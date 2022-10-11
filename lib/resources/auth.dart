import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List pics,
  }) async {
    String res = "An error occured ";

    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty 
          || pics != null
) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        _firestore.collection("users").doc(credential.user!.uid).set({
          "username": username,
          "email": email,
          "uid": credential.user!.uid,
          "bio": bio,
          // "pics": pics,
          "followers": [],
          "following": [],
        });
        res = "success";
      }
    } catch (err) {
      err.toString();
    }
    return res;
  }
}
