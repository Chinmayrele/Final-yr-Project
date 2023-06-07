import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/math_utils.dart';

// ignore: must_be_immutable
class RubyItemWidget extends StatefulWidget {
  const RubyItemWidget({
    Key? key,
    required this.index,
    required this.rubyValue,
    required this.submitQuantity,
  }) : super(key: key);
  final Object? rubyValue;
  final int index;
  final void Function(
    int rubyIndex,
    bool isSelected,
    int diamondQuantity,
    int rubyQuantity,
  ) submitQuantity;

  @override
  State<RubyItemWidget> createState() => _RubyItemWidgetState();
}

class _RubyItemWidgetState extends State<RubyItemWidget> {
  int _selectedItem = -1;
  bool _isSelected = false;
  int _selectedDiamond = 0;
  int _selectedRuby = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          _selectedItem = widget.index;
          _selectedDiamond =
              (widget.rubyValue as Map<dynamic, dynamic>)['diamond'];
          _selectedRuby =
              (widget.rubyValue as Map<dynamic, dynamic>)['ruby'] * 1000;
          widget.submitQuantity(
              _selectedItem, _isSelected, _selectedDiamond, _selectedRuby);
          debugPrint("RUBY: $_selectedRuby");
          debugPrint("DIAMOND: $_selectedDiamond");
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: _selectedItem == widget.index && _isSelected
                ? Border.all(color: ColorConstant.deepPurple900, width: 1.6)
                : Border.all(color: Colors.white10.withOpacity(0.2), width: 0),
            borderRadius: BorderRadius.circular(15)),
        child: GlassmorphicContainer(
          borderRadius: 15,
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
          width: getHorizontalSize(0),
          height: getVerticalSize(60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstant.imgGroup89955,
                height: getVerticalSize(22.00),
                width: getHorizontalSize(21.29),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getVerticalSize(4.00),
                ),
                child: Text(
                  (widget.rubyValue as Map<dynamic, dynamic>)['diamond']
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.gray800,
                    fontSize: getFontSize(
                      22,
                    ),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: getVerticalSize(5.00),
                  bottom: getVerticalSize(7.00),
                ),
                alignment: Alignment.center,
                width: getHorizontalSize(77),
                decoration: BoxDecoration(
                  color: ColorConstant.whiteA700,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      getHorizontalSize(8.00),
                    ),
                    bottomRight: Radius.circular(
                      getHorizontalSize(8.00),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 2),
                    SizedBox(
                      height: getSize(15.00),
                      width: getSize(16.00),
                      child: SvgPicture.asset(
                        ImageConstant.imgGroup1527,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(
                          2,
                        ),
                      ),
                      child: Text(
                        (widget.rubyValue as Map<dynamic, dynamic>)['ruby']
                                .toString() +
                            "K",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorConstant.bluegray401,
                          fontSize: getFontSize(
                            15,
                          ),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
