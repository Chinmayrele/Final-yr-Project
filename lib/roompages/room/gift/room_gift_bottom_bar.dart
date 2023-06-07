import 'package:final_yr_project/roompages/room/gift/room_gift_member_list.dart';
import 'package:final_yr_project/roompages/room/gift/userDiamond.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import '../../../core/utils/math_utils.dart';
import '../../../service/zego_gift_service.dart';
import '../../../service/zego_speaker_seat_service.dart';
import '../../../service/zego_user_service.dart';
import '../../../service/zego_room_service.dart';
import '../../../common/style/styles.dart';
import '../../../model/zego_user_info.dart';
import '../../../model/zego_room_gift.dart';
import '../../../wallet_screen/wallet_screen.dart';
import 'item_gift_select_send.dart';

class RoomGiftBottomBar extends HookWidget {
  RoomGiftBottomBar(
      {Key? key, required this.selectedRoomGift, required this.userGiftID})
      : super(key: key);

  ValueNotifier<ZegoRoomGift> selectedRoomGift;
  final String userGiftID;

  late OverlayEntry _memberListEntry;
  late OverlayState _memberListState;
  bool _isMemberListVisible = false;
  ZegoUserInfo selectedUser = ZegoUserInfo.empty();
  String dropdownvalue = '1';

