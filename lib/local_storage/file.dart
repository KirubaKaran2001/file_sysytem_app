import 'dart:io';
import 'dart:async';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '/class/local_storage_class.dart';
import 'package:http/http.dart' as http;

class LocalStorage extends StatefulWidget {
  final Storage storage;
  const LocalStorage({
    super.key,
    required this.storage
  });

  @override
  State<LocalStorage> createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  TextEditingController textController = TextEditingController();
  late String state;
  Future<Directory>? appDocDir;
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
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
    writeToFilee();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('File Sysytem'),
        ),
        body:
        Column(
          children: <Widget>[
            TextField(
              controller: textController,
            ),
            ElevatedButton(
              onPressed: writeData,
              child: const Text('Write Data'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: deleteFile,
              child: const Text('delete  dir'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                writeToFilee();
              },
              child: const Text('Writeasbytes'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              (state != '') ? state : "",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            FutureBuilder(
              future: writeToFilee(),
              builder:
                  (BuildContext context, AsyncSnapshot snapshot) {
                Text text = const Text('');
                if (snapshot.hasData) {
                  text = Text('path : ${snapshot.data}');
                } else if (snapshot.hasError) {
                  text = Text('Error : ${snapshot.error}');
                }
                return Container(
                  child: text,
                );
                 
              },
            )
          ],
        ),
      ),
    );
  }

  Future<File> writeData() async {
    // setState(() {
    //   state = textController.text;
    //   textController;
    // });
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/db.txt');
    file.writeAsString('state');
    String readfile = await file.readAsString();
    print(readfile);
    // return widget.storage.writeData('state');
    return writeData();
  }

  Future<File> deleteFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/db.txt');
    await file.delete();
    // return widget.storage.deleteFile();
    return deleteFile();
  }

  Future<File> writeToFilee() async {
    const url = 'https://upload.wikimedia.org/wikipedia/en/a/a9/Example.jpg';
    const outputFilePath = 'example2.jpg';
    final response = await http.get(Uri.parse(url));
    Directory? tempDir = await getDownloadsDirectory();
    String tempPath = tempDir!.path;
    var filePath = '$tempPath/' '$outputFilePath';
    print(filePath);
    return File(filePath).writeAsBytes(response.bodyBytes);
  }

}
