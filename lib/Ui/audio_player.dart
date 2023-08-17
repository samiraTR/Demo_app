import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
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
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
          audioPlayer.setVolume(1.0);
        });
      }
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
    FilePicker.platform.saveFile();
    if (result != null) {
      final file = File(result.files.single.path!);
      audioPlayer.setSourceUrl(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text("Audio Player")],
            ),
            const SizedBox(
              height: 150,
            ),
            ClipRRect(
              child: Image.asset(
                "assets/images/vinyl.jpg",
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 80,
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
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(formatDuration(position)),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        String url =
                            "https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3";
                        await audioPlayer.play(UrlSource(url),
                            volume: 100.0,
                            balance: 90.0,
                            mode: PlayerMode.mediaPlayer);
                        await audioPlayer.resume();
                      }
                    },
                    icon: !isPlaying
                        ? const Icon(Icons.play_arrow)
                        : const Icon(Icons.pause),
                  ),
                ),
                Text(formatDuration(duration - position)),
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    return DateFormat('H:mm:ss').format(DateTime(0, 0, 0).add(duration));
  }
}
