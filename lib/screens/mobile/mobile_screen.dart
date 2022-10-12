import 'package:flutter/material.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';

class MobileScreenSize extends StatefulWidget {
  const MobileScreenSize({super.key});

  @override
  State<MobileScreenSize> createState() => _MobileScreenSizeState();
}

class _MobileScreenSizeState extends State<MobileScreenSize> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<UserProvider>(context).getUser;
    return  Scaffold(
      body: Center(
        child: Text(users.username),
      ),
    );
  }
}
