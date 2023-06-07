import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';

// ignore: must_be_immutable
class RecentlyVisitedWidget extends StatefulWidget {
  const RecentlyVisitedWidget({Key? key,required this.index}) : super(key: key);
  final String index;



  @override
  State<RecentlyVisitedWidget> createState() => _RecentlyVisitedWidgetState();
}

class _RecentlyVisitedWidgetState extends State<RecentlyVisitedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getVerticalSize(
          12.00,
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
            margin: EdgeInsets.only(
              right: getHorizontalSize(
                10.00,
              ),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.index,
                    style: TextStyle(
                      color: ColorConstant.bluegray400,
                      fontSize: getFontSize(
                        18,
                      ),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getVerticalSize(
                12.00,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GlassmorphicContainer(
                  borderRadius: 20,
                  width:size.width,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.2),
                        Color(0xFFFFFFFF).withOpacity(0.2),
                      ],
                      stops: [
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
                  height: getVerticalSize(85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: getSize(
                          58.81,
                        ),
                        width: getSize(
                          58.81,
                        ),
                        margin: EdgeInsets.only(
                          top: getVerticalSize(
                            10.00,
                          ),
                          bottom: getVerticalSize(
                            9.19,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getSize(
                                    29.41,
                                  ),
                                ),
                                child: Image.asset(
                                  ImageConstant.imgUnsplashdhoq,
                                  height: getSize(
                                    58.81,
                                  ),
                                  width: getSize(
                                    58.81,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    10.00,
                                  ),
                                  top: getVerticalSize(
                                    10.00,
                                  ),
                                  right: getHorizontalSize(
                                    1.76,
                                  ),
                                  bottom: getVerticalSize(
                                    1.89,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.lightGreenA700,
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      7.46,
                                    ),
                                  ),
                                  border: Border.all(
                                    color: ColorConstant.gray201,
                                    width: getHorizontalSize(
                                      1.00,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          3.87,
                                        ),
                                        top: getVerticalSize(
                                          6.00,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          5.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          2.00,
                                        ),
                                        top: getVerticalSize(
                                          8.00,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          3.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector66,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          2.00,
                                        ),
                                        top: getVerticalSize(
                                          6.00,
                                        ),
                                        right: getHorizontalSize(
                                          4.05,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          5.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            19.00,
                          ),
                          bottom: getVerticalSize(
                            18.16,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: getHorizontalSize(
                                  241.54,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: getVerticalSize(
                                          5.00,
                                        ),
                                      ),
                                      child: Text(
                                        "Host Name",
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
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: getVerticalSize(
                                          14.00,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(
                                                2.50,
                                              ),
                                              bottom: getVerticalSize(
                                                2.50,
                                              ),
                                            ),
                                            child: Container(
                                              height: getSize(
                                                10.00,
                                              ),
                                              width: getSize(
                                                10.00,
                                              ),
                                              child: SvgPicture.asset(
                                                ImageConstant.imgVector7,
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
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Text(
                                "party room name 1...",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(
                                    15,
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
                GlassmorphicContainer(
                  borderRadius: 20,
                  width:size.width,
                  blur: 10,
                  margin: EdgeInsets.only(top: getVerticalSize(5)),
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.2),
                        Color(0xFFFFFFFF).withOpacity(0.2),
                      ],
                      stops: [
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
                  height: getVerticalSize(85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: getSize(
                          58.81,
                        ),
                        width: getSize(
                          58.81,
                        ),
                        margin: EdgeInsets.only(
                          top: getVerticalSize(
                            10.00,
                          ),
                          bottom: getVerticalSize(
                            10.19,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getSize(
                                    29.41,
                                  ),
                                ),
                                child: Image.asset(
                                  ImageConstant.imgUnsplashdhoq,
                                  height: getSize(
                                    58.81,
                                  ),
                                  width: getSize(
                                    58.81,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    10.00,
                                  ),
                                  top: getVerticalSize(
                                    10.00,
                                  ),
                                  right: getHorizontalSize(
                                    1.76,
                                  ),
                                  bottom: getVerticalSize(
                                    1.89,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.lightGreenA700,
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      7.46,
                                    ),
                                  ),
                                  border: Border.all(
                                    color: ColorConstant.gray201,
                                    width: getHorizontalSize(
                                      1.00,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          3.87,
                                        ),
                                        top: getVerticalSize(
                                          6.00,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          5.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          2.00,
                                        ),
                                        top: getVerticalSize(
                                          8.00,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          3.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector66,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          2.00,
                                        ),
                                        top: getVerticalSize(
                                          6.00,
                                        ),
                                        right: getHorizontalSize(
                                          4.05,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          5.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            19.00,
                          ),
                          bottom: getVerticalSize(
                            18.16,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: getHorizontalSize(
                                  241.54,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: getVerticalSize(
                                          5.00,
                                        ),
                                      ),
                                      child: Text(
                                        "Host Name",
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
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: getVerticalSize(
                                          14.00,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(
                                                2.50,
                                              ),
                                              bottom: getVerticalSize(
                                                2.50,
                                              ),
                                            ),
                                            child: Container(
                                              height: getSize(
                                                10.00,
                                              ),
                                              width: getSize(
                                                10.00,
                                              ),
                                              child: SvgPicture.asset(
                                                ImageConstant.imgVector7,
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
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Text(
                                "party room name 1...",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(
                                    15,
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
                GlassmorphicContainer(
                  margin: EdgeInsets.only(
                    top: getVerticalSize(
                      5.00,
                    ),
                  ),
                  borderRadius: 20,
                  width:size.width,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.2),
                        Color(0xFFFFFFFF).withOpacity(0.2),
                      ],
                      stops: [
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
                  height: getVerticalSize(85),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: getSize(
                          58.81,
                        ),
                        width: getSize(
                          58.81,
                        ),
                        margin: EdgeInsets.only(
                          top: getVerticalSize(
                            10.00,
                          ),
                          bottom: getVerticalSize(
                            10.19,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getSize(
                                    29.41,
                                  ),
                                ),
                                child: Image.asset(
                                  ImageConstant.imgUnsplashdhoq,
                                  height: getSize(
                                    58.81,
                                  ),
                                  width: getSize(
                                    58.81,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    10.00,
                                  ),
                                  top: getVerticalSize(
                                    10.00,
                                  ),
                                  right: getHorizontalSize(
                                    1.76,
                                  ),
                                  bottom: getVerticalSize(
                                    1.89,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.lightGreenA700,
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      7.46,
                                    ),
                                  ),
                                  border: Border.all(
                                    color: ColorConstant.gray201,
                                    width: getHorizontalSize(
                                      1.00,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          3.87,
                                        ),
                                        top: getVerticalSize(
                                          6.00,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          5.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          2.00,
                                        ),
                                        top: getVerticalSize(
                                          8.00,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          3.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector66,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          2.00,
                                        ),
                                        top: getVerticalSize(
                                          6.00,
                                        ),
                                        right: getHorizontalSize(
                                          4.05,
                                        ),
                                        bottom: getVerticalSize(
                                          3.92,
                                        ),
                                      ),
                                      child: Container(
                                        height: getVerticalSize(
                                          5.00,
                                        ),
                                        width: getHorizontalSize(
                                          1.00,
                                        ),
                                        child: SvgPicture.asset(
                                          ImageConstant.imgVector55,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            19.00,
                          ),
                          bottom: getVerticalSize(
                            18.16,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: getHorizontalSize(
                                  241.54,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: getVerticalSize(
                                          5.00,
                                        ),
                                      ),
                                      child: Text(
                                        "Host Name",
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
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: getVerticalSize(
                                          14.00,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(
                                                2.50,
                                              ),
                                              bottom: getVerticalSize(
                                                2.50,
                                              ),
                                            ),
                                            child: Container(
                                              height: getSize(
                                                10.00,
                                              ),
                                              width: getSize(
                                                10.00,
                                              ),
                                              child: SvgPicture.asset(
                                                ImageConstant.imgVector7,
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
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Text(
                                "party room name 1...",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(
                                    15,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
