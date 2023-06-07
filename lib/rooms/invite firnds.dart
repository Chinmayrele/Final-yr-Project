import 'package:final_yr_project/rooms/widgets/invite_friends_in_room_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol/rooms/widgets/invite_friends_in_room_item_widget.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';

class Inviting extends StatefulWidget {
  const Inviting({Key? key}) : super(key: key);

  @override
  State<Inviting> createState() => _InvitingState();
}

class _InvitingState extends State<Inviting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(520),

      child: GlassmorphicContainer(
          borderRadius: 0,
          width:size.width,
          blur: 15,
          alignment: Alignment.bottomCenter,
          border: 1,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.1),
                Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: [
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
                      alignment: Alignment.centerLeft,
                      child: Container(
                        alignment: Alignment.centerLeft,
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
                              offset: Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: getHorizontalSize(20)),
                          child: Text(
                            "Invite to join the room",
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
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return InviteFriendsInRoomItemWidget();
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
  }
}
