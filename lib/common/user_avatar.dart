import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../providers/info_providers.dart';

int getUserAvatarIndex(String userName) {
  if (userName.isEmpty) {
    return 0;
  }

  var digest = md5.convert(utf8.encode(userName));
  var value0 = digest.bytes[0] & 0xff;
  return (value0 % 8).abs();

  // var avatarCode = int.parse(
  //     md5.convert(utf8.encode(userName)).toString().substring(0, 2),
  //     radix: 16);
  // return avatarCode % 8;
}

Future<UserBasicModel> getUserFullData(BuildContext context, String userId) async {
  final result = Provider.of<InfoProviders>(context, listen: false);
  final data = await result.callCurrentUserProfileData(userId);
  return data;
}
