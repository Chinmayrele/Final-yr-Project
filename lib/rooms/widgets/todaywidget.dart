import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../model/user_model.dart';
import '../../providers/info_providers.dart';

// ignore: must_be_immutable
class TodayWidget extends StatefulWidget {
  const TodayWidget({
    Key? key,
    // required this.todayData,
    required this.todayList,
  }) : super(key: key);
  // final UserBasicModel todayData;
  final String todayList;

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  Map<String, dynamic> charismaMap = {};
  UserBasicModel? userData;
  bool isLoading = true;
  @override
  void initState() {
    // FirebaseFirestore.instance
    //     .collection('UsersDiamond')
    //     .doc(widget.todayData.userId)
    //     .get()
    //     .then((value) {
    //   final e = value.data();
    //   charismaMap = {"todayCharisma": e!['todayCharisma'], "date": e['date']};
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    final result = Provider.of<InfoProviders>(context);
    result.callCurrentUserProfileData(widget.todayList).then((value) {
      userData = value;
      FirebaseFirestore.instance
          .collection("UsersDiamond")
          .doc(widget.todayList)
          .get()
          .then((value) {
        final e = value.data();
        charismaMap = {"todayCharisma": e!['todayCharisma'], "date": e['date']};
        setState(() {
          isLoading = false;
        });
      });
    });
    // FirebaseFirestore.instance
    //     .collection("UsersDiamond")
    //     .doc(widget.todayList)
    //     .get()
    //     .then((value) {
    //   final e = value.data();
    //   charismaMap = {"todayCharisma": e!['todayCharisma'], "date": e['date']};
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.white.withOpacity(0.4),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              top: getVerticalSize(
                12.00,
              ),
              bottom: getVerticalSize(
                12.00,
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: getSize(
                            50.00,
                          ),
                          width: getSize(
                            50.00,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      getSize(
                                        25.00,
                                      ),
                                    ),
                                    child: Image.network(
                                      userData!.imageUrl,
                                      // widget.todayData.imageUrl,
                                      height: getSize(50.00),
                                      width: getSize(50.00),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              // Align(
                              //   alignment: Alignment.bottomRight,
                              //   child: Container(
                              //     height: getSize(
                              //       12.50,
                              //     ),
                              //     width: getSize(
                              //       12.50,
                              //     ),
                              //     margin: EdgeInsets.only(
                              //       left: getHorizontalSize(
                              //         10.00,
                              //       ),
                              //       top: getVerticalSize(
                              //         10.00,
                              //       ),
                              //       right: getHorizontalSize(
                              //         0.43,
                              //       ),
                              //       bottom: getVerticalSize(
                              //         2.16,
                              //       ),
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: ColorConstant.lightGreenA700,
                              //       borderRadius: BorderRadius.circular(
                              //         getHorizontalSize(
                              //           6.25,
                              //         ),
                              //       ),
                              //       border: Border.all(
                              //         color: ColorConstant.gray200,
                              //         width: getHorizontalSize(
                              //           1.00,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              25.00,
                            ),
                            top: getVerticalSize(
                              14.00,
                            ),
                            bottom: getVerticalSize(
                              15.00,
                            ),
                          ),
                          child: Text(
                            userData!.name,
                            // widget.todayData.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
                              fontSize: getFontSize(
                                18,
                              ),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: getVerticalSize(
                        16.00,
                      ),
                      width: getHorizontalSize(
                        45.00,
                      ),
                      child: Text(
                        (DateTime.parse(charismaMap['date']).day ==
                                    DateTime.now().day &&
                                DateTime.parse(charismaMap['date']).month ==
                                    DateTime.now().month)
                            ? charismaMap['todayCharisma']
                            : 0,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.whiteA700,
                          fontSize: getFontSize(
                            10,
                          ),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Divider(
                  indent: 60,
                  height: getVerticalSize(1),
                  color: Colors.white,
                  thickness: 0.5,
                )
              ],
            ),
          );
  }
}
