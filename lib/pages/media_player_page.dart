import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class MediaPlayerPage extends StatefulWidget {
  const MediaPlayerPage({super.key});

  @override
  State<MediaPlayerPage> createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();

    videoController =
        VideoPlayerController.asset("assets/Video/video_laundry.mp4")
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    videoController.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    await audioPlayer.play(
      AssetSource("audio/audio_laundry.mp3"),
    );
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [

          /// AUDIO
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [

                  const Icon(
                    Icons.music_note,
                    size: 70,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Audio Laundry",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Putar audio promosi laundry",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      ElevatedButton.icon(
                        onPressed: playAudio,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Play"),
                      ),

                      ElevatedButton.icon(
                        onPressed: stopAudio,
                        icon: const Icon(Icons.stop),
                        label: const Text("Stop"),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// VIDEO
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [

                  const Icon(
                    Icons.video_library,
                    size: 70,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Video Proses Laundry",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (videoController.value.isInitialized)

                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController),
                      ),
                    )

                  else

                    const CircularProgressIndicator(),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.green,
                          size: 45,
                        ),
                        onPressed: () {
                          videoController.play();
                          setState(() {});
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.pause_circle,
                          color: Colors.orange,
                          size: 45,
                        ),
                        onPressed: () {
                          videoController.pause();
                          setState(() {});
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.replay_circle_filled,
                          color: Colors.blue,
                          size: 45,
                        ),
                        onPressed: () {
                          videoController.seekTo(Duration.zero);
                          videoController.play();
                          setState(() {});
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}