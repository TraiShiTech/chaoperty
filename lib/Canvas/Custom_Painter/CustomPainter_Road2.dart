import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Road2 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Road2(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01471289, size.height * 0.7166660);
    path_0.lineTo(size.width * 0.9813809, size.height * 0.7166660);
    path_0.lineTo(size.width * 0.9813809, size.height * 0.2833340);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.2833340);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9313809, size.height * 0.7166660);
    path_1.lineTo(size.width * 0.9813809, size.height * 0.7166660);
    path_1.lineTo(size.width * 0.9813809, size.height * 0.2833340);
    path_1.lineTo(size.width * 0.9313809, size.height * 0.2833340);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.01471289, size.height * 0.7166660);
    path_2.lineTo(size.width * 0.06471289, size.height * 0.7166660);
    path_2.lineTo(size.width * 0.06471289, size.height * 0.2833340);
    path_2.lineTo(size.width * 0.01471289, size.height * 0.2833340);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9813809, size.height * 0.7333340);
    path_3.lineTo(size.width * 0.01471289, size.height * 0.7333340);
    path_3.cubicTo(
        size.width * 0.004712891,
        size.height * 0.7333340,
        size.width * -0.001953125,
        size.height * 0.7266680,
        size.width * -0.001953125,
        size.height * 0.7166680);
    path_3.lineTo(size.width * -0.001953125, size.height * 0.2833340);
    path_3.cubicTo(
        size.width * -0.001953125,
        size.height * 0.2733340,
        size.width * 0.004712891,
        size.height * 0.2666680,
        size.width * 0.01471289,
        size.height * 0.2666680);
    path_3.lineTo(size.width * 0.9813789, size.height * 0.2666680);
    path_3.cubicTo(
        size.width * 0.9913789,
        size.height * 0.2666680,
        size.width * 0.9980449,
        size.height * 0.2733340,
        size.width * 0.9980449,
        size.height * 0.2833340);
    path_3.lineTo(size.width * 0.9980449, size.height * 0.7166680);
    path_3.cubicTo(
        size.width * 0.9980469,
        size.height * 0.7266660,
        size.width * 0.9913809,
        size.height * 0.7333340,
        size.width * 0.9813809,
        size.height * 0.7333340);
    path_3.close();
    path_3.moveTo(size.width * 0.03138086, size.height * 0.7000000);
    path_3.lineTo(size.width * 0.9647148, size.height * 0.7000000);
    path_3.lineTo(size.width * 0.9647148, size.height * 0.3000000);
    path_3.lineTo(size.width * 0.03138086, size.height * 0.3000000);
    path_3.lineTo(size.width * 0.03138086, size.height * 0.7000000);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.9813809, size.height * 0.5166660);
    path_4.lineTo(size.width * 0.9480469, size.height * 0.5166660);
    path_4.cubicTo(
        size.width * 0.9380469,
        size.height * 0.5166660,
        size.width * 0.9313809,
        size.height * 0.5100000,
        size.width * 0.9313809,
        size.height * 0.5000000);
    path_4.cubicTo(
        size.width * 0.9313809,
        size.height * 0.4900000,
        size.width * 0.9380469,
        size.height * 0.4833340,
        size.width * 0.9480469,
        size.height * 0.4833340);
    path_4.lineTo(size.width * 0.9813809, size.height * 0.4833340);
    path_4.cubicTo(
        size.width * 0.9913809,
        size.height * 0.4833340,
        size.width * 0.9980469,
        size.height * 0.4900000,
        size.width * 0.9980469,
        size.height * 0.5000000);
    path_4.cubicTo(
        size.width * 0.9980469,
        size.height * 0.5100000,
        size.width * 0.9913809,
        size.height * 0.5166660,
        size.width * 0.9813809,
        size.height * 0.5166660);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.8513809, size.height * 0.5166660);
    path_5.lineTo(size.width * 0.7863809, size.height * 0.5166660);
    path_5.cubicTo(
        size.width * 0.7763809,
        size.height * 0.5166660,
        size.width * 0.7697148,
        size.height * 0.5100000,
        size.width * 0.7697148,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.7697148,
        size.height * 0.4900000,
        size.width * 0.7763809,
        size.height * 0.4833340,
        size.width * 0.7863809,
        size.height * 0.4833340);
    path_5.lineTo(size.width * 0.8513809, size.height * 0.4833340);
    path_5.cubicTo(
        size.width * 0.8613809,
        size.height * 0.4833340,
        size.width * 0.8680469,
        size.height * 0.4900000,
        size.width * 0.8680469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.8680469,
        size.height * 0.5100000,
        size.width * 0.8613809,
        size.height * 0.5166660,
        size.width * 0.8513809,
        size.height * 0.5166660);
    path_5.close();
    path_5.moveTo(size.width * 0.6913809, size.height * 0.5166660);
    path_5.lineTo(size.width * 0.6263809, size.height * 0.5166660);
    path_5.cubicTo(
        size.width * 0.6163809,
        size.height * 0.5166660,
        size.width * 0.6097148,
        size.height * 0.5100000,
        size.width * 0.6097148,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.6097148,
        size.height * 0.4900000,
        size.width * 0.6163809,
        size.height * 0.4833340,
        size.width * 0.6263809,
        size.height * 0.4833340);
    path_5.lineTo(size.width * 0.6913809, size.height * 0.4833340);
    path_5.cubicTo(
        size.width * 0.7013809,
        size.height * 0.4833340,
        size.width * 0.7080469,
        size.height * 0.4900000,
        size.width * 0.7080469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.7080469,
        size.height * 0.5100000,
        size.width * 0.6997129,
        size.height * 0.5166660,
        size.width * 0.6913809,
        size.height * 0.5166660);
    path_5.close();
    path_5.moveTo(size.width * 0.5297129, size.height * 0.5166660);
    path_5.lineTo(size.width * 0.4647129, size.height * 0.5166660);
    path_5.cubicTo(
        size.width * 0.4547129,
        size.height * 0.5166660,
        size.width * 0.4480469,
        size.height * 0.5100000,
        size.width * 0.4480469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.4480469,
        size.height * 0.4900000,
        size.width * 0.4547129,
        size.height * 0.4833340,
        size.width * 0.4647129,
        size.height * 0.4833340);
    path_5.lineTo(size.width * 0.5297129, size.height * 0.4833340);
    path_5.cubicTo(
        size.width * 0.5397129,
        size.height * 0.4833340,
        size.width * 0.5463789,
        size.height * 0.4900000,
        size.width * 0.5463789,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.5463809,
        size.height * 0.5100000,
        size.width * 0.5397129,
        size.height * 0.5166660,
        size.width * 0.5297129,
        size.height * 0.5166660);
    path_5.close();
    path_5.moveTo(size.width * 0.3697129, size.height * 0.5166660);
    path_5.lineTo(size.width * 0.3047129, size.height * 0.5166660);
    path_5.cubicTo(
        size.width * 0.2947129,
        size.height * 0.5166660,
        size.width * 0.2880469,
        size.height * 0.5100000,
        size.width * 0.2880469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.2880469,
        size.height * 0.4900000,
        size.width * 0.2947129,
        size.height * 0.4833340,
        size.width * 0.3047129,
        size.height * 0.4833340);
    path_5.lineTo(size.width * 0.3697129, size.height * 0.4833340);
    path_5.cubicTo(
        size.width * 0.3797129,
        size.height * 0.4833340,
        size.width * 0.3863789,
        size.height * 0.4900000,
        size.width * 0.3863789,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.3863809,
        size.height * 0.5100000,
        size.width * 0.3780469,
        size.height * 0.5166660,
        size.width * 0.3697129,
        size.height * 0.5166660);
    path_5.close();
    path_5.moveTo(size.width * 0.2080469, size.height * 0.5166660);
    path_5.lineTo(size.width * 0.1447129, size.height * 0.5166660);
    path_5.cubicTo(
        size.width * 0.1347129,
        size.height * 0.5166660,
        size.width * 0.1280469,
        size.height * 0.5100000,
        size.width * 0.1280469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.1280469,
        size.height * 0.4900000,
        size.width * 0.1347129,
        size.height * 0.4833340,
        size.width * 0.1447129,
        size.height * 0.4833340);
    path_5.lineTo(size.width * 0.2097129, size.height * 0.4833340);
    path_5.cubicTo(
        size.width * 0.2197129,
        size.height * 0.4833340,
        size.width * 0.2263789,
        size.height * 0.4900000,
        size.width * 0.2263789,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.2263809,
        size.height * 0.5100000,
        size.width * 0.2180469,
        size.height * 0.5166660,
        size.width * 0.2080469,
        size.height * 0.5166660);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.04804688, size.height * 0.5166660);
    path_6.lineTo(size.width * 0.01471289, size.height * 0.5166660);
    path_6.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5166660,
        size.width * -0.001953125,
        size.height * 0.5100000,
        size.width * -0.001953125,
        size.height * 0.5000000);
    path_6.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4900000,
        size.width * 0.004712891,
        size.height * 0.4833340,
        size.width * 0.01471289,
        size.height * 0.4833340);
    path_6.lineTo(size.width * 0.04804688, size.height * 0.4833340);
    path_6.cubicTo(
        size.width * 0.05804688,
        size.height * 0.4833340,
        size.width * 0.06471289,
        size.height * 0.4900000,
        size.width * 0.06471289,
        size.height * 0.5000000);
    path_6.cubicTo(
        size.width * 0.06471289,
        size.height * 0.5100000,
        size.width * 0.05804687,
        size.height * 0.5166660,
        size.width * 0.04804688,
        size.height * 0.5166660);
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
