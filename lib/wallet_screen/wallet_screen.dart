import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../ruby_screen/Ruby.dart';
import '../wallet_screen/widgets/wallet_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late List<Object?> diamondNumbers;
  bool isLoading01 = true;
  bool isLoading02 = true;
  late Map<dynamic, dynamic> dataUserD;
  late Razorpay _razorpay;
  var razorpayAmountIndex = -1;
  bool isSelectedIndex = false;
  int selectedPriceMoney = 0;
  int totalDiamond = 0;
  List<Map<String, dynamic>> transaction = [];
  @override
  void initState() {
    FirebaseDatabase.instance.ref('DiamondPanel').get().then((data) {
      diamondNumbers = data.value as List<Object?>;
      setState(() {
        isLoading01 = false;
      });
      // diamondNumbers = data;
      // print(obj[0]);
      // value.children.forEach((element) {
      //   diamondNumbers = element.value;
      //   print("DIAMOND VALUE : $diamondNumbers");
      // });
      // setState(() {
      //   isLoading01 = false;
      // });
    });
    _tabController = TabController(length: 2, vsync: this);

    FirebaseFirestore.instance
        .collection('UsersDiamond')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      dataUserD = value.data() as Map<dynamic, dynamic>;
      setState(() {
        isLoading02 = false;
      });
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  late TabController _tabController;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    await FirebaseFirestore.instance
        .collection("UsersDiamond")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "diamond": (dataUserD['diamond'] as int) + totalDiamond,
    });
    transaction.clear();
    Map<String, dynamic> mp = {
      "diamonds": (dataUserD['diamond'] as int) + totalDiamond,
      "name": "Buying Diamonds",
      "dateTime": DateTime.now(),
      // "imageurl": selectedImageUrl,
    };
    transaction.add(mp);
    await FirebaseFirestore.instance
        .collection('transactions')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "transHistory": FieldValue.arrayUnion(transaction),
    });
    final isExists = await FirebaseFirestore.instance
        .collection('incomeExpense')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('income')
        .doc('incomeCollection')
        .get();
    final income = {
      "text": "Buying $totalDiamond Diamonds",
      "quantity": 0,
      "createdAt": DateTime.now(),
      "diamonds": totalDiamond,
    };
    final list = [];
    list.add(income);
    if (isExists.exists) {
      await FirebaseFirestore.instance
          .collection('incomeExpense')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('income')
          .doc('incomeCollection')
          .update({
        "incomeList": FieldValue.arrayUnion(list),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('incomeExpense')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('income')
          .doc('incomeCollection')
          .set({
        "incomeList": FieldValue.arrayUnion(list),
      });
    }
    setState(() {
      dataUserD['diamond'] = (dataUserD['diamond'] as int) + totalDiamond;
    });
    snackBar('Payement Succesfully done!!!');
    // Navigator.of(context).pop();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    // snackBar(response.message.toString());
    snackBar('PAYMENT FAILED!!!');
    //debugPrint("CODE: ${response.code}\nMESSAGE ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    //debugPrint("WALLET NAME ${response.walletName}");
  }

  _submitValFn(int diamondAmountIndex, bool isSelected, int selectedPrice) {
    razorpayAmountIndex = diamondAmountIndex;
    isSelectedIndex = isSelected;
    selectedPriceMoney = selectedPrice;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: isLoading01
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading02
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    alignment: Alignment.centerLeft,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GlassmorphicContainer(
                                height: getVerticalSize(68),
                                width: double.infinity,
                                borderRadius: 5,
                                blur: 5,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: getVerticalSize(5)),
                                      child: Icon(Icons.arrow_back),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: getVerticalSize(15),
                                          left: getHorizontalSize(20)),
                                      width: getHorizontalSize(180),
                                      child: TabBar(
                                        indicator: ShapeDecoration(
                                            shape: RoundedRectangleBorder(),
                                            gradient: LinearGradient(colors: [
                                              ColorConstant.textStart,
                                              ColorConstant.textEnd
                                            ])),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        controller: _tabController,
                                        labelPadding:
                                            EdgeInsets.only(bottom: 4),
                                        indicatorWeight: 1.5,
                                        unselectedLabelStyle: TextStyle(
                                          color: ColorConstant.gray800,
                                          fontSize: getFontSize(17),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        // labelColor: ColorConstant.deepPurple900,
                                        labelStyle: TextStyle(
                                          foreground: Paint()
                                            ..shader = LinearGradient(
                                              colors: <Color>[
                                                ColorConstant.textStart,
                                                ColorConstant.textEnd,
                                              ],
                                            ).createShader(Rect.fromLTWH(
                                                getHorizontalSize(20),
                                                0.0,
                                                getHorizontalSize(80),
                                                0.0)),
                                          fontSize: getFontSize(21),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        tabs: const [
                                          Text(
                                            "Diamond",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "Ruby",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: getHorizontalSize(110),
                                          top: getVerticalSize(5)),
                                      height: getSize(
                                        17.00,
                                      ),
                                      width: getSize(
                                        17.00,
                                      ),
                                      child: SvgPicture.asset(
                                        ImageConstant.transactions,
                                        fit: BoxFit.fill,
                                        color: ColorConstant.gray800,
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: getHorizontalSize(
                                                  55.00,
                                                ),
                                                bottom: getVerticalSize(
                                                  4.00,
                                                ),
                                              ),
                                              child: Image.asset(
                                                ImageConstant.imgGroup8997,
                                                height: getVerticalSize(
                                                  59.00,
                                                ),
                                                width: getHorizontalSize(
                                                  57.10,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: getHorizontalSize(
                                                  14.90,
                                                ),
                                                right: getHorizontalSize(
                                                  55.00,
                                                ),
                                              ),
                                              child: Text(
                                                dataUserD['diamond'].toString(),
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
                                      Align(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: getVerticalSize(
                                              40.00,
                                            ),
                                            left: getHorizontalSize(20),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Image.asset(
                                                  ImageConstant.imgRectangle152,
                                                  height: getVerticalSize(
                                                    85.00,
                                                  ),
                                                  width: getHorizontalSize(
                                                    320.00,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      8.00,
                                                    ),
                                                    top: getVerticalSize(
                                                      22.00,
                                                    ),
                                                    right: getHorizontalSize(
                                                      7.00,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      23.00,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        "<",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .whiteA70033,
                                                          fontSize: getFontSize(
                                                            30,
                                                          ),
                                                          fontFamily:
                                                              'Red Hat Display',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                            269.00,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          ">",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: ColorConstant
                                                                .whiteA70033,
                                                            fontSize:
                                                                getFontSize(
                                                              30,
                                                            ),
                                                            fontFamily:
                                                                'Red Hat Display',
                                                            fontWeight:
                                                                FontWeight.w700,
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
                                      GlassmorphicContainer(
                                        margin: EdgeInsets.only(
                                            top: getVerticalSize(10)),
                                        width: size.width,
                                        borderRadius: 15,
                                        blur: 10,
                                        alignment: Alignment.bottomCenter,
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
                                        height: getVerticalSize(461),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: getHorizontalSize(
                                                  20.00,
                                                ),
                                                top: getVerticalSize(
                                                  37.00,
                                                ),
                                                right: getHorizontalSize(
                                                  20.00,
                                                ),
                                              ),
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisExtent:
                                                      getVerticalSize(125.00),
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing:
                                                      getHorizontalSize(15.00),
                                                  crossAxisSpacing:
                                                      getHorizontalSize(15.00),
                                                ),
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: 6,
                                                itemBuilder: (context, index) {
                                                  return WalletItemWidget(
                                                    diamondValue:
                                                        diamondNumbers[index],
                                                    // diamondNumbers.child(index.toString()),
                                                    index: index,
                                                    submitPrice: _submitValFn,
                                                  );
                                                },
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                isSelectedIndex
                                                    ? launchPayment()
                                                    : null;
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(29.00),
                                                  top: getVerticalSize(33.00),
                                                  right:
                                                      getHorizontalSize(29.00),
                                                ),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height:
                                                      getVerticalSize(30.00),
                                                  width:
                                                      getHorizontalSize(90.00),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(20.00),
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
                                                        ColorConstant
                                                            .deepPurple900,
                                                        ColorConstant.purple500,
                                                      ],
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Recharge",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: ColorConstant
                                                          .whiteA700,
                                                      fontSize: getFontSize(14),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(29.00),
                                                  top: getVerticalSize(80.00),
                                                  right:
                                                      getHorizontalSize(29.00),
                                                ),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'What should I do if i don’t get any diamonds after paying? ',
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .bluegray401,
                                                          fontSize: getFontSize(
                                                            10,
                                                          ),
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Ruby(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  launchPayment() {
    final extraDiamond =
        (diamondNumbers[razorpayAmountIndex] as Map<dynamic, dynamic>)['offer']
                .toString()
                .trim()
                .isNotEmpty
            ? (diamondNumbers[razorpayAmountIndex]
                as Map<dynamic, dynamic>)['offer']
            : 0;
    totalDiamond = ((diamondNumbers[razorpayAmountIndex]
            as Map<dynamic, dynamic>)['normal'] +
        extraDiamond);
    int amountToPay = selectedPriceMoney * 100;
    // (diamondNumbers[razorpayAmountIndex] as Map<dynamic, dynamic>)['money'];
    // int amountToPay = 79 * 100;
    var options = {
      'key': 'rzp_test_MBah3s7fIhMA4A',
      'amount': '$amountToPay',
      'name': 'EnLearn App',
      'description': 'Buying $totalDiamond Diamonds',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9404372648',
        'email': 'dchinmay032@gmail.com'
      },
      // "external": {
      //   "wallets": ["paytm"]
      // },
    };
    try {
      _razorpay.open(options);
    } catch (err) {
      //debugPrint(err.toString());
    }
  }
}
