import 'package:final_yr_project/roompages/room/gift/room_gift_bottom_bar.dart';
import 'package:final_yr_project/roompages/room/gift/room_gift_selector.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/math_utils.dart';
import '../../../model/user_model.dart';
import '../../../model/zego_room_gift.dart';
import '../../../model/zego_user_info.dart';
import '../../../providers/info_providers.dart';
import '../../../service/zego_user_service.dart';

class GiveGift extends StatefulWidget {
  GiveGift({Key? key, required this.refreshFn, required this.selectedRoomGift})
      : super(key: key);
  final void Function(String userId) refreshFn;
  ValueNotifier<ZegoRoomGift> selectedRoomGift;

  @override
  State<GiveGift> createState() => _GiveGiftState();
}

class _GiveGiftState extends State<GiveGift>
    with SingleTickerProviderStateMixin {
  int giftSelect = -1;
  bool isLoading = true;
  late TabController _controller;

  List<UserBasicModel> usersDataList = [];
  @override
  void initState() {
    _controller = TabController(length: list.length, vsync: this);
    var userService = Provider.of<ZegoUserService>(context, listen: false);
    final result = Provider.of<InfoProviders>(context, listen: false);
    List<ZegoUserInfo> userIds = userService.userList;
    result.fetchUsersProfileDataforGifts(userIds).then((value) {
      usersDataList.clear();
      usersDataList = result.usersProfileDataforGifts;
      setState(() {
        isLoading = false;
      });
    });
    //FETCH GIFTS FROM ADMIN PANEL HERE ONLY AND PASS BY CONSTRUCTOR TO RoomGiftSelector PAGE
    
    super.initState();
  }

  final List<Widget> list = [
    const Tab(
      text: "Classic",
    ),
    const Tab(
      text: "Events",
    ),
    const Tab(
      text: "Privilege",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: getVerticalSize(5), left: getHorizontalSize(10)),
                    width: getHorizontalSize(300),
                    height: getVerticalSize(35),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: usersDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                giftSelect = index;
                                // RETURN USERID OF THE USER SELECTED
                                widget.refreshFn(usersDataList[index].userId);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: giftSelect == index
                                          ? ColorConstant.deepPurple900
                                          : Colors.transparent,
                                      width: 2)),
                              margin:
                                  EdgeInsets.only(right: getHorizontalSize(6)),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage(usersDataList[index].imageUrl),
                                // backgroundImage: AssetImage(okok[index]["image"]),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: getVerticalSize(4)),
                      height: getVerticalSize(40),
                      width: getHorizontalSize(50),
                      child: Center(
                          child: Text("All",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(18))))),
                ],
              ),
              GlassmorphicContainer(
                margin: EdgeInsets.only(
                    top: getVerticalSize(1),
                    left: getHorizontalSize(3),
                    right: getHorizontalSize(3)),
                width: getHorizontalSize(360),
                height: 2,
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
                height: 40,
                width: getHorizontalSize(195),
                margin: EdgeInsets.only(left: getHorizontalSize(10)),
                child: TabBar(
                  controller: _controller,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorWeight: 0,
                  indicator: const BoxDecoration(),
                  unselectedLabelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: getFontSize(16),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: getFontSize(17),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: list,
                ),
              ),
              RoomGiftSelector(selectedRoomGift: widget.selectedRoomGift),
              RoomGiftBottomBar(
                  selectedRoomGift: widget.selectedRoomGift,
                  userGiftID:
                      giftSelect == -1 ? "" : usersDataList[giftSelect].userId)
            ],
          );
  }
}
