import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';
import 'audio_player.dart';

class MsgAudioBubble extends StatefulWidget {
  const MsgAudioBubble({
    Key? key,
    required this.text,
    required this.isMe,
    required this.type,
  }) : super(key: key);
  final String text;
  final bool isMe;
  final String type;

  @override
  State<MsgAudioBubble> createState() => _MsgAudioBubbleState();
}

class _MsgAudioBubbleState extends State<MsgAudioBubble> {
  final player = AudioPlayer();

  @override
  void initState() {
    player.init();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRecording = player.isRecording;
    return Align(
      alignment: (!widget.isMe ? Alignment.topLeft : Alignment.topRight),
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.12,
        margin: const EdgeInsets.only(top: 80, bottom: 8, left: 10, right: 10),
        constraints: BoxConstraints(maxWidth: size.width * 0.8),
        decoration: BoxDecoration(
          // color: ColorConstant.whiteA700B2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              getHorizontalSize(0.00),
            ),
            topRight: Radius.circular(
              getHorizontalSize(10.00),
            ),
            bottomLeft: Radius.circular(
              getHorizontalSize(10.00),
            ),
            bottomRight: Radius.circular(
              getHorizontalSize(10.00),
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.cyan[300]!.withOpacity(0.5),
              ColorConstant.whiteA70019.withOpacity(0.7),
            ],
          ),
          border: Border.all(
            color: ColorConstant.whiteA70019,
            width: getHorizontalSize(1.00),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black90026,
              spreadRadius: getHorizontalSize(2.00),
              blurRadius: getHorizontalSize(2.00),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 15, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Icon(
                        isRecording ? Icons.stop : Icons.play_arrow_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final isRecording = player.isRecording;
                        debugPrint("RECORDING: $isRecording");
                        debugPrint("TEXT IN AUDIO: ${widget.text}");
                        await player.toggleRecording(
                            recording: widget.text,
                            whenFinished: () => setState(() {}));
                        setState(() {});
                      },
                    )),
                Column(
                  children: const [
                    Text(
                      "Audio file",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Listen to the audio sent',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
