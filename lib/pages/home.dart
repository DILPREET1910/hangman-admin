import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

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
    List<int> questionList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Column(
              children: questionList.map((element) {
                return FutureBuilder(
                  future: firestore.getQuestion(element),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: snapshot.data! ? Colors.green : Colors.red),
                        onPressed: () async {
                          await firestore.startQuestion(element);
                          setState(() {});
                        },
                        child: Text(
                          "question$element",
                          style: GoogleFonts.ubuntu(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      return SpinKitCircle(color: Colors.grey[900]);
                    }
                  },
                );
              }).toList(),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                firestore.reset();
              },
              child: Text(
                "reset",
                style: GoogleFonts.ubuntu(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
