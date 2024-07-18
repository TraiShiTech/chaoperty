import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Road6 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Road6(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6813809, size.height * 0.3166660);
    path_0.lineTo(size.width * 0.6813809, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.3147129, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.3147129, size.height * 0.3166660);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.3166660);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.6833340);
    path_0.lineTo(size.width * 0.3147129, size.height * 0.6833340);
    path_0.lineTo(size.width * 0.3147129, size.height * 0.9833340);
    path_0.lineTo(size.width * 0.6813809, size.height * 0.9833340);
    path_0.lineTo(size.width * 0.6813809, size.height * 0.6833340);
    path_0.lineTo(size.width * 0.9813809, size.height * 0.6833340);
    path_0.lineTo(size.width * 0.9813809, size.height * 0.3166660);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9313809, size.height * 0.6833340);
    path_1.lineTo(size.width * 0.9813809, size.height * 0.6833340);
    path_1.lineTo(size.width * 0.9813809, size.height * 0.3166660);
    path_1.lineTo(size.width * 0.9313809, size.height * 0.3166660);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.01471289, size.height * 0.6833340);
    path_2.lineTo(size.width * 0.06471289, size.height * 0.6833340);
    path_2.lineTo(size.width * 0.06471289, size.height * 0.3166660);
    path_2.lineTo(size.width * 0.01471289, size.height * 0.3166660);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.6813809, size.height);
    path_3.lineTo(size.width * 0.3147129, size.height);
    path_3.cubicTo(
        size.width * 0.3047129,
        size.height,
        size.width * 0.2980469,
        size.height * 0.9933340,
        size.width * 0.2980469,
        size.height * 0.9833340);
    path_3.lineTo(size.width * 0.2980469, size.height * 0.7000000);
    path_3.lineTo(size.width * 0.01471289, size.height * 0.7000000);
    path_3.cubicTo(
        size.width * 0.004712891,
        size.height * 0.7000000,
        size.width * -0.001953125,
        size.height * 0.6933340,
        size.width * -0.001953125,
        size.height * 0.6833340);
    path_3.lineTo(size.width * -0.001953125, size.height * 0.3166660);
    path_3.cubicTo(
        size.width * -0.001953125,
        size.height * 0.3066660,
        size.width * 0.004712891,
        size.height * 0.3000000,
        size.width * 0.01471289,
        size.height * 0.3000000);
    path_3.lineTo(size.width * 0.2980469, size.height * 0.3000000);
    path_3.lineTo(size.width * 0.2980469, size.height * 0.01666602);
    path_3.cubicTo(size.width * 0.2980469, size.height * 0.006666016,
        size.width * 0.3047129, 0, size.width * 0.3147129, 0);
    path_3.lineTo(size.width * 0.6813789, 0);
    path_3.cubicTo(
        size.width * 0.6913789,
        0,
        size.width * 0.6980449,
        size.height * 0.006666016,
        size.width * 0.6980449,
        size.height * 0.01666602);
    path_3.lineTo(size.width * 0.6980449, size.height * 0.3000000);
    path_3.lineTo(size.width * 0.9813789, size.height * 0.3000000);
    path_3.cubicTo(
        size.width * 0.9913789,
        size.height * 0.3000000,
        size.width * 0.9980449,
        size.height * 0.3066660,
        size.width * 0.9980449,
        size.height * 0.3166660);
    path_3.lineTo(size.width * 0.9980449, size.height * 0.6833320);
    path_3.cubicTo(
        size.width * 0.9980449,
        size.height * 0.6933320,
        size.width * 0.9913789,
        size.height * 0.6999980,
        size.width * 0.9813789,
        size.height * 0.6999980);
    path_3.lineTo(size.width * 0.6980469, size.height * 0.6999980);
    path_3.lineTo(size.width * 0.6980469, size.height * 0.9833320);
    path_3.cubicTo(
        size.width * 0.6980469,
        size.height * 0.9933340,
        size.width * 0.6913809,
        size.height,
        size.width * 0.6813809,
        size.height);
    path_3.close();
    path_3.moveTo(size.width * 0.3313809, size.height * 0.9666660);
    path_3.lineTo(size.width * 0.6647148, size.height * 0.9666660);
    path_3.lineTo(size.width * 0.6647148, size.height * 0.6833340);
    path_3.cubicTo(
        size.width * 0.6647148,
        size.height * 0.6733340,
        size.width * 0.6713809,
        size.height * 0.6666680,
        size.width * 0.6813809,
        size.height * 0.6666680);
    path_3.lineTo(size.width * 0.9647148, size.height * 0.6666680);
    path_3.lineTo(size.width * 0.9647148, size.height * 0.3333340);
    path_3.lineTo(size.width * 0.6813809, size.height * 0.3333340);
    path_3.cubicTo(
        size.width * 0.6713809,
        size.height * 0.3333340,
        size.width * 0.6647148,
        size.height * 0.3266680,
        size.width * 0.6647148,
        size.height * 0.3166680);
    path_3.lineTo(size.width * 0.6647148, size.height * 0.03333398);
    path_3.lineTo(size.width * 0.3313809, size.height * 0.03333398);
    path_3.lineTo(size.width * 0.3313809, size.height * 0.3166680);
    path_3.cubicTo(
        size.width * 0.3313809,
        size.height * 0.3266680,
        size.width * 0.3247148,
        size.height * 0.3333340,
        size.width * 0.3147148,
        size.height * 0.3333340);
    path_3.lineTo(size.width * 0.03138086, size.height * 0.3333340);
    path_3.lineTo(size.width * 0.03138086, size.height * 0.6666680);
    path_3.lineTo(size.width * 0.3147148, size.height * 0.6666680);
    path_3.cubicTo(
        size.width * 0.3247148,
        size.height * 0.6666680,
        size.width * 0.3313809,
        size.height * 0.6733340,
        size.width * 0.3313809,
        size.height * 0.6833340);
    path_3.lineTo(size.width * 0.3313809, size.height * 0.9666660);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4980469, size.height * 0.1500000);
    path_4.cubicTo(
        size.width * 0.4880469,
        size.height * 0.1500000,
        size.width * 0.4813809,
        size.height * 0.1433340,
        size.width * 0.4813809,
        size.height * 0.1333340);
    path_4.lineTo(size.width * 0.4813809, size.height * 0.08333398);
    path_4.cubicTo(
        size.width * 0.4813809,
        size.height * 0.07333398,
        size.width * 0.4880469,
        size.height * 0.06666797,
        size.width * 0.4980469,
        size.height * 0.06666797);
    path_4.cubicTo(
        size.width * 0.5080469,
        size.height * 0.06666797,
        size.width * 0.5147129,
        size.height * 0.07333398,
        size.width * 0.5147129,
        size.height * 0.08333398);
    path_4.lineTo(size.width * 0.5147129, size.height * 0.1333340);
    path_4.cubicTo(
        size.width * 0.5147129,
        size.height * 0.1433340,
        size.width * 0.5080469,
        size.height * 0.1500000,
        size.width * 0.4980469,
        size.height * 0.1500000);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.2833340);
    path_5.cubicTo(
        size.width * 0.4880469,
        size.height * 0.2833340,
        size.width * 0.4813809,
        size.height * 0.2766680,
        size.width * 0.4813809,
        size.height * 0.2666680);
    path_5.lineTo(size.width * 0.4813809, size.height * 0.2166680);
    path_5.cubicTo(
        size.width * 0.4813809,
        size.height * 0.2066680,
        size.width * 0.4880469,
        size.height * 0.2000020,
        size.width * 0.4980469,
        size.height * 0.2000020);
    path_5.cubicTo(
        size.width * 0.5080469,
        size.height * 0.2000020,
        size.width * 0.5147129,
        size.height * 0.2066680,
        size.width * 0.5147129,
        size.height * 0.2166680);
    path_5.lineTo(size.width * 0.5147129, size.height * 0.2666680);
    path_5.cubicTo(
        size.width * 0.5147129,
        size.height * 0.2766660,
        size.width * 0.5080469,
        size.height * 0.2833340,
        size.width * 0.4980469,
        size.height * 0.2833340);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4980469, size.height * 0.4166660);
    path_6.cubicTo(
        size.width * 0.4880469,
        size.height * 0.4166660,
        size.width * 0.4813809,
        size.height * 0.4100000,
        size.width * 0.4813809,
        size.height * 0.4000000);
    path_6.lineTo(size.width * 0.4813809, size.height * 0.3500000);
    path_6.cubicTo(
        size.width * 0.4813809,
        size.height * 0.3400000,
        size.width * 0.4880469,
        size.height * 0.3333340,
        size.width * 0.4980469,
        size.height * 0.3333340);
    path_6.cubicTo(
        size.width * 0.5080469,
        size.height * 0.3333340,
        size.width * 0.5147129,
        size.height * 0.3400000,
        size.width * 0.5147129,
        size.height * 0.3500000);
    path_6.lineTo(size.width * 0.5147129, size.height * 0.4000000);
    path_6.cubicTo(
        size.width * 0.5147129,
        size.height * 0.4100000,
        size.width * 0.5080469,
        size.height * 0.4166660,
        size.width * 0.4980469,
        size.height * 0.4166660);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.4980469, size.height * 0.5500000);
    path_7.cubicTo(
        size.width * 0.4880469,
        size.height * 0.5500000,
        size.width * 0.4813809,
        size.height * 0.5433340,
        size.width * 0.4813809,
        size.height * 0.5333340);
    path_7.lineTo(size.width * 0.4813809, size.height * 0.4833340);
    path_7.cubicTo(
        size.width * 0.4813809,
        size.height * 0.4733340,
        size.width * 0.4880469,
        size.height * 0.4666680,
        size.width * 0.4980469,
        size.height * 0.4666680);
    path_7.cubicTo(
        size.width * 0.5080469,
        size.height * 0.4666680,
        size.width * 0.5147129,
        size.height * 0.4733340,
        size.width * 0.5147129,
        size.height * 0.4833340);
    path_7.lineTo(size.width * 0.5147129, size.height * 0.5333340);
    path_7.cubicTo(
        size.width * 0.5147129,
        size.height * 0.5433340,
        size.width * 0.5080469,
        size.height * 0.5500000,
        size.width * 0.4980469,
        size.height * 0.5500000);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.4980469, size.height * 0.6833340);
    path_8.cubicTo(
        size.width * 0.4880469,
        size.height * 0.6833340,
        size.width * 0.4813809,
        size.height * 0.6766680,
        size.width * 0.4813809,
        size.height * 0.6666680);
    path_8.lineTo(size.width * 0.4813809, size.height * 0.6166680);
    path_8.cubicTo(
        size.width * 0.4813809,
        size.height * 0.6066680,
        size.width * 0.4880469,
        size.height * 0.6000020,
        size.width * 0.4980469,
        size.height * 0.6000020);
    path_8.cubicTo(
        size.width * 0.5080469,
        size.height * 0.6000020,
        size.width * 0.5147129,
        size.height * 0.6066680,
        size.width * 0.5147129,
        size.height * 0.6166680);
    path_8.lineTo(size.width * 0.5147129, size.height * 0.6666680);
    path_8.cubicTo(
        size.width * 0.5147129,
        size.height * 0.6766660,
        size.width * 0.5080469,
        size.height * 0.6833340,
        size.width * 0.4980469,
        size.height * 0.6833340);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.4980469, size.height * 0.8166660);
    path_9.cubicTo(
        size.width * 0.4880469,
        size.height * 0.8166660,
        size.width * 0.4813809,
        size.height * 0.8100000,
        size.width * 0.4813809,
        size.height * 0.8000000);
    path_9.lineTo(size.width * 0.4813809, size.height * 0.7500000);
    path_9.cubicTo(
        size.width * 0.4813809,
        size.height * 0.7400000,
        size.width * 0.4880469,
        size.height * 0.7333340,
        size.width * 0.4980469,
        size.height * 0.7333340);
    path_9.cubicTo(
        size.width * 0.5080469,
        size.height * 0.7333340,
        size.width * 0.5147129,
        size.height * 0.7400000,
        size.width * 0.5147129,
        size.height * 0.7500000);
    path_9.lineTo(size.width * 0.5147129, size.height * 0.8000000);
    path_9.cubicTo(
        size.width * 0.5147129,
        size.height * 0.8100000,
        size.width * 0.5080469,
        size.height * 0.8166660,
        size.width * 0.4980469,
        size.height * 0.8166660);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.4980469, size.height * 0.9333340);
    path_10.cubicTo(
        size.width * 0.4880469,
        size.height * 0.9333340,
        size.width * 0.4813809,
        size.height * 0.9266680,
        size.width * 0.4813809,
        size.height * 0.9166680);
    path_10.lineTo(size.width * 0.4813809, size.height * 0.8833340);
    path_10.cubicTo(
        size.width * 0.4813809,
        size.height * 0.8733340,
        size.width * 0.4880469,
        size.height * 0.8666680,
        size.width * 0.4980469,
        size.height * 0.8666680);
    path_10.cubicTo(
        size.width * 0.5080469,
        size.height * 0.8666680,
        size.width * 0.5147129,
        size.height * 0.8733340,
        size.width * 0.5147129,
        size.height * 0.8833340);
    path_10.lineTo(size.width * 0.5147129, size.height * 0.9166680);
    path_10.cubicTo(
        size.width * 0.5147129,
        size.height * 0.9266660,
        size.width * 0.5080469,
        size.height * 0.9333340,
        size.width * 0.4980469,
        size.height * 0.9333340);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.9147129, size.height * 0.5166660);
    path_11.lineTo(size.width * 0.8647129, size.height * 0.5166660);
    path_11.cubicTo(
        size.width * 0.8547129,
        size.height * 0.5166660,
        size.width * 0.8480469,
        size.height * 0.5100000,
        size.width * 0.8480469,
        size.height * 0.5000000);
    path_11.cubicTo(
        size.width * 0.8480469,
        size.height * 0.4900000,
        size.width * 0.8547129,
        size.height * 0.4833340,
        size.width * 0.8647129,
        size.height * 0.4833340);
    path_11.lineTo(size.width * 0.9147129, size.height * 0.4833340);
    path_11.cubicTo(
        size.width * 0.9247129,
        size.height * 0.4833340,
        size.width * 0.9313789,
        size.height * 0.4900000,
        size.width * 0.9313789,
        size.height * 0.5000000);
    path_11.cubicTo(
        size.width * 0.9313809,
        size.height * 0.5100000,
        size.width * 0.9247129,
        size.height * 0.5166660,
        size.width * 0.9147129,
        size.height * 0.5166660);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.7813809, size.height * 0.5166660);
    path_12.lineTo(size.width * 0.7313809, size.height * 0.5166660);
    path_12.cubicTo(
        size.width * 0.7213809,
        size.height * 0.5166660,
        size.width * 0.7147148,
        size.height * 0.5100000,
        size.width * 0.7147148,
        size.height * 0.5000000);
    path_12.cubicTo(
        size.width * 0.7147148,
        size.height * 0.4900000,
        size.width * 0.7213809,
        size.height * 0.4833340,
        size.width * 0.7313809,
        size.height * 0.4833340);
    path_12.lineTo(size.width * 0.7813809, size.height * 0.4833340);
    path_12.cubicTo(
        size.width * 0.7913809,
        size.height * 0.4833340,
        size.width * 0.7980469,
        size.height * 0.4900000,
        size.width * 0.7980469,
        size.height * 0.5000000);
    path_12.cubicTo(
        size.width * 0.7980469,
        size.height * 0.5100000,
        size.width * 0.7913809,
        size.height * 0.5166660,
        size.width * 0.7813809,
        size.height * 0.5166660);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.6480469, size.height * 0.5166660);
    path_13.lineTo(size.width * 0.5980469, size.height * 0.5166660);
    path_13.cubicTo(
        size.width * 0.5880469,
        size.height * 0.5166660,
        size.width * 0.5813809,
        size.height * 0.5100000,
        size.width * 0.5813809,
        size.height * 0.5000000);
    path_13.cubicTo(
        size.width * 0.5813809,
        size.height * 0.4900000,
        size.width * 0.5880469,
        size.height * 0.4833340,
        size.width * 0.5980469,
        size.height * 0.4833340);
    path_13.lineTo(size.width * 0.6480469, size.height * 0.4833340);
    path_13.cubicTo(
        size.width * 0.6580469,
        size.height * 0.4833340,
        size.width * 0.6647129,
        size.height * 0.4900000,
        size.width * 0.6647129,
        size.height * 0.5000000);
    path_13.cubicTo(
        size.width * 0.6647129,
        size.height * 0.5100000,
        size.width * 0.6580469,
        size.height * 0.5166660,
        size.width * 0.6480469,
        size.height * 0.5166660);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.3813809, size.height * 0.5166660);
    path_14.lineTo(size.width * 0.3313809, size.height * 0.5166660);
    path_14.cubicTo(
        size.width * 0.3213809,
        size.height * 0.5166660,
        size.width * 0.3147148,
        size.height * 0.5100000,
        size.width * 0.3147148,
        size.height * 0.5000000);
    path_14.cubicTo(
        size.width * 0.3147148,
        size.height * 0.4900000,
        size.width * 0.3213809,
        size.height * 0.4833340,
        size.width * 0.3313809,
        size.height * 0.4833340);
    path_14.lineTo(size.width * 0.3813809, size.height * 0.4833340);
    path_14.cubicTo(
        size.width * 0.3913809,
        size.height * 0.4833340,
        size.width * 0.3980469,
        size.height * 0.4900000,
        size.width * 0.3980469,
        size.height * 0.5000000);
    path_14.cubicTo(
        size.width * 0.3980469,
        size.height * 0.5100000,
        size.width * 0.3913809,
        size.height * 0.5166660,
        size.width * 0.3813809,
        size.height * 0.5166660);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.2480469, size.height * 0.5166660);
    path_15.lineTo(size.width * 0.1980469, size.height * 0.5166660);
    path_15.cubicTo(
        size.width * 0.1880469,
        size.height * 0.5166660,
        size.width * 0.1813809,
        size.height * 0.5100000,
        size.width * 0.1813809,
        size.height * 0.5000000);
    path_15.cubicTo(
        size.width * 0.1813809,
        size.height * 0.4900000,
        size.width * 0.1880469,
        size.height * 0.4833340,
        size.width * 0.1980469,
        size.height * 0.4833340);
    path_15.lineTo(size.width * 0.2480469, size.height * 0.4833340);
    path_15.cubicTo(
        size.width * 0.2580469,
        size.height * 0.4833340,
        size.width * 0.2647129,
        size.height * 0.4900000,
        size.width * 0.2647129,
        size.height * 0.5000000);
    path_15.cubicTo(
        size.width * 0.2647129,
        size.height * 0.5100000,
        size.width * 0.2580469,
        size.height * 0.5166660,
        size.width * 0.2480469,
        size.height * 0.5166660);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.1147129, size.height * 0.5166660);
    path_16.lineTo(size.width * 0.08138086, size.height * 0.5166660);
    path_16.cubicTo(
        size.width * 0.07138086,
        size.height * 0.5166660,
        size.width * 0.06471484,
        size.height * 0.5100000,
        size.width * 0.06471484,
        size.height * 0.5000000);
    path_16.cubicTo(
        size.width * 0.06471484,
        size.height * 0.4900000,
        size.width * 0.07138086,
        size.height * 0.4833340,
        size.width * 0.08138086,
        size.height * 0.4833340);
    path_16.lineTo(size.width * 0.1147148, size.height * 0.4833340);
    path_16.cubicTo(
        size.width * 0.1247148,
        size.height * 0.4833340,
        size.width * 0.1313809,
        size.height * 0.4900000,
        size.width * 0.1313809,
        size.height * 0.5000000);
    path_16.cubicTo(
        size.width * 0.1313809,
        size.height * 0.5100000,
        size.width * 0.1247129,
        size.height * 0.5166660,
        size.width * 0.1147129,
        size.height * 0.5166660);
    path_16.close();

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
