import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:quiz/QuizAdmin/Screens/Authenticate/Register/register.dart';
import 'package:quiz/QuizAdmin/Screens/Authenticate/SignIn/sign_in.dart';
import 'package:quiz/QuizAdmin/Screens/Home/addQuesAns.dart';
import 'package:quiz/QuizAdmin/Screens/Home/home.dart';
import 'package:quiz/QuizAdmin/Screens/wrapper.dart';
import 'package:quiz/QuizAdmin/Services/auth.dart';
import 'package:quiz/QuizAdmin/Services/database.dart';
//import 'package:quiz/QuizTaker/Screens/enterDetails.dart';
import 'package:quiz/QuizTaker/screens/welcome/welcome_screen.dart';
import 'package:quiz/userWrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AdminAuthService _auth = AdminAuthService();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AdminAuthService()),
      ChangeNotifierProvider(create: (context) => DatabaseService(uid: _auth.currentUser().uid)),
    ],   
    child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AdminAuthService>(context);
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => UserWrapper(),
        '/AdminSignIn': (context) => auth.loggedIn ? AdminHome() : AdminSignIn(), // Data to be added
        '/AdminRegister': (context) => auth.loggedIn ? AdminHome() : AdminRegister(),
        '/AdminHome': (context) => auth.loggedIn ? AdminHome() : AdminSignIn(),
        '/AdminAuthWrapper': (context) => AdminWrapper(),
        '/TakerEnterDetails': (context) => WelcomeScreen(),
        '/AddQuesAns': (context) => AddQuesAns(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6F35A5),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}