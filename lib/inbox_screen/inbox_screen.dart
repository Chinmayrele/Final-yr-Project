import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/zego_page_constant.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import '../constants/zim_error_code.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../localization/localisation.dart';
import '../model/user_model.dart';
import '../model/zego_room_user_role.dart';
import '../model/zego_user_info.dart';
import '../providers/info_providers.dart';
import '../service/zego_room_manager.dart';
import '../service/zego_room_service.dart';
import '../service/zego_user_service.dart';
import '../util/secret_reader.dart';
import 'chat_appbar.dart';
import 'message_buuble.dart';
import 'msgAudioBubble.dart';
import 'msg_invite_bubble.dart';
import 'new_message_textfield.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({
    Key? key,
    required this.frndDataModel,
  }) : super(key: key);
  final UserBasicModel frndDataModel;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  UserBasicModel? curUserData;
  bool isLoading = true;
  Map<String, dynamic> roomMap = {};
  // String hostName = '';
  @override
  void initState() {
    SecretReader.instance.loadKeyCenterData().then((_) {
      // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
      ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
          SecretReader.instance.serverSecret, (_) => null);
    });
    final result = Provider.of<InfoProviders>(context, listen: false);
    curUserData = result.curUserData;
    // result.callCurrentUserData().then((value) {
    //   curUserData = value;
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    getUserRoomData();
    super.initState();
  }

  Future<void> getUserRoomData() async {
    FirebaseFirestore.instance
        .collection('userJoinRoom')
        .doc(widget.frndDataModel.userId)
        .get()
        .then((value) {
      roomMap = value.data() as Map<String, dynamic>;
      setState(() {
        isLoading = false;
      });
    });
  }

  void tryJoinRoom(BuildContext context, String roomID, String romName,
      String useId, String imgRoom, String hostName) async {
    if (roomID.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toastRoomIdEnterError,
          backgroundColor: Colors.grey);
      return;
    }

    var room = context.read<ZegoRoomService>();
    final code = await room.joinRoom(roomID);
    // .then((code) {
    if (code != 0) {
      String message = AppLocalizations.of(context)!.toastJoinRoomFail(code);
      if (code == ZIMErrorCodeExtension.valueMap[zimErrorCode.roomNotExist]) {
        message = AppLocalizations.of(context)!.toastRoomNotExistFail;
      }
      Fluttertoast.showToast(msg: message, backgroundColor: Colors.grey);
    } else {
      var users = context.read<ZegoUserService>();
      if (room.roomInfo.hostID == users.localUserInfo.userID) {
        users.localUserInfo.userRole = ZegoRoomUserRole.roomUserRoleHost;
        // hostName = users.localUserInfo.userName;
      }
      List usersRoomList = [];
      usersRoomList.add(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection('hostRoomData')
          .doc(useId)
          .update({
        "users": FieldValue.arrayUnion(usersRoomList),
        "todayUsers": FieldValue.arrayUnion(usersRoomList),
      });
      await FirebaseFirestore.instance
          .collection('userJoinRoom')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "roomName": room.roomInfo.roomName,
        "roomId": room.roomInfo.roomID,
        "type": "user",
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "members": 0,
        "imageRoom": imgRoom,
        "hostName": hostName,
      });
      if (useId != FirebaseAuth.instance.currentUser!.uid) {
        final date = DateTime.now();
        final dateTime = date.toString().split(' ')[0];
        final mp = {
          "roomName": room.roomInfo.roomName,
          "roomId": room.roomInfo.roomID,
          "hostName": hostName,
          "createdAt": dateTime,
          "imageRoom": imgRoom,
          "userId": FirebaseAuth.instance.currentUser!.uid,
        };
        final listData = [];
        listData.add(mp);
        debugPrint("REACHED HERE");
        final docIdExists = await FirebaseFirestore.instance
            .collection('recentVisited')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('visited')
            .doc(dateTime)
            .get();
        if (!docIdExists.exists) {
          debugPrint("ALSO HERE");
          await FirebaseFirestore.instance
              .collection('recentVisited')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('visited')
              .doc(dateTime)
              .set({
            "recentList": FieldValue.arrayUnion(listData),
          });
        } else {
          debugPrint("NOW HERE");
          await FirebaseFirestore.instance
              .collection('recentVisited')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('visited')
              .doc(dateTime)
              .update({
            "recentList": FieldValue.arrayUnion(listData),
          });
        }
      }
      Navigator.pushReplacementNamed(context, PageRouteNames.roomMain,
          arguments: {
            "roomName": romName,
            "roomId": roomID,
            "hostName": hostName,
            "hostId": useId,
            "imagePickRoom": imgRoom,
          });
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logUserId = FirebaseAuth.instance.currentUser!.uid;
    final strCompare = logUserId.compareTo(widget.frndDataModel.userId);
    final docId = strCompare == -1
        ? logUserId + widget.frndDataModel.userId
        : widget.frndDataModel.userId + logUserId;
    var hSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.whiteA700,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              :
              // FutureBuilder(
              //     future: getUserRoomData(),
              //     builder: (ctx, futureSnaps) {
              //       // if (futureSnaps.connectionState == ConnectionState.waiting) {
              //       //   return const Center(
              //       //     child: CircularProgressIndicator(
              //       //       color: Colors.pink,
              //       //     ),
              //       //   );
              //       // } else {
              Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        ImageConstant.imgUnsplash8uzpyn,
                        height: getVerticalSize(810.00),
                        width: getHorizontalSize(360.00),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        ChatAppbar(chatterData: widget.frndDataModel),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('chatRoom')
                                  .doc(docId) // docId
                                  .collection('messages')
                                  .orderBy('createdAt', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Stack(
                                    children: [
                                      ListView.builder(
                                        reverse: true,
                                        // itemCount: messages.length,
                                        itemCount: snapshot.data!.docs.length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        itemBuilder: (context, index) {
                                          debugPrint(
                                              "SNAPSHOTS: ${snapshot.data}");
                                          return snapshot.data!.docs[index]
                                                      ['type'] ==
                                                  "invite"
                                              ? MessageInviteBubble(
                                                  text: snapshot.data!
                                                      .docs[index]['text'],
                                                  isMe:
                                                      snapshot.data!.docs[index]
                                                              ['senderId'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                  type: "invite",
                                                  curUser: curUserData!,
                                                )
                                              : snapshot.data!.docs[index]
                                                          ['type'] ==
                                                      "audio"
                                                  ? MsgAudioBubble(
                                                      text: snapshot.data!
                                                          .docs[index]['text'],
                                                      type: snapshot.data!
                                                          .docs[index]['type'],
                                                      isMe: snapshot.data!
                                                                  .docs[index][
                                                              'senderUserId'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                    )
                                                  : MessageBubble(
                                                      text: snapshot.data!
                                                          .docs[index]['text'],
                                                      type: snapshot.data!
                                                          .docs[index]['type'],
                                                      isMe: snapshot.data!
                                                                  .docs[index]
                                                              ['senderId'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                    );
                                        },
                                        // ),
                                      ),
                                      (roomMap['roomId'] as String).isEmpty
                                          ? const SizedBox()
                                          : InkWell(
                                              onTap: () async {
                                                ZegoUserInfo info =
                                                    ZegoUserInfo.empty();
                                                info.userID =
                                                    curUserData!.userId;
                                                info.userName =
                                                    curUserData!.name;
                                                if (info.userName.isEmpty) {
                                                  info.userName = info.userID;
                                                }
                                                var userModel = context
                                                    .read<ZegoUserService>();
                                                final errorCode =
                                                    await userModel.login(
                                                        info, "");
                                                // .then((errorCode) {
                                                debugPrint(
                                                    "ERROR CODE: $errorCode");
                                                if (errorCode != 0) {
                                                  Fluttertoast.showToast(
                                                      msg: AppLocalizations.of(
                                                              context)!
                                                          .toastLoginFail(
                                                              errorCode),
                                                      backgroundColor:
                                                          Colors.grey);
                                                  return;
                                                } else {
                                                  tryJoinRoom(
                                                      context,
                                                      roomMap['roomId'],
                                                      roomMap['roomName'],
                                                      roomMap['userId'],
                                                      roomMap['imageRoom'],
                                                      roomMap['hostName']);
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Image.asset(
                                                    ImageConstant.imgGroup1255,
                                                    height:
                                                        getVerticalSize(34.00),
                                                    width: getHorizontalSize(
                                                        73.00),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.pink,
                                    ),
                                  );
                                }
                              }),
                        ),
                        // MessageTextTrial(chatterUser: widget.frndDataModel),
                        MessageTextField(chatterUser: widget.frndDataModel),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                        ),
                      ],
                    ),
                  ],
                )
          // }

          ),
    );
  }
}
