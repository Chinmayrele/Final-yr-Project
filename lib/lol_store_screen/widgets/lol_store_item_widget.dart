// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:glassmorphism/glassmorphism.dart';

// import '../../core/utils/color_constant.dart';
// import '../../core/utils/image_constant.dart';
// import '../../core/utils/math_utils.dart';

// // ignore: must_be_immutable
// class LolStoreItemWidget extends StatefulWidget {
//   const LolStoreItemWidget({
//     Key? key,
//     required this.storeData,
//     required this.userData,
//     required this.index,
//     required this.submitStoreFn,
//   }) : super(key: key);
//   final Object? storeData;
//   final Map<String, dynamic> userData;
//   final int index;
//   final void Function(
//     int diamonds,
//     int validity,
//     String imageUrl,
//     String frameName,
//     bool selected,
//   ) submitStoreFn;

//   @override
//   State<LolStoreItemWidget> createState() => _LolStoreItemWidgetState();
// }

// class _LolStoreItemWidgetState extends State<LolStoreItemWidget> {
//   int _selectedItem = -1;
//   bool _isSelected = false;
//   int sDiamonds = 0;
//   int sValidity = 0;
//   String sImageUrl = '';
//   String sFrameName = '';
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _isSelected = !_isSelected;
//           _selectedItem = widget.index;
//           sDiamonds = (widget.storeData as Map<dynamic, dynamic>)['diamonds'];
//           sValidity =
//               (widget.storeData as Map<dynamic, dynamic>)['validity'] as int;
//           sImageUrl = (widget.storeData as Map<dynamic, dynamic>)['imageUrl'];
//           sFrameName = (widget.storeData as Map<dynamic, dynamic>)['frameName'];
//           widget.submitStoreFn(
//               sDiamonds, sValidity, sImageUrl, sFrameName, _isSelected);
//         });
//       },
//       child: Align(
//         alignment: Alignment.center,
//         child: Container(
//           margin: const EdgeInsets.only(top: 5),
//           decoration: BoxDecoration(
//             border: _selectedItem == widget.index && _isSelected
//                 ? Border.all(color: ColorConstant.deepPurple900, width: 2)
//                 : Border.all(color: Colors.white10.withOpacity(0.2), width: 0),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: GlassmorphicContainer(
//             borderRadius: 15,
//             height: getVerticalSize(185),
//             blur: 15,
//             alignment: Alignment.bottomCenter,
//             border: 2,
//             linearGradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   const Color(0xFFffffff).withOpacity(0.2),
//                   const Color(0xFFFFFFFF).withOpacity(0.2),
//                 ],
//                 stops: const [
//                   0.1,
//                   1,
//                 ]),
//             borderGradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white10.withOpacity(0.2),
//                 Colors.white10.withOpacity(0.2),
//               ],
//             ),
//             width: getHorizontalSize(148),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     height: getVerticalSize(120.00),
//                     width: getHorizontalSize(153.00),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(
//                           getHorizontalSize(8.00),
//                         ),
//                         topRight: Radius.circular(
//                           getHorizontalSize(8.00),
//                         ),
//                         bottomLeft: Radius.circular(
//                           getHorizontalSize(0.00),
//                         ),
//                         bottomRight: Radius.circular(
//                           getHorizontalSize(0.00),
//                         ),
//                       ),
//                       gradient: LinearGradient(
//                         begin: const Alignment(
//                             -0.001697166058858155, 0.5074751480283091),
//                         end: const Alignment(
//                             0.9983028339411415, 0.5074752102704458),
//                         colors: [
//                           ColorConstant.deepPurple90019,
//                           ColorConstant.purple50019,
//                         ],
//                       ),
//                     ),
//                     child: Card(
//                       clipBehavior: Clip.antiAlias,
//                       elevation: 0,
//                       margin: const EdgeInsets.all(0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(
//                             getHorizontalSize(8.00),
//                           ),
//                           topRight: Radius.circular(
//                             getHorizontalSize(8.00),
//                           ),
//                           bottomLeft: Radius.circular(
//                             getHorizontalSize(0.00),
//                           ),
//                           bottomRight: Radius.circular(
//                             getHorizontalSize(0.00),
//                           ),
//                         ),
//                       ),
//                       child: Stack(
//                         children: [
//                           Align(
//                             alignment: Alignment.center,
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 left: getHorizontalSize(24.00),
//                                 top: getVerticalSize(7.00),
//                                 right: getHorizontalSize(24.00),
//                                 bottom: getVerticalSize(8.00),
//                               ),
//                               child: Image.network(
//                                 (widget.storeData
//                                     as Map<dynamic, dynamic>)['imageUrl'],
//                                 height: getSize(105.00),
//                                 width: getSize(105.00),
//                                 fit: BoxFit.fill,
//                               ),
//                               // Image.asset(
//                               //   ImageConstant.imgFramebridedan,
//                               //   height: getSize(105.00),
//                               //   width: getSize(105.00),
//                               //   fit: BoxFit.fill,
//                               // ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(17.00),
//                       top: getVerticalSize(12.00),
//                       right: getHorizontalSize(10.00),
//                     ),
//                     child: Text(
//                       (widget.storeData as Map<dynamic, dynamic>)['frameName'],
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: ColorConstant.gray800,
//                         fontSize: getFontSize(12),
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: getHorizontalSize(30.0),
//                       top: getVerticalSize(10.0),
//                       right: getHorizontalSize(10.0),
//                       bottom: getVerticalSize(14.0),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: getVerticalSize(2.00),
//                             bottom: getVerticalSize(
//                               3.00,
//                             ),
//                           ),
//                           child: SizedBox(
//                             height: getVerticalSize(7.00),
//                             width: getHorizontalSize(10.00),
//                             // child: SvgPicture.asset(
//                             //   ImageConstant.imgUnion2,
//                             //   fit: BoxFit.fill,
//                             // ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: getHorizontalSize(4.00),
//                           ),
//                           child: Text(
//                             (widget.storeData
//                                         as Map<dynamic, dynamic>)['validity'] ==
//                                     -1
//                                 ? (widget.storeData as Map<dynamic, dynamic>)[
//                                             'diamonds']
//                                         .toString() +
//                                     "/ Permanent"
//                                 : (widget.storeData as Map<dynamic, dynamic>)[
//                                             'diamonds']
//                                         .toString() +
//                                     "/" +
//                                     (widget.storeData as Map<dynamic, dynamic>)[
//                                             'validity']
//                                         .toString() +
//                                     " Day",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: ColorConstant.gray800,
//                               fontSize: getFontSize(10),
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
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
