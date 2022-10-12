import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:get/get.dart';

import 'package:instagramclone/screens/mobile/mobile_screen.dart';
import 'package:instagramclone/screens/mobile/login.dart';

void main() async {
  
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// MediaQuery.of(context).width
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      //  home:const  Login(),
      // home: const ResponsiveScreen(
      //   mobileScreenSize: MobileScreenSize(),
      //   webScreenSize: WebScreenSize(),
      // ),
      home: StreamBuilder(
        
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              print(Get.height.toString());
              print(MediaQuery.of(context).size.width.toString());
              return  const MobileScreenSize();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print(Get.height.toString());
            return const Center(
              
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const Login();
        },
      ),
    );
  }
}
