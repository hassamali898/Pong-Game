import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/theme/Colors.dart';

class Ball extends StatelessWidget {
  final double x;
  final double y;
  final bool isGameStarted;
  const Ball({
    Key? key,
    required this.x,
    required this.y,
    required this.isGameStarted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: isGameStarted
          ? Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: primary_color,
                shape: BoxShape.circle,
              ),
              width: 20,
              height: 20,
            )
          : AvatarGlow(
              endRadius: 60.0,
              child: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: primary_color,
                  shape: BoxShape.circle,
                ),
                width: 20,
                height: 20,
              ),
            ),
    );
  }
}
