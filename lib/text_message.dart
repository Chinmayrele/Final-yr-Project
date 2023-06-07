import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/math_utils.dart';
import 'model/user_model.dart';

class MessageTextTrial extends StatefulWidget {
  const MessageTextTrial({
    Key? key,
    required this.chatterUser,
  }) : super(key: key);
  final UserBasicModel chatterUser;

  @override
  State<MessageTextTrial> createState() => _MessageTextTrialState();
}

class _MessageTextTrialState extends State<MessageTextTrial> {
  var _enteredMessage = '';
  bool emojiShowing = false;
  // late CameraController _cameraController;
  String docId = '';
  String logUserId = '';
  late FocusNode focusNode;

  late Future<void> cameraValue;
  @override
  void initState() {
    logUserId = FirebaseAuth.instance.currentUser!.uid;
    final strCompare = logUserId.compareTo(widget.chatterUser.userId);
    docId = strCompare == -1
        ? logUserId + widget.chatterUser.userId
        : widget.chatterUser.userId + logUserId;
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  void _sendMessage() async {
    final t = Timestamp.now();
    var time = t.toDate();
    time.toString();

    FocusScope.of(context).unfocus();
    final timeStamp = Timestamp.now();
    await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(docId) // docId
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'type': "text",
      'createdAt': timeStamp,
      'senderId': logUserId,
      'receiverId': widget.chatterUser.userId,
    });
    await FirebaseFirestore.instance
        .collection('allMessage')
        .doc(docId) //widget.chatterUser.userId
        .set({
      "senderUserId": logUserId,
      "receiverUserId": widget.chatterUser.userId,
      "message": _enteredMessage,
      "createdAt": timeStamp,
      "type": "text",
      "bothIds": docId,
    });
    _controller.clear();
    _enteredMessage = '';
  }

  _onEmojiSelected(Emoji emoji) {
    _enteredMessage += emoji.emoji;
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _enteredMessage = _enteredMessage.characters.skipLast(1).toString();
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.05,
          margin: EdgeInsets.only(
              left: getHorizontalSize(10),
              right: getHorizontalSize(10),
              bottom: size.height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getVerticalSize(0.07),
                  bottom: getVerticalSize(0.0),
                ),
                child: SizedBox(
                  height: getVerticalSize(37.0),
                  width: getHorizontalSize(278.8),
                  child: TextFormField(
                    // onFieldSubmitted: addMessage(),
                    cursorHeight: 22,
                    focusNode: focusNode,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Message....',
                      hintStyle: TextStyle(
                        fontSize: getFontSize(14.0),
                        color: ColorConstant.gray600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(30.00),
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
                      prefixIcon: GestureDetector(
                        onTap: () {
                          pickImageCamera();
                        },
                        child: Padding(
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
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: getSize(16.02),
                        minHeight: getSize(16.02),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                          size: 26,
                        ),
                      ),
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
                        16.0,
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
              ),
              // SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    emojiShowing = !emojiShowing;
                    focusNode.unfocus();
                    focusNode.canRequestFocus = true;
                  });
                },
                child: SizedBox(
                  // margin: const EdgeInsets.only(right: 5),
                  height: getSize(23.68),
                  width: getSize(23.68),
                  child: SvgPicture.asset(
                    ImageConstant.imgGroup,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // emojiShowing
              //     ? const SizedBox(height: 0, width: 0)
              Padding(
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
                            _sendMessage();
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
    );
  }

  File? _imageFile;
  File? _imageFile02;
  String urlDownload = "";
  UploadTask? task;

  Future<void> pickImageCamera() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 40);
      if (image == null) return;
      _imageFile = File(image.path);
      File? _imageFile01 = await compressImage(imageToCompress: _imageFile!);
      setState(() {
        _imageFile02 = _imageFile01;
      });
      convertToUrl();
    } on PlatformException catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<File?> compressImage(
      {required File imageToCompress, quality = 100, percentage = 8}) async {
    var path = await FlutterNativeImage.compressImage(
        imageToCompress.absolute.path,
        quality: 100,
        percentage: 8);
    return path;
  }

  Future<void> convertToUrl() async {
    try {
      if (_imageFile02 != null) {
        final fileName = _imageFile02!.path;
        final destination = 'files/$fileName';
        final ref = FirebaseStorage.instance.ref(destination);
        task = ref.putFile(_imageFile02!);
        if (task == null) {
          return;
        }
        final snapshot = await task!.whenComplete(() {});
        urlDownload = await snapshot.ref.getDownloadURL();
        debugPrint("URL DOWNLOAD DONE: $urlDownload");
        final dateStamp = Timestamp.now();
        await FirebaseFirestore.instance
            .collection('chatRoom')
            .doc(docId) // docId
            .collection('messages')
            .add({
          'text': urlDownload,
          'type': "img",
          'createdAt': dateStamp,
          'senderId': logUserId,
          'receiverId': widget.chatterUser.userId,
        });
        await FirebaseFirestore.instance
            .collection('allMessage')
            .doc(docId)
            .set({
          "userId": widget.chatterUser.userId,
          "message": "Image is sent!",
          "createdAt": dateStamp,
          "type": "img",
          "bothIds": docId,
        });
        setState(() {});
      }
    } on FirebaseException catch (e) {
      //debugPrint('Error Uploading: $e');
    }
  }

  // showAttachmentBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           child: Wrap(
  //             children: <Widget>[
  //               ListTile(
  //                   leading: Icon(Icons.image),
  //                   title: Text('Image'),
  //                   onTap: () => showFilePicker(FileType.image)),
  //               ListTile(
  //                   leading: Icon(Icons.videocam),
  //                   title: Text('Video'),
  //                   onTap: () => showFilePicker(FileType.video)),
  //               ListTile(
  //                 leading: Icon(Icons.insert_drive_file),
  //                 title: Text('File'),
  //                 onTap: () => showFilePicker(FileType.any),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
  // showFilePicker(FileType fileType) async {
  //   FilePickerResult? file = await FilePicker.platform.pickFiles(type: fileType);
  //   // getFile(type: fileType);
  //   chatBloc.dispatch(SendAttachmentEvent(chat.chatId, file, fileType));
  //   Navigator.pop(context);
  //   GradientSnackBar.showMessage(context, 'Sending attachment..');
  // }
  // Future mapSendAttachmentEventToState(SendAttachmentEvent event) async {
  //   String url = await storageRepository.uploadFile(
  //       event.file, Paths.getAttachmentPathByFileType(event.fileType));
  //   String username = SharedObjects.prefs.getString(Constants.sessionUsername);
  //   String name = SharedObjects.prefs.getString(Constants.sessionName);
  //   Message message;
  //   if (event.fileType == FileType.image)
  //     message = ImageMessage(url, DateTime.now().millisecondsSinceEpoch, name, username);
  //   else if (event.fileType == FileType.video)
  //     message = VideoMessage(url, DateTime.now().millisecondsSinceEpoch, name, username);
  //   else
  //     message = FileMessage(url, DateTime.now().millisecondsSinceEpoch, name, username);
  //   await chatRepository.sendMessage(event.chatId, message);
  // }
}
