import 'package:flutter/material.dart';

// lib imports
import 'package:hangman_ieee_intromeet_2023_admin_app/services/firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // firestore instance
  Firestore firestore = Firestore();

  @override
  List<int> questionList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                firestore.startGame();
              },
              child: Text("start"),
            ),
            const SizedBox(height: 20),
            Column(
              children: questionList.map((element) {
                return Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          firestore.startQuestion(element);
                        },
                        child: Text("question$element")),
                    const SizedBox(width: 10)
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
