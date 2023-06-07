import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';

class ProvacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(
                1.9839188847292633e-8,
                -0.016875002677067014,
              ),
              end: const Alignment(
                1.0000000074505806,
                1.0000000075763091,
              ),
              colors: [
                ColorConstant.purpleA400D1.withOpacity(0.3),
                ColorConstant.blue90066.withOpacity(0.3),
              ],
            ),
          ),
          child: Stack(
            children: [
              Align(
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
                alignment: Alignment.topCenter,
                child: GlassmorphicContainer(
                  margin: EdgeInsets.only(
                    left: getHorizontalSize(
                      20.00,
                    ),
                    top: getVerticalSize(
                      30.00,
                    ),
                    right: getHorizontalSize(
                      20.00,
                    ),
                  ),
                  borderRadius: 10,
                  width: size.width,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 1,
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
                  height: getVerticalSize(720),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                      Row(
                      children: [
                        Container(
                          height: getVerticalSize(
                            20.00,
                          ),
                          width:
                          getHorizontalSize(
                            20.00,
                          ),
                          margin: EdgeInsets.only(left: getHorizontalSize(10),top: getVerticalSize(15)),
                          child: Icon(Icons.arrow_back,color: Colors.white,size: 25,)
                        ),
                        Container(
                          margin: EdgeInsets.only(left: getHorizontalSize(37),top: getVerticalSize(15)),

                          child: Text(
                            "PRIVACY POLICY"
                                .toUpperCase(),
                            overflow: TextOverflow
                                .ellipsis,
                            textAlign:
                            TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant
                                  .whiteA700,
                              fontSize: getFontSize(
                                24,
                              ),
                              fontFamily: 'Roboto',
                              fontWeight:
                              FontWeight.w700,
                              decoration:
                              TextDecoration
                                  .underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                        Container(
                          width: getHorizontalSize(
                            295.00,
                          ),
                          margin: EdgeInsets.only(
                            top: getVerticalSize(
                              23.00,
                            ),
                            bottom: 20
                          ),
                          child: Text(
                            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.\n\nLorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.\n\nVersions of the Lorem ipsum text have been used in typesetting at least since the 1960s, when it was popularized by advertisements for Letraset transfer sheets.[1] Lorem ipsum was introduced to the digital world in the mid-1980s, when Aldus employed it in graphic and word-processing templates for its desktop publishing program PageMaker. Other popular word processors, including Pages and Microsoft Word, have since adopted Lorem ipsum,[2] as have many LaTeX packages,[3][4][5] web content managers such as Joomla! and WordPress, and CSS libraries such as Semantic UI.[6]In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.\n\nLorem ipsum is typically a corrupted version of De finibus bonorum et malorum, a 1st-century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.\n\nVersions of the Lorem ipsum text have been used in typesetting at least since the 1960s, when it was popularized by advertisements for Letraset transfer sheets.[1] Lorem ipsum was introduced to the digital world in the mid-1980s, when Aldus employed it in graphic and word-processing templates for its desktop publishing program PageMaker. Other popular word processors, including Pages and Microsoft Word, have since adopted Lorem ipsum,[2] as have many LaTeX packages,[3][4][5] web content managers such as Joomla! and WordPress, and CSS libraries such as Semantic UI.[6]"
                                .toUpperCase(),
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:
                              ColorConstant.whiteA700,
                              fontSize: getFontSize(
                                14,
                              ),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
