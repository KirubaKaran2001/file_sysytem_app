import 'package:dart_vlc/dart_vlc.dart';
import 'package:file_sysytem_app/local_storage/video.dart';
import 'package:flutter/material.dart';

void main() {
  DartVLC.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoPlayerApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
