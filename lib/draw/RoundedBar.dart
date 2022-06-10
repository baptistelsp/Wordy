import 'package:flutter/material.dart';
import "../../utils/color.dart";

class RoundedBar extends CustomPainter {
  final double percentage;
  RoundedBar(this.percentage);

  @override
  void paint(Canvas canvas, Size size, ) {
    double w = size.width;
    double h = size.height;
    double r = 15;

    var paint1 = Paint()
      ..color = HexColor('#D1CFC8')
      ..style = PaintingStyle.fill;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );
    canvas.drawRRect(fullRect, paint1);

    var paint2 = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    if (percentage > 0){
      RRect fullRect2 = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset( (w*percentage)/2, h / 2), width: w*percentage, height: h),
        Radius.circular(r),
      );
      canvas.drawRRect(fullRect2, paint2);

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}