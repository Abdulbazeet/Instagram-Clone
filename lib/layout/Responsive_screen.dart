import 'package:flutter/material.dart';
import 'package:instagramclone/const/dimensions.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget webScreenSize;
  final Widget mobileScreenSize;
  const ResponsiveScreen(
      {super.key, required this.mobileScreenSize, required this.webScreenSize});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webSize) {
        return mobileScreenSize;
      }
      return webScreenSize;
    });
  }
}
