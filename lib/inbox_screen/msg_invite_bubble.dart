import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/zego_page_constant.dart';
import '../constants/zim_error_code.dart';
import '../core/utils/color_constant.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import '../core/utils/math_utils.dart';
import '../localization/localisation.dart';
import '../model/user_model.dart';
import '../model/zego_room_user_role.dart';
import '../model/zego_user_info.dart';
import '../service/zego_room_manager.dart';
import '../service/zego_room_service.dart';
import '../service/zego_user_service.dart';
import '../util/secret_reader.dart';

class MessageInviteBubble extends StatefulWidget {
  final Map<String, dynamic> text;
  final bool isMe;
  final String type;
  final UserBasicModel curUser;
  const MessageInviteBubble({
    Key? key,
    required this.text,
    required this.isMe,
    required this.type,
    required this.curUser,
  }) : super(key: key);

  @override
  State<MessageInviteBubble> createState() => _MessageInviteBubbleState();
}

class _MessageInviteBubbleState extends State<MessageInviteBubble> {
  @override
  void initState() {
    SecretReader.instance.loadKeyCenterData().then((_) {
      // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
      ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
          SecretReader.instance.serverSecret, (_) => null);
    });
    super.initState();
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
      alignment: (!widget.isMe ? Alignment.topLeft : Alignment.topRight),
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.12,
        margin: const EdgeInsets.only(top: 80, bottom: 8, left: 10, right: 10),
        constraints: BoxConstraints(maxWidth: size.width * 0.8),
        decoration: BoxDecoration(
          // color: ColorConstant.whiteA700B2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              getHorizontalSize(0.00),
            ),
            topRight: Radius.circular(
              getHorizontalSize(10.00),
            ),
            bottomLeft: Radius.circular(
              getHorizontalSize(10.00),
            ),
            bottomRight: Radius.circular(
              getHorizontalSize(10.00),
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.cyan[300]!.withOpacity(0.5),
              ColorConstant.whiteA70019.withOpacity(0.7),
            ],
          ),
          border: Border.all(
            color: ColorConstant.whiteA70019,
            width: getHorizontalSize(1.00),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black90026,
              spreadRadius: getHorizontalSize(2.00),
              blurRadius: getHorizontalSize(2.00),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  width: 50,
                  height: 50,
                  child: Image.network(
                    widget.text['imagePick'],
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.text['roomName'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join the channel to chit chat!',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              height: 24,
              child: ElevatedButton(
                onPressed: () async {
                  ZegoUserInfo info = ZegoUserInfo.empty();
                  info.userID = widget.curUser.userId;
                  info.userName = widget.curUser.name;
                  if (info.userName.isEmpty) {
                    info.userName = info.userID;
                  }
                  var userModel = context.read<ZegoUserService>();
                  final errorCode = await userModel.login(info, "");
                  // .then((errorCode)
                  if (errorCode != 0) {
                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!
                            .toastLoginFail(errorCode),
                        backgroundColor: Colors.grey);
                    return;
                  } else {
                    tryJoinRoom(
                        context,
                        widget.text['roomId'],
                        widget.text['roomName'],
                        widget.text['hostId'],
                        widget.text['imagePick'],
                        widget.text['hostName']);
                  }
                  // "roomId": widget.roomID,
                  //     "roomName": widget.roomName,
                  //     "hostName": widget.hostName,
                  //     "hostId": widget.hostId,
                  //     "imagePick": widget.imagePick,
                  // });
                  // if ((widget.text['roomId'] as String).isEmpty) {
                  //   Fluttertoast.showToast(
                  //       msg:
                  //           AppLocalizations.of(context)!.toastRoomIdEnterError,
                  //       backgroundColor: Colors.grey);
                  //   return;
                  // }

                  // var room = context.read<ZegoRoomService>();
                  // final code =
                  //     await room.joinRoom((widget.text['roomId'] as String));
                  // // .then((code) {
                  // if (code != 0) {
                  //   String message =
                  //       AppLocalizations.of(context)!.toastJoinRoomFail(code);
                  //   if (code ==
                  //       ZIMErrorCodeExtension
                  //           .valueMap[zimErrorCode.roomNotExist]) {
                  //     message =
                  //         AppLocalizations.of(context)!.toastRoomNotExistFail;
                  //   }
                  //   Fluttertoast.showToast(
                  //       msg: message, backgroundColor: Colors.grey);
                  // } else {
                  //   var users = context.read<ZegoUserService>();
                  //   if (room.roomInfo.hostID == users.localUserInfo.userID) {
                  //     users.localUserInfo.userRole =
                  //         ZegoRoomUserRole.roomUserRoleHost;
                  //   }
                  //   List usersRoomList = [];
                  //   usersRoomList.add(users.localUserInfo.userID);
                  //   await FirebaseFirestore.instance
                  //       .collection('allRoomsData')
                  //       .doc(room.roomInfo.hostID)
                  //       .update({
                  //     "roomDataList": FieldValue.arrayUnion(usersRoomList),
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
                  //     "hostName": widget.text['hostName'],
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
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class MessageBubble extends StatelessWidget {
//   final String text;
//   final bool isMe;
//   const MessageBubble({
//     Key? key,
//     required this.text,
//     required this.isMe,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: isMe ? Colors.indigo : Colors.pink,
//             borderRadius: BorderRadius.only(
//               topLeft: const Radius.circular(10),
//               topRight: const Radius.circular(10),
//               bottomLeft:
//                   !isMe ? const Radius.circular(0) : const Radius.circular(10),
//               bottomRight:
//                   isMe ? const Radius.circular(0) : const Radius.circular(10),
//             ),
//           ),
//           width: 220,
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           child: Text(
//             text,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }
