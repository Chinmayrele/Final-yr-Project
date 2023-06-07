import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../common/style/styles.dart';
import '../../../core/utils/math_utils.dart';
import '../../../localization/localisation.dart';
import '../../../model/zego_room_gift.dart';
import '../../../service/zego_speaker_seat_service.dart';
import 'give_gift_select.dart';

class RoomGiftPage extends HookWidget {
  RoomGiftPage({Key? key}) : super(key: key);
  // final String userId;

  final List<Widget> list = [
    const Tab(
      text: "Classic",
    ),
    const Tab(
      text: "Events",
    ),
    const Tab(
      text: "Privilege",
    ),
  ];

  String userIdGift = "";

  refreshFunct(String userId) {
    userIdGift = userId;
  }

  int giftSelect = -1;
  @override
  Widget build(BuildContext context) {
    final _controller = useTabController(initialLength: list.length);
    final _index = useState(0);
    final _key = GlobalKey();

    _controller.addListener(() {
      _index.value = _controller.index;
    });

    var selectedRoomGift = useState<ZegoRoomGift>(ZegoRoomGift(
        RoomGiftID.fingerHeart.value,
        // "Diamond",
        AppLocalizations.of(context)!.roomPageGiftHeart,
        StyleIconUrls.roomGiftFingerHeart));

    // var selectedGiftID = useState<ZegoSpeakerSeatService>();

    return GlassmorphicContainer(
      height: getVerticalSize(340),
      width: getHorizontalSize(360),
      borderRadius: 5,
      blur: 5,
      alignment: Alignment.bottomCenter,
      border: 3,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.2),
            const Color(0xFFFFFFFF).withOpacity(0.2),
          ],
          stops: const [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white10.withOpacity(0.3),
          Colors.white10.withOpacity(0.3),
        ],
      ),
      child: Stack(
        children: [
          GlassmorphicContainer(
            margin: const EdgeInsets.only(top: 4),
            height: getVerticalSize(90),
            width: getHorizontalSize(360),
            borderRadius: 5,
            blur: 15,
            alignment: Alignment.bottomCenter,
            border: 0,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.15),
                  const Color(0xFFFFFFFF).withOpacity(0.15),
                ],
                stops: const [
                  0.1,
                  1,
                ]),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white10.withOpacity(0.5),
                Colors.white10.withOpacity(0.5),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GlassmorphicContainer(
              //   margin: const EdgeInsets.only(top: 4),
              //   height: getVerticalSize(90),
              //   width: getHorizontalSize(360),
              //   borderRadius: 5,
              //   blur: 15,
              //   alignment: Alignment.bottomCenter,
              //   border: 0,
              //   linearGradient: LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         const Color(0xFFffffff).withOpacity(0.15),
              //         const Color(0xFFFFFFFF).withOpacity(0.15),
              //       ],
              //       stops: const [
              //         0.1,
              //         1,
              //       ]),
              //   borderGradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [
              //       Colors.white10.withOpacity(0.5),
              //       Colors.white10.withOpacity(0.5),
              //     ],
              //   ),
              // ),
              GiveGift(
                  refreshFn: refreshFunct, selectedRoomGift: selectedRoomGift),
              // RoomGiftSelector(selectedRoomGift: selectedRoomGift),
              // RoomGiftBottomBar(
              //     selectedRoomGift: selectedRoomGift, userGiftID: userIdGift)
            ],
          ),
        ],
      ),
    );
  }
}
