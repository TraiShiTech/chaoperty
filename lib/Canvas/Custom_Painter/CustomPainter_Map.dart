import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Map extends CustomPainter {
  final color_s;

  RPSCustomPainter_Map(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.06250000);
    path_0.cubicTo(
        size.width * 0.3437500,
        size.height * 0.06250000,
        size.width * 0.2187500,
        size.height * 0.1875000,
        size.width * 0.2187500,
        size.height * 0.3406250);
    path_0.cubicTo(
        size.width * 0.2187500,
        size.height * 0.5718750,
        size.width * 0.4687500,
        size.height * 0.7687500,
        size.width * 0.4812500,
        size.height * 0.7750000);
    path_0.cubicTo(
        size.width * 0.4875000,
        size.height * 0.7781250,
        size.width * 0.4937500,
        size.height * 0.7812500,
        size.width * 0.5000000,
        size.height * 0.7812500);
    path_0.cubicTo(
        size.width * 0.5062500,
        size.height * 0.7812500,
        size.width * 0.5125000,
        size.height * 0.7781250,
        size.width * 0.5187500,
        size.height * 0.7750000);
    path_0.cubicTo(
        size.width * 0.5312500,
        size.height * 0.7656250,
        size.width * 0.7812500,
        size.height * 0.5718750,
        size.width * 0.7812500,
        size.height * 0.3406250);
    path_0.cubicTo(
        size.width * 0.7812500,
        size.height * 0.1875000,
        size.width * 0.6562500,
        size.height * 0.06250000,
        size.width * 0.5000000,
        size.height * 0.06250000);
    path_0.close();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.4375000);
    path_0.cubicTo(
        size.width * 0.4468750,
        size.height * 0.4375000,
        size.width * 0.4062500,
        size.height * 0.3968750,
        size.width * 0.4062500,
        size.height * 0.3437500);
    path_0.cubicTo(
        size.width * 0.4062500,
        size.height * 0.2906250,
        size.width * 0.4468750,
        size.height * 0.2500000,
        size.width * 0.5000000,
        size.height * 0.2500000);
    path_0.cubicTo(
        size.width * 0.5531250,
        size.height * 0.2500000,
        size.width * 0.5937500,
        size.height * 0.2906250,
        size.width * 0.5937500,
        size.height * 0.3437500);
    path_0.cubicTo(
        size.width * 0.5937500,
        size.height * 0.3968750,
        size.width * 0.5531250,
        size.height * 0.4375000,
        size.width * 0.5000000,
        size.height * 0.4375000);
    path_0.close();

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05200000;
    paint_0_stroke.color = Color(0xff080707).withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9343750, size.height * 0.8937500);
    path_1.lineTo(size.width * 0.8093750, size.height * 0.6437500);
    path_1.cubicTo(
        size.width * 0.8031250,
        size.height * 0.6312500,
        size.width * 0.7937500,
        size.height * 0.6250000,
        size.width * 0.7812500,
        size.height * 0.6250000);
    path_1.lineTo(size.width * 0.7437500, size.height * 0.6250000);
    path_1.cubicTo(
        size.width * 0.6687500,
        size.height * 0.7375000,
        size.width * 0.5750000,
        size.height * 0.8125000,
        size.width * 0.5562500,
        size.height * 0.8250000);
    path_1.cubicTo(
        size.width * 0.5406250,
        size.height * 0.8375000,
        size.width * 0.5218750,
        size.height * 0.8437500,
        size.width * 0.5000000,
        size.height * 0.8437500);
    path_1.cubicTo(
        size.width * 0.4781250,
        size.height * 0.8437500,
        size.width * 0.4593750,
        size.height * 0.8375000,
        size.width * 0.4437500,
        size.height * 0.8250000);
    path_1.cubicTo(
        size.width * 0.4281250,
        size.height * 0.8125000,
        size.width * 0.3312500,
        size.height * 0.7375000,
        size.width * 0.2562500,
        size.height * 0.6250000);
    path_1.lineTo(size.width * 0.2187500, size.height * 0.6250000);
    path_1.cubicTo(
        size.width * 0.2062500,
        size.height * 0.6250000,
        size.width * 0.1968750,
        size.height * 0.6312500,
        size.width * 0.1906250,
        size.height * 0.6437500);
    path_1.lineTo(size.width * 0.06562500, size.height * 0.8937500);
    path_1.cubicTo(
        size.width * 0.05937500,
        size.height * 0.9031250,
        size.width * 0.06250000,
        size.height * 0.9156250,
        size.width * 0.06562500,
        size.height * 0.9250000);
    path_1.cubicTo(
        size.width * 0.06875000,
        size.height * 0.9343750,
        size.width * 0.08437500,
        size.height * 0.9375000,
        size.width * 0.09375000,
        size.height * 0.9375000);
    path_1.lineTo(size.width * 0.9062500, size.height * 0.9375000);
    path_1.cubicTo(
        size.width * 0.9156250,
        size.height * 0.9375000,
        size.width * 0.9281250,
        size.height * 0.9312500,
        size.width * 0.9343750,
        size.height * 0.9218750);
    path_1.cubicTo(
        size.width * 0.9406250,
        size.height * 0.9125000,
        size.width * 0.9375000,
        size.height * 0.9031250,
        size.width * 0.9343750,
        size.height * 0.8937500);
    path_1.close();

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05200000;
    paint_1_stroke.color = Color(0xff080707).withOpacity(1.0);
    paint_1_stroke.strokeCap = StrokeCap.round;
    paint_1_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5000000, size.height * 0.06250000);
    path_2.cubicTo(
        size.width * 0.3437500,
        size.height * 0.06250000,
        size.width * 0.2187500,
        size.height * 0.1875000,
        size.width * 0.2187500,
        size.height * 0.3406250);
    path_2.cubicTo(
        size.width * 0.2187500,
        size.height * 0.5718750,
        size.width * 0.4687500,
        size.height * 0.7687500,
        size.width * 0.4812500,
        size.height * 0.7750000);
    path_2.cubicTo(
        size.width * 0.4875000,
        size.height * 0.7781250,
        size.width * 0.4937500,
        size.height * 0.7812500,
        size.width * 0.5000000,
        size.height * 0.7812500);
    path_2.cubicTo(
        size.width * 0.5062500,
        size.height * 0.7812500,
        size.width * 0.5125000,
        size.height * 0.7781250,
        size.width * 0.5187500,
        size.height * 0.7750000);
    path_2.cubicTo(
        size.width * 0.5312500,
        size.height * 0.7656250,
        size.width * 0.7812500,
        size.height * 0.5718750,
        size.width * 0.7812500,
        size.height * 0.3406250);
    path_2.cubicTo(
        size.width * 0.7812500,
        size.height * 0.1875000,
        size.width * 0.6562500,
        size.height * 0.06250000,
        size.width * 0.5000000,
        size.height * 0.06250000);
    path_2.close();
    path_2.moveTo(size.width * 0.5000000, size.height * 0.4375000);
    path_2.cubicTo(
        size.width * 0.4468750,
        size.height * 0.4375000,
        size.width * 0.4062500,
        size.height * 0.3968750,
        size.width * 0.4062500,
        size.height * 0.3437500);
    path_2.cubicTo(
        size.width * 0.4062500,
        size.height * 0.2906250,
        size.width * 0.4468750,
        size.height * 0.2500000,
        size.width * 0.5000000,
        size.height * 0.2500000);
    path_2.cubicTo(
        size.width * 0.5531250,
        size.height * 0.2500000,
        size.width * 0.5937500,
        size.height * 0.2906250,
        size.width * 0.5937500,
        size.height * 0.3437500);
    path_2.cubicTo(
        size.width * 0.5937500,
        size.height * 0.3968750,
        size.width * 0.5531250,
        size.height * 0.4375000,
        size.width * 0.5000000,
        size.height * 0.4375000);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9343750, size.height * 0.8937500);
    path_3.lineTo(size.width * 0.8093750, size.height * 0.6437500);
    path_3.cubicTo(
        size.width * 0.8031250,
        size.height * 0.6312500,
        size.width * 0.7937500,
        size.height * 0.6250000,
        size.width * 0.7812500,
        size.height * 0.6250000);
    path_3.lineTo(size.width * 0.7437500, size.height * 0.6250000);
    path_3.cubicTo(
        size.width * 0.6687500,
        size.height * 0.7375000,
        size.width * 0.5750000,
        size.height * 0.8125000,
        size.width * 0.5562500,
        size.height * 0.8250000);
    path_3.cubicTo(
        size.width * 0.5406250,
        size.height * 0.8375000,
        size.width * 0.5218750,
        size.height * 0.8437500,
        size.width * 0.5000000,
        size.height * 0.8437500);
    path_3.cubicTo(
        size.width * 0.4781250,
        size.height * 0.8437500,
        size.width * 0.4593750,
        size.height * 0.8375000,
        size.width * 0.4437500,
        size.height * 0.8250000);
    path_3.cubicTo(
        size.width * 0.4281250,
        size.height * 0.8125000,
        size.width * 0.3312500,
        size.height * 0.7375000,
        size.width * 0.2562500,
        size.height * 0.6250000);
    path_3.lineTo(size.width * 0.2187500, size.height * 0.6250000);
    path_3.cubicTo(
        size.width * 0.2062500,
        size.height * 0.6250000,
        size.width * 0.1968750,
        size.height * 0.6312500,
        size.width * 0.1906250,
        size.height * 0.6437500);
    path_3.lineTo(size.width * 0.06562500, size.height * 0.8937500);
    path_3.cubicTo(
        size.width * 0.05937500,
        size.height * 0.9031250,
        size.width * 0.06250000,
        size.height * 0.9156250,
        size.width * 0.06562500,
        size.height * 0.9250000);
    path_3.cubicTo(
        size.width * 0.06875000,
        size.height * 0.9343750,
        size.width * 0.08437500,
        size.height * 0.9375000,
        size.width * 0.09375000,
        size.height * 0.9375000);
    path_3.lineTo(size.width * 0.9062500, size.height * 0.9375000);
    path_3.cubicTo(
        size.width * 0.9156250,
        size.height * 0.9375000,
        size.width * 0.9281250,
        size.height * 0.9312500,
        size.width * 0.9343750,
        size.height * 0.9218750);
    path_3.cubicTo(
        size.width * 0.9406250,
        size.height * 0.9125000,
        size.width * 0.9375000,
        size.height * 0.9031250,
        size.width * 0.9343750,
        size.height * 0.8937500);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
