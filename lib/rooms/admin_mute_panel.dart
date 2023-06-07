import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/math_utils.dart';

class AdminMutePanel extends StatefulWidget {
  const AdminMutePanel({
    Key? key,
    required this.romId,
    required this.romName,
  }) : super(key: key);
  final String romName;
  final String romId;

  @override
  State<AdminMutePanel> createState() => _AdminMutePanelState();
}

class _AdminMutePanelState extends State<AdminMutePanel> {
  bool val = false;
  int selectedMute = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            width: size.width * 0.8,
            child: const Text(
              'Adminsitrator',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Switch(
              value: val,
              onChanged: (value) async {
                setState(() {
                  val = value;
                });
                val
                    ? await FirebaseFirestore.instance
                        .collection('adminPanel')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                        "roomName": widget.romName,
                        "roomId": widget.romName,
                        "type": "admin",
                      })
                    : await FirebaseFirestore.instance
                        .collection('adminPanel')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .delete();
              }),
        ],
      ),
      const Divider(color: Colors.grey, thickness: 1),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                int selectedRadio = 0;
                // selectedRadio = selectedGender.trim().isEmpty
                //     ? selectedGenderUs.contains('Female')
                //         ? 1
                //         : 2
                //     : selectedGender.contains('Female')
                //         ? 1
                //         : 2;
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.transparent,
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SizedBox(
                        height: 300,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: GlassmorphicContainer(
                                  borderRadius: 15,
                                  width: size.width,
                                  blur: 5,
                                  alignment: Alignment.bottomCenter,
                                  border: 1,
                                  linearGradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFFffffff)
                                            .withOpacity(0.2),
                                        const Color(0xFFFFFFFF)
                                            .withOpacity(0.2),
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
                                  height: getVerticalSize(300),
                                )),
                            Column(mainAxisSize: MainAxisSize.min, children: [
                              // List<Widget>.generate(2, (int index) {
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: selectedRadio,
                                    onChanged: (value) {
                                      // selectedRadio == 1 ? setState(() => selectedRadio = 0,) :
                                      setState(() => selectedRadio == 1
                                          ? selectedRadio = 0
                                          : selectedRadio = value as int);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  const Text('10 minute',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue: selectedRadio,
                                    onChanged: (value) {
                                      selectedRadio == 2
                                          ? setState(
                                              () => selectedRadio = 0,
                                            )
                                          : setState(() =>
                                              selectedRadio = value as int);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  const Text('1 hours',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 3,
                                    groupValue: selectedRadio,
                                    onChanged: (value) {
                                      selectedRadio == 3
                                          ? setState(
                                              () => selectedRadio = 0,
                                            )
                                          : setState(() =>
                                              selectedRadio = value as int);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  const Text('12 hours',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 4,
                                    groupValue: selectedRadio,
                                    onChanged: (value) {
                                      selectedRadio == 4
                                          ? setState(
                                              () => selectedRadio = 0,
                                            )
                                          : setState(() =>
                                              selectedRadio = value as int);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  const Text('24 hours',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 90,
                                  height: 33,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        selectedMute = selectedRadio;
                                      },
                                      child: const Text(
                                        'MUTE',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorConstant.deepPurple40066,
                                      )),
                                ),
                              ),
                            ]
                                // }),
                                ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              width: size.width * 0.85,
              child: const Text(
                'Mute the room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
      const Divider(color: Colors.grey, thickness: 1),
      const SizedBox(height: 8),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            width: size.width * 0.95,
            child: const Text(
              'Report',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
