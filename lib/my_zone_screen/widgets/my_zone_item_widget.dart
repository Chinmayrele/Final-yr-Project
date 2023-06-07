import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import '../../constants/zego_page_constant.dart';
import '../../constants/zim_error_code.dart';
import '../../core/utils/color_constant.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../localization/localisation.dart';
import '../../model/user_model.dart';
import '../../model/zego_room_user_role.dart';
import '../../model/zego_user_info.dart';
import '../../service/zego_room_manager.dart';
import '../../service/zego_room_service.dart';
import '../../service/zego_user_service.dart';
import '../../util/secret_reader.dart';

// ignore: must_be_immutable
class MyZoneItemWidget extends StatefulWidget {
  const MyZoneItemWidget({
    Key? key,
    required this.followingList,
    required this.index,
    required this.userRoomData,
    required this.onlineStatus,
    required this.curData,
  }) : super(key: key);
  final int index;
  final UserBasicModel followingList;
  final String onlineStatus;
  final Map<String, dynamic> userRoomData;
  final UserBasicModel curData;

  @override
  State<MyZoneItemWidget> createState() => _MyZoneItemWidgetState();
}

class _MyZoneItemWidgetState extends State<MyZoneItemWidget> {
  // String hostName = '';
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
      debugPrint("HOSTID IN TRENDING SCREEN ITEM: ${room.roomInfo.hostID}");
      debugPrint(
          "LocalUSER ID IN TRENDING SCREEN ITEM: ${users.localUserInfo.userID}");
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
      if(useId != FirebaseAuth.instance.currentUser!.uid) {
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
  void initState() {
    SecretReader.instance.loadKeyCenterData().then((_) {
      // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
      ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
          SecretReader.instance.serverSecret, (_) => null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.userRoomData['roomId'] as String).isEmpty
          ? () {}
          : () async {
              var userModel = context.read<ZegoUserService>();
              if (userModel.loginState == LoginState.loginStateLoggedIn) {
                debugPrint("01");
                await userModel.logout();
              }
              ZegoUserInfo info = ZegoUserInfo.empty();
              info.userID = widget.curData.userId;
              info.userName = widget.curData.name;
              if (info.userName.isEmpty) {
                info.userName = info.userID;
              }
              final errorCode = await userModel.login(info, "");
              // .then((errorCode) {
              if (errorCode != 0) {
                Fluttertoast.showToast(
                    msg:
                        AppLocalizations.of(context)!.toastLoginFail(errorCode),
                    backgroundColor: Colors.grey);
                return;
              } else {
                debugPrint("IMAGE ROOM: ${widget.userRoomData['imageRoom']}");
                tryJoinRoom(
                    context,
                    widget.userRoomData['roomId'],
                    widget.userRoomData['roomName'],
                    widget.userRoomData['userId'],
                    widget.userRoomData['imageRoom'],
                    widget.userRoomData['hostName']);
              }
              // });
              // if ((widget.userRoomData['roomName'] as String).isEmpty) {
              //   Fluttertoast.showToast(
              //       msg: AppLocalizations.of(context)!.toastRoomIdEnterError,
              //       backgroundColor: Colors.grey);
              //   return;
              // }
              // var room = context.read<ZegoRoomService>();
              // final code = await room
              //     .joinRoom((widget.userRoomData['roomId'] as String));
              // // .then((code) {
              // if (code != 0) {
              //   String message =
              //       AppLocalizations.of(context)!.toastJoinRoomFail(code);
              //   if (code ==
              //       ZIMErrorCodeExtension.valueMap[zimErrorCode.roomNotExist]) {
              //     message = AppLocalizations.of(context)!.toastRoomNotExistFail;
              //   }
              //   Fluttertoast.showToast(
              //       msg: message, backgroundColor: Colors.grey);
              // } else {
              //   var users = context.read<ZegoUserService>();
              //   if (room.roomInfo.hostID == users.localUserInfo.userID) {
              //     users.localUserInfo.userRole =
              //         ZegoRoomUserRole.roomUserRoleHost;
              //     hostName = users.localUserInfo.userName;
              //   }
              //   List usersRoomList = [];
              //   usersRoomList.add(users.localUserInfo.userID);
              //   await FirebaseFirestore.instance
              //       .collection('hostRoomData')
              //       .doc(room.roomInfo.hostID)
              //       .update({
              //     "users": FieldValue.arrayUnion(usersRoomList),
              //   });
              //   await FirebaseFirestore.instance
              //       .collection('userJoinRoom')
              //       .doc(FirebaseAuth.instance.currentUser!.uid)
              //       .update({
              //     "roomName": room.roomInfo.roomName,
              //     "roomId": room.roomInfo.roomID,
              //     "userId": FirebaseAuth.instance.currentUser!.uid,
              //     "type": "user",
              //     "members": 0,
              //   });
              //   final date = DateTime.now();
              //   final dateTime = date.toString().split(' ')[0];
              //   final mp = {
              //     "roomName": room.roomInfo.roomName,
              //     "roomId": room.roomInfo.roomID,
              //     "hostName": hostName,
              //     "createdAt": dateTime,
              //     "userId": FirebaseAuth.instance.currentUser!.uid,
              //   };
              //   final listData = [];
              //   listData.add(mp);
              //   final docIdExists = await FirebaseFirestore.instance
              //       .collection('recentVisited')
              //       .doc(FirebaseAuth.instance.currentUser!.uid)
              //       .collection('visited')
              //       .doc(dateTime)
              //       .get();
              //   if (!docIdExists.exists) {
              //     await FirebaseFirestore.instance
              //         .collection('recentVisited')
              //         .doc(FirebaseAuth.instance.currentUser!.uid)
              //         .collection('visited')
              //         .doc(dateTime)
              //         .set({
              //       "recentList": FieldValue.arrayUnion(listData),
              //     });
              //   } else {
              //     await FirebaseFirestore.instance
              //         .collection('recentVisited')
              //         .doc(FirebaseAuth.instance.currentUser!.uid)
              //         .collection('visited')
              //         .doc(dateTime)
              //         .update({
              //       "recentList": FieldValue.arrayUnion(listData),
              //     });
              //   }
              //   Navigator.pushReplacementNamed(
              //       context, PageRouteNames.roomMain);
              // }
              // });
              // }
            },
      child: GlassmorphicContainer(
        margin: EdgeInsets.only(
          top: getVerticalSize(
            widget.index == 0 ? getVerticalSize(10) : 2,
          ),
        ),
        borderRadius: 20,
        width: size.width,
        blur: 15,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.2),
              const Color(0xFFFFFFFF).withOpacity(0.2),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white10.withOpacity(0.2),
            Colors.white10.withOpacity(0.2)
          ],
        ),
        height: getVerticalSize(85),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: getSize(58.00),
              width: getSize(58.0),
              margin: EdgeInsets.only(
                left: getHorizontalSize(11.00),
                top: getVerticalSize(5.00),
                bottom: getVerticalSize(5.00),
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getSize(29.41),
                        ),
                        child: Image.network(
                          widget.followingList.imageUrl,
                          height: getSize(56.00),
                          width: getSize(56.00),
                          fit: BoxFit.fill,
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: getHorizontalSize(10.00),
                        top: getVerticalSize(10.00),
                        right: getHorizontalSize(1.76),
                        bottom: getVerticalSize(1.89),
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.online,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(10),
                        ),
                        border: Border.all(
                          color: ColorConstant.gray200,
                          width: getHorizontalSize(1.00),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(3.87),
                              top: getVerticalSize(6.00),
                              bottom: getVerticalSize(3.92),
                            ),
                            child: SizedBox(
                              height: getVerticalSize(5.00),
                              width: getHorizontalSize(1.00),
                              child: SvgPicture.asset(
                                (widget.userRoomData['roomId'] as String)
                                        .isEmpty
                                    ? ImageConstant.imgVector8
                                    : ImageConstant.imgVector55,
                                fit: BoxFit.fill,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(2.00),
                              top: getVerticalSize(8.00),
                              bottom: getVerticalSize(3.92),
                            ),
                            child: SizedBox(
                              height: getVerticalSize(3.00),
                              width: getHorizontalSize(1.00),
                              child: SvgPicture.asset(
                                (widget.userRoomData['roomId'] as String)
                                        .isEmpty
                                    ? ImageConstant.imgVector8
                                    : ImageConstant.imgVector66,
                                fit: BoxFit.fill,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(2.00),
                              top: getVerticalSize(
                                6.00,
                              ),
                              right: getHorizontalSize(4.05),
                              bottom: getVerticalSize(3.92),
                            ),
                            child: SizedBox(
                              height: getVerticalSize(5.00),
                              width: getHorizontalSize(1.00),
                              child: SvgPicture.asset(
                                (widget.userRoomData['roomId'] as String)
                                        .isEmpty
                                    ? ImageConstant.imgVector8
                                    : ImageConstant.imgVector55,
                                color: Colors.white,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(12.29),
                top: getVerticalSize(19.00),
                right: getHorizontalSize(11.36),
                bottom: getVerticalSize(18.16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: getHorizontalSize(
                        241.54,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: getVerticalSize(
                                4.00,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  widget.followingList.name,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      17,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //     left: getHorizontalSize(12.00),
                                //     top: getVerticalSize(3.50),
                                //     bottom: getVerticalSize(3.50),
                                //   ),
                                //   child: SizedBox(
                                //     height: getVerticalSize(14.00),
                                //     width: getHorizontalSize(14.01),
                                //     child: SvgPicture.asset(
                                //       ImageConstant.img04f2f1fed89b09d,
                                //       fit: BoxFit.fill,
                                //       color: Colors.black87.withOpacity(0.7),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: getVerticalSize(12.00),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: getVerticalSize(0),
                                  ),
                                  child: SizedBox(
                                    height: getSize(10.0),
                                    width: getSize(10.00),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgVector,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      2.00,
                                    ),
                                  ),
                                  child: Text(
                                    widget.userRoomData['members'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.gray600,
                                      fontSize: getFontSize(
                                        13,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getVerticalSize(
                        0.00,
                      ),
                    ),
                    child: Text(
                      (widget.userRoomData['roomId'] as String).isEmpty
                          ? ''
                          : (widget.userRoomData['roomName']),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.gray600,
                        fontSize: getFontSize(
                          13.5,
                        ),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
