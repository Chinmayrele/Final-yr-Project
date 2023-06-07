// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol_app_infi/rooms/show_admin_mute_setting.dart';
// import 'package:lol_app_infi/rooms/show_invite_sheet.dart';
// import 'package:lol_app_infi/rooms/show_today_sheet.dart';
// import 'package:lol_app_infi/rooms/today.dart';
// import 'package:provider/provider.dart';
// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/math_utils.dart';
// import '../service/zego_room_service.dart';
// import 'drawer.dart';
// import 'drawer_admin.dart';
// import 'invite firnds.dart';
// import 'namewidget.dart';
// import 'online.dart';
// import 'othersprofiel.dart';

// class Start extends StatefulWidget {
//   const Start({Key? key}) : super(key: key);

//   @override
//   State<Start> createState() => _StartState();
// }

// class _StartState extends State<Start> {
//   // bool username = false;
//   // bool other = false;
//   bool invite = false;
//   // bool online = false;
//   bool today = false;
//   bool admin = false;
//   // bool setting = false;
//   bool mic = false;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _scaffoKey = GlobalKey<ScaffoldState>();
//   bool isEndDrawer = true;

//   List choices = [
//     {"title": "Amit", "image": ImageConstant.imgUnsplashvvewjj, "type": "host"},
//     {
//       "title": "Name",
//       "image": ImageConstant.imgUnsplashvvewjj1,
//       "type": "user"
//     },
//     {"title": "No.3", "image": ImageConstant.imgComponent, "type": "user"},
//     {"title": "No.4", "image": ImageConstant.imgComponent, "type": "user"},
//     {"title": "No.5", "image": ImageConstant.imgComponent, "type": "user"},
//     {"title": "No.6", "image": ImageConstant.imgComponent, "type": "user"},
//     {"title": "No.7", "image": ImageConstant.imgComponent, "type": "user"},
//     {"title": "No.8", "image": ImageConstant.imgComponent, "type": "user"},
//   ];

//   final TextEditingController _controller = TextEditingController();

