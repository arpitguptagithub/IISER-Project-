import 'package:flutter/material.dart';

class CrosswordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Crossword Puzzle'),
          ),
          centerTitle: true,
        ),
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

  List<List<bool>> cellSelected = [];
  int count = 0;
  String selectedWord = "";
  int prev_row = -1;
  int prev_column = -1;

  @override
  void initState() {
    super.initState();
    for (var row in puzzleGrid) {
      cellSelected.add(List.generate(row.length, (index) => false));
    }
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
    if (selectedWord == "DNA") {
      return true;
    } else if (selectedWord == "TRANSCRIPTION") {
      return true;
    } else if (selectedWord == "MRNA") {
      return true;
    } else if (selectedWord == "NUCLEOTIDE") {
      return true;
    } else if (selectedWord == "RIBOSOME") {
      return true;
    } else if (selectedWord == "TRNA") {
      return true;
    } else if (selectedWord == "TEMPLATE") {
      return true;
    } else if (selectedWord == "TRANSLATION") {
      return true;
    } else if (selectedWord == "CODON") {
      return true;
    } else if (selectedWord == "COMPLEMENT") {
      return true;
    } else if (selectedWord == "AMINO") {
      return true;
    } else if (selectedWord == "RRNA") {
      return true;
    } else if (selectedWord == "CODING") {
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
    return Center(
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
                    resetSelection();
                    if (prev_row != -1 && prev_column != -1) {
                      if (row == prev_row) {
                        selectWord(row, col, "horizontal");
                      } else if (col == prev_column) {
                        selectWord(row, col, "vertical");
                      } else {
                        prev_column = -1;
                        prev_row = -1;
                      }
                    } else {
                      prev_column = col;
                      prev_row = row;
                    }
                    //selectWord(row, col, "horizontal"); // Change to "vertical" for vertical selection
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
                  'ACROSS\n',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '1)DNA - Genetic material that contains instructions for cellular functions (3 letters)\n'
                  '2)Transcription - Process where DNA is converted into RNA (13 letters).\n'
                  '3)mRNA - The type of RNA that carries the genetic code from the nucleus to the ribosomes (4 letters).\n'
                  '4)Nucleotide - Basic unit of DNA and RNA, consisting of a sugar, a phosphate group, and a nitrogenous base (10 letters).\n'
                  '5)Ribosome - The site of protein synthesis within a cell (8 letters).\n'
                  '6)tRNA - The molecule involved in translation, which carries amino acids to the ribosome (4 letters).\n'
                  '7)Template - The strand of DNA that serves as a template for RNA synthesis (8 letters).\n'
                  '8)Translation - The process by which the genetic code is translated into a sequence of amino acids (10 letters).\n\n',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'DOWN\n',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '1)Codon - The sequence of three nucleotides that codes for a specific amino acid (5 letters).\n'
                  '2)Complement - The complementary strand of DNA that is synthesized during transcription (9 letters).\n'
                  '3)Amino - A building block of proteins (5 letters).\n'
                  '4)rRNA - The type of RNA that is synthesized using DNA as a template (4 letters).\n'
                  '5)Coding - The strand of DNA that directly corresponds to the sequence of RNA produced during transcription (6 letters).\n'
                  '6)Transcription - The process by which RNA is synthesized from DNA (11 letters).',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
