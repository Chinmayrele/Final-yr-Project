
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../beans_expenses_screen/widgets/beans_expenses_item_widget.dart';
import 'package:flutter/material.dart';

import '../beans_income_screen/beans_income_screen.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';

class BeansExpensesScreen extends StatefulWidget {
  const BeansExpensesScreen({Key? key}) : super(key: key);

  @override
  State<BeansExpensesScreen> createState() => _BeansExpensesScreenState();
}

class _BeansExpensesScreenState extends State<BeansExpensesScreen> {
  @override
  Widget build(BuildContext context) {
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
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
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: getVerticalSize(
                                776.00,
                              ),
                              width: size.width,
                              child: Stack(
                                alignment: Alignment.topLeft,
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
                                    alignment: Alignment.topLeft,
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
                                            const Color(0xFFffffff).withOpacity(0.1),
                                            const Color(0xFFFFFFFF).withOpacity(0.1),
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
                                            child: Container(
                                              height: getVerticalSize(
                                                13.67,
                                              ),
                                              width: getHorizontalSize(
                                                14.64,
                                              ),
                                              child: const Icon(Icons.arrow_back,size: 25,)
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                10.36,
                                              ),
                                              top: getVerticalSize(
                                                24.00,
                                              ),
                                              right: getHorizontalSize(
                                                155.00,
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BeansIncomeScreen()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: getVerticalSize(
                                                              3.50,
                                                            ),
                                                            bottom:
                                                                getVerticalSize(
                                                              3.50,
                                                            ),
                                                                left: getHorizontalSize(5)
                                                          ),
                                                          child: Text(
                                                            "Income",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: ColorConstant
                                                                  .bluegray400,
                                                              fontSize:
                                                                  getFontSize(
                                                                17,
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
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                            15.00,
                                                          ),
                                                        ),
                                                        child: GradientText(
                                                          "Expenses",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: ColorConstant
                                                                .deepPurple900,
                                                            fontSize:
                                                                getFontSize(
                                                              22,
                                                            ),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          colors: [
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
                                                        49.00,
                                                      ),
                                                      top: getVerticalSize(
                                                        4.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        49.00,
                                                      ),
                                                    ),
                                                    child: Image.asset(
                                                      ImageConstant
                                                          .imageNotFound,
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
                                                        60.00,
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
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  8.00,
                                ),
                                top: getVerticalSize(
                                  76.00,
                                ),
                                right: getHorizontalSize(
                                  9.88,
                                ),
                                bottom: getVerticalSize(
                                  76.00,
                                ),
                              ),
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return BeansExpensesItemWidget();
                                },
                              ),
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
