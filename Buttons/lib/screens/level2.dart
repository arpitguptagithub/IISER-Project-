import 'package:flutter/material.dart';
import 'package:buttons/utils/game_provider.dart';
import 'package:buttons/widgets/game_board.dart';
import 'package:buttons/widgets/game_keyboard.dart';

class LevelTwo extends StatefulWidget {
  const LevelTwo({Key? key}) : super(key: key);

  @override
  State<LevelTwo> createState() => _LevelTwoState();
}

class _LevelTwoState extends State<LevelTwo> {
  WorldeGame _game = WorldeGame();
  late String word;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorldeGame.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Wordle",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          GameKeyboard(_game),
        ],
      ),
    );
  }
}
