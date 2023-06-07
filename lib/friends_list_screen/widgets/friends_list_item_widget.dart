import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../model/user_model.dart';
import '../../usernames/newuser.dart';

// ignore: must_be_immutable
class FriendsListItemWidget extends StatefulWidget {
  const FriendsListItemWidget({
    Key? key,
    required this.friendsDataList,
  }) : super(key: key);
  final UserBasicModel friendsDataList;

  @override
  State<FriendsListItemWidget> createState() => _FriendsListItemWidgetState();
}

class _FriendsListItemWidgetState extends State<FriendsListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) =>
                OtherUser(otherUserData: widget.friendsDataList)));
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
        height: getVerticalSize(79),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getSize(29.00),
                    ),
                    child: Image.network(
                      widget.friendsDataList.imageUrl,
                      fit: BoxFit.cover,
                      height: getSize(58.0),
                      width: getSize(58.0),
                    ),
                    // Image.asset(
                    //   ImageConstant.imgUnsplash3tll9,
                    //   height: getSize(
                    //     58.00,
                    //   ),
                    //   width: getSize(
                    //     58.00,
                    //   ),
                    //   fit: BoxFit.fill,
                    // ),
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
                          widget.friendsDataList.name,
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
                            "ID : ${widget.friendsDataList.frontUid}",
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
            Padding(
              padding: EdgeInsets.only(
                // left: getHorizontalSize(87.00),
                top: getVerticalSize(29.00),
                right: getHorizontalSize(15.00),
                bottom: getVerticalSize(29.00),
              ),
              child: Container(
                alignment: Alignment.center,
                height: getVerticalSize(20.00),
                width: getHorizontalSize(48.00),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(18.50),
                    ),
                    color: Colors.transparent,
                    border: Border.all(color: ColorConstant.deepPurple900),
                    gradient: LinearGradient(
                      colors: [ColorConstant.textStart, ColorConstant.textEnd],
                    )),
                child: GradientText(
                  "Friend",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: ColorConstant.deepPurple900,
                    fontSize: getFontSize(10),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  colors: [ColorConstant.textStart, ColorConstant.textEnd],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
