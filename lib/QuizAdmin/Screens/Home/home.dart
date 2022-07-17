import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/QuizAdmin/Screens/Home/createQuiz.dart';
import 'package:quiz/QuizAdmin/Screens/Home/dashboard.dart';
import 'package:quiz/QuizAdmin/Screens/Home/profile.dart';
import 'package:quiz/QuizAdmin/Services/auth.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  int page = 0;

  List<String> appBar = [
    "Quizzy",
    "Dashboard",
    "Profile"
  ];

  @override
  Widget build(BuildContext context) {

    final _auth = Provider.of<AdminAuthService>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBar[page], style: TextStyle(fontFamily: (page != 0) ?  'Acme' : 'Billabong', fontSize: (page != 0) ? 21 : 40)),
        backgroundColor: Colors.indigo[400],
        elevation: 50.0,
        shadowColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              _auth.signOut();
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/signup_top.png",
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
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            //SingleChildScrollView(
               (page == 0) ? CreateQuiz() : (page == 1) ? AdminDashboard() : AdminProfile(),
            //),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          height: size.height*0.073,
          buttonBackgroundColor: Colors.red[100],
          backgroundColor: Colors.white10,
          color: Colors.grey,
          items: <Widget>[
            ImageIcon(
              AssetImage("assets/news2.png"),
              size: size.height*0.03902,
            ),
            ImageIcon(
              AssetImage("assets/news3.png"),
              size: size.height*0.03902,
            ),
            ImageIcon(
              AssetImage("assets/newspaper.png"),
              size: size.height*0.03902,
            ),
          ],
          animationDuration: Duration(milliseconds: 500),
          animationCurve: Curves.linearToEaseOut,
          onTap: (index) {
            setState(() {
              page = index;
            });
          }),
    );
  }
}