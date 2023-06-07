import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/rooms/widgets/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../constants/zego_room_constant.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../localization/localisation.dart';
import '../model/user_model.dart';
import '../model/zego_room_user_role.dart';
import '../my_rooms_screen/my_rooms_screen.dart';
import '../providers/info_providers.dart';
import '../service/zego_room_service.dart';
import '../service/zego_speaker_seat_service.dart';
import '../service/zego_user_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

showModalSht(
    BuildContext context,
    String userID,
    String userName,
    ZegoSpeakerSeatStatus status,
    UserBasicModel hostData,
    Map<String, dynamic> followList) {
  return Future.delayed(const Duration(seconds: 2)).then((val) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            // bool isLoad = true;
            // @override
            // late InfoProviders result;
            // UserBasicModel? currUserData;
            // result = Provider.of<InfoProviders>(context, listen: false);
            // result.callCurrentUserProfileData(userID).then((value) {
            //   currUserData = value;
            //   setState(() {});
            // });
            // ZegoSpeakerSeatService seatService = ZegoSpeakerSeatService();
            ZegoSpeakerSeatService seatService =
                context.read<ZegoSpeakerSeatService>();
            final mic = Provider.of<Provid>(context);
            return Container(
              height: getVerticalSize(
                330.00,
              ),
              width: size.width,
              margin: EdgeInsets.only(
                top: getVerticalSize(
                  20.00,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: GlassmorphicContainer(
                              borderRadius: 15,
                              width: size.width,
                              blur: 10,
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
                              height: getVerticalSize(280),
                            )),
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) => Profile()));
                          },
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              children: [
                                GlassmorphicContainer(
                                  borderRadius: 60,
                                  width: getHorizontalSize(100),
                                  blur: 1,
                                  alignment: Alignment.bottomCenter,
                                  border: 1,
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
                                      Colors.white10.withOpacity(0.2),
                                      Colors.white10.withOpacity(0.2),
                                    ],
                                  ),
                                  height: getVerticalSize(100),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 4.5),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        getSize(
                                          45.50,
                                        ),
                                      ),
                                      child: Image.network(
                                        hostData.imageUrl,
                                        height: getVerticalSize(
                                          91.00,
                                        ),
                                        width: getHorizontalSize(
                                          92.00,
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                      //     Image.asset(
                                      //   ImageConstant.imgUnsplashvvewjj,
                                      //   height: getVerticalSize(
                                      //     91.00,
                                      //   ),
                                      //   width: getHorizontalSize(
                                      //     92.00,
                                      //   ),
                                      //   fit: BoxFit.fill,
                                      // ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: getVerticalSize(
                                70.00,
                              ),
                              bottom: getVerticalSize(
                                12.00,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstant.blue100,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  getHorizontalSize(
                                    14.50,
                                  ),
                                ),
                                bottomLeft: Radius.circular(
                                  getHorizontalSize(
                                    14.50,
                                  ),
                                ),
                              ),
                              border: Border.all(
                                color: ColorConstant.blue900,
                                width: getHorizontalSize(
                                  1.00,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.black90040,
                                  spreadRadius: getHorizontalSize(
                                    2.00,
                                  ),
                                  blurRadius: getHorizontalSize(
                                    2.00,
                                  ),
                                  offset: Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      8.65,
                                    ),
                                    top: getVerticalSize(
                                      5.00,
                                    ),
                                    bottom: getVerticalSize(
                                      4.39,
                                    ),
                                  ),
                                  child: Image.asset(
                                    ImageConstant.imgBluesapphire,
                                    height: getVerticalSize(
                                      15.00,
                                    ),
                                    width: getHorizontalSize(
                                      10.26,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                        4.64,
                                      ),
                                      top: getVerticalSize(
                                        6.73,
                                      ),
                                      bottom: getVerticalSize(
                                        5.88,
                                      ),
                                      right: getHorizontalSize(2)),
                                  child: Text(
                                    "12.3 M",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.blue900,
                                      fontSize: getFontSize(
                                        10,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(0)),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: getHorizontalSize(12),
                                    color: ColorConstant.blue900,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(
                          10.55,
                        ),
                        top: getVerticalSize(
                          19.60,
                        ),
                        right: getHorizontalSize(
                          10.55,
                        ),
                        bottom: getVerticalSize(
                          19.60,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              userName,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontSize: getFontSize(
                                  26,
                                ),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: getVerticalSize(
                                62.53,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      71.00,
                                    ),
                                  ),
                                  child: Text(
                                    (followList['following'] as List)
                                        .length
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.whiteA700,
                                      fontSize: getFontSize(
                                        13,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      6.73,
                                    ),
                                    top: getVerticalSize(
                                      3.00,
                                    ),
                                    bottom: getVerticalSize(
                                      2.20,
                                    ),
                                  ),
                                  child: Text(
                                    "Following",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.whiteA700,
                                      fontSize: getFontSize(
                                        10,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      5.89,
                                    ),
                                  ),
                                  child: Container(
                                    height: getVerticalSize(
                                      5.05,
                                    ),
                                    width: getHorizontalSize(
                                      2.52,
                                    ),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgVector11,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: getVerticalSize(
                                    16.82,
                                  ),
                                  width: getHorizontalSize(
                                    0.84,
                                  ),
                                  margin: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      13.46,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.whiteA700,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      13.46,
                                    ),
                                    top: getVerticalSize(
                                      1.00,
                                    ),
                                  ),
                                  child: Text(
                                    (followList['followers'] as List)
                                        .length
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.whiteA700,
                                      fontSize: getFontSize(
                                        13,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      6.73,
                                    ),
                                    top: getVerticalSize(
                                      3.00,
                                    ),
                                    bottom: getVerticalSize(
                                      2.20,
                                    ),
                                  ),
                                  child: Text(
                                    "Followers",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.whiteA700,
                                      fontSize: getFontSize(
                                        10,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      5.88,
                                    ),
                                    right: getHorizontalSize(
                                      72.84,
                                    ),
                                  ),
                                  child: Container(
                                    height: getVerticalSize(
                                      5.05,
                                    ),
                                    width: getHorizontalSize(
                                      2.52,
                                    ),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgVector11,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  10.02,
                                ),
                                right: getHorizontalSize(
                                  3.45,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.lime200,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          10.00,
                                        ),
                                      ),
                                      border: Border.all(
                                        color: ColorConstant.lime800,
                                        width: getHorizontalSize(
                                          1.50,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              10.00,
                                            ),
                                          ),
                                          child: Image.asset(
                                            ImageConstant.img2bronzelvl1,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: getHorizontalSize(
                                                  7.59,
                                                ),
                                                top: getVerticalSize(
                                                  5.07,
                                                ),
                                                right: getHorizontalSize(
                                                  35.28,
                                                ),
                                              ),
                                              child: Text(
                                                "VIP level",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: ColorConstant
                                                      .lightGreen900,
                                                  fontSize: getFontSize(
                                                    8,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    7.59,
                                                  ),
                                                  top: getVerticalSize(
                                                    0.69,
                                                  ),
                                                  right: getHorizontalSize(
                                                    35.28,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    4.15,
                                                  ),
                                                ),
                                                child: Text(
                                                  "vip 1",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .lightGreen900,
                                                    fontSize: getFontSize(
                                                      12,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.amber100,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          10.00,
                                        ),
                                      ),
                                      border: Border.all(
                                        color: ColorConstant.orangeA100,
                                        width: getHorizontalSize(
                                          1.50,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              10.00,
                                            ),
                                          ),
                                          child: Image.asset(
                                            ImageConstant.imgTrophy,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    7.50,
                                                  ),
                                                  top: getVerticalSize(
                                                    5.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    30,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Contribution",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.orange700,
                                                    fontSize: getFontSize(
                                                      8,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: getHorizontalSize(
                                                  7.51,
                                                ),
                                                top: getVerticalSize(
                                                  0.76,
                                                ),
                                                right: getHorizontalSize(
                                                  30,
                                                ),
                                                bottom: getVerticalSize(
                                                  4.15,
                                                ),
                                              ),
                                              child: Text(
                                                "123k",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.orange700,
                                                  fontSize: getFontSize(
                                                    12,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.lightGreenA100,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(
                                          10.00,
                                        ),
                                      ),
                                      border: Border.all(
                                        color: ColorConstant.lightGreenA200,
                                        width: getHorizontalSize(
                                          1.50,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              10.00,
                                            ),
                                            top: getVerticalSize(
                                              8.00,
                                            ),
                                            bottom: getVerticalSize(
                                              8.00,
                                            ),
                                          ),
                                          child: Container(
                                              height: getSize(
                                                18.00,
                                              ),
                                              width: getSize(
                                                18.00,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: ColorConstant.starr,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.star,
                                                color: ColorConstant
                                                    .lightGreenA100,
                                                size: 15,
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              7.59,
                                            ),
                                            top: getVerticalSize(
                                              5.07,
                                            ),
                                            right: getHorizontalSize(
                                              33.41,
                                            ),
                                            bottom: getVerticalSize(
                                              4.15,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: getHorizontalSize(
                                                    1.83,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Charisma",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .lightGreen800,
                                                    fontSize: getFontSize(
                                                      8,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(
                                                    0.69,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    0.00,
                                                  ),
                                                ),
                                                child: Text(
                                                  "2.56 m",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .lightGreen800,
                                                    fontSize: getFontSize(
                                                      12,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: getVerticalSize(
                                8.98,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: getVerticalSize(
                                    45.42,
                                  ),
                                  width: getHorizontalSize(
                                    168.22,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                          ImageConstant.imgRectangle210,
                                          height: getVerticalSize(
                                            45.42,
                                          ),
                                          width: getHorizontalSize(
                                            168.22,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          var userService =
                                              context.read<ZegoUserService>();
                                          var isLocalHost = ZegoRoomUserRole
                                                  .roomUserRoleHost ==
                                              userService
                                                  .localUserInfo.userRole;
                                          if (isLocalHost) {
                                            showDialog<bool>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  showEndRoomDialog(context),
                                            );
                                          } else {
                                            var seatService = context
                                                .read<ZegoSpeakerSeatService>();
                                            final value =
                                                await seatService.leaveSeat();
                                            // .then((value) {
                                            var roomService =
                                                context.read<ZegoRoomService>();
                                            final errorCode =
                                                await roomService.leaveRoom();
                                            // .then((errorCode) {
                                            if (0 != errorCode) {
                                              Fluttertoast.showToast(
                                                  msg: AppLocalizations.of(
                                                          context)!
                                                      .toastRoomLeaveFailTip(
                                                          errorCode),
                                                  backgroundColor: Colors.grey);
                                            } else {
                                              await FirebaseFirestore.instance
                                                  .collection("userJoinRoom")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                "roomName": "",
                                                "roomId": "",
                                                "userId": "",
                                                "type": "",
                                                "members": 0,
                                                "imageRoom": "",
                                                "hostName": "",
                                              });
                                              final errorC =
                                                  await userService.logout();
                                              // .then((errorCode) {
                                              if (errorC != 0) {
                                                Fluttertoast.showToast(
                                                    msg: AppLocalizations.of(
                                                            context)!
                                                        .toastRoomEndFailTip(
                                                            errorCode),
                                                    backgroundColor:
                                                        Colors.grey);
                                              } else {
                                                Navigator.of(context).pop();
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            const MyRoomsScreen()));
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
                                            left: getHorizontalSize(
                                              37.01,
                                            ),
                                            bottom: getVerticalSize(
                                              8.96,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: getVerticalSize(
                                                    3.65,
                                                  ),
                                                ),
                                                child: Container(
                                                  height: getVerticalSize(
                                                    20.03,
                                                  ),
                                                  width: getHorizontalSize(
                                                    18.50,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    ImageConstant
                                                        .img04f2f1fed89b09d,
                                                    fit: BoxFit.fill,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    6.73,
                                                  ),
                                                  top: getVerticalSize(
                                                    1.68,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Leave",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.whiteA700,
                                                    fontSize: getFontSize(
                                                      20,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
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
                                Container(
                                  height: getVerticalSize(
                                    45.42,
                                  ),
                                  width: getHorizontalSize(
                                    170.0,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                          ImageConstant.imgRectangle211,
                                          height: getVerticalSize(
                                            45.42,
                                          ),
                                          width: getHorizontalSize(
                                            168.22,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final hasPermission =
                                              await _checkMicPermission(
                                                  context, true);
                                          // .then((hasPermission) {
                                          if (hasPermission) {
                                            seatService = context
                                                .read<ZegoSpeakerSeatService>();
                                            seatService.toggleMic();
                                            setState(() {});
                                          }
                                          // });
                                        },
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                30.45,
                                              ),
                                              bottom: getVerticalSize(
                                                8.96,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: getVerticalSize(
                                                      3.65,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    height: getVerticalSize(
                                                      21.03,
                                                    ),
                                                    width: getHorizontalSize(
                                                      15.14,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      ImageConstant.imgVector5,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      7.57,
                                                    ),
                                                    top: getVerticalSize(
                                                      1.68,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    !seatService.isMute
                                                        ? "Turn Off"
                                                        : "Turn On",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: ColorConstant
                                                          .whiteA700,
                                                      fontSize: getFontSize(
                                                        20,
                                                      ),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
            );
          });
        });
  });
}

ValueNotifier<bool> hasDialog = ValueNotifier<bool>(false);
showEndRoomDialog(BuildContext context) {
  hasDialog.value = true;

  var title = const Text(
    'Leave Room',
    style: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  );
  var content = const Text(
    'Leave the room now?',
    style: TextStyle(color: Colors.black, fontSize: 16),
  );

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

          // final value =
          //     await context.read<ZegoSpeakerSeatService>().leaveSeat();
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
          final errorC = await userService.logout();
          // .then((errorCode) {
          if (errorC != 0) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!
                    .toastRoomEndFailTip(errorC),
                backgroundColor: Colors.grey);
          } else {
            Navigator.of(context).pop(true);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const MyRoomsScreen()));
          }

          // Navigator.pushReplacementNamed(
          //     context, PageRouteNames.roomEntrance);
          // });
        },
      ),
    ],
  );
}

