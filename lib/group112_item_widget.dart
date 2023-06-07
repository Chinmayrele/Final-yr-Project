import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/providers/info_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import 'core/utils/color_constant.dart';
import 'core/utils/math_utils.dart';
import 'inbox_screen/inbox_screen.dart';
import 'model/user_model.dart';

// ignore: must_be_immutable
class Group112ItemWidget extends StatefulWidget {
  const Group112ItemWidget({
    Key? key,
    // required this.frndList,
    required this.chatData,
  }) : super(key: key);
  // final UserBasicModel frndList;
  final QueryDocumentSnapshot<Object?> chatData;

  @override
  State<Group112ItemWidget> createState() => _Group112ItemWidgetState();
}

class _Group112ItemWidgetState extends State<Group112ItemWidget> {
  late UserBasicModel userDataCreated;
  bool isLoading = true;
  @override
  void initState() {
    final result = Provider.of<InfoProviders>(context, listen: false);
    String idss = (widget.chatData['receiverUserId'] as String) ==
            FirebaseAuth.instance.currentUser!.uid
        ? 'senderUserId'
        : 'receiverUserId';
    result.fetchUserModelData(widget.chatData[idss]).then((value) {
      userDataCreated = value;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var timeDate = (widget.chatData['createdAt'] as Timestamp).toDate();
    List<String> tim = timeDate.toString().split(" ");
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InboxScreen(frndDataModel: userDataCreated)
                      // InboxScreen(frndDataModel: widget.frndList)
                      ));
            },
            child: GlassmorphicContainer(
              margin: EdgeInsets.only(
                top: getVerticalSize(
                  2.0,
                ),
                bottom: getVerticalSize(
                  2.0,
                ),
              ),
              borderRadius: 15,
              width: size.width,
              blur: 15,
              alignment: Alignment.bottomCenter,
              border: 1,
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
                  Colors.white10.withOpacity(0.2),
                  Colors.white10.withOpacity(0.2),
                ],
              ),
              height: getVerticalSize(87.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        11.00,
                      ),
                      top: getVerticalSize(
                        10.00,
                      ),
                      bottom: getVerticalSize(
                        11.00,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            getSize(
                              29.00,
                            ),
                          ),
                          child: Image.network(
                            userDataCreated.imageUrl,
                            // widget.frndList.imageUrl,
                            fit: BoxFit.cover,
                            height: getSize(58),
                            width: getSize(58),
                          ),
                          // Image.asset(
                          //   ImageConstant.imgEllipse9,
                          //   height: getSize(
                          //     58.00,
                          //   ),
                          //   width: getSize(
                          //     58.00,
                          //   ),
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              13.92,
                            ),
                            top: getVerticalSize(
                              5,
                            ),
                            bottom: getVerticalSize(
                              10.36,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: getHorizontalSize(
                                    0.00,
                                  ),
                                ),
                                child: Text(
                                  userDataCreated.name,
                                  // widget.frndList.name,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.gray900,
                                    fontSize: getFontSize(
                                      17,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    10.00,
                                  ),
                                ),
                                child: Text(
                                  widget.chatData['message'],
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
                  const Spacer(),
                  Center(
                    child: Text(
                      tim[0] == DateTime.now().toString().split(' ')[0]
                          ? tim[1].substring(0, 8)
                          : tim[0].substring(0, 10),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.gray600,
                        fontSize: getFontSize(
                          11,
                        ),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          );
  }
}
