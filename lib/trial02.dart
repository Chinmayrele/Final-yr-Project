import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tttraaail extends StatefulWidget {
  const Tttraaail({super.key});

  @override
  State<Tttraaail> createState() => _TttraaailState();
}

class _TttraaailState extends State<Tttraaail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text("SUBMIT"),
        onPressed: () async {
          await FirebaseDatabase.instance.ref('RubyPanel').set([
            {"diamond": 25, "ruby": 11},
            {"diamond": 35, "ruby": 11},
            {"diamond": 45, "ruby": 11},
            {"diamond": 55, "ruby": 11},
            {"diamond": 65, "ruby": 11},
            {"diamond": 75, "ruby": 11},
            {"diamond": 85, "ruby": 11},
            {"diamond": 95, "ruby": 11},
            {"diamond": 100, "ruby": 11},
          ]);
          // await FirebaseDatabase.instance.ref('DiamondPanel').set([
          //   {"normal": 25, "offer": 11},
          //   {"normal": 35, "offer": 11},
          //   {"normal": 45, "offer": 11},
          //   {"normal": 55, "offer": 11},
          //   {"normal": 65, "offer": 11},
          //   {"normal": 75, "offer": 11},
          // ]);
        },
      )),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:lol_app_infi/model/user_model.dart';
// import 'package:lol_app_infi/providers/info_providers.dart';
// import 'package:lol_app_infi/trending_screen/widgets/trending_item_widget.dart';
// import 'package:provider/provider.dart';

// import '../core/utils/math_utils.dart';

// class TrendingScreenTrial extends HookWidget {
//   TrendingScreenTrial({Key? key}) : super(key: key);

//   UserBasicModel? curUerData;
//   bool isLoading = true;
//   // @override
//   // void initState() {
//   //   debugPrint("INIT STATE OF TRENDING SCREEN CALLED!!!");
//   //   // WidgetsBinding.instance.addObserver(this);
//   //   final result = Provider.of<InfoProviders>(context, listen: false);
//   //   result.callCurrentUserData().then((value) {
//   //     debugPrint("OR HERE");
//   //     curUerData = value;
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   });
//   //   setStatus("Online");
//   //   super.initState();
//   // }

//   Future<void> setStatus(String status) async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .update({
//       "status": status,
//     });
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.detached) {
//   //     // OFFLINE
//   //     setStatus("Offline");
//   //   } else {
//   //     //ONLINE
//   //     setStatus("Online");
//   //   }
//   //   super.didChangeAppLifecycleState(state);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     useEffect(() {
//       final result = Provider.of<InfoProviders>(context, listen: false);
//       result.callCurrentUserData().then((value) {
//         debugPrint("OR HERE");
//         curUerData = value;
//         // useState(() {
//         // isLoading = false;

//         // });
//         // setState(() {
//         // });
//       });
//     }, const []);
//     return
//         // isLoading
//         //     ? const Center(
//         //         child: CircularProgressIndicator(color: Colors.pink),
//         //       )
//         Container(
//       margin: EdgeInsets.only(
//         top: 15,
//         left: getHorizontalSize(13.00),
//         right: getHorizontalSize(13.00),
//       ),
//       child: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection('hostRoomData').snapshots(),
//         builder: (ctx, snapShots) {
//           if (!snapShots.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.black,
//               ),
//             );
//           } else {
//             final trendData = snapShots.data!.docs;
//             trendData.sort(((a, b) => (b['roomCharisma'] as int)
//                 .compareTo((a['roomCharisma'] as int))));
//             trendData.removeWhere(
//                 (element) => (element['roomId'] as String).isEmpty);
//             return GridView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 mainAxisExtent: getVerticalSize(181.00),
//                 crossAxisCount: 2,
//                 mainAxisSpacing: getHorizontalSize(9.00),
//                 crossAxisSpacing: getHorizontalSize(8.00),
//               ),
//               physics: const BouncingScrollPhysics(),
//               itemCount: trendData.length,
//               itemBuilder: (context, index) {
//                 return (trendData[index]['roomId'] as String).isEmpty
//                     ? const SizedBox()
//                     : TrendingItemWidget(
//                         curUserData: curUerData!,
//                         trendingData: trendData[index],
//                         index: index,
//                       );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
