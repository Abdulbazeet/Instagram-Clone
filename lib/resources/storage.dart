import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class MediaStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImage(String fileName, Uint8List image,bool isPost) async {
    Reference ref = _firebaseStorage
        .ref()
        .child(fileName)
        .child(_firebaseAuth.currentUser!.uid);
        if (isPost) {
          String id = const Uuid().v1();
          ref = ref.child(id);
        }
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
