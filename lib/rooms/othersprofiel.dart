// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol_app_infi/rooms/start.dart';
// // import 'package:lol/rooms/start.dart';

// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/math_utils.dart';

// class OtherProfile extends StatefulWidget {
//   const OtherProfile({Key? key}) : super(key: key);

//   @override
//   State<OtherProfile> createState() => _OtherProfileState();
// }

// class _OtherProfileState extends State<OtherProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: getVerticalSize(
//         330.00,
//       ),
//       width: size.width,
//       margin: EdgeInsets.only(
//         top: getVerticalSize(
//           100.00,
//         ),
//       ),
//       child: Stack(
//         children: [
//           Align(
//             child: Stack(
//               children: [
//                 Align(
//                     alignment: Alignment.bottomCenter,
//                     child: GlassmorphicContainer(
//                       borderRadius: 15,
//                       width: size.width,
//                       blur: 10,
//                       alignment: Alignment.bottomCenter,
//                       border: 1,
//                       linearGradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             const Color(0xFFffffff).withOpacity(0.2),
//                             const Color(0xFFFFFFFF).withOpacity(0.2),
//                           ],
//                           stops: const [
//                             0.1,
//                             1,
//                           ]),
//                       borderGradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Colors.white10.withOpacity(0.2),
//                           Colors.white10.withOpacity(0.2),
//                         ],
//                       ),
//                       height: getVerticalSize(280),
//                     )),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => Start()));
//                   },
//                   child: Align(
//                     alignment: Alignment.topCenter,
//                     child: Stack(
//                       children: [
//                         GlassmorphicContainer(
//                           borderRadius: 60,
//                           width: getHorizontalSize(100),
//                           blur: 1,
//                           alignment: Alignment.bottomCenter,
//                           border: 1,
//                           linearGradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 const Color(0xFFffffff).withOpacity(0.2),
//                                 const Color(0xFFFFFFFF).withOpacity(0.2),
//                               ],
//                               stops: const [
//                                 0.1,
//                                 1,
//                               ]),
//                           borderGradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               Colors.white10.withOpacity(0.2),
//                               Colors.white10.withOpacity(0.2),
//                             ],
//                           ),
//                           height: getVerticalSize(100),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 5,left: 5),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               getSize(
//                                 45.50,
//                               ),
//                             ),
//                             child: Image.asset(
//                               ImageConstant.imgUnsplashvvewjj1,
//                               height: getVerticalSize(
//                                 91.00,
//                               ),
//                               width: getHorizontalSize(
//                                 92.00,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child:   Padding(
//                     padding: EdgeInsets.only(top: getVerticalSize(57),left: getHorizontalSize(10),right: getHorizontalSize(10)),
//                     child: Row(
//                       crossAxisAlignment:
//                       CrossAxisAlignment.center,
//                       mainAxisSize:
//                       MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Icon(Icons.menu,color: Colors.white,size: getHorizontalSize(20),),

