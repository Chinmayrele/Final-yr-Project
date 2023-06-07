import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../model/zego_user_info.dart';

class InfoProviders with ChangeNotifier {
  // final UserBasicModel userData;
  final List<UserBasicModel> _usersData = [];
  final List<UserBasicModel> _usersDataByIds = [];
  final List<UserBasicModel> _usersProfileData = [];
  final List<UserBasicModel> _usersProfileDataforGifts = [];

  List<UserBasicModel> get usersData => [..._usersData];
  List<UserBasicModel> get usersDataByIds => [..._usersDataByIds];
  List<UserBasicModel> get usersProfileData => [..._usersProfileData];
  List<UserBasicModel> get usersProfileDataforGifts =>
      [..._usersProfileDataforGifts];

  late UserBasicModel curUserData;

  Future<UserBasicModel?> callCurrentUserData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final e = data.data();
    final userData = UserBasicModel(
      userId: e!['userId'],
      name: e['name'],
      dob: e['dateBirth'],
      gender: e['gender'],
      imageUrl: e['imageUrl'],
      coverImage: e['coverImage'],
      about: e['about'],
      address: e['address'],
      status: e['status'],
      frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
    );
    curUserData = userData;
    return userData;
  }

  Future<void> fetchUsersProfileData(List<dynamic> listData) async {
    _usersProfileData.clear();
    for (int i = 0; i < listData.length; i++) {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(listData[i])
          .get();
      final e = data.data();
      final userData = UserBasicModel(
        userId: e!['userId'],
        name: e['name'],
        dob: e['dateBirth'],
        gender: e['gender'],
        imageUrl: e['imageUrl'],
        coverImage: e['coverImage'],
        about: e['about'],
        address: e['address'],
        status: e['status'],
        frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
      );
      _usersProfileData.add(userData);
    }
    notifyListeners();
  }

  Future<void> fetchUsersProfileDataforGifts(
      List<ZegoUserInfo> listData) async {
    _usersProfileDataforGifts.clear();
    for (int i = 0; i < listData.length; i++) {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(listData[i].userID)
          .get();
      final e = data.data();
      final userData = UserBasicModel(
        userId: e!['userId'],
        name: e['name'],
        dob: e['dateBirth'],
        gender: e['gender'],
        imageUrl: e['imageUrl'],
        coverImage: e['coverImage'],
        about: e['about'],
        address: e['address'],
        status: e['status'],
        frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
      );
      _usersProfileDataforGifts.add(userData);
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> callCurrentUserFollowData(String userId) async {
    final data = await FirebaseFirestore.instance
        .collection('followList')
        .doc(userId)
        .get();
    final e = data.data();
    return e as Map<String, dynamic>;
  }

  Future<UserBasicModel> callCurrentUserProfileData(String userId) async {
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final e = data.data();
    debugPrint("FRONT UID: ${e!['frontUid']}");
    final userData = UserBasicModel(
      userId: e['userId'],
      name: e['name'],
      dob: e['dateBirth'],
      gender: e['gender'],
      imageUrl: e['imageUrl'],
      coverImage: e['coverImage'],
      about: e['about'],
      address: e['address'],
      status: e['status'],
      frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
    );
    return userData;
  }

  Future<void> fetchUserData(
      Map<String, dynamic> listData, String typeFollow) async {
    _usersData.clear();
    final followLists = (listData[typeFollow] as List);
    // print("LENGTH OF FOLLOWING LIST: ${followLists.length}");
    for (int i = 0; i < followLists.length; i++) {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(followLists[i].toString())
          .get();
      final e = data.data();
      // debugPrint("VALUE OF E DATA: ${e!['name']}");
      // for (int i = 0; i < (e!['following'] as List).length; i++) {
      final singleData = UserBasicModel(
        userId: e!['userId'],
        name: e['name'],
        dob: e['dateBirth'],
        gender: e['gender'],
        imageUrl: e['imageUrl'],
        coverImage: e['coverImage'],
        about: e['about'],
        address: e['address'],
        status: e['status'],
        frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
      );
      _usersData.add(singleData);
    }
    notifyListeners();
  }

  Future<UserBasicModel> fetchUserModelData(String userId) async {
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final e = data.data();
    final singleDataUser = UserBasicModel(
      userId: e!['userId'],
      name: e['name'],
      dob: e['dateBirth'],
      gender: e['gender'],
      imageUrl: e['imageUrl'],
      coverImage: e['coverImage'],
      about: e['about'],
      address: e['address'],
      status: e['status'],
      frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
    );
    return singleDataUser;
  }

  Future<void> fetchUserDataByIds(List<dynamic> listData) async {
    _usersDataByIds.clear();
    // print("LENGTH OF FOLLOWING LIST: ${followLists.length}");
    for (int i = 0; i < listData.length; i++) {
      final data = await FirebaseFirestore.instance
          .collection('users')
          .doc(listData[i])
          .get();
      final e = data.data();
      // debugPrint("VALUE OF E DATA: ${e!['name']}");
      // for (int i = 0; i < (e!['following'] as List).length; i++) {
      final singleData = UserBasicModel(
        userId: e!['userId'],
        name: e['name'],
        dob: e['dateBirth'],
        gender: e['gender'],
        imageUrl: e['imageUrl'],
        coverImage: e['coverImage'],
        about: e['about'],
        address: e['address'],
        status: e['status'],
        frontUid: e['frontUid'],
      likesOnMe: e['likesOnMe'],
      );
      _usersDataByIds.add(singleData);
      debugPrint("SINGLE DATA VALUE: ${singleData.dob}");
    }
    notifyListeners();
  }

  Future<void> saveProfileChanges(
    String selectedName,
    String selectedImage,
    String selectedGender,
    String selectedAddress,
    String selectedBio,
    String selectedDob,
    String selectedCoverImage,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "name": selectedName,
      "imageUrl": selectedImage,
      "gender": selectedGender,
      "address": selectedAddress,
      "about": selectedBio,
      "dateBirth": selectedDob,
      "coverImage": selectedCoverImage,
      "status": "Online",
    });
    curUserData.name = selectedName;
    curUserData.imageUrl = selectedImage;
    curUserData.gender = selectedGender;
    curUserData.address = selectedAddress;
    curUserData.dob = selectedDob;
    curUserData.coverImage = selectedCoverImage;
    curUserData.about = selectedBio;
    curUserData.status = "Online";
    notifyListeners();
  }
}
