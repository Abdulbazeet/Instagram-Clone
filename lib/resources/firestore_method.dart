import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagramclone/models/post.dart';
import 'package:instagramclone/resources/storage.dart';
import 'package:uuid/uuid.dart';

import '../models/comments.dart';

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
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComments(String postId, String username, String uid,
      String profileImage, String comment) async {
    try {
      String commentId = const Uuid().v1();
      Comments comments = Comments(
          username: username,
          uid: uid,
          comment: comment,
          likes: [],
          profileImage: profileImage,
          commentId: commentId,
          time: DateTime.now());

      if (comment.isNotEmpty) {
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comments.toJson());
      } else {
        print('Text is not void');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeComment(
      String uid, List likes, String commentId, String postId) async {
    try {
      if (likes.contains(uid)) {
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String userUid, String followUid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userUid).get();
      List following = (snapshot.data()! as dynamic)['following'];
      if (following.contains(followUid)) {
        await _firestore.collection('users').doc(userUid).update({
          'followers': FieldValue.arrayRemove([userUid])
        });
        await _firestore.collection('users').doc(userUid).update({
          'following': FieldValue.arrayRemove([followUid])
        });
      } else {
        await _firestore.collection('users').doc(userUid).update({
          'following': FieldValue.arrayUnion([followUid])
        });
        await _firestore.collection('users').doc(followUid).update({
          'followers': FieldValue.arrayUnion([userUid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
