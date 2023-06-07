import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const pathToSave = 'audio_example.mp4';

class AudioRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialize = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone Permission Required!');
    }
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialize = true;
  }

  void dispose() {
    if (!_isRecorderInitialize) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialize = false;
  }

  Future<void> _record() async {
    if (!_isRecorderInitialize) return;

    await _audioRecorder!.startRecorder(toFile: pathToSave);
  }

  Future<String?> _stop() async {
    if (!_isRecorderInitialize) return null;
    final recordedLink = await _audioRecorder!.stopRecorder();
    return recordedLink;
  }

  Future<String?> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
      return "";
    } else {
      final String? record = await _stop();
      return record;
    }
  }
}
