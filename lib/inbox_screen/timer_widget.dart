import 'dart:async';

import 'package:flutter/material.dart';

class TimerController extends ValueNotifier<bool> {
  TimerController({bool isPlaying = false}) : super(isPlaying);

  void startTimer() => value = true;

  void stopTimer() => value = false;
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.controller}) : super(key: key);

  final TimerController controller;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;
  Duration duration = const Duration();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.value) {
        startTimer();
      } else {
        stopTimer();
      }
    });
  }

  @override
  void dispose() {
    timer == null;
    super.dispose();
  }

  void reset() => setState(() => duration = const Duration());

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  bool isStarted = false;

  void startTimer({bool resets = true}) {
    debugPrint("MOUNTED VLAUE: $mounted");
    if (!mounted) return;
    if (resets) {
      reset();
      debugPrint("TIME STARTED");
    }
    setState(() {
      isStarted = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    debugPrint("TIME STOPPED");
    if (!mounted) return;
    if (resets) {
      reset();
    }
    setState(() {
      isStarted = false;
      timer?.cancel();
    });
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  @override
  Widget build(BuildContext context) {
    return Center(child: buildTime());
  }

  Widget buildTime() {
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    debugPrint("WHATS HERE?: $seconds");
    return Text(
      '$minutes:$seconds',
      style: TextStyle(
          color: !isStarted ? Colors.transparent : Colors.black, fontSize: 17),
    );
  }
}
