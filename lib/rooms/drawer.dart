import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/rooms/widgets/providers.dart';
import 'package:final_yr_project/trending_screen/trending_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../constants/zego_page_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../localization/localisation.dart';
import '../model/zego_room_user_role.dart';
import '../my_rooms_screen/my_rooms_screen.dart';
import '../roompages/room/member/room_member_page.dart';
import '../service/zego_room_service.dart';
import '../service/zego_speaker_seat_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import '../service/zego_user_service.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({
    Key? key,
    required this.scaffKey,
    required this.refreshWid,
    required this.hostId,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffKey;
  final void Function(GlobalKey<ScaffoldState> scaff) refreshWid;
  final String hostId;

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  bool isTrue = false;
  bool isLock = false;
  bool isMsgLock = false;
  Map<String, dynamic>? roomData;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('hostRoomData')
        .doc(widget.hostId)
        .get()
        .then((value) {
      roomData = value.data();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<Provid>(context);
    return Drawer(
      // key: widget.scaffoldKey,
      backgroundColor: Colors.transparent,
      width: 70,
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          height: 460,
          child: GlassmorphicContainer(
            borderRadius: 0,
            height: getVerticalSize(500),
            margin: EdgeInsets.only(top: getVerticalSize(35)),
            width: getHorizontalSize(70),
            blur: 15,
            alignment: Alignment.bottomCenter,
            border: 1,
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
                Colors.white10.withOpacity(0.2),
              ],
            ),
            child: isTrue
                ? Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isTrue = false;
                                  });
                                  // widget.refreshWid(widget.scaffKey);
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 2.5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    result.changeImage(
                                        ImageConstant.imgRectangle141);
                                  });
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(11.89),
                                      top: getVerticalSize(25.00),
                                      right: getHorizontalSize(11.89),
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        ImageConstant.imgRectangle141,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  result.changeImage(
                                      ImageConstant.imgRectangle142);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(50.0),
                                    width: getSize(50.0),
                                    child: Image.asset(
                                      ImageConstant.imgRectangle142,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  result.changeImage(
                                      ImageConstant.imgRectangle143);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(50.0),
                                    width: getSize(50.0),
                                    child: Image.asset(
                                      ImageConstant.imgRectangle143,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  result.changeImage(
                                      ImageConstant.imgRectangle144);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(50.0),
                                    width: getSize(50.0),
                                    child: Image.asset(
                                      ImageConstant.imgRectangle144,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  result.changeImage(
                                      ImageConstant.imgRectangle145);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(50),
                                    width: getSize(50.0),
                                    child: Image.asset(
                                      ImageConstant.imgRectangle145,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  result.changeImage(
                                      ImageConstant.imgRectangle147);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(50),
                                    width: getSize(50.0),
                                    child: Image.asset(
                                      ImageConstant.imgRectangle147,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  result.changeImage(
                                      ImageConstant.img1dhckghtzdumti);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(50),
                                    width: getSize(50.0),
                                    child: Image.asset(
                                      ImageConstant.img1dhckghtzdumti,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTrue = true;
                                });
                                // widget.refreshWid(widget.scaffKey);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  ImageConstant.imgRectangle14,
                                  height: getSize(50.00),
                                  width: getSize(50.00),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // hasDialog.value = true;
                                // showModalBottomSheet(
                                //     context: context,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(12)),
                                //     isDismissible: true,
                                //     builder: (BuildContext context) {
                                //       return AnimatedPadding(
                                //           padding:
                                //               MediaQuery.of(context).viewInsets,
                                //           duration:
                                //               const Duration(milliseconds: 100),
                                //           child: SizedBox(
                                //               height: 800.h,
                                //               child: const RoomMemberPage()));
                                //     }).then((value) {
                                //   hasDialog.value = false;
                                // });
                                showDialog(
                                    context: context,
                                    builder: (ctx) => Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: GlassmorphicContainer(
                                                width: 340,
                                                height: 660,
                                                borderRadius: 8,
                                                border: 1,
                                                blur: 5,
                                                linearGradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      const Color(0xFFffffff)
                                                          .withOpacity(0.2),
                                                      const Color(0xFFFFFFFF)
                                                          .withOpacity(0.2),
                                                    ],
                                                    stops: const [
                                                      0.1,
                                                      1,
                                                    ]),
                                                borderGradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.white10
                                                        .withOpacity(0.2),
                                                    Colors.white10
                                                        .withOpacity(0.2),
                                                  ],
                                                ),
                                                child: Dialog(
                                                  insetPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  // scrollable: true,
                                                  // backgroundColor:
                                                  //     Colors.transparent,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Row(children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child: Container(
                                                                height: 90,
                                                                width: 90,
                                                                child: Image
                                                                    .network(
                                                                  roomData![
                                                                      'imageRoom'],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )),
                                                          const SizedBox(
                                                              width: 20),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                roomData![
                                                                    'roomName'],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "ID: ${roomData!['roomId']}",
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white70,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {},
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .content_copy_rounded,
                                                                        color: Colors
                                                                            .white70,
                                                                        size:
                                                                            16,
                                                                      )),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ]),
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      const Divider(
                                                        indent: 30,
                                                        endIndent: 20,
                                                        color: Colors.white,
                                                        thickness: 1,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        child: Text(
                                                          'HOST',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child: Image
                                                                      .asset(
                                                                    ImageConstant
                                                                        .imgUnsplashjmati51,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          const Text(
                                                            "Host Name",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Divider(
                                                        indent: 45,
                                                        endIndent: 15,
                                                        color: Colors.white,
                                                        thickness: 0.4,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        child: Text(
                                                          'ADMIN',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child: SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child:
                                                                    Image.asset(
                                                                  ImageConstant
                                                                      .imgUnsplash3l3rwq7,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          const Text(
                                                            'User Name',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Divider(
                                                        indent: 45,
                                                        endIndent: 15,
                                                        color: Colors.white,
                                                        thickness: 0.4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(11.89),
                                  top: getVerticalSize(30.00),
                                  right: getHorizontalSize(11.89),
                                ),
                                child: Container(
                                  height: getSize(26.20),
                                  width: getSize(26.20),
                                  child: SvgPicture.asset(
                                    ImageConstant.imgPeoplealtblac,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Consumer<ZegoRoomService>(
                              builder: (_, roomService, child) => InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLock = !isLock;
                                  });
                                  debugPrint("LOCK VALUE: $isLock");
                                  // ZegoRoomService? roomService;
                                  var seatService =
                                      context.read<ZegoSpeakerSeatService>();
                                  debugPrint("HERE");
                                  final errorCode =
                                      await seatService.closeAllSeat(
                                          isLock, roomService.roomInfo);
                                  // .then((errorCode) {
                                  if (0 != errorCode) {
                                    Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .toastLockSeatError(errorCode),
                                        backgroundColor: Colors.grey);
                                  }
                                  // });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.89),
                                    top: getVerticalSize(30.00),
                                    right: getHorizontalSize(11.89),
                                  ),
                                  child: SizedBox(
                                    height: getSize(26.20),
                                    width: getSize(26.20),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgPeoplealtblac1,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Consumer<ZegoRoomService>(
                                builder: (_, roomService, child) => InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isMsgLock = !isMsgLock;
                                        });
                                        debugPrint("MSGLOCK VALUE: $isMsgLock");
                                        // ZegoRoomService? roomService;
                                        final errorCode = await roomService
                                            .disableTextMessage(isMsgLock);
                                        // .then((errorCode) {
                                        String message = '';
                                        if (0 != errorCode) {
                                          message = AppLocalizations.of(
                                                  context)!
                                              .toastMuteMessageError(errorCode);
                                        } else {
                                          if (isMsgLock) {
                                            message = AppLocalizations.of(
                                                    context)!
                                                .toastDisableTextChatSuccess;
                                          } else {
                                            message =
                                                AppLocalizations.of(context)!
                                                    .toastAllowTextChatSuccess;
                                          }
                                        }
                                        Fluttertoast.showToast(
                                            msg: message,
                                            backgroundColor: Colors.grey);
                                        // });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(11.89),
                                          top: getVerticalSize(35.00),
                                          right: getHorizontalSize(11.89),
                                        ),
                                        child: SizedBox(
                                          height: getSize(26.20),
                                          width: getSize(26.20),
                                          child: SvgPicture.asset(
                                            ImageConstant.imgPaymentsblack,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )),
                            Padding(
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  11.89,
                                ),
                                top: getVerticalSize(
                                  35.00,
                                ),
                                right: getHorizontalSize(
                                  11.89,
                                ),
                              ),
                              child: Container(
                                  height: getSize(
                                    26.00,
                                  ),
                                  width: getSize(
                                    26.00,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.black45,
                                    size: 22,
                                  )),
                            ),
                            InkWell(
                              onTap: () async {
                                var userService =
                                    context.read<ZegoUserService>();
                                var isLocalHost =
                                    ZegoRoomUserRole.roomUserRoleHost ==
                                        userService.localUserInfo.userRole;
                                if (isLocalHost) {
                                  showDialog<bool>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) =>
                                        showEndRoomDialog(context),
                                  );
                                } else {
                                  var seatService =
                                      context.read<ZegoSpeakerSeatService>();
                                  final value = await seatService.leaveSeat();
                                  // .then((value) {
                                  var roomService =
                                      context.read<ZegoRoomService>();
                                  final errorCode =
                                      await roomService.leaveRoom();
                                  // .then((errorCode) {
                                  if (0 != errorCode) {
                                    Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .toastRoomLeaveFailTip(errorCode),
                                        backgroundColor: Colors.grey);
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection("userJoinRoom")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "roomName": "",
                                      "roomId": "",
                                      "userId": "",
                                      "type": "",
                                      "members": 0,
                                      "imageRoom": "",
                                      "hostName": "",
                                    });
                                    final errorC = await userService.logout();
                                    // .then((errorCode) {
                                    if (errorC != 0) {
                                      Fluttertoast.showToast(
                                          msg: AppLocalizations.of(context)!
                                              .toastRoomEndFailTip(errorC),
                                          backgroundColor: Colors.grey);
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const TrendingScreen()));
                                    }
                                    // Navigator.pushReplacementNamed(
                                    //     context, PageRouteNames.roomEntrance);
                                  }
                                  // });
                                  // });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(11.89),
                                  top: getVerticalSize(35.00),
                                  right: getHorizontalSize(11.89),
                                ),
                                child: SizedBox(
                                  height: getSize(26.20),
                                  width: getSize(26.20),
                                  child: SvgPicture.asset(
                                    ImageConstant.imgEventavailable,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  ValueNotifier<bool> hasDialog = ValueNotifier<bool>(false);
  showEndRoomDialog(BuildContext context) {
    hasDialog.value = true;

    var title = Text(AppLocalizations.of(context)!.roomPageDestroyRoom);
    var content = Text(AppLocalizations.of(context)!.dialogSureToDestroyRoom);

    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.dialogCancel),
          onPressed: () {
            hasDialog.value = false;

            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.dialogConfirm),
          onPressed: () async {
            hasDialog.value = false;

            final value =
                await context.read<ZegoSpeakerSeatService>().leaveSeat();
            // .then((value) {
            var roomService = context.read<ZegoRoomService>();
            var userService = context.read<ZegoUserService>();
            final errorCode = await roomService.leaveRoom();
            // .then((errorCode) {
            if (0 != errorCode) {
              Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!
                      .toastRoomEndFailTip(errorCode),
                  backgroundColor: Colors.grey);
            }
            // });
            await FirebaseFirestore.instance
                .collection("userJoinRoom")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "roomName": "",
              "roomId": "",
              "userId": "",
              "type": "",
              "members": 0,
              "imageRoom": "",
              "hostName": "",
            });
            await FirebaseFirestore.instance
                .collection('hostRoomData')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "roomName": "",
              "roomId": "",
              "imageRoom": "",
              "userId": "",
              "users": [],
              "type": "",
              "roomCharisma": 0,
              "lockId": "",
              "hostName": "",
            });
            final errorC = await userService.logout();
            // .then((errorCode) {
            if (errorC != 0) {
              Fluttertoast.showToast(
                  msg:
                      AppLocalizations.of(context)!.toastRoomEndFailTip(errorC),
                  backgroundColor: Colors.grey);
            } else {
              Navigator.of(context).pop(true);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) => const MyRoomsScreen()));
            }
            // });

            // Navigator.pushReplacementNamed(
            //     context, PageRouteNames.roomEntrance);
            // });
          },
        ),
      ],
    );
  }
  // Future<bool> _checkMicPermission(
  //     BuildContext context, bool showDialog) async {
  //   var userService = context.read<ZegoUserService>();
  //   var status =
  //       ZegoRoomUserRole.roomUserRoleHost == userService.localUserInfo.userRole
  //           ? await Permission.microphone.request()
  //           : await Permission.microphone.status;

  //   if (!status.isGranted) {
  //     if (showDialog) {
  //       _showDialog(context, AppLocalizations.of(context)!.roomPageMicCantOpen,
  //           AppLocalizations.of(context)!.roomPageGrantMicPermission,
  //           cancelButtonText: AppLocalizations.of(context)!.dialogCancel,
  //           confirmButtonText:
  //               AppLocalizations.of(context)!.roomPageGoToSettings,
  //           confirmCallback: () => openAppSettings());
  //     }
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // _showDialog(BuildContext context, String title, String description,
  //     {String? cancelButtonText,
  //     String? confirmButtonText,
  //     VoidCallback? confirmCallback}) {
  //   hasDialog.value = true;

  //   showDialog<String>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text(title),
  //       content: Text(description),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             hasDialog.value = false;

  //             Navigator.pop(
  //                 context,
  //                 cancelButtonText ??
  //                     AppLocalizations.of(context)!.dialogCancel);
  //           },
  //           child: Text(
  //               cancelButtonText ?? AppLocalizations.of(context)!.dialogCancel),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             hasDialog.value = false;

  //             Navigator.pop(
  //                 context,
  //                 confirmButtonText ??
  //                     AppLocalizations.of(context)!.dialogConfirm);

  //             if (confirmCallback != null) {
  //               confirmCallback();
  //             }
  //           },
  //           child: Text(confirmButtonText ??
  //               AppLocalizations.of(context)!.dialogConfirm),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
