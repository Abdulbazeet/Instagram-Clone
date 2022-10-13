import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramclone/models/users.dart';

class Post {
  final String username;
  final String uid;
  final String description;
  final String photo;
  final String postId;
  final String postUrl;
  final time;
  final likes;

  const Post(
      {required this.username,
      required this.uid,
      required this.description,
      required this.postUrl,
      required this.likes,
      required this.photo,
      required this.postId,
      required this.time});

  Map<String, dynamic> toJson() => {
        "username": username,
        "likes": likes,
        "uid": uid,
        "description": description,
        "photo": photo,
        "time": time,
        "postUrl": postUrl,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        username: snapshot['username'],
        uid: snapshot['uid'],
        description: snapshot['description'],
        postUrl: snapshot['postUrl'],
        likes: snapshot['likes'],
        photo: snapshot['photo'],
        postId: snapshot['postId'],
        time: snapshot['time']);
  }
}
