import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz/QuizAdmin/Shared/rounded_button.dart';

class UserWrapper extends StatefulWidget {
  @override
  State<UserWrapper> createState() => _UserWrapperState();
}

class _UserWrapperState extends State<UserWrapper> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,   
                children: <Widget>[
                  SizedBox(height: 30),
                  
                  Text("Quizyyyy", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Billabong', fontSize: 60)),
                  
                  SizedBox(height: 30),
                  
                  SvgPicture.asset(
                    "assets/login.svg",
                    height: size.height * 0.35,
                  ),
                  
                  SizedBox(height: size.height * 0.03),

                  RoundedButton(text: "Quiz Admin", pressed: (){
                    Navigator.pushNamed(context, '/AdminAuthWrapper');
                  }),

                  SizedBox(height: size.height * 0.03),

                  RoundedButton(text: "Quiz Taker", pressed: (){
                    Navigator.pushNamed(context, '/TakerEnterDetails');
                  }),
                ],            
              ),
            ),
          ],
        ),
      ),
    );
  }
}
