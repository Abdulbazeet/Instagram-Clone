import 'package:flutter/material.dart';
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  const TextFieldInput({super.key, required this.hintText, required this.textEditingController, required this.textInputType, this.isPass = false});

  @override
  Widget build(BuildContext context) {
    final _borderSide = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );
    return TextField(
      
      
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: _borderSide,
         focusedBorder: _borderSide,
         border: _borderSide,
         contentPadding: EdgeInsets.all(8),
         filled: true,
         hintText: hintText,

      ),
       keyboardType: textInputType,
       obscureText: isPass,
      
      
      );
  }
}