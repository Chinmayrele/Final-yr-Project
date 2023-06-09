import 'dart:io';

import 'package:final_yr_project/providers/info_providers.dart';
import 'package:final_yr_project/roompages/room/room_main_page.dart';
import 'package:final_yr_project/roompages/settings/settings_page.dart';
import 'package:final_yr_project/rooms/widgets/providers.dart';
import 'package:final_yr_project/service/zego_loading_service.dart';
import 'package:final_yr_project/service/zego_room_manager.dart';
import 'package:final_yr_project/service/zego_speaker_seat_service.dart';
import 'package:final_yr_project/service/zego_user_service.dart';
import 'package:final_yr_project/splash.dart';
import 'package:final_yr_project/trial02.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'package:wakelock/wakelock.dart';

import 'common/style/styles.dart';
import 'constants/zego_page_constant.dart';
import 'localization/localisation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(const MyApp());
  FlutterBugly.init(
    androidAppId: "",
    iOSAppId: "",
    // androidAppId: "6c4f086570",
    // iOSAppId: "086cd4eca3",
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable(); //  always bright
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top
    ]); //  hide status bar and bottom navigation bar

    if (Platform.isAndroid) {
      supportAndroidRunBackground();
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Provid()),
          ChangeNotifierProvider(create: (context) => InfoProviders()),
          ChangeNotifierProvider(
              create: (context) => ZegoRoomManager.shared.roomService),
          ChangeNotifierProvider(
              create: (context) => ZegoRoomManager.shared.speakerSeatService),
          ChangeNotifierProvider(
              create: (context) => ZegoRoomManager.shared.userService),
          ChangeNotifierProvider(
              create: (context) => ZegoRoomManager.shared.giftService),
          ChangeNotifierProvider(
              create: (context) => ZegoRoomManager.shared.messageService),
          ChangeNotifierProvider(
              create: (context) => ZegoRoomManager.shared.loadingService),
          ChangeNotifierProxyProvider<ZegoSpeakerSeatService, ZegoUserService>(
            create: (context) => context.read<ZegoUserService>(),
            update: (_, seats, users) {
              if (users == null) throw ArgumentError.notNull('users');
              users.updateSpeakerSet(seats.speakerIDSet);
              return users;
            },
          ),
          ChangeNotifierProxyProvider<ZegoUserService, ZegoSpeakerSeatService>(
            create: (context) => context.read<ZegoSpeakerSeatService>(),
            update: (_, users, seats) {
              if (seats == null) throw ArgumentError.notNull('seats');
              // Note: Update localUserID before update hostID cause we will call takeSeat() after hostID updated.
              seats.updateUserIDSet(
                  users.userList.map((user) => user.userID).toSet());
              return seats;
            },
          ),
        ],
        child: GestureDetector(
          onTap: () {
            //  for hide keyboard when click on empty place of all pages
            hideKeyboard(context);
          },
          child: MediaQuery(
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
              child: ScreenUtilInit(
                designSize: const Size(750, 1334),
                minTextAdapt: true,
                builder: (BuildContext context, Widget? child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "ZegoLiveAudio",
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  // home: const Tttraaail(),
                  home: const MyAnimationScreen(),
                  // initialRoute: PageRouteNames.login,
                  routes: {
                    // PageRouteNames.splash: (context) => const MyAnimationScreen(),
                    // PageRouteNames.login: (context) => const LoginPage(),
                    PageRouteNames.settings: (context) => const SettingsPage(),
                    // PageRouteNames.roomEntrance: (context) =>
                    //     RoomEntrancePage(),
                    PageRouteNames.roomMain: (context) => roomMainLoadingPage(),
                  },
                ),
              )),
        ));
  }

  roomMainLoadingPage() {
    return Consumer<ZegoLoadingService>(
      builder: (context, loadingService, child) => LoaderOverlay(
        child: RoomMainPage(),
        useDefaultLoading: false,
        overlayColor: Colors.grey,
        overlayOpacity: 0.8,
        overlayWidget: SizedBox(
          width: 750.w,
          height: 1334.h,
          child: Center(
            child: Column(
              children: [
                const Expanded(child: Text('')),
                const CupertinoActivityIndicator(
                  radius: 14,
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.grey,
                  ),
                  child: Text(loadingService.loadingText(),
                      style: StyleConstant.loadingText),
                ),
                const Expanded(child: Text(''))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Future<void> supportAndroidRunBackground() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      var androidConfig = FlutterBackgroundAndroidConfig(
        notificationTitle: packageInfo.appName,
        notificationText: "Background notification for keeping " +
            packageInfo.appName +
            " running in the background",
        notificationImportance: AndroidNotificationImportance.Default,
        // notificationIcon: , // Default is ic_launcher from folder mipmap
      );

      await FlutterBackground.initialize(androidConfig: androidConfig)
          .then((value) {
        FlutterBackground.enableBackgroundExecution();
      });
    });
  }
}
