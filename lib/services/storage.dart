import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:legalsuits/services/dbser.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadfile(String loc, String filename, String filepath) async {
    File file = File(filepath);
    try {
      List j = [];
      j = await DBServices().isfileexist(filepath);
      if (j.isNotEmpty) {
        await storage.ref('$loc/$filename').delete().then((value) async {
          await storage.ref('$loc/$filename').putFile(file);
        });
        return;
      }
      await storage.ref('$loc/$filename').putFile(file);
      await DBServices().addFile('$loc/$filename');
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }
}
