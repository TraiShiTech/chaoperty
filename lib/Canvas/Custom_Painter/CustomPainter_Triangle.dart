import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Triangle extends CustomPainter {
  final color_s;

  RPSCustomPainter_Triangle(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9811417, size.height * 0.9830146);
    path_0.lineTo(size.width * 0.01552992, size.height * 0.9830146);
    path_0.lineTo(size.width * 0.4983368, size.height * 0.01740092);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9811417, size.height * 0.9996625);
    path_1.lineTo(size.width * 0.01552992, size.height * 0.9996625);
    path_1.cubicTo(
        size.width * 0.01053537,
        size.height * 0.9996625,
        size.width * 0.003876627,
        size.height * 0.9963321,
        size.width * 0.0005462786,
        size.height * 0.9913376);
    path_1.cubicTo(
        size.width * -0.002784070,
        size.height * 0.9863430,
        size.width * -0.002784070,
        size.height * 0.9796843,
        size.width * 0.0005462786,
        size.height * 0.9746897);
    path_1.lineTo(size.width * 0.4833531, size.height * 0.009077979);
    path_1.cubicTo(
        size.width * 0.4883477,
        size.height * -0.002575313,
        size.width * 0.5066617,
        size.height * -0.002575313,
        size.width * 0.5133204,
        size.height * 0.009077979);
    path_1.lineTo(size.width * 0.9961273, size.height * 0.9746897);
    path_1.cubicTo(
        size.width * 0.9994576,
        size.height * 0.9796843,
        size.width * 0.9977915,
        size.height * 0.9863430,
        size.width * 0.9961273,
        size.height * 0.9913376);
    path_1.cubicTo(
        size.width * 0.9944611,
        size.height * 0.9963321,
        size.width * 0.9861362,
        size.height * 0.9996625,
        size.width * 0.9811417,
        size.height * 0.9996625);
    path_1.close();
    path_1.moveTo(size.width * 0.04216685, size.height * 0.9663648);
    path_1.lineTo(size.width * 0.9545047, size.height * 0.9663648);
    path_1.lineTo(size.width * 0.4983368, size.height * 0.05402890);
    path_1.lineTo(size.width * 0.04216685, size.height * 0.9663648);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff231317).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
