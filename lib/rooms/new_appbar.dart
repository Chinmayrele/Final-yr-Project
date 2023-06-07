import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/rooms/show_invite_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../model/user_model.dart';
import '../providers/info_providers.dart';
import '../service/zego_room_service.dart';

class NewAppBar extends StatefulWidget {
  const NewAppBar({
    Key? key,
    required this.refreshWid,
    required this.scafffold,
    required this.roomName,
    required this.roomID,
    required this.hostId,
    required this.hostName,
    required this.imagePick,
  }) : super(key: key);
  final void Function(GlobalKey<ScaffoldState> scaff) refreshWid;
  final GlobalKey<ScaffoldState> scafffold;
  final String roomName;
  final String roomID;
  final String hostName;
  final String hostId;
  final String imagePick;

  @override
  State<NewAppBar> createState() => _NewAppBarState();
}

class _NewAppBarState extends State<NewAppBar> {
  List<dynamic> friendsListIds = [];
  List<UserBasicModel> friendsList = [];
  bool isLoading = true;
  @override
  void initState() {
    final result = Provider.of<InfoProviders>(context, listen: false);
    result
        .callCurrentUserFollowData(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      final followingList = (value['following'] as List);
      debugPrint(
          "FOLLOWINF LIST LENGTH IN NEW APPBAR: ${followingList.length}");
      // final followerslist = (value['followers'] as List);
      // friendsListIds.clear();
      // for (int i = 0; i < followerslist.length; i++) {
      //   for (int j = 0; j < followingList.length; j++) {
      //     if ((followerslist[i]) == followingList[j]) {
      //       friendsListIds.add(followerslist[i]);
      //     }
      //   }
      // }
      result.fetchUserDataByIds(followingList).then((_) {
        friendsList.clear();
        friendsList = result.usersDataByIds;
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              top: getVerticalSize(
                12,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: getSize(
                      16.82,
                    ),
                    width: getSize(
                      16.82,
                    ),
                    margin: EdgeInsets.only(
                        left: getHorizontalSize(15),
                        top: getVerticalSize(12),
                        right: getHorizontalSize(15)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: getHorizontalSize(142),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<ZegoRoomService>(
                        builder: (context, roomService, child) => Text(
                          roomService.roomInfo.roomName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorConstant.whiteA700,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {});
                      //   },
                      //   child: Text(
                      //     "Party Room Name",
                      //     overflow: TextOverflow.ellipsis,
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //       color: ColorConstant.whiteA700,
                      //       fontSize: getFontSize(
                      //         18,
                      //       ),
                      //       fontFamily: 'Roboto',
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      Consumer<ZegoRoomService>(
                        builder: (context, roomService, child) => Text(
                          "ID:" + roomService.roomInfo.roomID,
                          style: const TextStyle(
                            color: Color(0xFF606060),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     top: getVerticalSize(
                      //       4.00,
                      //     ),
                      //   ),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       setState(() {});
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           child: RichText(
                      //             text: TextSpan(
                      //               children: [
                      //                 TextSpan(
                      //                   text: 'Id',
                      //                   style: TextStyle(
                      //                     color:
                      //                         ColorConstant.whiteA700,
                      //                     fontSize: getFontSize(
                      //                       13,
                      //                     ),
                      //                     fontFamily: 'Roboto',
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //                 TextSpan(
                      //                   text: ' : gh3456789',
                      //                   style: TextStyle(
                      //                     color:
                      //                         ColorConstant.whiteA700,
                      //                     fontSize: getFontSize(
                      //                       13,
                      //                     ),
                      //                     fontFamily: 'Roboto',
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsets.only(
                      //             left: getHorizontalSize(
                      //               6.00,
                      //             ),
                      //           ),
                      //           child: Container(
                      //             height: getVerticalSize(
                      //               11.00,
                      //             ),
                      //             width: getHorizontalSize(
                      //               10.00,
                      //             ),
                      //             child: SvgPicture.asset(
                      //               ImageConstant.imgVector5,
                      //               fit: BoxFit.fill,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: GestureDetector(
                //     onTap: () {
                //       setState(() {});
                //     },
                //     child: Container(
                //       margin: EdgeInsets.only(left: getHorizontalSize(70)),
                //       height: getSize(
                //         28.60,
                //       ),
                //       width: getSize(
                //         28.60,
                //       ),
                //       child: SvgPicture.asset(
                //         ImageConstant.imgGroup1324,
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 80),
                GestureDetector(
                  onTap: () {
                    showInviteSheet(
                      context,
                      friendsList,
                      widget.roomName,
                      widget.roomID,
                      widget.hostName,
                      widget.hostId,
                      widget.imagePick,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        9.00,
                      ),
                    ),
                    child: SizedBox(
                      height: getSize(
                        28.60,
                      ),
                      width: getSize(
                        28.00,
                      ),
                      child: SvgPicture.asset(
                        ImageConstant.imgGroup1317,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                // END DRAWER
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.refreshWid(widget.scafffold);
                    });
                    // Scaffold.of(context).openEndDrawer();
                    // isEndDrawer ?
                    // _scaffoldKey.currentState!.openEndDrawer();
                    // : _scaffoKey.currentState!.openEndDrawer();
                    // setState(() {
                    //   setting = !setting;
                    // });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        9.00,
                      ),
                      bottom: getVerticalSize(
                        2.53,
                      ),
                    ),
                    child: SizedBox(
                      height: getVerticalSize(
                        26.07,
                      ),
                      width: getHorizontalSize(
                        27.76,
                      ),
                      child: SvgPicture.asset(
                        ImageConstant.imgGroup1316,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
