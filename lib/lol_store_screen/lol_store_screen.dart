import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../collections_screen/collections_screen.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../lol_store_screen/widgets/lol_store_item_widget.dart';
import 'package:flutter/material.dart';

import '../refresh_indicator/refresh_widget.dart';
import '../usernames/new.dart';
import '../wallet_screen/wallet_screen.dart';

class LolStoreScreen extends StatefulWidget {
  const LolStoreScreen({Key? key}) : super(key: key);

  @override
  State<LolStoreScreen> createState() => _LolStoreScreenState();
}

class _LolStoreScreenState extends State<LolStoreScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading01 = true;
  bool isLoading02 = true;
  late Map<String, dynamic> dataUserDR = {};
  late List<Object?> lolStoreData;
  int selectedDiamonds = 0;
  int selectedValidity = 0;
  String selectedImageUrl = '';
  String selectedFrameName = '';
  bool selectedSelection = false;
  bool isPurchasing = false;
  List<Map<String, dynamic>> frames = [];
  @override
  void initState() {
    getLolStoreData();
    _tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  int _selectedItem = -1;
  bool _isSelected = false;
  int sDiamonds = 0;
  int sValidity = 0;
  String sImageUrl = '';
  String sFrameName = '';

  Future getLolStoreData() async {
    FirebaseDatabase.instance.ref("LolStore").get().then((value) {
      lolStoreData = value.value as List<Object?>;
      setState(() {
        isLoading01 = false;
      });
    });
    FirebaseFirestore.instance
        .collection('UsersDiamond')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      dataUserDR = value.data() as Map<String, dynamic>;
      setState(() {
        isLoading02 = false;
      });
    });
  }

  late TabController _tabController;

  void _submitFN(int diamonds, int validity, String imageUrl, String frameName,
      bool selected) {
    selectedDiamonds = diamonds;
    selectedValidity = validity;
    selectedImageUrl = imageUrl;
    selectedFrameName = frameName;
    selectedSelection = selected;
    setState(() {});
  }

  showingDialogBox(String headText, String text, bool isPurchse) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // buttonPadding: const EdgeInsets.only(right: 10),
            actionsAlignment: MainAxisAlignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            titlePadding: const EdgeInsets.only(left: 20, top: 10),
            title: Text(
              headText,
              style: TextStyle(
                color: ColorConstant.deepPurple900,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Text(text),
            actions: [
              isPurchse
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const WalletScreen()));
                      },
                      child: const Text('Buy Diamonds',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      style: ElevatedButton.styleFrom(
                          primary: ColorConstant.deepPurple900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                  : Container(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(!isPurchse ? 'Yay' : 'Cancel',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: !isPurchse
                        ? ColorConstant.deepPurple9000c
                        : ColorConstant.blue90066),
              ),
            ],

            // ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const Profile()));
          return Future(() => false);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: isLoading01
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  )
                : isLoading02
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.pink,
                        ),
                      )
                    : RefreshWidget(
                        onRefresh: getLolStoreData,
                        child: Stack(
                          alignment: Alignment.topLeft,
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
                                    height: size.height * 0.115,
                                    borderRadius: 15,
                                    width: getHorizontalSize(360),
                                    blur: 15,
                                    alignment: Alignment.center,
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
                                        Colors.white30.withOpacity(0.2),
                                        Colors.white30.withOpacity(0.2),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                              16.00,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_back,
                                                  size: 25,
                                                ),
                                                onPressed: () async {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              const Profile()));
                                                  return Future(() => false);
                                                },
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(
                                                    15,
                                                  ),
                                                ),
                                                child: GradientText(
                                                  "Lol Store",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .deepPurple900,
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
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             const CollectionsScreen()));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    top: getVerticalSize(
                                                      4.00,
                                                    ),
                                                    right: 15,
                                                    bottom: getVerticalSize(
                                                      4.00,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: getVerticalSize(
                                                            2.00,
                                                          ),
                                                          bottom:
                                                              getVerticalSize(
                                                            3.00,
                                                          ),
                                                        ),
                                                        child: Image.asset(
                                                          ImageConstant
                                                              .imgGroup613,
                                                          height:
                                                              getVerticalSize(
                                                            13.00,
                                                          ),
                                                          width:
                                                              getHorizontalSize(
                                                            16.95,
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left:
                                                              getHorizontalSize(
                                                            6.05,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          dataUserDR['diamond']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: ColorConstant
                                                                .gray800,
                                                            fontSize:
                                                                getFontSize(
                                                              15,
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
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: getVerticalSize(15),
                                              left: getHorizontalSize(20)),
                                          width: getHorizontalSize(360),
                                          child: TabBar(
                                            isScrollable: true,
                                            indicator: ShapeDecoration(
                                                shape:
                                                    const RoundedRectangleBorder(),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      ColorConstant.textStart,
                                                      ColorConstant.textEnd
                                                    ])),
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            controller: _tabController,
                                            labelPadding: const EdgeInsets.only(
                                                bottom: 2),
                                            indicatorWeight: 1.0,
                                            unselectedLabelStyle: TextStyle(
                                              color: ColorConstant.gray800,
                                              fontSize: getFontSize(14),
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
                                              fontSize: getFontSize(15),
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
                                                    left:
                                                        getHorizontalSize(15)),
                                                child: const Text(
                                                  "Avatar Frames",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        getHorizontalSize(15)),
                                                child: const Text(
                                                  "Entrance Effects",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        getHorizontalSize(15)),
                                                child: const Text(
                                                  "Room BG Images",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        getHorizontalSize(15)),
                                                child: const Text(
                                                  "Avatar Frames",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          Stack(
                                            children: [
                                              GridView.builder(
                                                // GRIDVIEW LIST DATA/////////////////////////////////////////////////////////////////////////////////////////////
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1.1,
                                                  crossAxisSpacing: 0,
                                                  mainAxisSpacing: 5,
                                                ),
                                                shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: lolStoreData.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _isSelected =
                                                            !_isSelected;
                                                        _selectedItem = index;
                                                        sDiamonds =
                                                            (lolStoreData[index]
                                                                    as Map<
                                                                        dynamic,
                                                                        dynamic>)[
                                                                'diamonds'];
                                                        sValidity = (lolStoreData[
                                                                    index]
                                                                as Map<dynamic,
                                                                    dynamic>)[
                                                            'validity'] as int;
                                                        sImageUrl =
                                                            (lolStoreData[index]
                                                                    as Map<
                                                                        dynamic,
                                                                        dynamic>)[
                                                                'imageUrl'];
                                                        sFrameName =
                                                            (lolStoreData[index]
                                                                    as Map<
                                                                        dynamic,
                                                                        dynamic>)[
                                                                'frameName'];
                                                        _submitFN(
                                                            sDiamonds,
                                                            sValidity,
                                                            sImageUrl,
                                                            sFrameName,
                                                            _isSelected);
                                                      });
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: _selectedItem ==
                                                                      index &&
                                                                  _isSelected
                                                              ? Border.all(
                                                                  color: ColorConstant
                                                                      .deepPurple900,
                                                                  width: 2)
                                                              : Border.all(
                                                                  color: Colors
                                                                      .white10
                                                                      .withOpacity(
                                                                          0.2),
                                                                  width: 0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child:
                                                            GlassmorphicContainer(
                                                          borderRadius: 15,
                                                          height:
                                                              getVerticalSize(
                                                                  185),
                                                          blur: 15,
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          border: 2,
                                                          linearGradient:
                                                              LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                  colors: [
                                                                const Color(
                                                                        0xFFffffff)
                                                                    .withOpacity(
                                                                        0.2),
                                                                const Color(
                                                                        0xFFFFFFFF)
                                                                    .withOpacity(
                                                                        0.2),
                                                              ],
                                                                  stops: const [
                                                                0.1,
                                                                1,
                                                              ]),
                                                          borderGradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              Colors.white10
                                                                  .withOpacity(
                                                                      0.2),
                                                              Colors.white10
                                                                  .withOpacity(
                                                                      0.2),
                                                            ],
                                                          ),
                                                          width:
                                                              getHorizontalSize(
                                                                  148),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      getVerticalSize(
                                                                          109.00),
                                                                  width:
                                                                      getHorizontalSize(
                                                                          153.00),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft:
                                                                          Radius
                                                                              .circular(
                                                                        getHorizontalSize(
                                                                            8.00),
                                                                      ),
                                                                      topRight:
                                                                          Radius
                                                                              .circular(
                                                                        getHorizontalSize(
                                                                            8.00),
                                                                      ),
                                                                      bottomLeft:
                                                                          Radius
                                                                              .circular(
                                                                        getHorizontalSize(
                                                                            0.00),
                                                                      ),
                                                                      bottomRight:
                                                                          Radius
                                                                              .circular(
                                                                        getHorizontalSize(
                                                                            0.00),
                                                                      ),
                                                                    ),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: const Alignment(
                                                                          -0.001697166058858155,
                                                                          0.5074751480283091),
                                                                      end: const Alignment(
                                                                          0.9983028339411415,
                                                                          0.5074752102704458),
                                                                      colors: [
                                                                        ColorConstant
                                                                            .deepPurple90019,
                                                                        ColorConstant
                                                                            .purple50019,
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: Card(
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    elevation:
                                                                        0,
                                                                    margin: const EdgeInsets
                                                                        .all(0),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                          getHorizontalSize(
                                                                              8.00),
                                                                        ),
                                                                        topRight:
                                                                            Radius.circular(
                                                                          getHorizontalSize(
                                                                              8.00),
                                                                        ),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                          getHorizontalSize(
                                                                              0.00),
                                                                        ),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                          getHorizontalSize(
                                                                              0.00),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: getHorizontalSize(4.00),
                                                                              top: getVerticalSize(0.00),
                                                                              right: getHorizontalSize(4.00),
                                                                              bottom: getVerticalSize(0.00),
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              (lolStoreData[index] as Map<dynamic, dynamic>)['imageUrl'],
                                                                              height: getSize(105.00),
                                                                              width: getSize(105.00),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            // Image.asset(
                                                                            //   ImageConstant.imgFramebridedan,
                                                                            //   height: getSize(105.00),
                                                                            //   width: getSize(105.00),
                                                                            //   fit: BoxFit.fill,
                                                                            // ),
                                                                          ),
                                                                        ),
                                                                      ],
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
                                                                    left: getHorizontalSize(
                                                                        17.00),
                                                                    top: getVerticalSize(
                                                                        5.00),
                                                                    // right: getHorizontalSize(
                                                                    //     10.00),
                                                                  ),
                                                                  child: Text(
                                                                    (lolStoreData[
                                                                            index]
                                                                        as Map<
                                                                            dynamic,
                                                                            dynamic>)['frameName'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorConstant
                                                                          .gray800,
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
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: getHorizontalSize(
                                                                        30.0),
                                                                    top: getVerticalSize(
                                                                        5.0),
                                                                    // right:
                                                                    //     getHorizontalSize(
                                                                    //         10.0),
                                                                    bottom:
                                                                        getVerticalSize(
                                                                            8.0),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: getVerticalSize(
                                                                              0.00),
                                                                          bottom:
                                                                              getVerticalSize(
                                                                            0.00,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              getVerticalSize(7.00),
                                                                          width:
                                                                              getHorizontalSize(10.00),
                                                                          // child: SvgPicture.asset(
                                                                          //   ImageConstant.imgUnion2,
                                                                          //   fit: BoxFit.fill,
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left:
                                                                              getHorizontalSize(4.00),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          (lolStoreData[index] as Map<dynamic, dynamic>)['validity'] == -1
                                                                              ? (lolStoreData[index] as Map<dynamic, dynamic>)['diamonds'].toString() + "/ Permanent"
                                                                              : (lolStoreData[index] as Map<dynamic, dynamic>)['diamonds'].toString() + "/" + (lolStoreData[index] as Map<dynamic, dynamic>)['validity'].toString() + " Day",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorConstant.gray800,
                                                                            fontSize:
                                                                                getFontSize(10),
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontWeight:
                                                                                FontWeight.w400,
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
                                                    ),
                                                  );
                                                  // LolStoreItemWidget(
                                                  //   storeData:
                                                  //       lolStoreData[index],
                                                  //   userData: dataUserDR,
                                                  //   index: index,
                                                  //   submitStoreFn: _submitFN,
                                                  // );
                                                },
                                              ),
                                              selectedFrameName
                                                          .trim()
                                                          .isNotEmpty &&
                                                      selectedImageUrl
                                                          .trim()
                                                          .isNotEmpty &&
                                                      selectedSelection
                                                  ? GlassmorphicContainer(
                                                      height: size.height * 0.1,
                                                      borderRadius: 15,
                                                      margin: EdgeInsets.only(
                                                        top: getVerticalSize(
                                                            612),
                                                      ),
                                                      width: size.width,
                                                      blur: 15,
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      border: 2,
                                                      linearGradient:
                                                          LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: [
                                                            const Color(
                                                                    0xFFffffff)
                                                                .withOpacity(
                                                                    0.2),
                                                            const Color(
                                                                    0xFFFFFFFF)
                                                                .withOpacity(
                                                                    0.2),
                                                          ],
                                                              stops: const [
                                                            0.1,
                                                            1,
                                                          ]),
                                                      borderGradient:
                                                          LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          Colors.white10
                                                              .withOpacity(0.2),
                                                          Colors.white10
                                                              .withOpacity(0.2),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        getHorizontalSize(
                                                                      21.00,
                                                                    ),
                                                                    top: 10),
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
                                                                Text(
                                                                  selectedFrameName,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .gray800,
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
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top:
                                                                        getVerticalSize(
                                                                      4.00,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text: selectedValidity == -1
                                                                              ? "Validity : Permanent After purchase"
                                                                              : "Validity : " + selectedValidity.toString() + " After Purchase",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorConstant.gray800,
                                                                            fontSize:
                                                                                getFontSize(
                                                                              10,
                                                                            ),
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              getVerticalSize(
                                                                            4.00,
                                                                          ),
                                                                          bottom:
                                                                              getVerticalSize(5)),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top:
                                                                              getVerticalSize(
                                                                            2.00,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              getVerticalSize(
                                                                            9.00,
                                                                          ),
                                                                          width:
                                                                              getHorizontalSize(
                                                                            13.00,
                                                                          ),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/diamonf.png",
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left:
                                                                              getHorizontalSize(
                                                                            5.00,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          selectedDiamonds
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorConstant.gray800,
                                                                            fontSize:
                                                                                getFontSize(
                                                                              12,
                                                                            ),
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              if ((dataUserDR['diamond']
                                                                          as int) -
                                                                      selectedDiamonds >
                                                                  0) {
                                                                setState(() {
                                                                  isPurchasing =
                                                                      true;
                                                                });
                                                                frames.clear();
                                                                debugPrint(
                                                                    "IF CONDITION ENTERED");
                                                                Map<String,
                                                                        dynamic>
                                                                    mp = {
                                                                  "diamonds":
                                                                      selectedDiamonds,
                                                                  "frameName":
                                                                      selectedFrameName,
                                                                  "validity":
                                                                      selectedValidity,
                                                                  "imageurl":
                                                                      selectedImageUrl,
                                                                  "category":
                                                                      "All"
                                                                };
                                                                frames.add(mp);
                                                                dataUserDR[
                                                                    'diamond'] = dataUserDR[
                                                                        'diamond'] -
                                                                    selectedDiamonds;
                                                                // });
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'UsersDiamond')
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    .update({
                                                                  "diamond":
                                                                      (dataUserDR[
                                                                          'diamond']),
                                                                });
                                                                final expense =
                                                                    {
                                                                  "text":
                                                                      "Bought a frame from store",
                                                                  "createdAt":
                                                                      DateTime
                                                                          .now(),
                                                                  "quantity": 1,
                                                                  "diamond":
                                                                      selectedDiamonds,
                                                                };
                                                                final list = [];
                                                                list.add(
                                                                    expense);
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'userFrames')
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    .update({
                                                                  "framesAdd":
                                                                      FieldValue
                                                                          .arrayUnion(
                                                                              frames)
                                                                });
                                                                final docExists = await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'incomeExpense')
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                    .collection(
                                                                        'expense')
                                                                    .doc(
                                                                        'expenseCollection')
                                                                    .get();
                                                                if (docExists
                                                                    .exists) {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'incomeExpense')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .collection(
                                                                          'expense')
                                                                      .doc(
                                                                          'expenseCollection')
                                                                      .update({
                                                                    "expenseList":
                                                                        FieldValue.arrayUnion(
                                                                            list),
                                                                  });
                                                                } else {
                                                                  await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'incomeExpense')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                      .collection(
                                                                          'expense')
                                                                      .doc(
                                                                          'expenseCollection')
                                                                      .set({
                                                                    "expenseList":
                                                                        FieldValue.arrayUnion(
                                                                            list),
                                                                  });
                                                                }
                                                                setState(() {
                                                                  isPurchasing =
                                                                      false;
                                                                });
                                                                showingDialogBox(
                                                                    'New Frame',
                                                                    'You have bought a new frame',
                                                                    false);
                                                              } else {
                                                                debugPrint(
                                                                    "ELSE CONDITION ENTERED");
                                                                showingDialogBox(
                                                                    "Purchase Diamonds!",
                                                                    'Oopss!!! Looks like you don\'t have enough diamonds',
                                                                    true);
                                                                debugPrint(
                                                                    "ELSE COND END");
                                                              }
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right:
                                                                    getHorizontalSize(
                                                                        20.00),
                                                                top:
                                                                    getVerticalSize(
                                                                        20.00),
                                                              ),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                height:
                                                                    getVerticalSize(
                                                                        24.00),
                                                                width:
                                                                    getHorizontalSize(
                                                                        84.00),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    getHorizontalSize(
                                                                        10.00),
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
                                                                  "Purchase",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .whiteA700,
                                                                    fontSize:
                                                                        getFontSize(
                                                                      14,
                                                                    ),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Container(),
                                          Container(),
                                          Container(),
                                          Container(),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
