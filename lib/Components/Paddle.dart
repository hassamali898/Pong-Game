import 'package:flutter/material.dart';

import '../theme/Colors.dart';

class Paddle extends StatelessWidget {
  final double x;
  final double y;
  final double width;
  final Color color;
  const Paddle(
      {Key? key,
      required this.x,
      required this.y,
      required this.width,
      this.color = primary_color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment((2 * x + width) / (2 - width), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: color,
          height: 20,
          width: size.width / 5,
        ),
      ),
    );
  }
}
