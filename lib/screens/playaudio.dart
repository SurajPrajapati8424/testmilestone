import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../widgets/button.dart';

/**
- Sample Audio
https://assets.mixkit.co/active_storage/sfx/474/474.wav;
https://assets.mixkit.co/active_storage/sfx/212/212.wav;
https://assets.mixkit.co/active_storage/sfx/166/166.wav;
 */

class PlayAudioScreen extends StatefulWidget {
  const PlayAudioScreen({super.key});

  @override
  PlayAudioScreenState createState() => PlayAudioScreenState();
}

class PlayAudioScreenState extends State<PlayAudioScreen> {
  late AudioManager audioManager;
  @override
  void initState() {
    super.initState();
    audioManager = AudioManager();
  }

  @override
  void dispose() {
    audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Listen when playing
            ValueListenableBuilder(
                valueListenable: audioManager.isPlayingNotifier,
                builder: (context, isPlaying, child) {
                  return isPlaying
                      ? const Text('Is Playing')
                      : const CircularProgressIndicator();
                }),
            // Play button
            Button(
              text: 'LOSS',
              onTap: () {
                audioManager.playAudio(
                    'https://assets.mixkit.co/active_storage/sfx/474/474.wav');
              },
            ),
            // Play button
            Button(
              text: 'WON',
              onTap: () {
                audioManager.playAudio(
                    'https://assets.mixkit.co/active_storage/sfx/166/166.wav');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AudioManager {
  final AudioPlayer audioPlayer = AudioPlayer();
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);
  AudioManager();

  // Method to play audio from URL
  Future<void> playAudio(String url) async {
    try {
      await audioPlayer.stop();
      isPlayingNotifier.value = true;
      await audioPlayer.play(UrlSource(url));

      // Listen for the completion event
      audioPlayer.onPlayerComplete.listen((_) {
        isPlayingNotifier.value = false;
      });
    } catch (e) {
      debugPrint("Error playing audio: $e");
      isPlayingNotifier.value = false;
    }
  }

  // Method to stop audio
  Future<void> stopAudio() async {
    if (isPlayingNotifier.value) {
      await audioPlayer.stop();
      isPlayingNotifier.value = false;
    }
  }

  // Dispose method to clean up resources
  void dispose() {
    audioPlayer.dispose();
    isPlayingNotifier.dispose();
  }
}
