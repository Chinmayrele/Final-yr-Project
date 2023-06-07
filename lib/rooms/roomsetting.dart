// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:glassmorphism/glassmorphism.dart';

// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/math_utils.dart';

// class RoomSetting extends StatefulWidget {
//   const RoomSetting({Key? key, required this.function}) : super(key: key);
//   final Function function;

//   @override
//   State<RoomSetting> createState() => _RoomSettingState();
// }

// class _RoomSettingState extends State<RoomSetting> {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topRight,
//       child: GlassmorphicContainer(
//         borderRadius: 0,
//         height: getVerticalSize(500),
//         margin: EdgeInsets.only(top: getVerticalSize(35)),
//         width:getHorizontalSize(70),
//         blur: 15,
//         alignment: Alignment.bottomCenter,
//         border: 1,
//         linearGradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFffffff).withOpacity(0.2),
//               Color(0xFFFFFFFF).withOpacity(0.2),
//             ],
//             stops: [
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
//         child:
//         Stack(
//           alignment: Alignment.centerLeft,
//           children: [

//             Align(
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       ImageConstant.imgRectangle14,
//                       height: getSize(
//                         50.00,
//                       ),
//                       width: getSize(
//                         50.00,
//                       ),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       setState(() {
//                         widget.function(true,false);

//                       });
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         left: getHorizontalSize(
//                           11.89,
//                         ),
//                         top: getVerticalSize(
//                           50.00,
//                         ),
//                         right: getHorizontalSize(
//                           11.89,
//                         ),
//                       ),
//                       child: Container(
//                         height: getSize(
//                           26.20,
//                         ),
//                         width: getSize(
//                           26.20,
//                         ),
//                         child: SvgPicture.asset(
//                           ImageConstant.imgPeoplealtblac,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         11.89,
//                       ),
//                       top: getVerticalSize(
//                         50.00,
//                       ),
//                       right: getHorizontalSize(
//                         11.89,
//                       ),
//                     ),
//                     child: Container(
//                       height: getSize(
//                         26.20,
//                       ),
//                       width: getSize(
//                         26.20,
//                       ),
//                       child: SvgPicture.asset(
//                         ImageConstant.imgPeoplealtblac1,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         11.89,
//                       ),
//                       top: getVerticalSize(
//                         50.00,
//                       ),
//                       right: getHorizontalSize(
//                         11.89,
//                       ),
//                     ),
//                     child: Container(
//                       height: getSize(
//                         26.20,
//                       ),
//                       width: getSize(
//                         26.20,
//                       ),
//                       child: SvgPicture.asset(
//                         ImageConstant.imgPaymentsblack,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         11.89,
//                       ),
//                       top: getVerticalSize(
//                         50.00,
//                       ),
//                       right: getHorizontalSize(
//                         11.89,
//                       ),
//                     ),
//                     child: Container(
//                         height: getSize(
//                          26.00,
//                         ),
//                         width: getSize(
//                           26.00,
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50)
//                         ),
//                         alignment: Alignment.center,
//                         child: Icon(
//                           Icons.star,
//                           color: Colors.black45,size: 22,
//                         )),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         11.89,
//                       ),
//                       top: getVerticalSize(
//                         50.00,
//                       ),
//                       right: getHorizontalSize(
//                         11.89,
//                       ),
//                     ),
//                     child: Container(
//                       height: getSize(
//                         26.20,
//                       ),
//                       width: getSize(
//                         26.20,
//                       ),
//                       child: SvgPicture.asset(
//                         ImageConstant.imgEventavailable,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
