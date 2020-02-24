import 'dart:io';

import 'package:file_picker/file_picker.dart';

class SvFilePicker {
  Future<File> pickImage() async {
    File file = await FilePicker.getFile(
      fileExtension: 'jpeg',
      type: FileType.IMAGE,
    );
    return file;
  }

  Future<File> pickAudio() async {
    File file = await FilePicker.getFile(
      fileExtension: 'mp3',
      type: FileType.AUDIO,
    );
    return file;
  }
}
