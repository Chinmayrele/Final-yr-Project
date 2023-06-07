import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';
import 'admin_mute_panel.dart';

showAdminMuteSetting(BuildContext context, String roomName, String roomId) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(maxHeight: 260),
      builder: (ctx) {
        return Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: GlassmorphicContainer(
                  borderRadius: 0,
                  width: size.width,
                  blur: 10,
                  alignment: Alignment.bottomCenter,
                  border: 1,
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
                      Colors.white10.withOpacity(0.2),
                      Colors.white10.withOpacity(0.2),
                    ],
                  ),
                  height: getVerticalSize(260),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.centerLeft,
                height: getVerticalSize(
                  50.00,
                ),
                width: size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteA70019,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black90033,
                      spreadRadius: getHorizontalSize(
                        2.00,
                      ),
                      blurRadius: getHorizontalSize(
                        2.00,
                      ),
                      offset: const Offset(
                        0,
                        4,
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: getHorizontalSize(20)),
                  child: Text(
                    "Settings",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: getFontSize(20),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // GlassmorphicContainer(
            //   blur: 5,
            //   width: double.infinity,
            //   borderRadius: 0,
            //   alignment: Alignment.centerLeft,
            //   border: 1,
            //   linearGradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         const Color(0xFFffffff).withOpacity(0.2),
            //         const Color(0xFFFFFFFF).withOpacity(0.2),
            //       ],
            //       stops: const [
            //         0.1,
            //         1,
            //       ]),
            //   borderGradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [
            //       Colors.white10.withOpacity(0.2),
            //       Colors.white10.withOpacity(0.2),
            //     ],
            //   ),
            //   height: 50,
            //   padding: const EdgeInsets.only(left: 15),
            //   child: const Text(
            //     '    Invite to join the room',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 18),
            //   ),
            // ),
            Container(
                margin: const EdgeInsets.only(top: 60),
                height: 370,
                child: AdminMutePanel(romName: roomName, romId: roomId)),
          ],
        );
      });
}
