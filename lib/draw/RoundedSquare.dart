import 'package:flutter/material.dart';
import "../../utils/color.dart";

class RoundedSquare extends CustomPainter {
  final double radius;
  final String hex;
  RoundedSquare({required this.radius, required this.hex});

  @override
  void paint(Canvas canvas, Size size, ) {
    double w = size.width;
    double h = size.height;
    double r = radius;

    var paint1 = Paint()
      ..color = HexColor(hex)
      ..style = PaintingStyle.fill;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );
    canvas.drawRRect(fullRect, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}