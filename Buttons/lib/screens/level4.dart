import 'dart:async';

import 'package:buttons/screens/level1.dart';
import 'package:buttons/screens/level3.dart';
import 'package:buttons/screens/level5.dart';
import 'package:crossword/crossword.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DNAPairingApp());
}

int Strands_num = 4;

class DNAPairingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DNAPairingPage(),
      ),
    );
  }
}

class DNAPairingPage extends StatefulWidget {
  @override
  _DNAPairingPageState createState() => _DNAPairingPageState();
}

class _DNAPairingPageState extends State<DNAPairingPage> {


  int timerSeconds = 60; // Set your desired countdown time here
  late Timer timer;
  bool isTimeUp = false;

  @override
  void initState() {
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerSeconds > 0) {
          timerSeconds--;
        } else {
          timer.cancel();
          isTimeUp = true;
        }
      });
    });
  }


  List<TextEditingController> row1Controllers = List.generate(
    2 * Strands_num,
    (index) => TextEditingController(),
  );

  List<TextEditingController> row2Controllers = List.generate(
    2 * Strands_num,
    (index) => TextEditingController(),
  );

  //Edit this function for checking complementary pairings of DNA
  void checkAndClearIfIncorrect() {
    List<String> DNA_bases = ['A', 'G', 'T', 'C'];
    for (int i = 0; i < row1Controllers.length; i++) {
      final String char1 = row1Controllers[i].text.toUpperCase();
      final String char2 = row2Controllers[i].text.toUpperCase();

      if (char1.isNotEmpty && char2.isNotEmpty && char1 != char2) {
        if (char1 == DNA_bases[i % 4] && char2 == DNA_bases[(i + 2) % 4]) {
          // Do nothing if the pair is correct
        } else if (char2 == DNA_bases[i % 4] &&
            char1 == DNA_bases[(i + 2) % 4]) {
          // Do nothing if the pair is correct
        } else if (char1 == DNA_bases[i % 4] &&
            char2 == DNA_bases[(i + 3) % 4]) {
          // Do nothing if the pair is correct
        } else if (char2 == DNA_bases[i % 4] &&
            char1 == DNA_bases[(i + 3) % 4]) {
          // Do nothing if the pair is correct
        } else if (char1 == DNA_bases[(i + 1) % 4] &&
            char2 == DNA_bases[(i + 2) % 4]) {
          // Do nothing if the pair is correct
        } else if (char2 == DNA_bases[(i + 1) % 4] &&
            char1 == DNA_bases[(i + 2) % 4]) {
          // Do nothing if the pair is correct
        } else if (char1 == DNA_bases[(i + 1) % 4] &&
            char2 == DNA_bases[(i + 3) % 4]) {
          // Do nothing if the pair is correct
        } else if (char2 == DNA_bases[(i + 1) % 4] &&
            char1 == DNA_bases[(i + 3) % 4]) {
          // Do nothing if the pair is correct
        } else if (char1 == DNA_bases[(i + 2) % 4] &&
            char2 == DNA_bases[(i + 3) % 4]) {
          // Do nothing if the pair is correct
        } else if (char2 == DNA_bases[(i + 2) % 4] &&
            char1 == DNA_bases[(i + 3) % 4]) {
          // Do nothing if the pair is correct
        } else if (char1 == DNA_bases[(i + 3) % 4] &&
            char2 == DNA_bases[(i + 1) % 4]) {
          // Do nothing if the pair is correct
        } else if (char2 == DNA_bases[(i + 3) % 4] &&
            char1 == DNA_bases[(i + 1) % 4]) {
          // Do nothing if the pair is correct
        } else if (char1 == DNA_bases[(i + 3) % 4] &&
            char2 == DNA_bases[(i + 2) % 4]) {
          // Do nothing if the pair is correct
        }
        // Clear both boxes if there's a mismatch
        else {
          row1Controllers[i].clear();
          row2Controllers[i].clear();
        }
      } else {
        // Clear both boxes if there's a mismatch - which will be there as joint bases can't be same - refer: google
        row1Controllers[i].clear();
        row2Controllers[i].clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('DNA Pairing'),
          centerTitle: true,
          actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Timer: ${timerSeconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 20),
              ),
            ),
          ],
          leading:  BackButton(onPressed:  (){
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuessTheImageApp(),
            ),
          );
            })
        ),
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            // First Row of Boxes
            Row(
              children: List.generate(
                row1Controllers.length,
                (index) => Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: row1Controllers[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Second Row of Boxes
            Row(
              children: List.generate(
                row2Controllers.length,
                (index) => Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(8),
                  //align this to have spiral effect can use stack to alling and give spiral effect
                  child: TextField(
                    controller: row2Controllers[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Check Button
            ElevatedButton(
              onPressed: () {
                checkAndClearIfIncorrect(); // Check and clear if pairs are incorrect
              },
              child: Text(
                'Check Pairs',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // Implement logic to move to the next puzzle or action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchingApp(),
                      ),
                    );
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
    );
  }
}
