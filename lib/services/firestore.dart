import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Firestore {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<void> startQuestion(int questionNumber) async {
    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection("admin").doc("questions").get();

    bool currentQuestion = await documentSnapshot.get(questionNumber.toString());

    try {
      await firestoreInstance
          .collection("admin")
          .doc("questions")
          .update({questionNumber.toString(): !currentQuestion});
    } on FirebaseException catch (error) {
      print("Error while toggling question status : $error");
    }
  }
}
