import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../localization/localisation.dart';
import '../../model/user_model.dart';
import '../../service/zego_room_manager.dart';
import '../../service/zego_user_service.dart';

import '../../constants/zego_page_constant.dart';
import '../../common/room_info_content.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import '../../util/secret_reader.dart';
import 'image_pick.dart';

class RoomEntrancePage extends HookWidget {
  const RoomEntrancePage({Key? key, required this.currUserData})
      : super(key: key);
  final UserBasicModel currUserData;

  // void tryJoinRoom(BuildContext context, String roomID) async {
  //   ZegoUserInfo info = ZegoUserInfo.empty();
  //   info.userID = currUserData.userId.substring(0, 9);
  //   info.userName = currUserData.name;
  //   // info.userID = userIdInputController.text;
  //   // info.userName = userNameInputController.text;
  //   if (info.userName.isEmpty) {
  //     info.userName = info.userID;
  //   }
  //   var userModel = context.read<ZegoUserService>();
  //   final errorCode = await userModel.login(info, "");
  //   // .then((errorCode) {
  //   debugPrint("ERROR CODE: $errorCode");
  //   if (errorCode != 0) {
  //     Fluttertoast.showToast(
  //         msg: AppLocalizations.of(context)!.toastLoginFail(errorCode),
  //         backgroundColor: Colors.grey);
  //     return;
  //   }
  //   // });
  //   if (roomID.isEmpty) {
  //     Fluttertoast.showToast(
  //         msg: AppLocalizations.of(context)!.toastRoomIdEnterError,
  //         backgroundColor: Colors.grey);
  //     return;
  //   }

  //   var room = context.read<ZegoRoomService>();
  //   final code = await room.joinRoom(roomID);
  //   // .then((code) {
  //   if (code != 0) {
  //     String message = AppLocalizations.of(context)!.toastJoinRoomFail(code);
  //     if (code == ZIMErrorCodeExtension.valueMap[zimErrorCode.roomNotExist]) {
  //       message = AppLocalizations.of(context)!.toastRoomNotExistFail;
  //     }
  //     Fluttertoast.showToast(msg: message, backgroundColor: Colors.grey);
  //   } else {
  //     var users = context.read<ZegoUserService>();
  //     if (room.roomInfo.hostID == users.localUserInfo.userID) {
  //       users.localUserInfo.userRole = ZegoRoomUserRole.roomUserRoleHost;
  //     }
  //     List usersRoomList = [];
  //     usersRoomList.add(users.localUserInfo.userID);
  //     await FirebaseFirestore.instance
  //         .collection('allRoomsData')
  //         .doc(room.roomInfo.hostID)
  //         .update({
  //       "roomDataList": FieldValue.arrayUnion(usersRoomList),
  //     });
  //     await FirebaseFirestore.instance
  //         .collection('userJoinRoom')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       "roomName": room.roomInfo.roomName,
  //       "roomId": room.roomInfo.roomID,
  //     });
  //     Navigator.pushReplacementNamed(context, PageRouteNames.roomMain);
  //   }
  //   // });
  // }

  // bool room = true;
  // final TextEditingController _controller = TextEditingController();
//   late AnimationController _animationController;
// @override
//   void initState() {
//     _animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     _animationController.repeat(reverse: true);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: _mainWidget(context),
    );
  }

  Widget _mainWidget(BuildContext context) {
    final roomIDInputController = useTextEditingController();
    // final dialogRoomNameInputController = useTextEditingController();

    //USER NAME ID AUTOMATIC LOGIC
    useEffect(() {
      SecretReader.instance.loadKeyCenterData().then((_) {
        // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
        ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
            SecretReader.instance.serverSecret, (_) => null);
      });
    }, const []);

    //TILL HERE
    var hSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: hSize.height,
          width: hSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(
                0.14444442420767467,
                0.1956249900768232,
              ),
              end: const Alignment(
                0.999999913809204,
                0.9999999743681396,
              ),
              colors: [
                ColorConstant.lime400,
                ColorConstant.green500,
              ],
            ),
          ),
          child: Column(
            // FractionllySizedBox(widthFactor: 0.85)
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getHorizontalSize(24.00),
                          right: getHorizontalSize(24.00),
                          top: 45),
                      child: SizedBox(
                          height: getSize(16.00),
                          width: getSize(16.00),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Icon(Icons.close,
                                  color: Colors.white))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(24.00),
                          top: 45,
                          right: getHorizontalSize(24.00),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, PageRouteNames.settings),
                          child: Text(AppLocalizations.of(context)!
                              .settingPageSettings),
                        )),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(30.00),
                    top: getVerticalSize(52.00),
                    right: getHorizontalSize(30.00),
                  ),
                  child: Text(
                    "CHAT",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.whiteA7007f,
                      fontSize: getFontSize(
                        80,
                      ),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              EntranceData(curData: currUserData),
              // PublicLock(refresh: _refreshWidgetBool),

              // OLD TEXTFIELD MADE BY YASHU BHAIYA  >>>>>
              // SizedBox(
              //   height: 50,
              //   child: CupertinoTextField(
              //     expands: true,
              //     maxLines: null,
              //     maxLength: 20,
              //     placeholder: AppLocalizations.of(context)!.createPageRoomId,
              //     controller: roomIDInputController,
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // CupertinoButton.filled(
              //     child: Text(AppLocalizations.of(context)!.createPageJoinRoom),
              //     onPressed: () {
              //       tryJoinRoom(context, roomIDInputController.text);
              //     }),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [Text(AppLocalizations.of(context)!.createPageOr)],
              //   ),
              // ),

              // BUTTON OLD BY YASHU BHAIYA
              // CupertinoButton(
              //     color: Colors.blueGrey[50],
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const Icon(
              //           Icons.add,
              //           color: Colors.black,
              //           size: 24.0,
              //         ),
              //         Text(
              //           AppLocalizations.of(context)!.createPageCreateRoom,
              //           style: const TextStyle(color: Colors.black),
              //         )
              //       ],
              //     ),
              //     onPressed: () {
              //       showCupertinoDialog<void>(
              //           context: context,
              //           builder: (BuildContext context) =>
              //               const CreateRoomDialog());
              //     }),

              // RoomEntbutton(
              //     dialogRoomNameInputController: dialogRoomNameInputController),
              // NEW TRYING TO PLACE TILL HERE
              Consumer<ZegoUserService>(builder: (_, userService, child) {
                if (userService.notifyInfo.isEmpty) {
                  return const Offstage(offstage: true, child: Text(''));
                }
                Future.delayed(Duration.zero, () async {
                  var infoContent = RoomInfoContent.fromJson(
                      jsonDecode(userService.notifyInfo));

                  switch (infoContent.toastType) {
                    case RoomInfoType.loginUserKickOut:
                      _showLoginUserKickOutTips(context, infoContent);
                      break;
                    default:
                      break;
                  }
                });

                return const Offstage(offstage: true, child: Text(''));
              }),
              // TILL HERE OLD VERSION MADE BY BHAIYA <<<<<<
            ],
          ),
        ),
      )),
    );
  }

  _showLoginUserKickOutTips(BuildContext context, RoomInfoContent infoContent) {
    if (infoContent.toastType != RoomInfoType.loginUserKickOut) {
      return;
    }

    Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.toastKickoutError,
        backgroundColor: Colors.grey);
    Navigator.pushReplacementNamed(context, PageRouteNames.login);
  }

  // bool isRoom = true;
  // _refreshWidgetBool(bool isRoomTrue) {
  //   isRoom = isRoomTrue;
  // }
}
