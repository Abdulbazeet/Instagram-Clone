import 'package:flutter/material.dart';

class FollowButtonWidget extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final String text;
  const FollowButtonWidget(
      {super.key,
      required this.function,
      required this.backgroundColor,
      required this.textColor,
      required this.borderColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width*.64,
          height: 27,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
