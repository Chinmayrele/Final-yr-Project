// import 'live_audio_room_localizations.dart';


import 'localisation.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ZegoLiveAudio';

  @override
  String get loginPageTitle => 'ZEGOCLOUD\nLive Audio Room';

  @override
  String get loginPageUserId => 'User ID';

  @override
  String get loginPageUserName => 'User name';

  @override
  String get loginPageLogin => 'Log In';

  @override
  String get toastUseridLoginFail => 'Please enter your user ID.';

  @override
  String get toastUserIdError => 'User ID can only contain letters and numbers.';

  @override
  String toastLoginFail(int code) {
    return 'Failed to log in. Error code: $code.';
  }

  @override
  String get toastKickoutError => 'This account has already logged in from another device.';

  @override
  String get createPageRoomId => 'Room ID';

  @override
  String get createPageRoomName => 'Room name';

  @override
  String get createPageOr => 'OR';

  @override
  String get createPageCreateRoom => 'Create room';

  @override
  String get createPageJoinRoom => 'Join room';

  @override
  String get createPageCancel => 'Cancel';

  @override
  String get createPageCreate => 'Create';

  @override
  String get toastRoomIdEnterError => 'Please enter the room ID.';

  @override
  String get toastRoomNotExistFail => 'This room does not exist. Please check the room ID or create a new one.';

  @override
  String get toastRoomExisted => 'Failed to create room, because the room already exists.';

  @override
  String get toastRoomNameError => 'Please enter the room name.';

  @override
  String get toastCreateRoomSuccess => 'Room created successfully. Join the room now.';

  @override
  String toastJoinRoomFail(int code) {
    return 'Failed to join the room. Error code: $code.';
  }

  @override
  String toastCreateRoomFail(int code) {
    return 'Failed to create a room. Error code: $code.';
  }

  @override
  String get settingPageSettings => 'Settings';

  @override
  String get settingPageSdkVersion => 'Express SDK Version';

  @override
  String get settingPageZimSdkVersion => 'ZIM SDK Version';

  @override
  String get settingPageVersion => 'APP Version';

  @override
  String get settingPageTermsOfService => 'Terms of service';

  @override
  String get settingPagePrivacyPolicy => 'Privacy Policy';

  @override
  String get settingPageUploadLog => 'Upload logs';

  @override
  String get toastUploadLogSuccess => 'Logs uploaded successfully.';

  @override
  String toastUploadLogFail(int code) {
    return 'Failed to upload logs. Error code: $code.';
  }

  @override
  String get settingPageLogout => 'Log out';

  @override
  String toastLogoutFail(int code) {
    return 'Failed to log out. Error code: $code.';
  }

  @override
  String get roomPageHost => 'Host';

  @override
  String get networkReconnect => 'Network error. Reconnecting...';

  @override
  String get roomTipsReconnect => 'Network connection failed. Reconnect?';

  @override
  String get networkConnectFailed => 'Network connection failed. Please log out and join again.';

  @override
  String get networkConnectFailedTitle => 'Network error';

  @override
  String get toastDisconnectTips => 'You are disconnected from the room. Please join again.';

  @override
  String get dialogTipsTitle => 'Tips';

  @override
  String get roomPageMicCantOpen => 'The Mic is off.';

  @override
  String get roomPageGrantMicPermission => 'Please allow access to your microphone to continue.';

  @override
  String get roomPageGoToSettings => 'Go to Settings';

  @override
  String get roomPageCancel => 'Cancel';

  @override
  String roomPageUserList(int num) {
    return 'Participants ($num)';
  }

  @override
  String get roomPageInviteTakeSeat => 'Invite to speak';

  @override
  String get roomPageRoleSpeaker => 'Speaker';

  @override
  String get roomPageRoleOwner => 'Owner';

  @override
  String get roomPageSettings => 'Settings';

  @override
  String get roomPageLeaveSeat => 'Leave the seat';

  @override
  String get roomPageSetTakeSeat => 'Close all untaken speaker seats';

  @override
  String get roomPageSetSilence => 'Disable text chat for all';

  @override
  String get roomPageHasLeftTheRoom => '%@ left the room';

  @override
  String get roomPageJoinedTheRoom => '%@ joined the room';

  @override
  String toastSendMessageError(int code) {
    return 'Failed to send message. Error code: $code.';
  }

  @override
  String get roomPageSendMessage => 'Send';

  @override
  String get roomPageBandsSendMessage => 'The host has disabled text chat for everyone.';

  @override
  String toastLockSeatError(int code) {
    return 'Failed to lock the seat. Error code: $code.';
  }

  @override
  String toastMuteMessageError(int code) {
    return 'Failed to mute message. Error code:$code.';
  }

  @override
  String get toastDisableTextChatSuccess => 'Disabled text chat successfully.';

  @override
  String get toastAllowTextChatSuccess => 'Allow text chat successfully.';

  @override
  String get toastDisableTextChatTips => 'The host has disabled text chat for everyone.';

  @override
  String get toastAllowTextChatTips => 'The host has allowed text chat for everyone.';

  @override
  String get roomPageGift => 'Gifts';

  @override
  String get roomPageSelectAllSpeakers => 'All speakers';

  @override
  String get roomPageGiftNoSpeaker => 'No other speakers';

  @override
  String get roomPageSelectDefault => 'Choose a speaker';

  @override
  String get roomPageSendGift => 'Send';

  @override
  String toastSendGiftError(int code) {
    return 'Failed to send gift. Error code:$code.';
  }

  @override
  String roomPageReceivedGiftTips(String nameA, String giftName, String nameB) {
    return '$nameA received $giftName from $nameB';
  }

  @override
  String get roomPageGiftHeart => 'DIAMOND';

  @override
  String get roomPageLockSeat => 'Close seat';

  @override
  String get roomPageUnlockSeat => 'Open seat';

  @override
  String get dialogMicOprationMessage => 'We need to use your mic to help you join the voice interaction.';

  @override
  String toastUnlockSeatFail(int code) {
    return 'Failed to open the seat. Error code: $code.';
  }

  @override
  String toastLockSeatFail(int code) {
    return 'Failed to close the seat. Error code: $code.';
  }

  @override
  String get toastLockSeatAlreadyTakeSeat => 'Failed to close the seat. A speaker has already take the seat.';

  @override
  String get roomPageLeaveSpeakerSeat => 'Leave seat';

  @override
  String roomPageLeaveSpeakerSeatDesc(String name) {
    return 'Remove $name from the speaker seat?';
  }

  @override
  String get dialogConfirm => 'OK';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String toastKickoutLeaveSeatError(String name, int code) {
    return 'Failed to remove $name from the speaker seat. Error code: $code.';
  }

  @override
  String get roomPageInvitationHasSent => 'Invitation sent.';

  @override
  String get roomPageNoMoreSeatAvailable => 'No speaker seats available at the moment. Please try again later.';

  @override
  String get dialogInvitionTitle => 'Invitation';

  @override
  String get dialogInvitionDescrip => 'The host has invited you to speak.';

  @override
  String get dialogRefuse => 'Decline';

  @override
  String get dialogAccept => 'Accept';

  @override
  String toastToBeASpeakerSeatFail(int code) {
    return 'Failed to connect. Error code: $code.';
  }

  @override
  String get roomPageTakeSeat => 'Take the seat';

  @override
  String toastTakeSpeakerSeatFail(int code) {
    return 'Failed to take the speaker seat. Error code: $code.';
  }

  @override
  String get thisSeatHasBeenClosed => 'This seat has been closed.';

  @override
  String get dialogSureToLeaveSeat => 'Are you sure to leave the seat?';

  @override
  String toastLeaveSeatFail(int code) {
    return 'Failed to leave the speaker seat. Error code: $code.';
  }

  @override
  String get roomPageDestroyRoom => 'End room';

  @override
  String get dialogSureToDestroyRoom => 'End the room now?';

  @override
  String get toastRoomHasDestroyed => 'This room has ended.';

  @override
  String toastRoomLeaveFailTip(int code) {
    return 'Failed to leave the room. Error code: $code.';
  }

  @override
  String toastRoomEndFailTip(int code) {
    return 'Failed to end the room. Error code: $code.';
  }
}
