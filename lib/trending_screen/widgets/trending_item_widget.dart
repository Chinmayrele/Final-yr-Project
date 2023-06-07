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
import '../../model/user_model.dart';
import '../../model/zego_room_user_role.dart';
import '../../model/zego_user_info.dart';
import '../../providers/info_providers.dart';
import '../../service/zego_room_manager.dart';
import '../../service/zego_room_service.dart';
import '../../service/zego_user_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import '../../util/secret_reader.dart';

// ignore: must_be_immutable
class TrendingItemWidget extends StatefulWidget {
  const TrendingItemWidget({
    Key? key,
    required this.index,
    required this.trendingData,
    required this.curUserData,
  }) : super(key: key);
  final int index;
  final QueryDocumentSnapshot<Object?> trendingData;
  final UserBasicModel curUserData;

  @override
  State<TrendingItemWidget> createState() => _TrendingItemWidgetState();
}

class _TrendingItemWidgetState extends State<TrendingItemWidget> {
  String imageUrlHost = '';
  bool isLoading = true;

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    // SecretReader.instance.loadKeyCenterData().then((_) {
    //   // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
    //   ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
    //       SecretReader.instance.serverSecret, (_) => null);
    // });
    final result = Provider.of<InfoProviders>(context, listen: false);
    result
        .callCurrentUserProfileData(widget.trendingData['userId'])
        .then((value) {
      imageUrlHost = value.imageUrl;
      setState(() {
        isLoading = false;
      });
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

    debugPrint("6");
    var room = context.read<ZegoRoomService>();
    final code = await room.joinRoom(roomID);
    debugPrint("7");
    if (code != 0) {
      debugPrint("8");
      String message = AppLocalizations.of(context)!.toastJoinRoomFail(code);
      if (code == ZIMErrorCodeExtension.valueMap[zimErrorCode.roomNotExist]) {
        debugPrint("9");
        message = AppLocalizations.of(context)!.toastRoomNotExistFail;
      }
      Fluttertoast.showToast(msg: message, backgroundColor: Colors.grey);
    } else {
      debugPrint("10");
      var users = context.read<ZegoUserService>();
      if (room.roomInfo.hostID == users.localUserInfo.userID) {
        users.localUserInfo.userRole = ZegoRoomUserRole.roomUserRoleHost;
        // hostName = users.localUserInfo.userName;
      }
      debugPrint("9");
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
    // userModel = context.read<ZegoUserService>();
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          )
        : GestureDetector(
            onTap: () async {
              var userModel = context.read<ZegoUserService>();
              debugPrint("0");
              debugPrint("LOGIN STATE: ${userModel.loginState}");
              if (userModel.loginState == LoginState.loginStateLoggedIn ||
                  userModel.loginState == LoginState.loginStateLoggingIn) {
                debugPrint("01");
                await userModel.logout();
              }
              debugPrint("LOGIN STATE002: ${userModel.loginState}");
              debugPrint("1");
              ZegoUserInfo info = ZegoUserInfo.empty();
              info.userID = widget.curUserData.userId;
              info.userName = widget.curUserData.name;
              if (info.userName.isEmpty) {
                info.userName = info.userID;
              }
              debugPrint("@");
              final errorCode = await userModel.login(info, "");
              debugPrint("LOGIN STATE004: ${userModel.loginState}");
              debugPrint("3");
              if ((errorCode) != 0) {
                debugPrint("4");
                Fluttertoast.showToast(
                    msg:
                        AppLocalizations.of(context)!.toastLoginFail(errorCode),
                    backgroundColor: Colors.grey);
              } else {
                debugPrint("5");
                tryJoinRoom(
                  context,
                  widget.trendingData['roomId'].toString(),
                  widget.trendingData['roomName'].toString(),
                  widget.trendingData['userId'].toString(),
                  widget.trendingData['imageRoom'].toString(),
                  widget.trendingData['hostName'].toString(),
                );
                // Navigator.pushReplacementNamed(context, '/room_entrance');
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: getVerticalSize(180.00),
                width: getHorizontalSize(162.00),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(30)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.network(
                        imageUrlHost,
                        // ImageConstant.imgUnsplash3l3rwq1,
                        height: getVerticalSize(
                          180.00,
                        ),
                        width: getHorizontalSize(
                          160.00,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: getVerticalSize(157.63),
                        width: getHorizontalSize(140.68),
                        margin: EdgeInsets.only(
                          left: getHorizontalSize(10.66),
                          top: getVerticalSize(11.72),
                          right: getHorizontalSize(10.66),
                          bottom: getVerticalSize(10.65),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: GlassmorphicContainer(
                                margin: EdgeInsets.only(
                                  top: getVerticalSize(30.00),
                                ),
                                borderRadius: 20,
                                width: size.width,
                                blur: 5,
                                alignment: Alignment.bottomCenter,
                                border: 1,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.black.withOpacity(0.2),
                                      Colors.black.withOpacity(0.2),
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
                                    Colors.white10.withOpacity(0.2),
                                  ],
                                ),
                                height: getVerticalSize(130),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(11.72),
                                        top: getVerticalSize(27.51),
                                        right: getHorizontalSize(11.72),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.trendingData['roomName'],
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: ColorConstant.gray50,
                                            fontSize: getFontSize(
                                              18,
                                            ),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: getHorizontalSize(110.84),
                                        margin: EdgeInsets.only(
                                          left: getHorizontalSize(11.72),
                                          top: getVerticalSize(15.76),
                                          right: getHorizontalSize(11.72),
                                          bottom: getVerticalSize(8.32),
                                        ),
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //     left: getHorizontalSize(4.26),
                                                //   ),
                                                //   child: Container(
                                                //     height: getVerticalSize(10.65),
                                                //     width: getHorizontalSize(10.66),
                                                //     child: SvgPicture.asset(
                                                //       ImageConstant.imgVector1,
                                                //       fit: BoxFit.fill,
                                                //     ),
                                                //   ),
                                                // ),
                                                Container(
                                                  height:
                                                      getVerticalSize(10.65),
                                                  width:
                                                      getHorizontalSize(10.66),
                                                  child: SvgPicture.asset(
                                                    ImageConstant
                                                        .img04f2f1fed89b09d2,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    right:
                                                        getHorizontalSize(4.26),
                                                  ),
                                                  child: Container(
                                                    height:
                                                        getVerticalSize(10.65),
                                                    width: getHorizontalSize(
                                                        10.66),
                                                    child: SvgPicture.asset(
                                                      ImageConstant.imgVector4,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: getVerticalSize(2.13),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  // Text(
                                                  //   "1.6 k",
                                                  //   overflow: TextOverflow.ellipsis,
                                                  //   textAlign: TextAlign.left,
                                                  //   style: TextStyle(
                                                  //     color: ColorConstant.whiteA700,
                                                  //     fontSize: getFontSize(
                                                  //       9,
                                                  //     ),
                                                  //     fontFamily: 'Roboto',
                                                  //     fontWeight: FontWeight.w400,
                                                  //   ),
                                                  // ),
                                                  Text(
                                                    (widget.trendingData[
                                                            'users'] as List)
                                                        .length
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: ColorConstant
                                                          .whiteA700,
                                                      fontSize: getFontSize(
                                                        9,
                                                      ),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.trendingData[
                                                            'roomCharisma']
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: ColorConstant
                                                          .whiteA700,
                                                      fontSize: getFontSize(
                                                        9,
                                                      ),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(33.03),
                                  right: getHorizontalSize(33.03),
                                  bottom: getVerticalSize(10.00),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    widget.trendingData['imageRoom'],
                                    // ImageConstant.imgUnsplashjmati5,
                                    height: getVerticalSize(74.56),
                                    width: getHorizontalSize(74.61),
                                    fit: BoxFit.fill,
                                  ),
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
            ),
          );
  }
}
