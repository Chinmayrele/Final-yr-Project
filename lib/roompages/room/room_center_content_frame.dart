import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/roompages/room/room_seat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../localization/localisation.dart';
import '../../model/user_model.dart';
import '../../providers/info_providers.dart';
import '../../rooms/showModalSheet.dart';
import '../../rooms/showOtherSheet.dart';
import '../../rooms/show_online_sheet.dart';
import '../../rooms/show_today_sheet.dart';
import '../../service/zego_gift_service.dart';
import '../../service/zego_user_service.dart';
import '../../service/zego_speaker_seat_service.dart';

// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import '../../model/zego_user_info.dart';
import '../../common/user_avatar.dart';

import '../../common/room_info_content.dart';
import '../../model/zego_room_user_role.dart';
import '../../model/zego_speaker_seat.dart';
import '../../constants/zego_room_constant.dart';
import 'gift/room_gift_tips.dart';
import 'message/room_message_page.dart';

class RoomCenterContentFrame extends StatefulWidget {
  const RoomCenterContentFrame({Key? key, required this.arguments})
      : super(key: key);
  final Object? arguments;

  @override
  _RoomCenterContentFrameState createState() => _RoomCenterContentFrameState();
}

class _RoomCenterContentFrameState extends State<RoomCenterContentFrame> {
  ValueNotifier<bool> hasDialog = ValueNotifier<bool>(false);

  _createSeats(List<ZegoSpeakerSeat> seatList, List<ZegoUserInfo> userInfoList,
      SeatItemClickCallback callback) {
    var userService = context.read<ZegoUserService>();
    var itemList = <SeatItem>[];
    for (var i = 0; i < 8; i++) {
      var seat = seatList[i];
      var userInfo = userService.getUserByID(seat.userID);
      debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      debugPrint("I AM HERE AT ROOM CENTER: ${userInfo.userName}");
      debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      var avatarIndex = getUserAvatarIndex(userInfo.userName);
      // var avatarData = getUserFullData(context, seat.userID);
      // var data = getUserFullData(context, userInfo.userID);
      var item = SeatItem(
        index: i,
        userID: seat.userID,
        userName: userInfo.userName,
        mic: seat.mic,
        status: seat.status,
        soundLevel: seat.soundLevel,
        networkQuality: seat.network,
        // avatar: avatarData,
        avatar: "images/seat_$avatarIndex.png",
        callback: callback,
        // data: data,
      );
      debugPrint("PIRNITNG SOMETHING");
      itemList.add(item);
    }
    return itemList;
  }

