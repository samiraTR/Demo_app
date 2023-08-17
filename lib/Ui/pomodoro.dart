import 'dart:async';

import 'package:demo_app/widgets/button_widget.dart';
import 'package:demo_app/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  bool isRunning = false;
  static const maxSeconds = 1800;
  int seconds = maxSeconds;
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        if (mounted) {
          setState(() {
            seconds--;
          });
        }
      } else {
        stopTimer();
      }
    });
  }

  stopTimer() {
    // if (isReset) {
    //   resetTimer();
    // }
    if (mounted) {
      setState(() {
        timer?.cancel();
      });
    }
  }

  void resetTimer() {
    timer?.cancel();
    setState(() => seconds = maxSeconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(child: Text("Pomodoro             ")),
      ),
      body: GradientWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimer(),
              const SizedBox(
                height: 50,
              ),
              buildButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons() {
    isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(text: "Pause", onClicked: stopTimer),
              const SizedBox(
                width: 20,
              ),
              ButtonWidget(text: "Cancel", onClicked: resetTimer)
            ],
          )
        : ButtonWidget(text: "Start Time!", onClicked: startTimer);
  }

  Widget buildTimer() {
    return SizedBox(
        height: 300,
        width: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 12,
              backgroundColor: Colors.greenAccent,
            ),
            Center(child: buildTime()),
          ],
        ));
  }

  Widget buildTime() {
    if (seconds == 0) {
      return const Icon(
        Icons.done,
        color: Colors.greenAccent,
        size: 100,
      );
    } else {
      return Text(
        formatDuration(seconds),
        style: const TextStyle(
            fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold),
      );
    }
  }

  String formatDuration(seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final second = seconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$second'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}
