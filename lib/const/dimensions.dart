import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/screens/add_post.dart';
import 'package:instagramclone/screens/homeScreen.dart';

import '../screens/profile.dart';
import '../screens/search_screen.dart';

// double width = MediaQuery.of(context).size.width;
const webSize = 600;
List<Widget> homescreen = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostPage(),
  const Text("data"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

// double width = Get.height;ku

