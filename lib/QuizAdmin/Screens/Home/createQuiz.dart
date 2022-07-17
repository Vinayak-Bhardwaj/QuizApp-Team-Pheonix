import 'package:flutter/material.dart';
import 'package:quiz/QuizAdmin/Screens/Home/addQuesAns.dart';
import 'package:quiz/QuizAdmin/Shared/input_fields.dart';
import 'package:quiz/QuizAdmin/Shared/rounded_button.dart';

class CreateQuiz extends StatefulWidget {
  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  @override
  Widget build(BuildContext context) {

    String error = '';
    String quizName = '';
    String quizDesc = '';

    return Container(
      //child: SingleChildScrollView(
        //physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 30,),

            InputField(
              hintText: "Quiz Name",
              changed: (val) {
                setState(() {
                  quizName = val;
                });
              },
              icon: Icons.person,
              valid: (val) {
                if (val != null) {
                  return val.length == 0 ? 'Enter Quiz Name!' : null;
                } else {
                  error = "Enter Quiz Name!";
                }
              },
            ),

            SizedBox(height: 10,),

            InputField(
              hintText: "Quiz Description",
              changed: (val) {
                setState(() {
                  quizDesc = val;
                });
              },
              icon: Icons.person,
              valid: (val) {
                if (val != null) {
                  return val.length == 0 ? 'Enter Quiz Description' : null;
                } else {
                  error = "Enter Quiz Description";
                }
              },
            ),

            SizedBox(height: 40),

            RoundedButton(
              text: "Create Quiz",
              pressed: () {
                Navigator.pushNamed(context, '/AddQuesAns', arguments: {'QuizName': quizName});
              },
            ),
          ],
        ),
      //),
    );
  }
}
