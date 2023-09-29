import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Firestore {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<void> startGame() async {
    Future<DocumentSnapshot> startGame =
        firestoreInstance.collection("admin").doc("startGame").get();
    bool start = false;

    // get value
    await startGame.asStream().forEach((element) {
      start = element.get("start");
    });

    try {
      await firestoreInstance.collection("admin").doc("startGame").update({"start": !start});
    } on FirebaseException catch (error) {
      print("Error while toggling game status: $error");
    }
  }

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
