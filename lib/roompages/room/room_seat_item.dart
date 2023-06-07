import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../model/user_model.dart';
import '../../providers/info_providers.dart';
import '../../service/zego_user_service.dart';

import '../../common/style/styles.dart';
import '../../model/zego_room_user_role.dart';
import '../../constants/zego_room_constant.dart';

typedef SeatItemClickCallback = Function(
    int index, String userId, String userName, ZegoSpeakerSeatStatus status);

class SeatItem extends StatefulWidget {
  final int index;
  final String userID;
  final String userName;
  final bool? mic;
  final ZegoSpeakerSeatStatus status;
  final double? soundLevel;
  final ZegoNetworkQuality? networkQuality;
  final String avatar;
  final SeatItemClickCallback callback;

  const SeatItem(
      {required this.index,
      required this.userID,
      required this.userName,
      this.mic,
      required this.status,
      this.soundLevel,
      this.networkQuality,
      required this.avatar,
      required this.callback,
      Key? key})
      : super(key: key);

  @override
  State<SeatItem> createState() => _SeatItemState();
}

class _SeatItemState extends State<SeatItem> {
  UserBasicModel? usersData;
  bool isLoading = true;
  @override
  void initState() {
    debugPrint("USER IDS ALL: ${widget.userID}");
    if (widget.userID.trim().isNotEmpty) {
      final result = Provider.of<InfoProviders>(context, listen: false);
      result.callCurrentUserProfileData(widget.userID).then((value) {
        usersData = value;
        setState(() {
          isLoading = false;
        });
      });
    }
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String getNetworkQualityIconName() {
    //   switch ((widget.networkQuality ?? ZegoNetworkQuality.badQuality)) {
    //     case ZegoNetworkQuality.goodQuality:
    //       return StyleIconUrls.roomNetworkStatusGood;
    //     case ZegoNetworkQuality.mediumQuality:
    //       return StyleIconUrls.roomNetworkStatusNormal;
    //     case ZegoNetworkQuality.badQuality:
    //     case ZegoNetworkQuality.unknownQuality:
    //       return StyleIconUrls.roomNetworkStatusBad;
    //   }
    // }

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : SizedBox(
            height: 120,
            width: 152.w,
            child: Stack(
              children: [
                // bottom layout
                Positioned(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // sound wave background
                          (widget.soundLevel ?? 0) > 10
                              ? Image.asset(StyleIconUrls.roomSoundWave)
                              : Container(
                                  color: Colors.transparent,
                                ),
                          // Avatar
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: _getCircleAvatar(context),
                          ),
                          // Microphone muted icon
                          (widget.mic ?? false) || widget.userID.isEmpty
                              ? Container(
                                  color: Colors.transparent,
                                )
                              : Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                      StyleIconUrls.roomSeatMicrophoneMuted),
                                )
                        ],
                      )),
                ),
                Positioned(
                  top: getVerticalSize(65),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.index == 0
                          ? Image.asset(StyleIconUrls.roomSeatsHost)
                          : Container(
                              color: Colors.transparent,
                            ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: widget.index == 0 ? 0 : 10),
                        width: 85,
                        child: Text(
                          widget.userName,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: TextButton(
                    onPressed: () {
                      widget.callback(widget.index, widget.userID,
                          widget.userName, widget.status);
                    },
                    child: const Text(""),
                  ),
                )
              ],
            ),
          );
  }

  _getCircleAvatar(BuildContext context) {
    var userService = context.read<ZegoUserService>();
    var isLocalUserOnSeat = userService.localUserInfo.userRole !=
        ZegoRoomUserRole.roomUserRoleListener;

    // late String image;
    // // late AssetImage image;
    // switch (widget.status) {
    //   case ZegoSpeakerSeatStatus.unTaken:
    //     image = isLocalUserOnSeat
    //         ? (StyleIconUrls.roomSeatDefault)
    //         : (StyleIconUrls.roomSeatAdd);
    //     break;
    //   case ZegoSpeakerSeatStatus.occupied:
    //     image = usersData == null ? (widget.avatar) : (usersData!.imageUrl);
    //     break;
    //   case ZegoSpeakerSeatStatus.closed:
    //     image = (ImageConstant.imgComponent);
    //     // image = const AssetImage(StyleIconUrls.roomSeatLock);
    //     break;
    // }
    late AssetImage image;
    switch (widget.status) {
      case ZegoSpeakerSeatStatus.unTaken:
        image = isLocalUserOnSeat
            ? const AssetImage(StyleIconUrls.roomSeatDefault)
            : const AssetImage(StyleIconUrls.roomSeatAdd);
        break;
      case ZegoSpeakerSeatStatus.occupied:
        image = AssetImage(widget.avatar);
        break;
      case ZegoSpeakerSeatStatus.closed:
        image = AssetImage(ImageConstant.imgComponent);
        // image = const AssetImage(StyleIconUrls.roomSeatLock);
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        getSize(
          35.77,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: image)),
        // child: (widget.status == ZegoSpeakerSeatStatus.occupied &&
        //         usersData != null)
        //     ? Image.network(
        //         image,
        //         fit: BoxFit.cover,
        //       )
        //     : Image.asset(image),
      ),
    );
    // return CircleAvatar(
    //   backgroundColor: const Color(0xFFE6E6E6),
    //   foregroundImage: image,
    // );
  }
}
