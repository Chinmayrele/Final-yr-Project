import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_yr_project/rooms/widgets/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';
import '../model/user_model.dart';

class InviteList extends StatefulWidget {
  const InviteList({
    Key? key,
    required this.frndData,
    required this.roomName,
    required this.roomID,
    required this.hostName,
    required this.hostId,
    required this.imagePick,
  }) : super(key: key);
  final UserBasicModel frndData;
  final String roomName;
  final String roomID;
  final String hostName;
  final String hostId;
  final String imagePick;

  @override
  State<InviteList> createState() => _InviteListState();
}

class _InviteListState extends State<InviteList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Provid>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: getSize(
                  50.00,
                ),
                width: getSize(
                  50.00,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getSize(
                            25.00,
                          ),
                        ),
                        child: Image.network(
                          widget.frndData.imageUrl,
                          height: getSize(
                            50.00,
                          ),
                          width: getSize(
                            50.00,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: getSize(
                          12.50,
                        ),
                        width: getSize(
                          12.50,
                        ),
                        margin: EdgeInsets.only(
                          left: getHorizontalSize(
                            10.00,
                          ),
                          top: getVerticalSize(
                            10.00,
                          ),
                          right: getHorizontalSize(
                            0.43,
                          ),
                          bottom: getVerticalSize(
                            2.16,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.lightGreenA700,
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              6.25,
                            ),
                          ),
                          border: Border.all(
                            color: ColorConstant.gray200,
                            width: getHorizontalSize(
                              1.00,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getHorizontalSize(
                    19.00,
                  ),
                  top: getVerticalSize(
                    14.00,
                  ),
                  bottom: getVerticalSize(
                    15.00,
                  ),
                ),
                child: Text(
                  widget.frndData.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontSize: getFontSize(
                      18,
                    ),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  String myId = FirebaseAuth.instance.currentUser!.uid;
                  String inviteeId = widget.frndData.userId;
                  final strCompare = myId.compareTo(inviteeId);
                  final docId =
                      strCompare == -1 ? myId + inviteeId : inviteeId + myId;
                  final dateStamp = Timestamp.now();
                  await FirebaseFirestore.instance
                      .collection('chatRoom')
                      .doc(docId)
                      .collection('messages')
                      .add({
                    'text': {
                      "roomId": widget.roomID,
                      "roomName": widget.roomName,
                      "hostName": widget.hostName,
                      "hostId": widget.hostId,
                      "imagePick": widget.imagePick,
                    },
                    'type': "invite",
                    'createdAt': dateStamp,
                    'senderId': myId,
                    'receiverId': inviteeId
                  });
                  await FirebaseFirestore.instance
                      .collection('allMessage')
                      .doc(docId)
                      .set({
                        "senderUserId": FirebaseAuth.instance.currentUser!.uid,
      "receiverUserId": widget.frndData.userId,
                    // "userId": widget.frndData.userId,
                    "message": "An invite is sent to you!",
                    "createdAt": dateStamp,
                    "type": "invite",
                    "bothIds": docId,
                  });
                  provider.didInvite();
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
                    width:
                        // followBList.contains(widget.userDataDocs['userId'])
                        //     ? getHorizontalSize(70)
                        getHorizontalSize(50.00),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(18.50),
                      ),
                      // border:
                      // followBList.contains(widget.userDataDocs['userId'])
                      //     ? Border.all(
                      //         color: ColorConstant.deepPurple900, width: 1.5)
                      //     : null,
                      gradient:
                          // followBList.contains(widget.userDataDocs['userId'])
                          //     ? null
                          LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: provider.invite
                            ? [ColorConstant.whiteA700, ColorConstant.whiteA700]
                            : [
                                ColorConstant.deepPurple900,
                                ColorConstant.purple500,
                              ],
                      ),
                    ),
                    child: Text(
                      provider.invite ? "Invited" : "Invite",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color:
                            // followBList.contains(widget.userDataDocs['userId'])
                            //     ? ColorConstant.deepPurple900
                            provider.invite
                                ? ColorConstant.black900
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
          const SizedBox(height: 5),
          Divider(
            indent: 65,
            height: getVerticalSize(0.5),
            color: Colors.white,
            thickness: 0.5,
          )
        ],
      ),
    );
    // GlassmorphicContainer(
    //   margin: EdgeInsets.only(
    //       top: getVerticalSize(10),
    //       bottom: getVerticalSize(2.50),
    //       left: 10,
    //       right: 10),
    //   borderRadius: 20,
    //   width: size.width,
    //   blur: 15,
    //   alignment: Alignment.bottomCenter,
    //   border: 2,
    //   linearGradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         const Color(0xFFffffff).withOpacity(0.3),
    //         const Color(0xFFFFFFFF).withOpacity(0.3),
    //       ],
    //       stops: const [
    //         0.1,
    //         1
    //       ]),
    //   borderGradient: LinearGradient(
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    //     colors: [
    //       Colors.white10.withOpacity(0.3),
    //       Colors.white10.withOpacity(0.3),
    //     ],
    //   ),
    //   height: getVerticalSize(82),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(
    //           left: getHorizontalSize(10.00),
    //           top: getVerticalSize(10.00),
    //           bottom: getVerticalSize(10.00),
    //         ),
    //         child: Center(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               SizedBox(
    //                 height: getSize(58.00),
    //                 width: getSize(58.00),
    //                 child: Stack(
    //                   alignment: Alignment.bottomRight,
    //                   children: [
    //                     Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(
    //                           getSize(29.00),
    //                         ),
    //                         //ImageConstant.imgUnsplash3tll9
    //                         child: Image.network(
    //                           'https://farm9.staticflickr.com/8505/8441256181_4e98d8bff5_z_d.jpg',
    //                           height: getSize(58.00),
    //                           width: getSize(58.00),
    //                           fit: BoxFit.fill,
    //                         ),
    //                       ),
    //                     ),
    //                     Align(
    //                       alignment: Alignment.bottomRight,
    //                       child: Container(
    //                         height: getSize(14.50),
    //                         width: getSize(14.50),
    //                         margin: EdgeInsets.only(
    //                           left: getHorizontalSize(10.00),
    //                           top: getVerticalSize(10.00),
    //                           right: getHorizontalSize(0.50),
    //                           bottom: getVerticalSize(2.50),
    //                         ),
    //                         decoration: BoxDecoration(
    //                           color: ColorConstant.lightGreenA700,
    //                           borderRadius: BorderRadius.circular(
    //                             getHorizontalSize(7.25),
    //                           ),
    //                           border: Border.all(
    //                             color: ColorConstant.gray200,
    //                             width: getHorizontalSize(1.00),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                   left: getHorizontalSize(15.00),
    //                   top: getVerticalSize(7.50),
    //                   bottom: getVerticalSize(7.50),
    //                 ),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "User Name",
    //                       overflow: TextOverflow.ellipsis,
    //                       textAlign: TextAlign.left,
    //                       style: TextStyle(
    //                         color: ColorConstant.whiteA700,
    //                         fontSize: getFontSize(17),
    //                         fontFamily: 'Roboto',
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                     ),
    //                     // Padding(
    //                     //   padding: EdgeInsets.only(
    //                     //     top: getVerticalSize(6.00),
    //                     //     right: getHorizontalSize(10.00),
    //                     //   ),
    //                     //   child: Text(
    //                     //     "ID : " +
    //                     //         (widget.userDataDocs['userId'] as String)
    //                     //             .substring(0, 9),
    //                     //     overflow: TextOverflow.ellipsis,
    //                     //     textAlign: TextAlign.left,
    //                     //     style: TextStyle(
    //                     //       color: ColorConstant.gray600,
    //                     //       fontSize: getFontSize(
    //                     //         14,
    //                     //       ),
    //                     //       fontFamily: 'Roboto',
    //                     //       fontWeight: FontWeight.w400,
    //                     //     ),
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       const Spacer(),
    //       GestureDetector(
    //         onTap: () {},
    //         child: Padding(
    //           padding: EdgeInsets.only(
    //             // left: getHorizontalSize(100.00),
    //             top: getVerticalSize(29.00),
    //             right: getHorizontalSize(10.00),
    //             bottom: getVerticalSize(29.00),
    //           ),
    //           child: Container(
    //             alignment: Alignment.center,
    //             height: getVerticalSize(20.00),
    //             width:
    //                 // followBList.contains(widget.userDataDocs['userId'])
    //                 //     ? getHorizontalSize(70)
    //                 getHorizontalSize(50.00),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(
    //                 getHorizontalSize(18.50),
    //               ),
    //               // border:
    //               // followBList.contains(widget.userDataDocs['userId'])
    //               //     ? Border.all(
    //               //         color: ColorConstant.deepPurple900, width: 1.5)
    //               //     : null,
    //               gradient:
    //                   // followBList.contains(widget.userDataDocs['userId'])
    //                   //     ? null
    //                   LinearGradient(
    //                 begin: Alignment.centerLeft,
    //                 end: Alignment.centerRight,
    //                 colors: [
    //                   ColorConstant.deepPurple900,
    //                   ColorConstant.purple500,
    //                 ],
    //               ),
    //             ),
    //             child: Text(
    //               "Invite",
    //               textAlign: TextAlign.left,
    //               style: TextStyle(
    //                 color:
    //                     // followBList.contains(widget.userDataDocs['userId'])
    //                     //     ? ColorConstant.deepPurple900
    //                     ColorConstant.whiteA700,
    //                 fontSize: getFontSize(10),
    //                 fontFamily: 'Roboto',
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
