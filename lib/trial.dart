// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';

// import 'inbox_screen/audio_player.dart';

// class SafeTalkScreen extends StatefulWidget {
//   const SafeTalkScreen({Key? key}) : super(key: key);

//   @override
//   _SafeTalkScreenState createState() => _SafeTalkScreenState();
// }

// class _SafeTalkScreenState extends State<SafeTalkScreen> {
//   var controller;
//   bool typing = false;
//   bool isAudio = false;
//   bool showRecorder = false;
//   bool recording = false;
//   bool recorded = false;
//   // MoodProvider moodProvider;
//   bool _anonymous = true;
//   // ColorUtil _colorUtil = ColorUtil();
//   final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
//   Codec _codec = Codec.aacMP4;
//   String _mPath = 'tau_file.mp4';
//   bool _mRecorderIsInited = false;
//   double _mSubscriptionDuration = 0;
//   StreamSubscription? _recorderSubscription;
//   int pos = 0;
//   double dbLevel = 0;
//   double _height = 0;

//   List<double> bars = [];
//   UserProfile userProfile;
//   AudioPlayer audioPlayer = AudioPlayer();
//   @override
//   void dispose() {
//     stopRecorder(_mRecorder, false);
//     controller.stopAudio();
//     cancelRecorderSubscriptions();

//     // Be careful : you must `close` the audio session when you have finished with it.
//     audioPlayer.dispose();
//     _mRecorder.closeAudioSession();

//     super.dispose();
//   }

//   Future<void> setSubscriptionDuration(
//       double d) async // v is between 0.0 and 2000 (milliseconds)
//   {
//     _mSubscriptionDuration = d;
//     // setState(() {});
//     await _mRecorder.setSubscriptionDuration(
//       Duration(milliseconds: d.floor()),
//     );
//   }

//   void cancelRecorderSubscriptions() {
//     if (_recorderSubscription != null) {
//       _recorderSubscription.cancel();
//       _recorderSubscription = null;
//     }
//   }

//   Future<void> openTheRecorder() async {
//     if (!kIsWeb) {
//       var status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         throw RecordingPermissionException('Microphone permission not granted');
//       }
//     }
//     await _mRecorder.openAudioSession();
//     if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
//       _codec = Codec.opusWebM;
//       _mPath = 'tau_file.webm';
//       if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
//         _mRecorderIsInited = true;
//         return;
//       }
//     }
//     _mRecorderIsInited = true;
//   }

//   Future<void> init() async {
//     await openTheRecorder();
//     _recorderSubscription = _mRecorder.onProgress.listen((e) {
//       setState(() {
//         pos = e.duration.inSeconds;

//         if (e.decibels != null) {
//           dbLevel = e.decibels;
//         }
//       });
//     });
//     setSubscriptionDuration(1000);
//     setState(() {
//       _mRecorderIsInited = true;
//     });
//   }

//   getPlaybackFn(FlutterSoundRecorder recorder) {
//     if (!_mRecorderIsInited) {
//       return null;
//     }
//     if (recorder.isStopped) {
//       record(recorder);
//     } else {
//       stopRecorder(recorder, true).then((value) => setState(() {}));
//     }
//   }

//   Future uploadImageToFirebase(path) async {
//     // String fileName = basename(imageFile.path);
//     File audioFile = File(path);
//     String timeStamp = DateTime.now().toString();
//     final firebaseStorageRef = FirebaseStorage.instance
//         .ref()
//         .child('uploads/tokens/letter_$timeStamp');
//     await firebaseStorageRef.putFile(audioFile);
//     String imageLink = await firebaseStorageRef.getDownloadURL();
//     return imageLink;
//   }

//   Future<void> stopRecorder(FlutterSoundRecorder recorder, bool send) async {
//     // print('record 3');
//     String? recordUrl = await recorder.stopRecorder();
//     if (send) {
//       DocumentReference docRef = await FirebaseFirestore.instance
//           .collection('letter to universe')
//           .add({
//         'audio': '',
//         "uploaded": false,
//         'isAudio': true,
//         'likes': 0,
//         'message': '',
//         "time": DateTime.now().toString(),
//         'duration': pos,
//         // "uid": currentUser.user.uid.toString(),
//         'avatar': userProfile.avatar,
//         "username": (_anonymous) ? "Anonymous" : userProfile.displayName,
//         // "userImage": currentUser.user.photoURL,
//         // "mood": moodMap[moodProvider.selectedIndex]['title']
//       });
//       // print('record 4');
//       // print(recordUrl);
//       // Navigator.pushAndRemoveUntil(
//       //     context,
//       //     commonRouter(NavBarPage(
//       //       initialPage: 'Safe Talk',
//       //     )),
//       //     (Route<dynamic> route) => false);
//       String firebaseUrl = await uploadImageToFirebase(recordUrl);
//       docRef.update({'audio': firebaseUrl, 'uploaded': true});
//       // FirebaseFirestore.instance.collection('letter to universe').add({
//       //   'audio': firebaseUrl,
//       //   'isAudio': true,
//       //   'likes': 0,
//       //   'message': '',
//       //   "time": DateTime.now().toString(),
//       //   "uid": currentUser.user.uid.toString()
//       // });
//       print(firebaseUrl);
//     }
//   }

