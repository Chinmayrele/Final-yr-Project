import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../collections_screen/collections_screen.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../dynamic_links/firebase_dynamic.dart';
import '../follower_list_screen/follower_list_screen.dart';
import '../following_list_screen/following_list_screen.dart';
import '../friends_list_screen/friends_list_screen.dart';
import '../lol_store_screen/lol_store_screen.dart';
import '../message.dart';
import '../model/user_model.dart';
import '../my_zone_screen/my_zone_screen.dart';
import '../providers/info_providers.dart';
import '../refresh_indicator/refresh_widget.dart';
import '../shared_pref/first_time_login.dart';
import '../visitors_list_screen/visitors_list_screen.dart';
import '../wallet_screen/wallet_screen.dart';
import '../wealth_level_screen/wealth_level_screen.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  bool contain = false;
  bool like = false;
  late InfoProviders result;
  bool isLoading = true;
  bool isLoading02 = true;
  bool isLoading03 = true;
  UserBasicModel? currentUserData;
  Map<String, dynamic> followMap = {};
  bool isCoverImageEdit = false;
  bool isImageLoading = false;
  File? _imageFile;
  // String urlDownload = '';
  UploadTask? task;
  List<dynamic> friendsListUIds = [];
  List<dynamic> framesData = [];
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _ssController = ScreenshotController();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  @override
  void initState() {
    // getDynamicLink();
    FirebaseDynamicLinkService.initDynamicLinks(context);
    getProfileDataRes();
    super.initState();
  }

  String _linkMessage = '';

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _createDynamicLink(bool short, UserBasicModel userData) async {
    // setState(() {
    //   _isCreatingLink = true;
    // });

    // const String DynamicLink = 'https://thelolapp.page.link/lolProfile';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://theenlearn.page.link',
      // longDynamicLink: Uri.parse(
      //   'https://reactnativefirebase.page.link/?efr=0&ibi=io.invertase.testing&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Ftest-app%2Fhelloworld&ofl=https://ofl-example.com',
      // ),
      link: Uri.parse(
          'https://theenlearn.page.link/studentProfile?id=${userData.userId}'),
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
      _linkMessage = url.toString();
      // _isCreatingLink = false;
    });
  }

  Future getProfileDataRes() async {
    result = Provider.of<InfoProviders>(context, listen: false);
    currentUserData = result.curUserData;
    // result.callCurrentUserData().then((value) {
    //   currentUserData = value;
    //   urlDownload = currentUserData!.coverImage;
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    result
        .callCurrentUserFollowData(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      followMap = value;
      friendsListUIds.clear();
      final followingList = (followMap['following'] as List);
      final followerslist = (followMap['followers'] as List);
      for (int i = 0; i < followerslist.length; i++) {
        for (int j = 0; j < followingList.length; j++) {
          if ((followerslist[i] as String) == followingList[j].toString()) {
            friendsListUIds.add(followerslist[i]);
          }
        }
      }
      setState(() {
        isLoading02 = false;
      });
    });
    FirebaseFirestore.instance
        .collection('userFrames')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      framesData = value.data()!['framesAdd'];
      setState(() {
        isLoading03 = false;
      });
    });
  }

  _refreshState(
      String userId,
      String sName,
      String sDob,
      String sGender,
      String sImageUrl,
      String sCoverImage,
      String sAbout,
      String sAddress,
      String sStatus,
      int sFrontUid,
      int likesOnMe) {
    currentUserData = UserBasicModel(
      userId: userId,
      name: sName,
      dob: sDob,
      gender: sGender,
      imageUrl: sImageUrl,
      coverImage: sCoverImage,
      about: sAbout,
      address: sAddress,
      status: sStatus,
      frontUid: sFrontUid,
      likesOnMe: likesOnMe,
    );
    setState(() {});
  }

  Future<void> saveAndShare(Uint8List bytes) async {
    Directory? directory = await getApplicationDocumentsDirectory();
    final image = File("${directory.path}/screenshot.png");
    image.writeAsBytesSync(bytes);
    const text = 'Check out the profile I found on Enlearn app';
    await Share.shareFiles([image.path], text: _linkMessage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Screenshot(
        controller: _ssController,
        child: Scaffold(
          body: isLoading02
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : isLoading03
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : getBody(),
        ),
      ),
    );
  }

  Widget getBody() {
    return RefreshWidget(
      onRefresh: getProfileDataRes,
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.24,
                  width: size.width,
                  child: Stack(
                    children: [
                      //COVER IMAGE
                      Align(
                        alignment: Alignment.centerLeft,
                        child: currentUserData!.coverImage.trim().isEmpty
                            ? Image.asset(
                                ImageConstant.imgUnsplashyp4wgd,
                                width: getHorizontalSize(360.00),
                                fit: BoxFit.fill,
                              )
                            : Image.network(currentUserData!.coverImage,
                                fit: BoxFit.cover, width: double.infinity,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }),
                      ),
                      // contain?
                      //APPBAR
                      Container(
                        height: getVerticalSize(40),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.black90026,
                              spreadRadius: getHorizontalSize(2.00),
                              blurRadius: getHorizontalSize(2.00),
                              offset: const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(15.00),
                                ),
                                child: SizedBox(
                                    height: getVerticalSize(13.67),
                                    width: getHorizontalSize(18.64),
                                    child: const Icon(Icons.arrow_back,
                                        color: Colors.white)),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => EditProfile(
                                            currentUserData: currentUserData!,
                                            refreshFn: _refreshState,
                                          )));
                                  // setState(() {
                                  //   isCoverImageEdit = !isCoverImageEdit;
                                  // });
                                },
                                icon: const Icon(
                                  Icons.mode_edit_outlined,
                                  color: Colors.white,
                                  size: 18,
                                )),
                            IconButton(
                                onPressed: () async {
                                  final image = await _ssController.capture();
                                  await _createDynamicLink(
                                      false, currentUserData!);
                                  debugPrint("LINK GENERATED: $_linkMessage");
                                  saveAndShare(image!);
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 18,
                                )),
                            // Container(
                            //   height: getVerticalSize(18.00),
                            //   width: getHorizontalSize(57.57),
                            //   margin:
                            //       EdgeInsets.only(right: getHorizontalSize(15)),
                            //   child: SvgPicture.asset(
                            //     ImageConstant.imgFrame1357,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // :Container(
                      //     height:0,
                      // ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //PROFILE IMAGE
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: size.height * 0.06,
                                    left: getHorizontalSize(15)),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(100.00),
                                    ),
                                    child: Image.network(
                                      currentUserData!.imageUrl,
                                      height: getSize(80.00),
                                      width: getSize(80.00),
                                      fit: BoxFit.fill,
                                    )
                                    // Image.asset(
                                    //   ImageConstant.imgUnsplashkb41g,
                                    //   height: getSize(80.00),
                                    //   width: getSize(80.00),
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                              ),
                              framesData.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        (framesData[0] as Map<String, dynamic>)[
                                            'imageurl'],
                                        height: getVerticalSize(85.00),
                                        width: getHorizontalSize(85.04),
                                        fit: BoxFit.cover,
                                      ))
                                  : const SizedBox()
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: getHorizontalSize(18),
                                top: getVerticalSize(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //USER NAME
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentUserData!.name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: getFontSize(25),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 78,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.gray400,
                                        borderRadius: BorderRadius.circular(
                                          getHorizontalSize(16.00),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.gray600,
                                          width: getHorizontalSize(1.00),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorConstant.black90026,
                                            spreadRadius:
                                                getHorizontalSize(2.00),
                                            blurRadius: getHorizontalSize(2.00),
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: LikeButton(
                                        size: 30,
                                        likeCountPadding:
                                            EdgeInsets.only(left: 2, top: 0),
                                        circleColor: CircleColor(
                                            start: Colors.red.withOpacity(0.7),
                                            end: Colors.red.withOpacity(0.6)),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor:
                                              Colors.red.withOpacity(0.7),
                                          dotSecondaryColor:
                                              Colors.red.withOpacity(0.6),
                                        ),
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        padding:
                                            EdgeInsets.only(left: 5, top: 2),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            CupertinoIcons.heart_fill,
                                            color: isLiked
                                                ? Colors.red.withOpacity(0.7)
                                                : Colors.grey,
                                            size: 24,
                                          );
                                        },
                                        likeCount: 999,
                                        countBuilder: (count, isLiked, text) {
                                          var color = isLiked
                                              ? Colors.red.withOpacity(0.7)
                                              : Colors.grey;
                                          Widget result;
                                          if (count == 0) {
                                            result = Text(
                                              "0",
                                              style: TextStyle(color: color),
                                            );
                                          } else if (count! > 999) {
                                            double num = count / 1000;
                                            String d = num.toStringAsFixed(1);
                                            result = Text(
                                              d + "k",
                                              style: TextStyle(color: color),
                                            );
                                          } else {
                                            result = Text(
                                              text,
                                              style: TextStyle(color: color),
                                            );
                                          }
                                          return result;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    debugPrint("PRINTED");
                                    Clipboard.setData(ClipboardData(
                                            text: currentUserData!.frontUid
                                                .toString()))
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "User id is copied to clipboard")));
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: getVerticalSize(2.00),
                                    ),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'ID : ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: currentUserData!.frontUid
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(6.00),
                                          ),
                                          child: SizedBox(
                                            height: getVerticalSize(14.00),
                                            child: Icon(
                                              Icons.copy_outlined,
                                              color: Colors.white,
                                              size: getHorizontalSize(15),
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
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  child: GlassmorphicContainer(
                    borderRadius: 15,
                    width: size.width,
                    blur: 15,
                    alignment: Alignment.bottomCenter,
                    border: 2,
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
                    height: getVerticalSize(125),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const FriendsListScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(15.00),
                              top: getVerticalSize(72),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(6.00),
                                      right: getHorizontalSize(9.00),
                                    ),
                                    child: Text(
                                      friendsListUIds.length.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: getVerticalSize(4.51),
                                    ),
                                    child: Text(
                                      "Friends",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.gray601,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: getVerticalSize(27.65),
                          width: getHorizontalSize(1.78),
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(22.00),
                            top: getVerticalSize(80),
                            bottom: getVerticalSize(14.35),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.gray500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const FollowingListScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(22.00),
                              top: getVerticalSize(72),
                              bottom: getVerticalSize(10.49),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(11.00),
                                      right: getHorizontalSize(11.00),
                                    ),
                                    child: Text(
                                      (followMap['following'] as List)
                                          .length
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: getVerticalSize(4.51),
                                    ),
                                    child: Text(
                                      "Following",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.gray601,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: getVerticalSize(27.65),
                          width: getHorizontalSize(1.78),
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(22.00),
                            top: getVerticalSize(75),
                            bottom: getVerticalSize(14.35),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.gray500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => FollowerListScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(22.01),
                              top: getVerticalSize(72),
                              bottom: getVerticalSize(10.49),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(11.00),
                                      right: getHorizontalSize(11.00),
                                    ),
                                    child: Text(
                                      (followMap['followers'] as List)
                                          .length
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: getVerticalSize(4.51),
                                    ),
                                    child: Text(
                                      "Followers",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.gray601,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: getVerticalSize(27.65),
                          width: getHorizontalSize(1.78),
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(22.00),
                            top: getVerticalSize(size.height * 0.09),
                            bottom: getVerticalSize(14.35),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.gray500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const VisitorsScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(22.00),
                              top: getVerticalSize(72),
                              // right: getHorizontalSize(18.65),
                              bottom: getVerticalSize(10.49),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(7.00),
                                      right: getHorizontalSize(9.00),
                                    ),
                                    child: Text(
                                      (followMap['visitors'] as List)
                                          .length
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: getVerticalSize(4.51),
                                    ),
                                    child: Text(
                                      "Visitors",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.gray601,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
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
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: getVerticalSize(145),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.only(top: getVerticalSize(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const WalletScreen()));
                                    },
                                    child: Image.asset(
                                      "assets/images/img_group9010.png",
                                      width: getHorizontalSize(60),
                                      height: getVerticalSize(60),
                                    )),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  WealthLevelScreen()));
                                    },
                                    child: Image.asset(
                                      "assets/images/img_group9009.png",
                                      width: getHorizontalSize(60),
                                      height: getVerticalSize(60),
                                    )),
                                // GestureDetector(
                                //     onTap: () {
                                //       Navigator.pushReplacement(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (ctx) =>
                                //                   const LolStoreScreen()));
                                //     },
                                //     child: Image.asset(
                                //       "assets/images/img_group9008.png",
                                //       width: getHorizontalSize(60),
                                //       height: getVerticalSize(60),
                                //     )),
                                GestureDetector(
                                    onTap: () {
                                      //LOGOUT
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              title: const Text(
                                                'Do you want to logout?',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await setVisitingFlag(
                                                        // isLocDone: false,
                                                        isLoginDone: false,
                                                        isProfileDone: false,
                                                        // isQueAnsDone: false,
                                                        // isTermsCondGiven: false,
                                                      );
                                                      await _signOut();
                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      const MyAnimationScreen()),
                                                              (Route route) =>
                                                                  false);
                                                      setState(() {});
                                                    },
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.amber,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.amber,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    )),
                                              ],
                                            );
                                          });
                                    },
                                    child: Image.asset(
                                      "assets/images/img_group9013.png",
                                      width: getHorizontalSize(60),
                                      height: getVerticalSize(60),
                                    )),
                                GestureDetector(
                                  onTap: () async {
                                    final image = await _ssController.capture();
                                    await _createDynamicLink(
                                        false, currentUserData!);
                                    debugPrint("LINK GENERATED: $_linkMessage");
                                    saveAndShare(image!);
                                  },
                                  child: Image.asset(
                                    "assets/images/img_group9011.png",
                                    width: getHorizontalSize(60),
                                    height: getVerticalSize(60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: getVerticalSize(12)),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Image.asset(
                          //         "assets/images/img_group9013.png",
                          //         width: getHorizontalSize(60),
                          //         height: getVerticalSize(60),
                          //       ),
                          //       Image.asset(
                          //         "assets/images/img_group9014.png",
                          //         width: getHorizontalSize(60),
                          //         height: getVerticalSize(60),
                          //       ),
                          //       Image.asset(
                          //         "assets/images/img_group9015.png",
                          //         width: getHorizontalSize(60),
                          //         height: getVerticalSize(60),
                          //       ),
                          //       // GestureDetector(
                          //       //   onTap: () async {
                          //       //     final image = await _ssController.capture();
                          //       //     await _createDynamicLink(
                          //       //         false, currentUserData!);
                          //       //     debugPrint("LINK GENERATED: $_linkMessage");
                          //       //     saveAndShare(image!);
                          //       //   },
                          //       //   child: Image.asset(
                          //       //     "assets/images/img_group9011.png",
                          //       //     width: getHorizontalSize(60),
                          //       //     height: getVerticalSize(60),
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    )),
                GlassmorphicContainer(
                  margin: EdgeInsets.only(
                    top: getVerticalSize(
                      10.00,
                    ),
                  ),
                  height: getVerticalSize(360),
                  borderRadius: 15,
                  width: size.width,
                  blur: 15,
                  alignment: Alignment.topLeft,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(28.00),
                            top: getVerticalSize(16),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'About me',
                                  style: TextStyle(
                                    color: ColorConstant.gray800,
                                    fontSize: getFontSize(22),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(0.50),
                        width: size.width,
                        margin: EdgeInsets.only(
                          top: getVerticalSize(8.31),
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.black90026,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: getVerticalSize(7.00),
                            bottom: getVerticalSize(15.00),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(23.00),
                                  right: getHorizontalSize(23.00),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: getVerticalSize(12.00),
                                            left: getHorizontalSize(5),
                                            bottom: getVerticalSize(6.00),
                                          ),
                                          child: SizedBox(
                                            height: getSize(15.00),
                                            width: getSize(15.00),
                                            child: SvgPicture.asset(
                                              ImageConstant.imgGroup1283,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 10,
                                                  left:
                                                      getHorizontalSize(18.09)),
                                              child: Text(
                                                currentUserData!
                                                        .about.isNotEmpty
                                                    ? currentUserData!.about
                                                    : "User Bio Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without",
                                                style: TextStyle(
                                                  color: ColorConstant.gray601,
                                                  fontSize: getFontSize(14),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.29,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: getVerticalSize(7.00),
                                              left: getHorizontalSize(5)),
                                          child: SizedBox(
                                            height: getSize(15.00),
                                            width: getSize(15.00),
                                            child: SvgPicture.asset(
                                              ImageConstant.imgGroup1284,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: getHorizontalSize(17.00),
                                              bottom: 10),
                                          child: Text(
                                            currentUserData!.userId
                                                .substring(0, 9),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: ColorConstant.gray601,
                                              fontSize: getFontSize(14),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 1.29,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        // top: getVerticalSize(1.00),
                                        right: getHorizontalSize(10.00),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              // top: getVerticalSize(2.00),
                                              bottom: getVerticalSize(10.00),
                                            ),
                                            child: SizedBox(
                                              height: getVerticalSize(15.00),
                                              width: getHorizontalSize(12.91),
                                              child: const Icon(Icons.home,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left:
                                                      getHorizontalSize(18.09)),
                                              child: Text(
                                                currentUserData!
                                                        .address.isNotEmpty
                                                    ? currentUserData!.address
                                                    : 'Home address',
                                                style: TextStyle(
                                                  color: ColorConstant.gray601,
                                                  fontSize: getFontSize(14),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.29,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: getVerticalSize(1.00),
                                        right: getHorizontalSize(10.00),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: getVerticalSize(2.00),
                                                bottom: getVerticalSize(1.00),
                                                left: getHorizontalSize(2)),
                                            child: SizedBox(
                                                height: getVerticalSize(22.00),
                                                width: getHorizontalSize(13.06),
                                                child: Icon(Icons.cake,
                                                    size: getHorizontalSize(17),
                                                    color: Colors.black54)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(17.94),
                                            ),
                                            child: Text(
                                              currentUserData!.dob
                                                  .substring(0, 10),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: ColorConstant.gray601,
                                                fontSize: getFontSize(14),
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
                                          top: getVerticalSize(15.00),
                                          right: getHorizontalSize(10.00),
                                          bottom: getVerticalSize(40)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: getVerticalSize(2.00),
                                              left: getHorizontalSize(3),
                                            ),
                                            child: SizedBox(
                                                height: getVerticalSize(14.00),
                                                width: getHorizontalSize(10.98),
                                                child: const Icon(
                                                    Icons.transgender_sharp,
                                                    color: Colors.black45,
                                                    size: 20)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: getHorizontalSize(
                                                18.02,
                                              ),
                                            ),
                                            child: Text(
                                              currentUserData!.gender,
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
              ],
            ),
          ),
          // Container(
          //   margin:
          //   EdgeInsets.only(
          //     top:size.height*0.18,
          //     left:size.width*0.81,
          //   ),
          //   height:26,
          //   alignment: Alignment.center,
          //   decoration:
          //   BoxDecoration(
          //     color:
          //     ColorConstant.gray400,
          //     borderRadius:
          //     BorderRadius.circular(
          //       getHorizontalSize(
          //         16.00,
          //       ),
          //     ),
          //     border:
          //     Border.all(
          //       color:
          //       ColorConstant.gray600,
          //       width:
          //       getHorizontalSize(
          //         1.00,
          //       ),
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: ColorConstant.black90026,
          //         spreadRadius: getHorizontalSize(
          //           2.00,
          //         ),
          //         blurRadius: getHorizontalSize(
          //           2.00,
          //         ),
          //         offset: const Offset(
          //           0,
          //           4,
          //         ),
          //       ),
          //     ],
          //   ),
          //   child:
          //   LikeButton(
          //     size:getHorizontalSize(55),
          //     circleColor:
          //     CircleColor(start: Colors.red.withOpacity(0.7), end: Colors.red.withOpacity(0.6)),
          //     bubblesColor: BubblesColor(
          //       dotPrimaryColor: Colors.red.withOpacity(0.7),
          //       dotSecondaryColor:Colors.red.withOpacity(0.6),
          //     ),
          //     likeBuilder: (bool isLiked) {
          //       return Row(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Text(
          //             "12.8k",
          //             overflow: TextOverflow.ellipsis,
          //             textAlign: TextAlign.left,
          //             style: TextStyle(
          //               color: isLiked?Colors.red.withOpacity(0.7):ColorConstant.gray600,
          //               fontSize: getFontSize(
          //                 15,
          //               ),
          //               fontFamily: 'Roboto',
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //           Padding(
          //             padding:EdgeInsets.only(left:4),
          //             child: Icon(
          //               CupertinoIcons.heart_fill,
          //               color: isLiked ? Colors.red.withOpacity(0.7) : Colors.grey,
          //               size: 17,
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // ),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const Message()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: getHorizontalSize(10)),
                        child: Image.asset(
                          "assets/images/img_group9007.png",
                          width: getHorizontalSize(60),
                          height: getVerticalSize(60),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: getHorizontalSize(10)),
                      child: Image.asset(
                        "assets/images/img_group9003.png",
                        width: getHorizontalSize(55),
                        height: getVerticalSize(55),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