  var items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  OverlayEntry _createOverlayEntry(TextEditingController userNameTextCtrl) {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.center,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(
                    left: 36.w, top: 812.h, right: 246.w, bottom: 150.h),
                child: RoomGiftMemberList(memberSelectNotify: (userInfo) {
                  selectedUser = userInfo;
                  if (userIDOfNoSpeakerUser != selectedUser.userID) {
                    //  meaningful user
                    userNameTextCtrl.text = selectedUser.userName;
                  }
                  hideMemberList();
                }),
              )),
          onTap: () {
            hideMemberList();
          },
        ),
      ),
    );
  }

  showMemberList(context, userNameTextCtrl) async {
    if (!_isMemberListVisible) {
      _memberListState = Overlay.of(context)!;
      _memberListEntry = _createOverlayEntry(userNameTextCtrl);
      _memberListState.insert(_memberListEntry);
      _isMemberListVisible = true;
    }
  }

  void hideMemberList() {
    _isMemberListVisible = false;
    _memberListEntry.remove();
  }

  // void sendGift(BuildContext context) {
  //   if (selectedUser.isEmpty() ||
  //       userIDOfNoSpeakerUser == selectedUser.userID) {
  //     return;
  //   }
  //   var giftService = context.read<ZegoGiftService>();
  //   var userService = context.read<ZegoUserService>();
  //   var roomService = context.read<ZegoRoomService>();
  //   var seatService = context.read<ZegoSpeakerSeatService>();
  //   List<String> toUserList = [];
  //   if (userIDOfAllSpeaker == selectedUser.userID) {
  //     //  host first
  //     if (userService.localUserInfo.userID != roomService.roomInfo.hostID) {
  //       toUserList.add(roomService.roomInfo.hostID); //  host must be a speaker
  //     }
  //     for (var speakerID in seatService.speakerIDSet) {
  //       if (userService.localUserInfo.userID == speakerID) {
  //         continue; // ignore self
  //       }
  //       toUserList.add(speakerID);
  //     }
  //   } else {
  //     toUserList.add(selectedUser.userID);
  //   }
  //   giftService
  //       .sendGift(roomService.roomInfo.roomID, userService.localUserInfo.userID,
  //           selectedRoomGift.value.id.toString(), toUserList)
  //       .then((errorCode) {
  //     if (0 != errorCode) {
  //       Fluttertoast.showToast(
  //           msg: AppLocalizations.of(context)!.toastSendGiftError(errorCode),
  //           backgroundColor: Colors.grey);
  //     } else {
  //       // hide the page
  //       Navigator.pop(context);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint("USERID IN GIFT BOTTOM: $userGiftID");
    final selectedUserNameCtrl = useTextEditingController();

    final _areFieldsEmpty = useState<bool>(true);
    useEffect(() {
      selectedUserNameCtrl.addListener(() {
        _areFieldsEmpty.value = selectedUserNameCtrl.text.toString().isEmpty;
        /*
        selectedUserNameCtrl.text.toString() ==
            AppLocalizations.of(context)!.roomPageSelectAllSpeakers
        * */
        //selectedUserNameCtrl.text.toString().isEmpty;
        //AppLocalizations.of(context)!
        //                                     .roomPageSelectDefault
      });
    }, [selectedUserNameCtrl]);

    return Container(
      alignment: Alignment.center,
      width: size.width * 0.95,
      margin: EdgeInsets.only(
          left: getHorizontalSize(15),
          top: getVerticalSize(5),
          right: getHorizontalSize(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/img_group8997.png",
            width: getHorizontalSize(30),
            height: getVerticalSize(30),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       top: getVerticalSize(8), right: getHorizontalSize(4)),
          //   child: Text(
          //     "0",
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w600,
          //         fontSize: getFontSize(20)),
          //   ),
          // ),
          UsersDiamondBottom(
              selectedRoomGift: selectedRoomGift, userIdGift: userGiftID),
          // GestureDetector(
          //   onTap: () {
          //     // // UNCOMMENT THIS WHEN BACK FUNCTIONALITY IS MADE FOR THE ROOM SCREEN
          //     // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const WalletScreen()));
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(top: getVerticalSize(8)),
          //     child: const Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.white,
          //       size: 13,
          //     ),
          //   ),
          // ),
          // const Expanded(child: Text("")),
          // ItemGiftSelectSend(
          //     selectedRoomGift: selectedRoomGift, userIdGift: userGiftID),
          // Container(
          //   width: getHorizontalSize(60),
          //   height: getVerticalSize(30),
          //   padding: EdgeInsets.only(
          //       left: getHorizontalSize(20), right: getHorizontalSize(6)),
          //   decoration: const BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(15),
          //           bottomLeft: Radius.circular(15)),
          //       gradient: LinearGradient(
          //           colors: [Colors.black12, Colors.black12],
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight)),
          //   alignment: Alignment.center,
          //   child: DropdownButton(
          //     value: dropdownvalue,
          //     iconSize: 20,
          //     isExpanded: true,
          //     dropdownColor: Colors.white.withOpacity(0.5),
          //     icon: const Icon(
          //       Icons.keyboard_arrow_down,
          //       color: Colors.white,
          //     ),
          //     items: items.map((String items) {
          //       return DropdownMenuItem(
          //         value: items,
          //         child: Text(
          //           items,
          //           style: const TextStyle(color: Colors.white),
          //         ),
          //       );
          //     }).toList(),
          //     onChanged: (String? newValue) {
          //       dropdownvalue = newValue!;
          //     },
          //     underline: DropdownButtonHideUnderline(
          //       child: Container(),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     margin: EdgeInsets.only(right: getHorizontalSize(20)),
          //     width: getHorizontalSize(45),
          //     height: getVerticalSize(28),
          //     decoration: const BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(15),
          //             bottomRight: Radius.circular(15)),
          //         gradient: LinearGradient(
          //             colors: [Color(0xFF1000C6), Color(0xFFC600BE)],
          //             begin: Alignment.topLeft,
          //             end: Alignment.bottomRight)),
          //     alignment: Alignment.center,
          //     child: const Text(
          //       "Send",
          //       style:
          //           TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          //     ),
          //   ),
          // )
          //     ],
          //   ),
          // );

          //   SizedBox(
          //   height: 80.w,
          //   width: double.infinity,
          //   child: Row(
          //     children: [
          //       Container(
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: StyleColors.giftMemberListBackgroundColor,
          //               style: BorderStyle.solid,
          //               width: 1.0,
          //             ),
          //             color: StyleColors.giftMemberListBackgroundColor,
          //             borderRadius: BorderRadius.circular(24.0),
          //           ),
          //           width: 475.w,
          //           height: 80.h,
          //           padding: EdgeInsets.only(
          //               left: 36.w, top: 0, right: 0, bottom: 3 /*magic num.*/),
          //           child: Row(
          //             children: [
          //               SizedBox(
          //                   width: 318.w,
          //                   height: 80.h,
          //                   child: GestureDetector(
          //                       onTap: () {
          //                         showMemberList(context, selectedUserNameCtrl);
          //                       },
          //                       child: AbsorbPointer(
          //                           child: Center(
          //                               child: TextFormField(
          //                         readOnly: true,
          //                         textAlign: TextAlign.left,
          //                         maxLines: 1,
          //                         style: StyleConstant.roomGiftInputText,
          //                         decoration: InputDecoration(
          //                             isDense: true,
          //                             contentPadding: EdgeInsets.zero,
          //                             border: InputBorder.none,
          //                             hintStyle: StyleConstant.roomGiftInputText,
          //                             hintText: AppLocalizations.of(context)!
          //                                 .roomPageSelectDefault),
          //                         controller: selectedUserNameCtrl,
          //                       ))))),
          //               const Expanded(child: Text('')),
          //               IconButton(
          //                   onPressed: () =>
          //                       showMemberList(context, selectedUserNameCtrl),
          //                   icon: Image.asset(StyleIconUrls.roomMemberDropDownArrow))
          //             ],
          //           )),
          //       const Expanded(child: Text('')),
          //       SizedBox(
          //           width: 180.w,
          //           height: 80.h,
          //           child: GestureDetector(
          //             onTap: () => selectedUser.isEmpty() ? null : sendGift(context),
          //             child: Container(
          //               decoration: BoxDecoration(
          //                   color: _areFieldsEmpty.value
          //                       ? StyleColors.blueButtonDisableColor
          //                       : StyleColors.blueButtonEnabledColor,
          //                   borderRadius:
          //                       const BorderRadius.all(Radius.circular(12))),
          //               padding: const EdgeInsets.only(
          //                   left: 10, right: 10, top: 10, bottom: 10),
          //               alignment: Alignment.center,
          //               child: Text(
          //                 AppLocalizations.of(context)!.roomPageSendGift,
          //                 style: StyleConstant.roomGiftSendButtonText,
          //               ),
          //             ),
          //           ))
        ],
      ),
    );
  }
}
