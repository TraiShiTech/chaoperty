import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Road3 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Road3(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2813809, size.height * 0.9833340);
    path_0.lineTo(size.width * 0.7147129, size.height * 0.9833340);
    path_0.lineTo(size.width * 0.7147129, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.2813809, size.height * 0.01666602);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6647129, size.height * 0.9833340);
    path_1.lineTo(size.width * 0.7147129, size.height * 0.9833340);
    path_1.lineTo(size.width * 0.7147129, size.height * 0.01666602);
    path_1.lineTo(size.width * 0.6647129, size.height * 0.01666602);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2813809, size.height * 0.9833340);
    path_2.lineTo(size.width * 0.3313809, size.height * 0.9833340);
    path_2.lineTo(size.width * 0.3313809, size.height * 0.01666602);
    path_2.lineTo(size.width * 0.2813809, size.height * 0.01666602);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.7147129, size.height);
    path_3.lineTo(size.width * 0.2813809, size.height);
    path_3.cubicTo(
        size.width * 0.2713809,
        size.height,
        size.width * 0.2647148,
        size.height * 0.9933340,
        size.width * 0.2647148,
        size.height * 0.9833340);
    path_3.lineTo(size.width * 0.2647148, size.height * 0.01666602);
    path_3.cubicTo(size.width * 0.2647148, size.height * 0.006666016,
        size.width * 0.2713809, 0, size.width * 0.2813809, 0);
    path_3.lineTo(size.width * 0.7147148, 0);
    path_3.cubicTo(
        size.width * 0.7247148,
        0,
        size.width * 0.7313809,
        size.height * 0.006666016,
        size.width * 0.7313809,
        size.height * 0.01666602);
    path_3.lineTo(size.width * 0.7313809, size.height * 0.9833320);
    path_3.cubicTo(
        size.width * 0.7313809,
        size.height * 0.9933340,
        size.width * 0.7247129,
        size.height,
        size.width * 0.7147129,
        size.height);
    path_3.close();
    path_3.moveTo(size.width * 0.2980469, size.height * 0.9666660);
    path_3.lineTo(size.width * 0.6980469, size.height * 0.9666660);
    path_3.lineTo(size.width * 0.6980469, size.height * 0.03333398);
    path_3.lineTo(size.width * 0.2980469, size.height * 0.03333398);
    path_3.lineTo(size.width * 0.2980469, size.height * 0.9666660);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4980469, size.height * 0.06666602);
    path_4.cubicTo(
        size.width * 0.4880469,
        size.height * 0.06666602,
        size.width * 0.4813809,
        size.height * 0.06000000,
        size.width * 0.4813809,
        size.height * 0.05000000);
    path_4.lineTo(size.width * 0.4813809, size.height * 0.01666602);
    path_4.cubicTo(size.width * 0.4813809, size.height * 0.006666016,
        size.width * 0.4880469, 0, size.width * 0.4980469, 0);
    path_4.cubicTo(
        size.width * 0.5080469,
        0,
        size.width * 0.5147129,
        size.height * 0.006666016,
        size.width * 0.5147129,
        size.height * 0.01666602);
    path_4.lineTo(size.width * 0.5147129, size.height * 0.05000000);
    path_4.cubicTo(
        size.width * 0.5147129,
        size.height * 0.06000000,
        size.width * 0.5080469,
        size.height * 0.06666602,
        size.width * 0.4980469,
        size.height * 0.06666602);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.8700000);
    path_5.cubicTo(
        size.width * 0.4880469,
        size.height * 0.8700000,
        size.width * 0.4813809,
        size.height * 0.8633340,
        size.width * 0.4813809,
        size.height * 0.8533340);
    path_5.lineTo(size.width * 0.4813809, size.height * 0.7883340);
    path_5.cubicTo(
        size.width * 0.4813809,
        size.height * 0.7783340,
        size.width * 0.4880469,
        size.height * 0.7716680,
        size.width * 0.4980469,
        size.height * 0.7716680);
    path_5.cubicTo(
        size.width * 0.5080469,
        size.height * 0.7716680,
        size.width * 0.5147129,
        size.height * 0.7783340,
        size.width * 0.5147129,
        size.height * 0.7883340);
    path_5.lineTo(size.width * 0.5147129, size.height * 0.8533340);
    path_5.cubicTo(
        size.width * 0.5147129,
        size.height * 0.8633340,
        size.width * 0.5080469,
        size.height * 0.8700000,
        size.width * 0.4980469,
        size.height * 0.8700000);
    path_5.close();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.7100000);
    path_5.cubicTo(
        size.width * 0.4880469,
        size.height * 0.7100000,
        size.width * 0.4813809,
        size.height * 0.7033340,
        size.width * 0.4813809,
        size.height * 0.6933340);
    path_5.lineTo(size.width * 0.4813809, size.height * 0.6283340);
    path_5.cubicTo(
        size.width * 0.4813809,
        size.height * 0.6183340,
        size.width * 0.4880469,
        size.height * 0.6116680,
        size.width * 0.4980469,
        size.height * 0.6116680);
    path_5.cubicTo(
        size.width * 0.5080469,
        size.height * 0.6116680,
        size.width * 0.5147129,
        size.height * 0.6183340,
        size.width * 0.5147129,
        size.height * 0.6283340);
    path_5.lineTo(size.width * 0.5147129, size.height * 0.6933340);
    path_5.cubicTo(
        size.width * 0.5147129,
        size.height * 0.7016660,
        size.width * 0.5080469,
        size.height * 0.7100000,
        size.width * 0.4980469,
        size.height * 0.7100000);
    path_5.close();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.5483340);
    path_5.cubicTo(
        size.width * 0.4880469,
        size.height * 0.5483340,
        size.width * 0.4813809,
        size.height * 0.5416680,
        size.width * 0.4813809,
        size.height * 0.5316680);
    path_5.lineTo(size.width * 0.4813809, size.height * 0.4666680);
    path_5.cubicTo(
        size.width * 0.4813809,
        size.height * 0.4566680,
        size.width * 0.4880469,
        size.height * 0.4500020,
        size.width * 0.4980469,
        size.height * 0.4500020);
    path_5.cubicTo(
        size.width * 0.5080469,
        size.height * 0.4500020,
        size.width * 0.5147129,
        size.height * 0.4566680,
        size.width * 0.5147129,
        size.height * 0.4666680);
    path_5.lineTo(size.width * 0.5147129, size.height * 0.5316680);
    path_5.cubicTo(
        size.width * 0.5147129,
        size.height * 0.5416660,
        size.width * 0.5080469,
        size.height * 0.5483340,
        size.width * 0.4980469,
        size.height * 0.5483340);
    path_5.close();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.3883340);
    path_5.cubicTo(
        size.width * 0.4880469,
        size.height * 0.3883340,
        size.width * 0.4813809,
        size.height * 0.3816680,
        size.width * 0.4813809,
        size.height * 0.3716680);
    path_5.lineTo(size.width * 0.4813809, size.height * 0.3066680);
    path_5.cubicTo(
        size.width * 0.4813809,
        size.height * 0.2966680,
        size.width * 0.4880469,
        size.height * 0.2900020,
        size.width * 0.4980469,
        size.height * 0.2900020);
    path_5.cubicTo(
        size.width * 0.5080469,
        size.height * 0.2900020,
        size.width * 0.5147129,
        size.height * 0.2966680,
        size.width * 0.5147129,
        size.height * 0.3066680);
    path_5.lineTo(size.width * 0.5147129, size.height * 0.3716680);
    path_5.cubicTo(
        size.width * 0.5147129,
        size.height * 0.3800000,
        size.width * 0.5080469,
        size.height * 0.3883340,
        size.width * 0.4980469,
        size.height * 0.3883340);
    path_5.close();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.2266660);
    path_5.cubicTo(
        size.width * 0.4880469,
        size.height * 0.2266660,
        size.width * 0.4813809,
        size.height * 0.2200000,
        size.width * 0.4813809,
        size.height * 0.2100000);
    path_5.lineTo(size.width * 0.4813809, size.height * 0.1466660);
    path_5.cubicTo(
        size.width * 0.4813809,
        size.height * 0.1366660,
        size.width * 0.4880469,
        size.height * 0.1300000,
        size.width * 0.4980469,
        size.height * 0.1300000);
    path_5.cubicTo(
        size.width * 0.5080469,
        size.height * 0.1300000,
        size.width * 0.5147129,
        size.height * 0.1366660,
        size.width * 0.5147129,
        size.height * 0.1466660);
    path_5.lineTo(size.width * 0.5147129, size.height * 0.2116660);
    path_5.cubicTo(
        size.width * 0.5147129,
        size.height * 0.2200000,
        size.width * 0.5080469,
        size.height * 0.2266660,
        size.width * 0.4980469,
        size.height * 0.2266660);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4980469, size.height);
    path_6.cubicTo(
        size.width * 0.4880469,
        size.height,
        size.width * 0.4813809,
        size.height * 0.9933340,
        size.width * 0.4813809,
        size.height * 0.9833340);
    path_6.lineTo(size.width * 0.4813809, size.height * 0.9500000);
    path_6.cubicTo(
        size.width * 0.4813809,
        size.height * 0.9400000,
        size.width * 0.4880469,
        size.height * 0.9333340,
        size.width * 0.4980469,
        size.height * 0.9333340);
    path_6.cubicTo(
        size.width * 0.5080469,
        size.height * 0.9333340,
        size.width * 0.5147129,
        size.height * 0.9400000,
        size.width * 0.5147129,
        size.height * 0.9500000);
    path_6.lineTo(size.width * 0.5147129, size.height * 0.9833340);
    path_6.cubicTo(
        size.width * 0.5147129,
        size.height * 0.9933340,
        size.width * 0.5080469,
        size.height,
        size.width * 0.4980469,
        size.height);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
