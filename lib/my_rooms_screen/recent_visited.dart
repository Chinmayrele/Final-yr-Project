import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/my_rooms_screen/widget/recent_visited_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../refresh_indicator/refresh_widget.dart';

class RecentVisited extends StatefulWidget {
  const RecentVisited({Key? key}) : super(key: key);

  @override
  State<RecentVisited> createState() => _RecentVisitedState();
}

class _RecentVisitedState extends State<RecentVisited> {
  List dates = [];
  bool isLoading = true;
  @override
  void initState() {
    getRecentVisited();
    super.initState();
  }

  Future<void> getRecentVisited() async {
    FirebaseFirestore.instance
        .collection('recentVisited')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('visited')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        dates.add(element.id);
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.pink,
            ),
          )
        : RefreshWidget(
            onRefresh: getRecentVisited,
            child: Stack(
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Image.asset(
                //     ImageConstant.imgUnsplash8uzpyn,
                //     height: getVerticalSize(
                //       776.00
                //     ),
                //     width: getHorizontalSize(
                //       360.00
                //     ),
                //     fit: BoxFit.fill,
                //   ),
                // ),
                ListView.builder(
                  itemCount: dates.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    dates.sort(
                        ((a, b) => (b as String).compareTo(a.toString())));
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Text(
                            // CHECKING IF DATE EQUAL TO TODAYS DATE
                            dates[index].toString().substring(5, 7) ==
                                        DateTime.now()
                                            .toString()
                                            .split(" ")[0]
                                            .substring(5, 7) &&
                                    dates[index].toString().substring(8, 10) ==
                                        DateTime.now()
                                            .toString()
                                            .split(" ")[0]
                                            .substring(8, 10) &&
                                    dates[index].toString().substring(0, 4) ==
                                        DateTime.now()
                                            .toString()
                                            .split(" ")[0]
                                            .substring(0, 4)
                                ? "Today"
                                // CHECKING IF DATE IS SAME AS YESTERDAYS
                                : dates[index].toString().substring(5, 7) ==
                                            DateTime.now()
                                                .toString()
                                                .split(" ")[0]
                                                .substring(5, 7) &&
                                        dates[index]
                                                .toString()
                                                .substring(8, 10) ==
                                            (int.parse(DateTime.now().toString().split(" ")[0].substring(8, 10)) -
                                                    1)
                                                .toString() &&
                                        dates[index].toString().substring(0, 4) ==
                                            DateTime.now()
                                                .toString()
                                                .split(" ")[0]
                                                .substring(0, 4)
                                    ? "Yesterday"
                                    // ELSE JUST WRITE THE DATE AS IT IS
                                    : dates[index],
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('recentVisited')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('visited')
                              .doc(dates[index])
                              .snapshots(),
                          builder: (ctx, snapShots) {
                            if (!snapShots.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.pink,
                                ),
                              );
                            } else {
                              final recentDocs = snapShots.data!.data();
                              final listData = (recentDocs
                                      as Map<String, dynamic>)['recentList']
                                  as List;
                              listData.sort(((a, b) =>
                                  (b['createdAt'] as String)
                                      .compareTo(a['createdAt'] as String)));
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    (recentDocs['recentList'] as List).length,
                                itemBuilder: (context, index) {
                                  return RecentVisitedItem(
                                      recentDoc: listData[index]);
                                },
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
  }
}
