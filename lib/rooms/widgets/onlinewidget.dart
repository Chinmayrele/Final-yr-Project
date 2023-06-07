import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';
import '../../model/user_model.dart';
import '../../model/zego_user_info.dart';
import '../../providers/info_providers.dart';

// ignore: must_be_immutable
class OnlineWidget extends StatefulWidget {
  const OnlineWidget({Key? key, required this.onlineData}) : super(key: key);
  final ZegoUserInfo onlineData;

  @override
  State<OnlineWidget> createState() => _OnlineWidgetState();
}

class _OnlineWidgetState extends State<OnlineWidget> {
  late UserBasicModel userData;
  bool isLoading = true;
  @override
  void initState() {
    final result = Provider.of<InfoProviders>(context, listen: false);
    result.callCurrentUserProfileData(widget.onlineData.userID).then((value) {
      userData = value;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              top: getVerticalSize(
                12.00,
              ),
              bottom: getVerticalSize(
                12.00,
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: getSize(
                            50.00,
                          ),
                          width: getSize(
                            50.00,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      getSize(25.00),
                                    ),
                                    child: Image.network(
                                      userData.imageUrl,
                                      height: getSize(50.00),
                                      width: getSize(50.00),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: getSize(
                                    12.50,
                                  ),
                                  width: getSize(
                                    12.50,
                                  ),
                                  margin: EdgeInsets.only(
                                    left: getHorizontalSize(
                                      10.00,
                                    ),
                                    top: getVerticalSize(
                                      10.00,
                                    ),
                                    right: getHorizontalSize(
                                      0.43,
                                    ),
                                    bottom: getVerticalSize(
                                      2.16,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.lightGreenA700,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        6.25,
                                      ),
                                    ),
                                    border: Border.all(
                                      color: ColorConstant.gray200,
                                      width: getHorizontalSize(
                                        1.00,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              30.00,
                            ),
                            top: getVerticalSize(
                              14.00,
                            ),
                            bottom: getVerticalSize(
                              15.00,
                            ),
                          ),
                          child: Text(
                            userData.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
                              fontSize: getFontSize(
                                18,
                              ),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(
                  indent: 60,
                  height: getVerticalSize(0.5),
                  color: Colors.white,
                  thickness: 0.5,
                )
              ],
            ),
          );
  }
}
