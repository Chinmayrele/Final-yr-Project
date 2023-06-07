import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String type;
  const MessageBubble({
    Key? key,
    required this.text,
    required this.isMe,
    required this.type,
  }) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return widget.type == "text"
        ? Container(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
            child: Align(
              alignment:
                  (!widget.isMe ? Alignment.topLeft : Alignment.topRight),
              child: Container(
                constraints: BoxConstraints(maxWidth: size.width * 0.8),
                decoration: !widget.isMe
                    ? BoxDecoration(
                        color: ColorConstant.whiteA700B2,
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
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            getHorizontalSize(10.00),
                          ),
                          topRight: Radius.circular(
                            getHorizontalSize(0.00),
                          ),
                          bottomLeft: Radius.circular(
                            getHorizontalSize(10.00),
                          ),
                          bottomRight: Radius.circular(
                            getHorizontalSize(10.00),
                          ),
                        ),
                        gradient: LinearGradient(
                          begin: const Alignment(
                            -0.001697166058858155,
                            0.5074751480283091,
                          ),
                          end: const Alignment(
                            0.9983028339411415,
                            0.5074752102704458,
                          ),
                          colors: [
                            ColorConstant.deepPurple900.withOpacity(0.7),
                            ColorConstant.purple500.withOpacity(0.7),
                          ],
                        ),
                      ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 15,
                      color: !widget.isMe ? Colors.black : Colors.white),
                ),
              ),
            ),
          )
        : Container(
            height: size.height * 0.4,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            alignment: (!widget.isMe ? Alignment.topLeft : Alignment.topRight),
            child: Container(
              height: size.height * 0.4,
              width: size.width * 0.6,
              decoration: BoxDecoration(border: Border.all()),
              alignment: widget.text.isNotEmpty ? null : Alignment.center,
              child: widget.text.trim().isNotEmpty
                  ? Image.network(
                      widget.text,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink,
                      ),
                    ),
            ),
          );
  }
}



// import 'package:flutter/material.dart';

// class MessageBubble extends StatelessWidget {
//   final String text;
//   final bool isMe;
//   const MessageBubble({
//     Key? key,
//     required this.text,
//     required this.isMe,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: isMe ? Colors.indigo : Colors.pink,
//             borderRadius: BorderRadius.only(
//               topLeft: const Radius.circular(10),
//               topRight: const Radius.circular(10),
//               bottomLeft:
//                   !isMe ? const Radius.circular(0) : const Radius.circular(10),
//               bottomRight:
//                   isMe ? const Radius.circular(0) : const Radius.circular(10),
//             ),
//           ),
//           width: 220,
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           child: Text(
//             text,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

