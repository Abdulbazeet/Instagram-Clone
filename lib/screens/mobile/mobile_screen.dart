import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:instagramclone/const/dimensions.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:provider/provider.dart';
// import 'dart:html';

import '../../models/users.dart';

class MobileScreenSize extends StatefulWidget {
  const MobileScreenSize({super.key});

  @override
  State<MobileScreenSize> createState() => _MobileScreenSizeState();
}

class _MobileScreenSizeState extends State<MobileScreenSize> {
  int _page = 0;
  late PageController pageController;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void navigateToTab(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Users users = Provider.of<UserProvider>(context).getUser;
    return isLoading? const Center(child: CircularProgressIndicator(),): Scaffold(
      body: PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          physics: const NeverScrollableScrollPhysics(),
          children:
              //  homeScreen,
              //
              homescreen,),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: _page == 2 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
              label: "",
              backgroundColor: primaryColor)
        ],
        onTap: navigateToTab,
      ),
    );
  }
}
