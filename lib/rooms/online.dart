// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol_app_infi/rooms/widgets/onlinewidget.dart';
// // import 'package:lol/rooms/widgets/onlinewidget.dart';

// import '../core/utils/color_constant.dart';
// import '../core/utils/math_utils.dart';

// class Online  extends StatefulWidget {
//   const Online ({Key? key}) : super(key: key);

//   @override
//   State<Online > createState() => _OnlineState();
// }

// class _OnlineState extends State<Online > {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: getVerticalSize(520),

//       child: GlassmorphicContainer(
//         borderRadius: 0,
//         width:size.width,
//         blur: 15,
//         alignment: Alignment.bottomCenter,
//         border: 1,
//         linearGradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFffffff).withOpacity(0.1),
//               Color(0xFFFFFFFF).withOpacity(0.05),
//             ],
//             stops: [
//               0.1,
//               1,
//             ]),
//         borderGradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Colors.white10.withOpacity(0.05),
//             Colors.white10.withOpacity(0.05),
//           ],
//         ),
//         height: getVerticalSize(520),

//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: EdgeInsets.only(
//               top: getVerticalSize(
//                 3.00,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     height: getVerticalSize(
//                       40.00,
//                     ),
//                     width: size.width,
//                     decoration: BoxDecoration(
//                       color: ColorConstant.whiteA70019,
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorConstant.black90033,
//                           spreadRadius: getHorizontalSize(
//                             2.00,
//                           ),
//                           blurRadius: getHorizontalSize(
//                             2.00,
//                           ),
//                           offset: Offset(
//                             0,
//                             4,
//                           ),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: getHorizontalSize(20)),
//                       child: Text(
//                         "Online (12)",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: ColorConstant.whiteA700,
//                           fontSize: getFontSize(
//                             16,
//                           ),
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: getVerticalSize(477),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         18.00,
//                       ),
//                       top: getVerticalSize(
//                         3.00,
//                       ),
//                       right: getHorizontalSize(
//                         14.00,
//                       ),
//                     ),
//                     child: ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: 12,
//                       itemBuilder: (context, index) {
//                         return OnlineWidget();
//                       },
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
