import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../services/sv_file_picker.dart';
import '../services/sv_firestore.dart';
import '../services/sv_storage.dart';
import '../widgets/audios_list.dart';
import '../widgets/images_grid.dart';
import 'drawer.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser _user;

  HomeScreen(this._user);

  upload(String folder) async {
    File file;
    if (folder == 'images') {
      file = await SvFilePicker().pickImage();
    } else if (folder == 'audios') {
      file = await SvFilePicker().pickAudio();
    }

    if (file != null) {
      print('file has been picked');
      try {
        String _fileName = basename(file.path);
        String _fileUrl = await SvStorage().upload(folder, file);
        print('uploaded to storage');
        Map<String, dynamic> mapData = {
          'fileName': _fileName,
          'fileUrl': _fileUrl
        };
        await SvFirestore().createWithAutoDoc(folder, mapData);
        print('updated to firestore');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        titleSpacing: 0,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.image, color: Colors.white),
                onPressed: () {
                  upload('images');
                },
              ),
              IconButton(
                icon: Icon(Icons.audiotrack, color: Colors.white),
                onPressed: () {
                  upload('audios');
                },
              ),
            ],
          ),
        ],
      ),
      drawer: DrawerX(_user),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: AudioX()),
          GridX(),
        ],
      ),
    );
  }
}
