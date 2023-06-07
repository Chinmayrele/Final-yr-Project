import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../constants/zego_page_constant.dart';
import '../../constants/zim_error_code.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../localization/localisation.dart';
import '../../model/zego_room_user_role.dart';
import '../../model/zego_user_info.dart';
import '../../service/zego_room_service.dart';
import '../../service/zego_user_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

class MyRoomsScreenWidget extends StatefulWidget {
  const MyRoomsScreenWidget({
    Key? key,
    required this.delete,
    required this.roomMapData,
  }) : super(key: key);
  final bool delete;
  final Map<String, dynamic> roomMapData;

  @override
  State<MyRoomsScreenWidget> createState() => _MyRoomsScreenWidgetState();
}

class _MyRoomsScreenWidgetState extends State<MyRoomsScreenWidget> {
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
        // "todayUsers": FieldValue.arrayUnion(usersRoomList),
      });
      await FirebaseFirestore.instance
          .collection('userJoinRoom')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "roomName": room.roomInfo.roomName,
        "roomId": room.roomInfo.roomID,
        "type": "host",
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "members": 0,
        "imageRoom": imgRoom,
        "hostName": hostName,
      });
      // final date = DateTime.now();
      // final dateTime = date.toString().split(' ')[0];
      // final mp = {
      //   "roomName": room.roomInfo.roomName,
      //   "roomId": room.roomInfo.roomID,
      //   "hostName": hostName,
      //   "createdAt": dateTime,
      //   "userId": FirebaseAuth.instance.currentUser!.uid,
      // };
      // final listData = [];
      // listData.add(mp);
      // debugPrint("REACHED HERE");
      // final docIdExists = await FirebaseFirestore.instance
      //     .collection('recentVisited')
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .collection('visited')
      //     .doc(dateTime)
      //     .get();
      // if (!docIdExists.exists) {
      //   debugPrint("ALSO HERE");
      //   await FirebaseFirestore.instance
      //       .collection('recentVisited')
      //       .doc(FirebaseAuth.instance.currentUser!.uid)
      //       .collection('visited')
      //       .doc(dateTime)
      //       .set({
      //     "recentList": FieldValue.arrayUnion(listData),
      //   });
      // } else {
      //   debugPrint("NOW HERE");
      //   await FirebaseFirestore.instance
      //       .collection('recentVisited')
      //       .doc(FirebaseAuth.instance.currentUser!.uid)
      //       .collection('visited')
      //       .doc(dateTime)
      //       .update({
      //     "recentList": FieldValue.arrayUnion(listData),
      //   });
      // }
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
    return InkWell(
      onTap: () async {
        var userService = context.read<ZegoUserService>();
        final errorC = await userService.logout();
        // .then((errorCode) {
        if (errorC != 0) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.toastRoomEndFailTip(errorC),
              backgroundColor: Colors.grey);
        } else {
          ZegoUserInfo info = ZegoUserInfo.empty();
          info.userID = widget.roomMapData['userId'];
          info.userName = widget.roomMapData['hostName'];
          if (info.userName.isEmpty) {
            info.userName = info.userID;
          }
          var userModel = context.read<ZegoUserService>();
          debugPrint("USER ID: ${info.userID}");
          final errorCode = await userModel.login(info, "");
          // .then((errorCode) {
          if ((errorCode) != 0) {
            debugPrint("!!!!!");
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.toastLoginFail(errorCode),
                backgroundColor: Colors.grey);
          } else {
            tryJoinRoom(
                context,
                widget.roomMapData['roomId'],
                widget.roomMapData['roomName'],
                widget.roomMapData['userId'],
                widget.roomMapData['imageRoom'],
                widget.roomMapData['hostName']);
          }
        }
      },
      child: Container(
        height: getVerticalSize(63.00),
        margin: EdgeInsets.only(
          left: getHorizontalSize(16.00),
          top: getVerticalSize(15.00),
          right: getHorizontalSize(16.00),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: getVerticalSize(10.00),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getSize(25.00),
                        ),
                        child: Image.network(
                          widget.roomMapData['imageRoom'],
                          height: getSize(50.00),
                          width: getSize(50.00),
                          fit: BoxFit.fill,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(13.00),
                        top: getVerticalSize(6.00),
                        right: getHorizontalSize(130.00),
                        bottom: getVerticalSize(23.00),
                      ),
                      child: Text(
                        widget.roomMapData['roomName'],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.gray800,
                          fontSize: getFontSize(18),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    widget.delete
                        ? Container(
                            margin: EdgeInsets.only(
                                top: getVerticalSize(20),
                                left: getHorizontalSize(4)),
                            width: getHorizontalSize(20),
                            height: getVerticalSize(20),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(35)),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: getHorizontalSize(17),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(10.00),
                top: getVerticalSize(10.00),
              ),
              child: Container(
                height: getVerticalSize(33.00),
                width: getHorizontalSize(265.00),
                child: Text(
                  "ID : ${widget.roomMapData['roomId']}",
                  style:
                      TextStyle(color: ColorConstant.bluegray400, fontSize: 13),
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     hintText: 'ID : xy4615634',
                //     hintStyle: TextStyle(
                //       fontSize: getFontSize(13.0),
                //       color: ColorConstant.bluegray400,
                //     ),
                //     enabledBorder: const UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.black12,
                //         width: 0.5,
                //       ),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: ColorConstant.bluegray400,
                //         width: 1,
                //       ),
                //     ),
                //     isDense: true,
                //     contentPadding: EdgeInsets.only(
                //       top: getVerticalSize(1.03),
                //       bottom: getVerticalSize(20.03),
                //     ),
                //   ),
                //   style: TextStyle(
                //     color: ColorConstant.bluegray400,
                //     fontSize: getFontSize(12.0),
                //     fontFamily: 'Roboto',
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
