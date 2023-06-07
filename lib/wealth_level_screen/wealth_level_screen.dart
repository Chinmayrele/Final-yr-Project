import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../lol_store_screen/lol_store_screen.dart';

class WealthLevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.whiteA700,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: getVerticalSize(
                        776.00,
                      ),
                      width: size.width,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteA700,
                      ),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: getVerticalSize(
                                776.00,
                              ),
                              width: size.width,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Image.asset(
                                      ImageConstant.imgUnsplash8uzpyn,
                                      height: getVerticalSize(
                                        776.00,
                                      ),
                                      width: getHorizontalSize(
                                        360.00,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        GlassmorphicContainer(
                                          width: double.infinity,
                                          borderRadius: 15,
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
                                              Colors.white10.withOpacity(0.2),
                                              Colors.white10.withOpacity(0.2),
                                            ],
                                          ),
                                          height: getVerticalSize(70),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: size.width,
                                                  margin: EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      25.00,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      13.00,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        16.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        15.00,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsets
                                                                  .only(
                                                                // top:
                                                                // getVerticalSize(
                                                                //   6.00,
                                                                // ),
                                                                bottom:
                                                                getVerticalSize(
                                                                  8,
                                                                ),
                                                              ),
                                                              child: Container(
                                                                height:
                                                                getVerticalSize(
                                                                  13.67,
                                                                ),
                                                                width:
                                                                getHorizontalSize(
                                                                  14.64,
                                                                ),
                                                                child:
                                                               Icon(Icons.arrow_back,size:25)
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsets
                                                                  .only(
                                                                left:
                                                                getHorizontalSize(
                                                                  15,
                                                                ),
                                                              ),
                                                              child: GradientText(
                                                                "Wealth level",
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                textAlign:
                                                                TextAlign
                                                                    .left,
                                                                style:
                                                                TextStyle(
                                                                  color: ColorConstant
                                                                      .deepPurple900,
                                                                  fontSize:
                                                                  getFontSize(
                                                                    22,
                                                                  ),
                                                                  fontFamily:
                                                                  'Roboto',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                                colors: [
                                                                  ColorConstant.textStart,
                                                                  ColorConstant.textEnd
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                            top:
                                                            getVerticalSize(
                                                              4.00,
                                                            ),
                                                            bottom:
                                                            getVerticalSize(
                                                              5.00,
                                                            ),
                                                          ),
                                                          child: Container(
                                                            height: getSize(
                                                              17.00,
                                                            ),
                                                            width: getSize(
                                                              17.00,
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              ImageConstant
                                                                  .imgGroup1533,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(

                              top: getVerticalSize(
                                87.00,
                              ),

                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            30.00,
                                          ),
                                          top: getVerticalSize(
                                            12.00,
                                          ),
                                          bottom: getVerticalSize(
                                            13.00,
                                          ),
                                        ),
                                        child: Text(
                                          "Level 1",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: ColorConstant.gray800,
                                            fontSize: getFontSize(
                                              40,
                                            ),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: getHorizontalSize(
                                            30,
                                          ),
                                        ),
                                        child: Image.asset(
                                          ImageConstant.img2bronzelvl1,
                                          height: getVerticalSize(
                                            72.00,
                                          ),
                                          width: getHorizontalSize(
                                            60.40,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          38.00,
                                        ),
                                        top: getVerticalSize(
                                          19.00,
                                        ),
                                        right: getHorizontalSize(
                                          38.00,
                                        ),
                                        bottom:getVerticalSize(8)
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Need 50 more to level up',
                                            style: TextStyle(
                                              color: ColorConstant.gray800,
                                              fontSize: getFontSize(
                                                12,
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
                                ),
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal: getHorizontalSize(40)),
                                  child: LinearPercentIndicator( //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 10.0,
                                    percent:0.5,
                                    linearGradient: LinearGradient(
                                      colors: [
                                        ColorConstant.textStart,
                                        ColorConstant.textEnd
                                      ],
                                    ),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                        19.03,
                                      ),
                                      top: getVerticalSize(
                                        2.50,
                                      ),
                                      right: getHorizontalSize(
                                        19.03,
                                      ),
                                    ),
                                    child: Text(
                                      "100/150",
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
                                  ),
                                ),


                                GlassmorphicContainer(
                                  width: size.width,
                                  height: getVerticalSize(525),
                                  margin: EdgeInsets.only(
                                    top: getVerticalSize(
                                      20.00,
                                    ),
                                  ),
                                  borderRadius: 15,
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
                                      Colors.white10.withOpacity(0.2),
                                      Colors.white10.withOpacity(0.2),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: GlassmorphicContainer(
                                          alignment: Alignment.center,
                                          height: getVerticalSize(
                                            50.00,
                                          ),
                                          width: size.width,
                                          borderRadius: 15,
                                          blur: 15,
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
                                          child: Text(
                                            "Basic Privileges",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .gray800,
                                              fontSize: getFontSize(
                                                16,
                                              ),
                                              fontFamily: 'Roboto',
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LolStoreScreen()));
                                        },
                                        child: GlassmorphicContainer(
                                          alignment: Alignment.center,
                                          height: 50,
                                          margin: EdgeInsets.only(
                                            top: getVerticalSize(
                                              15.00,
                                            ),
                                            left:getHorizontalSize(15),
                                            right:getHorizontalSize(15),
                                          ),
                                          borderRadius: 15,
                                          width:size.width,
                                          blur: 10,
                                          border: 1.5,
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    20.00,
                                                  ),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      height: getVerticalSize(
                                                        20.48,
                                                      ),
                                                      width: getHorizontalSize(
                                                        48.00,
                                                      ),
                                                      child: Stack(
                                                        alignment:
                                                        Alignment.centerLeft,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets.only(
                                                                top:
                                                                getVerticalSize(
                                                                  6.00,
                                                                ),
                                                                bottom:
                                                                getVerticalSize(
                                                                  3.48,
                                                                ),
                                                              ),
                                                              padding:
                                                              EdgeInsets.only(
                                                                left:
                                                                getHorizontalSize(
                                                                  13.00,
                                                                ),
                                                                right:
                                                                getHorizontalSize(
                                                                  3.00,
                                                                ),
                                                                top:
                                                                getVerticalSize(
                                                                  2.00,
                                                                ),
                                                                bottom:
                                                                getVerticalSize(
                                                                  1.00,
                                                                ),
                                                              ),
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                  getHorizontalSize(
                                                                    3.00,
                                                                  ),
                                                                ),
                                                                gradient:
                                                                LinearGradient(
                                                                  begin: Alignment(
                                                                    0.15436241758654828,
                                                                    0.572507796678539,
                                                                  ),
                                                                  end: Alignment(
                                                                    0.9999999879479102,
                                                                    0.572507796678539,
                                                                  ),
                                                                  colors: [
                                                                    ColorConstant
                                                                        .lime800E5,
                                                                    ColorConstant
                                                                        .gray900E5,
                                                                  ],
                                                                ),
                                                              ),
                                                              child: Text(
                                                                "Level 2",
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                textAlign:
                                                                TextAlign.left,
                                                                style: TextStyle(
                                                                  color:
                                                                  ColorConstant
                                                                      .whiteA700,
                                                                  fontSize:
                                                                  getFontSize(
                                                                    7,
                                                                  ),
                                                                  fontFamily:
                                                                  'Roboto',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                right:
                                                                getHorizontalSize(
                                                                  10.00,
                                                                ),
                                                              ),
                                                              child: Image.asset(
                                                                ImageConstant
                                                                    .img2bronzelvl11,
                                                                height:
                                                                getVerticalSize(
                                                                  22.48,
                                                                ),
                                                                width:
                                                                getHorizontalSize(
                                                                  20.17,
                                                                ),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          12.00,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Exclusive Big Emojik Pack",
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        textAlign:
                                                        TextAlign.justify,
                                                        style: TextStyle(
                                                          color:
                                                          ColorConstant.gray800,
                                                          fontSize: getFontSize(
                                                            13,
                                                          ),
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: getHorizontalSize(
                                                    25.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    15.23,
                                                  ),
                                                ),
                                                child: Container(
                                                  height: getVerticalSize(
                                                    6.02,
                                                  ),
                                                  width: getHorizontalSize(
                                                    4.03,
                                                  ),
                                                  child: Icon(Icons.arrow_forward_ios,color: Colors.black45,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
