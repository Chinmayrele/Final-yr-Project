import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

// const pathToSave = 'audio_example.aac';

class AudioPlayer {
  FlutterSoundPlayer? _audioPlayer;
  // bool _isRecorderInitialize = false;
  bool get isRecording => _audioPlayer!.isPlaying;

  Future<void> init() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openAudioSession();
    // _isRecorderInitialize = true;
  }

  void dispose() {
    // if (!_isRecorderInitialize) return;
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future<void> _play(VoidCallback whenFinished, String playBackStr) async {
    // if (!_isRecorderInitialize) return;
    debugPrint("PLAYING");
    await _audioPlayer!.startPlayer(
        codec: Codec.aacMP4,
        fromURI:
            playBackStr,
        whenFinished: whenFinished);
    debugPrint("PLAYEDDDD");
  }

  Future<void> _stop() async {
    // if (!_isRecorderInitialize) return;
    debugPrint("STOPPED");
    await _audioPlayer!.stopPlayer();
    debugPrint("STOPPEDDDDDDDDDD");
  }

  Future<void> toggleRecording(
      {required VoidCallback whenFinished, required String recording}) async {
    if (_audioPlayer!.isStopped) {
      await _play(whenFinished, recording);
    } else {
      await _stop();
    }
  }
}
