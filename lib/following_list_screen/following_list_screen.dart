import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../follower_list_screen/follower_list_screen.dart';
import '../following_list_screen/widgets/following_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../friends_list_screen/friends_list_screen.dart';
import '../model/user_model.dart';
import '../providers/info_providers.dart';
import '../refresh_indicator/refresh_widget.dart';
import '../visitors_list_screen/visitors_list_screen.dart';

class FollowingListScreen extends StatefulWidget {
  const FollowingListScreen({Key? key}) : super(key: key);

  @override
  State<FollowingListScreen> createState() => _FollowingListScreenState();
}

class _FollowingListScreenState extends State<FollowingListScreen> {
  bool isLoading = true;
  Map<String, dynamic> listData = {};
  late List<UserBasicModel> dataList;
  late InfoProviders result;
  @override
  void initState() {
    getFollowList();

    super.initState();
  }

  Future getFollowList() async {
    print("INIT STATE OF FOLLOWING LIST CALLED!!!");
    result = Provider.of<InfoProviders>(context, listen: false);
    FirebaseFirestore.instance
        .collection('followList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      listData = value.data() as Map<String, dynamic>;
      result.fetchUserData(listData, 'following').then((_) {
        dataList = result.usersData;
        // debugPrint("DATALIST VALUE: ${dataList[0].name}");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var hSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshWidget(
              onRefresh: getFollowList,
              child: SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteA700,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: getVerticalSize(
                                778.00,
                              ),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: ColorConstant.whiteA700,
                              ),
                              child: Stack(
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
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: GlassmorphicContainer(
                                            width: size.width,
                                            height: hSize * 0.09,
                                            borderRadius: 15,
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
                                            child: Row(
                                              children: [
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //     top: getVerticalSize(
                                                //       8.00,
                                                //     ),
                                                //   ),
                                                //   child: GestureDetector(
                                                //     onTap: (){
                                                //       Navigator.of(context).pop(false);
                                                //     },
                                                //     child: Container(
                                                //       margin: EdgeInsets.only(left: getHorizontalSize(10)),
                                                //
                                                //       child: SvgPicture.asset(
                                                //         ImageConstant.imgVector,
                                                //         fit: BoxFit.fill,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                      12.36,
                                                    ),
                                                    top: getVerticalSize(
                                                      20.00,
                                                    ),
                                                    bottom: getVerticalSize(
                                                      0.00,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                FriendsListScreen()));
                                                              },
                                                              child: Text(
                                                                "Friends",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                  color: ColorConstant
                                                                      .bluegray400,
                                                                  fontSize:
                                                                      getFontSize(
                                                                    15,
                                                                  ),
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      top:
                                                                          getVerticalSize(
                                                                        3.50,
                                                                      ),
                                                                      bottom:
                                                                          getVerticalSize(
                                                                        3.50,
                                                                      ),
                                                                      left:
                                                                          getHorizontalSize(
                                                                              10)),
                                                              child: GradientText(
                                                                "Followings",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
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
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      top:
                                                                          getVerticalSize(
                                                                        3.50,
                                                                      ),
                                                                      bottom:
                                                                          getVerticalSize(
                                                                        3.50,
                                                                      ),
                                                                      left:
                                                                          getHorizontalSize(
                                                                              10)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  FollowerListScreen()));
                                                                },
                                                                child: Text(
                                                                  "Followers",
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
                                                                      16,
                                                                    ),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      top:
                                                                          getVerticalSize(
                                                                        3.50,
                                                                      ),
                                                                      bottom:
                                                                          getVerticalSize(
                                                                        3.50,
                                                                      ),
                                                                      left:
                                                                          getHorizontalSize(
                                                                              10)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  const VisitorsScreen()));
                                                                },
                                                                child: Text(
                                                                  "Visitors",
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
                                                                      16,
                                                                    ),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: getVerticalSize(
                                                              4.00,
                                                            ),
                                                            right:
                                                                getHorizontalSize(
                                                              25.00,
                                                            ),
                                                          ),
                                                          child: Image.asset(
                                                            ImageConstant
                                                                .imageNotFound,
                                                            height:
                                                                getVerticalSize(
                                                              2.00,
                                                            ),
                                                            width:
                                                                getHorizontalSize(
                                                              20.00,
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Container(
                                                          height: getVerticalSize(
                                                            2.00,
                                                          ),
                                                          width:
                                                              getHorizontalSize(
                                                            20.00,
                                                          ),
                                                          margin: EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                              95.00,
                                                            ),
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
                                        // StreamBuilder<DocumentSnapshot>(
                                        //   stream: FirebaseFirestore.instance
                                        //       .collection('users')
                                        //       .doc(FirebaseAuth
                                        //           .instance.currentUser!.uid)
                                        //       .snapshots(),
                                        //   builder: (ctx, snapshots) {
                                        //     final followingDocs = snapshots.data;
                                        Container(
                                          height: hSize * 0.86,
                                          margin: EdgeInsets.only(
                                            top: getVerticalSize(5),
                                            left: getHorizontalSize(
                                              14.00,
                                            ),
                                            right: getHorizontalSize(
                                              13.00,
                                            ),
                                          ),
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount:
                                                (listData['following'] as List)
                                                    .length,
                                            // (followingDocs!
                                            //         .get('following') as List)
                                            //     .length,
                                            itemBuilder: (context, index) {
                                              return FollowingListItemWidget(
                                                  // listData:
                                                  //     (listData['following']
                                                  //         as List)[index],
                                                  userDataList:
                                                      dataList[index]);
                                            },
                                          ),
                                        ),
                                        //   },
                                        // ),
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
                ),
            ),
      ),
    );
  }
}
