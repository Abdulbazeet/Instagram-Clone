import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Users {
  final String email;
  final String uid;
  final String password;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const Users(
      {required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.password,
      required this.photoUrl,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "bio": bio,
        "password": password,
        "pics": photoUrl,
        "followers": [],
        "following": [],
      };

  static Users fromSnap(DocumentSnapshot snap) {
    
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
        bio: snapshot['bio'],
        email: snapshot['email'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        password: snapshot['password'],
        photoUrl: snapshot['pics'],
        uid: snapshot['uid'],
        username: snapshot['username']);
  }
}
