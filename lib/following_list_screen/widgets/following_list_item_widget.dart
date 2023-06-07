import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../model/user_model.dart';
import '../../usernames/newuser.dart';

// ignore: must_be_immutable
class FollowingListItemWidget extends StatefulWidget {
  const FollowingListItemWidget({
    Key? key,
    // required this.listData,
    required this.userDataList,
  }) : super(key: key);
  // final String listData;
  final UserBasicModel userDataList;

  @override
  State<FollowingListItemWidget> createState() =>
      _FollowingListItemWidgetState();
}

class _FollowingListItemWidgetState extends State<FollowingListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => OtherUser(otherUserData: widget.userDataList)));
      },
      child: GlassmorphicContainer(
        margin: EdgeInsets.only(
          top: getVerticalSize(2.50),
          bottom: getVerticalSize(2.50),
        ),
        borderRadius: 15,
        width: size.width,
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
              1
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(10.00),
                top: getVerticalSize(10.00),
                bottom: getVerticalSize(10.00),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: getSize(58.00),
                    width: getSize(58.00),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              getSize(29.00),
                            ),
                            child: Image.network(
                              widget.userDataList.imageUrl,
                              fit: BoxFit.cover,
                              height: getSize(58.0),
                              width: getSize(58.0),
                            ),
                            // Image.asset(
                            //   ImageConstant.imgUnsplash3tll91,
                            //   height: getSize(
                            //     58.00,
                            //   ),
                            //   width: getSize(
                            //     58.00,
                            //   ),
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: getSize(14.50),
                            width: getSize(14.50),
                            margin: EdgeInsets.only(
                              left: getHorizontalSize(10.00),
                              top: getVerticalSize(10.00),
                              right: getHorizontalSize(0.50),
                              bottom: getVerticalSize(2.50),
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstant.lightGreenA700,
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(7.25),
                              ),
                              border: Border.all(
                                color: ColorConstant.gray200,
                                width: getHorizontalSize(1.00),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(15.00),
                      top: getVerticalSize(7.50),
                      bottom: getVerticalSize(7.50),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.userDataList.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(18),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: getVerticalSize(6.00),
                            right: getHorizontalSize(10.00),
                          ),
                          child: Text(
                            "ID : ${widget.userDataList.frontUid}",
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
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(
                  // left: getHorizontalSize(72.00),
                  top: getVerticalSize(29.00),
                  right: getHorizontalSize(15.00),
                  bottom: getVerticalSize(29.00),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: getVerticalSize(20.00),
                  width: getHorizontalSize(63.00),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(18.50),
                      ),
                      border: Border.all(color: ColorConstant.deepPurple900)),
                  child: Text(
                    "Following",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.deepPurple900,
                      fontSize: getFontSize(10),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
