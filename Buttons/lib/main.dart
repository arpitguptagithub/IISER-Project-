import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:buttons/screens/level2.dart';
import 'package:flutter/material.dart';
import 'package:buttons/screens/pageofinstructions.dart';
import 'package:buttons/screens/level1.dart';
import 'package:buttons/screens/level3.dart';
import 'package:buttons/screens/level4.dart';
import 'package:buttons/screens/level5.dart';
import 'package:buttons/screens/FinalLevel.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Pairing Game',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pairing Game',
          style: TextStyle(
            fontSize: 24, // Adjust the font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // Text color
            letterSpacing: 1.5, // Adjust letter spacing
          ),
        ),
        centerTitle: true, // Center the app name
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Adjust gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Image.asset(
                        "assets/IIT.png"), // Replace with your image asset
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "X",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Image.asset(
                        "assets/II.png"), // Replace with your image asset
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Lottie.asset(
                'assets/3danimations/start_right.json',
                width: 300,
                height: 300,
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 18), // Button text style
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpSplashScreen(
                        text: "Find all word",
                        imagePath: "assets/3danimations/correct_ans.json",
                        levelName: 1,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.green, // Button background color
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: Text(
                  'Exit',
                  style: TextStyle(fontSize: 18), // Button text style
                ),
                onPressed: () {
                  exit(0);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.red, // Button background color
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 2'),
      ),
      body: Container(
        height: 400,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 300,
                color: Colors.purple[600],
                child: const Center(
                    child: Text(
                  'Item 1',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 200,
                color: Colors.purple[500],
                child: const Center(
                  child: Text(
                    'Item 2',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 200,
                  color: Colors.purple[400],
                  child: const Center(
                    child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 200,
                color: Colors.purple[300],
                child: const Center(
                  child: Text(
                    'Item 4',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthRoute extends StatelessWidget {
  const FourthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LevelTwo(),
    );
  }
}
