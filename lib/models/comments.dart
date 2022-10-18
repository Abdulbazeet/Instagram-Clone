import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Comments {
  final String username;
  final String uid;
  final String comment;
  final String profileImage;
  final String commentId;
  final time;
  final likes;

  const Comments(
      {required this.username,
      required this.uid,
      required this.comment,
    
      required this.likes,
      required this.profileImage,
      required this.commentId,
      required this.time});

  Map<String, dynamic> toJson() => {
        "username": username,
        "likes": likes,
        "uid": uid,
        "comment": comment,
        "profileImage": profileImage,
        "time": time,
        'commentId': commentId
      };

  static Comments fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comments(
        username: snapshot['username'],
        uid: snapshot['uid'],
        comment: snapshot['comment'],
        likes: snapshot['likes'],
        profileImage: snapshot['profileImage'],
        commentId: snapshot['postId'],
        time: snapshot['time']);
  }
}
