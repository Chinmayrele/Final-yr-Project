import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/roompages/room/gift/room_gift_member_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/math_utils.dart';
import '../../../localization/localisation.dart';
import '../../../model/zego_room_gift.dart';
import '../../../model/zego_user_info.dart';
import '../../../service/zego_gift_service.dart';
import '../../../service/zego_room_service.dart';
import '../../../service/zego_speaker_seat_service.dart';
import '../../../service/zego_user_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

class UsersDiamondBottom extends StatefulWidget {
  UsersDiamondBottom(
      {Key? key, required this.selectedRoomGift, required this.userIdGift})
      : super(key: key);
  ValueNotifier<ZegoRoomGift> selectedRoomGift;
  final String userIdGift;

  @override
  State<UsersDiamondBottom> createState() => _UsersDiamondBottomState();
}

class _UsersDiamondBottomState extends State<UsersDiamondBottom> {
  late int usersDiamond;
  bool isLoading = true;
  String dropdownvalue = '1';

  ZegoUserInfo selectedUser = ZegoUserInfo.empty();

  void sendGift(BuildContext context) {
    // if (selectedUser.isEmpty() ||
    //     userIDOfNoSpeakerUser == selectedUser.userID) {
    //   return;
    // }
    if (widget.userIdGift.isEmpty ||
        userIDOfNoSpeakerUser == selectedUser.userID) {
      return;
    }
    var giftService = context.read<ZegoGiftService>();
    var userService = context.read<ZegoUserService>();
    var roomService = context.read<ZegoRoomService>();
    var seatService = context.read<ZegoSpeakerSeatService>();
    List<String> toUserList = [];
    if (userIDOfAllSpeaker == widget.userIdGift) {
      //  host first
      if (userService.localUserInfo.userID != roomService.roomInfo.hostID) {
        toUserList.add(roomService.roomInfo.hostID); //  host must be a speaker
      }
      for (var speakerID in seatService.speakerIDSet) {
        if (userService.localUserInfo.userID == speakerID) {
          continue; // ignore self
        }
        toUserList.add(speakerID);
      }
    } else {
      toUserList.add(widget.userIdGift);
    }
    giftService
        .sendGift(roomService.roomInfo.roomID, userService.localUserInfo.userID,
            widget.selectedRoomGift.value.id.toString(), toUserList, context)
        .then((errorCode) {
      if (0 != errorCode) {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.toastSendGiftError(errorCode),
            backgroundColor: Colors.grey);
      } else {
        // hide the page
        FirebaseFirestore.instance
            .collection('hostRoomData')
            .doc(roomService.roomInfo.hostID)
            .update({'roomCharisma': FieldValue.increment(10)}).then((_) {
          FirebaseFirestore.instance
              .collection('UsersDiamond')
              .doc(roomService.roomInfo.hostID)
              .update({"diamond": FieldValue.increment(2)}).then(
                  (value) => Navigator.pop(context));
        });
      }
    });
  }

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
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('UsersDiamond')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final e = value.data();
      usersDiamond = e!['diamond'];
      debugPrint("DIAMONDSSSSSSSSSSSSSSSS: $usersDiamond");
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
        : Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: getVerticalSize(8), right: getHorizontalSize(4)),
                child: Text(
                  usersDiamond.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: getFontSize(20)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // // UNCOMMENT THIS WHEN BACK FUNCTIONALITY IS MADE FOR THE ROOM SCREEN
                  // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const WalletScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.only(top: getVerticalSize(8)),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
              // const Spacer(),
              SizedBox(width: size.width * 0.37),
              // const Expanded(child: Text("")),
              Container(
                width: getHorizontalSize(60),
                height: getVerticalSize(30),
                padding: EdgeInsets.only(
                    left: getHorizontalSize(20), right: getHorizontalSize(6)),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    gradient: LinearGradient(
                        colors: [Colors.black12, Colors.black12],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                alignment: Alignment.center,
                child: DropdownButton(
                  value: dropdownvalue,
                  iconSize: 20,
                  isExpanded: true,
                  dropdownColor: Colors.white.withOpacity(0.5),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  underline: DropdownButtonHideUnderline(
                    child: Container(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //CHECK FIRST WHAT TO DO REALLY
                  sendGift(context);
                },
                child: Container(
                  margin: EdgeInsets.only(right: getHorizontalSize(20)),
                  width: getHorizontalSize(45),
                  height: getVerticalSize(28),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                          colors: [Color(0xFF1000C6), Color(0xFFC600BE)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Send",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          );
  }
}
