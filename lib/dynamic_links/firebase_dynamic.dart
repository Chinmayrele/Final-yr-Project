import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../usernames/newuser.dart';

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

class FirebaseDynamicLinkService {
  static Future<void> initDynamicLinks(BuildContext context) async {
    debugPrint("I have Reached here!!!");
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      debugPrint("LINKDATA: ${dynamicLinkData.link}");
      debugPrint("LINKDATA002: ${dynamicLinkData.link.path}");
      final Uri deepLink = dynamicLinkData.link;
      // var isStory = deepLink.pathSegments.contains('lolProfile');
      // if (isStory) {
      String? id = deepLink.queryParameters['id'];
      final data =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
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

      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => OtherUser(otherUserData: userData)));
      // }
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      debugPrint('onLink error');
      debugPrint(error.toString());
    });
  }
}
