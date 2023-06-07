import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';

class RecentVisitedItem extends StatefulWidget {
  const RecentVisitedItem({Key? key, required this.recentDoc})
      : super(key: key);
  final Map<String, dynamic> recentDoc;

  @override
  State<RecentVisitedItem> createState() => _RecentVisitedItemState();
}

class _RecentVisitedItemState extends State<RecentVisitedItem> {
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      margin: EdgeInsets.only(
        top: getVerticalSize(
          getVerticalSize(10),
        ),
      ),
      borderRadius: 20,
      width: size.width,
      blur: 15,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.2),
            const Color(0xFFFFFFFF).withOpacity(0.2),
          ],
          stops: const [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white10.withOpacity(0.2),
          Colors.white10.withOpacity(0.2)
        ],
      ),
      height: getVerticalSize(85),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: getSize(58.00),
            width: getSize(58.0),
            margin: EdgeInsets.only(
              left: getHorizontalSize(11.00),
              top: getVerticalSize(5.00),
              bottom: getVerticalSize(5.00),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        getSize(29.41),
                      ),
                      child: Image.network(
                        '',
                        // widget.recentDoc['imageRoom'],
                        height: getSize(56.00),
                        width: getSize(56.00),
                        fit: BoxFit.fill,
                      )),
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     margin: EdgeInsets.only(
                //       left: getHorizontalSize(10.00),
                //       top: getVerticalSize(10.00),
                //       right: getHorizontalSize(1.76),
                //       bottom: getVerticalSize(1.89),
                //     ),
                //     decoration: BoxDecoration(
                //       color: ColorConstant.online,
                //       borderRadius: BorderRadius.circular(
                //         getHorizontalSize(10),
                //       ),
                //       border: Border.all(
                //         color: ColorConstant.gray200,
                //         width: getHorizontalSize(1.00),
                //       ),
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.only(
                //             left: getHorizontalSize(3.87),
                //             top: getVerticalSize(6.00),
                //             bottom: getVerticalSize(3.92),
                //           ),
                //           child: SizedBox(
                //             height: getVerticalSize(5.00),
                //             width: getHorizontalSize(1.00),
                //             child: SvgPicture.asset(
                //               widget.userRoomData.isEmpty
                //                   ? ImageConstant.imgVector8
                //                   : ImageConstant.imgVector55,
                //               fit: BoxFit.fill,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.only(
                //             left: getHorizontalSize(2.00),
                //             top: getVerticalSize(8.00),
                //             bottom: getVerticalSize(3.92),
                //           ),
                //           child: SizedBox(
                //             height: getVerticalSize(3.00),
                //             width: getHorizontalSize(1.00),
                //             child: SvgPicture.asset(
                //               widget.userRoomData.isEmpty
                //                   ? ImageConstant.imgVector8
                //                   : ImageConstant.imgVector66,
                //               fit: BoxFit.fill,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.only(
                //             left: getHorizontalSize(2.00),
                //             top: getVerticalSize(
                //               6.00,
                //             ),
                //             right: getHorizontalSize(4.05),
                //             bottom: getVerticalSize(3.92),
                //           ),
                //           child: SizedBox(
                //             height: getVerticalSize(5.00),
                //             width: getHorizontalSize(1.00),
                //             child: SvgPicture.asset(
                //               widget.userRoomData.isEmpty
                //                   ? ImageConstant.imgVector8
                //                   : ImageConstant.imgVector55,
                //               color: Colors.white,
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
          Padding(
            padding: EdgeInsets.only(
              left: getHorizontalSize(12.29),
              top: getVerticalSize(19.00),
              right: getHorizontalSize(11.36),
              bottom: getVerticalSize(18.16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: getHorizontalSize(
                      241.54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: getVerticalSize(
                              4.00,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.recentDoc['hostName'],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: getFontSize(
                                    17,
                                  ),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //     left: getHorizontalSize(12.00),
                              //     top: getVerticalSize(3.50),
                              //     bottom: getVerticalSize(3.50),
                              //   ),
                              //   child: SizedBox(
                              //     height: getVerticalSize(14.00),
                              //     width: getHorizontalSize(14.01),
                              //     child: SvgPicture.asset(
                              //       ImageConstant.img04f2f1fed89b09d,
                              //       fit: BoxFit.fill,
                              //       color: Colors.black87.withOpacity(0.7),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: getVerticalSize(12.00),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: getVerticalSize(0),
                                ),
                                child: SizedBox(
                                  height: getSize(10.0),
                                  width: getSize(10.00),
                                  child: SvgPicture.asset(
                                    ImageConstant.imgVector,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    2.00,
                                  ),
                                ),
                                child: Text(
                                  "123",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.gray600,
                                    fontSize: getFontSize(
                                      13,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getVerticalSize(
                      0.00,
                    ),
                  ),
                  child: Text(
                    widget.recentDoc['roomName'],
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.gray600,
                      fontSize: getFontSize(
                        13.5,
                      ),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
