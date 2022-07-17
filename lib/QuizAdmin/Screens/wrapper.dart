import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/QuizAdmin/Screens/Authenticate/SignIn/sign_in.dart';
import 'package:quiz/QuizAdmin/Screens/Home/home.dart';
import 'package:quiz/QuizAdmin/Services/auth.dart';

class AdminWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AdminAuthService>(context);
    return !auth.loggedIn ? AdminSignIn() : AdminHome();
  }
}