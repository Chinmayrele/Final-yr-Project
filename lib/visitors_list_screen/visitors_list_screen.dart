import 'package:final_yr_project/visitors_list_screen/widgets/visitors_list_item_widget.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import 'package:flutter/material.dart';

import '../follower_list_screen/follower_list_screen.dart';
import '../following_list_screen/following_list_screen.dart';
import '../friends_list_screen/friends_list_screen.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.whiteA700,
              ),
              child: Column(
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
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GlassmorphicContainer(
                                    width: size.width,
                                    height: hSize * 0.09,
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
                                    child: Row(
                                      children: [
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //     top: getVerticalSize(
                                        //       8.00,
                                        //     ),
                                        //   ),
                                        //   child: GestureDetector(
                                        //     onTap: (){
                                        //       Navigator.of(context).pop(false);
                                        //     },
                                        //     child: Container(
                                        //       margin: EdgeInsets.only(left: getHorizontalSize(10)),
                                        //
                                        //       child: SvgPicture.asset(
                                        //         ImageConstant.imgVector,
                                        //         fit: BoxFit.fill,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              12.36,
                                            ),
                                            top: getVerticalSize(
                                              20.00,
                                            ),
                                            bottom: getVerticalSize(
                                              0.00,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FriendsListScreen()));
                                                      },
                                                      child: Text(
                                                        "Friends",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .bluegray400,
                                                          fontSize: getFontSize(
                                                            15,
                                                          ),
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: getVerticalSize(
                                                            3.50,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                            3.50,
                                                          ),
                                                          left:
                                                              getHorizontalSize(
                                                                  10)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          FollowingListScreen()));
                                                        },
                                                        child: Text(
                                                          "Followings",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: ColorConstant
                                                                .bluegray400,
                                                            fontSize:
                                                                getFontSize(
                                                              16,
                                                            ),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: getVerticalSize(
                                                            3.50,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                            3.50,
                                                          ),
                                                          left:
                                                              getHorizontalSize(
                                                                  10)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          FollowerListScreen()));
                                                        },
                                                        child: Text(
                                                          "Followers",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: ColorConstant
                                                                .bluegray400,
                                                            fontSize:
                                                                getFontSize(
                                                              16,
                                                            ),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: getVerticalSize(
                                                            3.50,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                            3.50,
                                                          ),
                                                          left:
                                                              getHorizontalSize(
                                                                  10)),
                                                      child: GradientText(
                                                        "Visitors",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .deepPurple900,
                                                          fontSize: getFontSize(
                                                            22,
                                                          ),
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        colors: [
                                                          ColorConstant
                                                              .textStart,
                                                          ColorConstant.textEnd
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      1.00,
                                                    ),
                                                    right: getHorizontalSize(
                                                      25.00,
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
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  height: getVerticalSize(
                                                    2.00,
                                                  ),
                                                  width: getHorizontalSize(
                                                    20.00,
                                                  ),
                                                  margin: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      235.00,
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
                                  height: hSize * 0.86,
                                  margin: EdgeInsets.only(
                                    top: getVerticalSize(5),
                                    left: getHorizontalSize(
                                      14.00,
                                    ),
                                    right: getHorizontalSize(
                                      13.00,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 0,
                                    itemBuilder: (context, index) {
                                      return const VisitorsItemWidget();
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
      ),
    );
  }
}
