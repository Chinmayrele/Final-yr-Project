import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

import '../../common/utf8_text_formatter.dart';
import '../../localization/localisation.dart';
import '../../util/secret_reader.dart';
import '../../service/zego_user_service.dart';
import '../../common/style/styles.dart';
import '../../model/zego_user_info.dart';
import '../../service/zego_room_manager.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);
  // static final RegExp userIDRegExp = RegExp('[a-zA-Z0-9]{1,20}');
  // static String userRandomID = Random().nextInt(1000).toString();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: _mainWidget(context),
    );
  }

  Widget _mainWidget(BuildContext context) {
    // Init SDK
    useEffect(() {
      SecretReader.instance.loadKeyCenterData().then((_) {
        // WARNING: DO NOT USE APPID AND APPSIGN IN PRODUCTION CODE!!!GET IT FROM SERVER INSTEAD!!!
        ZegoRoomManager.shared.initWithAPPID(SecretReader.instance.appID,
            SecretReader.instance.serverSecret, (_) => null);
      });
    }, const []);

    final userIdInputController = useTextEditingController();
    final userNameInputController = useTextEditingController();

    //  user id binding by device name
    // final deviceName = useState('Apple' + userRandomID);
    // userIdInputController.text = deviceName.value;
    // if (Platform.isAndroid) {
    //   DeviceInfo().readDeviceName().then((value) {
    //     deviceName.value = value + userRandomID;
    //   });
    // }

    // title

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    Container(
              margin: EdgeInsets.only(
                  left: 74.w, top: 100.h, right: /*94*/ 0, bottom: 70.h),
              child: Column(children: [
                Row(
                  children: const [
                    Text("LOL",
                        style: StyleConstant.loginTitle,
                        textAlign: TextAlign.left),
                     Expanded(child: Text(''))
                  ],
                ),
                Row(
                  children: const [
                    Text("Room",
                        style: StyleConstant.loginTitle,
                        textAlign: TextAlign.left),
                     Expanded(child: Text(''))
                  ],
                ),
              ])),
                    Container(
                      margin:
                EdgeInsets.only(left: 60.w, top: 0, right: 60.w, bottom: 536.h),
                      child: Column(
              children: [
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  style: StyleConstant.loginTextInput,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      counterText: '',
                      hintStyle: StyleConstant.loginTextInputHintStyle,
                      hintText: AppLocalizations.of(context)!.loginPageUserId),
                  controller: userIdInputController,
                ),
                SizedBox(height: 49.h),
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                    Utf8LengthLimitingTextInputFormatter(32),
                  ],
                  style: StyleConstant.loginTextInput,
                  decoration: InputDecoration(
                      counterText: '',
                      hintStyle: StyleConstant.loginTextInputHintStyle,
                      hintText: AppLocalizations.of(context)!.loginPageUserName),
                  controller: userNameInputController,
                ),
                SizedBox(
                  height: 70.h,
                ),
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.loginPageLogin),
                  style: ElevatedButton.styleFrom(
                    primary: StyleColors.blueButtonEnabledColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    minimumSize: Size(630.w, 98.h),
                  ),
                  onPressed: () {
                    // if (userIdInputController.text.isEmpty) {
                    //   Fluttertoast.showToast(
                    //       msg: AppLocalizations.of(context)!.toastUseridLoginFail,
                    //       backgroundColor: Colors.grey);
                    //   return;
                    // }
                    // if (!userIDRegExp.hasMatch(userIdInputController.text)) {
                    //   Fluttertoast.showToast(
                    //       msg: AppLocalizations.of(context)!.toastUserIdError,
                    //       backgroundColor: Colors.grey);
                    //   return;
                    // }
            
                    ZegoUserInfo info = ZegoUserInfo.empty();
                    info.userID = userIdInputController.text;
                    info.userName = userNameInputController.text;
                    if (info.userName.isEmpty) {
                      info.userName = info.userID;
                    }
                    var userModel = context.read<ZegoUserService>();
                    userModel.login(info, "").then((errorCode) {
                      if (errorCode != 0) {
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!
                                .toastLoginFail(errorCode),
                            backgroundColor: Colors.grey);
                      } else {
                        Navigator.pushReplacementNamed(context, '/room_entrance');
                      }
                    });
                  },
                )
              ],
                      ),
                    ),
                  ],
                ),
            )));
  }
}
