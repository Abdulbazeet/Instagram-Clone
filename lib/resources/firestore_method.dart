import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagramclone/models/post.dart';
import 'package:instagramclone/resources/storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPosts(
    String uid,
    String description,
    String username,
    String profileImage,
    Uint8List file,
  ) async {
    String res = "Some error occured";
    try {
      String downloadUrl =
          await MediaStorage().uploadImage("posts", file, true);
      String postId = const Uuid().v1();

      Post post = Post(
          username: username,
          uid: uid,
          description: description,
          postUrl: downloadUrl,
          likes: [],
          photo: profileImage,
          postId: postId,
          time: DateTime.now());
      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc('postId').update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc('postId').update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }
}
