import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import 'core/utils/color_constant.dart';
import 'core/utils/image_constant.dart';
import 'core/utils/math_utils.dart';

class Trial003 extends StatefulWidget {
  const Trial003({Key? key}) : super(key: key);

  @override
  State<Trial003> createState() => _Trial003State();
}

class _Trial003State extends State<Trial003> {
  var _enteredMessage = '';
  bool emojiShowing = false;
  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emojiShowing = false;
      }
    });
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        children: [
          Expanded(child: Container()),
          // SizedBox(
          //   height: emojiShowing ? size.height * 0.85 : size.height * 0.9,
          //   width: size.width * 0.8,
          // ),
          Container(
            height: size.height * 0.05,
            margin: EdgeInsets.only(
              left: getHorizontalSize(10),
              right: getHorizontalSize(10),
              // bottom: size.height * 0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: focusNode,
                    // onFieldSubmitted: addMessage(),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      hintStyle: TextStyle(
                        fontSize: getFontSize(
                          14.0,
                        ),
                        color: ColorConstant.gray600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            30.00,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: ColorConstant.whiteA70019,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(30.00),
                        ),
                        borderSide: BorderSide(
                          color: ColorConstant.whiteA70019,
                          width: 1,
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(14.83),
                          right: getHorizontalSize(10.00),
                        ),
                        child: SizedBox(
                          height: getSize(16.02),
                          width: getSize(17.80),
                          child: SvgPicture.asset(
                            ImageConstant.imgUnion,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: getSize(16.02),
                        minHeight: getSize(16.02),
                      ),
                      // suffixIcon: GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       emojiShowing = !emojiShowing;
                      //       if (focusNode.hasFocus) {
                      //         FocusScope.of(context).unfocus();
                      //       } else {
                      //         focusNode.canRequestFocus = true;
                      //       }
                      //     });
                      //   },
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         margin: const EdgeInsets.only(right: 10),
                      //         height: getSize(16.68),
                      //         width: getSize(16.68),
                      //         child: SvgPicture.asset(
                      //           ImageConstant.imgGroup,
                      //           fit: BoxFit.contain,
                      //         ),
                      //       ),
                      //       // Offstage(
                      //       //   offstage: !emojiShowing,
                      //       //   child: SizedBox(
                      //       //     height: 250,
                      //       //     child: EmojiPicker(
                      //       //         onEmojiSelected:
                      //       //             (Category category, Emoji emoji) {
                      //       //           _onEmojiSelected(emoji);
                      //       //         },
                      //       //         onBackspacePressed: _onBackspacePressed,
                      //       //         config: Config(
                      //       //             columns: 7,
                      //       //             // Issue: https://github.com/flutter/flutter/issues/28894
                      //       //             emojiSizeMax: 32 *
                      //       //                 (Platform.isIOS ? 1.30 : 1.0),
                      //       //             verticalSpacing: 0,
                      //       //             horizontalSpacing: 0,
                      //       //             gridPadding: EdgeInsets.zero,
                      //       //             initCategory: Category.SMILEYS,
                      //       //             bgColor: const Color(0xFFF2F2F2),
                      //       //             indicatorColor: Colors.blue,
                      //       //             iconColor: Colors.grey,
                      //       //             iconColorSelected: Colors.blue,
                      //       //             progressIndicatorColor: Colors.blue,
                      //       //             backspaceColor: Colors.blue,
                      //       //             skinToneDialogBgColor: Colors.white,
                      //       //             skinToneIndicatorColor: Colors.grey,
                      //       //             enableSkinTones: true,
                      //       //             showRecentsTab: true,
                      //       //             recentsLimit: 28,
                      //       //             replaceEmojiOnLimitExceed: false,
                      //       //             noRecents: const Text(
                      //       //               'No Recents',
                      //       //               style: TextStyle(
                      //       //                   fontSize: 20,
                      //       //                   color: Colors.black26),
                      //       //               textAlign: TextAlign.center,
                      //       //             ),
                      //       //             tabIndicatorAnimDuration:
                      //       //                 kTabScrollDuration,
                      //       //             categoryIcons: const CategoryIcons(),
                      //       //             buttonMode: ButtonMode.MATERIAL)),
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      // suffixIconConstraints: BoxConstraints(
                      //   minWidth: getSize(
                      //     16.68,
                      //   ),
                      //   minHeight: getSize(
                      //     16.68,
                      //   ),
                      // ),
                      filled: true,
                      fillColor: ColorConstant.whiteA700B2,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: getVerticalSize(
                          11.21,
                        ),
                        bottom: getVerticalSize(
                          12.26,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: ColorConstant.gray600,
                      fontSize: getFontSize(
                        14.0,
                      ),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (val) {
                      setState(() {
                        _enteredMessage = val;
                      });
                    },
                  ),
                ),
                // Material(
                //   color: Colors.transparent,
                //   child: IconButton(
                //     onPressed: () {
                //       setState(() {
                //         emojiShowing = !emojiShowing;
                //       });
                //       if (emojiShowing) {
                //         FocusScope.of(context).unfocus();
                //       }
                //     },
                //     icon: const Icon(
                //       Icons.emoji_emotions,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      emojiShowing = !emojiShowing;
                    });
                    if (emojiShowing) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: getSize(16.68),
                    width: getSize(16.68),
                    child: SvgPicture.asset(
                      ImageConstant.imgGroup,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                emojiShowing
                    ? const SizedBox(height: 0, width: 0)
                    : Padding(
                        padding: EdgeInsets.only(
                          right: getHorizontalSize(
                            0.01,
                          ),
                          bottom: getVerticalSize(
                            0.08,
                          ),
                        ),
                        child: _enteredMessage.trim().isEmpty
                            ? Image.asset(
                                ImageConstant.imgGroup1271,
                                height: getSize(37.07),
                                width: getSize(37.07),
                                fit: BoxFit.fill,
                              )
                            : GestureDetector(
                                onTap: () {
                                  // _sendMessage();
                                },
                                child: Icon(Icons.send,
                                    color: _enteredMessage.trim().isEmpty
                                        ? Colors.grey
                                        : Colors.green),
                              )),
              ],
            ),
          ),
          Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
              height: 250,
              child: EmojiPicker(
                  onEmojiSelected: (Category? category, Emoji emoji) {
                    _onEmojiSelected(emoji);
                  },
                  onBackspacePressed: _onBackspacePressed,
                  config: Config(
                      columns: 7,
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.SMILEYS,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      // progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      replaceEmojiOnLimitExceed: false,
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL)),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'dart:io';

// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_svg/svg.dart';

// import 'core/utils/color_constant.dart';
// import 'core/utils/image_constant.dart';
// import 'core/utils/math_utils.dart';

// class Trial003 extends StatefulWidget {
//   const Trial003({Key? key}) : super(key: key);

//   @override
//   State<Trial003> createState() => _Trial003State();
// }

// class _Trial003State extends State<Trial003> {
//   var _enteredMessage = '';
//   bool emojiShowing = false;
//   _onEmojiSelected(Emoji emoji) {
//     _controller
//       ..text += emoji.emoji
//       ..selection = TextSelection.fromPosition(
//           TextPosition(offset: _controller.text.length));
//   }

//   _onBackspacePressed() {
//     _controller
//       ..text = _controller.text.characters.skipLast(1).toString()
//       ..selection = TextSelection.fromPosition(
//           TextPosition(offset: _controller.text.length));
//   }

//   late FocusNode focusNode;

//   @override
//   void initState() {
//     focusNode = FocusNode();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         emojiShowing = false;
//       }
//     });
//     super.initState();
//   }

//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.blue[100],
//       body: Column(
//         children: [
//           Expanded(child: Container()),
//           // SizedBox(
//           //   height: emojiShowing ? size.height * 0.85 : size.height * 0.9,
//           //   width: size.width * 0.8,
//           // ),
//           Container(
//             height: size.height * 0.05,
//             margin: EdgeInsets.only(
//               left: getHorizontalSize(10),
//               right: getHorizontalSize(10),
//               // bottom: size.height * 0.01
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     focusNode: focusNode,
//                     // onFieldSubmitted: addMessage(),
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Message',
//                       hintStyle: TextStyle(
//                         fontSize: getFontSize(
//                           14.0,
//                         ),
//                         color: ColorConstant.gray600,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(
//                           getHorizontalSize(
//                             30.00,
//                           ),
//                         ),
//                         borderSide: BorderSide(
//                           color: ColorConstant.whiteA70019,
//                           width: 1,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(
//                           getHorizontalSize(30.00),
//                         ),
//                         borderSide: BorderSide(
//                           color: ColorConstant.whiteA70019,
//                           width: 1,
//                         ),
//                       ),
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.only(
//                           left: getHorizontalSize(14.83),
//                           right: getHorizontalSize(10.00),
//                         ),
//                         child: SizedBox(
//                           height: getSize(16.02),
//                           width: getSize(17.80),
//                           child: SvgPicture.asset(
//                             ImageConstant.imgUnion,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                       prefixIconConstraints: BoxConstraints(
//                         minWidth: getSize(16.02),
//                         minHeight: getSize(16.02),
//                       ),
//                       // suffixIcon: GestureDetector(
//                       //   onTap: () {
//                       //     setState(() {
//                       //       emojiShowing = !emojiShowing;
//                       //       if (focusNode.hasFocus) {
//                       //         FocusScope.of(context).unfocus();
//                       //       } else {
//                       //         focusNode.canRequestFocus = true;
//                       //       }
//                       //     });
//                       //   },
//                       //   child: Column(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: [
//                       //       Container(
//                       //         margin: const EdgeInsets.only(right: 10),
//                       //         height: getSize(16.68),
//                       //         width: getSize(16.68),
//                       //         child: SvgPicture.asset(
//                       //           ImageConstant.imgGroup,
//                       //           fit: BoxFit.contain,
//                       //         ),
//                       //       ),
//                       //       // Offstage(
//                       //       //   offstage: !emojiShowing,
//                       //       //   child: SizedBox(
//                       //       //     height: 250,
//                       //       //     child: EmojiPicker(
//                       //       //         onEmojiSelected:
//                       //       //             (Category category, Emoji emoji) {
//                       //       //           _onEmojiSelected(emoji);
//                       //       //         },
//                       //       //         onBackspacePressed: _onBackspacePressed,
//                       //       //         config: Config(
//                       //       //             columns: 7,
//                       //       //             // Issue: https://github.com/flutter/flutter/issues/28894
//                       //       //             emojiSizeMax: 32 *
//                       //       //                 (Platform.isIOS ? 1.30 : 1.0),
//                       //       //             verticalSpacing: 0,
//                       //       //             horizontalSpacing: 0,
//                       //       //             gridPadding: EdgeInsets.zero,
//                       //       //             initCategory: Category.SMILEYS,
//                       //       //             bgColor: const Color(0xFFF2F2F2),
//                       //       //             indicatorColor: Colors.blue,
//                       //       //             iconColor: Colors.grey,
//                       //       //             iconColorSelected: Colors.blue,
//                       //       //             progressIndicatorColor: Colors.blue,
//                       //       //             backspaceColor: Colors.blue,
//                       //       //             skinToneDialogBgColor: Colors.white,
//                       //       //             skinToneIndicatorColor: Colors.grey,
//                       //       //             enableSkinTones: true,
//                       //       //             showRecentsTab: true,
//                       //       //             recentsLimit: 28,
//                       //       //             replaceEmojiOnLimitExceed: false,
//                       //       //             noRecents: const Text(
//                       //       //               'No Recents',
//                       //       //               style: TextStyle(
//                       //       //                   fontSize: 20,
//                       //       //                   color: Colors.black26),
//                       //       //               textAlign: TextAlign.center,
//                       //       //             ),
//                       //       //             tabIndicatorAnimDuration:
//                       //       //                 kTabScrollDuration,
//                       //       //             categoryIcons: const CategoryIcons(),
//                       //       //             buttonMode: ButtonMode.MATERIAL)),
//                       //       //   ),
//                       //       // ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // suffixIconConstraints: BoxConstraints(
//                       //   minWidth: getSize(
//                       //     16.68,
//                       //   ),
//                       //   minHeight: getSize(
//                       //     16.68,
//                       //   ),
//                       // ),
//                       filled: true,
//                       fillColor: ColorConstant.whiteA700B2,
//                       isDense: true,
//                       contentPadding: EdgeInsets.only(
//                         top: getVerticalSize(
//                           11.21,
//                         ),
//                         bottom: getVerticalSize(
//                           12.26,
//                         ),
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: ColorConstant.gray600,
//                       fontSize: getFontSize(
//                         14.0,
//                       ),
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w400,
//                     ),
//                     onChanged: (val) {
//                       setState(() {
//                         _enteredMessage = val;
//                       });
//                     },
//                   ),
//                 ),
//                 // Material(
//                 //   color: Colors.transparent,
//                 //   child: IconButton(
//                 //     onPressed: () {
//                 //       setState(() {
//                 //         emojiShowing = !emojiShowing;
//                 //       });
//                 //       if (emojiShowing) {
//                 //         FocusScope.of(context).unfocus();
//                 //       }
//                 //     },
//                 //     icon: const Icon(
//                 //       Icons.emoji_emotions,
//                 //       color: Colors.white,
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(width: 10),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       emojiShowing = !emojiShowing;
//                     });
//                     if (emojiShowing) {
//                       FocusScope.of(context).unfocus();
//                     }
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(right: 10),
//                     height: getSize(16.68),
//                     width: getSize(16.68),
//                     child: SvgPicture.asset(
//                       ImageConstant.imgGroup,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 emojiShowing
//                     ? const SizedBox(height: 0, width: 0)
//                     : Padding(
//                         padding: EdgeInsets.only(
//                           right: getHorizontalSize(
//                             0.01,
//                           ),
//                           bottom: getVerticalSize(
//                             0.08,
//                           ),
//                         ),
//                         child: _enteredMessage.trim().isEmpty
//                             ? Image.asset(
//                                 ImageConstant.imgGroup1271,
//                                 height: getSize(37.07),
//                                 width: getSize(37.07),
//                                 fit: BoxFit.fill,
//                               )
//                             : GestureDetector(
//                                 onTap: () {
//                                   // _sendMessage();
//                                 },
//                                 child: Icon(Icons.send,
//                                     color: _enteredMessage.trim().isEmpty
//                                         ? Colors.grey
//                                         : Colors.green),
//                               )),
//               ],
//             ),
//           ),
//           Offstage(
//             offstage: !emojiShowing,
//             child: SizedBox(
//               height: 250,
//               child: EmojiPicker(
//                   onEmojiSelected: (Category category, Emoji emoji) {
//                     _onEmojiSelected(emoji);
//                   },
//                   onBackspacePressed: _onBackspacePressed,
//                   config: Config(
//                       columns: 7,
//                       // Issue: https://github.com/flutter/flutter/issues/28894
//                       emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
//                       verticalSpacing: 0,
//                       horizontalSpacing: 0,
//                       gridPadding: EdgeInsets.zero,
//                       initCategory: Category.SMILEYS,
//                       bgColor: const Color(0xFFF2F2F2),
//                       indicatorColor: Colors.blue,
//                       iconColor: Colors.grey,
//                       iconColorSelected: Colors.blue,
//                       progressIndicatorColor: Colors.blue,
//                       backspaceColor: Colors.blue,
//                       skinToneDialogBgColor: Colors.white,
//                       skinToneIndicatorColor: Colors.grey,
//                       enableSkinTones: true,
//                       showRecentsTab: true,
//                       recentsLimit: 28,
//                       replaceEmojiOnLimitExceed: false,
//                       noRecents: const Text(
//                         'No Recents',
//                         style: TextStyle(fontSize: 20, color: Colors.black26),
//                         textAlign: TextAlign.center,
//                       ),
//                       tabIndicatorAnimDuration: kTabScrollDuration,
//                       categoryIcons: const CategoryIcons(),
//                       buttonMode: ButtonMode.MATERIAL)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
