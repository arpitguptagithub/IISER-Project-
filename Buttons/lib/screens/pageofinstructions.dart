import 'package:buttons/main.dart';
import 'package:buttons/screens/level3.dart';
import 'package:buttons/screens/level4.dart';
import 'package:buttons/screens/level5.dart';
import 'package:flutter/material.dart';
import 'package:buttons/screens/level1.dart';
import 'package:buttons/screens/level3part2.dart';
import 'package:lottie/lottie.dart';


class HelpSplashScreen extends StatelessWidget {
  final String text;
  final String imagePath;
  final int levelName;
  final LW = {
    "Crossword": CrosswordApp(),
  };
  HelpSplashScreen({
    required this.text,
    required this.imagePath,
    required this.levelName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // add the animations ot whatever you feel

              SizedBox(height: 16.0),
              Lottie.asset(imagePath, width: 200.0),
              SizedBox(height: 16.0),
              Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
               SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (levelName == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrosswordApp()));
                  }
                  if (levelName == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuessTheImageApp()));
                  }
                  if (levelName == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DNAPairingApp()));
                  }
                  if (levelName == 4) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RNAPairingApp()));
                  }
                  if (levelName == 5) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MatchingApp()));
                  }
                  // if (levelName == 6) {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => FinalLevel()));
                  // }
                  if (levelName == 6) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FirstRoute()));
                  }
                  // Implement logic to move to the next puzzle or action
                },
               
                child: const Text(
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
