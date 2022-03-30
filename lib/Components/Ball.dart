import 'package:flutter/material.dart';
import 'package:pong_game/theme/Colors.dart';

class Ball extends StatelessWidget {
  final double x;
  final double y;
  const Ball({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: primary_color,
          shape: BoxShape.circle,
        ),
        width: 20,
        height: 20,
      ),
    );
  }
}
