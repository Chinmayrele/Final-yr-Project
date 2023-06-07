import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/ruby_screen/widgets/ruby_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:glassmorphism/glassmorphism.dart';
// import 'package:lol/ruby_screen/widgets/ruby_item_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../diamond_history_screen/diamond_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Ruby extends StatefulWidget {
  const Ruby({Key? key}) : super(key: key);

  @override
  State<Ruby> createState() => _RubyState();
}

class _RubyState extends State<Ruby> {
  bool isLoading01 = true;
  bool isLoading02 = true;
  late Map<dynamic, dynamic> dataUserDR;
  late List<Object?> rubyNumbers;
  bool isSelectedIndexRuby = false;
  int selectedRubyQuan = 0;
  int diamondQuantities = 0;
  int rubyQuantities = 0;
  @override
  void initState() {
    FirebaseDatabase.instance.ref('RubyPanel').get().then((data) {
      rubyNumbers = data.value as List<Object?>;
      setState(() {
        isLoading01 = false;
      });
    });
    FirebaseFirestore.instance
        .collection('UsersDiamond')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      dataUserDR = value.data() as Map<dynamic, dynamic>;
      setState(() {
        isLoading02 = false;
      });
    });
    super.initState();
  }

  _submitValFn(int rubyAmountIndex, bool isSelected, int diamondQuantity,
      int rubyQuantity) {
    selectedRubyQuan = rubyAmountIndex;
    isSelectedIndexRuby = isSelected;
    diamondQuantities = diamondQuantity;
    rubyQuantities = rubyQuantity;
    // selectedPriceMoney = selectedPrice;
  }

  snackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6))),
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading01
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          )
        : isLoading02
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              )
            : Container(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  ImageConstant.imgUnsplash8uzpyn,
                                  height: getVerticalSize(
                                    708.00,
                                  ),
                                  width: getHorizontalSize(
                                    360.00,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: getVerticalSize(60)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              56.00,
                                            ),
                                          ),
                                          child: Image.asset(
                                            ImageConstant.imgBluesapphire,
                                            height: getVerticalSize(
                                              52.00,
                                            ),
                                            width: getHorizontalSize(
                                              35.58,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              22.21,
                                            ),
                                            top: getVerticalSize(
                                              5.00,
                                            ),
                                            right: getHorizontalSize(
                                              51.21,
                                            ),
                                          ),
                                          child: Text(
                                            dataUserDR['ruby'].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: ColorConstant.gray800,
                                              fontSize: getFontSize(
                                                40,
                                              ),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: GlassmorphicContainer(
                                          margin: EdgeInsets.only(
                                            top: getVerticalSize(80),
                                          ),
                                          borderRadius: 10,
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
                                          height: getVerticalSize(50),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    29.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    15.00,
                                                  ),
                                                ),
                                                child: GradientText(
                                                  "Redeem",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .deepPurple900,
                                                    fontSize: getFontSize(
                                                      16,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  colors: [
                                                    ColorConstant.textStart,
                                                    ColorConstant.textEnd
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    20.00,
                                                  ),
                                                  bottom: getVerticalSize(
                                                    15.00,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Withdraw",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.gray800,
                                                    fontSize: getFontSize(
                                                      13,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GlassmorphicContainer(
                                        borderRadius: 10,
                                        width: size.width,
                                        blur: 2,
                                        height: getVerticalSize(460),
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(top: 0.5),
                                        border: 2,
                                        linearGradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFFffffff)
                                                  .withOpacity(0.2),
                                              Color(0xFFFFFFFF)
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
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: getVerticalSize(15),
                                            left: getHorizontalSize(30),
                                            right: getHorizontalSize(30),
                                          ),
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent:
                                                  getVerticalSize(105.00),
                                              crossAxisCount: 3,
                                              mainAxisSpacing:
                                                  getHorizontalSize(10.00),
                                              crossAxisSpacing:
                                                  getHorizontalSize(12.00),
                                            ),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: 9,
                                            itemBuilder: (context, index) {
                                              return RubyItemWidget(
                                                rubyValue: rubyNumbers[index],
                                                index: index,
                                                submitQuantity: _submitValFn,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  debugPrint("VALUESSS: ${dataUserDR['ruby']}");
                                  if ((dataUserDR['ruby'] as int) -
                                          rubyQuantities >
                                      0) {
                                    setState(() {
                                      dataUserDR['ruby'] =
                                          (dataUserDR['ruby'] as int) -
                                              rubyQuantities;
                                      debugPrint(
                                          "NEW RUBY QUANTITY LEFT: ${dataUserDR['ruby']}");
                                      dataUserDR['diamond'] =
                                          dataUserDR['diamond'] +
                                              diamondQuantities;
                                      debugPrint(
                                          "NEW DIAMOND QUANTITY: ${dataUserDR['diamond']}");
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('UsersDiamond')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "diamond": dataUserDR['diamond'],
                                      "ruby": dataUserDR['ruby'],
                                    });
                                    // INCOME EXPENSE LOGIC
                                    final isExists = await FirebaseFirestore
                                        .instance
                                        .collection('incomeExpense')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('income')
                                        .doc('incomeCollection')
                                        .get();
                                    final income = {
                                      "text":
                                          "Reedming $diamondQuantities Diamonds from Rubies",
                                      "quantity": 0,
                                      "createdAt": DateTime.now(),
                                      "diamonds": diamondQuantities,
                                    };
                                    final list = [];
                                    list.add(income);
                                    if (isExists.exists) {
                                      await FirebaseFirestore.instance
                                          .collection('incomeExpense')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('income')
                                          .doc('incomeCollection')
                                          .update({
                                        "incomeList":
                                            FieldValue.arrayUnion(list),
                                      });
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection('incomeExpense')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('income')
                                          .doc('incomeCollection')
                                          .set({
                                        "incomeList":
                                            FieldValue.arrayUnion(list),
                                      });
                                    } // TILL HERE INCOME EXPENSE LOGIC
                                    snackBar(
                                        'You have received the Diamonds!!!');
                                  } else {
                                    snackBar(
                                        "Looks like you don't have enough Rubies");
                                  }
                                },
                                child: Align(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: getVerticalSize(30.00),
                                    width: getHorizontalSize(82.00),
                                    margin: EdgeInsets.only(
                                        top: getVerticalSize(600)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(10.00),
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
                                          ColorConstant.deepPurple900,
                                          ColorConstant.purple500,
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      "Redeem",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: getFontSize(14),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
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
                  ],
                ),
              );
  }
}
