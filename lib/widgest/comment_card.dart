import 'package:flutter/material.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/resources/firestore_method.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../models/users.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profileImage']
                // 'https://images.unsplash.com/photo-1665846589489-5856db428a85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyM3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'

                ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.snap['username']}   '
                          // 'Ba'
                          ,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: widget.snap['comment']
                            // 'gg'

                            )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                        DateFormat.yMMMd().format(widget.snap['time'].toDate()),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                // await FirestoreMethod().likeComment(
                //     users.uid,
                //     widget.snap['likes'],
                //     widget.snap['commentId'],
                //     widget.snap['postId']);
              },
              icon: const Icon(Icons.favorite_rounded))
        ],
      ),
    );
  }
}
