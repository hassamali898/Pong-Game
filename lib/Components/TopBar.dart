// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pong_game/theme/Colors.dart';

class TopBar extends StatelessWidget {
  final int score;
  final int life;
  const TopBar({Key? key, required this.score, required this.life})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lifes = <Widget>[];
    for (int i = 0; i < life; i++) {
      lifes.add(
        new Icon(Icons.favorite, color: text_color_dark),
      );
    }
    return Container(
      alignment: Alignment(0, -0.98),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Score: ${score}",
              style: TextStyle(color: text_color_dark, fontSize: 20),
            ),
            Row(
              children: [
                Text(
                  "Life: ",
                  style: TextStyle(color: text_color_dark, fontSize: 20),
                ),
                ...lifes,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
