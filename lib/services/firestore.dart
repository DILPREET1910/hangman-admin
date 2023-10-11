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

  Future<bool> getQuestion(int questionNumber) async {
    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection("admin").doc("questions").get();
    bool status = false;

    try {
      status = await documentSnapshot.get(questionNumber.toString());
    } on FirebaseException catch (error) {
      print("Error while getting question status: $error");
    }
    return status;
  }

  Future<void> reset() async {
    try {
      for (int i = 1; i < 5; i++) {
        await firestoreInstance.collection("teamCount").doc("audi $i").update({
          "count": 0,
          "score": 0,
        });
      }
    } on FirebaseException catch (error) {
      print("Error while resetting: $error");
    }
  }
}
