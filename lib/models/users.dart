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
}
