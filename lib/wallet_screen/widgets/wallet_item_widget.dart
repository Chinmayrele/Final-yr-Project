import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';

// ignore: must_be_immutable
class WalletItemWidget extends StatefulWidget {
  const WalletItemWidget({
    Key? key,
    required this.index,
    required this.diamondValue,
    required this.submitPrice,
  }) : super(key: key);
  final int index;
  final Object? diamondValue;
  final void Function(int index, bool isSelected, int price) submitPrice;

  @override
  State<WalletItemWidget> createState() => _WalletItemWidgetState();
}

int? _selectedItem = -1;

class _WalletItemWidgetState extends State<WalletItemWidget> {
  bool _isSelected = false;
  int _selectedPrice = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          // _selectedItem = -1;
          _selectedItem = widget.index;
          _selectedPrice =
              (widget.diamondValue as Map<dynamic, dynamic>)['money'];
          widget.submitPrice(widget.index, _isSelected, _selectedPrice);
          debugPrint(_selectedItem.toString());
          debugPrint(_isSelected.toString());
        });
      },
      child: Container(
        height: 122,
        decoration: BoxDecoration(
            border: _selectedItem == widget.index && _isSelected
                ? Border.all(color: ColorConstant.deepPurple900, width: 1.6)
                : Border.all(color: Colors.white10.withOpacity(0.2), width: 0),
            borderRadius: BorderRadius.circular(15)),
        child: GlassmorphicContainer(
          width: getHorizontalSize(95),
          borderRadius: 15,
          blur: 10,
          alignment: Alignment.bottomCenter,
          border: 2,
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
          height: getVerticalSize(64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: getVerticalSize(58.00),
                  width: getHorizontalSize(96.00),
                  child: GlassmorphicContainer(
                    borderRadius: 0,
                    blur: 15,
                    alignment: Alignment.bottomCenter,
                    border: 0,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorConstant.textStart.withOpacity(0.05),
                          ColorConstant.textEnd.withOpacity(0.05)
                        ],
                        stops: const [
                          0.1,
                          1
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white10.withOpacity(0.2),
                        Colors.white10.withOpacity(0.2),
                      ],
                    ),
                    width: getHorizontalSize(90),
                    height: getVerticalSize(60),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(27.16),
                              top: getVerticalSize(11.00),
                              right: getHorizontalSize(27.16),
                              bottom: getVerticalSize(11.00),
                            ),
                            child: Image.asset(
                              ImageConstant.imgGroup8995,
                              height: getVerticalSize(38.03),
                              width: getHorizontalSize(35.84),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  // left: getHorizontalSize(
                  //   10.00,
                  // ),
                  top: getVerticalSize(
                    9.00,
                  ),
                  right: getHorizontalSize(
                    2.00,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (widget.diamondValue as Map<dynamic, dynamic>)['normal']
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ColorConstant.gray800,
                        fontSize: getFontSize(
                          20,
                        ),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          3.00,
                        ),
                        bottom: getVerticalSize(
                          4.00,
                        ),
                      ),
                      child: Text(
                        ((widget.diamondValue as Map<dynamic, dynamic>)['offer']
                                    .toString())
                                .isEmpty
                            ? ""
                            : "+ " +
                                (widget.diamondValue
                                        as Map<dynamic, dynamic>)['offer']
                                    .toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.deepPurple900,
                          fontSize: getFontSize(
                            14,
                          ),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getVerticalSize(
                    5.00,
                  ),
                  bottom: getVerticalSize(
                    10.00,
                  ),
                ),
                child: Text(
                  "INR " +
                      (widget.diamondValue as Map<dynamic, dynamic>)['money']
                          .toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: ColorConstant.bluegray401,
                    fontSize: getFontSize(
                      12,
                    ),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
