import 'dart:async';

import 'package:buttons/main.dart';
import 'package:buttons/screens/level5.dart';
import 'package:buttons/screens/pageofinstructions.dart';
import 'package:flutter/material.dart';

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
  int timerSeconds = 999999999; // Set your desired countdown time here
  late Timer timer;
  bool isTimeUp = false;

  final List<List<String>> puzzleGrid = [
    ['C', 'A', 'R', 'T', 'U', 'L', 'C', 'I', 'R', 'P', 'Y', 'N', 'E'],
    ['O', 'M', 'T', 'A', 'C', 'S', 'O', 'T', 'O', 'D', 'N', 'A', 'K'],
    ['M', 'I', 'R', 'O', 'M', 'T', 'O', 'R', 'U', 'N', 'L', 'A', 'C'],
    ['P', 'N', 'U', 'C', 'L', 'E', 'O', 'T', 'I', 'D', 'E', 'D', 'O'],
    ['L', 'O', 'L', 'U', 'G', 'T', 'C', 'O', 'D', 'I', 'N', 'C', 'D'],
    ['E', 'R', 'I', 'B', 'O', 'S', 'O', 'M', 'E', 'L', 'B', 'O', 'I'],
    ['M', 'R', 'F', 'N', 'A', 'P', 'T', 'R', 'T', 'T', 'G', 'C', 'N'],
    ['E', 'N', 'N', 'D', 'R', 'I', 'B', 'O', 'S', 'O', 'M', 'O', 'G'],
    ['N', 'A', 'E', 'E', 'T', 'S', 'C', 'N', 'L', 'E', 'M', 'D', 'M'],
    ['T', 'R', 'A', 'N', 'S', 'C', 'R', 'I', 'P', 'T', 'I', 'O', 'N'],
    ['I', 'I', 'C', 'S', 'R', 'I', 'B', 'O', 'A', 'T', 'R', 'N', 'A'],
    ['T', 'E', 'M', 'P', 'L', 'A', 'T', 'E', 'S', 'O', 'M', 'E', 'C'],
    ['M', 'C', 'M', 'R', 'N', 'A', 'G', 'G', 'O', 'C', 'R', 'T', 'R'],
    ['R', 'T', 'R', 'A', 'N', 'S', 'L', 'A', 'T', 'I', 'O', 'N', 'O']
  ];

