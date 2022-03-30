import 'package:flutter/material.dart';
import 'package:pong_game/Components/Paddle.dart';
import 'package:pong_game/theme/Colors.dart';

class Shapes extends StatelessWidget {
  final List<List<List<num>>> shappy;
  const Shapes({Key? key, required this.shappy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double y = -0.9;
    double x = -1;
    final children = <Widget>[];
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5 - i; j++) {
        if (shappy[i][j][0] != 2) {
          children.add(
            Paddle(
              color: background_color_light,
              x: x,
              y: y,
              width: 0.4,
            ),
          );
        }
        x += 0.4;
      }
      x = -1 + (0.23 * (i + 1));
      y += 0.05;
    }
    return Container(
      child: Stack(
        children: children,
      ),
    );
  }
}
