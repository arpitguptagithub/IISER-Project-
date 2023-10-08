import 'package:buttons/screens/level5.dart';
import 'package:flutter/material.dart';
import 'package:buttons/screens/level1.dart';
class HelpSplashScreen extends StatelessWidget {

  final String text;
  final String imagePath;
  final int levelName;
  final  LW = {
                    "Crossword" : CrosswordApp(),
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
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
    
              
              SizedBox(height: 16.0),
              Image.asset(
                imagePath,
                width: 200.0, 
              ),
              ElevatedButton(
                onPressed: () {
                  if(levelName == 1){
                    Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => CrosswordApp())
                );
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