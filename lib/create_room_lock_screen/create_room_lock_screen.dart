import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';

class CreateRoomLockScreen extends StatefulWidget {
  const CreateRoomLockScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomLockScreen> createState() => _CreateRoomLockScreenState();
}

class _CreateRoomLockScreenState extends State<CreateRoomLockScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(
                    0.14444442420767467,
                    0.1956249900768232,
                  ),
                  end: const Alignment(
                    0.999999913809204,
                    0.9999999743681396,
                  ),
                  colors: [
                    ColorConstant.lime400,
                    ColorConstant.green500,
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(
                      0.14444442420767467,
                      0.1956249900768232,
                    ),
                    end: const Alignment(
                      0.999999913809204,
                      0.9999999743681396,
                    ),
                    colors: [
                      ColorConstant.lime400,
                      ColorConstant.green500,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            27.00,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    24.00,
                                  ),
                                  right: getHorizontalSize(
                                    24.00,
                                  ),
                                ),
                                child: Container(
                                  height: getSize(
                                    16.00,
                                  ),
                                  width: getSize(
                                    16.00,
                                  ),
                                  child: SvgPicture.asset(
                                    ImageConstant.imgVector,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    30.00,
                                  ),
                                  top: getVerticalSize(
                                    52.00,
                                  ),
                                  right: getHorizontalSize(
                                    30.00,
                                  ),
                                ),
                                child: Text(
                                  "CHAT",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA7007f,
                                    fontSize: getFontSize(
                                      80,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: getVerticalSize(
                                  128.00,
                                ),
                                width: getHorizontalSize(
                                  145.00,
                                ),
                                margin: EdgeInsets.only(
                                  left: getHorizontalSize(
                                    30.00,
                                  ),
                                  top: getVerticalSize(
                                    47.00,
                                  ),
                                  right: getHorizontalSize(
                                    30.00,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: getHorizontalSize(
                                            10.00,
                                          ),
                                        ),
                                        child: Image.asset(
                                          ImageConstant.imgUnsplash889qh5,
                                          height: getSize(
                                            128.00,
                                          ),
                                          width: getSize(
                                            128.00,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            10.00,
                                          ),
                                          top: getVerticalSize(
                                            10.00,
                                          ),
                                          bottom: getVerticalSize(
                                            9.00,
                                          ),
                                        ),
                                        child: Container(
                                          height: getSize(
                                            39.00,
                                          ),
                                          width: getSize(
                                            39.00,
                                          ),
                                          child: SvgPicture.asset(
                                            ImageConstant.imgGroup12571,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    72.00,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          33.00,
                                        ),
                                        top: getVerticalSize(
                                          2.00,
                                        ),
                                        bottom: getVerticalSize(
                                          2.00,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.black90033,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            12.00,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.black90019,
                                          width: getHorizontalSize(
                                            1.00,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                10.00,
                                              ),
                                              top: getVerticalSize(
                                                4.00,
                                              ),
                                              bottom: getVerticalSize(
                                                5.73,
                                              ),
                                            ),
                                            child: Container(
                                              height: getVerticalSize(
                                                11.27,
                                              ),
                                              width: getHorizontalSize(
                                                9.80,
                                              ),
                                              child: SvgPicture.asset(
                                                ImageConstant.imgVector3,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                6.00,
                                              ),
                                              top: getVerticalSize(
                                                3.00,
                                              ),
                                              right: getHorizontalSize(
                                                10.00,
                                              ),
                                              bottom: getVerticalSize(
                                                3.00,
                                              ),
                                            ),
                                            child: Text(
                                              "public",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    ColorConstant.whiteA7007f,
                                                fontSize: getFontSize(
                                                  13,
                                                ),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: getVerticalSize(
                                        25.00,
                                      ),
                                      width: getHorizontalSize(
                                        68.43,
                                      ),
                                      margin: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          11.20,
                                        ),
                                        right: getHorizontalSize(
                                          174.57,
                                        ),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: getVerticalSize(
                                                25.00,
                                              ),
                                              width: getHorizontalSize(
                                                68.43,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    15.00,
                                                  ),
                                                ),
                                                border: Border.all(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  width: getHorizontalSize(
                                                    1.00,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                left: getHorizontalSize(
                                                  2.13,
                                                ),
                                                top: getVerticalSize(
                                                  2.00,
                                                ),
                                                right: getHorizontalSize(
                                                  2.50,
                                                ),
                                                bottom: getVerticalSize(
                                                  2.00,
                                                ),
                                              ),
                                              // decoration: BoxDecoration(
                                              //   color:
                                              //       ColorConstant.whiteA70033,
                                              //   borderRadius:
                                              //       BorderRadius.circular(
                                              //     getHorizontalSize(
                                              //       12.00,
                                              //     ),
                                              //   ),
                                              //   border: Border.all(
                                              //     color:
                                              //         ColorConstant.whiteA700,
                                              //     width: getHorizontalSize(
                                              //       1.00,
                                              //     ),
                                              //   ),
                                              // ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        10.00,
                                                      ),
                                                      top: getVerticalSize(
                                                        5.00,
                                                      ),
                                                      bottom: getVerticalSize(
                                                        4.73,
                                                      ),
                                                    ),
                                                    child: Container(
                                                      height: getVerticalSize(
                                                        11.27,
                                                      ),
                                                      width: getHorizontalSize(
                                                        9.80,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        ImageConstant
                                                            .imgVector4,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        6.00,
                                                      ),
                                                      top: getVerticalSize(
                                                        3.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        10.00,
                                                      ),
                                                      bottom: getVerticalSize(
                                                        3.00,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Lock",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: ColorConstant
                                                            .whiteA700,
                                                        fontSize: getFontSize(
                                                          13,
                                                        ),
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  30.00,
                                ),
                                top: getVerticalSize(
                                  56.00,
                                ),
                                right: getHorizontalSize(
                                  30.00,
                                ),
                              ),
                              child: Container(
                                height: getVerticalSize(
                                  38.00,
                                ),
                                width: getHorizontalSize(
                                  300.00,
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Channel Name',
                                    hintStyle: TextStyle(
                                      fontSize: getFontSize(
                                        25.0,
                                      ),
                                      color: ColorConstant.whiteA7004c,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstant.whiteA7004c,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstant.whiteA7004c,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      top: getVerticalSize(
                                        2.15,
                                      ),
                                      bottom: getVerticalSize(
                                        11.15,
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: ColorConstant.whiteA7004c,
                                    fontSize: getFontSize(
                                      25.0,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: getSize(
                        81.00,
                      ),
                      width: getSize(
                        81.00,
                      ),
                      margin: EdgeInsets.only(
                        left: getHorizontalSize(
                          140.00,
                        ),
                        top: getVerticalSize(
                          58.00,
                        ),
                        right: getHorizontalSize(
                          139.00,
                        ),
                        bottom: getVerticalSize(
                          20.00,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: getSize(
                                67.00,
                              ),
                              width: getSize(
                                67.00,
                              ),
                              margin: EdgeInsets.only(
                                left: getHorizontalSize(
                                  7.00,
                                ),
                                top: getVerticalSize(
                                  7.00,
                                ),
                                right: getHorizontalSize(
                                  7.00,
                                ),
                                bottom: getVerticalSize(
                                  7.00,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: getSize(
                                        67.00,
                                      ),
                                      width: getSize(
                                        67.00,
                                      ),
                                      child: CircularProgressIndicator(
                                        value: 0.5,
                                        backgroundColor: ColorConstant.red504c,
                                        strokeWidth: getHorizontalSize(
                                          3.00,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          31.00,
                                        ),
                                        top: getVerticalSize(
                                          31.00,
                                        ),
                                        right: getHorizontalSize(
                                          31.00,
                                        ),
                                        bottom: getVerticalSize(
                                          31.00,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(
                                            2.50,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                1.00,
                                              ),
                                              top: getVerticalSize(
                                                1.00,
                                              ),
                                              right: getHorizontalSize(
                                                1.00,
                                              ),
                                              bottom: getVerticalSize(
                                                2.00,
                                              ),
                                            ),
                                            child: const Text(
                                              "OK",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: getSize(
                                81.00,
                              ),
                              width: getSize(
                                81.00,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    40.50,
                                  ),
                                ),
                                border: Border.all(
                                  color: ColorConstant.whiteA70066,
                                  width: getHorizontalSize(
                                    3.00,
                                  ),
                                ),
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
          ),
        ),
      ),
    );
  }
}
