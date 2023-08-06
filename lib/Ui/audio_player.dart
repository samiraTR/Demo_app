import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDur) {
      setState(() {
        duration = newDur;
      });
    });

    audioPlayer.onPositionChanged.listen((newPos) {
      setState(() {
        position = newPos;
      });
    });
    // setAudio();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    String url =
        "https://quran.com/1/1https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3";
    audioPlayer.setSourceUrl(url);

    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      audioPlayer.setSourceUrl(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            child: Image.asset(
              "assets/images/vinyl.jpg",
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              }),
          Row(
            children: [
              Text(position.toString()),
              CircleAvatar(
                child: IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      String url =
                          "https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3";
                      await audioPlayer.play(UrlSource(url));
                      await audioPlayer.resume();
                    }
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
              ),
              Text(position.toString()),
            ],
          )
        ],
      ),
    );
  }
}
