import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';

// ignore: must_be_immutable
class BeansExpensesItemWidget extends StatelessWidget {
  BeansExpensesItemWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GlassmorphicContainer(
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
            Colors.black12.withOpacity(0.02),
            Colors.black12.withOpacity(0.02),
          ],
        ),
        height: getVerticalSize(65),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  15.00,
                ),
                top: getVerticalSize(
                  10.00,
                ),
                bottom: getVerticalSize(
                  10.00,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: getHorizontalSize(
                        10.00,
                      ),
                    ),
                    child: Text(
                      "Withdraw",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: ColorConstant.gray800,
                        fontSize: getFontSize(
                          15,
                        ),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getVerticalSize(
                        8.00,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "21-04-2022",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: ColorConstant.bluegray400,
                            fontSize: getFontSize(
                              12,
                            ),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              9.00,
                            ),
                            right: getHorizontalSize(
                              53.00,
                            ),
                          ),
                          child: Text(
                            "10:12:49",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: ColorConstant.bluegray400,
                              fontSize: getFontSize(
                                12,
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
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(
                  5.00,
                ),
                top: getVerticalSize(
                  15.50,
                ),
                right: getHorizontalSize(
                  15.00,
                ),
                bottom: getVerticalSize(
                  15.50,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "10K",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ColorConstant.gray800,
                      fontSize: getFontSize(
                        25,
                      ),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: getVerticalSize(
                      23.56,
                    ),
                    width: getHorizontalSize(
                      16.12,
                    ),
                    margin: EdgeInsets.only(
                      left: getHorizontalSize(
                        15.00,
                      ),
                      top: getVerticalSize(
                        1.50,
                      ),
                      bottom: getVerticalSize(
                        3.94,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            ImageConstant.imgGroup15272,
                            height: getVerticalSize(
                              23.56,
                            ),
                            width: getHorizontalSize(
                              16.12,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            ImageConstant.imgGroup15272,
                            height: getVerticalSize(
                              23.56,
                            ),
                            width: getHorizontalSize(
                              16.12,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
