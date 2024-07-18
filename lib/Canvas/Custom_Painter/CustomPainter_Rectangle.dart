import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Rectangle extends CustomPainter {
  final color_s;

  RPSCustomPainter_Rectangle(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.04166667, size.height * 0.1250000);
    path_0.lineTo(size.width * 0.04166667, size.height * 0.8750000);
    path_0.lineTo(size.width * 0.9583333, size.height * 0.8750000);
    path_0.lineTo(size.width * 0.9583333, size.height * 0.1250000);
    path_0.close();
    path_0.moveTo(size.width * 0.9166667, size.height * 0.8333333);
    path_0.lineTo(size.width * 0.08333333, size.height * 0.8333333);
    path_0.lineTo(size.width * 0.08333333, size.height * 0.1666667);
    path_0.lineTo(size.width * 0.9166667, size.height * 0.1666667);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.08333333, size.height * 0.1666667);
    path_1.lineTo(size.width * 0.9166667, size.height * 0.1666667);
    path_1.lineTo(size.width * 0.9166667, size.height * 0.8333333);
    path_1.lineTo(size.width * 0.08333333, size.height * 0.8333333);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(0, 0);
    path_2.lineTo(size.width, 0);
    path_2.lineTo(size.width, size.height);
    path_2.lineTo(0, size.height);
    path_2.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
