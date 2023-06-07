import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
// ignore: must_be_immutable
class VisitorsItemWidget extends StatelessWidget {
  const VisitorsItemWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      margin: EdgeInsets.only(
        top: getVerticalSize(
          2.50,
        ),
        bottom: getVerticalSize(
          2.50,
        ),
      ),
      borderRadius: 15,
      width:size.width,
      blur: 15,
      height: getVerticalSize(79),
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.2),
            Color(0xFFFFFFFF).withOpacity(0.2),
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
          Colors.white10.withOpacity(0.2),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getHorizontalSize(
                10.00,
              ),
              top: getVerticalSize(
                10.00,
              ),
              bottom: getVerticalSize(
                10.00,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: getSize(
                    58.00,
                  ),
                  width: getSize(
                    58.00,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            getSize(
                              29.00,
                            ),
                          ),
                          child: Image.asset(
                            ImageConstant.imgUnsplash3tll92,
                            height: getSize(
                              58.00,
                            ),
                            width: getSize(
                              58.00,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: getSize(
                            14.50,
                          ),
                          width: getSize(
                            14.50,
                          ),
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(
                              10.00,
                            ),
                            top: getVerticalSize(
                              10.00,
                            ),
                            right: getHorizontalSize(
                              0.50,
                            ),
                            bottom: getVerticalSize(
                              2.50,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.lightGreenA700,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                7.25,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.gray200,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(
                      15.00,
                    ),
                    top: getVerticalSize(
                      7.50,
                    ),
                    bottom: getVerticalSize(
                      7.50,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "User Name 3",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.black900,
                          fontSize: getFontSize(
                            18,
                          ),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            6.00,
                          ),
                          right: getHorizontalSize(
                            10.00,
                          ),
                        ),
                        child: Text(
                          "ID : 12345678",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.gray600,
                            fontSize: getFontSize(
                              14,
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
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              // left: getHorizontalSize(
              //   85.00,
              // ),
              right: 15,
              top: getVerticalSize(
                33.00,
              ),
              bottom: getVerticalSize(
                33.00,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '30 Min ago',
                          style: TextStyle(
                            color: ColorConstant.bluegray400,
                            fontSize: getFontSize(
                              12,
                            ),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     left: getHorizontalSize(
                //       4.00,
                //     ),
                //     top: getVerticalSize(
                //       3.00,
                //     ),
                //     bottom: getVerticalSize(
                //       2.00,
                //     ),
                //   ),
                //   child: Container(
                //     height: getVerticalSize(
                //       7.00,
                //     ),
                //     width: getHorizontalSize(
                //       4.00,
                //     ),
                //     child: SvgPicture.asset(
                //       ImageConstant.imgVector2,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