//   void record(FlutterSoundRecorder recorder) async {
//     print('record 1');
//     await recorder.startRecorder(
//       codec: _codec,
//       toFile: _mPath,
//     );
//     recorder.onProgress.listen((event) {
//       bars.add(event.decibels);
//       setState(() {
//         print(event.decibels);
//       });
//     });
//     print('record 2');
//     setState(() {});
//   }

//   TextEditingController _textController = TextEditingController();
//   showLetterToUniverseInfo() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             content: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("What's Safe Talk?",
//                       style: FlutterFlowTheme.title3
//                           .copyWith(fontSize: 17, fontWeight: FontWeight.w600)),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                       "Safe Talk is built with the intention to create a safe space for you to share feelings that you can't share with anyone. It's built with an intention to unburden ourselves from the weight of our bottled emotions. Here all your feelings are valid and you can share them with people who know where you are coming from and are willing to listen to you and support you. Start sharing today!",
//                       style: FlutterFlowTheme.bodyText1),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 50,
//                       margin: EdgeInsets.only(top: 20),
//                       decoration: BoxDecoration(
//                           color: Color(0xffFFC729),
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Center(
//                           child: Text('Ok, thanks!',
//                               style: FlutterFlowTheme.title3.copyWith(
//                                   fontSize: 17, fontWeight: FontWeight.w600))),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Widget _buildTextComposer() {
//     return Container(
//         margin: EdgeInsets.symmetric(vertical: 16),
//         // padding: EdgeInsets.symmetric(horizontal: 6),
//         decoration: BoxDecoration(
//             color: Colors.transparent, borderRadius: BorderRadius.circular(16)),
//         child: !showRecorder ? _buildLetterField() : _buildAudioRecorder());
//   }

//   Widget _buildLetterField() {
//     return Container(
//       // height: 200,
//       padding: const EdgeInsets.only(top: 0, left: 0),
//       child: Stack(
//         children: [
//           TextField(
//             controller: _textController,

//             // onSubmitted: _handleSubmitted,
//             onChanged: (val) {
//               if (val.isNotEmpty && !typing) {
//                 setState(() {
//                   typing = true;
//                 });
//               } else if (val.isEmpty) {
//                 setState(() {
//                   typing = false;
//                 });
//               }
//             },
//             maxLines: 8,
//             decoration: InputDecoration(
//                 // suffixIcon: ,
//                 hintText:
//                     'Share your feelings without fears of\njudgements. We assure you, this is\na safe place.',
//                 hintStyle: FlutterFlowTheme.textFieldHintStyle
//                     .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
//                 contentPadding: EdgeInsets.all(8),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: _colorUtil.messageOfTheDayBorderColor,
//                       width: 1,
//                     )),
//                 fillColor: _colorUtil.messageOfTheDayFillColor,
//                 filled: true,
//                 isCollapsed: true,
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                       color: _colorUtil.messageOfTheDayBorderColor,
//                       width: 1,
//                     ))),
//           ),
//           // Positioned(
//           //     top: 0,
//           //     right: 0,
//           //     child: (_textController.text.isEmpty)
//           //         ? new Container(
//           //             // alignment: Alignment.topRight,
//           //             padding: EdgeInsets.zero,
//           //             child: new IconButton(
//           //               icon: new Image.asset(
//           //                 'assets/images/icons/microphone.png',
//           //                 height: 30,
//           //                 width: 30,
//           //                 fit: BoxFit.scaleDown,
//           //               ),
//           //               padding: EdgeInsets.zero,
//           //               onPressed: () {
//           //                 showRecorder = !showRecorder;
//           //                 setState(() {});
//           //               },
//           //             ),
//           //           )
//           //         : new Container(
//           //             height: 0,
//           //             width: 0,
//           //           ))
//         ],
//       ),
//     );
//   }

//   Widget _buildAudioRecorder() {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(32),
//       child: Dismissible(
//         direction: DismissDirection.endToStart,
//         onDismissed: (direction) {
//           if (direction == DismissDirection.endToStart) {
//             showRecorder = !showRecorder;
//             _mRecorder.stopRecorder();
//             setState(() {});
//           } else {
//             return;
//           }
//         },
//         key: Key("recorder"),
//         background: Container(
//           height: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           color: Colors.red,
//           alignment: Alignment.centerRight,
//           child: Text("Delete", style: TextStyle(color: Colors.white)),
//         ),
//         child: Container(
//           height: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           color: Color(0xff353333),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                   child: (!recording)
//                       ? Image(
//                           image: AssetImage("assets/images/icons/wave.png"),
//                           fit: BoxFit.fitWidth,
//                         )
//                       : Container(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: List.generate(
//                                   bars.length,
//                                   (index) => Container(
//                                         padding: EdgeInsets.all(4),
//                                         width: 3,
//                                         height: bars[index] % 30,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(32)),
//                                       )),
//                             ),
//                           ),
//                         )),
//                IconButton(
//                   icon: (!recording)
//                       ? Image.asset(
//                           'assets/images/icons/microphone.png',
//                           height: 30,
//                           width: 30,
//                           fit: BoxFit.scaleDown,
//                           color: Colors.white,
//                         )
//                       : const Icon(
//                           Icons.stop,
//                           color: Colors.white,
//                           size: 32,
//                         ),
//                   onPressed: (recording)
//                       ? () {
//                           _mRecorder.stopRecorder();
//                           recorded = true;

//                           setState(() {});
//                         }
//                       : () {
//                           getPlaybackFn(_mRecorder);
//                           recording = !recording;
//                           setState(() {});
//                         }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // moodProvider = Provider.of<MoodProvider>(context, listen: false);
//     // moodProvider.updatedSelectedIndex(-1);
//     // userProfile = Provider.of<UserProvider>(context, listen: false).userData;
//     super.initState();
//     init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white.withOpacity(0.5),
//           elevation: 0,
//           title: Text(
//             'Safe Talk',
//             style: FlutterFlowTheme.title3,
//           ),
//           leading: IconsWidget(
//               assetName: 'assets/images/icons/back.png',
//               height: 48,
//               width: 48,
//               iconColor: Colors.black,
//               onPressed: () => Navigator.pop(context)),
//           centerTitle: true,
//           actions: [
//             IconsWidget(
//                 padding: 0,
//                 assetName: 'assets/images/icons/question_mark.png',
//                 height: 48,
//                 width: 48,
//                 iconColor: Colors.black,
//                 onPressed: () {
//                   showLetterToUniverseInfo();
//                 }),
//             IconsWidget(
//                 padding: 0,
//                 assetName: 'assets/images/icons/storyline.png',
//                 height: 48,
//                 width: 48,
//                 iconColor: Colors.black,
//                 onPressed: () {
//                   showLetterToUniverseInfo();
//                 }),
//           ],
//           bottom: PreferredSize(
//             preferredSize: Size(double.infinity, 2),
//             child: Container(
//               height: 2,
//               color: Color(0xffFFC729),
//             ),
//           ),
//         ),
//         body: Container(
//           width: size.width,
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Text(
//                 //  ,
//                 //   style: FlutterFlowTheme.title3
//                 //       .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
//                 // ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 // Text("Mood : ${moodMap[moodProvider.selectedIndex]['title']}",
//                 //     style: FlutterFlowTheme.title3
//                 //         .copyWith(fontSize: 13, fontWeight: FontWeight.w400)),
//                 _buildTextComposer(),
//                 Consumer<MoodProvider>(
//                   builder: (context, moodProvider, _) => Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ...List.generate(
//                             moodMap.length,
//                             (index) => Row(
//                                   children: [
//                                     InkWell(
//                                       onTap: () async {
//                                         final animation = animationsMap[
//                                             'moodOnClickAnimation'];
//                                         moodProvider.changeSelectedStatus(true);
//                                         moodProvider
//                                             .updatedSelectedIndex(index);
//                                         // moodFlowController.updatedMoodFlowList();

//                                         await (animation.curvedAnimation.parent
//                                                 as AnimationController)
//                                             .forward(from: 0.0);
//                                       },
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               Image.asset(
//                                                 moodMap[index]['asset'],
//                                                 height: 30,
//                                                 width: 30,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                               Image.asset(
//                                                 moodMap[index]['asset'],
//                                                 height: 30,
//                                                 width: 30,
//                                                 fit: BoxFit.cover,
//                                                 color: (moodProvider
//                                                                 .selectedIndex ==
//                                                             index ||
//                                                         moodProvider
//                                                                 .selectedIndex ==
//                                                             -1)
//                                                     ? Colors.transparent
//                                                     : Color(0xffEBF2FA)
//                                                         .withOpacity(0.5),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             moodMap[index]['title'],
//                                             style: FlutterFlowTheme.bodyText1.copyWith(
//                                                 color: (moodProvider
//                                                                 .selectedIndex ==
//                                                             index ||
//                                                         moodProvider
//                                                                 .selectedIndex ==
//                                                             -1)
//                                                     ? Colors.black
//                                                     : Colors.grey.shade400),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     (index == moodMap.length - 1)
//                                         ? Container(
//                                             height: 0,
//                                             width: 0,
//                                           )
//                                         : Padding(
//                                             padding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 2, 10, 2),
//                                             child: Container(
//                                               width: 2,
//                                               height: 35,
//                                               decoration: BoxDecoration(
//                                                 color: Color(0xFFE5E5EA),
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                               ),
//                                             ),
//                                           ),
//                                   ],
//                                 )),
//                       ],
//                     ),
//                   ),
//                 ),

//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 12),
//                       child: CupertinoSwitch(
//                           activeColor: Color(0xFFFFC629),
//                           value: _anonymous,
//                           onChanged: (_) {
//                             setState(() {
//                               _anonymous = !_anonymous;
//                             });
//                           }),
//                     ),
//                     Text(
//                       (_anonymous)
//                           ? "Publish this anonmyously"
//                           : "Publish as ${userProfile.displayName}",
//                       style: FlutterFlowTheme.bodyText1
//                           .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
//                     ),
//                     Spacer(),
//                     IconsWidget(
//                       padding: 0,
//                       assetName: 'assets/images/icons/check circle.png',
//                       height: 54,
//                       width: 54,
//                       iconColor: Colors.black,
//                       onPressed: (_textController.text.isEmpty)
//                           ? (recorded)
//                               ? () {
//                                   stopRecorder(_mRecorder, true);
//                                 }
//                               : () {}
//                           : () {
//                               print("predssed");
//                               FirebaseFirestore.instance
//                                   .collection('letter to universe')
//                                   .add({
//                                 'audio': '',
//                                 'isAudio': false,
//                                 'likes': 0,
//                                 // 'mood': moodMap[moodProvider.selectedIndex]
//                                     // ['title'],
//                                 'message': _textController.text.toString(),
//                                 "time": DateTime.now().toString(),
//                                 // "uid": currentUser.user.uid.toString(),
//                                 'avatar': userProfile.avatar,
//                                 "username": (_anonymous)
//                                     ? "Anonymous"
//                                     : userProfile.displayName,
//                                 // "userImage": currentUser.user.photoURL,
//                               });
//                               _textController.clear();
//                               setState(() {
//                                 typing = false;
//                               });
//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   commonRouter(NavBarPage(
//                                     initialPage: 'Safe Talk',
//                                   )),
//                                   (Route<dynamic> route) => false);
//                             },
//                     ),
//                   ],
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(vertical: 20),
//                 //   child: FFButtonWidget(
//                 //     text: 'Send',
//                 //     onPressed: ,
//                 //     // icon: Image.asset(
//                 //     //   'assets/images/fabicon.png',
//                 //     //   width: 15,
//                 //     //   height: 15,
//                 //     //   fit: BoxFit.scaleDown,
//                 //     // ),
//                 //     options: FFButtonOptions(
//                 //       width: double.infinity,
//                 //       elevation: 0,
//                 //       iconSize: 20,
//                 //       height: 52,
//                 //       color: (_textController.text.isNotEmpty)
//                 //           ? Color(0xFFFFC629)
//                 //           : Color(0xFFEFEFF4),
//                 //       textStyle: FlutterFlowTheme.title3.copyWith(
//                 //           color: Colors.white,
//                 //           fontSize: 17,
//                 //           fontWeight: FontWeight.w600),
//                 //       borderSide: BorderSide(
//                 //         color: Colors.transparent,
//                 //         width: 1,
//                 //       ),
//                 //       borderRadius: 8,
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ));
//   }
// }