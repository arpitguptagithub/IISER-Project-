import 'package:buttons/main.dart';
import 'package:buttons/screens/level1.dart';
import 'package:buttons/screens/level3.dart';
import 'package:buttons/screens/level5.dart';
import 'package:buttons/screens/pageofinstructions.dart';
import 'package:crossword/crossword.dart';
import 'package:lottie/lottie.dart';

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(DNAPairingApp());
}

int Strands_num = 4;
bool NextButton = false;

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
  var Letters = ['A', 'T', 'G', 'C', 'A', 'T', 'G', 'C'];

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

  void checkAndClearIfIncorrect() {
    int countFinal = 0;
    Map<String, String> DNA_Bases = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G'};
    // List<String> DNA_bases = ['A', 'G', 'T', 'C'];
    for (int i = 0; i < row1Controllers.length; i++) {
      final String char1 = Letters[i];
      final String char2 = row2Controllers[i].text.toUpperCase();

      if (char1.isNotEmpty && char2.isNotEmpty && char1 != char2) {
        if (DNA_Bases.containsKey(char1) && DNA_Bases[char1] == char2) {
          countFinal += 1;
        } else {
          // Clear both boxes if there's a mismatch - which will be there as joint bases can't be same - refer: google
          // row1Controllers[i].clear();
          row2Controllers[i].clear();
        }
      } else {
        // Clear both boxes if there's a mismatch - which will be there as joint bases can't be same - refer: google
        // row1Controllers[i].clear();
        row2Controllers[i].clear();
      }
    }
    print(countFinal);
    if (countFinal == 8) {
      DisplayLevelComplete();
      NextButton = true;
    }
  }

  void DisplayLevelComplete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level Complete'),
          content: Text('You have completed the level'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpSplashScreen(
                        text: "Match the following",
                        imagePath: "imagePath",
                        levelName: 4),
                  ),
                ); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DNA Pairing'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              textAlign: TextAlign.center,
              'Timer: ${timerSeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
        leading: BackButton(onPressed: () {
          // Handle back button press
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuessTheImageApp(),
            ),
          );
        }),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 197, 205, 213),
              Color.fromARGB(255, 178, 174, 174)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Lottie.asset('assets/3danimations/animation_lmi4qgx8.json'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      // First Row of Boxes
                      Expanded(
                        child: Column(
                          children: List.generate(
                            row1Controllers.length,
                            (index) => Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 212, 22, 22),
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: Center(
                                child: Text(
                                  Letters[index],
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 24, // Font size
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // CustomPaint to draw lines between boxes in the row
                      CustomPaint(
                        size: Size(20, 400),
                        painter: MyPainter(),
                      ),
                      // Second Row of Boxes with Reverse after 4th element
                      Expanded(
                        child: Column(
                          children: [
                            // Rows 1 to 4
                            ...List.generate(
                              8,
                              (index) => Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(8),
                                child: TextField(
                                  controller: row2Controllers[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (text) {
                                    // Convert the entered text to uppercase
                                    text = text.toUpperCase();
                                    row2Controllers[index].value =
                                        row2Controllers[index].value.copyWith(
                                              text: text,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: text.length),
                                            );
                                  },
                                  enableInteractiveSelection: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
// Buttons (check pair and next)

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 16), // Add spacing between buttons
                      ElevatedButton(
                        onPressed: () {
                          checkAndClearIfIncorrect(); // Checking the pairs
                        },
                        child: const Text(
                          'Check Pairs',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      // SizedBox(width: 16), // Add spacing between buttons

                      // if (!isTimeUp)
                      //   ElevatedButton(
                      //     onPressed: () {
                      //       // Implement logic to move to the next puzzle or action
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => HelpSplashScreen(
                      //               text: "Match the following",
                      //               imagePath: "imagePath",
                      //               levelName: 4),
                      //         ),
                      //       );
                      //     },
                      //     child: const Text(
                      //       'Next',
                      //       style: TextStyle(
                      //         fontSize: 18.0,
                      //       ),
                      //     ),
                      //   ),
                    ],
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
            ],
          ),
        ),
      ),
    );
  }
}

// For Vertical Line (See UI which you want)

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0;

//     // Draw lines connecting boxes in the row
//     canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0; // Adjust the line thickness as needed

    // Calculate the number of lines needed based on the box count in each row
    int rowCount = 8; // You can adjust this based on your actual row count
    // int boxCountPerRow =
    //     2 * Strands_num; // Assuming the same box count for all rows
    double lineHeight = size.height / (rowCount - 1);

    // Draw horizontal lines connecting boxes in all rows
    for (int i = 0; i < rowCount; i++) {
      double y = i * lineHeight;
      canvas.drawLine(
          Offset(-size.width * 4.0, y), Offset(size.width * 4.0, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
