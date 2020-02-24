import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SvStorage {
  var _storage = FirebaseStorage.instance;

  Future<String> upload(String folder, File file) async {
    var _fileName = basename(file.path);
    StorageReference _ref = _storage.ref().child(folder + '/' + _fileName);
    StorageUploadTask uploadTask = _ref.putFile(file);
    await uploadTask.onComplete;
    var _fileUrl = await _ref.getDownloadURL();
    return _fileUrl.toString();
  }

  Future<void> delete(String folder, String fileName) async {
    StorageReference _ref = _storage.ref().child(folder + '/' + fileName);
    await _ref.delete();
  }
}
