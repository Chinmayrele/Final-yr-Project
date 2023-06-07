import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setVisitingFlag({
  bool isLoginDone = false,
  bool isProfileDone = false,
  // bool isLocDone = false,
  // bool isPermiLocGiven = false,
}) async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  String? alreadyVisited = sharedPreference.getString('alreadyVisitedUser');
  Map<String, dynamic> mp;
  if (alreadyVisited == null) {
    mp = {
      "isProfileDone": isProfileDone,
      "isLoginDone": isLoginDone,
      // "isLocDone": isLocDone,
      // "isLocAccesGiven": isPermiLocGiven,
    };
  } else {
    mp = json.decode(alreadyVisited);
    // if (isProfileDone)
    mp['isProfileDone'] = isProfileDone;
    // if (isLoginDone)
    mp['isLoginDone'] = isLoginDone;
    // if (isLocDone)
    // mp['isLocDone'] = isLocDone;
    // if (isQueAnsDone)
    // mp['isLocAccesGiven'] = isPermiLocGiven;
  }

  String setString = json.encode(mp);
  await sharedPreference.setString('alreadyVisitedUser', setString);
}

Future<String> getVisitingFlag() async {
  SharedPreferences sharePreference = await SharedPreferences.getInstance();
  String alreadyVisited = sharePreference.getString('alreadyVisitedUser') ?? '';

  return alreadyVisited;
}
