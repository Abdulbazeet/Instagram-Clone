import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:instagramclone/resources/firestore_method.dart';
import 'package:instagramclone/resources/utils.dart';
import 'package:instagramclone/widgest/button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userdata = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userdata = snap.data()!;
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLength = postSnap.docs.length;
      followers = snap.data()!['followers'].length;
      following = snap.data()!['following'].length;
      isFollowing = snap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: Text(
                userdata['username'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(userdata['pics']),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    buildStats(postLength, 'posts'),
                                    buildStats(followers, 'followers'),
                                    buildStats(following, 'following'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButtonWidget(
                                            function: () {},
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            textColor: primaryColor,
                                            borderColor: Colors.grey,
                                            text: "Edit profile ")
                                        : isFollowing
                                            ? FollowButtonWidget(
                                                function: () async {
                                                  await FirestoreMethod()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userdata['uid']);
                                                },
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                text: 'Unfollow')
                                            : FollowButtonWidget(
                                                function: () async {
                                                  await FirestoreMethod()
                                                      .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userdata['uid']);
                                                },
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                text: 'Follow')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userdata['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 1),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userdata['bio'],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: (snapshot.data as dynamic).docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 1.5),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snaps =
                                  (snapshot.data! as dynamic).docs[index];

                              return Container(
                                child: Image(
                                  image: NetworkImage(
                                    snaps['postUrl'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

Column buildStats(int num, String title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        num.toString(),
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Container(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
      )
    ],
  );
}
