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
  List<int> snakePositions = [16, 47, 49, 56, 62, 64, 87, 93, 95, 99];
  List<int> ladderStarts = [1, 4, 9, 21, 28, 36, 51, 71, 80];
  List<int> ladderEnds = [38, 14, 31, 42, 84, 44, 67, 91, 100];

  int currentPlayer = 1;
  List<int> playerPositions = [1, 1];
  List<int> diceValues = [1, 1];
  bool isGameOver = false;

  void rollDice() {
    setState(() {
      int diceValue = Random().nextInt(maxDiceValue) + 1;
      diceValues[currentPlayer - 1] = diceValue;
      playerPositions[currentPlayer - 1] += diceValue;

      if (playerPositions[currentPlayer - 1] > 100) {
        playerPositions[currentPlayer - 1] = 100;
      }

      if (snakePositions.contains(playerPositions[currentPlayer - 1])) {
        playerPositions[currentPlayer - 1] = 1;
      } else if (ladderStarts.contains(playerPositions[currentPlayer - 1])) {
        int index = ladderStarts.indexOf(playerPositions[currentPlayer - 1]);
        playerPositions[currentPlayer - 1] = ladderEnds[index];
      }

      if (playerPositions[currentPlayer - 1] == 100) {
        isGameOver = true;
      }

      currentPlayer = currentPlayer == 1 ? 2 : 1;
    });
  }

  void resetGame() {
    setState(() {
      currentPlayer = 1;
      playerPositions = [1, 1];
      diceValues = [1, 1];
      isGameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake and Ladders'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/board_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player 1 Position: ${playerPositions[0]}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Player 2 Position: ${playerPositions[1]}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Player 1 Dice Value:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/images/dice${diceValues[0]}.png',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Player 2 Dice Value:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/images/dice${diceValues[1]}.png',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            if (isGameOver)
              Text(
                'Congratulations! Player $currentPlayer won!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (!isGameOver)
              ElevatedButton(
                onPressed: rollDice,
                child: Text('Roll Dice (Player $currentPlayer)'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}