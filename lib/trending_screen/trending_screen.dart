import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/trending_screen/widgets/trending_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/math_utils.dart';
import '../model/user_model.dart';
import '../providers/info_providers.dart';
import '../service/zego_room_manager.dart';
import '../util/secret_reader.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with WidgetsBindingObserver {
  UserBasicModel? curUerData;
  bool isLoading = true;
  @override
  void initState() {
    debugPrint("INIT STATE OF TRENDING SCREEN CALLED!!!");
    WidgetsBinding.instance.addObserver(this);
    SecretReader.instance.loadKeyCenterData().then((_) {
      // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
      ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
          SecretReader.instance.serverSecret, (_) => null);
    });
    final result = Provider.of<InfoProviders>(context, listen: false);
    result.callCurrentUserData().then((value) {
      debugPrint("OR HERE");
      curUerData = value;
      setState(() {
        isLoading = false;
      });
    });
    setStatus("Online");
    super.initState();
  }

  Future<void> setStatus(String status) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //ONLINE
      setStatus("Online");
    } else {
      // OFFLINE
      setStatus("Offline");
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(color: Colors.pink),
          )
        : Container(
            margin: EdgeInsets.only(
              top: 15,
              left: getHorizontalSize(13.00),
              right: getHorizontalSize(13.00),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('hostRoomData')
                  .snapshots(),
              builder: (ctx, snapShots) {
                if (!snapShots.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  final trendData = snapShots.data!.docs;
                  trendData.sort(((a, b) => (b['roomCharisma'] as int)
                      .compareTo((a['roomCharisma'] as int))));
                  trendData.removeWhere(
                      (element) => (element['roomId'] as String).isEmpty);
                  return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: getVerticalSize(181.00),
                      crossAxisCount: 2,
                      mainAxisSpacing: getHorizontalSize(9.00),
                      crossAxisSpacing: getHorizontalSize(8.00),
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: trendData.length,
                    itemBuilder: (context, index) {
                      return (trendData[index]['roomId'] as String).isEmpty
                          ? const SizedBox()
                          : TrendingItemWidget(
                              curUserData: curUerData!,
                              trendingData: trendData[index],
                              index: index,
                            );
                    },
                  );
                }
              },
            ),
          );
  }
}
