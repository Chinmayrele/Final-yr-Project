import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../model/user_model.dart';
import '../usernames/new.dart';

class ChatAppbar extends StatefulWidget {
  const ChatAppbar({Key? key, required this.chatterData}) : super(key: key);
  final UserBasicModel chatterData;

  @override
  State<ChatAppbar> createState() => _ChatAppbarState();
}

class _ChatAppbarState extends State<ChatAppbar> {
  @override
  Widget build(BuildContext context) {
    var hSize = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GlassmorphicContainer(
                width: double.infinity,
                height: hSize * 0.09,
                borderRadius: 15,
                blur: 15,
                alignment: Alignment.bottomCenter,
                border: 4,
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
                    Colors.white10.withOpacity(0.3),
                    Colors.white10.withOpacity(0.3),
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
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: getVerticalSize(
                            21.00,
                          ),
                          bottom: getVerticalSize(
                            9.81,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              16.00,
                            ),
                            right: getHorizontalSize(
                              15.59,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 7),
                                        height: getVerticalSize(
                                          13.67,
                                        ),
                                        width: getHorizontalSize(
                                          14.64,
                                        ),
                                        child: const Icon(Icons.arrow_back,
                                            color: Colors.black)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                        10.88,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height: getVerticalSize(
                                            33.19,
                                          ),
                                          width: getHorizontalSize(
                                            34.48,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: getHorizontalSize(
                                                      1.29,
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getSize(
                                                        16.59,
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      widget.chatterData.imageUrl,
                                                      height: getSize(
                                                        33.19,
                                                      ),
                                                      width: getSize(
                                                        33.19,
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      10.00,
                                                    ),
                                                    top: getVerticalSize(
                                                      5.00,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      4,
                                                    ),
                                                  ),
                                                  child: SizedBox(
                                                    height: getSize(
                                                      10.00,
                                                    ),
                                                    width: getSize(
                                                      10.00,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      ImageConstant
                                                          .imgGroup1281,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              9.00,
                                            ),
                                            bottom: getVerticalSize(
                                              4.19,
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             Profile()));
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.chatterData.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.gray800,
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //     right: getHorizontalSize(
                                                //       10.00,
                                                //     ),
                                                //   ),
                                                //   child: Text(
                                                //     "1 minutes ago",
                                                //     overflow:
                                                //         TextOverflow.ellipsis,
                                                //     textAlign: TextAlign.left,
                                                //     style: TextStyle(
                                                //       color:
                                                //           ColorConstant.gray600,
                                                //       fontSize: getFontSize(
                                                //         10,
                                                //       ),
                                                //       fontFamily: 'Roboto',
                                                //       fontWeight:
                                                //           FontWeight.w400,
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //     height: getVerticalSize(
                              //       22.00,
                              //     ),
                              //     width: getHorizontalSize(
                              //       15.41,
                              //     ),
                              //     child: Icon(
                              //       Icons.mic,
                              //       color: Colors.grey.shade600,
                              //     )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //     left: getHorizontalSize(
            //       10.00,
            //     ),
            //     top: hSize * 0.015,
            //   ),
            //   child: Image.asset(
            //     ImageConstant.imgGroup1255,
            //     height: getVerticalSize(
            //       34.00,
            //     ),
            //     width: getHorizontalSize(
            //       73.00,
            //     ),
            //     fit: BoxFit.fill,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
