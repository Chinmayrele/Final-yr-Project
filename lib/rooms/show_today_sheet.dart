import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';
import '../model/user_model.dart';
import 'widgets/todaywidget.dart';

showTodaySheet(
  BuildContext context,
  List<UserBasicModel> todayListData,
  List<dynamic> usersToday,
) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return SizedBox(
          height: getVerticalSize(520),
          child: GlassmorphicContainer(
            borderRadius: 0,
            width: size.width,
            blur: 15,
            alignment: Alignment.topCenter,
            border: 1,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.1),
                  const Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: const [
                  0.1,
                  1,
                ]),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white10.withOpacity(0.05),
                Colors.white10.withOpacity(0.05),
              ],
            ),
            height: getVerticalSize(520),
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: getVerticalSize(
                      3.00,
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
                          alignment: Alignment.center,
                          height: getVerticalSize(
                            40.00,
                          ),
                          width: size.width,
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA70019,
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.black90033,
                                spreadRadius: getHorizontalSize(
                                  2.00,
                                ),
                                blurRadius: getHorizontalSize(
                                  2.00,
                                ),
                                offset: const Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: getHorizontalSize(0)),
                            child: Text(
                              "Today",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontSize: getFontSize(
                                  16,
                                ),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(
                            18.00,
                          ),
                          top: getVerticalSize(
                            14.00,
                          ),
                          right: getHorizontalSize(
                            14.00,
                          ),
                        ),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          // itemCount: todayListData.length,
                          itemCount: usersToday.length,
                          itemBuilder: (context, index) {
                            return TodayWidget(
                              // todayData: todayListData[index],
                              todayList: usersToday[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
