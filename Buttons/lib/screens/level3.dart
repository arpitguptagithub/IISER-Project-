import 'dart:async';

import 'package:buttons/main.dart';
import 'package:buttons/screens/FinalLevel.dart';
import 'package:buttons/screens/level4.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Navigation Basics',
//     home: MaterialApp(),
//   ));
// }

class MatchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MatchingPage(),
      ),
    );
  }
}

class MatchingPage extends StatefulWidget {
  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  int timerSeconds = 60; // Set your desired countdown time here
  late Timer timer;
  bool isTimeUp = false;

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

  Map<String, String?> matches = {
    'A': null,
    'B': null,
    'C': null,
    'D': null,
    'E': null,
  };

  Map<String, String> targets = {
    'A': 'Apple',
    'B': 'Banana',
    'C': 'Cat',
    'E': 'ElevatedButton',
    'D': 'Dog',
  };

  void checkMatch(String draggable, String target) {
    if (draggable.trim() == target.trim()) {
      setState(() {
        matches[draggable] = target;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Matching Game'),
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
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DNAPairingApp(),
              ),
            );
          })),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 197, 205, 213),
              Color.fromARGB(255, 178, 174, 174)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), // Background color
        padding: EdgeInsets.all(20.0), // Padding for the whole container
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Left Column
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: matches.keys.map((draggable) {
                  return Draggable<String>(
                    data: draggable,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent, // Box background color
                        border:
                            Border.all(color: Colors.black), // Box border color
                      ),
                      child: Center(
                        child: Text(
                          draggable,
                          style: TextStyle(
                            fontSize: 20.0, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                            color: Colors.white, // Font color
                          ),
                        ),
                      ),
                    ),
                    feedback: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent, // Box background color
                        border:
                            Border.all(color: Colors.black), // Box border color
                      ),
                      child: Center(
                        child: Text(
                          draggable,
                          style: TextStyle(
                            fontSize: 20.0, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                            color: Colors.white, // Font color
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(),
                  );
                }).toList(),
              ),
              // Right Column
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: targets.keys.map((target) {
                  return DragTarget<String>(
                    builder: (BuildContext context, List<String?> candidateData,
                        List<dynamic> rejectedData) {
                      final isMatched = matches[target] != null;

                      return Container(
                        width: 150,
                        height: 60,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0), // Margin between target boxes
                        decoration: BoxDecoration(
                          color: isMatched
                              ? Colors.green
                              : Colors.white, // Box background color
                          border: Border.all(
                              color: Colors.black), // Box border color
                        ),
                        child: Center(
                          child: Text(
                            isMatched ? matches[target]! : target,
                            style: TextStyle(
                              fontSize: 20.0, // Font size
                              fontWeight: FontWeight.bold, // Font weight
                              color: Colors.black, // Font color
                            ),
                          ),
                        ),
                      );
                    },
                    onWillAccept: (draggable) => matches[draggable!] == null,
                    onAccept: (draggable) {
                      checkMatch(draggable!, target);
                    },
                  );
                }).toList(),
              ),
              if (!isTimeUp)
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to move to the next puzzle or action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalLevel(),
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
              if (isTimeUp)
                AlertDialog(
                  title: Text('TIME UP....'),
                  content: Text('GO TO THE HOME PAGE AND START AGAIN....'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstRoute(),
                          ),
                        ); // Close the dialog
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
