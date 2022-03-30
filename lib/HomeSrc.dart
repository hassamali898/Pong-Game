// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/Components/Ball.dart';
import 'package:pong_game/Components/Paddle.dart';
import 'package:pong_game/Components/Shapes.dart';
import 'package:pong_game/Components/TopBar.dart';
import 'package:pong_game/theme/Colors.dart';

class HomeSrc extends StatefulWidget {
  const HomeSrc({Key? key}) : super(key: key);

  @override
  State<HomeSrc> createState() => _HomeSrcState();
}

//direction
enum direction { up, down, left, right }

class _HomeSrcState extends State<HomeSrc> {
  //top bar
  int score = 0;
  int life = 3;
  //ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.down;
  var ballXDirection = direction.right;
  //paddle variables
  double paddleX = 0;
  double paddleY = 0;
  double paddleWidth = 0.4;
  //game started
  bool isGameStarted = false;
  //game shapes
  var shappy = List.generate(
      5, (i) => List.filled(5 - i, [0, 0.0], growable: false),
      growable: false);

  bool isBetweenXShape() {
    bool isEmpty = true;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5 - i; j++) {
        if (shappy[i][j][0] != 2) {
          isEmpty = false;
          if ((shappy[i][j][0] + paddleWidth >= ballX &&
                  shappy[i][j][0] <= ballX) &&
              (shappy[i][j][1] <= ballY && shappy[i][j][1] + 0.05 >= ballY)) {
            shappy[i][j] = [2, 2];
            score += 10;
            return true;
          }
        }
      }
    }
    if (isEmpty) {
      setState(() {
        winGame();
      });
    }
    return false;
  }

  //Ball direction
  void startGame() {
    double y = -0.9;
    double x = -1;
    if (life == 3) {
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5 - i; j++) {
          shappy[i][j] = [x, y];
          x += 0.4;
        }
        x = -1 + (0.23 * (i + 1));
        y += 0.05;
      }
    }
    debugPrint(shappy.toString());
    isGameStarted = true;
    Timer.periodic(Duration(microseconds: 1), (timer) {
      updateDirection();
      moveBall();
      //if player win
      if (isGameStarted == false) {
        timer.cancel();
      }
      //check if ball is out of bounds
      if (isPlayerDead()) {
        timer.cancel();
        life == 1 ? resetGame() : gameOver();
      }
    });
  }

  void winGame() {
    double y = -0.9;
    double x = -1;
    setState(() {
      ballX = 0;
      ballY = 0;
      paddleX = 0;
      paddleY = 0;
      isGameStarted = false;
      score = 0;
      life = 3;
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5 - i; j++) {
          shappy[i][j] = [x, y];
          x += 0.4;
        }
        x = -1 + (0.23 * (i + 1));
        y += 0.05;
      }
    });
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'You Win!',
                style: TextStyle(
                    color: success_color, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'If you want to play again press ok',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ),
              ],
            ));
  }

  void resetGame() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Game Over!',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'If you want to play again press ok',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ),
              ],
            ));

    double y = -0.9;
    double x = -1;
    setState(() {
      ballX = 0;
      ballY = 0;
      paddleX = 0;
      paddleY = 0;
      isGameStarted = false;
      score = 0;
      life = 3;
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5 - i; j++) {
          shappy[i][j] = [x, y];
          x += 0.4;
        }
        x = -1 + (0.23 * (i + 1));
        y += 0.05;
      }
    });
  }

  void gameOver() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Oops!',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'If you want to play again press ok',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ),
              ],
            ));
    setState(() {
      ballX = 0;
      ballY = 0;
      paddleX = 0;
      paddleY = 0;
      isGameStarted = false;
      life--;
      score = 0;
    });
  }

  bool isPlayerDead() {
    if (ballY > 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      //vertical direction
      if (ballY >= 0.9 && paddleX + paddleWidth >= ballX && paddleX <= ballX) {
        ballYDirection = direction.up;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.down;
      }
      //horizontal direction
      if (ballX >= 1) {
        ballXDirection = direction.left;
      } else if (ballX <= -1) {
        ballXDirection = direction.right;
      }
      //paddle direction
      if (isBetweenXShape()) {
        debugPrint('between');
        ballYDirection = direction.down;
      }
    });
  }

  void moveBall() {
    setState(() {
      //vertical movement
      if (ballYDirection == direction.down) {
        ballY += 0.007;
      } else if (ballYDirection == direction.up) {
        ballY -= 0.007;
      }
      //horizontal movement
      if (ballXDirection == direction.right) {
        ballX += 0.007;
      } else if (ballXDirection == direction.left) {
        ballX -= 0.007;
      }
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0 &&
        (paddleX + paddleWidth) + details.delta.dx / 100 <= 1) {
      setState(() {
        paddleX += details.delta.dx / 100;
      });
    } else if (details.delta.dx < 0 && paddleX + details.delta.dx / 100 >= -1) {
      setState(() {
        paddleX += details.delta.dx / 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          setState(() {
            if (paddleX + paddleWidth <= 0.9) {
              paddleX += 0.2;
            }
          });
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          setState(() {
            if (paddleX >= -0.9) {
              paddleX -= 0.2;
            }
          });
        }
      },
      child: GestureDetector(
        onTap: isGameStarted ? () {} : startGame,
        onHorizontalDragUpdate: (DragUpdateDetails update) {
          onDragUpdate(update);
        },
        child: Scaffold(
          backgroundColor: background_color,
          body: Container(
              child: Center(
            child: Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                //game started
                isGameStarted
                    ? Container()
                    : Container(
                        alignment: Alignment(0, -0.1),
                        child: Text("Tab To Play".toUpperCase(),
                            style:
                                TextStyle(color: primary_color, fontSize: 20)),
                      ),
                //topBar
                TopBar(
                  score: score,
                  life: life,
                ),
                //top Paddle
                Shapes(
                  shappy: shappy,
                ),
                //bottom Paddle
                Paddle(
                  x: paddleX,
                  y: 0.9,
                  width: paddleWidth,
                ),
                //Ball
                Ball(x: ballX, y: ballY),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
