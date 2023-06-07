import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../friends_list_screen/friends_list_screen.dart';

// ignore: must_be_immutable
class CollectionsItemWidget extends StatefulWidget {
  const CollectionsItemWidget({
    Key? key,
    required this.listFrameData,
  }) : super(key: key);
  final Object? listFrameData;

  @override
  State<CollectionsItemWidget> createState() => _CollectionsItemWidgetState();
}

class _CollectionsItemWidgetState extends State<CollectionsItemWidget> {
  // "diamonds": selectedDiamonds,
  // "frameName": selectedFrameName,
  // "validity": selectedValidity,
  // "imageurl": selectedImageUrl,
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FriendsListScreen()));
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
            top: getVerticalSize(5.50),
            bottom: getVerticalSize(5.50),
          ),
          child: GlassmorphicContainer(
            borderRadius: 15,
            width: getHorizontalSize(150),
            height: getVerticalSize(183),
            blur: 15,
            alignment: Alignment.bottomCenter,
            border: 2,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.2),
                  const Color(0xFFFFFFFF).withOpacity(0.2),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: getVerticalSize(120.00),
                    width: getHorizontalSize(153.00),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          getHorizontalSize(8.00),
                        ),
                        topRight: Radius.circular(
                          getHorizontalSize(8.00),
                        ),
                        bottomLeft: Radius.circular(
                          getHorizontalSize(0.00),
                        ),
                        bottomRight: Radius.circular(
                          getHorizontalSize(0.00),
                        ),
                      ),
                      gradient: LinearGradient(
                        begin: const Alignment(
                          -0.001697166058858155,
                          0.5074751480283091,
                        ),
                        end: const Alignment(
                          0.9983028339411415,
                          0.5074752102704458,
                        ),
                        colors: [
                          ColorConstant.deepPurple90019,
                          ColorConstant.purple50019,
                        ],
                      ),
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            getHorizontalSize(8.00),
                          ),
                          topRight: Radius.circular(
                            getHorizontalSize(8.00),
                          ),
                          bottomLeft: Radius.circular(
                            getHorizontalSize(0.00),
                          ),
                          bottomRight: Radius.circular(
                            getHorizontalSize(0.00),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          //FRAME FROM SERVER
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(24.00),
                                  top: getVerticalSize(8.00),
                                  right: getHorizontalSize(24.00),
                                  bottom: getVerticalSize(7.00),
                                ),
                                child: Image.network(
                                  (widget.listFrameData
                                      as Map<String, dynamic>)['imageurl'],
                                  height: getSize(105.00),
                                  width: getSize(105.00),
                                  fit: BoxFit.cover,
                                )
                                // Image.asset(
                                // ImageConstant.imgFramebirthday,
                                // height: getSize(105.00),
                                // width: getSize(105.00),
                                // fit: BoxFit.fill,
                                // ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(14.00),
                      top: getVerticalSize(12.00),
                      // right: getHorizontalSize(18.00),
                    ),
                    child: Text(
                      (widget.listFrameData
                          as Map<String, dynamic>)['frameName'],
                      // "Bride Avatar Frames",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.gray800,
                        fontSize: getFontSize(
                          14,
                        ),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(19.00),
                    top: getVerticalSize(5.00),
                    right: getHorizontalSize(19.00),
                    bottom: getVerticalSize(15.00),
                  ),
                  child: Text(
                    (widget.listFrameData
                                as Map<String, dynamic>)['validity'] ==
                            -1
                        ? "Permanent"
                        : (widget.listFrameData
                                    as Map<String, dynamic>)['validity']
                                .toString() +
                            " Day",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.bluegray400,
                      fontSize: getFontSize(
                        12,
                      ),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
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
