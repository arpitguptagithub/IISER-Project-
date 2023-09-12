import 'dart:async';

import 'package:buttons/screens/level4.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CrosswordApp());
}

class CrosswordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      
      ),
      home: Scaffold(
        body: SafeArea(
          child: CrosswordGrid(),
        ),
      ),
    );
  }
}

class CrosswordGrid extends StatefulWidget {
  @override
  _CrosswordGridState createState() => _CrosswordGridState();
}

class _CrosswordGridState extends State<CrosswordGrid> {

  int timerSeconds = 60; // Set your desired countdown time here
  late Timer timer;
  bool isTimeUp = false;

  

  final List<List<String>> puzzleGrid = [
    ['D', 'N', 'A', 'T', 'R', 'A', 'N', 'S', 'C', 'R', 'I', 'P', 'T', 'I', 'O', 'N'],
    ['N', 'U', 'C', 'L', 'E', 'O', 'T', 'I', 'D', 'E', 'M', 'R', 'N', 'A', 'C', 'O', 'D', 'O', 'N'],
    ['A', 'M', 'I', 'N', 'O', 'A', 'C', 'I', 'D', 'R', 'I', 'B', 'O', 'S', 'O', 'M', 'E', 'O'],
    // Add more rows as needed
  ];

  List<List<bool>> cellSelected = [];
  int count = 0;
  String selectedWord = "";

  @override
  void initState() {
    super.initState();
    startTimer();
    for (var row in puzzleGrid) {
      cellSelected.add(List.generate(row.length, (index) => false));
    }
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


  void selectWord(int row, int col, String direction) {
    String word = "";
    if (direction == "horizontal") {
      // Select the horizontal word
      for (var j = col; j < puzzleGrid[row].length; j++) {
        word += puzzleGrid[row][j];
        cellSelected[row][j] = true;
      }
    } else if (direction == "vertical") {
      // Select the vertical word
      for (var i = row; i < puzzleGrid.length; i++) {
        word += puzzleGrid[i][col];
        cellSelected[i][col] = true;
      }
    }

    setState(() {
      selectedWord = word;
      if (checkForWordMatch()) {
        count += 1;
      }
    });
  }

  bool checkForWordMatch() {
    return selectedWord == "DNA"; // Change this to match your crossword words
  }

  void resetSelection() {
    for (var row in cellSelected) {
      for (var i = 0; i < row.length; i++) {
        row[i] = false;
      }
    }
    selectedWord = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text('Crossword Puzzle'),
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
              builder: (context) => DNAPairingApp(),
            ),
          );
            })
        ),


    body: Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: puzzleGrid.length * puzzleGrid[0].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: puzzleGrid[0].length,
              ),
              itemBuilder: (context, index) {
                final row = index ~/ puzzleGrid[0].length;
                final col = index % puzzleGrid[0].length;

                return GestureDetector(
                  onTap: () {
                    resetSelection();
                    selectWord(row, col, "horizontal"); // Change to "vertical" for vertical selection
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      color: cellSelected[row][col] ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        puzzleGrid[row][col],
                        style: TextStyle(
                          fontSize: 20.0,
                          color: cellSelected[row][col] ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Selected Word: $selectedWord',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Correct Words Found: $count',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    );
  }
}
