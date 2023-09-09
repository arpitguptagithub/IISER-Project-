import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class GuessTheImageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GuessTheImagePage(),
      ),
    );
  }
}

class GuessTheImagePage extends StatefulWidget {
  @override
  _GuessTheImagePageState createState() => _GuessTheImagePageState();
}

class _GuessTheImagePageState extends State<GuessTheImagePage> {
  final List<String> wordsToGuess = ['LION', 'TIGER', 'CHEETAH', 'LEOPARD'];
  final String correctAnswer = 'LION';

  List<String> selectedLetters = [];
  List<String> availableLetters = [];
  List<String> filledBoxes = List.filled(4, '');

  int timerSeconds = 60; // Set your desired countdown time here
  late Timer timer;
  bool isTimeUp = false;

  @override
  void initState() {
    super.initState();
    availableLetters = generateRandomLetters(correctAnswer);
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


  List<String> generateRandomLetters(String targetWord) {
    List<String> allLetters = targetWord.split('');
    List<String> randomLetters = [];

    while (allLetters.isNotEmpty) {
      int randomIndex = Random().nextInt(allLetters.length);
      randomLetters.add(allLetters[randomIndex]);
      allLetters.removeAt(randomIndex);
    }

    // Add extra random letters to fill the available letters box
    int lettersToAdd = max(6 - targetWord.length, 0);
    for (int i = 0; i < lettersToAdd; i++) {
      randomLetters.add(String.fromCharCode(Random().nextInt(26) + 'A'.codeUnitAt(0)));
    }

    return randomLetters;
  }

  Widget buildLetterButton(String letter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (filledBoxes.contains('')) {
            int emptyBoxIndex = filledBoxes.indexOf('');
            if (emptyBoxIndex < correctAnswer.length &&
                letter == correctAnswer[emptyBoxIndex]) {
              filledBoxes[emptyBoxIndex] = letter;
              selectedLetters.add(letter);
              availableLetters.remove(letter);
            }
          }
        });
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectedBoxes() {
    List<Widget> selectedBoxWidgets = filledBoxes.map((letter) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: selectedBoxWidgets,
    );
  }

  Widget buildAvailableLetters() {
    List<Widget> availableLetterWidgets = availableLetters.map((letter) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: buildLetterButton(letter),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: availableLetterWidgets,
    );
  }

  bool isAnswerCorrect() {
    return filledBoxes.join('') == correctAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Guess the Image'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Here
              Container(
                margin: EdgeInsets.all(16.0),
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/lion.jpg'), // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 16.0),
              // Empty boxes for guessing
              buildSelectedBoxes(),
              SizedBox(height: 16.0),
              // Available letters
              buildAvailableLetters(),
              SizedBox(height: 16.0),
              if (isAnswerCorrect())
                Text(
                  'Correct Answer: $correctAnswer',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to move to the next puzzle or action
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
