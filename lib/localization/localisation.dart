import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'locali_en.dart';
import 'locali_zh.dart';


/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/live_audio_room_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ZegoLiveAudio'**
  String get appName;

  /// No description provided for @loginPageTitle.
  ///
  /// In en, this message translates to:
  /// **'ZEGOCLOUD\nLive Audio Room'**
  String get loginPageTitle;

  /// No description provided for @loginPageUserId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get loginPageUserId;

  /// No description provided for @loginPageUserName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get loginPageUserName;

  /// No description provided for @loginPageLogin.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginPageLogin;

  /// No description provided for @toastUseridLoginFail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your user ID.'**
  String get toastUseridLoginFail;

  /// No description provided for @toastUserIdError.
  ///
  /// In en, this message translates to:
  /// **'User ID can only contain letters and numbers.'**
  String get toastUserIdError;

  /// No description provided for @toastLoginFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to log in. Error code: {code}.'**
  String toastLoginFail(int code);

  /// No description provided for @toastKickoutError.
  ///
  /// In en, this message translates to:
  /// **'This account has already logged in from another device.'**
  String get toastKickoutError;

  /// No description provided for @createPageRoomId.
  ///
  /// In en, this message translates to:
  /// **'Room ID'**
  String get createPageRoomId;

  /// No description provided for @createPageRoomName.
  ///
  /// In en, this message translates to:
  /// **'Room name'**
  String get createPageRoomName;

  /// No description provided for @createPageOr.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get createPageOr;

  /// No description provided for @createPageCreateRoom.
  ///
  /// In en, this message translates to:
  /// **'Create room'**
  String get createPageCreateRoom;

  /// No description provided for @createPageJoinRoom.
  ///
  /// In en, this message translates to:
  /// **'Join room'**
  String get createPageJoinRoom;

  /// No description provided for @createPageCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get createPageCancel;

  /// No description provided for @createPageCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createPageCreate;

  /// No description provided for @toastRoomIdEnterError.
  ///
  /// In en, this message translates to:
  /// **'Please enter the room ID.'**
  String get toastRoomIdEnterError;

  /// No description provided for @toastRoomNotExistFail.
  ///
  /// In en, this message translates to:
  /// **'This room does not exist. Please check the room ID or create a new one.'**
  String get toastRoomNotExistFail;

  /// No description provided for @toastRoomExisted.
  ///
  /// In en, this message translates to:
  /// **'Failed to create room, because the room already exists.'**
  String get toastRoomExisted;

  /// No description provided for @toastRoomNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter the room name.'**
  String get toastRoomNameError;

  /// No description provided for @toastCreateRoomSuccess.
  ///
  /// In en, this message translates to:
  /// **'Room created successfully. Join the room now.'**
  String get toastCreateRoomSuccess;

  /// No description provided for @toastJoinRoomFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to join the room. Error code: {code}.'**
  String toastJoinRoomFail(int code);

  /// No description provided for @toastCreateRoomFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to create a room. Error code: {code}.'**
  String toastCreateRoomFail(int code);

  /// No description provided for @settingPageSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingPageSettings;

  /// No description provided for @settingPageSdkVersion.
  ///
  /// In en, this message translates to:
  /// **'Express SDK Version'**
  String get settingPageSdkVersion;

  /// No description provided for @settingPageZimSdkVersion.
  ///
  /// In en, this message translates to:
  /// **'ZIM SDK Version'**
  String get settingPageZimSdkVersion;

  /// No description provided for @settingPageVersion.
  ///
  /// In en, this message translates to:
  /// **'APP Version'**
  String get settingPageVersion;

  /// No description provided for @settingPageTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get settingPageTermsOfService;

  /// No description provided for @settingPagePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingPagePrivacyPolicy;

  /// No description provided for @settingPageUploadLog.
  ///
  /// In en, this message translates to:
  /// **'Upload logs'**
  String get settingPageUploadLog;

  /// No description provided for @toastUploadLogSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logs uploaded successfully.'**
  String get toastUploadLogSuccess;

  /// No description provided for @toastUploadLogFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload logs. Error code: {code}.'**
  String toastUploadLogFail(int code);

  /// No description provided for @settingPageLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingPageLogout;

  /// No description provided for @toastLogoutFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to log out. Error code: {code}.'**
  String toastLogoutFail(int code);

  /// No description provided for @roomPageHost.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get roomPageHost;

  /// No description provided for @networkReconnect.
  ///
  /// In en, this message translates to:
  /// **'Network error. Reconnecting...'**
  String get networkReconnect;

  /// No description provided for @roomTipsReconnect.
  ///
  /// In en, this message translates to:
  /// **'Network connection failed. Reconnect?'**
  String get roomTipsReconnect;

  /// No description provided for @networkConnectFailed.
  ///
  /// In en, this message translates to:
  /// **'Network connection failed. Please log out and join again.'**
  String get networkConnectFailed;

  /// No description provided for @networkConnectFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get networkConnectFailedTitle;

  /// No description provided for @toastDisconnectTips.
  ///
  /// In en, this message translates to:
  /// **'You are disconnected from the room. Please join again.'**
  String get toastDisconnectTips;

  /// No description provided for @dialogTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get dialogTipsTitle;

  /// No description provided for @roomPageMicCantOpen.
  ///
  /// In en, this message translates to:
  /// **'The Mic is off.'**
  String get roomPageMicCantOpen;

  /// No description provided for @roomPageGrantMicPermission.
  ///
  /// In en, this message translates to:
  /// **'Please allow access to your microphone to continue.'**
  String get roomPageGrantMicPermission;

  /// No description provided for @roomPageGoToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get roomPageGoToSettings;

  /// No description provided for @roomPageCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get roomPageCancel;

  /// No description provided for @roomPageUserList.
  ///
  /// In en, this message translates to:
  /// **'Participants ({num})'**
  String roomPageUserList(int num);

  /// No description provided for @roomPageInviteTakeSeat.
  ///
  /// In en, this message translates to:
  /// **'Invite to speak'**
  String get roomPageInviteTakeSeat;

  /// No description provided for @roomPageRoleSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Speaker'**
  String get roomPageRoleSpeaker;

  /// No description provided for @roomPageRoleOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get roomPageRoleOwner;

  /// No description provided for @roomPageSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get roomPageSettings;

  /// No description provided for @roomPageLeaveSeat.
  ///
  /// In en, this message translates to:
  /// **'Leave the seat'**
  String get roomPageLeaveSeat;

  /// No description provided for @roomPageSetTakeSeat.
  ///
  /// In en, this message translates to:
  /// **'Close all untaken speaker seats'**
  String get roomPageSetTakeSeat;

  /// No description provided for @roomPageSetSilence.
  ///
  /// In en, this message translates to:
  /// **'Disable text chat for all'**
  String get roomPageSetSilence;

  /// No description provided for @roomPageHasLeftTheRoom.
  ///
  /// In en, this message translates to:
  /// **'%@ left the room'**
  String get roomPageHasLeftTheRoom;

  /// No description provided for @roomPageJoinedTheRoom.
  ///
  /// In en, this message translates to:
  /// **'%@ joined the room'**
  String get roomPageJoinedTheRoom;

  /// No description provided for @toastSendMessageError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message. Error code: {code}.'**
  String toastSendMessageError(int code);

  /// No description provided for @roomPageSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get roomPageSendMessage;

  /// No description provided for @roomPageBandsSendMessage.
  ///
  /// In en, this message translates to:
  /// **'The host has disabled text chat for everyone.'**
  String get roomPageBandsSendMessage;

  /// No description provided for @toastLockSeatError.
  ///
  /// In en, this message translates to:
  /// **'Failed to lock the seat. Error code: {code}.'**
  String toastLockSeatError(int code);

  /// No description provided for @toastMuteMessageError.
  ///
  /// In en, this message translates to:
  /// **'Failed to mute message. Error code:{code}.'**
  String toastMuteMessageError(int code);

  /// No description provided for @toastDisableTextChatSuccess.
  ///
  /// In en, this message translates to:
  /// **'Disabled text chat successfully.'**
  String get toastDisableTextChatSuccess;

  /// No description provided for @toastAllowTextChatSuccess.
  ///
  /// In en, this message translates to:
  /// **'Allow text chat successfully.'**
  String get toastAllowTextChatSuccess;

  /// No description provided for @toastDisableTextChatTips.
  ///
  /// In en, this message translates to:
  /// **'The host has disabled text chat for everyone.'**
  String get toastDisableTextChatTips;

  /// No description provided for @toastAllowTextChatTips.
  ///
  /// In en, this message translates to:
  /// **'The host has allowed text chat for everyone.'**
  String get toastAllowTextChatTips;

  /// No description provided for @H.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get roomPageGift;

  /// No description provided for @roomPageSelectAllSpeakers.
  ///
  /// In en, this message translates to:
  /// **'All speakers'**
  String get roomPageSelectAllSpeakers;

  /// No description provided for @roomPageGiftNoSpeaker.
  ///
  /// In en, this message translates to:
  /// **'No other speakers'**
  String get roomPageGiftNoSpeaker;

  /// No description provided for @roomPageSelectDefault.
  ///
  /// In en, this message translates to:
  /// **'Choose a speaker'**
  String get roomPageSelectDefault;

  /// No description provided for @roomPageSendGift.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get roomPageSendGift;

  /// No description provided for @toastSendGiftError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send gift. Error code:{code}.'**
  String toastSendGiftError(int code);

  /// No description provided for @roomPageReceivedGiftTips.
  ///
  /// In en, this message translates to:
  /// **'{nameA} received {giftName} from {nameB}'**
  String roomPageReceivedGiftTips(String nameA, String giftName, String nameB);

  /// No description provided for @roomPageGiftHeart.
  ///
  /// In en, this message translates to:
  /// **'HEART'**
  String get roomPageGiftHeart;

  /// No description provided for @roomPageLockSeat.
  ///
  /// In en, this message translates to:
  /// **'Close seat'**
  String get roomPageLockSeat;

  /// No description provided for @roomPageUnlockSeat.
  ///
  /// In en, this message translates to:
  /// **'Open seat'**
  String get roomPageUnlockSeat;

  /// No description provided for @dialogMicOprationMessage.
  ///
  /// In en, this message translates to:
  /// **'We need to use your mic to help you join the voice interaction.'**
  String get dialogMicOprationMessage;

  /// No description provided for @toastUnlockSeatFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to open the seat. Error code: {code}.'**
  String toastUnlockSeatFail(int code);

  /// No description provided for @toastLockSeatFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to close the seat. Error code: {code}.'**
  String toastLockSeatFail(int code);

  /// No description provided for @toastLockSeatAlreadyTakeSeat.
  ///
  /// In en, this message translates to:
  /// **'Failed to close the seat. A speaker has already take the seat.'**
  String get toastLockSeatAlreadyTakeSeat;

  /// No description provided for @roomPageLeaveSpeakerSeat.
  ///
  /// In en, this message translates to:
  /// **'Leave seat'**
  String get roomPageLeaveSpeakerSeat;

  /// No description provided for @roomPageLeaveSpeakerSeatDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the speaker seat?'**
  String roomPageLeaveSpeakerSeatDesc(String name);

  /// No description provided for @dialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get dialogConfirm;

  /// No description provided for @dialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogCancel;

  /// No description provided for @toastKickoutLeaveSeatError.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove {name} from the speaker seat. Error code: {code}.'**
  String toastKickoutLeaveSeatError(String name, int code);

  /// No description provided for @roomPageInvitationHasSent.
  ///
  /// In en, this message translates to:
  /// **'Invitation sent.'**
  String get roomPageInvitationHasSent;

  /// No description provided for @roomPageNoMoreSeatAvailable.
  ///
  /// In en, this message translates to:
  /// **'No speaker seats available at the moment. Please try again later.'**
  String get roomPageNoMoreSeatAvailable;

  /// No description provided for @dialogInvitionTitle.
  ///
  /// In en, this message translates to:
  /// **'Invitation'**
  String get dialogInvitionTitle;

  /// No description provided for @dialogInvitionDescrip.
  ///
  /// In en, this message translates to:
  /// **'The host has invited you to speak.'**
  String get dialogInvitionDescrip;

  /// No description provided for @dialogRefuse.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get dialogRefuse;

  /// No description provided for @dialogAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get dialogAccept;

  /// No description provided for @toastToBeASpeakerSeatFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect. Error code: {code}.'**
  String toastToBeASpeakerSeatFail(int code);

  /// No description provided for @roomPageTakeSeat.
  ///
  /// In en, this message translates to:
  /// **'Take the seat'**
  String get roomPageTakeSeat;

  /// No description provided for @toastTakeSpeakerSeatFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to take the speaker seat. Error code: {code}.'**
  String toastTakeSpeakerSeatFail(int code);

  /// No description provided for @thisSeatHasBeenClosed.
  ///
  /// In en, this message translates to:
  /// **'This seat has been closed.'**
  String get thisSeatHasBeenClosed;

  /// No description provided for @dialogSureToLeaveSeat.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to leave the seat?'**
  String get dialogSureToLeaveSeat;

  /// No description provided for @toastLeaveSeatFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to leave the speaker seat. Error code: {code}.'**
  String toastLeaveSeatFail(int code);

  /// No description provided for @roomPageDestroyRoom.
  ///
  /// In en, this message translates to:
  /// **'End room'**
  String get roomPageDestroyRoom;

  /// No description provided for @dialogSureToDestroyRoom.
  ///
  /// In en, this message translates to:
  /// **'End the room now?'**
  String get dialogSureToDestroyRoom;

  /// No description provided for @toastRoomHasDestroyed.
  ///
  /// In en, this message translates to:
  /// **'This room has ended.'**
  String get toastRoomHasDestroyed;

  /// No description provided for @toastRoomLeaveFailTip.
  ///
  /// In en, this message translates to:
  /// **'Failed to leave the room. Error code: {code}.'**
  String toastRoomLeaveFailTip(int code);

  /// No description provided for @toastRoomEndFailTip.
  ///
  /// In en, this message translates to:
  /// **'Failed to end the room. Error code: {code}.'**
  String toastRoomEndFailTip(int code);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
