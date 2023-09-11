import 'package:buttons/screens/level4.dart';
import 'package:flutter/material.dart';

class MatchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Matching Game'),
          centerTitle: true,
          leading:  BackButton(onPressed:  (){Navigator.pop(context);})
        ),
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
  Map<String, String?> matches = {
    'A': null,
    'B': null,
    'C': null,
    'D': null,
    'E': null,
  };

  Map<String, String> targets = {
    'A': 'Apple',
    'B': 'Banana',
    'C': 'Cat',
    'E': 'ElevatedButton',
    'D': 'Dog',
  };

  void checkMatch(String draggable, String target) {
    if (draggable.trim() == target.trim()) {
      setState(() {
        matches[draggable] = target;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey, // Background color
      padding: EdgeInsets.all(20.0), // Padding for the whole container
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Left Column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: matches.keys.map((draggable) {
                return Draggable<String>(
                  data: draggable,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent, // Box background color
                      border: Border.all(color: Colors.black), // Box border color
                    ),
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
                  feedback: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent, // Box background color
                      border: Border.all(color: Colors.black), // Box border color
                    ),
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
              children: targets.keys.map((target) {
                return DragTarget<String>(
                  builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                    final isMatched = matches[target] != null;

                    return Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.symmetric(vertical: 10.0), // Margin between target boxes
                      decoration: BoxDecoration(
                        color: isMatched ? Colors.green : Colors.white, // Box background color
                        border: Border.all(color: Colors.black), // Box border color
                      ),
                      child: Center(
                        child: Text(
                          isMatched ? matches[target]! : target,
                          style: TextStyle(
                            fontSize: 20.0, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                            color: Colors.black, // Font color
                          ),
                        ),
                      ),
                    );
                  },
                  onWillAccept: (draggable) => matches[draggable!] == null,
                  onAccept: (draggable) {
                    checkMatch(draggable!, target);
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () {
                  // Implement logic to move to the next puzzle or action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DNAPairingApp(),
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
          ],
        ),
      ),
    );
  }
}
