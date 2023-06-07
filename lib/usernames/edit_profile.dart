import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import '../model/user_model.dart';
import '../providers/info_providers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    required this.currentUserData,
    required this.refreshFn,
  }) : super(key: key);
  final UserBasicModel currentUserData;
  final void Function(
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
    int sLikesOnMe,
  ) refreshFn;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isImageLoading = false;
  bool isSaved = false;
  String urlDownload = '';
  File? _imageFile;
  UploadTask? task;
  TextEditingController bioController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  DateTime? _dateTime;
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

  Future<void> convertToUrl(String imageType) async {
    try {
      if (_imageFile != null) {
        final fileName = _imageFile!.path;
        final destination = 'files/$fileName';
        final ref = FirebaseStorage.instance.ref(destination);
        task = ref.putFile(_imageFile!);
        if (task == null) {
          return;
        }
        urlDownload = '';
        final snapshot = await task!.whenComplete(() {});
        urlDownload = await snapshot.ref.getDownloadURL();
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .update({
        //   imageType: urlDownload,
        // });
        debugPrint('DOWNLOAD URL OF IMAGE: $urlDownload');
        setState(() {});
      }
    } on FirebaseException catch (e) {
      //debugPrint('Error Uploading: $e');
    }
  }

  Future<bool?> _backPressFn(BuildContext ctx) async {
    return showDialog<bool>(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Do you really want to exit the without saving changes!',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ],
          );
        });
  }

  @override
  void initState() {
    _value =
        widget.currentUserData.gender.toLowerCase().contains('female') ? 1 : 2;
    super.initState();
  }

  // return Future(() => false);
  String selectedBio = '';
  String selectedName = '';
  String selectedImage = '';
  String selectedCoverImage = '';
  String selectedDob = '';
  String selectedGender = '';
  String selectedAddress = '';
  late int _value;

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<InfoProviders>(context);
    String selectedBioUs = widget.currentUserData.about;
    String selectedNameUs = widget.currentUserData.name;
    String selectedImageUs = widget.currentUserData.imageUrl;
    String selectedCoverImageUs = widget.currentUserData.coverImage;
    String selectedDobUs = widget.currentUserData.dob;
    String selectedGenderUs = widget.currentUserData.gender;
    String selectedAddressUs = widget.currentUserData.address;
    // _value = selectedGenderUs.toLowerCase().contains('female') ? 1 : 2;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _backPressFn(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Edit Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              )),
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 26,
              )),
          actions: [
            Container(
              width: 70,
              margin: const EdgeInsets.only(top: 10, bottom: 10, right: 13),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isSaved = true;
                  });
                  result.saveProfileChanges(
                      selectedName.isEmpty ? selectedNameUs : selectedName,
                      selectedImage.isEmpty ? selectedImageUs : selectedImage,
                      selectedGender.isEmpty
                          ? selectedGenderUs
                          : selectedGender,
                      selectedAddress.isEmpty
                          ? selectedAddressUs
                          : selectedAddress,
                      selectedBio.isEmpty ? selectedBioUs : selectedBio,
                      selectedDob.isEmpty ? selectedDobUs : selectedDob,
                      selectedCoverImage.isEmpty
                          ? selectedCoverImageUs
                          : selectedCoverImage);
                  // await FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc(FirebaseAuth.instance.currentUser!.uid)
                  //     .update({
                  //   "name": selectedName,
                  //   "imageUrl": selectedImage,
                  //   "gender": selectedGender,
                  //   "address": selectedAddress,
                  //   "about": selectedBio,
                  //   "dateBirth": selectedDob,
                  //   "coverImage": selectedCoverImage,
                  // });
                  widget.refreshFn(
                    widget.currentUserData.userId,
                    selectedName.isEmpty ? selectedNameUs : selectedName,
                    selectedDob.isEmpty ? selectedDobUs : selectedDob,
                    selectedGender.isEmpty ? selectedGenderUs : selectedGender,
                    selectedImage.isEmpty ? selectedImageUs : selectedImage,
                    selectedCoverImage.isEmpty
                        ? selectedCoverImageUs
                        : selectedCoverImage,
                    selectedBio.isEmpty ? selectedBioUs : selectedBio,
                    selectedAddress.isEmpty
                        ? selectedAddressUs
                        : selectedAddress,
                    "Online",
                    widget.currentUserData.frontUid,
                    widget.currentUserData.likesOnMe,
                  );
                  setState(() {
                    isSaved = false;
                  });
                  Navigator.of(context).pop();
                },
                child: isSaved
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'OK',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            )
          ],
        ),
        body: Stack(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Click on cover photo to change it!!!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: isImageLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.pink,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isImageLoading = true;
                                });
                                await getPicture();
                                await convertToUrl("coverImage");
                                selectedCoverImage = urlDownload;
                                setState(() {
                                  isImageLoading = false;
                                });
                              },
                              child: SizedBox(
                                  height: 120,
                                  width: 110,
                                  child: selectedCoverImage.trim().isNotEmpty
                                      ? Image.network(
                                          selectedCoverImage,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          ImageConstant.imgUnsplashyp4wgd,
                                          width: getHorizontalSize(360.00),
                                          fit: BoxFit.fill,
                                        ))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // backgroundColor: ColorConstant.blue100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              title: const Text(
                                'BIO',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              content: SizedBox(
                                height: 100,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Update your bio here!',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                              depth: -3,
                                              color: Colors.white,
                                              border: NeumorphicBorder(
                                                  width: 0.5,
                                                  color: ColorConstant.blue900),
                                              boxShape: const NeumorphicBoxShape
                                                  .stadium(),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: getVerticalSize(13),
                                                // bottom: getVerticalSize(8),
                                                left: getHorizontalSize(15)),
                                            child: TextFormField(
                                              // initialValue: widget.currentUserData.about,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                              cursorHeight: 17,
                                              controller: bioController,
                                              maxLines: null,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "About you",
                                                hintStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: getFontSize(
                                                    15,
                                                  ),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ]),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      selectedBio = bioController.text;
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ],
                            );
                          });
                      debugPrint("BIO IN BUILD: $selectedBio");
                    },
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.only(left: 20, right: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Bio', style: TextStyle(color: Colors.grey)),
                          // Expanded(
                          //     child: GestureDetector(
                          //       child: Container(
                          //   height: 45,
                          // ),
                          //     )),
                          // Spacer(),
                          Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1.2),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20, right: 19),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: const Text(
                                  'Avatar Image',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                content: SizedBox(
                                  height: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Change your Avatar Image Here!',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      const SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          await getPicture();
                                          await convertToUrl("imageUrl");
                                          selectedImage = urlDownload;
                                          setState(() {});
                                        },
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                selectedImage.trim().isEmpty
                                                    ? selectedImageUs
                                                    : selectedImage,
                                                // widget.currentUserData.imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        selectedImage = urlDownload;
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                ],
                              );
                            });
                      },
                      child: Row(
                        children: [
                          const Text('Avatar',
                              style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              selectedImage.trim().isEmpty
                                  ? selectedImageUs
                                  : selectedImage,
                              // widget.currentUserData.imageUrl,
                            ),
                            radius: 20,
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1.2),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20, right: 19),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: const Text(
                                  'Avatar Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                content: SizedBox(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Change your name here!',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                depth: -3,
                                                color: Colors.white,
                                                border: NeumorphicBorder(
                                                    width: 0.5,
                                                    color:
                                                        ColorConstant.blue900),
                                                boxShape:
                                                    const NeumorphicBoxShape
                                                        .stadium(),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: getVerticalSize(13),
                                                  // bottom: getVerticalSize(8),
                                                  left: getHorizontalSize(15)),
                                              child: TextFormField(
                                                // initialValue: widget.currentUserData.about,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                                cursorHeight: 17,
                                                controller: nameController,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: "Name",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: getFontSize(
                                                      15,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    )),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedName = nameController.text;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                ],
                              );
                            });
                      },
                      child: Row(
                        children: [
                          const Text('Nickname',
                              style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          Text(
                              selectedName.trim().isEmpty
                                  ? selectedNameUs
                                  : selectedName,
                              // widget.currentUserData.name,
                              style: const TextStyle(color: Colors.black)),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1.2),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20, right: 19),
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 29200)),
                            lastDate: DateTime.now());
                        if (date == null) {
                          return;
                        }
                        setState(() {
                          _dateTime = date;
                          selectedDob = date.toString();
                        });
                      },
                      child: Row(
                        children: [
                          const Text('Birthday',
                              style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          Text(
                              selectedDob.trim().isEmpty
                                  ? selectedDobUs
                                  : selectedDob,
                              // widget.currentUserData.dob,
                              style: const TextStyle(color: Colors.black)),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1.2),
                  Container(
                    height: 45,
                    margin: const EdgeInsets.only(left: 20, right: 19),
                    child: GestureDetector(
                      onTap: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              int selectedRadio = selectedGender.trim().isEmpty
                                  ? selectedGenderUs.contains('Female')
                                      ? 1
                                      : 2
                                  : selectedGender.contains('Female')
                                      ? 1
                                      : 2;
                              return AlertDialog(
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // List<Widget>.generate(2, (int index) {
                                          Row(
                                            children: [
                                              Radio<int>(
                                                value: 1,
                                                groupValue: selectedRadio,
                                                onChanged: (value) {
                                                  setState(() => selectedRadio =
                                                      value as int);
                                                },
                                              ),
                                              SizedBox(width: 20),
                                              Text('Female')
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio<int>(
                                                value: 2,
                                                groupValue: selectedRadio,
                                                onChanged: (value) {
                                                  setState(() => selectedRadio =
                                                      value as int);
                                                },
                                              ),
                                              SizedBox(width: 20),
                                              Text('Male')
                                            ],
                                          )
                                        ]
                                        // }),
                                        );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedGender = selectedRadio == 1
                                              ? "Female"
                                              : "Male";
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                ],
                              );
                            });
                        // showDialog(
                        //     context: context,
                        //     builder: (ctx) {
                        //       return AlertDialog(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(15)),
                        //         title: const Text(
                        //           'Gender',
                        //           style: TextStyle(
                        //               color: Colors.black,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 18),
                        //         ),
                        //         content: SizedBox(
                        //           height: 100,
                        //           child: Column(children: [
                        //             Row(
                        //               children: [
                        //                 Radio(
                        //                     value: 1,
                        //                     groupValue: _value,
                        //                     onChanged: (value) {
                        //                       setState(() {
                        //                         _value = 1;
                        //                       });
                        //                     }),
                        //                 const SizedBox(width: 20),
                        //                 const Text(
                        //                   'Female',
                        //                   style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 16),
                        //                 )
                        //               ],
                        //             ),
                        //             Row(
                        //               children: [
                        //                 Radio(
                        //                     value: 2,
                        //                     groupValue: _value,
                        //                     onChanged: (value) {
                        //                       setState(() {
                        //                         _value = 2;
                        //                       });
                        //                     }),
                        //                 const SizedBox(width: 20),
                        //                 const Text(
                        //                   'Male',
                        //                   style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 16),
                        //                 )
                        //               ],
                        //             ),
                        //           ]),
                        //         ),
                        //         actions: [
                        //           TextButton(
                        //               onPressed: () {
                        //                 setState(() {
                        //                   selectedGender =
                        //                       _value == 1 ? "Female" : "Male";
                        //                 });
                        //                 Navigator.of(context).pop();
                        //               },
                        //               child: const Text(
                        //                 'Submit',
                        //                 style: TextStyle(
                        //                     color: Colors.amber,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 18),
                        //               )),
                        //           TextButton(
                        //               onPressed: () {
                        //                 Navigator.of(context).pop();
                        //               },
                        //               child: const Text(
                        //                 'Cancel',
                        //                 style: TextStyle(
                        //                     color: Colors.amber,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 18),
                        //               )),
                        //         ],
                        //       );
                        //     });
                      },
                      child: Row(
                        children: [
                          const Text('Gender',
                              style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          Text(
                              selectedGender.trim().isEmpty
                                  ? selectedGenderUs
                                  : selectedGender,
                              // widget.currentUserData.gender,
                              style: const TextStyle(color: Colors.black)),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1.2),
                  Container(
                    height: 45,
                    margin: const EdgeInsets.only(left: 20, right: 19),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                title: const Text(
                                  'Address',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                content: SizedBox(
                                    height: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Change your address here!',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                depth: -3,
                                                color: Colors.white,
                                                border: NeumorphicBorder(
                                                    width: 0.5,
                                                    color:
                                                        ColorConstant.blue900),
                                                boxShape:
                                                    const NeumorphicBoxShape
                                                        .stadium(),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: getVerticalSize(13),
                                                  // bottom: getVerticalSize(8),
                                                  left: getHorizontalSize(15)),
                                              child: TextFormField(
                                                // initialValue: widget.currentUserData.about,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                                cursorHeight: 17,
                                                controller: addressController,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: "Address",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: getFontSize(
                                                      15,
                                                    ),
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                // onChanged: (val) {
                                                //   selectedAdress = val;
                                                // },
                                              ),
                                            )),
                                      ],
                                    )),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        selectedAddress =
                                            addressController.text;
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        // selectedAdress = '';
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                ],
                              );
                            });
                      },
                      child: Row(
                        children: const [
                          Text('Hometown',
                              style: TextStyle(color: Colors.grey)),
                          Spacer(),
                          Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 1.2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
