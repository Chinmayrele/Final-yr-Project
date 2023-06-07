import 'dart:convert';

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../localization/localisation.dart';
import '../../rooms/widgets/providers.dart';
import '../../service/zego_message_service.dart';
import '../../service/zego_room_service.dart';
import '../../service/zego_speaker_seat_service.dart';
import '../../service/zego_user_service.dart';

import '../../common/style/styles.dart';
import '../../model/zego_room_user_role.dart';
import '../../common/room_info_content.dart';
import '../../common/input/input_dialog.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import 'gift/room_gift_page.dart';
import 'member/room_member_page.dart';

class ControllerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconSrc;

  const ControllerButton(
      {Key? key, required this.onPressed, required this.iconSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 68.w,
        height: 68.w,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Transform.scale(
          scale: 1.5,
          child: IconButton(
            onPressed: onPressed,
            icon: Image.asset(
              iconSrc,
            ),
          ),
        ));
  }
}

class RoomControlButtonsBar extends HookWidget {
  RoomControlButtonsBar({Key? key}) : super(key: key);

  ValueNotifier<bool> hasDialog = ValueNotifier<bool>(false);

  final TextEditingController msgInputEditingController =
      TextEditingController();
  final TextEditingController _controller = TextEditingController();
  String _enteredMsg = '';
  FocusNode focusNode = FocusNode();
  bool isEmojiShowing = false;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<Provid>(context);
    // Check microphone permission
    useEffect(() {
      _checkMicPermission(context, false).then((hasPermission) {
        //  sync microphone default status after check permission
        var seatService = context.read<ZegoSpeakerSeatService>();
        seatService.setMicrophoneDefaultMute(!hasPermission);
      });
      // // FOR GIFT TAKING USERLIST
      // var userService = context.read<ZegoUserService>();
      // userService.userList;
      // //TILL HERE
      return null;
    }, const []);

