import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/color_constant.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../constants/zego_page_constant.dart';
import '../constants/zim_error_code.dart';
import '../inbox_screen/inbox_screen.dart';
import '../localization/localisation.dart';
import '../model/user_model.dart';
import '../model/zego_room_user_role.dart';
import '../model/zego_user_info.dart';
import '../providers/info_providers.dart';
import '../service/zego_room_manager.dart';
import '../service/zego_room_service.dart';
import '../service/zego_user_service.dart';
import '../util/secret_reader.dart';

class OtherUser extends StatefulWidget {
  const OtherUser({Key? key, required this.otherUserData}) : super(key: key);
  // final QueryDocumentSnapshot<Object?> otherUserData;
  final UserBasicModel otherUserData;

  @override
  State<OtherUser> createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  bool contain = false;
  late InfoProviders result;
  Map<String, dynamic> followMap = {};
  List<dynamic> friendsListUid = [];
  bool isLoading = true;
  List<dynamic> following = [];
  List<dynamic> followers = [];
  List<dynamic> removeFollowers = [];
  List<dynamic> removeFollowing = [];
  List<dynamic> followersList = [];
  List<dynamic> followingList = [];
  // String hostName = '';
  UserBasicModel? curUserData;
  String _linkMessage = '';
  final _ssController = ScreenshotController();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  int likOnMe = 0;