  _showBottomModalButton(
      BuildContext context, String buttonText, VoidCallback callback) {
    hasDialog.value = true;

    showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SizedBox(
              height: 300.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 98.h,
                    width: 630.w,
                    child: CupertinoButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                          callback();
                        },
                        child: Text(
                          buttonText,
                          style: TextStyle(
                              color: const Color(0xFF1B1B1B), fontSize: 28.sp),
                        )),
                  ),
                  SizedBox(
                    height: 98.h,
                    width: 630.w,
                    child: CupertinoButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                          callback();
                        },
                        child: Text(
                          "Invite",
                          style: TextStyle(
                              color: const Color(0xFF1B1B1B), fontSize: 28.sp),
                        )),
                  ),
                ],
              ));
        }).then((value) {
      hasDialog.value = false;
    });
  }

  _showDialog(BuildContext context, String title, String description,
      {String? cancelButtonText,
      String? confirmButtonText,
      VoidCallback? callback}) {
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
              Navigator.pop(
                  context,
                  cancelButtonText ??
                      AppLocalizations.of(context)!.dialogCancel);
            },
            child: Text(confirmButtonText ??
                AppLocalizations.of(context)!.dialogCancel),
          ),
          TextButton(
            onPressed: () {
              hasDialog.value = false;

              Navigator.pop(
                  context, AppLocalizations.of(context)!.dialogConfirm);

              if (callback != null) {
                callback();
              }
            },
            child: Text(AppLocalizations.of(context)!.dialogConfirm),
          ),
        ],
      ),
    );
  }

  String hostUserId = '';

  _hostItemClickCallback(
    int index,
    String userID,
    String userName,
    ZegoSpeakerSeatStatus status,
  ) async {
    debugPrint("USER ID HERE: $userID");
    if (index == 0) {
      UserBasicModel? currUserData;

      result.callCurrentUserProfileData(userID).then((value) {
        currUserData = value;
        result.callCurrentUserFollowData(userID).then((value) {
          final followListMap = value;
          showModalSht(
              context, userID, userName, status, currUserData!, followListMap);
        });
      }).catchError((err) {
        debugPrint("ERR: $err");
      });
      // return;
      // });
    } else if (userID.isEmpty) {
      // Close or Unclose Seat
      var setToClose = ZegoSpeakerSeatStatus.closed != status;
      var buttonText = setToClose
          ? AppLocalizations.of(context)!.roomPageLockSeat
          : AppLocalizations.of(context)!.roomPageUnlockSeat;

      _showBottomModalButton(context, buttonText, () {
        var seats = context.read<ZegoSpeakerSeatService>();
        seats.closeSeat(setToClose, index).then((code) {
          if (code != 0) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.toastLockSeatAlreadyTakeSeat,
                backgroundColor: Colors.grey);
          }
        });
      });
    } else if (userID.isNotEmpty && status == ZegoSpeakerSeatStatus.occupied) {
      UserBasicModel userData;
      Map<String, dynamic> followMap = {};
      final result = Provider.of<InfoProviders>(context, listen: false);
      result.callCurrentUserProfileData(userID).then((val) {
        userData = val;
        result.callCurrentUserFollowData(userID).then((value) {
          followMap = value;
          showOtherModalSht(
              context,
              userID,
              userName,
              status,
              (widget.arguments as Map<String, dynamic>)['hostId'],
              userData,
              followMap);
        });
      });
    } else {
      // Remove user from seat
      _showBottomModalButton(
          context, AppLocalizations.of(context)!.roomPageLeaveSpeakerSeat, () {
        var seats = context.read<ZegoSpeakerSeatService>();
        if (!seats.isSeatOccupied(index)) {
          return;
        }

        _showDialog(
            context,
            AppLocalizations.of(context)!.roomPageLeaveSpeakerSeat,
            AppLocalizations.of(context)!
                .roomPageLeaveSpeakerSeatDesc(userName), callback: () {
          var seats = context.read<ZegoSpeakerSeatService>();
          seats.removeUserFromSeat(index).then((code) {
            if (code != 0) {
              Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!
                      .toastKickoutLeaveSeatError(userName, code),
                  backgroundColor: Colors.grey);
            }
          });
        });
      });
    }
  }

  _speakerItemClickCallback(
      int index, String userID, String userName, ZegoSpeakerSeatStatus status) {
    var users = context.read<ZegoUserService>();
    var seats = context.read<ZegoSpeakerSeatService>();
    debugPrint("USER ID && NAME HERE IS OF $userID AND $userName");
    if (userID.isEmpty) {
      debugPrint("ENTERED HERE IN SPEAKER ITEM CALLBACK!!!");
      if (ZegoSpeakerSeatStatus.closed == status) {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.thisSeatHasBeenClosed,
            backgroundColor: Colors.grey);
        return;
      }
      _showBottomModalButton(
          context, AppLocalizations.of(context)!.roomPageTakeSeat, () {
        if (ZegoSpeakerSeatStatus.closed == seats.seatList[index].status) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.thisSeatHasBeenClosed,
              backgroundColor: Colors.grey);
          return;
        }

        seats.switchSeat(index).then((errorCode) {
          if (0 != errorCode) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!
                    .toastTakeSpeakerSeatFail(errorCode),
                backgroundColor: Colors.grey);
          }
        });
      });
    } else if (status == ZegoSpeakerSeatStatus.occupied &&
        users.localUserInfo.userRole == ZegoRoomUserRole.roomUserRoleHost) {
      debugPrint("ENTERED HERE ONLY NA!!!");
      final result = Provider.of<InfoProviders>(context, listen: false);
      UserBasicModel userData;
      Map<String, dynamic> followMap = {};
      debugPrint("USEIDDDD: $userID");
      result.callCurrentUserProfileData(userID).then((val) {
        userData = val;
        result.callCurrentUserFollowData(userID).then((value) {
          followMap = value;
          debugPrint("follow MAP: $followMap");
          showModalSht(context, userID, users.localUserInfo.userName, status,
              userData, followMap);
        });
      });
    } else if (users.localUserInfo.userID == userID) {
      debugPrint("ENTERED !!!");
      late UserBasicModel userData;
      final result = Provider.of<InfoProviders>(context, listen: false);
      result.callCurrentUserProfileData(userID).then((val) {
        userData = val;
        result.callCurrentUserFollowData(userID).then((val) {
          final followMap = val;
          showOtherModalSht(
              context,
              userID,
              userName,
              status,
              (widget.arguments as Map<String, dynamic>)['hostId'],
              userData,
              followMap);
        });
      });
      // _showBottomModalButton(
      //     context, AppLocalizations.of(context)!.roomPageLeaveSpeakerSeat, () {
      //   var seats = context.read<ZegoSpeakerSeatService>();
      //   if (!seats.isLocalInSeat()) {
      //     Fluttertoast.showToast(
      //         msg: AppLocalizations.of(context)!.toastLeaveSeatFail(-1),
      //         backgroundColor: Colors.grey);
      //     return;
      //   }

      //   _showDialog(
      //       context,
      //       AppLocalizations.of(context)!.roomPageLeaveSpeakerSeat,
      //       AppLocalizations.of(context)!.dialogSureToLeaveSeat, callback: () {
      //     var seats = context.read<ZegoSpeakerSeatService>();
      //     seats.leaveSeat().then((code) {
      //       if (code != 0) {
      //         Fluttertoast.showToast(
      //             msg: AppLocalizations.of(context)!.toastLeaveSeatFail(code),
      //             backgroundColor: Colors.grey);
      //       }
      //     });
      //   });
      // });
    } else if (status == ZegoSpeakerSeatStatus.occupied) {
      debugPrint("ENTERED HERE ONLY NA");
      final result = Provider.of<InfoProviders>(context, listen: false);
      UserBasicModel userData;
      Map<String, dynamic> followMap = {};
      result.callCurrentUserProfileData(users.localUserInfo.userID).then((val) {
        userData = val;
        result
            .callCurrentUserFollowData(users.localUserInfo.userID)
            .then((value) {
          followMap = value;
          showOtherModalSht(
              context,
              userID,
              userName,
              status,
              (widget.arguments as Map<String, dynamic>)['hostId'],
              userData,
              followMap);
        });
      });
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.thisSeatHasBeenClosed,
          backgroundColor: Colors.grey);
    }
  }

  _listenerItemClickCallback(
      int index, String userID, String userName, ZegoSpeakerSeatStatus status) {
    if (userID.isNotEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.thisSeatHasBeenClosed,
          backgroundColor: Colors.grey);
      return;
    }
    if (ZegoSpeakerSeatStatus.closed == status) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.thisSeatHasBeenClosed,
          backgroundColor: Colors.grey);
      return;
    }
    _showBottomModalButton(
        context, AppLocalizations.of(context)!.roomPageTakeSeat, () async {
      var seatService = context.read<ZegoSpeakerSeatService>();

      if (ZegoSpeakerSeatStatus.closed == seatService.seatList[index].status) {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.thisSeatHasBeenClosed,
            backgroundColor: Colors.grey);
        return;
      }

      var status = await Permission.microphone.request();
      seatService.setMicrophoneDefaultMute(!status.isGranted);

      seatService.takeSeat(index).then((code) {
        if (code != 0) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.toastTakeSpeakerSeatFail(code),
              backgroundColor: Colors.grey);
        }
        setState(() {});
      });
    });
  }

  List<dynamic> followingListUids = [];
  List<dynamic> followersListUids = [];
  List<UserBasicModel> followingListData = [];
  List<UserBasicModel> onlineDataList = [];
  // List onlineStatusList = [];
  bool isLoading = true;
  late InfoProviders result;
  // UserBasicModel? hostData;

  @override
  void initState() {
    result = Provider.of<InfoProviders>(context, listen: false);
    getData();
    super.initState();
  }

  Future<void> getData() async {
    followingListData.clear();
    followingListUids.clear();
    // hostData = result.curUserData;
    FirebaseFirestore.instance
        .collection('followList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final e = value.data();
      followingListUids = e!['following'] as List;
      followersListUids = e['followers'] as List;
      result.fetchUsersProfileData(followingListUids).then((value) {
        followingListData = result.usersProfileData;
        onlineDataList = followingListData.where(
          (element) {
            return element.status == "Online";
          },
        ).toList();
        debugPrint("ONLINE DATA LIST LENGTH: ${onlineDataList.length}");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getSeatClickCallbackByUserRole(ZegoRoomUserRole userRole) {
      switch (userRole) {
        case ZegoRoomUserRole.roomUserRoleHost:
          return _hostItemClickCallback;
        case ZegoRoomUserRole.roomUserRoleSpeaker:
          return _speakerItemClickCallback;
        case ZegoRoomUserRole.roomUserRoleListener:
          return _listenerItemClickCallback;
      }
    }

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          )
        // : FutureBuilder(
        //     future: getData(),
        //     builder: (ctx, snapShots) {
        // if (snapShots.connectionState == ConnectionState.waiting) {
        //   return const Center(
        //     child: CircularProgressIndicator(
        //       color: Colors.pink,
        //     ),
        //   );
        // } else {
        : SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('hostRoomData')
                            .doc((widget.arguments
                                as Map<String, dynamic>)['hostId'])
                            .snapshots(),
                        builder: (ctx, snapShots) {
                          if (!snapShots.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.pink,
                              ),
                            );
                          } else {
                            var roomUsersData = snapShots.data!.data();
                            return GestureDetector(
                              onTap: () {
                                showTodaySheet(
                                    context,
                                    followingListData,
                                    ((roomUsersData
                                            as Map<String, dynamic>)['users']
                                        as List));
                                // setState(() {
                                //   today = !today;
                                // });
                              },
                              child: SizedBox(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: getVerticalSize(12),
                                          left: getHorizontalSize(8)),
                                      child: Image.asset(
                                        ImageConstant.imgTrophy,
                                        height: getVerticalSize(29.44),
                                        width: getHorizontalSize(26.07),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: getVerticalSize(15)),
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(40.00),
                                        right: getHorizontalSize(10.00),
                                        top: getVerticalSize(3),
                                        bottom: getVerticalSize(2.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.black90026,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            getHorizontalSize(0.00),
                                          ),
                                          topRight: Radius.circular(
                                            getHorizontalSize(18.50),
                                          ),
                                          bottomLeft: Radius.circular(
                                            getHorizontalSize(0.00),
                                          ),
                                          bottomRight: Radius.circular(
                                            getHorizontalSize(18.50),
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.black90019,
                                          width: getHorizontalSize(
                                            1.00,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        (roomUsersData as Map<String, dynamic>)[
                                                'roomCharisma']
                                            .toString(),
                                        // "12.8 M",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Consumer<ZegoUserService>(
                        builder: (_, userService, child) => Container(
                          margin: EdgeInsets.only(
                              left: getHorizontalSize(220),
                              top: getVerticalSize(10)),
                          decoration: BoxDecoration(
                            color: Colors.white12.withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                getHorizontalSize(18.50),
                              ),
                              topRight: Radius.circular(
                                getHorizontalSize(0.0),
                              ),
                              bottomLeft: Radius.circular(
                                getHorizontalSize(18.50),
                              ),
                              bottomRight: Radius.circular(
                                getHorizontalSize(0.0),
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.black90019,
                              width: getHorizontalSize(1.00),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showOnlineSheet(context, userService.userList);
                              // showOnlineSheet(context, onlineDataList);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(11.00),
                                    top: getVerticalSize(5.00),
                                    bottom: getVerticalSize(6.35),
                                  ),
                                  child: SizedBox(
                                    height: getVerticalSize(10.6),
                                    width: getHorizontalSize(10.6),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgVector1,
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(3.34),
                                    top: getVerticalSize(3.00),
                                    right: getHorizontalSize(6.00),
                                    bottom: getVerticalSize(4.00),
                                  ),
                                  child: Text(
                                    userService.userList.length.toString(),
                                    // onlineDataList.length.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.whiteA700,
                                      fontSize: getFontSize(
                                        12.5,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      // StreamBuilder<QuerySnapshot>(
                      //   stream: FirebaseFirestore.instance
                      //       .collection('followList')
                      //       .snapshots(),
                      //   builder: (ctx, snapshots) {
                      //     if (snapshots.hasData) {
                      //       final onlineDocs = snapshots.data!.docs;
                      //       return Container(
                      //         margin: EdgeInsets.only(
                      //             left: getHorizontalSize(220),
                      //             top: getVerticalSize(10)),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white12.withOpacity(0.1),
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(
                      //               getHorizontalSize(18.50),
                      //             ),
                      //             topRight: Radius.circular(
                      //               getHorizontalSize(0.0),
                      //             ),
                      //             bottomLeft: Radius.circular(
                      //               getHorizontalSize(18.50),
                      //             ),
                      //             bottomRight: Radius.circular(
                      //               getHorizontalSize(0.0),
                      //             ),
                      //           ),
                      //           border: Border.all(
                      //             color: ColorConstant.black90019,
                      //             width: getHorizontalSize(1.00),
                      //           ),
                      //         ),
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             showOnlineSheet(context);
                      //             // setState(() {
                      //             //   online = !online;
                      //             // });
                      //           },
                      //           child: Row(
                      //             crossAxisAlignment:
                      //                 CrossAxisAlignment.start,
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                   left: getHorizontalSize(11.00),
                      //                   top: getVerticalSize(5.00),
                      //                   bottom: getVerticalSize(6.35),
                      //                 ),
                      //                 child: Container(
                      //                   height: getVerticalSize(10.6),
                      //                   width: getHorizontalSize(10.6),
                      //                   child: SvgPicture.asset(
                      //                     ImageConstant.imgVector1,
                      //                     fit: BoxFit.fill,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                   left: getHorizontalSize(3.34),
                      //                   top: getVerticalSize(3.00),
                      //                   right: getHorizontalSize(6.00),
                      //                   bottom: getVerticalSize(4.00),
                      //                 ),
                      //                 child: Text(
                      //                   onlineDocs.length.toString(),
                      //                   // "12",
                      //                   overflow: TextOverflow.ellipsis,
                      //                   textAlign: TextAlign.left,
                      //                   style: TextStyle(
                      //                     color: ColorConstant.whiteA700,
                      //                     fontSize: getFontSize(
                      //                       12.5,
                      //                     ),
                      //                     fontFamily: 'Roboto',
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return const Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.pink,
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  //height: 212.h * 2,
                  height: 370.h,
                  width: 622.w, //(152.w + 22.w) * 3,
                  child: Consumer2<ZegoSpeakerSeatService, ZegoUserService>(
                    builder: (context, seats, users, child) => Container(
                      height: getVerticalSize(190),
                      width: size.width,
                      margin: EdgeInsets.only(
                          left: getHorizontalSize(25), top: getVerticalSize(0)),
                      child: GridView.count(
                        childAspectRatio: (122 / 165),
                        primary: false,
                        crossAxisSpacing: 22.w,
                        mainAxisSpacing: 0,
                        crossAxisCount: 4,
                        children: _createSeats(
                            seats.seatList,
                            users.userList,
                            getSeatClickCallbackByUserRole(
                                users.localUserInfo.userRole)),
                      ),
                    ),
                  ),
                ),
                // const Expanded(child: Text('')),
                Consumer<ZegoGiftService>(
                    builder: (_, giftService, child) => Visibility(
                        visible: giftService.displayTips,
                        child: _getRoomGiftTips(context, giftService))),
                SizedBox(height: 18.h),
                // ConstrainedBox(
                //     constraints: BoxConstraints(
                //       minWidth: 632.w,
                //       maxWidth: 632.w,
                //       minHeight: 1.h,
                //       maxHeight: 640.h, //  630.h change by gift tips
                //     ),
                Expanded(child: ChatMessagePage()),
                Consumer<ZegoUserService>(builder: (_, userService, child) {
                  if (userService.notifyInfo.isEmpty) {
                    return const Offstage(offstage: true, child: Text(''));
                  }
                  Future.delayed(Duration.zero, () async {
                    var infoContent = RoomInfoContent.fromJson(
                        jsonDecode(userService.notifyInfo));

                    switch (infoContent.toastType) {
                      case RoomInfoType.roomNetworkTempBroken:
                        if (hasDialog.value) {
                          hasDialog.value = false;
                          Navigator.pop(context);
                        }
                        break;
                      default:
                        break;
                    }
                  });

                  return const Offstage(offstage: true, child: Text(''));
                }),
              ],
            ),
          );
    // });
  }

  Widget _getRoomGiftTips(BuildContext context, ZegoGiftService giftService) {
    var userService = context.read<ZegoUserService>();
    String senderName =
        userService.getUserByID(giftService.giftSender).userName;
    List<String> receiverNames = [];
    for (var userID in giftService.giftReceivers) {
      receiverNames.add(userService.getUserByID(userID).userName);
    }
    return RoomGiftTips(
      gift: GiftMessageModel(senderName, receiverNames, giftService.giftID),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [invite, unlock];

  static const invite = MenuItem(text: 'Invite', icon: CupertinoIcons.plus);
  static const unlock = MenuItem(text: 'Unlock', icon: Icons.lock_open);
  // static const settings = MenuItem(text: 'Settings', icon: Icons.settings);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.invite:
        //Do something
        break;
      case MenuItems.unlock:
        //Do something
        break;
      // case MenuItems.share:
      // //Do something
      //   break;
    }
  }
}