//   _refreshWidget(GlobalKey<ScaffoldState> scaff) {
//     // setState(() {
//     isEndDrawer = !isEndDrawer;
//     // });
//     scaff.currentState!.openEndDrawer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("IS END DRAWER VALUE: $isEndDrawer");
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         endDrawer:
//             EndDrawer(refreshWid: _refreshWidget, scaffKey: _scaffoldKey, hostId: 'qwertyuikjhgf'),
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             Image.asset(
//               ImageConstant.img1dhckghtzdumti,
//               height: getVerticalSize(776.00),
//               width: getHorizontalSize(360.00),
//               fit: BoxFit.fill,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: getVerticalSize(
//                           12,
//                         ),
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Container(
//                               height: getSize(
//                                 16.82,
//                               ),
//                               width: getSize(
//                                 16.82,
//                               ),
//                               margin: EdgeInsets.only(
//                                   left: getHorizontalSize(15),
//                                   top: getVerticalSize(12),
//                                   right: getHorizontalSize(15)),
//                               child: const Icon(
//                                 Icons.arrow_back,
//                                 color: Colors.white,
//                               )),
//                           SizedBox(
//                             width: getHorizontalSize(142),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Consumer<ZegoRoomService>(
//                                   builder: (context, roomService, child) =>
//                                       Text(
//                                     roomService.roomInfo.roomName,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Color(0xFF1B1B1B),
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 32,
//                                     ),
//                                   ),
//                                 ),
//                                 // GestureDetector(
//                                 //   onTap: () {
//                                 //     setState(() {});
//                                 //   },
//                                 //   child: Text(
//                                 //     "Party Room Name",
//                                 //     overflow: TextOverflow.ellipsis,
//                                 //     textAlign: TextAlign.left,
//                                 //     style: TextStyle(
//                                 //       color: ColorConstant.whiteA700,
//                                 //       fontSize: getFontSize(
//                                 //         18,
//                                 //       ),
//                                 //       fontFamily: 'Roboto',
//                                 //       fontWeight: FontWeight.w600,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 Consumer<ZegoRoomService>(
//                                   builder: (context, roomService, child) =>
//                                       Text(
//                                     "ID:" + roomService.roomInfo.roomID,
//                                     style: const TextStyle(
//                                       color: Color(0xFF606060),
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                                 // Padding(
//                                 //   padding: EdgeInsets.only(
//                                 //     top: getVerticalSize(
//                                 //       4.00,
//                                 //     ),
//                                 //   ),
//                                 //   child: GestureDetector(
//                                 //     onTap: () {
//                                 //       setState(() {});
//                                 //     },
//                                 //     child: Row(
//                                 //       children: [
//                                 //         Container(
//                                 //           child: RichText(
//                                 //             text: TextSpan(
//                                 //               children: [
//                                 //                 TextSpan(
//                                 //                   text: 'Id',
//                                 //                   style: TextStyle(
//                                 //                     color:
//                                 //                         ColorConstant.whiteA700,
//                                 //                     fontSize: getFontSize(
//                                 //                       13,
//                                 //                     ),
//                                 //                     fontFamily: 'Roboto',
//                                 //                     fontWeight: FontWeight.w500,
//                                 //                   ),
//                                 //                 ),
//                                 //                 TextSpan(
//                                 //                   text: ' : gh3456789',
//                                 //                   style: TextStyle(
//                                 //                     color:
//                                 //                         ColorConstant.whiteA700,
//                                 //                     fontSize: getFontSize(
//                                 //                       13,
//                                 //                     ),
//                                 //                     fontFamily: 'Roboto',
//                                 //                     fontWeight: FontWeight.w500,
//                                 //                   ),
//                                 //                 ),
//                                 //               ],
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //         Padding(
//                                 //           padding: EdgeInsets.only(
//                                 //             left: getHorizontalSize(
//                                 //               6.00,
//                                 //             ),
//                                 //           ),
//                                 //           child: Container(
//                                 //             height: getVerticalSize(
//                                 //               11.00,
//                                 //             ),
//                                 //             width: getHorizontalSize(
//                                 //               10.00,
//                                 //             ),
//                                 //             child: SvgPicture.asset(
//                                 //               ImageConstant.imgVector5,
//                                 //               fit: BoxFit.fill,
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {});
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(
//                                     left: getHorizontalSize(70)),
//                                 height: getSize(
//                                   28.60,
//                                 ),
//                                 width: getSize(
//                                   28.60,
//                                 ),
//                                 child: SvgPicture.asset(
//                                   ImageConstant.imgGroup1324,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               showAdminMuteSetting(
//                                   context, "roomName", "roomId");
//                               // showInviteSheet(context, []);
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   9.00,
//                                 ),
//                               ),
//                               child: SizedBox(
//                                 height: getSize(
//                                   28.60,
//                                 ),
//                                 width: getSize(
//                                   28.00,
//                                 ),
//                                 child: SvgPicture.asset(
//                                   ImageConstant.imgGroup1317,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // END DRAWER
//                           GestureDetector(
//                             onTap: () {
//                               // isEndDrawer ?
//                               _scaffoldKey.currentState!.openEndDrawer();
//                               // : _scaffoKey.currentState!.openEndDrawer();
//                               // setState(() {
//                               //   setting = !setting;
//                               // });
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   9.00,
//                                 ),
//                                 bottom: getVerticalSize(
//                                   2.53,
//                                 ),
//                               ),
//                               child: SizedBox(
//                                 height: getVerticalSize(
//                                   26.07,
//                                 ),
//                                 width: getHorizontalSize(
//                                   27.76,
//                                 ),
//                                 child: SvgPicture.asset(
//                                   ImageConstant.imgGroup1316,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: size.width,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               // showTodaySheet(context);
//                               // setState(() {
//                               //   today = !today;
//                               // });
//                             },
//                             child: Container(
//                               child: Stack(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: getVerticalSize(12),
//                                         left: getHorizontalSize(8)),
//                                     child: Image.asset(
//                                       ImageConstant.imgTrophy,
//                                       height: getVerticalSize(
//                                         29.44,
//                                       ),
//                                       width: getHorizontalSize(
//                                         26.07,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(
//                                         top: getVerticalSize(15)),
//                                     padding: EdgeInsets.only(
//                                       left: getHorizontalSize(
//                                         40.00,
//                                       ),
//                                       right: getHorizontalSize(
//                                         10.00,
//                                       ),
//                                       top: getVerticalSize(
//                                         3,
//                                       ),
//                                       bottom: getVerticalSize(
//                                         2.0,
//                                       ),
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: ColorConstant.black90026,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(
//                                           getHorizontalSize(
//                                             0.00,
//                                           ),
//                                         ),
//                                         topRight: Radius.circular(
//                                           getHorizontalSize(
//                                             18.50,
//                                           ),
//                                         ),
//                                         bottomLeft: Radius.circular(
//                                           getHorizontalSize(
//                                             0.00,
//                                           ),
//                                         ),
//                                         bottomRight: Radius.circular(
//                                           getHorizontalSize(
//                                             18.50,
//                                           ),
//                                         ),
//                                       ),
//                                       border: Border.all(
//                                         color: ColorConstant.black90019,
//                                         width: getHorizontalSize(
//                                           1.00,
//                                         ),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       "12.8 M",
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: ColorConstant.whiteA700,
//                                         fontSize: getFontSize(
//                                           14,
//                                         ),
//                                         fontFamily: 'Roboto',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // StreamBuilder<QuerySnapshot>(
//                           //   stream: FirebaseFirestore.instance
//                           //       .collection('followList')
//                           //       .snapshots(),
//                           //   builder: (ctx, snapshots) {
//                           //     if (snapshots.hasData) {
//                           //       final onlineDocs = snapshots.data!.docs;
//                           //       return Container(
//                           //         margin: EdgeInsets.only(
//                           //             left: getHorizontalSize(220),
//                           //             top: getVerticalSize(10)),
//                           //         decoration: BoxDecoration(
//                           //           color: Colors.white12.withOpacity(0.1),
//                           //           borderRadius: BorderRadius.only(
//                           //             topLeft: Radius.circular(
//                           //               getHorizontalSize(18.50),
//                           //             ),
//                           //             topRight: Radius.circular(
//                           //               getHorizontalSize(0.0),
//                           //             ),
//                           //             bottomLeft: Radius.circular(
//                           //               getHorizontalSize(18.50),
//                           //             ),
//                           //             bottomRight: Radius.circular(
//                           //               getHorizontalSize(0.0),
//                           //             ),
//                           //           ),
//                           //           border: Border.all(
//                           //             color: ColorConstant.black90019,
//                           //             width: getHorizontalSize(1.00),
//                           //           ),
//                           //         ),
//                           //         child: GestureDetector(
//                           //           onTap: () {
//                           //             showOnlineSheet(context);
//                           //             // setState(() {
//                           //             //   online = !online;
//                           //             // });
//                           //           },
//                           //           child: Row(
//                           //             crossAxisAlignment:
//                           //                 CrossAxisAlignment.start,
//                           //             mainAxisSize: MainAxisSize.min,
//                           //             children: [
//                           //               Padding(
//                           //                 padding: EdgeInsets.only(
//                           //                   left: getHorizontalSize(11.00),
//                           //                   top: getVerticalSize(5.00),
//                           //                   bottom: getVerticalSize(6.35),
//                           //                 ),
//                           //                 child: Container(
//                           //                   height: getVerticalSize(10.6),
//                           //                   width: getHorizontalSize(10.6),
//                           //                   child: SvgPicture.asset(
//                           //                     ImageConstant.imgVector1,
//                           //                     fit: BoxFit.fill,
//                           //                     color: Colors.white,
//                           //                   ),
//                           //                 ),
//                           //               ),
//                           //               Padding(
//                           //                 padding: EdgeInsets.only(
//                           //                   left: getHorizontalSize(3.34),
//                           //                   top: getVerticalSize(3.00),
//                           //                   right: getHorizontalSize(6.00),
//                           //                   bottom: getVerticalSize(4.00),
//                           //                 ),
//                           //                 child: Text(
//                           //                   onlineDocs.length.toString(),
//                           //                   // "12",
//                           //                   overflow: TextOverflow.ellipsis,
//                           //                   textAlign: TextAlign.left,
//                           //                   style: TextStyle(
//                           //                     color: ColorConstant.whiteA700,
//                           //                     fontSize: getFontSize(
//                           //                       12.5,
//                           //                     ),
//                           //                     fontFamily: 'Roboto',
//                           //                     fontWeight: FontWeight.w500,
//                           //                   ),
//                           //                 ),
//                           //               ),
//                           //             ],
//                           //           ),
//                           //         ),
//                           //       );
//                           //     } else {
//                           //       return const Center(
//                           //         child: CircularProgressIndicator(
//                           //           color: Colors.pink,
//                           //         ),
//                           //       );
//                           //     }
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: getVerticalSize(190),
//                       width: size.width,
//                       margin: EdgeInsets.only(
//                           left: getHorizontalSize(25),
//                           top: getVerticalSize(10)),
//                       child: GridView.count(
//                         crossAxisCount: 4,
//                         crossAxisSpacing: getHorizontalSize(5),
//                         mainAxisSpacing: getVerticalSize(10),
//                         children: List.generate(8, (index) {
//                           return NameRoom(
//                             title: choices[index]["title"],
//                             image: choices[index]["image"],
//                             type: choices[index]["type"],
//                             index: index,
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SingleChildScrollView(
//                   reverse: true,
//                   child: Column(
//                     children: [
//                       GlassmorphicContainer(
//                         borderRadius: 0,
//                         height: getVerticalSize(55),
//                         width: size.width,
//                         blur: 6,
//                         alignment: Alignment.bottomCenter,
//                         border: 1,
//                         linearGradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               const Color(0xFFffffff).withOpacity(0.1),
//                               const Color(0xFFFFFFFF).withOpacity(0.05),
//                             ],
//                             stops: const [
//                               0.1,
//                               1,
//                             ]),
//                         borderGradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Colors.white10.withOpacity(0.05),
//                             Colors.white10.withOpacity(0.05),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: getHorizontalSize(
//                                 15,
//                               ),
//                               bottom: getVerticalSize(10)),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Neumorphic(
//                                 style: NeumorphicStyle(
//                                   depth: -3,
//                                   color: Colors.black12.withOpacity(0.15),
//                                   border: NeumorphicBorder(
//                                       width: 0.5,
//                                       color: Colors.black12.withOpacity(0.1)),
//                                   boxShape: NeumorphicBoxShape.stadium(),
//                                 ),
//                                 child: SizedBox(
//                                   width: getHorizontalSize(220),
//                                   height: getVerticalSize(32),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: getHorizontalSize(150),
//                                         child: TextField(
//                                           textAlign: TextAlign.center,
//                                           controller: _controller,
//                                           decoration: InputDecoration(
//                                             hintText: "Send Message..."
//                                                 "",
//                                             hintStyle: TextStyle(
//                                                 color: Colors.grey.shade600,
//                                                 fontSize: getSize(12)),
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets.only(
//                                                 bottom: getVerticalSize(20)),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             right: getHorizontalSize(5)),
//                                         child: Image.asset(
//                                           ImageConstant.imgFlushedemojii,
//                                           height: getVerticalSize(
//                                             22.00,
//                                           ),
//                                           width: getHorizontalSize(
//                                             22.00,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                     margin: EdgeInsets.only(
//                                         left: getHorizontalSize(20)),
//                                     child: Icon(
//                                       mic ? Icons.mic : Icons.mic_off,
//                                       color: Colors.white,
//                                       size: 25,
//                                     )),
//                               ),
//                               Container(
//                                 height: getSize(
//                                   32.00,
//                                 ),
//                                 width: getSize(
//                                   34.00,
//                                 ),
//                                 margin: EdgeInsets.only(
//                                     left: getHorizontalSize(25)),
//                                 decoration: BoxDecoration(
//                                   color: ColorConstant.whiteA700,
//                                   borderRadius: BorderRadius.circular(
//                                     getHorizontalSize(
//                                       17.00,
//                                     ),
//                                   ),
//                                 ),
//                                 child: Card(
//                                   clipBehavior: Clip.antiAlias,
//                                   elevation: 0,
//                                   margin: const EdgeInsets.all(0),
//                                   color: ColorConstant.whiteA700,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                       getHorizontalSize(
//                                         17.00,
//                                       ),
//                                     ),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.center,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                             left: getHorizontalSize(
//                                               3.90,
//                                             ),
//                                             top: getVerticalSize(
//                                               3.89,
//                                             ),
//                                             right: getHorizontalSize(
//                                               4.77,
//                                             ),
//                                             bottom: getVerticalSize(
//                                               2.91,
//                                             ),
//                                           ),
//                                           child: Image.asset(
//                                             ImageConstant.imgHandmadeexplos,
//                                             height: getVerticalSize(
//                                               27.20,
//                                             ),
//                                             width: getHorizontalSize(
//                                               25.33,
//                                             ),
//                                             fit: BoxFit.fill,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             bottom: MediaQuery.of(context).viewInsets.bottom),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             // username
//             //     ? Align(
//             //         alignment: Alignment.bottomCenter,
//             //         // child: showModalSht(context),
//             //         child: InviteFriends(),
//             //       )
//             //     : Container(
//             //         height: 1,
//             //       ),
//             // other
//             //     ? const Align(
//             //         alignment: Alignment.bottomCenter, child: OtherProfile())
//             //     : Container(
//             //         height: 1,
//             //       ),
//             invite
//                 ? const Align(
//                     alignment: Alignment.bottomCenter, child: Inviting())
//                 : Container(
//                     height: 1,
//                   ),
//             // online
//             //     ? const Align(
//             //         alignment: Alignment.bottomCenter, child: Online())
//             //     : Container(
//             //         height: 1,
//             //       ),
//             // today
//             //     ? const Align(alignment: Alignment.bottomCenter, child: Today())
//             //     : Container(
//             //         height: 1,
//             //       ),
//             // admin
//             //     ? Container(
//             //         alignment: Alignment.center, child: const RoomAdmin())
//             //     : Container(
//             //         height: 1,
//             //       ),
//             // setting
//             //     ? Align(
//             //         alignment: Alignment.topRight,
//             //         child: RoomSetting(function: goToPreviousItem))
//             //     : Container(
//             //         height: 1,
//             //       ),
//           ],
//         ),
//       ),
//     );
//   }

//   // goToPreviousItem(bool value, bool val) {
//   //   return setState(() {
//   //     admin = value;
//   //     setting = val;
//   //   });
//   // }

//   // usersFun(bool value, bool val) {
//   //   return setState(() {
//   //     username = value;
//   //     other = val;
//   //   });
//   // }
// }
