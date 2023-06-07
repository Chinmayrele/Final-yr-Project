import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_gen/gen_l10n/live_audio_room_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../common/style/styles.dart';
import '../../../core/utils/math_utils.dart';
import '../../../localization/localisation.dart';
import '../../../model/zego_room_gift.dart';

class RoomGiftSelector extends StatefulWidget {
  RoomGiftSelector({Key? key, required this.selectedRoomGift})
      : super(key: key);

  ValueNotifier<ZegoRoomGift> selectedRoomGift;

  @override
  State<RoomGiftSelector> createState() => _RoomGiftSelectorState();
}

class _RoomGiftSelectorState extends State<RoomGiftSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getVerticalSize(194),
          width: getHorizontalSize(360),
          child: GridView.count(
            primary: true,
            physics: const ScrollPhysics(),
            padding: EdgeInsets.only(
                left: getHorizontalSize(10),
                top: getVerticalSize(10),
                right: getHorizontalSize(4),
                bottom: getVerticalSize(10)),
            mainAxisSpacing: 2,
            crossAxisCount: 4,
            crossAxisSpacing: 2,
            childAspectRatio: 1.2,
            children: getGiftWidgets(context),
          ),
        ),
        // DotsIndicator(
        //   dotsCount: 5,
        //   position: 0,
        //   decorator: DotsDecorator(
        //     color: Colors.grey.shade300, // Inactive color
        //     activeColor: const Color(0xFF1000C6),
        //     size: const Size(8, 8),
        //     activeSize: const Size(10, 10),
        //   ),
        // ),
      ],
    );
  }

  List<Widget> getGiftWidgets(context) {
    List<ZegoRoomGift> gifts = [];
    gifts.add(ZegoRoomGift(
        RoomGiftID.fingerHeart.value,
        AppLocalizations.of(context)!.roomPageGiftHeart,
        StyleIconUrls.roomGiftFingerHeart));

    List<Widget> widgets = [];
    for (var gift in gifts) {
      widgets.add(
        GlassmorphicContainer(
          height: getVerticalSize(0),
          width: getHorizontalSize(0),
          padding: const EdgeInsets.all(0),
          borderRadius: 5,
          blur: 10,
          alignment: Alignment.center,
          border: 0,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.25),
                const Color(0xFFFFFFFF).withOpacity(0.25),
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
          child: Image.asset(
            gift.res,
            width: getHorizontalSize(65),
            height: getVerticalSize(65),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return widgets;
  }
}
