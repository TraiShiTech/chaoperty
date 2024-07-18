import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Drink extends CustomPainter {
  final color_s;

  RPSCustomPainter_Drink(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7869219, size.height * 0.4972303);
    path_0.cubicTo(
        size.width * 0.7869219,
        size.height * 0.6848253,
        size.width * 0.6348549,
        size.height * 0.8368923,
        size.width * 0.4472599,
        size.height * 0.8368923);
    path_0.cubicTo(
        size.width * 0.2596649,
        size.height * 0.8368923,
        size.width * 0.1075979,
        size.height * 0.6848253,
        size.width * 0.1075979,
        size.height * 0.4972303);
    path_0.cubicTo(
        size.width * 0.1075979,
        size.height * 0.3096353,
        size.width * 0.2596649,
        size.height * 0.1575684,
        size.width * 0.4472599,
        size.height * 0.1575684);
    path_0.cubicTo(
        size.width * 0.6348549,
        size.height * 0.1575684,
        size.width * 0.7869219,
        size.height * 0.3096353,
        size.width * 0.7869219,
        size.height * 0.4972303);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4472599, size.height * 0.8494729);
    path_1.cubicTo(
        size.width * 0.2530307,
        size.height * 0.8494729,
        size.width * 0.09501736,
        size.height * 0.6914606,
        size.width * 0.09501736,
        size.height * 0.4972303);
    path_1.cubicTo(
        size.width * 0.09501736,
        size.height * 0.3030001,
        size.width * 0.2530297,
        size.height * 0.1449878,
        size.width * 0.4472599,
        size.height * 0.1449878);
    path_1.cubicTo(
        size.width * 0.6414902,
        size.height * 0.1449878,
        size.width * 0.7995025,
        size.height * 0.3030001,
        size.width * 0.7995025,
        size.height * 0.4972303);
    path_1.cubicTo(
        size.width * 0.7995025,
        size.height * 0.6914606,
        size.width * 0.6414892,
        size.height * 0.8494729,
        size.width * 0.4472599,
        size.height * 0.8494729);
    path_1.close();
    path_1.moveTo(size.width * 0.4472599, size.height * 0.1701489);
    path_1.cubicTo(
        size.width * 0.2669001,
        size.height * 0.1701489,
        size.width * 0.1201775,
        size.height * 0.3168715,
        size.width * 0.1201775,
        size.height * 0.4972313);
    path_1.cubicTo(
        size.width * 0.1201775,
        size.height * 0.6775911,
        size.width * 0.2669001,
        size.height * 0.8243137,
        size.width * 0.4472599,
        size.height * 0.8243137);
    path_1.cubicTo(
        size.width * 0.6276197,
        size.height * 0.8243137,
        size.width * 0.7743423,
        size.height * 0.6775911,
        size.width * 0.7743423,
        size.height * 0.4972313);
    path_1.cubicTo(
        size.width * 0.7743423,
        size.height * 0.3168715,
        size.width * 0.6276197,
        size.height * 0.1701489,
        size.width * 0.4472599,
        size.height * 0.1701489);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff4D5152).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4472599, size.height * 0.4972303);
    path_2.moveTo(size.width * 0.2082387, size.height * 0.4972303);
    path_2.arcToPoint(Offset(size.width * 0.6862811, size.height * 0.4972303),
        radius:
            Radius.elliptical(size.width * 0.2390212, size.height * 0.2390212),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.2082387, size.height * 0.4972303),
        radius:
            Radius.elliptical(size.width * 0.2390212, size.height * 0.2390212),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.4598405, size.height * 0.7739923);
    path_3.lineTo(size.width * 0.4598405, size.height * 0.3840100);
    path_3.lineTo(size.width * 0.7869229, size.height * 0.3840100);
    path_3.lineTo(size.width * 0.7869229, size.height * 0.7739923);
    path_3.cubicTo(
        size.width * 0.7869229,
        size.height * 0.8087344,
        size.width * 0.7587650,
        size.height * 0.8368923,
        size.width * 0.7240229,
        size.height * 0.8368923);
    path_3.lineTo(size.width * 0.5227405, size.height * 0.8368923);
    path_3.cubicTo(
        size.width * 0.4879983,
        size.height * 0.8368923,
        size.width * 0.4598405,
        size.height * 0.8087344,
        size.width * 0.4598405,
        size.height * 0.7739923);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4598405, size.height * 0.7739923);
    path_4.lineTo(size.width * 0.4598405, size.height * 0.7362525);
    path_4.lineTo(size.width * 0.7869229, size.height * 0.7362525);
    path_4.lineTo(size.width * 0.7869229, size.height * 0.7739923);
    path_4.cubicTo(
        size.width * 0.7869229,
        size.height * 0.8087344,
        size.width * 0.7587650,
        size.height * 0.8368923,
        size.width * 0.7240229,
        size.height * 0.8368923);
    path_4.lineTo(size.width * 0.5227405, size.height * 0.8368923);
    path_4.cubicTo(
        size.width * 0.4879983,
        size.height * 0.8368923,
        size.width * 0.4598405,
        size.height * 0.8087344,
        size.width * 0.4598405,
        size.height * 0.7739923);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffF28C13).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.7240219, size.height * 0.8494729);
    path_5.lineTo(size.width * 0.5227405, size.height * 0.8494729);
    path_5.cubicTo(
        size.width * 0.4811181,
        size.height * 0.8494729,
        size.width * 0.4472599,
        size.height * 0.8156147,
        size.width * 0.4472599,
        size.height * 0.7739923);
    path_5.lineTo(size.width * 0.4472599, size.height * 0.3840100);
    path_5.cubicTo(
        size.width * 0.4472599,
        size.height * 0.3770568,
        size.width * 0.4528863,
        size.height * 0.3714304,
        size.width * 0.4598395,
        size.height * 0.3714304);
    path_5.lineTo(size.width * 0.7869219, size.height * 0.3714304);
    path_5.cubicTo(
        size.width * 0.7938751,
        size.height * 0.3714304,
        size.width * 0.7995015,
        size.height * 0.3770568,
        size.width * 0.7995015,
        size.height * 0.3840100);
    path_5.lineTo(size.width * 0.7995015, size.height * 0.7739923);
    path_5.cubicTo(
        size.width * 0.7995025,
        size.height * 0.8156147,
        size.width * 0.7656442,
        size.height * 0.8494729,
        size.width * 0.7240219,
        size.height * 0.8494729);
    path_5.close();
    path_5.moveTo(size.width * 0.4724201, size.height * 0.3965896);
    path_5.lineTo(size.width * 0.4724201, size.height * 0.7739923);
    path_5.cubicTo(
        size.width * 0.4724201,
        size.height * 0.8017442,
        size.width * 0.4949876,
        size.height * 0.8243127,
        size.width * 0.5227405,
        size.height * 0.8243127);
    path_5.lineTo(size.width * 0.7240219, size.height * 0.8243127);
    path_5.cubicTo(
        size.width * 0.7517738,
        size.height * 0.8243127,
        size.width * 0.7743423,
        size.height * 0.8017452,
        size.width * 0.7743423,
        size.height * 0.7739923);
    path_5.lineTo(size.width * 0.7743423, size.height * 0.3965896);
    path_5.lineTo(size.width * 0.4724201, size.height * 0.3965896);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff4D5152).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4598405, size.height * 0.7236719);
    path_6.lineTo(size.width * 0.7869229, size.height * 0.7236719);
    path_6.lineTo(size.width * 0.7869229, size.height * 0.7488321);
    path_6.lineTo(size.width * 0.4598405, size.height * 0.7488321);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff4D5152).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.8372422, size.height * 0.7488321);
    path_7.lineTo(size.width * 0.7869219, size.height * 0.7488321);
    path_7.lineTo(size.width * 0.7869219, size.height * 0.7236719);
    path_7.lineTo(size.width * 0.8372422, size.height * 0.7236719);
    path_7.cubicTo(
        size.width * 0.8580529,
        size.height * 0.7236719,
        size.width * 0.8749820,
        size.height * 0.7067428,
        size.width * 0.8749820,
        size.height * 0.6859322);
    path_7.lineTo(size.width * 0.8749820, size.height * 0.4972303);
    path_7.cubicTo(
        size.width * 0.8749820,
        size.height * 0.4764186,
        size.width * 0.8580529,
        size.height * 0.4594905,
        size.width * 0.8372422,
        size.height * 0.4594905);
    path_7.lineTo(size.width * 0.7869219, size.height * 0.4594905);
    path_7.lineTo(size.width * 0.7869219, size.height * 0.4343304);
    path_7.lineTo(size.width * 0.8372422, size.height * 0.4343304);
    path_7.cubicTo(
        size.width * 0.8719233,
        size.height * 0.4343304,
        size.width * 0.9001422,
        size.height * 0.4625492,
        size.width * 0.9001422,
        size.height * 0.4972303);
    path_7.lineTo(size.width * 0.9001422, size.height * 0.6859312);
    path_7.cubicTo(
        size.width * 0.9001432,
        size.height * 0.7206133,
        size.width * 0.8719233,
        size.height * 0.7488321,
        size.width * 0.8372422,
        size.height * 0.7488321);
    path_7.close();
    path_7.moveTo(size.width * 0.6108006, size.height * 0.6733516);
    path_7.lineTo(size.width * 0.6359608, size.height * 0.6733516);
    path_7.lineTo(size.width * 0.6359608, size.height * 0.6985118);
    path_7.lineTo(size.width * 0.6108006, size.height * 0.6985118);
    path_7.close();
    path_7.moveTo(size.width * 0.5604812, size.height * 0.6733516);
    path_7.lineTo(size.width * 0.5856414, size.height * 0.6733516);
    path_7.lineTo(size.width * 0.5856414, size.height * 0.6985118);
    path_7.lineTo(size.width * 0.5604812, size.height * 0.6985118);
    path_7.close();
    path_7.moveTo(size.width * 0.6611210, size.height * 0.6733516);
    path_7.lineTo(size.width * 0.6862811, size.height * 0.6733516);
    path_7.lineTo(size.width * 0.6862811, size.height * 0.6985118);
    path_7.lineTo(size.width * 0.6611210, size.height * 0.6985118);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff4D5152).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
