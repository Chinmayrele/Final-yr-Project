// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol_app_infi/rooms/start.dart';
// import 'package:simple_gradient_text/simple_gradient_text.dart';

// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/math_utils.dart';
// import 'room_admin_setting_item_widget.dart';

// class EndDrawerAdmin extends StatefulWidget {
//   const EndDrawerAdmin({Key? key}) : super(key: key);

//   @override
//   State<EndDrawerAdmin> createState() => _EndDrawerAdminState();
// }

// class _EndDrawerAdminState extends State<EndDrawerAdmin> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.transparent,
//       child: GlassmorphicContainer(
//         borderRadius: 0,
//         margin: EdgeInsets.symmetric(horizontal: getHorizontalSize(25)),
//         width: size.width,
//         blur: 15,
//         alignment: Alignment.bottomCenter,
//         border: 1,
//         linearGradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFFffffff).withOpacity(0.2),
//               const Color(0xFFFFFFFF).withOpacity(0.2),
//             ],
//             stops:const [
//               0.1,
//               1,
//             ]),
//         borderGradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Colors.white10.withOpacity(0.2),
//             Colors.white10.withOpacity(0.2),
//           ],
//         ),
//         height: getVerticalSize(530),
//         child: Align(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: getHorizontalSize(
//                 14.00,
//               ),
//               top: getVerticalSize(
//                 16.00,
//               ),
//               right: getHorizontalSize(
//                 19.00,
//               ),
//               bottom: getVerticalSize(
//                 18.00,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         height: getVerticalSize(
//                           73.00,
//                         ),
//                         width: getHorizontalSize(
//                           83.45,
//                         ),
//                         child: Stack(
//                           alignment: Alignment.bottomRight,
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   right: getHorizontalSize(
//                                     10.00,
//                                   ),
//                                 ),
//                                 child: Image.asset(
//                                   ImageConstant.imgUnsplash889qh5,
//                                   height: getSize(
//                                     73.00,
//                                   ),
//                                   width: getSize(
//                                     73.00,
//                                   ),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   left: getHorizontalSize(
//                                     10.00,
//                                   ),
//                                   top: getVerticalSize(
//                                     10.00,
//                                   ),
//                                   bottom: getVerticalSize(
//                                     3.38,
//                                   ),
//                                 ),
//                                 child: Container(
//                                   height: getSize(
//                                     24.00,
//                                   ),
//                                   width: getSize(
//                                     24.00,
//                                   ),
//                                   child: SvgPicture.asset(
//                                     ImageConstant.imgGroup1257,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: getHorizontalSize(
//                                 15.55,
//                               ),
//                               top: getVerticalSize(
//                                 10.00,
//                               ),
//                               right: getHorizontalSize(
//                                 45.00,
//                               ),
//                             ),
//                             child: Text(
//                               "Room Name",
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: ColorConstant.whiteA700,
//                                 fontSize: getFontSize(
//                                   20,
//                                 ),
//                                 fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   15.55,
//                                 ),
//                                 right: getHorizontalSize(
//                                   45.00,
//                                 ),
//                                 top: getVerticalSize(5)),
//                             child: Text(
//                               "Id : gh3456789",
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: ColorConstant.whiteA700,
//                                 fontSize: getFontSize(
//                                   13,
//                                 ),
//                                 fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                     child: Divider(
//                       color: Colors.white30,
//                       thickness: 1,
//                     ),
//                     padding: EdgeInsets.symmetric(
//                         vertical: getVerticalSize(5),
//                         horizontal: getHorizontalSize(20))),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         18.00,
//                       ),
//                       top: getVerticalSize(
//                         0.00,
//                       ),
//                       right: getHorizontalSize(
//                         211.00,
//                       ),
//                     ),
//                     child: Text(
//                       "Host",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: ColorConstant.whiteA7004c,
//                         fontSize: getFontSize(
//                           12,
//                         ),
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         8.00,
//                       ),
//                       top: getVerticalSize(
//                         8.00,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Container(
//                           height: getVerticalSize(
//                             38.00,
//                           ),
//                           width: getHorizontalSize(
//                             37.65,
//                           ),
//                           margin: EdgeInsets.only(right: getHorizontalSize(10)),
//                           child: Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(
//                                     getSize(
//                                       19.00,
//                                     ),
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             width: 1.0, color: Colors.grey)),
//                                     child: Image.asset(
//                                       ImageConstant.imgUnsplash3tll912,
//                                       height: getVerticalSize(
//                                         40.00,
//                                       ),
//                                       width: getHorizontalSize(
//                                         40.00,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Container(
//                                   height: getVerticalSize(
//                                     9.50,
//                                   ),
//                                   width: getHorizontalSize(
//                                     9.41,
//                                   ),
//                                   margin: EdgeInsets.only(
//                                     left: getHorizontalSize(
//                                       10.00,
//                                     ),
//                                     top: getVerticalSize(
//                                       10.00,
//                                     ),
//                                     right: getHorizontalSize(
//                                       0.33,
//                                     ),
//                                     bottom: getVerticalSize(
//                                       1.64,
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: ColorConstant.lightGreenA700,
//                                     borderRadius: BorderRadius.circular(
//                                       getHorizontalSize(
//                                         4.75,
//                                       ),
//                                     ),
//                                     border: Border.all(
//                                       color: ColorConstant.gray200,
//                                       width: getHorizontalSize(
//                                         1.00,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Text(
//                           "User Name 6",
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: ColorConstant.whiteA700,
//                             fontSize: getFontSize(
//                               15,
//                             ),
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                     child: Divider(
//                       color: Colors.white30,
//                       thickness: 1,
//                     ),
//                     padding: EdgeInsets.only(
//                         top: getVerticalSize(10),
//                         left: getHorizontalSize(50),
//                         right: getHorizontalSize(20))),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         18.00,
//                       ),
//                       top: getVerticalSize(
//                         5.00,
//                       ),
//                       right: getHorizontalSize(
//                         202.00,
//                       ),
//                     ),
//                     child: Text(
//                       "Admin",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: ColorConstant.whiteA7004c,
//                         fontSize: getFontSize(
//                           12,
//                         ),
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: getVerticalSize(240),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         8.00,
//                       ),
//                       top: getVerticalSize(
//                         9.00,
//                       ),
//                     ),
//                     child: ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       itemBuilder: (context, index) {
//                         return RoomAdminSettingItemWidget();
//                       },
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Start()));
//                   },
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         left: getHorizontalSize(
//                           18.00,
//                         ),
//                         top: getVerticalSize(
//                           18.00,
//                         ),
//                         right: getHorizontalSize(
//                           18.00,
//                         ),
//                       ),
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: getVerticalSize(
//                           31.00,
//                         ),
//                         width: getHorizontalSize(
//                           107.00,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white12.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(
//                             getHorizontalSize(
//                               26.50,
//                             ),
//                           ),
//                           border: Border.all(
//                             color: ColorConstant.whiteA70026,
//                             width: getHorizontalSize(
//                               3.00,
//                             ),
//                           ),
//                         ),
//                         child: GradientText(
//                           "CONFIRM",
//                           textAlign: TextAlign.left,
//                           colors: [
//                             ColorConstant.textStart,
//                             ColorConstant.textEnd
//                           ],
//                           style: TextStyle(
//                             color: ColorConstant.deepPurple901,
//                             fontSize: getFontSize(
//                               15,
//                             ),
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