  @override
  void initState() {
    SecretReader.instance.loadKeyCenterData().then((_) {
      // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
      ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
          SecretReader.instance.serverSecret, (_) => null);
    });
    result = Provider.of<InfoProviders>(context, listen: false);
    getFollowData();
    super.initState();
  }

  Future<void> _createDynamicLink(bool short, UserBasicModel userData) async {
    // setState(() {
    //   _isCreatingLink = true;
    // });

    // const String DynamicLink = 'https://thelolapp.page.link/lolProfile';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://thelolapp.page.link',
      // longDynamicLink: Uri.parse(
      //   'https://reactnativefirebase.page.link/?efr=0&ibi=io.invertase.testing&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Ftest-app%2Fhelloworld&ofl=https://ofl-example.com',
      // ),
      link: Uri.parse(
          'https://thelolapp.page.link/lolProfile?id=${userData.userId}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.final_yr_project',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.invertase.testing',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage =
          "Hey Check out this cool profile on the Lol app " + url.toString();
      // _isCreatingLink = false;
    });
  }

  Future<void> saveAndShare(Uint8List bytes) async {
    Directory? directory = await getApplicationDocumentsDirectory();
    final image = File("${directory.path}/screenshot.png");
    image.writeAsBytesSync(bytes);
    const text = 'Check out the cool profile I have seen on Lol app';
    await Share.shareFiles([image.path], text: _linkMessage);
  }

  void tryJoinRoom(BuildContext context, String roomID, String romName,
      String useId, String imgRoom, String hostName) async {
    if (roomID.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toastRoomIdEnterError,
          backgroundColor: Colors.grey);
      return;
    }

    var room = context.read<ZegoRoomService>();
    final code = await room.joinRoom(roomID);
    // .then((code) {
    if (code != 0) {
      String message = AppLocalizations.of(context)!.toastJoinRoomFail(code);
      if (code == ZIMErrorCodeExtension.valueMap[zimErrorCode.roomNotExist]) {
        message = AppLocalizations.of(context)!.toastRoomNotExistFail;
      }
      Fluttertoast.showToast(msg: message, backgroundColor: Colors.grey);
    } else {
      var users = context.read<ZegoUserService>();
      if (room.roomInfo.hostID == users.localUserInfo.userID) {
        users.localUserInfo.userRole = ZegoRoomUserRole.roomUserRoleHost;
        // hostName = users.localUserInfo.userName;
      }
      List usersRoomList = [];
      usersRoomList.add(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection('hostRoomData')
          .doc(useId)
          .update({
        "users": FieldValue.arrayUnion(usersRoomList),
        "todayUsers": FieldValue.arrayUnion(usersRoomList),
      });
      await FirebaseFirestore.instance
          .collection('userJoinRoom')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "roomName": room.roomInfo.roomName,
        "roomId": room.roomInfo.roomID,
        "type": "user",
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "members": 0,
        "imageRoom": imgRoom,
        "hostName": hostName,
      });
      if (useId != FirebaseAuth.instance.currentUser!.uid) {
        final date = DateTime.now();
        final dateTime = date.toString().split(' ')[0];
        final mp = {
          "roomName": room.roomInfo.roomName,
          "roomId": room.roomInfo.roomID,
          "hostName": hostName,
          "createdAt": dateTime,
          "imageRoom": imgRoom,
          "userId": FirebaseAuth.instance.currentUser!.uid,
        };
        final listData = [];
        listData.add(mp);
        debugPrint("REACHED HERE");
        final docIdExists = await FirebaseFirestore.instance
            .collection('recentVisited')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('visited')
            .doc(dateTime)
            .get();
        if (!docIdExists.exists) {
          debugPrint("ALSO HERE");
          await FirebaseFirestore.instance
              .collection('recentVisited')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('visited')
              .doc(dateTime)
              .set({
            "recentList": FieldValue.arrayUnion(listData),
          });
        } else {
          debugPrint("NOW HERE");
          await FirebaseFirestore.instance
              .collection('recentVisited')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('visited')
              .doc(dateTime)
              .update({
            "recentList": FieldValue.arrayUnion(listData),
          });
        }
      }
      Navigator.pushReplacementNamed(context, PageRouteNames.roomMain,
          arguments: {
            "roomName": romName,
            "roomId": roomID,
            "hostName": hostName,
            "hostId": useId,
            "imagePickRoom": imgRoom,
          });
      // });
    }
  }

  Future<void> getFollowData() async {
    result.callCurrentUserFollowData(widget.otherUserData.userId).then((value) {
      followMap = value;
      // friendsListUid.clear();
      followingList = (followMap['following'] as List);
      followersList = (followMap['followers'] as List);
      for (int i = 0; i < followersList.length; i++) {
        for (int j = 0; j < followingList.length; j++) {
          if ((followersList[i] as String) == followingList[j].toString()) {
            friendsListUid.add(followersList[i]);
          }
        }
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        final e = value.data();
        curUserData = UserBasicModel(
            userId: e!['userId'],
            name: e['name'],
            dob: e['dateBirth'],
            gender: e['gender'],
            imageUrl: e['imageUrl'],
            coverImage: e['coverImage'],
            about: e['about'],
            address: e['address'],
            status: e['status'],
            frontUid: e['frontUid'],
            likesOnMe: e['likesOnMe']);
        likOnMe = e['likesOnMe'];
        setState(() {
          isLoading = false;
        });
      });
      // curUserData = result.curUserData;
      // result.callCurrentUserData().then((value) {
      //   curUserData = value;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Screenshot(
        controller: _ssController,
        child: Scaffold(
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                )
              : SingleChildScrollView(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('userJoinRoom')
                        .doc(widget.otherUserData.userId)
                        .snapshots(),
                    builder: (ctx, snapShots) {
                      if (!snapShots.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        );
                      } else {
                        final roomJoinData = snapShots.data!.data();
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: getVerticalSize(
                                      736.00,
                                    ),
                                    width: size.width,
                                    child: Stack(
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
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.23,
                                              width: size.width,
                                              child: Stack(
                                                children: [
                                                  GestureDetector(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: (widget
                                                                  .otherUserData
                                                                  .coverImage)
                                                              .trim()
                                                              .isNotEmpty
                                                          ? Image.network(
                                                              widget
                                                                  .otherUserData
                                                                  .coverImage,
                                                              fit: BoxFit.cover,
                                                              width:
                                                                  getHorizontalSize(
                                                                      360.00),
                                                            )
                                                          : Image.asset(
                                                              ImageConstant
                                                                  .imgUnsplashyp4wgd,
                                                              width:
                                                                  getHorizontalSize(
                                                                      360.00),
                                                              fit: BoxFit.fill,
                                                            ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: getVerticalSize(35),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black45,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ColorConstant
                                                              .black90026,
                                                          spreadRadius:
                                                              getHorizontalSize(
                                                                  2.00),
                                                          blurRadius:
                                                              getHorizontalSize(
                                                                  2.00),
                                                          offset: const Offset(
                                                              0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                                    15.00),
                                                          ),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                                Icons
                                                                    .arrow_back,
                                                                color: Colors
                                                                    .white),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                constraints:
                                                                    const BoxConstraints(
                                                                        maxHeight:
                                                                            280),
                                                                builder: (ctx) {
                                                                  return Stack(
                                                                    children: [
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .bottomCenter,
                                                                          child:
                                                                              GlassmorphicContainer(
                                                                            borderRadius:
                                                                                0,
                                                                            width:
                                                                                size.width,
                                                                            blur:
                                                                                10,
                                                                            alignment:
                                                                                Alignment.bottomCenter,
                                                                            border:
                                                                                1,
                                                                            linearGradient:
                                                                                LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                                                              const Color(0xFFffffff).withOpacity(0.2),
                                                                              const Color(0xFFFFFFFF).withOpacity(0.2),
                                                                            ], stops: const [
                                                                              0.1,
                                                                              1,
                                                                            ]),
                                                                            borderGradient:
                                                                                LinearGradient(
                                                                              begin: Alignment.topLeft,
                                                                              end: Alignment.bottomRight,
                                                                              colors: [
                                                                                Colors.white10.withOpacity(0.2),
                                                                                Colors.white10.withOpacity(0.2),
                                                                              ],
                                                                            ),
                                                                            height:
                                                                                getVerticalSize(280),
                                                                          )),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          height:
                                                                              getVerticalSize(
                                                                            50.00,
                                                                          ),
                                                                          width:
                                                                              size.width,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ColorConstant.whiteA70019,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: ColorConstant.black90033,
                                                                                spreadRadius: getHorizontalSize(
                                                                                  2.00,
                                                                                ),
                                                                                blurRadius: getHorizontalSize(
                                                                                  2.00,
                                                                                ),
                                                                                offset: const Offset(
                                                                                  0,
                                                                                  4,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: getHorizontalSize(20)),
                                                                            child:
                                                                                Text(
                                                                              "Settings",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: ColorConstant.whiteA700,
                                                                                fontSize: getFontSize(20),
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: getVerticalSize(
                                                                            70),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () async {
                                                                                    final image = await _ssController.capture();
                                                                                    await _createDynamicLink(false, widget.otherUserData);
                                                                                    debugPrint("LINK GENERATED: $_linkMessage");
                                                                                    saveAndShare(image!);
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                                                                                    width: size.width * 0.95,
                                                                                    child: const Text(
                                                                                      'Share Profile',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const Divider(
                                                                                color: Colors.white,
                                                                                thickness: 1),
                                                                            const SizedBox(height: 8),
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                                                                                  width: size.width * 0.95,
                                                                                  child: const Text(
                                                                                    'Block',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 18,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const Divider(
                                                                                color: Colors.white,
                                                                                thickness: 1),
                                                                            const SizedBox(height: 8),
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                                                                                  width: size.width * 0.95,
                                                                                  child: const Text(
                                                                                    'Report',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 18,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )

                                                                      // GlassmorphicContainer(
                                                                      //   blur: 5,
                                                                      //   width: double.infinity,
                                                                      //   borderRadius: 0,
                                                                      //   alignment: Alignment.centerLeft,
                                                                      //   border: 1,
                                                                      //   linearGradient: LinearGradient(
                                                                      //       begin: Alignment.topLeft,
                                                                      //       end: Alignment.bottomRight,
                                                                      //       colors: [
                                                                      //         const Color(0xFFffffff).withOpacity(0.2),
                                                                      //         const Color(0xFFFFFFFF).withOpacity(0.2),
                                                                      //       ],
                                                                      //       stops: const [
                                                                      //         0.1,
                                                                      //         1,
                                                                      //       ]),
                                                                      //   borderGradient: LinearGradient(
                                                                      //     begin: Alignment.topLeft,
                                                                      //     end: Alignment.bottomRight,
                                                                      //     colors: [
                                                                      //       Colors.white10.withOpacity(0.2),
                                                                      //       Colors.white10.withOpacity(0.2),
                                                                      //     ],
                                                                      //   ),
                                                                      //   height: 50,
                                                                      //   padding: const EdgeInsets.only(left: 15),
                                                                      //   child: const Text(
                                                                      //     '    Invite to join the room',
                                                                      //     style: TextStyle(
                                                                      //         color: Colors.white,
                                                                      //         fontWeight: FontWeight.bold,
                                                                      //         fontSize: 18),
                                                                      //   ),
                                                                      // ),
                                                                      // Container(
                                                                      //     margin: const EdgeInsets.only(top: 60),
                                                                      //     height: 370,
                                                                      //     child: AdminMutePanel(romName: roomName, romId: roomId)),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: SizedBox(
                                                              height:
                                                                  getVerticalSize(
                                                                      18.00),
                                                              width:
                                                                  getHorizontalSize(
                                                                      57.57),
                                                              child: const Icon(
                                                                  Icons.menu,
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              child: GlassmorphicContainer(
                                                borderRadius: 15,
                                                width: size.width,
                                                blur: 15,
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                                    Colors.white10
                                                        .withOpacity(0.2),
                                                    Colors.white10
                                                        .withOpacity(0.2),
                                                  ],
                                                ),
                                                height: getVerticalSize(188),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: size.height * 0.07),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  10.00),
                                                          top: getVerticalSize(
                                                            size.height * 0.09,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          6.00),
                                                                  right:
                                                                      getHorizontalSize(
                                                                          9.00),
                                                                ),
                                                                child: Text(
                                                                  friendsListUid
                                                                      .length
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .black900,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            14),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top:
                                                                      getVerticalSize(
                                                                          4.51),
                                                                ),
                                                                child: Text(
                                                                  "Friends",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .gray601,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            12),
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
                                                      Container(
                                                        height: getVerticalSize(
                                                            27.65),
                                                        width:
                                                            getHorizontalSize(
                                                                1.78),
                                                        margin: EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  22.00),
                                                          top: getVerticalSize(
                                                              size.height *
                                                                  0.09),
                                                          bottom:
                                                              getVerticalSize(
                                                                  14.35),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .gray500,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  22.00),
                                                          top: getVerticalSize(
                                                            size.height * 0.09,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                                  10.49),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          11.00),
                                                                  right:
                                                                      getHorizontalSize(
                                                                          11.00),
                                                                ),
                                                                child: Text(
                                                                  (followMap['following']
                                                                          as List)
                                                                      .length
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .black900,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            14),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top:
                                                                      getVerticalSize(
                                                                          4.51),
                                                                ),
                                                                child: Text(
                                                                  "Following",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .gray601,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            12),
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
                                                      Container(
                                                        height: getVerticalSize(
                                                            27.65),
                                                        width:
                                                            getHorizontalSize(
                                                                1.78),
                                                        margin: EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  22.00),
                                                          top: getVerticalSize(
                                                              size.height *
                                                                  0.09),
                                                          bottom:
                                                              getVerticalSize(
                                                                  14.35),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .gray500,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                                  22.01),
                                                          top: getVerticalSize(
                                                              size.height *
                                                                  0.09),
                                                          bottom:
                                                              getVerticalSize(
                                                                  10.49),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          11.00),
                                                                  right:
                                                                      getHorizontalSize(
                                                                          11.00),
                                                                ),
                                                                child: Text(
                                                                  (followMap['followers']
                                                                          as List)
                                                                      .length
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .black900,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            14),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top:
                                                                      getVerticalSize(
                                                                          4.51),
                                                                ),
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
                                                                        .gray601,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            12),
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
                                                      // Container(
                                                      //   height: getVerticalSize(
                                                      //       27.65),
                                                      //   width: getHorizontalSize(
                                                      //       1.78),
                                                      //   margin: EdgeInsets.only(
                                                      //     left: getHorizontalSize(
                                                      //         22.00),
                                                      //     top: getVerticalSize(
                                                      //         size.height * 0.09),
                                                      //     bottom: getVerticalSize(
                                                      //         14.35),
                                                      //   ),
                                                      //   decoration: BoxDecoration(
                                                      //     color: ColorConstant
                                                      //         .gray500,
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding: EdgeInsets.only(
                                                      //     left: getHorizontalSize(
                                                      //         22.00),
                                                      //     top: getVerticalSize(
                                                      //         size.height * 0.09),
                                                      //     right:
                                                      //         getHorizontalSize(
                                                      //             15.65),
                                                      //     bottom: getVerticalSize(
                                                      //         10.49),
                                                      //   ),
                                                      //   child: Column(
                                                      //     mainAxisSize:
                                                      //         MainAxisSize.min,
                                                      //     crossAxisAlignment:
                                                      //         CrossAxisAlignment
                                                      //             .center,
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .start,
                                                      //     children: [
                                                      //       Align(
                                                      //         alignment: Alignment
                                                      //             .centerLeft,
                                                      //         child: Padding(
                                                      //           padding:
                                                      //               EdgeInsets
                                                      //                   .only(
                                                      //             left:
                                                      //                 getHorizontalSize(
                                                      //               5.00,
                                                      //             ),
                                                      //             right:
                                                      //                 getHorizontalSize(
                                                      //               0.00,
                                                      //             ),
                                                      //           ),
                                                      //           child: Text(
                                                      //             (followMap['visitors']
                                                      //                     as List)
                                                      //                 .length
                                                      //                 .toString(),
                                                      //             overflow:
                                                      //                 TextOverflow
                                                      //                     .ellipsis,
                                                      //             textAlign:
                                                      //                 TextAlign
                                                      //                     .left,
                                                      //             style:
                                                      //                 TextStyle(
                                                      //               color: ColorConstant
                                                      //                   .black900,
                                                      //               fontSize:
                                                      //                   getFontSize(
                                                      //                 14,
                                                      //               ),
                                                      //               fontFamily:
                                                      //                   'Roboto',
                                                      //               fontWeight:
                                                      //                   FontWeight
                                                      //                       .w700,
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       Align(
                                                      //         alignment: Alignment
                                                      //             .centerLeft,
                                                      //         child: Padding(
                                                      //           padding:
                                                      //               EdgeInsets
                                                      //                   .only(
                                                      //             top:
                                                      //                 getVerticalSize(
                                                      //               4.51,
                                                      //             ),
                                                      //           ),
                                                      //           child: Text(
                                                      //             "Visitors",
                                                      //             overflow:
                                                      //                 TextOverflow
                                                      //                     .ellipsis,
                                                      //             textAlign:
                                                      //                 TextAlign
                                                      //                     .left,
                                                      //             style:
                                                      //                 TextStyle(
                                                      //               color: ColorConstant
                                                      //                   .gray601,
                                                      //               fontSize:
                                                      //                   getFontSize(
                                                      //                 12,
                                                      //               ),
                                                      //               fontFamily:
                                                      //                   'Roboto',
                                                      //               fontWeight:
                                                      //                   FontWeight
                                                      //                       .w400,
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ((roomJoinData as Map<String,
                                                            dynamic>)['roomId']
                                                        as String)
                                                    .isEmpty
                                                ? const SizedBox()
                                                : GestureDetector(
                                                    onTap: () async {
                                                      ZegoUserInfo info =
                                                          ZegoUserInfo.empty();
                                                      info.userID =
                                                          curUserData!.userId;
                                                      info.userName =
                                                          curUserData!.name;
                                                      if (info
                                                          .userName.isEmpty) {
                                                        info.userName =
                                                            info.userID;
                                                      }
                                                      var userModel =
                                                          context.read<
                                                              ZegoUserService>();
                                                      final errorCode =
                                                          await userModel.login(
                                                              info, "");
                                                      // .then((errorCode)
                                                      if (errorCode != 0) {
                                                        Fluttertoast.showToast(
                                                            msg: AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .toastLoginFail(
                                                                    errorCode),
                                                            backgroundColor:
                                                                Colors.grey);
                                                        return;
                                                      } else {
                                                        tryJoinRoom(
                                                            context,
                                                            (roomJoinData as Map<
                                                                    String,
                                                                    dynamic>)[
                                                                'roomId'],
                                                            (roomJoinData)[
                                                                'roomName'],
                                                            roomJoinData[
                                                                'userId'],
                                                            roomJoinData[
                                                                'imageRoom'],
                                                            roomJoinData[
                                                                'hostName']);
                                                      }
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top:
                                                              getHorizontalSize(
                                                                  10),
                                                          left: 5,
                                                          right: 5),
                                                      height: 70,
                                                      child: Center(
                                                        child: Card(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    getHorizontalSize(
                                                                        15.00),
                                                                  ),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          2.0)),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      getHorizontalSize(
                                                                        15.00,
                                                                      ),
                                                                    ),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin:
                                                                          const Alignment(
                                                                        -0.001697166058858155,
                                                                        0.5074751480283091,
                                                                      ),
                                                                      end:
                                                                          const Alignment(
                                                                        0.9983028339411415,
                                                                        0.5074752102704458,
                                                                      ),
                                                                      colors: [
                                                                        ColorConstant
                                                                            .deepPurple900,
                                                                        ColorConstant
                                                                            .purple500,
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Image.asset(
                                                                    ImageConstant
                                                                        .imgComponentlott,
                                                                    height: getVerticalSize(
                                                                        120.00),
                                                                    width: getHorizontalSize(
                                                                        120.00),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Image.asset(
                                                                    ImageConstant
                                                                        .imgComponentlott1,
                                                                    height: getVerticalSize(
                                                                        120.00),
                                                                    width: getHorizontalSize(
                                                                        110.00),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Image.asset(
                                                                    ImageConstant
                                                                        .imgComponentlott,
                                                                    height: getVerticalSize(
                                                                        140.00),
                                                                    width: getHorizontalSize(
                                                                        120.00),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: getHorizontalSize(
                                                                          10),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                2.0,
                                                                            color:
                                                                                ColorConstant.deepPurple900),
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        (roomJoinData)[
                                                                            'imageRoom'],
                                                                        height:
                                                                            getSize(50),
                                                                        width: getSize(
                                                                            50),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: getVerticalSize(
                                                                              15.00),
                                                                          left:
                                                                              getHorizontalSize(10.00),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          (roomJoinData)[
                                                                              'roomName'],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorConstant.whiteA700,
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
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: getVerticalSize(5.0), left: getHorizontalSize(10)),
                                                                            child:
                                                                                SizedBox(
                                                                              height: getSize(12.55),
                                                                              width: getSize(12.55),
                                                                              child: const Icon(Icons.account_circle, color: Colors.white, size: 15),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: getHorizontalSize(3.00), top: getVerticalSize(5)),
                                                                            child:
                                                                                Text(
                                                                              "123",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: ColorConstant.whiteA700,
                                                                                fontSize: getFontSize(12),
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        getSize(
                                                                            12.55),
                                                                    width: getSize(
                                                                        12.55),
                                                                    margin: EdgeInsets.only(
                                                                        left: getHorizontalSize(
                                                                            10),
                                                                        bottom:
                                                                            getVerticalSize(14)),
                                                                    child: SvgPicture.asset(
                                                                        ImageConstant
                                                                            .img04f2f1fed89b09d,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        color: Colors
                                                                            .white70),
                                                                  ),
                                                                  Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: size
                                                                              .width *
                                                                          0.3,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorConstant
                                                                          .whiteA700,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        getHorizontalSize(
                                                                            25.00),
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                getHorizontalSize(10.06),
                                                                            top:
                                                                                getVerticalSize(6.00),
                                                                            bottom:
                                                                                getVerticalSize(5.64),
                                                                          ),
                                                                          child:
                                                                              Image.asset(
                                                                            ImageConstant.imgGroup1605,
                                                                            height:
                                                                                getVerticalSize(4.36),
                                                                            width:
                                                                                getHorizontalSize(5.33),
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                getHorizontalSize(3.55),
                                                                            top:
                                                                                getVerticalSize(2.00),
                                                                            right:
                                                                                getHorizontalSize(10.06),
                                                                            bottom:
                                                                                getVerticalSize(2.00),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "Join",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ColorConstant.gray800,
                                                                              fontSize: getFontSize(10),
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w600,
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
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            SingleChildScrollView(
                                              child: GlassmorphicContainer(
                                                margin: EdgeInsets.only(
                                                  top: getVerticalSize(10.00),
                                                ),
                                                height: getVerticalSize(268),
                                                borderRadius: 15,
                                                width: size.width,
                                                blur: 15,
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                                      1
                                                    ]),
                                                borderGradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.white10
                                                        .withOpacity(0.2),
                                                    Colors.white10
                                                        .withOpacity(0.2),
                                                  ],
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                                    23.00),
                                                            top:
                                                                getVerticalSize(
                                                                    13.00),
                                                            right:
                                                                getHorizontalSize(
                                                                    23.00),
                                                          ),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'About me',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .gray800,
                                                                    fontSize:
                                                                        getFontSize(
                                                                            22),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: getVerticalSize(
                                                            0.50),
                                                        width: size.width,
                                                        margin: EdgeInsets.only(
                                                          top: getVerticalSize(
                                                              7.31),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .black90026,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top:
                                                                getVerticalSize(
                                                                    7.00),
                                                            bottom:
                                                                getVerticalSize(
                                                                    15.00),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          23.00),
                                                                  right:
                                                                      getHorizontalSize(
                                                                          23.00),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                getVerticalSize(1.00),
                                                                            // bottom:
                                                                            //     getVerticalSize(30.00),
                                                                          ),
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                getSize(15.00),
                                                                            width:
                                                                                getSize(15.00),
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              ImageConstant.imgGroup1283,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              getHorizontalSize(267.00),
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                getHorizontalSize(18.00),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            (widget.otherUserData.about).trim().isNotEmpty
                                                                                ? widget.otherUserData.about
                                                                                : "User Bio Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without",
                                                                            maxLines:
                                                                                null,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ColorConstant.gray601,
                                                                              fontSize: getFontSize(
                                                                                15,
                                                                              ),
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.29,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              bottom: getVerticalSize(
                                                                                2.00,
                                                                              ),
                                                                              top: 10),
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                getSize(
                                                                              15.00,
                                                                            ),
                                                                            width:
                                                                                getSize(
                                                                              15.00,
                                                                            ),
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              ImageConstant.imgGroup1284,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: getHorizontalSize(
                                                                                17.00,
                                                                              ),
                                                                              top: 10),
                                                                          child:
                                                                              Text(
                                                                            widget.otherUserData.frontUid.toString(),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ColorConstant.gray601,
                                                                              fontSize: getFontSize(
                                                                                14,
                                                                              ),
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.29,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            getVerticalSize(
                                                                          15.00,
                                                                        ),
                                                                        right:
                                                                            getHorizontalSize(
                                                                          10.00,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              top: getVerticalSize(
                                                                                2.00,
                                                                              ),
                                                                              bottom: getVerticalSize(
                                                                                1.00,
                                                                              ),
                                                                            ),
                                                                            child: SizedBox(
                                                                                height: getVerticalSize(
                                                                                  15.00,
                                                                                ),
                                                                                width: getHorizontalSize(
                                                                                  12.91,
                                                                                ),
                                                                                child: const Icon(Icons.home, color: Colors.black45, size: 20)),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: getHorizontalSize(
                                                                                18.09,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              (widget.otherUserData.address).trim().isNotEmpty ? widget.otherUserData.address : "Home address",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.justify,
                                                                              style: TextStyle(
                                                                                color: ColorConstant.gray601,
                                                                                fontSize: getFontSize(
                                                                                  14,
                                                                                ),
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.29,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            getVerticalSize(
                                                                          15.00,
                                                                        ),
                                                                        right:
                                                                            getHorizontalSize(
                                                                          10.00,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              top: getVerticalSize(
                                                                                2.00,
                                                                              ),
                                                                              bottom: getVerticalSize(
                                                                                1.00,
                                                                              ),
                                                                            ),
                                                                            child: SizedBox(
                                                                                height: getVerticalSize(
                                                                                  15.00,
                                                                                ),
                                                                                width: getHorizontalSize(
                                                                                  13.06,
                                                                                ),
                                                                                child: const Icon(Icons.cake, color: Colors.black45, size: 20)),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: getHorizontalSize(
                                                                                17.94,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              widget.otherUserData.dob.substring(0, 10),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.justify,
                                                                              style: TextStyle(
                                                                                color: ColorConstant.gray601,
                                                                                fontSize: getFontSize(
                                                                                  14,
                                                                                ),
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.29,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: getVerticalSize(
                                                                            15.00,
                                                                          ),
                                                                          right: getHorizontalSize(
                                                                            10.00,
                                                                          ),
                                                                          bottom: getVerticalSize(70)),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              top: getVerticalSize(
                                                                                2.00,
                                                                              ),
                                                                              bottom: getVerticalSize(
                                                                                1.00,
                                                                              ),
                                                                            ),
                                                                            child: SizedBox(
                                                                                height: getVerticalSize(
                                                                                  15.00,
                                                                                ),
                                                                                width: getHorizontalSize(
                                                                                  10.98,
                                                                                ),
                                                                                child: const Icon(Icons.transgender_outlined, color: Colors.black45, size: 20)),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: getHorizontalSize(
                                                                                18.02,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              widget.otherUserData.gender,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.justify,
                                                                              style: TextStyle(
                                                                                color: ColorConstant.gray601,
                                                                                fontSize: getFontSize(
                                                                                  14,
                                                                                ),
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.29,
                                                                              ),
                                                                            ),
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.18,
                                              left: size.width * 0.79,
                                              right: size.width * 0.02),
                                          height: 26,
                                          decoration: BoxDecoration(
                                            color: ColorConstant.gray400,
                                            borderRadius: BorderRadius.circular(
                                              getHorizontalSize(
                                                16.00,
                                              ),
                                            ),
                                            border: Border.all(
                                              color: ColorConstant.gray600,
                                              width: getHorizontalSize(
                                                1.00,
                                              ),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorConstant.black90026,
                                                spreadRadius: getHorizontalSize(
                                                  2.00,
                                                ),
                                                blurRadius: getHorizontalSize(
                                                  2.00,
                                                ),
                                                offset: const Offset(
                                                  0,
                                                  4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          child: LikeButton(
                                            size: getHorizontalSize(59),
                                            circleColor: const CircleColor(
                                                start: Color(0xff00ddff),
                                                end: Color(0xff0099cc)),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor:
                                                  Color(0xff33b5e5),
                                              dotSecondaryColor:
                                                  Color(0xff0099cc),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    likOnMe
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: isLiked
                                                          ? Colors.red
                                                              .withOpacity(0.7)
                                                          : ColorConstant
                                                              .gray600,
                                                      fontSize: getFontSize(
                                                        15,
                                                      ),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color: isLiked
                                                          ? Colors.red
                                                              .withOpacity(0.7)
                                                          : Colors.grey,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: size.height * 0.18,
                                                  left: getHorizontalSize(15)),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.5,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    getHorizontalSize(
                                                      100.00,
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    widget
                                                        .otherUserData.imageUrl,
                                                    height: getSize(80.00),
                                                    width: getSize(80.00),
                                                    fit: BoxFit.fill,
                                                  )
                                                  // Image.asset(
                                                  //   ImageConstant.imgUnsplashkb41g1,
                                                  //   height: getSize(
                                                  //     80.00,
                                                  //   ),
                                                  //   width: getSize(
                                                  //     80.00,
                                                  //   ),
                                                  //   fit: BoxFit.fill,
                                                  // ),
                                                  ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: getHorizontalSize(16),
                                                  top: getVerticalSize(2)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.otherUserData.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: getFontSize(
                                                        25,
                                                      ),
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      debugPrint("PRINTED");
                                                      Clipboard.setData(ClipboardData(
                                                              text: widget
                                                                  .otherUserData
                                                                  .frontUid
                                                                  .toString()))
                                                          .then((_) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "User id is copied to clipboard")));
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'ID : ${widget.otherUserData.userId.substring(0, 9)}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      getFontSize(
                                                                    13,
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
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left:
                                                                getHorizontalSize(
                                                              6.00,
                                                            ),
                                                          ),
                                                          child: SizedBox(
                                                            height:
                                                                getVerticalSize(
                                                              12.00,
                                                            ),
                                                            width:
                                                                getHorizontalSize(
                                                              11.00,
                                                            ),
                                                            child: const Icon(
                                                                Icons.copy,
                                                                size: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: GestureDetector(
                                            onTap: followersList.contains(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                ? () async {
                                                    removeFollowers.add(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                    removeFollowing.add(widget
                                                        .otherUserData.userId);
                                                    followersList.remove(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'followList')
                                                        .doc(widget
                                                            .otherUserData
                                                            .userId)
                                                        .update({
                                                      "followers": FieldValue
                                                          .arrayRemove(
                                                              removeFollowers)
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'followList')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .update({
                                                      "following": FieldValue
                                                          .arrayRemove(
                                                              removeFollowing),
                                                      // "isFollowing": true,
                                                    });
                                                    // widget.refreshFn();
                                                    setState(() {});
                                                  }
                                                : () async {
                                                    // final currentUserData = await callCurrentUserData();
                                                    // followers.add(FirebaseAuth.instance.currentUser!.uid);
                                                    followers.add(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid);
                                                    following.add(widget
                                                        .otherUserData.userId);
                                                    followersList.add(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'followList')
                                                        .doc(widget
                                                            .otherUserData
                                                            .userId)
                                                        .update({
                                                      "followers":
                                                          FieldValue.arrayUnion(
                                                              followers),
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'followList')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .update({
                                                      "following":
                                                          FieldValue.arrayUnion(
                                                              following),
                                                      // "isFollowing": true,
                                                    });
                                                    // widget.refreshFn();
                                                    setState(() {});
                                                    // setState(() {
                                                    //   isFollow = true;
                                                    // });
                                                  },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: getHorizontalSize(30),
                                                  bottom: getVerticalSize(20)),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: getVerticalSize(
                                                      37.00,
                                                    ),
                                                    width: getHorizontalSize(
                                                      140.00,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        getHorizontalSize(
                                                          25.00,
                                                        ),
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
                                                          ColorConstant
                                                              .purple500,
                                                        ],
                                                      ),
                                                    ),
                                                    child: Text(
                                                      followersList.contains(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                          ? "Following"
                                                          : "Follow",
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        color: ColorConstant
                                                            .whiteA700,
                                                        fontSize: getFontSize(
                                                          16,
                                                        ),
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.13,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      InboxScreen(
                                                                        frndDataModel:
                                                                            widget.otherUserData,
                                                                      )));
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                          10.00,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: getVerticalSize(
                                                          37.00,
                                                        ),
                                                        width:
                                                            getHorizontalSize(
                                                          140.00,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            getHorizontalSize(
                                                              25.00,
                                                            ),
                                                          ),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                const Alignment(
                                                              -0.001697166058858155,
                                                              0.5074751480283091,
                                                            ),
                                                            end:
                                                                const Alignment(
                                                              0.9983028339411415,
                                                              0.5074752102704458,
                                                            ),
                                                            colors: [
                                                              ColorConstant
                                                                  .deepPurple900,
                                                              ColorConstant
                                                                  .purple500,
                                                            ],
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Message",
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                            height: 1.13,
                                                          ),
                                                        ),
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
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
