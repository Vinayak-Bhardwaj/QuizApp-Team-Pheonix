import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/QuizAdmin/Screens/Home/user_information.dart';


class AdminProfile extends StatefulWidget {
  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size.height*0.0609),
          Image.asset("assets/profile2edited.jpg", height: size.height*0.2804),
          Divider(
            height: size.height*0.07317,
            indent: size.width*0.1216,
            endIndent: size.width*0.1216,
            color: Colors.grey,
            thickness: 1.0,
          ),
          UserInformation(),
        ],
      ),
    );
  }
}