import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/providers/info_providers.dart';
import 'package:final_yr_project/refresh_indicator/refresh_widget.dart';
import 'package:final_yr_project/search_screen/search_screen.dart';
import 'package:final_yr_project/usernames/new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'core/utils/color_constant.dart';
import 'core/utils/image_constant.dart';
import 'core/utils/math_utils.dart';
import 'group112_item_widget.dart';
import 'model/user_model.dart';
import 'my_rooms_screen/my_rooms_screen.dart';
import 'my_zone_screen/my_zone_screen.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  late InfoProviders result;
  UserBasicModel? userData;
  bool isLoading = false;
  List<UserBasicModel> friendsList = [];
  List<dynamic> friendsListUIds = [];
  late TabController _tabController;

  @override
  void initState() {
    getMessageList();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future getMessageList() async {
    result = Provider.of<InfoProviders>(context, listen: false);
    FirebaseFirestore.instance
        .collection('followList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      final e = value.data();
      // friendsListUIds.clear();
      final followingList = (e!['following'] as List);
      final followerslist = (e['followers'] as List);
      debugPrint("FOLLOWERS LENGHT LIST: ${followerslist.length}");
      debugPrint("FOLLOWING LENGHT LIST: ${followingList.length}");
      for (int i = 0; i < followerslist.length; i++) {
        for (int j = 0; j < followingList.length; j++) {
          if ((followerslist[i]) == followingList[j]) {
            friendsListUIds.add(followerslist[i]);
          }
        }
      }
      debugPrint("FRIENDS LIST UIDS LENGTH: ${friendsListUIds.length}");
      // friendsListUIds = e!['friends'] as List;
      result.fetchUserDataByIds(friendsListUIds).then((_) {
        friendsList = result.usersDataByIds;
        // debugPrint("DATALIST VALUE: ${friendsList[0].name}");
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
        // backgroundColor: ColorConstant.whiteA700,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshWidget(
                onRefresh: getMessageList,
                child: Stack(
                  alignment: Alignment.bottomCenter,
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
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          GlassmorphicContainer(
                              height: getVerticalSize(77),
                              margin: EdgeInsets.only(
                                bottom: getVerticalSize(
                                  0.00,
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
                                  Colors.white10.withOpacity(0.2),
                                  Colors.white10.withOpacity(0.2),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: getVerticalSize(5),
                                        left: getHorizontalSize(20)),
                                    width: getHorizontalSize(230),
                                    child: TabBar(
                                      indicator: ShapeDecoration(
                                          shape: RoundedRectangleBorder(),
                                          gradient: LinearGradient(colors: [
                                            ColorConstant.textStart,
                                            ColorConstant.textEnd
                                          ])),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      controller: _tabController,
                                      labelPadding: EdgeInsets.only(bottom: 4),
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
                                          "Message",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "Notification",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      debugPrint("HERE");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const SearchScreen()));
                                    },
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Icon(
                                          Icons.search,
                                          color: ColorConstant.gray800,
                                          size: getFontSize(30),
                                        )),
                                  ),

                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyRoomsScreen()));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10,
                                            right: getHorizontalSize(10),
                                            bottom: 5),
                                        child: Icon(
                                          Icons.home,
                                          color: ColorConstant.gray800,
                                          size: getFontSize(30),
                                        )),
                                  )
                                ],
                              )),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('allMessage')
                                      .snapshots(),
                                  builder: (ctx, snapShots) {
                                    if (snapShots.hasData) {
                                      final chatData = snapShots.data!.docs;
                                      return Container(
                                        margin: EdgeInsets.only(
                                            // top: getVerticalSize(78),
                                            left: getHorizontalSize(15),
                                            right: getHorizontalSize(15)),
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: chatData.length,
                                          // itemCount: friendsList.length,
                                          itemBuilder: (context, index) {
                                            return !((chatData[index]['bothIds']
                                                        as String)
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid))
                                                ? Container()
                                                : Group112ItemWidget(
                                                    // frndList: friendsList[index],
                                                    chatData: chatData[index]);
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
                                Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: getVerticalSize(25)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => MyZoneScreen()));
                                  },
                                  child: Image.asset(
                                    "assets/images/img_group9005.png",
                                    width: getHorizontalSize(60),
                                    height: getVerticalSize(60),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getHorizontalSize(10)),
                                child: Image.asset(
                                  "assets/images/img_group9004.png",
                                  width: getHorizontalSize(55),
                                  height: getVerticalSize(55),
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
                                      left: getHorizontalSize(10)),
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
                ),
              ),
      ),
    );
  }
}
