import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SnakeAndLadders(),
  ));
}

class SnakeAndLadders extends StatefulWidget {
  @override
  _SnakeAndLaddersState createState() => _SnakeAndLaddersState();
}

class _SnakeAndLaddersState extends State<SnakeAndLadders> {
  static final int boardSize = 10;
  static final int maxDiceValue = 6;
  List<int> snakePositions = [16, 47, 49, 56, 62, 64, 87, 93, 95, 98];
  List<int> ladderStarts = [1, 4, 9, 21, 28, 36, 51, 71, 80];
  List<int> ladderEnds = [38, 14, 31, 42, 84, 44, 67, 91, 100];

  int playerPosition = 1;
  int diceValue = 1;
  bool isGameOver = false;

  void rollDice() {
    setState(() {
      diceValue = Random().nextInt(maxDiceValue) + 1;
      playerPosition += diceValue;

      if (playerPosition > 100) {
        playerPosition = 100;
      }

      if (snakePositions.contains(playerPosition)) {
        playerPosition = 1;
      } else if (ladderStarts.contains(playerPosition)) {
        int index = ladderStarts.indexOf(playerPosition);
        playerPosition = ladderEnds[index];
      }

      if (playerPosition == 100) {
        isGameOver = true;
      }
    });
  }

  void resetGame() {
    setState(() {
      playerPosition = 1;
      diceValue = 1;
      isGameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake and Ladders'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Player Position: $playerPosition',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            'Dice Value: $diceValue',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          if (isGameOver)
            Text(
              'Congratulations! You won!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          if (!isGameOver)
            ElevatedButton(
              onPressed: rollDice,
              child: Text('Roll Dice'),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
