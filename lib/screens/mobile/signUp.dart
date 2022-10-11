import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagramclone/resources/auth.dart';

import '../../const/colors.dart';
import '../../widgest/text_field_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _bio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/logos/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children:  [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1545291730-faff8ca1d4b0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmVhdXRpZnVsJTIwYmxhY2slMjB3b21hbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60'),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  hintText: 'Enter username',
                  textEditingController: _username,
                  textInputType: TextInputType.name),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textEditingController: _email,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textEditingController: _password,
                textInputType: TextInputType.name,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your bio',
                textEditingController: _bio,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                height: 49,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: blueColor),
                child: const Center(
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              RichText(
                text: TextSpan(text: "Already have an account? ", children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() => AuthMethods().signUpUser(username: _username.text, email: _email.text, password: _password.text, bio: _bio.text)),
                      text: " Log in",
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
