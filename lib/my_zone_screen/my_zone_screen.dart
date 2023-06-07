import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../message.dart';
import '../model/user_model.dart';
import '../my_rooms_screen/my_rooms_screen.dart';
import '../my_zone_screen/widgets/my_zone_item_widget.dart';
import 'package:flutter/material.dart';

import '../providers/info_providers.dart';
import '../refresh_indicator/refresh_widget.dart';
import '../search_screen/search_screen.dart';
import '../service/zego_room_manager.dart';
import '../trending_screen/trending_screen.dart';
import '../usernames/new.dart';
import '../util/secret_reader.dart';

class MyZoneScreen extends StatefulWidget {
  const MyZoneScreen({Key? key}) : super(key: key);

  @override
  State<MyZoneScreen> createState() => _MyZoneScreenState();
}

class _MyZoneScreenState extends State<MyZoneScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> friendsListUids = [];
  late InfoProviders result;
  List<UserBasicModel> followingList = [];
  bool isLoading = true;
  List<dynamic> followingListUids = [];
  UserBasicModel? curUserData;

  @override
  void initState() {
    SecretReader.instance.loadKeyCenterData().then((_) {
      // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
      ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
          SecretReader.instance.serverSecret, (_) => null);
    });
    result = Provider.of<InfoProviders>(context, listen: false);
    _tabController = TabController(initialIndex: 1, length: 2, vsync: this);
    getFriendList();

    super.initState();
  }

  Future<void> getFriendList() async {
    debugPrint("TRY HERE");
    FirebaseFirestore.instance
        .collection('followList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final e = value.data();
      followingListUids.clear();
      followingListUids = (e!['following'] as List);
      result.fetchUserDataByIds(followingListUids).then((_) {
        followingList.clear();
        followingList = result.usersDataByIds;
        result.callCurrentUserData().then((value) {
          curUserData = value;
          setState(() {
            isLoading = false;
          });
        });
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
              onRefresh: getFriendList,

              // FutureBuilder(
              //     future: getFriendList(),
              //     builder: (ctx, snapShots) {
              child: Stack(
                alignment: Alignment.centerLeft,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlassmorphicContainer(
                            height: getVerticalSize(68),
                            width: getHorizontalSize(360),
                            borderRadius: 5,
                            blur: 5,
                            alignment: Alignment.bottomCenter,
                            border: 3,
                            linearGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.2),
                                  const Color(0xFFFFFFFF).withOpacity(0.2),
                                ],
                                stops: const [
                                  0.1,
                                  1,
                                ]),
                            borderGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white10.withOpacity(0.5),
                                Colors.white10.withOpacity(0.5),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: getVerticalSize(15),
                                      left: getHorizontalSize(20)),
                                  width: getHorizontalSize(220),
                                  child: TabBar(
                                    // indicatorColor:
                                    //     ColorConstant.deepPurple900,

                                    indicator: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        gradient: LinearGradient(colors: [
                                          ColorConstant.textStart,
                                          ColorConstant.textEnd
                                        ])),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    controller: _tabController,
                                    labelPadding:
                                        const EdgeInsets.only(bottom: 4),
                                    indicatorWeight: 2.5,
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
                                        "My Zone",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Trending",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: getHorizontalSize(10),
                                      bottom: getVerticalSize(15)),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SearchScreen()));
                                        },
                                        child: Icon(
                                          Icons.search,
                                          color: ColorConstant.gray800,
                                          size: getFontSize(30),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyRoomsScreen()));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: getHorizontalSize(15),
                                                right: 15),
                                            child: Icon(
                                              Icons.home,
                                              color: ColorConstant.gray800,
                                              size: getFontSize(30),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('userJoinRoom')
                                    .snapshots(),
                                builder: (ctx, snapShots) {
                                  if (snapShots.hasData) {
                                    final userDocs = snapShots.data!.docs;
                                    List<Map<String, dynamic>> datass = [];
                                    for (int i = 0;
                                        i < followingListUids.length;
                                        i++) {
                                      int flag = 0;
                                      for (int j = 0;
                                          j < userDocs.length;
                                          j++) {
                                        if ((userDocs[j]['userId'] as String)
                                                .isNotEmpty &&
                                            (followingListUids[i] as String)
                                                .contains(
                                                    userDocs[j]['userId'])) {
                                          debugPrint(
                                              "ENTERED IN IF LOOP: $j TIMES");
                                          Map<String, dynamic> mpD = {};
                                          mpD = {
                                            "roomName": (userDocs[j]['roomName']
                                                as String),
                                            "roomId": (userDocs[j]['roomId']
                                                as String),
                                            "userId": (userDocs[j]['userId']
                                                as String),
                                            "type":
                                                (userDocs[j]['type'] as String),
                                            "members":
                                                (userDocs[j]['members'] as int),
                                            "hostName": userDocs[j]['hostName']
                                                as String,
                                            "imageRoom": userDocs[j]
                                                ['imageRoom'] as String,
                                          };
                                          datass.add(mpD);
                                          flag = 1;
                                        }
                                      }
                                      if (flag == 0) {
                                        datass.add({
                                          "roomName": '',
                                          "roomId": '',
                                          "userId": '',
                                          "type": '',
                                          "members": 0,
                                          "hostName": "",
                                          "imageRoom": "",
                                        });
                                      }
                                    }
                                    debugPrint(
                                        "LENGTH MYZONE DATA LIST: ${datass.length}");
                                    return Container(
                                      margin: EdgeInsets.only(
                                        left: getHorizontalSize(13.00),
                                        right: getHorizontalSize(12.00),
                                      ),
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: followingList.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> mp = {};
                                          if (userDocs.isNotEmpty) {
                                            mp = {
                                              "roomName": (datass[index]
                                                  ['roomName'] as String),
                                              "roomId": (datass[index]['roomId']
                                                  as String),
                                              "userId": (datass[index]['userId']
                                                  as String),
                                              "type": (datass[index]['type']
                                                  as String),
                                              "members": (datass[index]
                                                  ['members'] as int),
                                              "imageRoom": (datass[index]
                                                  ['imageRoom'] as String),
                                              "hostName": (datass[index]
                                                  ['hostName'] as String)
                                            };
                                          }
                                          // CHECK OFFLINE/ONLINE STATUS AND RETURN CONTAINER IF OFFLINE
                                          return (followingList[index].status ==
                                                      "Offline" ||
                                                  (mp['roomId'] as String)
                                                      .isEmpty)
                                              ? Container()
                                              : MyZoneItemWidget(
                                                  curData: curUserData!,
                                                  onlineStatus:
                                                      followingList[index]
                                                          .status,
                                                  index: index,
                                                  followingList:
                                                      followingList[index],
                                                  userRoomData: mp.isEmpty
                                                      ? {
                                                          "roomName": '',
                                                          "roomId": '',
                                                          "userId": '',
                                                          "type": '',
                                                          "members": 0,
                                                          "imageRoom": "",
                                                          "hostName": "",
                                                        }
                                                      : mp);
                                        },
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.pink,
                                      ),
                                    );
                                  }
                                },
                              ),
                              const TrendingScreen(),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //     left: getHorizontalSize(13.00),
                              //     right: getHorizontalSize(13.00),
                              //   ),
                              //   child: GridView.builder(
                              //     shrinkWrap: true,
                              //     scrollDirection: Axis.vertical,
                              //     gridDelegate:
                              //         SliverGridDelegateWithFixedCrossAxisCount(
                              //       mainAxisExtent: getVerticalSize(181.00),
                              //       crossAxisCount: 2,
                              //       mainAxisSpacing: getHorizontalSize(9.00),
                              //       crossAxisSpacing: getHorizontalSize(8.00),
                              //     ),
                              //     physics: const BouncingScrollPhysics(),
                              //     itemCount: 8,
                              //     itemBuilder: (context, index) {
                              //       return TrendingItemWidget(
                              //         index: index,
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: getVerticalSize(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/img_group9002.png",
                              width: getHorizontalSize(55),
                              height: getVerticalSize(55),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const Message()));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: getHorizontalSize(12)),
                                child: Image.asset(
                                  "assets/images/img_group9007.png",
                                  width: getHorizontalSize(60),
                                  height: getVerticalSize(60),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const Profile()));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: getHorizontalSize(12)),
                                child: Image.asset(
                                  "assets/images/img_group9006.png",
                                  width: getHorizontalSize(60),
                                  height: getVerticalSize(60),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              )
              //   },
              // ),
              ),
    ));
  }
}
