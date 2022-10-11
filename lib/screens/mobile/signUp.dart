import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/resources/auth.dart';
import 'package:instagramclone/resources/utils.dart';

import '../../const/colors.dart';
import '../../widgest/text_field_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Uint8List? chosenImage;

  final TextEditingController _bio = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _bio.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      chosenImage = image;
    });
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
                children: [
                  chosenImage!=null? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(chosenImage!),
                  ):
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://st.depositphotos.com/2218212/2938/i/450/depositphotos_29387653-stock-photo-facebook-profile.jpg'),
                  ),
                  Positioned(
                      bottom: -10,
                      right: 0,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo)))
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
              GestureDetector(
                onTap: () => AuthMethods().signUpUser(
                    username: _username.text,
                    email: _email.text,
                    password: _password.text,
                    bio: _bio.text,
                    pics: chosenImage!
                    )
                     ,

                child: Container(
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
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              RichText(
                text: TextSpan(text: "Already have an account? ", children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() => print("Log in")),
                      text: " Log in",
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ]),
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
