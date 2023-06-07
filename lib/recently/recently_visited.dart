import 'package:final_yr_project/recently/widgets/recently_item_widget.dart';
import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol/recently/widgets/recently_item_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../my_rooms_screen/my_rooms_screen.dart';

class RecentlyVisitedScreen extends StatefulWidget {

  @override
  State<RecentlyVisitedScreen> createState() => _RecentlyVisitedScreenState();
}

class _RecentlyVisitedScreenState extends State<RecentlyVisitedScreen> {

  List date = ["Today" ,"Yesterday" , "22/04/2022"];
  @override
  Widget build(BuildContext context) {
    var hSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstant.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GlassmorphicContainer(
                                  margin: EdgeInsets.only(
                                    bottom: getVerticalSize(
                                      10.00,
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
                                      Colors.white10.withOpacity(0.2),
                                      Colors.white10.withOpacity(0.2),
                                    ],
                                  ),
                                  height: getVerticalSize(70),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            16.00,
                                          ),

                                        ),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pop(false);
                                          },


                                            child: Icon(Icons.arrow_back,size:25)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            10.36,
                                          ),
                                          top: getVerticalSize(
                                            15.00,
                                          ),
                                          bottom: getVerticalSize(
                                            10.00,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: getVerticalSize(
                                                        3.50,
                                                      ),
                                                      bottom: getVerticalSize(
                                                        3.50,
                                                      ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyRoomsScreen()));

                                                      },
                                                      child: Text(
                                                        "Rooms",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontSize: getFontSize(
                                                            18,
                                                          ),
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        15.00,
                                                      ),
                                                    ),
                                                    child: GradientText(
                                                     'Recently Visited',
                                                            style: TextStyle(
                                                              color: ColorConstant
                                                                  .deepPurple900,
                                                              fontSize:
                                                                  getFontSize(
                                                                23,
                                                              ),
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ), colors: [
                                                      ColorConstant.textStart,
                                                      ColorConstant.textEnd
                                                    ],
                                                          ),

                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    66.00,
                                                  ),
                                                  top: getVerticalSize(
                                                    2.00,
                                                  ),
                                                  right: getHorizontalSize(
                                                    66.00,
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  ImageConstant.imageNotFound,
                                                  height: getVerticalSize(
                                                    2.00,
                                                  ),
                                                  width: getHorizontalSize(
                                                    20.00,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: getVerticalSize(
                                                  2.00,
                                                ),
                                                width: getHorizontalSize(
                                                  20.00,
                                                ),
                                                margin: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    70.00,
                                                  ),
                                                  top: getVerticalSize(
                                                    2.00,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      ColorConstant.textStart,
                                                      ColorConstant.textEnd
                                                    ],
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                    getHorizontalSize(
                                                      10.00,
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
                              Container(
                                margin:EdgeInsets.only(left:10,right:10),
                                height: getVerticalSize(685),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return RecentlyVisitedWidget(index:date[index]);
                                  },
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
    );
  }
}
