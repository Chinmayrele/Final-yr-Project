import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../plugin/zim_plugin.dart';
import '../../constants/zim_error_code.dart';
import '../../constants/zego_custom_command_constant.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

typedef ZegoRoomCallback = Function(int);

/// Class gift management.
/// <p>Description: This class contains the logics of send and receive gifts.</>
class ZegoGiftService extends ChangeNotifier {
  /// gift's sender of current gift
  String giftSender = "";

  /// gift's id of current gift
  String giftID = "";

  /// gift's receivers of current gift
  List<String> giftReceivers = [];

  ///  gift tips visibility
  bool displayTips = false;

  ///  hide gift tips when timeout
  late Timer displayTimer;

  ZegoGiftService() {
    /// register listener on sdk
    ZIMPlugin.onReceiveCustomRoomMessage = _onReceiveCustomMessage;
  }

  /// call this when enter room
  onRoomEnter() {}

  /// call this when leave room
  onRoomLeave() {
    if (displayTips) {
      displayTimer.cancel();
    }
    displayTips = false;

    giftSender = "";
    giftID = "";
    giftReceivers.clear();
  }

  /// Send virtual gift.
  /// <p>Description: This method can be used to send a virtual gift, all room users will receive a notification. You
  /// can determine whether you are the gift recipient by the toUserList parameter.</>
  /// <p>Call this method at:  After joining the room</>
  ///
  /// @param roomID     refers to the room id.
  /// @param senderUserID     refers to the user id of sender.
  /// @param giftID     refers to the gift type.
  /// @param toUserList refers to the gift recipient.
  Future<int> sendGift(String roomID, String senderUserID, String giftID,
      List<String> toUserList, BuildContext context) async {
    Map message = {
      'actionType':
          ZegoCustomCommandTypeExtension.valueMap[zegoCustomCommandType.gift],
      'target': toUserList,
      'content': {'giftID': giftID}
    };
    String json = jsonEncode(message);
    var result = await ZIMPlugin.sendRoomMessage(roomID, json, true);

    // /////////////////////////////////////////////////////
    // var messageService = context.read<ZegoMessageService>();
    // final errorCode =
    //     await messageService.sendTextMessage(roomID, senderUserID, "");
    // // .then((errorCode) {
    // if (0 != errorCode) {
    //   Fluttertoast.showToast(
    //       msg: AppLocalizations.of(context)!.toastSendMessageError(errorCode),
    //       backgroundColor: Colors.grey);
    // } else {
    //   debugPrint("EKSE");
    // }
    // ////////////////////////////////////////////////////////
    int code = result['errorCode'];
    if (ZIMErrorCodeExtension.valueMap[zimErrorCode.success] == code) {
      this.giftID = giftID;
      giftReceivers = toUserList;
      giftSender = senderUserID;
    }

    _showGiftTips();

    notifyListeners();

    return code;
  }

  void _onReceiveCustomMessage(
      String roomID, List<Map<String, dynamic>> messageListJson) {
    for (final item in messageListJson) {
      var messageJson = item['message'];
      Map<String, dynamic> messageDic = jsonDecode(messageJson);
      int actionType = messageDic['actionType'];
      if (zegoCustomCommandType.gift ==
          ZegoCustomCommandTypeExtension.mapValue[actionType]) {
        giftID = messageDic['content']['giftID'];
        giftSender = item['userID'];
        giftReceivers = messageDic['target'].cast<String>();
      }
    }

    _showGiftTips();

    notifyListeners();
  }

  void _showGiftTips() {
    if (displayTips) {
      displayTimer.cancel();
    }
    displayTips = true;
    displayTimer = Timer(const Duration(seconds: 5), () {
      displayTips = false; //  hide after 10 seconds
      notifyListeners();
    });
  }
}