// TRANSCRIPTION
// MRNA
// NUCLEOTIDE
// RIBOSOME
// TRNA
// TEMPLATE
// TRANSLATION
// CODON
// COMPLEMENT
// AMINO
// RRNA
// CODING
  List<List<bool>> cellSelected = [];
  Map<String, bool> checkWord = {
    "TRANSCRIPTION": false,
    "MRNA": false,
    "NUCLEOTIDE": false,
    "RIBOSOME": false,
    "TRNA": false,
    "TEMPLATE": false,
    "TRANSLATION": false,
    "CODON": false,
    "COMPLEMENT": false,
    "AMINO": false,
    "RRNA": false,
    "CODING": false,
    "DNA": false
  };
  int count = 0;
  String selectedWord = "";
  int prev_row = -1;
  int prev_column = -1;

  @override
  void initState() {
    startTimer();
    super.initState();
    for (var row in puzzleGrid) {
      cellSelected.add(List.generate(row.length, (index) => false));
    }
  }

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
      for (var j = prev_column; j <= col; j++) {
        word += puzzleGrid[row][j];
        cellSelected[row][j] = true;
      }
    } else if (direction == "vertical") {
      // Select the vertical word
      for (var i = prev_row; i <= row; i++) {
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
    if (selectedWord == "DNA" && checkWord["DNA"] == false) {
      checkWord["DNA"] = true;
      return true;
    } else if (selectedWord == "TRANSCRIPTION" &&
        checkWord["TRANSCRIPTION"] == false) {
      checkWord["TRANSCRIPTION"] = true;
      return true;
    } else if (selectedWord == "MRNA" && checkWord["MRNA"] == false) {
      checkWord["MRNA"] = true;
      return true;
    } else if (selectedWord == "NUCLEOTIDE" &&
        checkWord["NUCLEOTIDE"] == false) {
      checkWord["NUCLEOTIDE"] = true;
      return true;
    } else if (selectedWord == "RIBOSOME" && checkWord["RIBOSOME"] == false) {
      checkWord["RIBOSOME"] = true;
      return true;
    } else if (selectedWord == "TRNA" && checkWord["TRNA"] == false) {
      checkWord["TRNA"] = true;
      return true;
    } else if (selectedWord == "TEMPLATE" && checkWord["TEMPLATE"] == false) {
      checkWord["TEMPLATE"] = true;
      return true;
    } else if (selectedWord == "TRANSLATION" &&
        checkWord["TRANSLATION"] == false) {
      checkWord["TRANSLATION"] = true;
      return true;
    } else if (selectedWord == "CODON" && checkWord["CODON"] == false) {
      checkWord["CODON"] = true;
      return true;
    } else if (selectedWord == "COMPLEMENT" &&
        checkWord["COMPLEMENT"] == false) {
      checkWord["COMPLEMENT"] = true;
      return true;
    } else if (selectedWord == "AMINO" && checkWord["AMINO"] == false) {
      checkWord["AMINO"] = true;
      return true;
    } else if (selectedWord == "RRNA" && checkWord["RRNA"] == false) {
      checkWord["RRNA"] = true;
      return true;
    } else if (selectedWord == "CODING" && checkWord["CODING"] == false) {
      checkWord["CODING"] = true;
      return true;
    } else {
      return false;
    } // Change this to match your crossword words
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
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Synthetic Saga'),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //     child: Text(
        //       textAlign: TextAlign.center,
        //       'Timer: ${timerSeconds.toString().padLeft(2, '0')}',
        //       style: const TextStyle(fontSize: 20),
        //     ),
        //   ),
        // ],
        // leading: BackButton(onPressed: () {
        //   // Handle back button press
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => FirstRoute(),
        //     ),
        //   );
        // }),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
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
                      if (prev_row != -1 && prev_column != -1) {
                        if (row == prev_row) {
                          selectWord(row, col, "horizontal");
                        } else if (col == prev_column) {
                          selectWord(row, col, "vertical");
                        } else {
                          prev_column = -1;
                          prev_row = -1;
                          resetSelection();
                        }
                      } else {
                        prev_column = col;
                        prev_row = row;
                        resetSelection();
                      }
                      //selectWord(row, col, "horizontal"); // Change to "vertical" for vertical selection
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        color:
                            cellSelected[row][col] ? Colors.red : Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          puzzleGrid[row][col],
                          style: TextStyle(
                            fontSize: 20.0,
                            color: cellSelected[row][col]
                                ? Colors.white
                                : Colors.black,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Selected Word: $selectedWord',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Correct Words Found: $count',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'HINTS\n',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: PageView(
                      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                      /// Use [Axis.vertical] to scroll vertically.
                      controller: controller,
                      children: const <Widget>[
                        Center(
                          child: Text(
                              '1)Genetic material that contains instructions for cellular functions (3 letters)\n'),
                        ),
                        Center(
                          child: Text(
                              '2)Process where DNA is converted into RNA (13 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '3)The type of RNA that carries the genetic code from the nucleus to the ribosomes (4 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '4)Basic unit of DNA and RNA, consisting of a sugar, a phosphate group, and a nitrogenous base (10 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '5)The site of protein synthesis within a cell (8 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '6)The molecule involved in translation, which carries amino acids to the ribosome (4 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '7)The strand of DNA that serves as a template for RNA synthesis (8 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '8)The sequence of three nucleotides that codes for a specific amino acid (5 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '9)The complementary strand of DNA that is synthesized during transcription (9 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '10)A building block of proteins (5 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '11)The type of RNA that is synthesized using DNA as a template (4 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '12)The strand of DNA that directly corresponds to the sequence of RNA produced during transcription (6 letters).\n'),
                        ),
                        Center(
                          child: Text(
                              '13)The process by which RNA is synthesized from DNA (11 letters).'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isTimeUp)
              AlertDialog(
                alignment: Alignment.center,
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
            if (!isTimeUp)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (count == 13) {
                          // Implement logic to move to the next puzzle or action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpSplashScreen(
                                  text:
                                      "Welcome to Level 2! Your task is to unscramble the letters provided as hints for each picture. \nThese images represent fundamental tools of synthetic biology. \nUpon successful completion of Level 2, you will be sent to Level 3.\n Good luck!",
                                  imagePath:
                                      "assets/3danimations/correct_ans.json",
                                  levelName: 2),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
