import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../diamond_history_screen/widgets/diamond_history_item_widget.dart';
import 'package:flutter/material.dart';

class DiamondHistoryScreen extends StatefulWidget {
  const DiamondHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DiamondHistoryScreen> createState() => _DiamondHistoryScreenState();
}

class _DiamondHistoryScreenState extends State<DiamondHistoryScreen> {
  var transHisData;
  @override
  void initState() {
    super.initState();
  }

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
                            child: SizedBox(
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
                                      width: size.width,
                                      blur: 15,
                                      alignment: Alignment.bottomCenter,
                                      border: 4,
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
                                              left: getHorizontalSize(16.00),
                                              top: getVerticalSize(2.00),
                                            ),
                                            child: SizedBox(
                                                height: getVerticalSize(13.67),
                                                width: getHorizontalSize(14.64),
                                                child: const Icon(
                                                  Icons.arrow_back,
                                                  size: 25,
                                                )),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(14.00),
                                              top: getVerticalSize(24.00),
                                              bottom: getVerticalSize(14.00),
                                            ),
                                            child: GradientText(
                                              "Transactions",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    ColorConstant.deepPurple900,
                                                fontSize: getFontSize(
                                                  23,
                                                ),
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w700,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(8.00),
                                top: getVerticalSize(76.00),
                                right: getHorizontalSize(8.00),
                                bottom: getVerticalSize(76.00),
                              ),
                              child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('transactions')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (ctx, snapShots) {
                                  if (!snapShots.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.pink),
                                    );
                                  }
                                  transHisData = snapShots.data!.data();
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        (transHisData['transHistory'] as List)
                                            .length,
                                    itemBuilder: (context, index) {
                                      return DiamondHistoryItemWidget(
                                        transactionData: (transHisData['transHistory'] as List)[index],
                                      );
                                    },
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
    );
  }
}
