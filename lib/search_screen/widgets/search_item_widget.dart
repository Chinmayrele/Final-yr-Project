import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../model/user_model.dart';
import '../../usernames/newuser.dart';

// ignore: must_be_immutable
class SearchItemWidget extends StatefulWidget {
  const SearchItemWidget({
    Key? key,
    required this.userDataDocs,
    required this.index,
    required this.followingList,
    required this.refreshFn,
  }) : super(key: key);
  final QueryDocumentSnapshot<Object?> userDataDocs;
  final int index;
  final List<dynamic> followingList;
  final void Function() refreshFn;

  @override
  State<SearchItemWidget> createState() => _SearchItemWidgetState();
}

class _SearchItemWidgetState extends State<SearchItemWidget> {
  List<dynamic> following = [];
  List<dynamic> followers = [];
  List<dynamic> removeFollowers = [];
  List<dynamic> removeFollowing = [];
  bool isFollow = false;
  int onTapCount = 0;
  // List<dynamic> followMe = [];
  @override
  Widget build(BuildContext context) {
    // List<dynamic> followBList = widget.followingList;
    return InkWell(
      onTap: () {
        var userDataModel = UserBasicModel(
          userId: widget.userDataDocs['userId'],
          name: widget.userDataDocs['name'],
          dob: widget.userDataDocs['dateBirth'],
          gender: widget.userDataDocs['gender'],
          imageUrl: widget.userDataDocs['imageUrl'],
          coverImage: widget.userDataDocs['coverImage'],
          about: widget.userDataDocs['about'],
          address: widget.userDataDocs['address'],
          status: widget.userDataDocs['status'],
          frontUid: widget.userDataDocs['frontUid'],
          likesOnMe: widget.userDataDocs['likesOnMe'],
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => OtherUser(otherUserData: userDataModel)));
      },
      child: GlassmorphicContainer(
        margin: EdgeInsets.only(
          top: getVerticalSize(
            widget.index == 0 ? 10 : 3,
          ),
          bottom: getVerticalSize(2.50),
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
              const Color(0xFFffffff).withOpacity(0.3),
              const Color(0xFFFFFFFF).withOpacity(0.3),
            ],
            stops: const [
              0.1,
              1
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white10.withOpacity(0.3),
            Colors.white10.withOpacity(0.3),
          ],
        ),
        height: getVerticalSize(82),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getHorizontalSize(10.00),
                top: getVerticalSize(10.00),
                bottom: getVerticalSize(10.00),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: getSize(58.00),
                      width: getSize(58.00),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                getSize(29.00),
                              ),
                              //ImageConstant.imgUnsplash3tll9
                              child: Image.network(
                                widget.userDataDocs['imageUrl'],
                                height: getSize(58.00),
                                width: getSize(58.00),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          widget.userDataDocs['status'] == "Offline"
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: getSize(14.50),
                                    width: getSize(14.50),
                                    margin: EdgeInsets.only(
                                      left: getHorizontalSize(10.00),
                                      top: getVerticalSize(10.00),
                                      right: getHorizontalSize(0.50),
                                      bottom: getVerticalSize(2.50),
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.lightGreenA700,
                                      borderRadius: BorderRadius.circular(
                                        getHorizontalSize(7.25),
                                      ),
                                      border: Border.all(
                                        color: ColorConstant.gray200,
                                        width: getHorizontalSize(1.00),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(15.00),
                        top: getVerticalSize(7.50),
                        bottom: getVerticalSize(7.50),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.userDataDocs['name'],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(17),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: getVerticalSize(6.00),
                              right: getHorizontalSize(10.00),
                            ),
                            child: Text(
                              "ID : " +
                                  (widget.userDataDocs['frontUid'].toString()),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.gray600,
                                fontSize: getFontSize(
                                  14,
                                ),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: widget.followingList
                      .contains(widget.userDataDocs['userId'])
                  ? () async {
                      removeFollowers
                          .add(FirebaseAuth.instance.currentUser!.uid);
                      removeFollowing.add(widget.userDataDocs['userId']);
                      await FirebaseFirestore.instance
                          .collection('followList')
                          .doc(widget.userDataDocs['userId'])
                          .update({
                        "followers": FieldValue.arrayRemove(removeFollowers)
                      });
                      await FirebaseFirestore.instance
                          .collection('followList')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "following": FieldValue.arrayRemove(removeFollowing),
                        // "isFollowing": true,
                      });
                      widget.refreshFn();
                      setState(() {});
                    }
                  : () async {
                      // final currentUserData = await callCurrentUserData();
                      // followers.add(FirebaseAuth.instance.currentUser!.uid);
                      followers.add(FirebaseAuth.instance.currentUser!.uid);
                      following.add(widget.userDataDocs['userId']);

                      await FirebaseFirestore.instance
                          .collection('followList')
                          .doc(widget.userDataDocs['userId'])
                          .update({
                        "followers": FieldValue.arrayUnion(followers),
                      });
                      await FirebaseFirestore.instance
                          .collection('followList')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "following": FieldValue.arrayUnion(following),
                        // "isFollowing": true,
                      });
                      widget.refreshFn();
                      setState(() {});
                      // setState(() {
                      //   isFollow = true;
                      // });
                    },
              child: Padding(
                padding: EdgeInsets.only(
                  // left: getHorizontalSize(100.00),
                  top: getVerticalSize(29.00),
                  right: getHorizontalSize(10.00),
                  bottom: getVerticalSize(29.00),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: getVerticalSize(20.00),
                  width: widget.followingList.contains(widget.userDataDocs['userId'])
                      ? getHorizontalSize(70)
                      : getHorizontalSize(50.00),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(18.50),
                    ),
                    border: widget.followingList.contains(widget.userDataDocs['userId'])
                        ? Border.all(
                            color: ColorConstant.deepPurple900, width: 1.5)
                        : null,
                    gradient:
                        widget.followingList.contains(widget.userDataDocs['userId'])
                            ? null
                            : LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  ColorConstant.deepPurple900,
                                  ColorConstant.purple500,
                                ],
                              ),
                  ),
                  child: Text(
                    widget.followingList.contains(widget.userDataDocs['userId'])
                        ? "Following"
                        : "Follow",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: widget.followingList.contains(widget.userDataDocs['userId'])
                          ? ColorConstant.deepPurple900
                          : ColorConstant.whiteA700,
                      fontSize: getFontSize(10),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
