import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path /db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString(data);
  }

  Future<File> deleteFile() async {
    try {
      final file = await localFile;
      file.delete();
    } catch (e) {
      throw Exception();
    }
    throw Exception('Error');
  }


}



List<String> playList = [
  "https://assets.mixkit.co/videos/preview/mixkit-going-down-a-curved-highway-through-a-mountain-range-41576-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-people-pouring-a-warm-drink-around-a-campfire-513-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-stars-in-space-background-1610-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-countryside-meadow-4075-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-aerial-view-of-city-traffic-at-night-11-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-fireworks-illuminating-the-beach-sky-4157-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-raft-going-slowly-down-a-river-1218-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-landscape-of-a-mountain-range-4366-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-coast-landscape-aerial-shot-1955-large.mp4",
  "https://assets.mixkit.co/videos/preview/mixkit-clouds-covering-the-mountains-4695-large.mp4",
];
  