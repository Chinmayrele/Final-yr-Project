import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../collections_screen/widgets/collections_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../model/user_model.dart';
import '../usernames/new.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen>
    with SingleTickerProviderStateMixin {
  var listData;
  late TabController _tabController;
  late UserBasicModel userData;
  bool isLoading01 = true;
  late String imageurluser;

  void _refreshSetState() {
    setState(() {});
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final e = value.data();
      imageurluser = e!['imageUrl'];
      setState(() {
        isLoading01 = false;
      });
    });
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List framesList = [];
    Future getFrameFunc() async {
      final data = await FirebaseFirestore.instance
          .collection('userFrames')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final e = data.data();
      framesList = e!['framesAdd'] as List;
      debugPrint("LENGTH FRMAESLIST: ${framesList.length}");
      // setState(() {});
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const Profile()));
          return Future(() => false);
        },
        child: Scaffold(
          backgroundColor: ColorConstant.whiteA700,
          body: isLoading01
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: getFrameFunc(),
                  builder: (context, snapshots) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            ImageConstant.imgUnsplash8uzpyn,
                            height: getVerticalSize(778.00),
                            width: getHorizontalSize(360.00),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              GlassmorphicContainer(
                                width: double.infinity,
                                height: size.height * 0.09,
                                borderRadius: 15,
                                blur: 15,
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
                                child: SizedBox(
                                  width: size.width,
                                  height: size.height * 0.08,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(16.00),
                                      top: getVerticalSize(5),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          const Profile()));
                                              return Future(() => false);
                                            },
                                            icon: const Icon(Icons.arrow_back,
                                                size: 25)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(15),
                                          ),
                                          child: GradientText(
                                            "Collections",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color:
                                                  ColorConstant.deepPurple900,
                                              fontSize: getFontSize(
                                                22,
                                              ),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w600,
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
                              ),
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: getHorizontalSize(28.60),
                                        top: getVerticalSize(25.00),
                                        right: getHorizontalSize(28.60),
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteA70033,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(52.42),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.black90002,
                                          width: getHorizontalSize(1.00),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          //USER IMAGE
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(6.11),
                                              top: getVerticalSize(6.12),
                                              right: getHorizontalSize(6.12),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getSize(
                                                  60.30,
                                                ),
                                              ),
                                              child: Image.network(
                                                imageurluser,
                                                height: getSize(
                                                  120.61,
                                                ),
                                                width: getSize(
                                                  120.61,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //IMAGE FRAME AROUND DP
                                  Align(
                                    alignment: Alignment.center,
                                    // child: Image
                                    //     .network(
                                    //   (framesList[
                                    //           0][
                                    //       'imageurl']),
                                    //   height:
                                    //       getVerticalSize(
                                    //     185.00,
                                    //   ),
                                    //   width:
                                    //       getHorizontalSize(
                                    //     185.04,
                                    //   ),
                                    //   fit: BoxFit
                                    //       .cover,
                                    // ),
                                    //     Image.asset(
                                    //   ImageConstant
                                    //       .imgFramebirthday1,
                                    //   height:
                                    //       getVerticalSize(
                                    //     171.00,
                                    //   ),
                                    //   width:
                                    //       getHorizontalSize(
                                    //     152.04,
                                    //   ),
                                    //   fit: BoxFit
                                    //       .fill,
                                    // ),
                                  ),
                                ],
                              ),
                              GlassmorphicContainer(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  50.00,
                                ),
                                margin: EdgeInsets.only(
                                  top: getVerticalSize(
                                    25.00,
                                  ),
                                ),
                                width: size.width,
                                borderRadius: 15,
                                blur: 15,
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
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: getVerticalSize(10),
                                      left: getHorizontalSize(20)),
                                  width: getHorizontalSize(360),
                                  child: TabBar(
                                    isScrollable: true,
                                    indicator: ShapeDecoration(
                                        shape: const RoundedRectangleBorder(),
                                        gradient: LinearGradient(colors: [
                                          ColorConstant.textStart,
                                          ColorConstant.textEnd
                                        ])),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    controller: _tabController,
                                    labelPadding:
                                        const EdgeInsets.only(bottom: 2),
                                    indicatorWeight: 1.0,
                                    unselectedLabelStyle: TextStyle(
                                      color: ColorConstant.gray800,
                                      fontSize: getFontSize(15),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
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
                                            getHorizontalSize(40),
                                            0.0)),
                                      fontSize: getFontSize(16),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    tabs: [
                                      const Text(
                                        "All",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(15)),
                                        child: const Text(
                                          "Avatar Frames",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(15)),
                                        child: const Text(
                                          "Entrance Effects",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(15)),
                                        child: const Text(
                                          "Room BG Images",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(15)),
                                        child: const Text(
                                          "Avatar Frames",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('userFrames')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .snapshots(),
                                      builder: (ctx, snapShots) {
                                        if (!snapShots.hasData) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.pink),
                                          );
                                        } else {
                                          listData = snapShots.data!.data();
                                          debugPrint(
                                              "LIST DATA RETURNING: $listData");
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(20.00),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: getVerticalSize(5.00),
                                                ),
                                                child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      (listData['framesAdd']
                                                              as List)
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CollectionsItemWidget(
                                                      listFrameData:
                                                          (listData['framesAdd']
                                                              as List)[index],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Container(),
                                    Container(),
                                    Container(),
                                    Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
