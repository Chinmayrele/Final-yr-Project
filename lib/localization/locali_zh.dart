// import 'live_audio_room_localizations.dart';


import 'localisation.dart';

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'ZegoLiveAudio';

  @override
  String get loginPageTitle => '欢迎体验\nZego 语聊房';

  @override
  String get loginPageUserId => '用户 ID';

  @override
  String get loginPageUserName => '用户名称';

  @override
  String get loginPageLogin => '登录';

  @override
  String get toastUseridLoginFail => '请填写用户 ID';

  @override
  String get toastUserIdError => 'User ID 应为数字或英文';

  @override
  String toastLoginFail(int code) {
    return '登录失败，错误码：$code';
  }

  @override
  String get toastKickoutError => '该帐号已在其他设备登录，你已被踢出';

  @override
  String get createPageRoomId => '房间 ID';

  @override
  String get createPageRoomName => '房间名称';

  @override
  String get createPageOr => '或者';

  @override
  String get createPageCreateRoom => '创建房间';

  @override
  String get createPageJoinRoom => '加入房间';

  @override
  String get createPageCancel => '取消';

  @override
  String get createPageCreate => '创建';

  @override
  String get toastRoomIdEnterError => '请填写房间 ID';

  @override
  String get toastRoomNotExistFail => '该房间不存在，请创建房间';

  @override
  String get toastRoomExisted => '创建房间失败，房间已存在';

  @override
  String get toastRoomNameError => '请填写房间名称';

  @override
  String get toastCreateRoomSuccess => '房间已被创建，请加入房间';

  @override
  String toastJoinRoomFail(int code) {
    return '加入房间失败，错误码：$code';
  }

  @override
  String toastCreateRoomFail(int code) {
    return '创建房间失败，错误码：$code';
  }

  @override
  String get settingPageSettings => '设置';

  @override
  String get settingPageSdkVersion => 'Express SDK 版本号';

  @override
  String get settingPageZimSdkVersion => 'ZIM SDK 版本号';

  @override
  String get settingPageVersion => 'App 版本号';

  @override
  String get settingPageTermsOfService => '服务条款';

  @override
  String get settingPagePrivacyPolicy => '隐私政策';

  @override
  String get settingPageUploadLog => '上传日志';

  @override
  String get toastUploadLogSuccess => '日志上传成功';

  @override
  String toastUploadLogFail(int code) {
    return '日志上传失败，错误码：$code';
  }

  @override
  String get settingPageLogout => '退出登录';

  @override
  String toastLogoutFail(int code) {
    return '退出登录失败，错误码：$code';
  }

  @override
  String get roomPageHost => '房主';

  @override
  String get networkReconnect => '网络发生了错误，正在重连中...';

  @override
  String get roomTipsReconnect => '网络连接已断开，是否重连？';

  @override
  String get networkConnectFailed => '网络连接失败，请重新登录后再试';

  @override
  String get networkConnectFailedTitle => '网络错误';

  @override
  String get toastDisconnectTips => '房间连接已断开，请重新加入房间!';

  @override
  String get dialogTipsTitle => '提示';

  @override
  String get roomPageMicCantOpen => '麦克风无法开启';

  @override
  String get roomPageGrantMicPermission => '你还未授权我们使用麦克风';

  @override
  String get roomPageGoToSettings => '去设置';

  @override
  String get roomPageCancel => '取消';

  @override
  String roomPageUserList(int num) {
    return '用户列表（$num）';
  }

  @override
  String get roomPageInviteTakeSeat => '邀请上麦';

  @override
  String get roomPageRoleSpeaker => '连麦成员';

  @override
  String get roomPageRoleOwner => '房主';

  @override
  String get roomPageSettings => '设置';

  @override
  String get roomPageLeaveSeat => '下麦';

  @override
  String get roomPageSetTakeSeat => '禁止房间用户上麦';

  @override
  String get roomPageSetSilence => '禁止房间用户发送消息';

  @override
  String get roomPageHasLeftTheRoom => '%@ 离开房间';

  @override
  String get roomPageJoinedTheRoom => '%@ 加入房间';

  @override
  String toastSendMessageError(int code) {
    return '发送消息失败，错误码：$code';
  }

  @override
  String get roomPageSendMessage => '发送';

  @override
  String get roomPageBandsSendMessage => '房主已开启禁言';

  @override
  String toastLockSeatError(int code) {
    return '锁定麦位失败，错误码：$code';
  }

  @override
  String toastMuteMessageError(int code) {
    return '禁止发送消息失败，错误码：$code';
  }

  @override
  String get toastDisableTextChatSuccess => '已开启全员禁言';

  @override
  String get toastAllowTextChatSuccess => '已取消全员禁言';

  @override
  String get toastDisableTextChatTips => '主持人已开启全员禁言';

  @override
  String get toastAllowTextChatTips => '主持人已取消全员禁言';

  @override
  String get roomPageGift => '礼物';

  @override
  String get roomPageSelectAllSpeakers => '全部麦上成员';

  @override
  String get roomPageGiftNoSpeaker => '无其他麦上成员';

  @override
  String get roomPageSelectDefault => '选择赠送礼物对象';

  @override
  String get roomPageSendGift => '赠送';

  @override
  String toastSendGiftError(int code) {
    return '赠送礼物失败，错误码：$code';
  }

  @override
  String roomPageReceivedGiftTips(String nameA, String giftName, String nameB) {
    return '$nameA收到$nameB赠送的 $giftName';
  }

  @override
  String get roomPageGiftHeart => '爱心';

  @override
  String get roomPageLockSeat => '锁定麦位';

  @override
  String get roomPageUnlockSeat => '解锁麦位';

  @override
  String get dialogMicOprationMessage => '请允许我们使用你的麦克风，以便你能正常进行语音聊天。';

  @override
  String toastUnlockSeatFail(int code) {
    return '解锁麦位失败，错误码：$code';
  }

  @override
  String toastLockSeatFail(int code) {
    return '锁定麦位失败，错误码：$code';
  }

  @override
  String get toastLockSeatAlreadyTakeSeat => '锁定麦位失败，麦上已有用户';

  @override
  String get roomPageLeaveSpeakerSeat => '下麦';

  @override
  String roomPageLeaveSpeakerSeatDesc(String name) {
    return '是否踢 $name下麦？';
  }

  @override
  String get dialogConfirm => '确认';

  @override
  String get dialogCancel => '取消';

  @override
  String toastKickoutLeaveSeatError(String name, int code) {
    return '踢 $name 下麦失败，错误码：$code';
  }

  @override
  String get roomPageInvitationHasSent => '邀请通知已发送';

  @override
  String get roomPageNoMoreSeatAvailable => '已没有空闲的麦位';

  @override
  String get dialogInvitionTitle => '上麦邀请';

  @override
  String get dialogInvitionDescrip => '房主邀请你一起连麦，是否同意';

  @override
  String get dialogRefuse => '拒绝';

  @override
  String get dialogAccept => '同意';

  @override
  String toastToBeASpeakerSeatFail(int code) {
    return '连麦失败，错误码：$code';
  }

  @override
  String get roomPageTakeSeat => '上麦';

  @override
  String toastTakeSpeakerSeatFail(int code) {
    return '上麦失败，错误码：$code';
  }

  @override
  String get thisSeatHasBeenClosed => '该麦位已被锁定';

  @override
  String get dialogSureToLeaveSeat => '确定要下麦吗？';

  @override
  String toastLeaveSeatFail(int code) {
    return '下麦失败，错误码：$code';
  }

  @override
  String get roomPageDestroyRoom => '解散房间';

  @override
  String get dialogSureToDestroyRoom => '是否解散该房间？';

  @override
  String get toastRoomHasDestroyed => '房间已被解散';

  @override
  String toastRoomLeaveFailTip(int code) {
    return '离开房间失败，错误码：$code';
  }

  @override
  String toastRoomEndFailTip(int code) {
    return '解散房间失败，错误码：$code';
  }
}