//                         Text(
//                           "@Mention",
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
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
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: getHorizontalSize(
//                   10.55,
//                 ),
//                 top: getVerticalSize(
//                   19.60,
//                 ),
//                 right: getHorizontalSize(
//                   10.55,
//                 ),
//                 bottom: getVerticalSize(
//                   19.60,
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "User Name",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: ColorConstant.whiteA700,
//                         fontSize: getFontSize(
//                           26,
//                         ),
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: getVerticalSize(
//                         62.53,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               71.00,
//                             ),
//                           ),
//                           child: Text(
//                             "324",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: ColorConstant.whiteA700,
//                               fontSize: getFontSize(
//                                 13,
//                               ),
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               6.73,
//                             ),
//                             top: getVerticalSize(
//                               3.00,
//                             ),
//                             bottom: getVerticalSize(
//                               2.20,
//                             ),
//                           ),
//                           child: Text(
//                             "Following",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: ColorConstant.whiteA700,
//                               fontSize: getFontSize(
//                                 10,
//                               ),
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               5.89,
//                             ),
//                           ),
//                           child: Container(
//                             height: getVerticalSize(
//                               5.05,
//                             ),
//                             width: getHorizontalSize(
//                               2.52,
//                             ),
//                             child: SvgPicture.asset(
//                               ImageConstant.imgVector11,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: getVerticalSize(
//                             16.82,
//                           ),
//                           width: getHorizontalSize(
//                             0.84,
//                           ),
//                           margin: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               13.46,
//                             ),
//                           ),
//                           decoration: BoxDecoration(
//                             color: ColorConstant.whiteA700,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               13.46,
//                             ),
//                             top: getVerticalSize(
//                               1.00,
//                             ),
//                           ),
//                           child: Text(
//                             "324",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: ColorConstant.whiteA700,
//                               fontSize: getFontSize(
//                                 13,
//                               ),
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               6.73,
//                             ),
//                             top: getVerticalSize(
//                               3.00,
//                             ),
//                             bottom: getVerticalSize(
//                               2.20,
//                             ),
//                           ),
//                           child: Text(
//                             "Followers",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: ColorConstant.whiteA700,
//                               fontSize: getFontSize(
//                                 10,
//                               ),
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(
//                               5.88,
//                             ),
//                             right: getHorizontalSize(
//                               72.84,
//                             ),
//                           ),
//                           child: Container(
//                             height: getVerticalSize(
//                               5.05,
//                             ),
//                             width: getHorizontalSize(
//                               2.52,
//                             ),
//                             child: SvgPicture.asset(
//                               ImageConstant.imgVector11,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         top: getVerticalSize(
//                           10.02,
//                         ),
//                         right: getHorizontalSize(
//                           3.45,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: ColorConstant.lime200,
//                               borderRadius: BorderRadius.circular(
//                                 getHorizontalSize(
//                                   10.00,
//                                 ),
//                               ),
//                               border: Border.all(
//                                 color: ColorConstant.lime800,
//                                 width: getHorizontalSize(
//                                   1.50,
//                                 ),
//                               ),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     left: getHorizontalSize(
//                                       10.00,
//                                     ),
//                                   ),
//                                   child: Image.asset(
//                                     ImageConstant.img2bronzelvl1,
//                                     height: 25,width: 25,
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         left: getHorizontalSize(
//                                           7.59,
//                                         ),
//                                         top: getVerticalSize(
//                                           5.07,
//                                         ),
//                                         right: getHorizontalSize(
//                                           35.28,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         "VIP level",
//                                         overflow: TextOverflow.ellipsis,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: ColorConstant.lightGreen900,
//                                           fontSize: getFontSize(
//                                             8,
//                                           ),
//                                           fontFamily: 'Roboto',
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                           left: getHorizontalSize(
//                                             7.59,
//                                           ),
//                                           top: getVerticalSize(
//                                             0.69,
//                                           ),
//                                           right: getHorizontalSize(
//                                             35.28,
//                                           ),
//                                           bottom: getVerticalSize(
//                                             4.15,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "vip 1",
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: ColorConstant.lightGreen900,
//                                             fontSize: getFontSize(
//                                               12,
//                                             ),
//                                             fontFamily: 'Roboto',
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: ColorConstant.amber100,
//                               borderRadius: BorderRadius.circular(
//                                 getHorizontalSize(
//                                   10.00,
//                                 ),
//                               ),
//                               border: Border.all(
//                                 color: ColorConstant.orangeA100,
//                                 width: getHorizontalSize(
//                                   1.50,
//                                 ),
//                               ),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     left: getHorizontalSize(
//                                       10.00,
//                                     ),
//                                   ),
//                                   child: Image.asset(
//                                     ImageConstant.imgTrophy,
//                                     height: 25,width: 25,
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.centerRight,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                           left: getHorizontalSize(
//                                             7.50,
//                                           ),
//                                           top: getVerticalSize(
//                                             5.00,
//                                           ),
//                                           right: getHorizontalSize(
//                                             30,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "Contribution",
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: ColorConstant.orange700,
//                                             fontSize: getFontSize(
//                                               8,
//                                             ),
//                                             fontFamily: 'Roboto',
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         left: getHorizontalSize(
//                                           7.51,
//                                         ),
//                                         top: getVerticalSize(
//                                           0.76,
//                                         ),
//                                         right: getHorizontalSize(
//                                           30,
//                                         ),
//                                         bottom: getVerticalSize(
//                                           4.15,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         "123k",
//                                         overflow: TextOverflow.ellipsis,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: ColorConstant.orange700,
//                                           fontSize: getFontSize(
//                                             12,
//                                           ),
//                                           fontFamily: 'Roboto',
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: ColorConstant.lightGreenA100,
//                               borderRadius: BorderRadius.circular(
//                                 getHorizontalSize(
//                                   10.00,
//                                 ),
//                               ),
//                               border: Border.all(
//                                 color: ColorConstant.lightGreenA200,
//                                 width: getHorizontalSize(
//                                   1.50,
//                                 ),
//                               ),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     left: getHorizontalSize(
//                                       10.00,
//                                     ),
//                                     top: getVerticalSize(
//                                       8.00,
//                                     ),
//                                     bottom: getVerticalSize(
//                                       8.00,
//                                     ),
//                                   ),
//                                   child: Container(
//                                       height: getSize(
//                                         18.00,
//                                       ),
//                                       width: getSize(
//                                         18.00,
//                                       ),
//                                       decoration: BoxDecoration(
//                                           color: ColorConstant.starr,
//                                           borderRadius: BorderRadius.circular(50)
//                                       ),
//                                       alignment: Alignment.center,
//                                       child: Icon(
//                                         Icons.star,
//                                         color: ColorConstant.lightGreenA100,size: 15,
//                                       )),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     left: getHorizontalSize(
//                                       7.59,
//                                     ),
//                                     top: getVerticalSize(
//                                       5.07,
//                                     ),
//                                     right: getHorizontalSize(
//                                       33.41,
//                                     ),
//                                     bottom: getVerticalSize(
//                                       4.15,
//                                     ),
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           right: getHorizontalSize(
//                                             1.83,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "Charisma",
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: ColorConstant.lightGreen800,
//                                             fontSize: getFontSize(
//                                               8,
//                                             ),
//                                             fontFamily: 'Roboto',
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           top: getVerticalSize(
//                                             0.69,
//                                           ),
//                                           bottom: getVerticalSize(
//                                             0.00,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "2.56 m",
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: ColorConstant.lightGreen800,
//                                             fontSize: getFontSize(
//                                               12,
//                                             ),
//                                             fontFamily: 'Roboto',
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(
//                       top: getVerticalSize(
//                         8.98,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           height: getVerticalSize(
//                             45.42,
//                           ),
//                           width: getHorizontalSize(
//                             168.22,
//                           ),
//                           child: Stack(
//                             alignment: Alignment.bottomLeft,
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Image.asset(
//                                   ImageConstant.imgRectangle210,
//                                   height: getVerticalSize(
//                                     45.42,
//                                   ),
//                                   width: getHorizontalSize(
//                                     168.22,
//                                   ),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: getHorizontalSize(
//                                     37.01,
//                                   ),
//                                   bottom: getVerticalSize(
//                                     8.96,
//                                   ),
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         bottom: getVerticalSize(
//                                           3.65,
//                                         ),
//                                       ),
//                                       child: Container(
//                                         height: getVerticalSize(
//                                           20.03,
//                                         ),
//                                         width: getHorizontalSize(
//                                           18.50,
//                                         ),
//                                         child: SvgPicture.asset(
//                                           ImageConstant.img04f2f1fed89b09d,
//                                           fit: BoxFit.fill,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         left: getHorizontalSize(
//                                           6.73,
//                                         ),
//                                         top: getVerticalSize(
//                                           1.68,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         "Leave",
//                                         overflow: TextOverflow.ellipsis,
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: ColorConstant.whiteA700,
//                                           fontSize: getFontSize(
//                                             20,
//                                           ),
//                                           fontFamily: 'Roboto',
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: getVerticalSize(
//                             45.42,
//                           ),
//                           width: getHorizontalSize(
//                             170.0,
//                           ),
//                           child: Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Image.asset(
//                                   ImageConstant.imgRectangle211,
//                                   height: getVerticalSize(
//                                     45.42,
//                                   ),
//                                   width: getHorizontalSize(
//                                     168.22,
//                                   ),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: getHorizontalSize(
//                                       30.45,
//                                     ),
//                                     bottom: getVerticalSize(
//                                       8.96,
//                                     ),
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           bottom: getVerticalSize(
//                                             3.65,
//                                           ),
//                                         ),
//                                         child: Container(
//                                           height: getVerticalSize(
//                                             21.03,
//                                           ),
//                                           width: getHorizontalSize(
//                                             15.14,
//                                           ),
//                                           child: SvgPicture.asset(
//                                             ImageConstant.imgVector5,
//                                             fit: BoxFit.fill,
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           left: getHorizontalSize(
//                                             7.57,
//                                           ),
//                                           top: getVerticalSize(
//                                             1.68,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "Turn Off",
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: ColorConstant.whiteA700,
//                                             fontSize: getFontSize(
//                                               20,
//                                             ),
//                                             fontFamily: 'Roboto',
//                                             fontWeight: FontWeight.w400,
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
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }