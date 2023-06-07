import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../my_zone_screen/my_zone_screen.dart';
import 'widgets/search_party_room_item_widget.dart';
import '../search_screen/widgets/search_item_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();

  List<QueryDocumentSnapshot<Object?>> userDocs = [];
  List<QueryDocumentSnapshot<Object?>> userRoomDocs = [];
  List<QueryDocumentSnapshot<Object?>> searchDocs = [];
  List<QueryDocumentSnapshot<Object?>> searchRoomDocs = [];
  late TabController _tabController;

  void _refreshSetState() {
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      renderTab();
    });
    super.initState();
  }

  renderTab() {
    searchController.clear();
    setState(() {});
  }

  List<dynamic> followingList = [];
  Future getFollowFunc() async {
    final data = await FirebaseFirestore.instance
        .collection('followList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    followingList.clear();
    final e = data.data();
    followingList = e!['following'] as List;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var hSize = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const MyZoneScreen()));
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstant.whiteA700,
          body: FutureBuilder(
              future: getFollowFunc(),
              builder: (context, snapShots) {
                // if (!snapShots.hasData) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else {
                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        ImageConstant.imgUnsplash8uzpyn,
                        height: getVerticalSize(779.00),
                        width: getHorizontalSize(360.00),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GlassmorphicContainer(
                          width: double.infinity,
                          height: getVerticalSize(112),
                          borderRadius: 10,
                          blur: 10,
                          alignment: Alignment.bottomCenter,
                          border: 4,
                          linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFffffff).withOpacity(0.2),
                                const Color(0xFFFFFFFF).withOpacity(0.2),
                              ],
                              stops: const [
                                0.1,
                                1
                              ]),
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.3),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: getVerticalSize(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: getVerticalSize(10.00),
                                        left: getHorizontalSize(10.00),
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const MyZoneScreen()));
                                          return Future(() => false);
                                        },
                                        child: SizedBox(
                                            height: getVerticalSize(18.00),
                                            width: getHorizontalSize(20.00),
                                            child: const Icon(
                                              Icons.arrow_back,
                                              size: 25.0,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      width: getHorizontalSize(285),
                                      margin: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          20.00,
                                        ),
                                      ),
                                      child: Neumorphic(
                                        style: const NeumorphicStyle(
                                          depth: -3,
                                          color: Colors.transparent,
                                          border: NeumorphicBorder(
                                              width: 0.5, color: Colors.white),
                                          boxShape:
                                              NeumorphicBoxShape.stadium(),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: getVerticalSize(8),
                                            bottom: getVerticalSize(8),
                                            left: getHorizontalSize(15)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: getHorizontalSize(240),
                                              child: TextField(
                                                controller: searchController,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText:
                                                      "Search for students/study rooms",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: getFontSize(
                                                      15,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    searchDocs = userDocs
                                                        .where((element) {
                                                      return (element.get(
                                                              'name') as String)
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                    }).toList();

                                                    searchRoomDocs =
                                                        userRoomDocs
                                                            .where((element) {
                                                      return (element
                                                                  .get('roomId')
                                                              as String)
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                    }).toList();
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: getSize(22.00),
                                              decoration: BoxDecoration(
                                                color: ColorConstant.gray500,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(11.00),
                                                ),
                                              ),
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                elevation: 0,
                                                margin: const EdgeInsets.all(0),
                                                color: ColorConstant.gray500,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    getHorizontalSize(11.00),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    getVerticalSize(
                                                                        5)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              searchController
                                                                  .clear();
                                                              searchDocs
                                                                  .clear();
                                                              searchRoomDocs
                                                                  .clear();
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            height:
                                                                getSize(13.83),
                                                            width:
                                                                getSize(13.83),
                                                            child: SvgPicture
                                                                .asset(
                                                              ImageConstant
                                                                  .imgGroup1253,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
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
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: getVerticalSize(12),
                                      left: getHorizontalSize(70)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: getHorizontalSize(200),
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
                                                  getHorizontalSize(60),
                                                  0.0,
                                                  getHorizontalSize(80),
                                                  0.0)),
                                            fontSize: getFontSize(21),
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                          ),
                                          tabs: const [
                                            Text(
                                              "Students",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              "Study Room",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .snapshots(),
                                  builder: (ctx, snapshots) {
                                    if (!snapshots.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.pink),
                                      );
                                    } else {
                                      userDocs = snapshots.data!.docs;
                                      return searchDocs.isNotEmpty
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  left: 12, right: 12),
                                              height: getVerticalSize(665),
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: searchDocs.length,
                                                itemBuilder: (context, index) {
                                                  // print("IN SEARCH DOCS GONE....");
                                                  searchDocs.sort(((a, b) =>
                                                      (b['status'] as String)
                                                          .compareTo(
                                                              a['status'])));
                                                  if (searchDocs[index]
                                                          ['userId'] ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid) {
                                                    return Container();
                                                  }
                                                  return SearchItemWidget(
                                                    userDataDocs:
                                                        searchDocs[index],
                                                    index: index,
                                                    followingList:
                                                        followingList,
                                                    refreshFn: _refreshSetState,
                                                  );
                                                },
                                              ),
                                            )
                                          : Container();
                                      // Container(
                                      //     margin: const EdgeInsets.only(
                                      //         left: 12, right: 12),
                                      //     height: getVerticalSize(665),
                                      //     child: ListView.builder(
                                      //       scrollDirection: Axis.vertical,
                                      //       shrinkWrap: true,
                                      //       itemCount: userDocs.length,
                                      //       itemBuilder: (context, index) {
                                      //         if (userDocs[index]['userId'] ==
                                      //             FirebaseAuth.instance
                                      //                 .currentUser!.uid) {
                                      //           return Container();
                                      //         }
                                      //         return SearchItemWidget(
                                      //           userDataDocs: userDocs[index],
                                      //           followingList: followingList,
                                      //           index: index,
                                      //           refreshFn: _refreshSetState,
                                      //         );
                                      //       },
                                      //     ),
                                      //   );
                                    }
                                  },
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('hostRoomData')
                                      .snapshots(),
                                  builder: (ctx, snapShots) {
                                    if (!snapShots.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.pink,
                                        ),
                                      );
                                    } else {
                                      userRoomDocs = snapShots.data!.docs;
                                      return searchRoomDocs.isNotEmpty
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  left: getHorizontalSize(14),
                                                  right: getHorizontalSize(14)),
                                              height: getVerticalSize(665),
                                              child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount:
                                                    searchRoomDocs.length,
                                                itemBuilder: (context, index) {
                                                  if ((searchRoomDocs[index]
                                                              ['userId'] ==
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid) ||
                                                      (searchRoomDocs[index]
                                                                  ['roomId']
                                                              as String)
                                                          .isEmpty) {
                                                    return Container();
                                                  }
                                                  return SearchPartyRoomItemWidget(
                                                    index: index,
                                                    userDataDocs:
                                                        searchRoomDocs[index],
                                                    refreshFn: _refreshSetState,
                                                  );
                                                },
                                              ),
                                            )
                                          : Container();
                                    }
                                  },
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ],
                );
              }
              // },
              ),
        ),
      ),
    );
  }
}
