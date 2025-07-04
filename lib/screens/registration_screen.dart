import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.0),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 12.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                  onChanged: (value) => email = value,
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 12.0),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  ),
                  onChanged: (value) => password = value,
                ),
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: 'Register',
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final userCredential = await _auth
                        .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                    if (userCredential.user != null) {
                      navigator.pushNamed(ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    developer.log(
                      'Something went wrong',
                      name: 'register',
                      error: e,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
