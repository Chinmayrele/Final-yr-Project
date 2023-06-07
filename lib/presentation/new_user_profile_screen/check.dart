import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../my_zone_screen/my_zone_screen.dart';
import 'package:intl/intl.dart';

import '../../shared_pref/first_time_login.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool male = false;
  bool female = false;
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _dobController = TextEditingController();
  bool isLoadingConfirm = false;
  File? _imageFile;
  UploadTask? task;
  String urlDownload = '';
  DateTime? datePicked;

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
        // widget.imageList.add(urlDownload);
        // imageUrlsUser.add(urlDownload);
        // FirebaseFirestore.instance
        //     .collection('profile')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .update({
        //   'imageUrls': widget.imageList,
        // });
        setState(() {});
      }
    } on FirebaseException catch (e) {
      //debugPrint('Error Uploading: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(
                1.9839188847292633e-8,
                -0.016875002677067014,
              ),
              end: const Alignment(
                1.0000000074505806,
                1.0000000075763091,
              ),
              colors: [
                ColorConstant.purpleA400D1.withOpacity(0.3),
                ColorConstant.blue90066.withOpacity(0.3),
              ],
            ),
          ),
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
              Align(
                alignment: Alignment.center,
                child: GlassmorphicContainer(
                  margin: EdgeInsets.only(
                    left: getHorizontalSize(36.00),
                    top: getVerticalSize(40.00),
                    right: getHorizontalSize(36.00),
                    bottom: getVerticalSize(40.00),
                  ),
                  borderRadius: 10,
                  width: size.width,
                  blur: 5,
                  alignment: Alignment.bottomCenter,
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
                  height: getVerticalSize(530),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await getPicture();
                          // await convertToUrl();
                          setState(() {});
                        },
                        child: Container(
                          height: getVerticalSize(96.32),
                          width: getHorizontalSize(96.97),
                          margin: EdgeInsets.only(
                            left: getHorizontalSize(33.00),
                            top: getVerticalSize(50.00),
                            right: getHorizontalSize(33.00),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: getVerticalSize(96.32),
                                  width: getHorizontalSize(96.97),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorConstant.whiteA70026,
                                            borderRadius: BorderRadius.circular(
                                              getHorizontalSize(52),
                                            ),
                                            border: Border.all(
                                              color: ColorConstant.whiteA70033,
                                              width: getHorizontalSize(4.00),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black54
                                                    .withOpacity(0.04),
                                                spreadRadius:
                                                    getHorizontalSize(2.00),
                                                blurRadius:
                                                    getHorizontalSize(2.00),
                                                offset: const Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          height: getSize(96.32),
                                          width: getSize(96.97),
                                          child: _imageFile != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          96.32),
                                                  child: Image.file(
                                                    _imageFile!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : SvgPicture.asset(
                                                  ImageConstant.imgSubtract,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            height: getSize(24.00),
                                            width: getSize(24.00),
                                            margin: EdgeInsets.only(
                                              left: getHorizontalSize(10.00),
                                              top: getVerticalSize(10.00),
                                              bottom: getVerticalSize(5.32),
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getHorizontalSize(12.00),
                                              ),
                                              border: Border.all(
                                                color: ColorConstant.whiteA700,
                                                width: getHorizontalSize(2.00),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      ColorConstant.black9001a,
                                                  spreadRadius:
                                                      getHorizontalSize(2.00),
                                                  blurRadius:
                                                      getHorizontalSize(2.00),
                                                  offset: const Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      getHorizontalSize(15)),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(25.00),
                          top: getVerticalSize(30.72),
                          right: getHorizontalSize(25.00),
                        ),
                        child: SizedBox(
                          height: getVerticalSize(40.63),
                          width: getHorizontalSize(220.00),
                          child: TextFormField(
                            controller: _nameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                fontSize: getFontSize(32.0),
                                color: ColorConstant.whiteA7004c,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorConstant.whiteA70033,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorConstant.whiteA70033,
                                  width: 2,
                                ),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                bottom: getVerticalSize(5.12),
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getFontSize(28.0),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(25.00),
                          top: getVerticalSize(34.87),
                          right: getHorizontalSize(25.00),
                        ),
                        child: SizedBox(
                            // height: getVerticalSize(42.63),
                            width: getHorizontalSize(220.00),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    datePicked =
                                        await DatePicker.showSimpleDatePicker(
                                      context,
                                      initialDate: DateTime.now(),
                                      // firstDate: DateTime(2022),
                                      lastDate: DateTime.now(),
                                      dateFormat: 'dd/MM/yyyy',
                                      locale: DateTimePickerLocale.en_us,
                                      looping: true,
                                    );
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    width: 220,
                                    child: Text(
                                      datePicked == null
                                          ? 'D.O.B'
                                          : DateFormat('dd/MM/yyyy')
                                              .format(datePicked!),
                                      style: TextStyle(
                                        fontSize: getFontSize(28.0),
                                        color: ColorConstant.whiteA7004c,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: ColorConstant.whiteA70033,
                                  thickness: 2,
                                )
                              ],
                            )
                            // TextFormField(
                            //   controller: _dobController,
                            //   textAlign: TextAlign.center,
                            //   keyboardType: TextInputType.datetime,
                            //   decoration: InputDecoration(
                            //     hintText: 'D.O.B',
                            //     hintStyle: TextStyle(
                            //       fontSize: getFontSize(32.0),
                            //       color: ColorConstant.whiteA7004c,
                            //     ),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //         color: ColorConstant.whiteA70033,
                            //         width: 2,
                            //       ),
                            //     ),
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //         color: ColorConstant.whiteA70033,
                            //         width: 2,
                            //       ),
                            //     ),
                            //     isDense: true,
                            //     contentPadding: EdgeInsets.only(
                            //       bottom: getVerticalSize(5.12),
                            //     ),
                            //   ),
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: getFontSize(28.0),
                            //     fontFamily: 'Roboto',
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            //   onChanged: (val) {
                            //
                            //     }
                            //   },
                            // ),
                            ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: getVerticalSize(24.63),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    male = true;
                                    female = false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(60.36),
                                  ),
                                  child: SizedBox(
                                    height: getSize(52.68),
                                    width: getSize(52.68),
                                    child: SvgPicture.asset(
                                        ImageConstant.imgGroup406,
                                        color: male
                                            ? ColorConstant.male
                                                .withOpacity(0.8)
                                            : Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    female = true;
                                    male = false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getHorizontalSize(51.80),
                                    right: getHorizontalSize(50.48),
                                  ),
                                  child: SizedBox(
                                    height: getSize(52.68),
                                    width: getSize(52.68),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgGroup405,
                                      fit: BoxFit.fill,
                                      color: female
                                          ? ColorConstant.female
                                              .withOpacity(0.8)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(33.00),
                          top: getVerticalSize(38.52),
                          right: getHorizontalSize(33.00),
                          bottom: getVerticalSize(50.47),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            if (_imageFile == null) {
                              snackBar('Please Enter a Image');
                              return;
                            }
                            if (_nameController.text.isEmpty) {
                              snackBar('Please enter your avatar name');
                              return;
                            }
                            if (datePicked == null) {
                              snackBar('Please enter your date of birth');
                              return;
                            }
                            if (male == false && female == false) {
                              snackBar('Please select your gender');
                              return;
                            }
                            setState(() {
                              isLoadingConfirm = true;
                            });
                            await setVisitingFlag(isProfileDone: true);
                            await convertToUrl();
                            final data = await FirebaseFirestore.instance
                                .collection('usersUIDS')
                                .doc('allUsersUids')
                                .get();
                            final e = data.data();
                            final frontid = e!['userUids'];
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "userId": FirebaseAuth.instance.currentUser!.uid,
                              "name": _nameController.text,
                              "dateBirth":
                                  DateFormat('dd/MM/yyyy').format(datePicked!),
                              "gender": male ? "Male" : "Female",
                              "imageUrl": urlDownload,
                              "isProfileComplete": true,
                              "coverImage": "",
                              "about": "",
                              "address": "",
                              "status": "Online",
                              "frontUid": frontid,
                              "likesOnMe": 0,
                            });
                            await FirebaseFirestore.instance
                                .collection('usersUIDS')
                                .doc('allUsersUids')
                                .update({
                                  "userUids": FieldValue.increment(1),
                                });
                            await FirebaseFirestore.instance
                                .collection('followList')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "followers": [],
                              "following": [],
                              "friends": [],
                              "visitors": [],
                              "userId": FirebaseAuth.instance.currentUser!.uid,
                              "email": FirebaseAuth.instance.currentUser!.email,
                            });
                            final newRef = FirebaseFirestore.instance
                                .collection("UsersDiamond");
                            await newRef
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "diamond": 0,
                              "ruby": 0,
                              "charisma": 0,
                              "todayCharisma": 0,
                              "date": "",
                            });
                            await FirebaseFirestore.instance
                                .collection('userFrames')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "framesAdd": [],
                            });
                            await FirebaseFirestore.instance
                                .collection('transactions')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "transHistory": [],
                            });
                            await FirebaseFirestore.instance
                                .collection('hostRoomData')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "roomName": "",
                              "roomId": "",
                              "userId": "",
                              "roomCharisma": 0,
                              "imageRoom": "",
                              "users": [],
                              "type": "",
                              "lockId": "",
                              "hostName": "",
                              "todayUsers": [],
                            });
                            await FirebaseFirestore.instance
                                .collection('userJoinRoom')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "roomName": "",
                              "roomId": "",
                              "type": "",
                              "userId": "",
                              "members": 0,
                              "hostName": "",
                              "imageRoom": "",
                            });
                            // await FirebaseFirestore.instance
                            //     .collection('recentVisited')
                            //     .doc(FirebaseAuth.instance.currentUser!.uid);

                            //     .set({
                            //   "recentList": [],
                            // });
                            setState(() {
                              isLoadingConfirm = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyZoneScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: getVerticalSize(46.53),
                            width: getHorizontalSize(172.96),
                            decoration: BoxDecoration(
                              color: male
                                  ? ColorConstant.male.withOpacity(0.25)
                                  : female
                                      ? ColorConstant.female.withOpacity(0.25)
                                      : ColorConstant.whiteA7004c,
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(26.50),
                              ),
                              border: Border.all(
                                color: male
                                    ? ColorConstant.male.withOpacity(0.2)
                                    : female
                                        ? ColorConstant.female.withOpacity(0.2)
                                        : ColorConstant.whiteA70026,
                                width: getHorizontalSize(3.00),
                              ),
                            ),
                            child: isLoadingConfirm
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "CONFIRM",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: male
                                          ? Colors.white
                                          : female
                                              ? Colors.white
                                              : ColorConstant.indigoA700,
                                      fontSize: getFontSize(20),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
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
    );
  }
}
