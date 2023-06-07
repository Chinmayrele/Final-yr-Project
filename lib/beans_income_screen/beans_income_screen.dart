import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../beans_income_screen/widgets/beans_income_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../refresh_indicator/refresh_widget.dart';

class BeansIncomeScreen extends StatefulWidget {
  const BeansIncomeScreen({Key? key}) : super(key: key);

  @override
  State<BeansIncomeScreen> createState() => _BeansIncomeScreenState();
}

class _BeansIncomeScreenState extends State<BeansIncomeScreen> {
  List<Map<String, dynamic>> incomeData = [];
  bool isLoading = true;
  @override
  void initState() {
    getIncomeData();
    super.initState();
  }

  Future<void> getIncomeData() async {
    FirebaseFirestore.instance
        .collection('incomeExpense')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('income')
        .doc('incomeCollection')
        .get()
        .then((value) {
      final e = value.data();
      incomeData = e!['recentList'] as List<Map<String, dynamic>>;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              )
            : RefreshWidget(
              onRefresh: getIncomeData,
              child: SizedBox(
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
                              height: getVerticalSize(776.00),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: ColorConstant.whiteA700,
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      height: getVerticalSize(776.00),
                                      width: size.width,
                                      child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Image.asset(
                                              ImageConstant.imgUnsplash8uzpyn,
                                              height: getVerticalSize(776.00),
                                              width: getHorizontalSize(360.00),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: GlassmorphicContainer(
                                              margin: EdgeInsets.only(
                                                bottom: getVerticalSize(10.00),
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
                                                    const Color(0xFFffffff)
                                                        .withOpacity(0.2),
                                                    const Color(0xFFFFFFFF)
                                                        .withOpacity(0.2),
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
                                                      // top: getVerticalSize(
                                                      //   31.00,
                                                      // ),
                                                      // bottom: getVerticalSize(
                                                      //   19.33,
                                                      // ),
                                                    ),
                                                    child: Container(
                                                        height: getVerticalSize(
                                                            13.67),
                                                        width: getHorizontalSize(
                                                            14.64),
                                                        child: const Icon(
                                                          Icons.arrow_back,
                                                          size: 25,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                          15.36),
                                                      top: getVerticalSize(24.00),
                                                      bottom:
                                                          getVerticalSize(10.00),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            width:
                                                                getHorizontalSize(
                                                                    150.00),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                GradientText(
                                                                  "Income",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .deepPurple900,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            22),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  colors: [
                                                                    ColorConstant
                                                                        .textStart,
                                                                    ColorConstant
                                                                        .textEnd
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top:
                                                                        getVerticalSize(
                                                                            3.50),
                                                                    bottom:
                                                                        getVerticalSize(
                                                                            3.50),
                                                                  ),
                                                                  child: Text(
                                                                    "Expenses",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorConstant
                                                                          .bluegray400,
                                                                      fontSize:
                                                                          getFontSize(
                                                                        17,
                                                                      ),
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                      27.00),
                                                              top:
                                                                  getVerticalSize(
                                                                      4.00),
                                                              right:
                                                                  getHorizontalSize(
                                                                      27.00),
                                                            ),
                                                            child: Image.asset(
                                                              ImageConstant
                                                                  .imageNotFound,
                                                              height:
                                                                  getVerticalSize(
                                                                      2.00),
                                                              width:
                                                                  getHorizontalSize(
                                                                      20.00),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            height:
                                                                getVerticalSize(
                                                                    2.00),
                                                            width:
                                                                getHorizontalSize(
                                                                    20.00),
                                                            margin:
                                                                EdgeInsets.only(
                                                              left:
                                                                  getHorizontalSize(
                                                                      30.00),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  ColorConstant
                                                                      .textStart,
                                                                  ColorConstant
                                                                      .textEnd
                                                                ],
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                        left: getHorizontalSize(7.00),
                                        top: getVerticalSize(76.00),
                                        right: getHorizontalSize(9.88),
                                        bottom: getVerticalSize(76.00),
                                      ),
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: incomeData.length,
                                        itemBuilder: (context, index) {
                                          return BeansIncomeItemWidget(
                                            incomeData: incomeData[index],
                                          );
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
      ),
    );
  }
}
