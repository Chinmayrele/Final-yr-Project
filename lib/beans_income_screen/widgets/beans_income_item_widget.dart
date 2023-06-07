import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../wealth_level_screen/wealth_level_screen.dart';

// ignore: must_be_immutable
class BeansIncomeItemWidget extends StatefulWidget {
  const BeansIncomeItemWidget({Key? key, required this.incomeData}) : super(key: key);
  final Map<String, dynamic> incomeData;

  @override
  State<BeansIncomeItemWidget> createState() => _BeansIncomeItemWidgetState();
}

class _BeansIncomeItemWidgetState extends State<BeansIncomeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WealthLevelScreen()));
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: GlassmorphicContainer(
          linearGradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.2),
            Colors.white38.withOpacity(0.2)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderGradient: LinearGradient(colors: [
            Colors.white24.withOpacity(0.3),
            Colors.white70.withOpacity(0.3)
          ]),
          height: getVerticalSize(70),
          blur: 25,
          borderRadius: 20,
          border: 1,
          width: getHorizontalSize(360),
          margin: EdgeInsets.only(top: getVerticalSize(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
                    Container(
                      width: getHorizontalSize(
                        182.00,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'User Name....',
                                    style: TextStyle(
                                      color: ColorConstant.gray800,
                                      fontSize: getFontSize(
                                        15,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'sent',
                                    style: TextStyle(
                                      color: ColorConstant.gray800,
                                      fontSize: getFontSize(
                                        15,
                                      ),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: getVerticalSize(
                                1.00,
                              ),
                              bottom: getVerticalSize(
                                2.00,
                              ),
                            ),
                            child: Image.asset(
                              ImageConstant.imgRose031,
                              height: getVerticalSize(
                                15.00,
                              ),
                              width: getHorizontalSize(
                                14.67,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "X 1",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: ColorConstant.gray800,
                              fontSize: getFontSize(
                                15,
                              ),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                                65.00,
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
                      "10",
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(
                          10.10,
                        ),
                        top: getVerticalSize(
                          2.00,
                        ),
                        bottom: getVerticalSize(
                          3.44,
                        ),
                      ),
                      child: Image.asset(
                        ImageConstant.imgGroup15274,
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
      ),
    );
  }
}
