import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagramclone/resources/auth.dart';

import '../models/users.dart';

class UserProvider with ChangeNotifier {
  Users? _users;
  final AuthMethods authMethods = AuthMethods();
  Users get getUser => _users!;
  Future<void> refreshUser() async {
    Users users = await authMethods.getUserDetails();
    _users = users;
    notifyListeners();
  }
}