    return Stack(
      children: [
        GlassmorphicContainer(
          // margin: EdgeInsets.only(),
          width: getHorizontalSize(360),
          height: getVerticalSize(75),
          borderRadius: 0,
          linearGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black12,
              Colors.white38,
              Colors.black12,
              Colors.white38,
            ],
          ),
          border: 0,
          blur: 5,
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white10.withOpacity(0.3),
              Colors.white10.withOpacity(0.3),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(32.w, 22.h, 12.h, 22.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<ZegoRoomService>(
                builder: (_, roomService, child) => Neumorphic(
                  style: NeumorphicStyle(
                    depth: -3,
                    color: Colors.black12.withOpacity(0.3),
                    border: NeumorphicBorder(
                        width: 0.5, color: Colors.black12.withOpacity(0.1)),
                    boxShape: const NeumorphicBoxShape.stadium(),
                  ),
                  child: SizedBox(
                    width: getHorizontalSize(220),
                    // height: getVerticalSize(42),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.white),
                            // textAlign: TextAlign.center,
                            controller: msgInputEditingController,
                            decoration: InputDecoration(
                              hintText: "   Send Message...",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: getSize(12)),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 10),
                            ),
                            onChanged: (val) {
                              _enteredMsg = msgInputEditingController.text;
                            },
                            onSubmitted: (val) {
                              // _showMessageInput(context);
                              var userService = context.read<ZegoUserService>();
                              var roomService = context.read<ZegoRoomService>();
                              var messageService =
                                  context.read<ZegoMessageService>();
                              messageService
                                  .sendTextMessage(
                                      roomService.roomInfo.roomID,
                                      userService.localUserInfo.userID,
                                      msgInputEditingController.text)
                                  .then((errorCode) {
                                if (0 != errorCode) {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .toastSendMessageError(errorCode),
                                      backgroundColor: Colors.grey);
                                } else {
                                  _enteredMsg = '';
                                  msgInputEditingController.text = '';
                                  focusNode.unfocus(); // clear if send
                                }
                              });
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(right: getHorizontalSize(5)),
                        //   child: Image.asset(
                        //     ImageConstant.imgFlushedemojii,
                        //     height: getVerticalSize(
                        //       22.00,
                        //     ),
                        //     width: getHorizontalSize(
                        //       22.00,
                        //     ),
                        //     // fit: BoxFit.fill,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // ControllerButton(
                //       iconSrc: _getImIcon(context, roomService),
                //       onPressed: () {
                //         var userService = context.read<ZegoUserService>();
                //         if (ZegoRoomUserRole.roomUserRoleHost !=
                //                 userService.localUserInfo.userRole &&
                //             roomService.roomInfo.isTextMessageDisable) {
                //           Fluttertoast.showToast(
                //               msg: AppLocalizations.of(context)!
                //                   .roomPageBandsSendMessage,
                //               backgroundColor: Colors.grey);
                //           return;
                //         }
                //         _showMessageInput(context);
                //       },
                //     )
              ),
              const Expanded(child: Text('')),
              Consumer2<ZegoUserService, ZegoSpeakerSeatService>(
                  builder: (_, users, seats, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _enteredMsg.isNotEmpty
                          ? [
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: getHorizontalSize(15)),
                                  child: Image.asset(
                                    ImageConstant.imgFlushedemojii,
                                    height: getVerticalSize(
                                      22.00,
                                    ),
                                    width: getHorizontalSize(
                                      22.00,
                                    ),
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    var userService =
                                        context.read<ZegoUserService>();
                                    var roomService =
                                        context.read<ZegoRoomService>();
                                    var messageService =
                                        context.read<ZegoMessageService>();
                                    messageService
                                        .sendTextMessage(
                                            roomService.roomInfo.roomID,
                                            userService.localUserInfo.userID,
                                            msgInputEditingController.text)
                                        .then((errorCode) {
                                      if (0 != errorCode) {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .toastSendMessageError(
                                                    errorCode),
                                            backgroundColor: Colors.grey);
                                      } else {
                                        _enteredMsg = '';
                                        msgInputEditingController.text = '';
                                        focusNode.unfocus();
                                        // clear if send
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.pink,
                                    size: 28,
                                  )),
                              const SizedBox(width: 15),
                            ]
                          : _createControllerButtons(
                              users.localUserInfo.userRole, seats.isMute,
                              // micCallback: () {
                              //   _checkMicPermission(context, true).then((hasPermission) {
                              //     if (hasPermission) {
                              //       var seatService =
                              //           context.read<ZegoSpeakerSeatService>();
                              //       seatService.toggleMic();
                              //     }
                              //   });
                              // },
                              memberCallback: () {
                                hasDialog.value = true;
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    isDismissible: true,
                                    builder: (BuildContext context) {
                                      return AnimatedPadding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: SizedBox(
                                              height: 800.h,
                                              child: const RoomMemberPage()));
                                    }).then((value) {
                                  hasDialog.value = false;
                                });
                              },
                              giftCallback: () {
                                hasDialog.value = true;
                                showModalBottomSheet(
                                    constraints: BoxConstraints(
                                        maxHeight: getVerticalSize(340)),
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    isDismissible: true,
                                    builder: (BuildContext context) {
                                      return AnimatedPadding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: SizedBox(
                                              height: 800.h,
                                              child: RoomGiftPage()));
                                    }).then((value) {
                                  hasDialog.value = false;
                                });
                              },
                              moreCallback: () {
                                hasDialog.value = true;
                                showModalBottomSheet(
                                    context: context,
                                    isDismissible: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          height: 60.h + 98.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: _getMoreMenu(context),
                                          ));
                                    }).then((value) {
                                  hasDialog.value = false;
                                });
                              },
                              // settingsCallback: () {
                              //   hasDialog.value = true;
                              //   showModalBottomSheet(
                              //       context: context,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(12)),
                              //       isDismissible: true,
                              //       builder: (BuildContext context) {
                              //         return AnimatedPadding(
                              //             padding: MediaQuery.of(context).viewInsets,
                              //             duration: const Duration(milliseconds: 100),
                              //             child: SizedBox(
                              //                 height: 800.h,
                              //                 child: const RoomSettingPage()));
                              //       }).then((value) {
                              //     hasDialog.value = false;
                              //   });
                              // }),
                            ))),
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
        ),
      ],
    );
  }

  _getImIcon(BuildContext context, ZegoRoomService roomService) {
    var userService = context.read<ZegoUserService>();
    if (ZegoRoomUserRole.roomUserRoleHost ==
        userService.localUserInfo.userRole) {
      return StyleIconUrls.roomBottomIm;
    }
    return roomService.roomInfo.isTextMessageDisable
        ? StyleIconUrls.roomBottomImDisable
        : StyleIconUrls.roomBottomIm;
  }

  _getMoreMenu(BuildContext context) {
    List<Widget> listItems = [];

    var inviteTakeSeat = SizedBox(
      height: 98.h,
      width: 630.w,
      child: CupertinoButton(
          color: Colors.white,
          child: Text(
            AppLocalizations.of(context)!.roomPageLeaveSpeakerSeat,
            style: TextStyle(color: const Color(0xFF1B1B1B), fontSize: 28.sp),
          ),
          onPressed: () {
            Navigator.pop(context);
            _onLeaveSeatClicked(context);
          }),
    );
    listItems.add(inviteTakeSeat);

    return listItems;
  }

  _onLeaveSeatClicked(BuildContext context) {
    var seats = context.read<ZegoSpeakerSeatService>();
    _showDialog(context, AppLocalizations.of(context)!.roomPageLeaveSpeakerSeat,
        AppLocalizations.of(context)!.dialogSureToLeaveSeat,
        confirmCallback: () {
      seats.leaveSeat().then((code) {
        if (code != 0) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.toastLeaveSeatFail(code),
              backgroundColor: Colors.grey);
        }
      });
    });
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

              Navigator.pop(
                  context,
                  cancelButtonText ??
                      AppLocalizations.of(context)!.dialogCancel);
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
            child: Text(confirmButtonText ??
                AppLocalizations.of(context)!.dialogConfirm),
          ),
        ],
      ),
    );
  }

  _showMessageInput(BuildContext context) {
    hasDialog.value = true;

    InputDialog.show(context, msgInputEditingController).then((value) {
      hasDialog.value = false;

      if (value?.isEmpty ?? true) {
        return;
      }

      var userService = context.read<ZegoUserService>();
      var roomService = context.read<ZegoRoomService>();

      if (ZegoRoomUserRole.roomUserRoleHost !=
              userService.localUserInfo.userRole &&
          roomService.roomInfo.isTextMessageDisable) {
        //  host disable message after listener pop up input dialog
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.roomPageBandsSendMessage,
            backgroundColor: Colors.grey);
        return;
      }

      var messageService = context.read<ZegoMessageService>();
      messageService
          .sendTextMessage(roomService.roomInfo.roomID,
              userService.localUserInfo.userID, value!)
          .then((errorCode) {
        if (0 != errorCode) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!
                  .toastSendMessageError(errorCode),
              backgroundColor: Colors.grey);
        } else {
          msgInputEditingController.text = ''; // clear if send
        }
      });
    });
  }

  Future<bool> _checkMicPermission(
      BuildContext context, bool showDialog) async {
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
            confirmButtonText:
                AppLocalizations.of(context)!.roomPageGoToSettings,
            confirmCallback: () => openAppSettings());
      }
      return false;
    } else {
      return true;
    }
  }

  _createControllerButtons(
    ZegoRoomUserRole userRole,
    bool isMute, {
    // required VoidCallback micCallback,
    required VoidCallback memberCallback,
    required VoidCallback giftCallback,
    required VoidCallback moreCallback,
    // required VoidCallback settingsCallback
  }) {
    var buttons = <Widget>[];
    // var micBtn = ControllerButton(
    //   iconSrc: isMute
    //       ? StyleIconUrls.roomBottomMicrophoneMuted
    //       : StyleIconUrls.roomBottomMicrophone,
    //   onPressed: micCallback,
    // );
    var micBtnSpacing = SizedBox(
      width: 36.w,
    );
    var memberBtn = ControllerButton(
      iconSrc: StyleIconUrls.roomBottomMember,
      onPressed: memberCallback,
    );
    var memberBtnSpacing = SizedBox(
      width: 36.w,
    );
    var giftBtn = ControllerButton(
      iconSrc: StyleIconUrls.roomBottomGift,
      onPressed: giftCallback,
    );
    var giftBtnSpacing = SizedBox(
      width: 36.w,
    );
    var moreBtn = ControllerButton(
      iconSrc: StyleIconUrls.roomBottomMore,
      onPressed: moreCallback,
    );
    // var settingsBtn = ControllerButton(
    //   iconSrc: StyleIconUrls.roomBottomSettings,
    //   onPressed: settingsCallback,
    // );
    if (ZegoRoomUserRole.roomUserRoleHost == userRole) {
      // buttons.add(micBtn);
      buttons.add(micBtnSpacing);
      buttons.add(memberBtn);
      buttons.add(memberBtnSpacing);
      buttons.add(giftBtn);
      buttons.add(giftBtnSpacing);
      // buttons.add(settingsBtn);
    } else if (ZegoRoomUserRole.roomUserRoleSpeaker == userRole) {
      // buttons.add(micBtn);
      buttons.add(micBtnSpacing);
      buttons.add(giftBtn);
      buttons.add(giftBtnSpacing);
      buttons.add(moreBtn);
    } else {
      buttons.add(giftBtn);
    }

    return buttons;
  }
}
