import 'dart:async';

import 'package:buttons/main.dart';
import 'package:buttons/screens/FinalLevel.dart';
import 'package:buttons/screens/level4.dart';
import 'package:buttons/screens/pageofinstructions.dart';
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
    'AAA': null,
    'AUG': null,
    'CGA': null,
    'UUC': null,
    'AGU': null,
    'GAU': null,
    'GGC': null,
    'UGA': null,
  };

  Map<String, String> temp = {
    'Met': 'AUG',
    'Lys': 'AAA',
    'Arg': 'CGA',
    'Phe': 'UUC',
    'Ser': 'AGU',
    'Asp': 'GAU',
    'Gly': 'GGC',
    'Stop': 'UGA',
  };
  Map<String, String> targets = {
    'AUG': 'Met',
    'AAA': 'Lys',
    'CGA': 'Arg',
    'UUC': 'Phe',
    'AGU': 'Ser',
    'GAU': 'Asp',
    'GGC': 'Gly',
    'UGA': 'Stop',
  };

  void checkMatch(String draggable, String target) {
    String? val1 = draggable;
    String val2 = target;

    if (val2 == val1) {
      // print('Match found: $draggable -> $target');
      setState(() {
        matches[draggable] = targets[target];
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
              Color.fromARGB(255, 48, 213, 200),
              Color.fromARGB(255, 48, 213, 200)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), // Background color
        padding: EdgeInsets.all(20.0), // Padding for the whole container
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Left Column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: matches.keys.map((draggable) {
                        return Draggable<String>(
                          data: draggable,
                          child: Container(
                            width: 120,
                            height: 48,
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255, 255, 200, 221), // Box background color
                                border: Border.all(
                                    color: Colors.black), // Box border color
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Center(
                              child: Text(
                                draggable,
                                style: TextStyle(
                                  fontSize: 20.0, // Font size
                                  fontWeight: FontWeight.bold, // Font weight
                                  color: const Color.fromARGB(
                                      255, 0, 0, 0), // Font color
                                ),
                              ),
                            ),
                          ),
                          feedback: Container(
                            width: 120,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255, 255, 200, 221), // Box background color
                                border: Border.all(
                                    color: Colors.black), // Box border color
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
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
                      children: targets.values.map((target) {
                        return DragTarget<String>(
                          builder: (BuildContext context,
                              List<String?> candidateData,
                              List<dynamic> rejectedData) {
                            final isMatched = matches[temp[target]] != null;

                            return Container(
                              width: 120,
                              height: 48,
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      10.0), // Margin between target boxes
                              decoration: BoxDecoration(
                                  color: isMatched
                                      ? Color.fromARGB(255, 10, 134, 15)
                                      : Colors.white, // Box background color
                                  border: Border.all(
                                      color: Colors.black), // Box border color
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Center(
                                child: Text(
                                  isMatched ? matches[temp[target]]! : target,
                                  style: TextStyle(
                                    fontSize: 20.0, // Font size
                                    fontWeight: FontWeight.bold, // Font weight
                                    color: Colors.black, // Font color
                                  ),
                                ),
                              ),
                            );
                          },
                          onWillAccept: (dragabble) =>
                              matches[dragabble!] == null,
                          onAccept: (draggable) {
                            checkMatch(draggable, temp[target]!);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
                if (!isTimeUp)
                  ElevatedButton(
                    onPressed: () {
                      // Implement logic to move to the next puzzle or action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpSplashScreen(
                              text: "Congratulations you completed the game😎",
                              imagePath: "assets/3danimations/congrats.json",
                              levelName: 6),
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AlertDialog(
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
