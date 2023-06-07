import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';

// ignore: must_be_immutable
class RoomAdminSettingItemWidget extends StatelessWidget {
  const RoomAdminSettingItemWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: getVerticalSize(
            9.00,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: getVerticalSize(
                        38.00,
                      ),
                      width: getHorizontalSize(
                        37.65,
                      ),
                      margin: EdgeInsets.only(right: getHorizontalSize(10)),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                getSize(
                                  19.00,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1.0,color: Colors.grey)

                                ),
                                child: Image.asset(
                                  ImageConstant.imgUnsplash3tll91,
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    40.00,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: getVerticalSize(
                                9.50,
                              ),
                              width: getHorizontalSize(
                                9.41,
                              ),
                              margin: EdgeInsets.only(
                                left: getHorizontalSize(
                                  10.00,
                                ),
                                top: getVerticalSize(
                                  10.00,
                                ),
                                right: getHorizontalSize(
                                  0.33,
                                ),
                                bottom: getVerticalSize(
                                  1.64,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.lightGreenA700,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    4.75,
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
                        top: getVerticalSize(
                          10.64,
                        ),
                        left: getHorizontalSize(2),
                        bottom: getVerticalSize(
                          9.36,
                        ),
                      ),
                      child: Text(
                        "Username6",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: getFontSize(
                            15,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(
                      75.00,
                    ),
                    top: getVerticalSize(
                      10.00,
                    ),
                    bottom: getVerticalSize(
                      10.00,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: getVerticalSize(
                      15,
                    ),
                    width: getHorizontalSize(
                      38,
                    ),
                    decoration:BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.textStart.withOpacity(0.8),
                          ColorConstant.textEnd.withOpacity(0.8)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      "Remove",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getFontSize(
                          9,
                        ),
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                child: Divider(color: Colors.white30,thickness: 1,),
                padding: EdgeInsets.only(left: getHorizontalSize(50),right: getHorizontalSize(20))),
          ],
        ),
      ),
    );
  }
}
