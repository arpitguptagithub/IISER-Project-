import 'dart:io';

import 'package:buttons/screens/level2.dart';
import 'package:flutter/material.dart';
import 'package:buttons/screens/level1.dart';
import 'package:buttons/screens/level3.dart';
import 'package:buttons/screens/level4.dart';
import 'package:buttons/screens/level5.dart';
import 'package:buttons/screens/FinalLevel.dart';




// import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('First Route'),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image0.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Start'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondRoute(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  // onPressed: () {},
                  // child: const Text("Exit"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Temp1'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuessTheImageApp(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Temp2'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FourthRoute(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Exit'),
                  onPressed: () {
                    exit(0);
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
            ],
          ),
        ),
        // child: Center(
        //   child: ElevatedButton(
        //     child: Text('Start'),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const SecondRoute()),
        //       );
        //     },
        //     style: ElevatedButton.styleFrom(
        //         fixedSize: const Size(250, 60),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(30),
        //         )),
        //   ),
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
      body:
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('Go back fool!'),
          // ),
          Container(
        // color: Colors.grey,
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Level 2'),
    //   ),
    // );
    return MaterialApp(
      home: LevelTwo(),
    );
  }
}
