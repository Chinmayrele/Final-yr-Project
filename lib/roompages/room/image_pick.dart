import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/zego_page_constant.dart';
import '../../constants/zim_error_code.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../create_room_public_screen/frame1268.dart';
import '../../generate_random.dart';
import '../../localization/localisation.dart';
import '../../model/user_model.dart';
import '../../model/zego_user_info.dart';
import '../../service/zego_room_service.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import '../../service/zego_speaker_seat_service.dart';
import '../../service/zego_user_service.dart';

class EntranceData extends StatefulWidget {
  const EntranceData({
    Key? key,
    required this.curData,
  }) : super(key: key);
  final UserBasicModel curData;

  @override
  State<EntranceData> createState() => _EntranceDataState();
}

class _EntranceDataState extends State<EntranceData> {
  File? _imageFile;
  String urlDownload = '';
  UploadTask? task;
  bool isLoading = false;
  bool roomTr = true;
  int integers = 00000;
  String alphabets = 'abcde';
  bool isRoomCreating = false;

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

  Future<void> getPicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageTemp = File(image.path);
        setState(() {
          _imageFile = imageTemp;
        });
      }
    } on PlatformException catch (err) {
      //debugPrint('Failed to Pick up the Image: $err');
    }
  }

  Future<void> convertToUrl() async {
    try {
      if (_imageFile != null) {
        final fileName = _imageFile!.path;
        final destination = 'files/$fileName';
        final ref = FirebaseStorage.instance.ref(destination);
        task = ref.putFile(_imageFile!);
        if (task == null) {
          return;
        }
        final snapshot = await task!.whenComplete(() {});
        urlDownload = await snapshot.ref.getDownloadURL();
        debugPrint('DOWNLOAD URL OF IMAGE: $urlDownload');
        setState(() {});
      }
    } on FirebaseException catch (e) {
      //debugPrint('Error Uploading: $e');
    }
  }

  String roomNameField = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            await getPicture();
            setState(() {
              isLoading = false;
            });
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: getVerticalSize(128.00),
              width: getHorizontalSize(145.00),
              margin: EdgeInsets.only(
                left: getHorizontalSize(30.00),
                top: getVerticalSize(47.00),
                right: getHorizontalSize(30.00),
                bottom: 20,
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(70)),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: getHorizontalSize(0.00),
                        ),
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                                height: getSize(140.00),
                                width: getSize(140.00),
                              )
                            : Image.asset(
                                ImageConstant.imgUnsplash889qh5,
                                height: getSize(128.00),
                                width: getSize(128.00),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(10.00),
                        top: getVerticalSize(10.00),
                        bottom: getVerticalSize(9.00),
                      ),
                      child: Container(
                        height: getSize(39.00),
                        width: getSize(39.00),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: SvgPicture.asset(
                          ImageConstant.imgGroup1257,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //PUBLIC-LOCK
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: getVerticalSize(32.00), bottom: 20),
            child: Row(
              children: [
                Container(
                  height: getVerticalSize(30.00),
                  margin: EdgeInsets.only(
                    left: getHorizontalSize(31.00),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Container(
                      //   height: getVerticalSize(
                      //     30.00,
                      //   ),
                      //   width: getHorizontalSize(
                      //     77.43,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.circular(
                      //       getHorizontalSize(
                      //         15.00,
                      //       ),
                      //     ),
                      //     border: Border.all(
                      //       color:
                      //           room?ColorConstant.whiteA700:Colors.transparent,
                      //       width: getHorizontalSize(
                      //         1.00,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            roomTr = true;
                            // widget.refresh(room);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(2.00),
                            top: getVerticalSize(2.00),
                            right: getHorizontalSize(2.63),
                            bottom: getVerticalSize(2.00),
                          ),
                          decoration: BoxDecoration(
                            color: roomTr
                                ? ColorConstant.whiteA70033
                                : ColorConstant.black90033,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                12.00,
                              ),
                            ),
                            border: Border.all(
                              color: roomTr
                                  ? ColorConstant.whiteA700
                                  : ColorConstant.black90019,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(10.00),
                                  top: getVerticalSize(3),
                                ),
                                child: Container(
                                    height: getVerticalSize(5.27),
                                    width: getHorizontalSize(9.80),
                                    child: Icon(
                                      Icons.lock_open_outlined,
                                      color: roomTr
                                          ? Colors.white
                                          : ColorConstant.whiteA7007f,
                                      size: 15,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(4.00),
                                  top: getVerticalSize(3.00),
                                  right: getHorizontalSize(12.00),
                                  bottom: getVerticalSize(3.00),
                                ),
                                child: Text(
                                  "public",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: roomTr
                                        ? ColorConstant.whiteA700
                                        : ColorConstant.whiteA7007f,
                                    fontSize: getFontSize(
                                      13,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
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
                  height: getVerticalSize(
                    30.00,
                  ),
                  margin: EdgeInsets.only(
                    left: getHorizontalSize(
                      10.00,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Container(
                      //   height: getVerticalSize(
                      //     30.00,
                      //   ),
                      //   width: getHorizontalSize(
                      //     77.43,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.circular(
                      //       getHorizontalSize(
                      //         15.00,
                      //       ),
                      //     ),
                      //     border: Border.all(
                      //       color:
                      //           room?Colors.transparent:ColorConstant.whiteA700,
                      //       width: getHorizontalSize(
                      //         1.00,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            roomTr = false;
                            // widget.refresh(room);
                          });
                          // ZegoRoomService? roomService;
                          // roomService!.roomInfo.roomID = 'cav';
                          // var seatService =
                          //     context.read<ZegoSpeakerSeatService>();
                          // seatService
                          //     .closeAllSeat(true, roomService.roomInfo)
                          //     .then((errorCode) {
                          //   if (0 != errorCode) {
                          //     Fluttertoast.showToast(
                          //         msg: AppLocalizations.of(context)!
                          //             .toastLockSeatError(errorCode),
                          //         backgroundColor: Colors.grey);
                          //   }
                          // });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                Frame1268Screen(context),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(2.00),
                            top: getVerticalSize(2.00),
                            right: getHorizontalSize(2.63),
                            bottom: getVerticalSize(2.00),
                          ),
                          decoration: BoxDecoration(
                            color: roomTr
                                ? ColorConstant.black90033
                                : ColorConstant.whiteA70033,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                12.00,
                              ),
                            ),
                            border: Border.all(
                              color: roomTr
                                  ? ColorConstant.black90019
                                  : ColorConstant.whiteA700,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(10.00),
                                  top: getVerticalSize(3),
                                ),
                                child: SizedBox(
                                    height: getVerticalSize(5.27),
                                    width: getHorizontalSize(9.80),
                                    child: Icon(
                                      Icons.lock,
                                      color: roomTr
                                          ? ColorConstant.whiteA7007f
                                          : Colors.white,
                                      size: 15,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: getHorizontalSize(10.00),
                                  top: getVerticalSize(3.00),
                                  right: getHorizontalSize(14.00),
                                  bottom: getVerticalSize(3.00),
                                ),
                                child: Text(
                                  "Lock",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: roomTr
                                        ? ColorConstant.whiteA7007f
                                        : ColorConstant.whiteA700,
                                    fontSize: getFontSize(
                                      13,
                                    ),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
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
          ),
        ),
        //TextField

        Padding(
          padding: EdgeInsets.only(
            left: getHorizontalSize(30.00),
            top: getVerticalSize(56.00),
            right: getHorizontalSize(30.00),
          ),
          child: SizedBox(
            height: getVerticalSize(38.00),
            width: getHorizontalSize(300.00),
            child: TextFormField(
              // controller: dialogRoomNameInputController,
              decoration: InputDecoration(
                hintText: 'Channel Name',
                hintStyle: TextStyle(
                  fontSize: getFontSize(
                    25.0,
                  ),
                  color: ColorConstant.whiteA7004c,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.whiteA7004c,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.whiteA7004c,
                  ),
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: getVerticalSize(2.15),
                  bottom: getVerticalSize(11.15),
                ),
              ),
              style: TextStyle(
                color: ColorConstant.whiteA7004c,
                fontSize: getFontSize(25.0),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
              onChanged: (val) {
                roomNameField = val;
              },
            ),
          ),
        ),
        //OK BUTTON
        Container(
          width: getSize(81.00),
          margin: EdgeInsets.only(
            left: getHorizontalSize(10.00),
            top: getVerticalSize(58.00),
          ),
          child: GestureDetector(
            onTap: () async {
              if (_imageFile == null) {
                snackBar("Please select your room image first");
              } else {
                setState(() {
                  isRoomCreating = true;
                });
                ZegoUserInfo info = ZegoUserInfo.empty();
                info.userID = widget.curData.userId;
                info.userName = widget.curData.name;
                if (info.userName.isEmpty) {
                  info.userName = info.userID;
                }
                var userModel = context.read<ZegoUserService>();
                final errorCode = await userModel.login(info, "");
                // .then((errorCode) {
                debugPrint("ERROR CODE TROUBLING: $errorCode");
                if ((errorCode) != 0) {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .toastLoginFail(errorCode),
                      backgroundColor: Colors.grey);
                  setState(() {
                    isRoomCreating = false;
                  });
                } else {
                  final e = await FirebaseFirestore.instance
                      .collection('roomUID')
                      .doc('createRoomID')
                      .get();
                  final data = e.data();
                  alphabets = generateRandomString(5);
                  integers = data!['intValue'];
                  String roomID = alphabets + integers.toString();
                  debugPrint("ROOM ID CREATED: $roomID");
                  tryCreateRoom(context, roomID, roomNameField);
                }
              }
              // });
              // tryCreateRoom(context, 'abcde12345', roomNameField);
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: getSize(67.00),
                    width: getSize(67.00),
                    margin: EdgeInsets.only(
                      left: getHorizontalSize(7.00),
                      top: getVerticalSize(7.00),
                      right: getHorizontalSize(7.00),
                      bottom: getVerticalSize(7.00),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: getSize(
                              67.00,
                            ),
                            width: getSize(
                              67.00,
                            ),
                            child: CircularProgressIndicator(
                              value: 0,
                              backgroundColor: ColorConstant.red504c,
                              strokeWidth: getHorizontalSize(
                                3.00,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: getSize(
                      81.00,
                    ),
                    width: getSize(
                      81.00,
                    ),
                    margin: EdgeInsets.only(
                      left: getHorizontalSize(135.00),
                      top: getVerticalSize(7.00),
                      right: getHorizontalSize(7.00),
                      bottom: getVerticalSize(7.00),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          40.50,
                        ),
                      ),
                      border: Border.all(
                        color: ColorConstant.whiteA70066,
                        width: getHorizontalSize(
                          3.00,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: isRoomCreating
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        )
                      : Text(
                          "OK",
                          style: TextStyle(
                              fontSize: getFontSize(25),
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  // final dialogRoomNameInputController = useTextEditingController();

  void tryCreateRoom(
      BuildContext context, String roomID, String roomName) async {
    debugPrint("NAME OF CURR USER DATA IS: ${widget.curData.name}");

    if (roomID.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toastRoomIdEnterError,
          backgroundColor: Colors.grey);
      return;
    }
    if (roomName.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.toastRoomNameError,
          backgroundColor: Colors.grey);
      return;
    }
    debugPrint("PRINT SOMETHING IN TRYCREATE");
    var room = context.read<ZegoRoomService>();
    final code = await room.createRoom(roomID, roomName);
    // .then((code)
    if (code != 0) {
      String message = AppLocalizations.of(context)!.toastCreateRoomFail(code);
      if (code ==
          ZIMErrorCodeExtension.valueMap[zimErrorCode.createExistRoom]) {
        message = AppLocalizations.of(context)!.toastRoomExisted;
      }
      Fluttertoast.showToast(msg: message, backgroundColor: Colors.grey);
      setState(() {
        isRoomCreating = false;
      });
    } else {
      // ROOM ADDING TO FIREBASE DATA LOGIC

      // List<Map<String, dynamic>> listData = [];
      // Map<String, dynamic> mp = {
      //   "roomName": roomName,
      //   "roomId": roomID,
      //   "userId": widget.curData.userId,
      //   "users": [],
      //   "type": "host",
      // };
      // listData.clear();
      // listData.add(mp);
      // UPDATE WILL FAIL HERE SINCE NO DOCUMENT ID IS CREATED> FIRST CREATE DOC ID IN LOL_INFI_APP
      // setState(() {
      //   isRoomCreating = true;
      // });
      await convertToUrl();

      await FirebaseFirestore.instance
          .collection('roomUID')
          .doc('createRoomID')
          .set({
        "aplhabet": alphabets,
        "intValue": integers + 1,
      });
      await FirebaseFirestore.instance
          .collection('hostRoomData')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "roomName": roomName,
        "roomId": roomID,
        "imageRoom": urlDownload,
        "userId": widget.curData.userId,
        "users": [FirebaseAuth.instance.currentUser!.uid],
        "type": "host",
        "roomCharisma": 0,
        "lockId": "",
        "hostName": widget.curData.name,
        "todayUsers": [],
      });
      await FirebaseFirestore.instance
          .collection('userJoinRoom')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "roomName": roomName,
        "roomId": roomID,
        "type": "host",
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "members": 1,
        "hostName": widget.curData.name,
        "imageRoom": urlDownload,
      });
      setState(() {
        isRoomCreating = false;
      });

      // ROOM SEATS LOCK LOGIC IF LOCK IS TRUE
      // if (roomTr) {
      //   ZegoRoomService? roomService;
      //   roomService!.roomInfo.roomID = roomID;
      //   roomService.roomInfo.roomName = roomName;
      //   var seatService = context.read<ZegoSpeakerSeatService>();
      //   seatService.closeAllSeat(true, roomService.roomInfo).then((errorCode) {
      //     if (0 != errorCode) {
      //       Fluttertoast.showToast(
      //           msg:
      //               AppLocalizations.of(context)!.toastLockSeatError(errorCode),
      //           backgroundColor: Colors.grey);
      //     }
      //   });
      // }  // ROOM LOCK LOGIC TILL HERE

      //NAVIGATE THE PAGE
      Navigator.pushReplacementNamed(context, PageRouteNames.roomMain,
          arguments: {
            "roomName": roomName,
            "roomId": roomID,
            "hostName": widget.curData.name,
            "hostId": widget.curData.userId,
            "imagePickRoom": urlDownload,
          });
    }
    // })
  }
}
