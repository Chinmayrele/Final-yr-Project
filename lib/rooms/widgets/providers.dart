import 'package:flutter/material.dart';

class Provid with ChangeNotifier {
  bool invite = false;
  String imageAssetUrl = '';
  bool isDisabled = false;
  // ImageConstant.img1dhckghtzdumti;
  void changeImage(String imageAsset) {
    imageAssetUrl = imageAsset;
    notifyListeners();
  }

  toggleMicProv() {}

  didInvite() {
    invite = true;
    notifyListeners();
  }

  isMsgDisabled(bool isDisabled) {
    isDisabled = !isDisabled;
    notifyListeners();
  }

  bool isMsgDisValue() {
    return isDisabled;
  }
}
