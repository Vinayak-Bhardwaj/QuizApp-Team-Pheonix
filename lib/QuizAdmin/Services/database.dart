import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz/QuizAdmin/Models/custom_user_data.dart';


class DatabaseService with ChangeNotifier{
  
  
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Map mappedDoc = {};
  List<Map> allQuizMappedDoc = [];
  List<Map> allQuizTakersMappedDoc = [];
  Map quizTakerMappedDoc = {};
  int numberOfQuiz;


  CustomUserData customUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustomUserData(
      uid: uid,
      name: snapshot['name'],
      phoneNumber: snapshot['phoneNumber'],
      emailId: snapshot['emailId'],

    );
  }
  

  //1. Get user data
  Future getData(String uid) async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('user').doc(uid).get();
    mappedDoc = doc.data() as Map;
  }

  //2. Get complete quiz list for an admin
  Future getAllQuizForAdmin(String uid) async {
    QuerySnapshot doc = await FirebaseFirestore.instance.collection('user').doc(uid).collection('quizesConducted').get();
    allQuizMappedDoc = doc.docs.cast();
    // if not work try type casting as List
  }


  //3. Get complete quiz takers list for an admin and for a particular quiz
  Future getAllQuizTakerForAQuiz(String uid, String quizIndex) async {
    QuerySnapshot doc = await FirebaseFirestore.instance.collection('user').doc(uid).collection('quizesConducted').doc(quizIndex).collection('quizTakers').get();
    allQuizTakersMappedDoc = doc.docs.cast();
  }


  //4. Get a quiz taker data for an admin and for a particular quiz
  Future getQuizTakerData(String uid, String quizIndex, String takerIndex) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('user').doc(uid).collection('quizesConducted').doc(quizIndex).collection('quizTakers').doc(takerIndex).get();
    quizTakerMappedDoc = doc.data() as Map;
  }


  //1. To update user data after registration
  Future<void> updateUserData(String name, String emailId, String phoneNo) async {
     await userCollection.doc(uid).set({
      'name': name,
      'emailId': emailId,
      'phoneNo': phoneNo,
    });
    notifyListeners();
  }


  //2. To update the quiz data after creating a quiz
  Future<void> updateQuizData(String uid, String quizIndex, String quizName, List<Map> quizData) async {
    try {
      await userCollection.doc(uid).collection('quizesConducted').doc(quizIndex).set({
        'quizId': quizIndex,
        'quizName': quizName,
        'quesAnsData': quizData.toString(),
      });
      notifyListeners();
    } catch(e) {
      print(e.toString());
    }
  }


  //3. To update quiz taker data after giving a quiz
  Future<void> updateQuizTakerData(String uid, String quizIndex, String quizTakerIndex,String takerName, String score) async {
    try{
      await userCollection.doc(uid).collection('quizesConducted').doc(quizIndex).collection('quizTakers').doc(quizTakerIndex).set({
        'name': takerName,
        'score': score,
      });
      notifyListeners();
    } catch(e) {
      print(e.toString());
    }
  }


  //4. Get number of quizes for indexing
  Future<void> getNumberOfQuizes(String uid) async {
    QuerySnapshot doc = await userCollection.doc(uid).collection('quizesConducted').get();
    numberOfQuiz = doc.docs.length;
  }


}