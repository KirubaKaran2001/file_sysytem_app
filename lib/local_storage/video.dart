import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:file_sysytem_app/class/local_storage_class.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class VideoPlayerApp extends StatefulWidget {
  const VideoPlayerApp({super.key});

  @override
  State<VideoPlayerApp> createState() => _VideoPlayerAppState();
}

class _VideoPlayerAppState extends State<VideoPlayerApp> {
  Future<File>? displayVideo;
  List<Media> medias = <Media>[];
  Player player = Player(
    id: 0,
  );
  String filePath = '';
  bool isFileExist = false;

  @override
  void initState() {
    super.initState();
    // writeToFilee();
    // getVideo();
    getVideo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadVideos(),
          builder: (context, snapshot) {
            debugPrint('**************************************');
            filePath = snapshot.data.toString();
            debugPrint('I am $filePath');
            debugPrint('**************************************');
            if (snapshot.hasData) {
              medias.add(
                Media.file(snapshot.data!),
              );
              player.open(
                Playlist(
                  medias: medias,
                ),
              );
              return Video(
                player: player,
                showControls: true,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              );
            } else {
              return const Center(
                child: Text(
                  'Loading.....',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // Future<File>? writeToFilee() async {
  //   for (var i = 0; i < playList.length; i++) {
  //     String outputFilePath = 'example$i.mp4';
  //     final response = await http.get(Uri.parse(playList[i].toString()));
  //     Directory? tempDir = await getApplicationDocumentsDirectory();
  //     String tempPath = tempDir.path;
  //     var filePath = '$tempPath/media_storage/$outputFilePath';
  //     print(filePath);
  //     setState(() {
  //       displayVideo = File(filePath).writeAsBytes(response.bodyBytes);
  //     });
  //   }
  // }

  getVideo() async {
    for (var i = 0; i < playList.length; i++) {
      final response = await http.get(Uri.parse(playList[i].toString()));
      final responseBytes = response.bodyBytes;
      return responseBytes;
    }
  }

  Future<File?> loadVideos() async {
    getVideo().then(
      (responseBytes) async {
        Directory? tempDir = await getApplicationDocumentsDirectory();
        String tempPath = tempDir.path;
        for (var i = 0; i < playList.length; i++) {
          String outputFilePath = 'example$i.mp4';
          var filePath = '$tempPath/media_storage/$outputFilePath';
          print(filePath);
          displayVideo = File(filePath).writeAsBytes(responseBytes);
        }
      },
    );
    setState(() {
      displayVideo = loadVideos() as Future<File>?;
    });
    return displayVideo;
  }
}
