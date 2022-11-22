import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageFunction {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String path, String name) async {
    File file = File(path);
    try {
      await storage.ref('test/$name').putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadAvatarFile(String path, String name) async {
    File file = File(path);
    try {
      await storage.ref('avatar/$name').putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('test').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found : $ref');
    });

    return results;
  }

  Future<String> downloadURL(String imgName) async {
    String downloadURL = await storage.ref('test/$imgName').getDownloadURL();
    return downloadURL;
  }

  Future<String> downloadAvatarURL(String imgName) async {
    String downloadURL = await storage.ref('avatar/$imgName').getDownloadURL();
    return downloadURL;
  }
}
