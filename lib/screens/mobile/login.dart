import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/resources/auth.dart';
import 'package:instagramclone/resources/utils.dart';
import 'package:instagramclone/screens/mobile/signUp.dart';
import 'package:instagramclone/widgest/text_field_input.dart';

import '../../const/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _paswordController.dispose();
  }

  void logInUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods()
        .logIn(email: _emailController.text, password: _paswordController.text);
    setState(() {
      isLoading = false;
    });
    if (res != "success") {
      showSnackBar("An error occured", context);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUp()));
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
              TextFieldInput(
                  hintText: 'Enter email adresss',
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter a paswword',
                textEditingController: _paswordController,
                textInputType: TextInputType.name,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: logInUser,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      )
                    : Container(
                        width: double.infinity,
                        height: 49,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: blueColor),
                        child: const Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              RichText(
                text: TextSpan(text: "Dont't have an account? ", children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = navigateToSignUp,
                      text: " Sign up",
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
