import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:instagramclone/layout/Responsive_screen.dart';
import 'package:instagramclone/screens/mobile/mobile_screen.dart';
import 'package:instagramclone/screens/mobile/login.dart';
import 'package:instagramclone/screens/web/web_screen.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home:const  Login(),
      home: const ResponsiveScreen(
        mobileScreenSize: MobileScreenSize(),
        webScreenSize: WebScreenSize(),
      ),
    );
  }
}
