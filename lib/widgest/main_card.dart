import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:intl/intl.dart';

class MainCard extends StatelessWidget {
  final snap;
  const MainCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: mobileBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(snap['photo']),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      snap['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: ((context) => Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outlined,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.message_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border_outlined)),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${snap['likes'].length} likes",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      text: snap['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: ' ${snap['description']}',
                            style:
                                const TextStyle(fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: const Text(
                      "View all 143 comments",
                      style: TextStyle(color: secondaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      snap['time'].toDate(),
                    ),
                    style: const TextStyle(color: secondaryColor, fontSize: 16),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
