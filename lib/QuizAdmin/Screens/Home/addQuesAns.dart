import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/QuizAdmin/Services/auth.dart';
import 'package:quiz/QuizAdmin/Services/database.dart';
import 'package:quiz/QuizAdmin/Shared/input_fields.dart';
import 'package:quiz/QuizAdmin/Shared/loading.dart';
import 'package:quiz/QuizAdmin/Shared/rounded_button.dart';

class AddQuesAns extends StatefulWidget {
  @override
  State<AddQuesAns> createState() => _AddQuesAnsState();
}

class _AddQuesAnsState extends State<AddQuesAns> {
  final _formKey = GlobalKey<FormState>();
  String question, op1, op2, op3, op4, correctAns;
  Map<String, dynamic> quesAns = {
    'question': '',
    'option1': '',
    'option2': '',
    'option3': '',
    'option4': '',
  };
  int numberOfQuiz = 0;
  List<Map> quizData = [];
  bool loading = false;
  String quizDesc = '';
  String error = '';

  // Future<void> getData() async {
  //   String uid = _auth.currentUser().uid;
  //   await _database.getNumberOfQuizes(uid);
  //   numberOfQuiz = _database.numberOfQuiz;
  // }

  @override
  Widget build(BuildContext context) {
    final _database = Provider.of<DatabaseService>(context);
    final _auth = Provider.of<AdminAuthService>(context);

    Size size = MediaQuery.of(context).size;

    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Add Ques Ans",
                  style: TextStyle(fontFamily: 'Acme', fontSize: 21)),
              backgroundColor: Colors.indigo[400],
              elevation: 50.0,
              shadowColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    //_auth.signOut();
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
                    left: 0,
                    child: Image.asset(
                      "assets/main_bottom.png",
                      width: size.width * 0.25,
                    ),
                  ),
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Text(
                              (quizData.length + 1).toString(),
                              style:
                                  TextStyle(fontFamily: 'Acme', fontSize: 21),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              initialValue: '',
                              validator: (val) =>
                                  val.isEmpty ? "Enter the question" : null,
                              decoration: InputDecoration(
                                hintText: "Question",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  question = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: '',
                              validator: (val) =>
                                  val.isEmpty ? "Enter option 1" : null,
                              decoration: InputDecoration(
                                hintText: "Option 1 (Correct answer)",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  op1 = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: '',
                              validator: (val) =>
                                  val.isEmpty ? "Enter option 2" : null,
                              decoration: InputDecoration(
                                hintText: "Option 2",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  op2 = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: '',
                              validator: (val) =>
                                  val.isEmpty ? "Enter option 3" : null,
                              decoration: InputDecoration(
                                hintText: "Option 3",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  op3 = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: '',
                              validator: (val) =>
                                  val.isEmpty ? "Enter option 4" : null,
                              decoration: InputDecoration(
                                hintText: "Option 4",
                              ),
                              onChanged: (val) {
                                setState(() {
                                  op4 = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            RoundedButton(
                              text: "Add Question",
                              pressed: () {
                                // uploadQuesData(
                                //     question, op1, op2, op3, op4, correctAns);
                                if (_formKey.currentState.validate()) {
                                  quesAns['question'] = question;
                                  quesAns['option1'] = op1;
                                  quesAns['option2'] = op2;
                                  quesAns['option3'] = op3;
                                  quesAns['option4'] = op4;
                                  //quesAns['correct_ans'] = correctAns;

                                  quizData.add(quesAns);

                                  setState(() {
                                    _formKey.currentState.reset();
                                  });
                                }
                              },
                            ),
                            //SizedBox(height: 10),
                            RoundedButton(
                              text: "Submit",
                              pressed: () async {
                                setState(() {
                                  loading = true;
                                });

                                //dynamic result = await uploadQuizData(quizData);

                                String uid = _auth.currentUser().uid;
                                await _database.getNumberOfQuizes(uid);
                                numberOfQuiz = _database.numberOfQuiz;
                                await _database.updateQuizData(
                                    uid,
                                    numberOfQuiz.toString(),
                                    arguments['QuizName'],
                                    quizData);

                                Navigator.pushNamed(context, '/AdminHome');

                                setState(() {
                                  loading = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // FutureBuilder(
                  //     //future: getData(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.done) {
                  //         return SingleChildScrollView(
                  //           physics: AlwaysScrollableScrollPhysics(),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(20.0),
                  //             child: Form(
                  //               key: _formKey,
                  //               child: Column(
                  //                 children: <Widget>[
                  //                   Text(
                  //                     (quizData.length + 1).toString(),
                  //                     style: TextStyle(
                  //                         fontFamily: 'Acme', fontSize: 21),
                  //                   ),
                  //                   SizedBox(height: 10),
                  //                   TextFormField(
                  //                     validator: (val) => val.isEmpty
                  //                         ? "Enter the question"
                  //                         : null,
                  //                     decoration: InputDecoration(
                  //                       hintText: "Question",
                  //                     ),
                  //                     onChanged: (val) {
                  //                       setState(() {
                  //                         question = val;
                  //                       });
                  //                     },
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   TextFormField(
                  //                     validator: (val) =>
                  //                         val.isEmpty ? "Enter option 1" : null,
                  //                     decoration: InputDecoration(
                  //                       hintText: "Option 1 (Correct answer)",
                  //                     ),
                  //                     onChanged: (val) {
                  //                       setState(() {
                  //                         op1 = val;
                  //                       });
                  //                     },
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   TextFormField(
                  //                     validator: (val) =>
                  //                         val.isEmpty ? "Enter option 2" : null,
                  //                     decoration: InputDecoration(
                  //                       hintText: "Option 2",
                  //                     ),
                  //                     onChanged: (val) {
                  //                       setState(() {
                  //                         op2 = val;
                  //                       });
                  //                     },
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   TextFormField(
                  //                     validator: (val) =>
                  //                         val.isEmpty ? "Enter option 3" : null,
                  //                     decoration: InputDecoration(
                  //                       hintText: "Option 3",
                  //                     ),
                  //                     onChanged: (val) {
                  //                       setState(() {
                  //                         op3 = val;
                  //                       });
                  //                     },
                  //                   ),
                  //                   SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   TextFormField(
                  //                     validator: (val) =>
                  //                         val.isEmpty ? "Enter option 4" : null,
                  //                     decoration: InputDecoration(
                  //                       hintText: "Option 4",
                  //                     ),
                  //                     onChanged: (val) {
                  //                       setState(() {
                  //                         op4 = val;
                  //                       });
                  //                     },
                  //                   ),
                  //                   SizedBox(
                  //                     height: 50,
                  //                   ),
                  //                   RoundedButton(
                  //                     text: "Add Question",
                  //                     pressed: () {
                  //                       // uploadQuesData(
                  //                       //     question, op1, op2, op3, op4, correctAns);
                  //                       if (_formKey.currentState.validate()) {
                  //                         quesAns['question'] = question;
                  //                         quesAns['option1'] = op1;
                  //                         quesAns['option2'] = op2;
                  //                         quesAns['option3'] = op3;
                  //                         quesAns['option4'] = op4;
                  //                         //quesAns['correct_ans'] = correctAns;

                  //                         quizData.add(quesAns);
                  //                       }
                  //                     },
                  //                   ),
                  //                   //SizedBox(height: 10),
                  //                   RoundedButton(
                  //                     text: "Submit",
                  //                     pressed: () async {
                  //                       setState(() {
                  //                         loading = true;
                  //                       });

                  //                       //dynamic result = await uploadQuizData(quizData);

                  //                       String uid = _auth.currentUser().uid;
                  //                       await _database.getNumberOfQuizes(uid);
                  //                       numberOfQuiz = _database.numberOfQuiz;
                  //                       await _database.updateQuizData(
                  //                           uid,
                  //                           numberOfQuiz.toString(),
                  //                           arguments['QuizName'],
                  //                           quizData);

                  //                       Navigator.pushNamed(
                  //                           context, '/AdminHome');

                  //                       setState(() {
                  //                         loading = false;
                  //                       });
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       } else {
                  //         return CircularProgressIndicator();
                  //       }
                  //     }),
                ],
              ),
            ),
          );
  }
}
