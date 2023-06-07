// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../core/utils/math_utils.dart';
// import '../frame_1268_screen/frame_1268_screen.dart';
// import '../rooms/start.dart';

// class CreateRoomPublicScreen extends StatefulWidget {
//   const CreateRoomPublicScreen({Key? key}) : super(key: key);

//   @override
//   State<CreateRoomPublicScreen> createState() => _CreateRoomPublicScreenState();
// }

// class _CreateRoomPublicScreenState extends State<CreateRoomPublicScreen> with SingleTickerProviderStateMixin{
//   late AnimationController _animationController;
//  bool room = true;

//   @override
//   void initState() {
//     _animationController =
//     AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
//     _animationController.repeat(reverse: true);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     var hSize  = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           child: Container(
//             height: hSize,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: const Alignment(
//                   0.14444442420767467,
//                   0.1956249900768232,
//                 ),
//                 end: const Alignment(
//                   0.999999913809204,
//                   0.9999999743681396,
//                 ),
//                 colors: [
//                   ColorConstant.lime400,
//                   ColorConstant.green500,
//                 ],
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin:const  Alignment(
//                     0.14444442420767467,
//                     0.1956249900768232,
//                   ),
//                   end: const Alignment(
//                     0.999999913809204,
//                     0.9999999743681396,
//                   ),
//                   colors: [
//                     ColorConstant.lime400,
//                     ColorConstant.green500,
//                   ],
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         top: getVerticalSize(
//                           27.00,
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   24.00,
//                                 ),
//                                 right: getHorizontalSize(
//                                   24.00,
//                                 ),
//                               ),
//                               child: Container(
//                                 height: getSize(
//                                   16.00,
//                                 ),
//                                 width: getSize(
//                                   16.00,
//                                 ),
//                                 child: GestureDetector(
//                                     onTap: (){Navigator.of(context).pop(false);
//                                       },
//                                     child: Icon(Icons.close,color:Colors.grey.shade200))
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   30.00,
//                                 ),
//                                 top: getVerticalSize(
//                                   52.00,
//                                 ),
//                                 right: getHorizontalSize(
//                                   30.00,
//                                 ),
//                               ),
//                               child: Text(
//                                 "CHAT",
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: ColorConstant.whiteA7007f,
//                                   fontSize: getFontSize(
//                                     80,
//                                   ),
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.w900,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: getVerticalSize(
//                                 128.00,
//                               ),
//                               width: getHorizontalSize(
//                                 145.00,
//                               ),
//                               margin: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   30.00,
//                                 ),
//                                 top: getVerticalSize(
//                                   47.00,
//                                 ),
//                                 right: getHorizontalSize(
//                                   30.00,
//                                 ),
//                               ),
//                               child: Stack(
//                                 alignment: Alignment.bottomRight,
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         right: getHorizontalSize(
//                                           10.00,
//                                         ),
//                                       ),
//                                       child: Image.asset(
//                                         ImageConstant.imgUnsplash889qh5,
//                                         height: getSize(
//                                           128.00,
//                                         ),
//                                         width: getSize(
//                                           128.00,
//                                         ),
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                         left: getHorizontalSize(
//                                           10.00,
//                                         ),
//                                         top: getVerticalSize(
//                                           10.00,
//                                         ),
//                                         bottom: getVerticalSize(
//                                           9.00,
//                                         ),
//                                       ),
//                                       child: Container(
//                                         height: getSize(
//                                           39.00,
//                                         ),
//                                         width: getSize(
//                                           39.00,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(20)
//                                         ),
//                                         child: SvgPicture.asset(
//                                           ImageConstant.imgGroup1257,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 top: getVerticalSize(
//                                   72.00,
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     height: getVerticalSize(
//                                       30.00,
//                                     ),
//                                     margin: EdgeInsets.only(
//                                       left: getHorizontalSize(
//                                         31.00,
//                                       ),
//                                     ),
//                                     child: Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         // Container(
//                                         //   height: getVerticalSize(
//                                         //     30.00,
//                                         //   ),
//                                         //   width: getHorizontalSize(
//                                         //     77.43,
//                                         //   ),
//                                         //   decoration: BoxDecoration(
//                                         //     borderRadius:
//                                         //         BorderRadius.circular(
//                                         //       getHorizontalSize(
//                                         //         15.00,
//                                         //       ),
//                                         //     ),
//                                         //     border: Border.all(
//                                         //       color:
//                                         //           room?ColorConstant.whiteA700:Colors.transparent,
//                                         //       width: getHorizontalSize(
//                                         //         1.00,
//                                         //       ),
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                         GestureDetector(
//                                           onTap: (){
//                                             setState(() {
//                                               room = true;
//                                             });
//                                           },
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             margin: EdgeInsets.only(
//                                               left: getHorizontalSize(
//                                                 2.00,
//                                               ),
//                                               top: getVerticalSize(
//                                                 2.00,
//                                               ),
//                                               right: getHorizontalSize(
//                                                 2.63,
//                                               ),
//                                               bottom: getVerticalSize(
//                                                 2.00,
//                                               ),
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   room?ColorConstant.whiteA70033:ColorConstant.black90033,
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 getHorizontalSize(
//                                                   12.00,
//                                                 ),
//                                               ),
//                                               border: Border.all(
//                                                 color:
//                                                     room?ColorConstant.whiteA700:ColorConstant.black90019,
//                                                 width: getHorizontalSize(
//                                                   1.00,
//                                                 ),
//                                               ),
//                                             ),
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: getHorizontalSize(
//                                                       10.00,
//                                                     ),
//                                                     top: getVerticalSize(3),
//                                                   ),
//                                                   child: Container(
//                                                     height: getVerticalSize(
//                                                       5.27,
//                                                     ),
//                                                     width: getHorizontalSize(
//                                                       9.80,
//                                                     ),
//                                                     child: Icon(Icons.lock_open_outlined,color:room?Colors.white:ColorConstant.whiteA7007f,size: 15,)
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: getHorizontalSize(
//                                                       4.00,
//                                                     ),
//                                                     top: getVerticalSize(
//                                                       3.00,
//                                                     ),
//                                                     right: getHorizontalSize(
//                                                       12.00,
//                                                     ),
//                                                     bottom: getVerticalSize(
//                                                       3.00,
//                                                     ),
//                                                   ),
//                                                   child: Text(
//                                                     "public",
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: room?ColorConstant
//                                                           .whiteA700:ColorConstant.whiteA7007f,
//                                                       fontSize: getFontSize(
//                                                         13,
//                                                       ),
//                                                       fontFamily: 'Roboto',
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),




//                                   Container(
//                                     height: getVerticalSize(
//                                       30.00,
//                                     ),
//                                     margin: EdgeInsets.only(
//                                       left: getHorizontalSize(
//                                         10.00,
//                                       ),
//                                     ),
//                                     child: Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         // Container(
//                                         //   height: getVerticalSize(
//                                         //     30.00,
//                                         //   ),
//                                         //   width: getHorizontalSize(
//                                         //     77.43,
//                                         //   ),
//                                         //   decoration: BoxDecoration(
//                                         //     borderRadius:
//                                         //         BorderRadius.circular(
//                                         //       getHorizontalSize(
//                                         //         15.00,
//                                         //       ),
//                                         //     ),
//                                         //     border: Border.all(
//                                         //       color:
//                                         //           room?Colors.transparent:ColorConstant.whiteA700,
//                                         //       width: getHorizontalSize(
//                                         //         1.00,
//                                         //       ),
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                         GestureDetector(
//                                           onTap: (){
//                                             setState(() {
//                                               room = false;
//                                             });
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) => Frame1268Screen(context),
//                                             );
//                                           },
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             margin: EdgeInsets.only(
//                                               left: getHorizontalSize(
//                                                 2.00,
//                                               ),
//                                               top: getVerticalSize(
//                                                 2.00,
//                                               ),
//                                               right: getHorizontalSize(
//                                                 2.63,
//                                               ),
//                                               bottom: getVerticalSize(
//                                                 2.00,
//                                               ),
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   room?ColorConstant.black90033:ColorConstant.whiteA70033,
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 getHorizontalSize(
//                                                   12.00,
//                                                 ),
//                                               ),
//                                               border: Border.all(
//                                                 color:
//                                                     room?ColorConstant.black90019:ColorConstant.whiteA700,
//                                                 width: getHorizontalSize(
//                                                   1.00,
//                                                 ),
//                                               ),
//                                             ),
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: getHorizontalSize(
//                                                       10.00,
//                                                     ),
//                                                     top: getVerticalSize(3),
//                                                   ),
//                                                   child: Container(
//                                                     height: getVerticalSize(
//                                                       5.27,
//                                                     ),
//                                                     width: getHorizontalSize(
//                                                       9.80,
//                                                     ),
//                                                     child: Icon(Icons.lock,color:room?ColorConstant.whiteA7007f:Colors.white,size: 15,)
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: getHorizontalSize(
//                                                       10.00,
//                                                     ),
//                                                     top: getVerticalSize(
//                                                       3.00,
//                                                     ),
//                                                     right: getHorizontalSize(
//                                                       14.00,
//                                                     ),
//                                                     bottom: getVerticalSize(
//                                                       3.00,
//                                                     ),
//                                                   ),
//                                                   child: Text(
//                                                     "Lock",
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: room?ColorConstant.whiteA7007f:ColorConstant
//                                                           .whiteA700,
//                                                       fontSize: getFontSize(
//                                                         13,
//                                                       ),
//                                                       fontFamily: 'Roboto',
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                       //
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: getHorizontalSize(
//                                 30.00,
//                               ),
//                               top: getVerticalSize(
//                                 56.00,
//                               ),
//                               right: getHorizontalSize(
//                                 30.00,
//                               ),
//                             ),
//                             child: Container(
//                               height: getVerticalSize(
//                                 38.00,
//                               ),
//                               width: getHorizontalSize(
//                                 300.00,
//                               ),
//                               child: TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Channel Name',
//                                   hintStyle: TextStyle(
//                                     fontSize: getFontSize(
//                                       25.0,
//                                     ),
//                                     color: ColorConstant.whiteA7004c,
//                                   ),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: ColorConstant.whiteA7004c,
//                                     ),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: ColorConstant.whiteA7004c,
//                                     ),
//                                   ),
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.only(
//                                     top: getVerticalSize(
//                                       2.15,
//                                     ),
//                                     bottom: getVerticalSize(
//                                       11.15,
//                                     ),
//                                   ),
//                                 ),
//                                 style: TextStyle(
//                                   color: ColorConstant.whiteA7004c,
//                                   fontSize: getFontSize(
//                                     25.0,
//                                   ),
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: getSize(
//                       81.00,
//                     ),
//                     margin: EdgeInsets.only(
//                       left: getHorizontalSize(
//                         140.00,
//                       ),
//                       top: getVerticalSize(
//                         58.00,
//                       ),
//                     ),
//                     child: GestureDetector(
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Start()));

//                       },
//                       child: Stack(
//                         alignment: Alignment.centerLeft,
//                         children: [
//                           Align(
//                             alignment: Alignment.center,
//                             child: Container(
//                               height: getSize(
//                                 67.00,
//                               ),
//                               width: getSize(
//                                 67.00,
//                               ),
//                               margin: EdgeInsets.only(
//                                 left: getHorizontalSize(
//                                   7.00,
//                                 ),
//                                 top: getVerticalSize(
//                                   7.00,
//                                 ),
//                                 right: getHorizontalSize(
//                                   7.00,
//                                 ),
//                                 bottom: getVerticalSize(
//                                   7.00,
//                                 ),
//                               ),
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Container(
//                                       height: getSize(
//                                         67.00,
//                                       ),
//                                       width: getSize(
//                                         67.00,
//                                       ),
//                                       child: CircularProgressIndicator(
//                                         value: 0,
//                                         backgroundColor: ColorConstant.red504c,
//                                         strokeWidth: getHorizontalSize(
//                                           3.00,
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                 ],
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               height: getSize(
//                                 81.00,
//                               ),
//                               width: getSize(
//                                 81.00,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                   getHorizontalSize(
//                                     40.50,
//                                   ),
//                                 ),
//                                 border: Border.all(
//                                   color: ColorConstant.whiteA70066,
//                                   width: getHorizontalSize(
//                                     3.00,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: FadeTransition(
//                                 opacity: _animationController,
//                               child: Text("OK",style: TextStyle(fontSize: getFontSize(25),color: Colors.white,fontWeight: FontWeight.w600),),

//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
