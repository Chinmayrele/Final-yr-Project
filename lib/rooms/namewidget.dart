// import 'dart:ffi';

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:lol_app_infi/rooms/showModalSheet.dart';
// import 'package:lol_app_infi/rooms/showOtherSheet.dart';

// import '../constants/zego_room_constant.dart';
// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/math_utils.dart';

// class NameRoom extends StatefulWidget {
//   const NameRoom({
//     Key? key,
//     required this.title,
//     required this.index,
//     required this.image,
//     required this.type,
//   }) : super(key: key);

//   final int index;
//   final String title;
//   final String image;
//   final String type;

//   @override
//   State<NameRoom> createState() => _NameRoomState();
// }

// class _NameRoomState extends State<NameRoom> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//             //   widget.type == 'host'
//             //       ? showModalSht(
//             //           context, 'ID', 'Name', ZegoSpeakerSeatStatus.closed)
//             //       : showOtherModalSht(
//             //           context, 'Id', 'NAME', ZegoSpeakerSeatStatus.closed);
//             //   // ? widget.function(true, false)

//             //   // : widget.function(false, true);
//             },
//             child: widget.image == ImageConstant.imgComponent
//                 ? DropdownButtonHideUnderline(
//                     child: DropdownButton2(
//                       // customButton: ClipRRect(
//                       //   borderRadius: BorderRadius.circular(
//                       //     getSize(
//                       //       27.77,
//                       //     ),
//                       //   ),
//                       //   child: Image.asset(
//                       //     widget.image,
//                       //     height: getSize(
//                       //       55.53,
//                       //     ),
//                       //     width: getSize(55.53),
//                       //     fit: BoxFit.fill,
//                       //   ),
//                       // ),
//                       items: [
//                         ...MenuItems.firstItems.map(
//                           (item) => DropdownMenuItem<MenuItem>(
//                             value: item,
//                             child: MenuItems.buildItem(item),
//                           ),
//                         ),
//                       ],
//                       onChanged: (value) {
//                         MenuItems.onChanged(context, value as MenuItem);
//                       },
//                       itemHeight: 48,
//                       itemPadding: const EdgeInsets.only(left: 12, right: 12),
//                       dropdownWidth: 115,
//                       dropdownPadding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 0),
//                       dropdownDecoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               Colors.black12.withOpacity(0.2),
//                               Colors.black12.withOpacity(0.2),
//                             ],
//                             stops: const [
//                               0.1,
//                               1,
//                             ]),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black45,
//                             blurRadius: 2.0, // soften the shadow
//                             spreadRadius: 2.0, //extend the shadow
//                             offset: Offset(
//                               0.0, // Move to right 10  horizontally
//                               0.0, // Move to bottom 10 Vertically
//                             ),
//                           )
//                         ],
//                       ),
//                       dropdownElevation: 6,
//                       offset: const Offset(-30, -1),
//                     ),
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(
//                       getSize(
//                         27.77,
//                       ),
//                     ),
//                     child: Image.asset(
//                       widget.image,
//                       height: getSize(
//                         55.53,
//                       ),
//                       width: getSize(55.53),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: getVerticalSize(7)),
//             child: Row(
//               children: [
//                 widget.index == 0
//                     ? Container(
//                         height: getSize(
//                           19,
//                         ),
//                         width: getSize(
//                           19,
//                         ),
//                         child: Card(
//                           clipBehavior: Clip.antiAlias,
//                           margin: EdgeInsets.all(0),
//                           color: ColorConstant.lime600,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                               getHorizontalSize(
//                                 8.33,
//                               ),
//                             ),
//                           ),
//                           child: Align(
//                               alignment: Alignment.center,
//                               child: Icon(
//                                 Icons.home,
//                                 color: Colors.white,
//                                 size: getHorizontalSize(13),
//                               )),
//                         ),
//                       )
//                     : widget.title == "No.${widget.index + 1}"
//                         ? Container(
//                             width: getHorizontalSize(8),
//                           )
//                         : Container(
//                             decoration: BoxDecoration(
//                               color: ColorConstant.redA700,
//                               borderRadius: BorderRadius.circular(
//                                 getHorizontalSize(
//                                   8.33,
//                                 ),
//                               ),
//                             ),
//                             child: Container(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: getHorizontalSize(5),
//                                     vertical: getVerticalSize(2.0)),
//                                 child: Text(
//                                   (widget.index + 1).toString(),
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       fontSize: getFontSize(
//                                         12,
//                                       ),
//                                       color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: getHorizontalSize(
//                       4.62,
//                     ),
//                     top: getVerticalSize(
//                       0.93,
//                     ),
//                     right: getHorizontalSize(
//                       0.01,
//                     ),
//                     bottom: getVerticalSize(
//                       2.77,
//                     ),
//                   ),
//                   child: Text(
//                     widget.title,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                         fontSize: getFontSize(13), color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MenuItem {
//   final String text;
//   final IconData icon;

//   const MenuItem({
//     required this.text,
//     required this.icon,
//   });
// }

// class MenuItems {
//   static const List<MenuItem> firstItems = [invite, unlock];

//   static const invite = MenuItem(text: 'Invite', icon: CupertinoIcons.plus);
//   static const unlock = MenuItem(text: 'Unlock', icon: Icons.lock_open);
//   // static const settings = MenuItem(text: 'Settings', icon: Icons.settings);

//   static Widget buildItem(MenuItem item) {
//     return Row(
//       children: [
//         Icon(item.icon, color: Colors.white, size: 22),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           item.text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   static onChanged(BuildContext context, MenuItem item) {
//     switch (item) {
//       case MenuItems.invite:
//         //Do something
//         break;
//       case MenuItems.unlock:
//         //Do something
//         break;
//       // case MenuItems.share:
//       // //Do something
//       //   break;
//     }
//   }
// }
