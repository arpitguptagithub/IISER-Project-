import 'package:flutter/material.dart';

class HelpSplashScreen extends StatelessWidget {
  final String text;
  final String imagePath;

  HelpSplashScreen({
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
          
        ),
      ),
    );
  }
}
