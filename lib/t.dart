import 'package:final_yr_project/roompages/room/message/room_message_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/style/styles.dart';
import 'localization/localisation.dart';
import 'model/zego_room_user_role.dart';
import 'model/zego_user_info.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';

class ZegoMessageListItemTrial extends StatelessWidget {
  const ZegoMessageListItemTrial({Key? key, required this.itemModel})
      : super(key: key);
  final ZegoMessageListItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 10,
        child: Container(
            width: 260,
            padding: EdgeInsets.only(
                left: 21.w, top: 21.h, right: 21.w, bottom: 21.h),
            margin: EdgeInsets.only(bottom: 8.h, left: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      getRoleWidget(context, itemModel.sender),
                      getSpacerWidgetByRole(itemModel.sender),
                      (itemModel.sender.userName.isNotEmpty)
                          ? (Text(itemModel.sender.userName,
                              style: StyleConstant.roomChatUserNameText))
                          : const Text(''),
                    ],
                  ),
                  const SizedBox(height: 5),
                  getMessageWidgets(context),
                ])
            // RichText(
            //     textAlign: TextAlign.start,
            //     text: TextSpan(children: getMessageWidgets(context))),
            ),
      ),
      const Expanded(flex: 1, child: Text('')),
    ]);
  }

  Text getMessageWidgets(BuildContext context) {
    Text spans;
    // spans.add(getRoleWidget(context, itemModel.sender));
    // spans.add(getSpacerWidgetByRole(itemModel.sender));
    // if (itemModel.sender.userName.isNotEmpty) {
    //   spans = (Text(itemModel.sender.userName + ": ",
    //       style: StyleConstant.roomChatUserNameText));
    // }

    var isMemberJoinedMessage = itemModel.message.message.contains(
        AppLocalizations.of(context)!
            .roomPageJoinedTheRoom
            .replaceAll('%@', '')
            .trim());
    var isMemberLeaveMessage = itemModel.message.message.contains(
        AppLocalizations.of(context)!
            .roomPageHasLeftTheRoom
            .replaceAll('%@', '')
            .trim());
    if (isMemberJoinedMessage || isMemberLeaveMessage) {
      spans = (Text("    " + itemModel.message.message,
          style: StyleConstant.roomChatUserNameText));
    } else {
      spans = (Text("    " + itemModel.message.message,
          style: const TextStyle(color: Colors.white, fontSize: 16)));
    }

    return spans;
  }

  Text getRoleWidget(context, ZegoUserInfo sender) {
    if (ZegoRoomUserRole.roomUserRoleHost == sender.userRole) {
      return Text(AppLocalizations.of(context)!.roomPageHost,
          style: StyleConstant.roomChatHostRoleText);
    }
    return const Text('');
  }

  Text getSpacerWidgetByRole(ZegoUserInfo sender) {
    if (ZegoRoomUserRole.roomUserRoleHost == sender.userRole) {
      return const Text(" ");
    }
    return const Text('');
  }
}
