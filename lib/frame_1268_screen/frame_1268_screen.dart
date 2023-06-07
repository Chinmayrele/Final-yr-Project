import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';

  Widget Frame1268Screen (BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
        content: Container(
          decoration: BoxDecoration(
            color: ColorConstant.black9004c,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: getVerticalSize(
                      25.00,
                    ),
                    bottom: getVerticalSize(
                      20.00,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: getHorizontalSize(
                            35.00,
                          ),
                          right: getHorizontalSize(
                            22.00,
                          ),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Lock the room',
                                style: TextStyle(
                                  color: ColorConstant.whiteA700,
                                  fontSize: getFontSize(
                                    33,
                                  ),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(
                            22.00,
                          ),
                          top: getVerticalSize(
                            40.00,
                          ),
                          right: getHorizontalSize(
                            21.00,
                          ),
                        ),
                        child: Container(
                          width: getHorizontalSize(
                            259.00,
                          ),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            obscureText: false,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: true,
                            enableActiveFill: true,
                            onChanged: (value) {},
                            textStyle: TextStyle(
                              fontSize: getFontSize(
                                40.0,
                              ),
                              color: ColorConstant.whiteA700,
                            ),
                            pinTheme: PinTheme(
                              fieldHeight: getHorizontalSize(
                                53.00,
                              ),
                              fieldWidth: getHorizontalSize(
                                53.00,
                              ),
                              shape: PinCodeFieldShape.box,
                              selectedFillColor: ColorConstant.gray600,
                              activeFillColor: ColorConstant.gray600,
                              inactiveFillColor: ColorConstant.gray600,
                              inactiveColor:
                                  ColorConstant.fromHex("#1212121D"),
                              selectedColor:
                                  ColorConstant.fromHex("#1212121D"),
                              activeColor:
                                  ColorConstant.fromHex("#1212121D"),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              22.00,
                            ),
                            top: getVerticalSize(
                              40.00,
                            ),
                            right: getHorizontalSize(
                              22.00,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop(false);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(
                                37.00,
                              ),
                              width: getHorizontalSize(
                                114.00,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.whiteA700,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    25.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Lock",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.gray601,
                                  fontSize: getFontSize(
                                    25,
                                  ),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }