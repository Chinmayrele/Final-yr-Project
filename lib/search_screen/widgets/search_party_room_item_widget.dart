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
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../localization/localisation.dart';
import '../../model/zego_room_user_role.dart';
import '../../service/zego_room_service.dart';
import '../../service/zego_user_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

// ignore: must_be_immutable
class SearchPartyRoomItemWidget extends StatefulWidget {
  const SearchPartyRoomItemWidget({
    Key? key,
    required this.index,
    required this.userDataDocs,
    required this.refreshFn,
  }) : super(key: key);
  final int index;
  final QueryDocumentSnapshot<Object?> userDataDocs;
  final void Function() refreshFn;

  @override
  State<SearchPartyRoomItemWidget> createState() =>
      _SearchPartyRoomItemWidgetState();
}

class _SearchPartyRoomItemWidgetState extends State<SearchPartyRoomItemWidget> {
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
        "type":
            useId == FirebaseAuth.instance.currentUser!.uid ? "host" : "user",
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
        // });
      }
      Navigator.pushReplacementNamed(context, PageRouteNames.roomMain,
          arguments: {
            "roomName": romName,
            "roomId": roomID,
            "hostName": hostName,
            "hostId": useId,
            "imagePickRoom": imgRoom,
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tryJoinRoom(
            context,
            widget.userDataDocs['roomId'],
            widget.userDataDocs['roomName'],
            widget.userDataDocs['userId'],
            widget.userDataDocs['imageRoom'],
            widget.userDataDocs['hostName']);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRoomsScreen()));
      },
      child: GlassmorphicContainer(
        margin: EdgeInsets.only(
          top: getVerticalSize(
            widget.index == 0 ? 10 : 3,
          ),
          bottom: getVerticalSize(
            4.50,
          ),
        ),
        borderRadius: 20,
        width: size.width,
        blur: 15,
        alignment: Alignment.bottomCenter,
        border: 1,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.3),
              const Color(0xFFFFFFFF).withOpacity(0.3),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white10.withOpacity(0.3),
            Colors.white10.withOpacity(0.3),
          ],
        ),
        height: getVerticalSize(80),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  10.00,
                ),
                top: getVerticalSize(
                  10.00,
                ),
                // bottom: getVerticalSize(
                //   10.00,
                // ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getSize(
                        29.00,
                      ),
                    ),
                    child: Image.network(
                      widget.userDataDocs['imageRoom'],
                      height: getSize(
                        58.00,
                      ),
                      width: getSize(
                        58.00,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        15.00,
                      ),
                      // top: getVerticalSize(
                      //   8.00,
                      // ),
                      bottom: getVerticalSize(
                        9.50,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.userDataDocs['roomName'],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(
                              18,
                            ),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: getVerticalSize(
                              5.50,
                            ),
                            right: getHorizontalSize(
                              10.00,
                            ),
                          ),
                          child: Text(
                            widget.userDataDocs['roomId'],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: ColorConstant.gray600,
                              fontSize: getFontSize(
                                14,
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
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                // left: getHorizontalSize(
                //   94.00,
                // ),
                top: getVerticalSize(
                  32.00,
                ),
                right: getHorizontalSize(
                  35.00,
                ),
                bottom: getVerticalSize(
                  32.00,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: getVerticalSize(
                        2.50,
                      ),
                      bottom: getVerticalSize(
                        2.50,
                      ),
                    ),
                    child: Container(
                      height: getSize(
                        10.00,
                      ),
                      width: getSize(
                        10.00,
                      ),
                      child: SvgPicture.asset(
                        ImageConstant.imgVector1,
                        fit: BoxFit.fill,
                        color: Colors.grey,
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
                      (widget.userDataDocs['users'] as List).length.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.gray600,
                        fontSize: getFontSize(
                          12,
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
