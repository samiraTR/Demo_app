import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorderScreen extends StatefulWidget {
  const SoundRecorderScreen({super.key});

  @override
  State<SoundRecorderScreen> createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  FlutterSoundRecorder? audioRecorder;
  bool isRecorderInitialised = false;
  final pathToReadAudio = "assets/audio/funk-casino-163105.mp3";
  @override
  void initState() {
    super.initState();
  }

  Future init() async {
    audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission is denied");
    }
    await audioRecorder!.openRecorder();
    isRecorderInitialised = true;
  }

  Future dispose() async {
    if (!isRecorderInitialised) return;
    await audioRecorder!.closeRecorder();
    audioRecorder = null;
    isRecorderInitialised = false;
  }

  Future record() async {
    await audioRecorder!.startRecorder(toFile: pathToReadAudio);
  }

  Future stop() async {
    await audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (audioRecorder!.isRecording) {
      await record();
      // audioRecorder!.pauseRecorder();
    } else {
      await stop();

      // audioRecorder.
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 46,
                    ),
                    Text('Duration'),
                    Text(
                      '00:01',
                      style: TextStyle(fontSize: 36),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
