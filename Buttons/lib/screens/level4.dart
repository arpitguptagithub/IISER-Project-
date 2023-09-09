import 'package:flutter/material.dart';

void main() {
  runApp(DNAPairingApp());
}

class DNAPairingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DNA Pairing'),
          centerTitle: true,
        ),
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
  List<TextEditingController> row1Controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  List<TextEditingController> row2Controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
 
 
 //Edit this function for checking complementary pairings of DNA
  void checkAndClearIfIncorrect() {
    for (int i = 0; i < row1Controllers.length; i++) {
      final String char1 = row1Controllers[i].text.toUpperCase();
      final String char2 = row2Controllers[i].text.toUpperCase();

      if (char1.isNotEmpty && char2.isNotEmpty && char1 != char2) {
        // Clear both boxes if there's a mismatch
        row1Controllers[i].clear();
        row2Controllers[i].clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            // First Row of Boxes
            Row(
              children: List.generate(
                row1Controllers.length,
                (index) => Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    controller: row1Controllers[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Second Row of Boxes
            Row(
              children: List.generate(
                row2Controllers.length,
                (index) => Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(8),
                  //align this to have spiral effect can use stack to alling and give spiral effect
                  child: TextField(
                    controller: row2Controllers[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Check Button
            ElevatedButton(
              onPressed: () {
                checkAndClearIfIncorrect(); // Check and clear if pairs are incorrect
              },
              child: Text(
                'Check Pairs',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 