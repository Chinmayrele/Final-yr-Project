import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/my_rooms_screen/recent_visited.dart';
import 'package:final_yr_project/my_rooms_screen/widget/roomscreenwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
// import 'package:lol/my_rooms_screen/roomscreenwidget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../create_room_public_screen/create_room_public_screen.dart';
import '../model/user_model.dart';
import '../model/zego_user_info.dart';
import '../providers/info_providers.dart';
import '../recently/recently_visited.dart';
import '../roompages/room/room_entrance_page.dart';
import '../service/zego_room_manager.dart';
import '../service/zego_user_service.dart';
import '../util/secret_reader.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

class MyRoomsScreen extends StatefulWidget {
  const MyRoomsScreen({Key? key}) : super(key: key);

  @override
  State<MyRoomsScreen> createState() => _MyRoomsScreenState();
}

class _MyRoomsScreenState extends State<MyRoomsScreen>
    with SingleTickerProviderStateMixin {
  bool delete = false;
  int count = 4;
  int managedcount = 0;
  late TabController _tabController;
  UserBasicModel? userDataDetails;
  bool isLoading = true;
  bool isLoading02 = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    final result = Provider.of<InfoProviders>(context, listen: false);
    userDataDetails = result.curUserData;
    // result.callCurrentUserData().then((value) {
    //   userDataDetails = value;
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    super.initState();
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

  Map<String, dynamic> mapData = {};

  getHostRoomData() async {
    // setState(() {
    //   isLoading02 = true;
    // });
    final data = await FirebaseFirestore.instance
        .collection('hostRoomData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    mapData = {};
    mapData = data.data() as Map<String, dynamic>;
    // setState(() {
    //   isLoading02 = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body:
            // isLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.pink,
            //         ),
            //       )
            FutureBuilder(
          future: getHostRoomData(),
          builder: (ctx, futureSnaps) {
            if (futureSnaps.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              );
            } else {
              return Stack(
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
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('hostRoomData')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (ctx, snapShots) {
                      if (!snapShots.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        );
                      } else {
                        final roomHostJoin = snapShots.data!.data();
                        return Column(
                          children: [
                            GlassmorphicContainer(
                                margin: EdgeInsets.only(
                                  bottom: getVerticalSize(
                                    10.00,
                                  ),
                                ),
                                borderRadius: 20,
                                width: size.width,
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
                                    Colors.white.withOpacity(0.2),
                                    Colors.white.withOpacity(0.2),
                                  ],
                                ),
                                height: getVerticalSize(70),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: getVerticalSize(20),
                                          left: getHorizontalSize(12)),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: getVerticalSize(15),
                                          left: getHorizontalSize(5),
                                          right: 20),
                                      width: getHorizontalSize(235),
                                      child: TabBar(
                                        indicator: ShapeDecoration(
                                            shape:
                                                const RoundedRectangleBorder(),
                                            gradient: LinearGradient(colors: [
                                              ColorConstant.textStart,
                                              ColorConstant.textEnd
                                            ])),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        controller: _tabController,
                                        labelPadding:
                                            const EdgeInsets.only(bottom: 4),
                                        indicatorWeight: 2,
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
                                            "My Rooms",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "Recently Visited",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     setState(() {
                                    //       delete = !delete;
                                    //     });
                                    //   },
                                    //   child: Container(
                                    //       margin: EdgeInsets.only(
                                    //           left: getHorizontalSize(90),
                                    //           bottom: getVerticalSize(30)),
                                    //       height: getVerticalSize(
                                    //         17.00,
                                    //       ),
                                    //       width: getHorizontalSize(
                                    //         15.73,
                                    //       ),
                                    //       child: Icon(Icons.delete,
                                    //           size: 24,
                                    //           color:
                                    //               ColorConstant.gray800)),
                                    // ),
                                  ],
                                )),
                            Expanded(
                                child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          GlassmorphicContainer(
                                            width: double.infinity,
                                            borderRadius: 15,
                                            blur: 5,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: getVerticalSize(2)),
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
                                                Colors.white.withOpacity(0.2),
                                                Colors.white.withOpacity(0.2),
                                              ],
                                            ),
                                            height: getVerticalSize(119),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        20.00,
                                                      ),
                                                      top: getVerticalSize(
                                                        10.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        16.00,
                                                      ),
                                                    ),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'My rooms',
                                                            style: TextStyle(
                                                              color: ColorConstant
                                                                  .bluegray400,
                                                              fontSize:
                                                                  getFontSize(
                                                                18,
                                                              ),
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                (mapData['roomId'] as String)
                                                        .isEmpty
                                                    ? Container()
                                                    : MyRoomsScreenWidget(
                                                        delete: delete,
                                                        roomMapData: mapData,
                                                      )
                                                // Container(
                                                //   child: ListView.builder(
                                                //     scrollDirection:
                                                //         Axis.vertical,
                                                //     shrinkWrap: true,
                                                //     itemCount: count,
                                                //     itemBuilder:
                                                //         (context, index) {
                                                //       return MyRoomsScreenWidget(
                                                //           delete: delete);
                                                //     },
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          GlassmorphicContainer(
                                            margin: EdgeInsets.only(
                                              top: getVerticalSize(
                                                11.00,
                                              ),
                                            ),
                                            borderRadius: 15,
                                            width: size.width,
                                            blur: 5,
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
                                            height: (managedcount + 1) *
                                                getVerticalSize(515),
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                        20.00,
                                                      ),
                                                      top: getVerticalSize(
                                                        20.00,
                                                      ),
                                                      right: getHorizontalSize(
                                                        16.00,
                                                      ),
                                                    ),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'My Managed rooms',
                                                            style: TextStyle(
                                                              color: ColorConstant
                                                                  .bluegray400,
                                                              fontSize:
                                                                  getFontSize(
                                                                19,
                                                              ),
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                // CHANGE MAPDATA HERE TO THE LIST ITEMS FOR ADMIN
                                                (mapData['roomId'] as String)
                                                        .isEmpty
                                                    ? Container()
                                                    : ListView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: managedcount,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return MyRoomsScreenWidget(
                                                            delete: delete,
                                                            roomMapData:
                                                                mapData,
                                                          );
                                                        },
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      delete
                                          ? Container()
                                          : GestureDetector(
                                              onTap: (mapData['roomId']
                                                          as String)
                                                      .isNotEmpty
                                                  ? () {
                                                      snackBar(
                                                          'First delete your current room');
                                                    }
                                                  : () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RoomEntrancePage(
                                                                      currUserData:
                                                                          userDataDetails!)
                                                              // CreateRoomPublicScreen()
                                                              ));
                                                    },
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top:
                                                          getVerticalSize(620)),
                                                  height: getVerticalSize(40),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      getHorizontalSize(
                                                        25.00,
                                                      ),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin: const Alignment(
                                                        -4.967055933224884e-10,
                                                        0.5000000509950846,
                                                      ),
                                                      end: const Alignment(
                                                        1.018181829151207,
                                                        0.5333333860950145,
                                                      ),
                                                      colors: (mapData['roomId']
                                                                  as String)
                                                              .isNotEmpty
                                                          ? [
                                                              ColorConstant
                                                                  .bluegray400,
                                                              ColorConstant
                                                                  .bluegray100,
                                                            ]
                                                          : [
                                                              ColorConstant
                                                                  .deepPurple901,
                                                              ColorConstant
                                                                  .purpleA400,
                                                            ],
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  15.00),
                                                        ),
                                                        child: Container(
                                                            height:
                                                                getSize(19.00),
                                                            width:
                                                                getSize(19.00),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 7),
                                                            child: const Icon(
                                                              Icons.home,
                                                              size: 25,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  10.00),
                                                          top: getVerticalSize(
                                                              9.50),
                                                          right:
                                                              getHorizontalSize(
                                                                  15.00),
                                                          bottom:
                                                              getVerticalSize(
                                                                  9.50),
                                                        ),
                                                        child: Text(
                                                          "Create Room",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: ColorConstant
                                                                .whiteA700,
                                                            fontSize:
                                                                getFontSize(
                                                              16,
                                                            ),
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                const RecentVisited(),
                              ],
                            )),
                          ],
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
