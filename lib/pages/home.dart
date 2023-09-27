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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TextButton(
          onPressed: () {
            firestore.startGame();
          },
          child: Text("start"),
        ),
      ),
    );
  }
}