Future<bool> _checkMicPermission(BuildContext context, bool showDialog) async {
  var userService = context.read<ZegoUserService>();
  var status =
      ZegoRoomUserRole.roomUserRoleHost == userService.localUserInfo.userRole
          ? await Permission.microphone.request()
          : await Permission.microphone.status;

  if (!status.isGranted) {
    if (showDialog) {
      _showDialog(context, AppLocalizations.of(context)!.roomPageMicCantOpen,
          AppLocalizations.of(context)!.roomPageGrantMicPermission,
          cancelButtonText: AppLocalizations.of(context)!.dialogCancel,
          confirmButtonText: AppLocalizations.of(context)!.roomPageGoToSettings,
          confirmCallback: () => openAppSettings());
    }
    return false;
  } else {
    return true;
  }
}

_showDialog(BuildContext context, String title, String description,
    {String? cancelButtonText,
    String? confirmButtonText,
    VoidCallback? confirmCallback}) {
  hasDialog.value = true;

  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            hasDialog.value = false;

            Navigator.pop(context,
                cancelButtonText ?? AppLocalizations.of(context)!.dialogCancel);
          },
          child: Text(
              cancelButtonText ?? AppLocalizations.of(context)!.dialogCancel),
        ),
        TextButton(
          onPressed: () {
            hasDialog.value = false;

            Navigator.pop(
                context,
                confirmButtonText ??
                    AppLocalizations.of(context)!.dialogConfirm);

            if (confirmCallback != null) {
              confirmCallback();
            }
          },
          child: Text(
              confirmButtonText ?? AppLocalizations.of(context)!.dialogConfirm),
        ),
      ],
    ),
  );
}
