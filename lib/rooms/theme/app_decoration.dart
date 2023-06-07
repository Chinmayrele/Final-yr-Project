import 'package:flutter/material.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/math_utils.dart';

class AppDecoration {
  static BoxDecoration get groupstylelime600cornerradius => BoxDecoration(
        color: ColorConstant.lime600,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.33,
          ),
        ),
      );
  static BoxDecoration get groupstyleblack9001 => BoxDecoration(
        color: ColorConstant.black90026,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              12.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              12.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
        ),
        border: Border.all(
          color: ColorConstant.black90019,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get textstylerobotoromanmedium14 => BoxDecoration(
        color: ColorConstant.black90026,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              18.50,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              18.50,
            ),
          ),
        ),
        border: Border.all(
          color: ColorConstant.black90019,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get groupstylewhiteA700cornerradius => BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            17.00,
          ),
        ),
      );
  static BoxDecoration get textstylerobotoromansemibold151 => BoxDecoration(
        color: ColorConstant.whiteA7004c,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            26.50,
          ),
        ),
        border: Border.all(
          color: ColorConstant.whiteA70026,
          width: getHorizontalSize(
            3.00,
          ),
        ),
      );
  static BoxDecoration get groupstyleblack90026cornerradius => BoxDecoration(
        color: ColorConstant.black90026,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            17.00,
          ),
        ),
      );
  static BoxDecoration get textstylerobotoromanregular7 => BoxDecoration(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            18.50,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment(
            -0.001697166058858155,
            0.5074751480283091,
          ),
          end: Alignment(
            0.9983028339411415,
            0.5074752102704458,
          ),
          colors: [
            ColorConstant.deepPurple900,
            ColorConstant.purple500,
          ],
        ),
      );
  static BoxDecoration get groupstylewhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
}
