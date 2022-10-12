import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as model;
import 'package:flutter/services.dart';
import 'package:instagramclone/models/users.dart';
import 'package:instagramclone/models/users.dart';
import 'package:instagramclone/models/users.dart';
import 'package:instagramclone/resources/storage.dart';

import '../models/users.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return Users.fromSnap(snapshot);
  }

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    // required String password,
    required Uint8List pics,
  }) async {
    String res = "An error occured ";

    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl =
            await MediaStorage().uploadImage("profileImage", pics, false);
        Users users = Users(
            email: email,
            bio: bio,
            followers: [],
            following: [],
            password: password,
            photoUrl: photoUrl,
            uid: credential.user!.uid,
            username: username);
        await _firestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(users.toJson());
        res = "success";
      }
    } catch (err) {
      err.toString();
    }
    return res;
  }

  Future<String> logIn(
      {required String email, required String password}) async {
    String res = "An error occured ";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = "Enter all fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
