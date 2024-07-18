import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop2 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop2(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7147129, size.height * 0.2833340);
    path_0.lineTo(size.width * 0.7147129, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.7166660);
    path_0.lineTo(size.width * 0.2813809, size.height * 0.7166660);
    path_0.lineTo(size.width * 0.2813809, size.height * 0.9833340);
    path_0.lineTo(size.width * 0.9813809, size.height * 0.9833340);
    path_0.lineTo(size.width * 0.9813809, size.height * 0.2833340);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffB0B6BB).withOpacity(0.8);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2813809, size.height * 0.7166660);
    path_1.lineTo(size.width * 0.7147129, size.height * 0.7166660);
    path_1.lineTo(size.width * 0.7147129, size.height * 0.2833340);
    path_1.lineTo(size.width * 0.2813809, size.height * 0.2833340);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.7230469, size.height * 0.3000000);
    path_2.lineTo(size.width * 0.6980469, size.height * 0.3000000);
    path_2.lineTo(size.width * 0.6980469, size.height * 0.2750000);
    path_2.cubicTo(
        size.width * 0.6980469,
        size.height * 0.2650000,
        size.width * 0.7047129,
        size.height * 0.2583340,
        size.width * 0.7147129,
        size.height * 0.2583340);
    path_2.cubicTo(
        size.width * 0.7213789,
        size.height * 0.2583340,
        size.width * 0.7280469,
        size.height * 0.2616680,
        size.width * 0.7297129,
        size.height * 0.2683340);
    path_2.cubicTo(
        size.width * 0.7347129,
        size.height * 0.2716680,
        size.width * 0.7397129,
        size.height * 0.2766680,
        size.width * 0.7397129,
        size.height * 0.2833340);
    path_2.cubicTo(
        size.width * 0.7397129,
        size.height * 0.2933340,
        size.width * 0.7330469,
        size.height * 0.3000000,
        size.width * 0.7230469,
        size.height * 0.3000000);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.7147129, size.height * 0.2200000);
    path_3.cubicTo(
        size.width * 0.7047129,
        size.height * 0.2200000,
        size.width * 0.6980469,
        size.height * 0.2133340,
        size.width * 0.6980469,
        size.height * 0.2033340);
    path_3.lineTo(size.width * 0.6980469, size.height * 0.1850000);
    path_3.cubicTo(
        size.width * 0.6980469,
        size.height * 0.1750000,
        size.width * 0.7047129,
        size.height * 0.1683340,
        size.width * 0.7147129,
        size.height * 0.1683340);
    path_3.cubicTo(
        size.width * 0.7247129,
        size.height * 0.1683340,
        size.width * 0.7313789,
        size.height * 0.1750000,
        size.width * 0.7313789,
        size.height * 0.1850000);
    path_3.lineTo(size.width * 0.7313789, size.height * 0.2033340);
    path_3.cubicTo(
        size.width * 0.7313809,
        size.height * 0.2133340,
        size.width * 0.7247129,
        size.height * 0.2200000,
        size.width * 0.7147129,
        size.height * 0.2200000);
    path_3.close();
    path_3.moveTo(size.width * 0.7147129, size.height * 0.1316660);
    path_3.cubicTo(
        size.width * 0.7047129,
        size.height * 0.1316660,
        size.width * 0.6980469,
        size.height * 0.1250000,
        size.width * 0.6980469,
        size.height * 0.1150000);
    path_3.lineTo(size.width * 0.6980469, size.height * 0.09666602);
    path_3.cubicTo(
        size.width * 0.6980469,
        size.height * 0.08666602,
        size.width * 0.7047129,
        size.height * 0.08000000,
        size.width * 0.7147129,
        size.height * 0.08000000);
    path_3.cubicTo(
        size.width * 0.7247129,
        size.height * 0.08000000,
        size.width * 0.7313789,
        size.height * 0.08666602,
        size.width * 0.7313789,
        size.height * 0.09666602);
    path_3.lineTo(size.width * 0.7313789, size.height * 0.1150000);
    path_3.cubicTo(
        size.width * 0.7313809,
        size.height * 0.1233340,
        size.width * 0.7247129,
        size.height * 0.1316660,
        size.width * 0.7147129,
        size.height * 0.1316660);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.7147129, size.height * 0.04166602);
    path_4.cubicTo(
        size.width * 0.7080469,
        size.height * 0.04166602,
        size.width * 0.7013789,
        size.height * 0.03833203,
        size.width * 0.6997129,
        size.height * 0.03166602);
    path_4.cubicTo(
        size.width * 0.6947129,
        size.height * 0.02833203,
        size.width * 0.6897129,
        size.height * 0.02333203,
        size.width * 0.6897129,
        size.height * 0.01666602);
    path_4.cubicTo(
        size.width * 0.6897129,
        size.height * 0.006666016,
        size.width * 0.6963789,
        size.height * -3.469447e-18,
        size.width * 0.7063789,
        size.height * -3.469447e-18);
    path_4.lineTo(size.width * 0.7313789, size.height * -3.469447e-18);
    path_4.lineTo(size.width * 0.7313789, size.height * 0.02500000);
    path_4.cubicTo(
        size.width * 0.7313809,
        size.height * 0.03500000,
        size.width * 0.7247129,
        size.height * 0.04166602,
        size.width * 0.7147129,
        size.height * 0.04166602);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.6363809, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.6180469, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.6080469,
        size.height * 0.03333398,
        size.width * 0.6013809,
        size.height * 0.02666797,
        size.width * 0.6013809,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.6013809, size.height * 0.006667969,
        size.width * 0.6080469, 0, size.width * 0.6180469, 0);
    path_5.lineTo(size.width * 0.6363809, 0);
    path_5.cubicTo(
        size.width * 0.6463809,
        0,
        size.width * 0.6530469,
        size.height * 0.006666016,
        size.width * 0.6530469,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.6530469,
        size.height * 0.02666602,
        size.width * 0.6447129,
        size.height * 0.03333398,
        size.width * 0.6363809,
        size.height * 0.03333398);
    path_5.close();
    path_5.moveTo(size.width * 0.5480469, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.5313809, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.5213809,
        size.height * 0.03333398,
        size.width * 0.5147148,
        size.height * 0.02666797,
        size.width * 0.5147148,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.5147148, size.height * 0.006667969,
        size.width * 0.5213809, 0, size.width * 0.5313809, 0);
    path_5.lineTo(size.width * 0.5480469, 0);
    path_5.cubicTo(
        size.width * 0.5580469,
        0,
        size.width * 0.5647129,
        size.height * 0.006666016,
        size.width * 0.5647129,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.5647129,
        size.height * 0.02666602,
        size.width * 0.5580469,
        size.height * 0.03333398,
        size.width * 0.5480469,
        size.height * 0.03333398);
    path_5.close();
    path_5.moveTo(size.width * 0.4613809, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.4430469, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.4330469,
        size.height * 0.03333398,
        size.width * 0.4263809,
        size.height * 0.02666797,
        size.width * 0.4263809,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.4263809, size.height * 0.006667969,
        size.width * 0.4330469, 0, size.width * 0.4430469, 0);
    path_5.lineTo(size.width * 0.4613809, 0);
    path_5.cubicTo(
        size.width * 0.4713809,
        0,
        size.width * 0.4780469,
        size.height * 0.006666016,
        size.width * 0.4780469,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.4780469,
        size.height * 0.02666602,
        size.width * 0.4697129,
        size.height * 0.03333398,
        size.width * 0.4613809,
        size.height * 0.03333398);
    path_5.close();
    path_5.moveTo(size.width * 0.3730469, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.3547129, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.3447129,
        size.height * 0.03333398,
        size.width * 0.3380469,
        size.height * 0.02666797,
        size.width * 0.3380469,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.3380469, size.height * 0.006667969,
        size.width * 0.3447129, 0, size.width * 0.3547129, 0);
    path_5.lineTo(size.width * 0.3730469, 0);
    path_5.cubicTo(
        size.width * 0.3830469,
        0,
        size.width * 0.3897129,
        size.height * 0.006666016,
        size.width * 0.3897129,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.3897129,
        size.height * 0.02666602,
        size.width * 0.3830469,
        size.height * 0.03333398,
        size.width * 0.3730469,
        size.height * 0.03333398);
    path_5.close();
    path_5.moveTo(size.width * 0.2863809, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.2680469, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.2580469,
        size.height * 0.03333398,
        size.width * 0.2513809,
        size.height * 0.02666797,
        size.width * 0.2513809,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.2513809, size.height * 0.006667969,
        size.width * 0.2580469, 0, size.width * 0.2680469, 0);
    path_5.lineTo(size.width * 0.2863809, 0);
    path_5.cubicTo(
        size.width * 0.2963809,
        0,
        size.width * 0.3030469,
        size.height * 0.006666016,
        size.width * 0.3030469,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.3030469,
        size.height * 0.02666602,
        size.width * 0.2947129,
        size.height * 0.03333398,
        size.width * 0.2863809,
        size.height * 0.03333398);
    path_5.close();
    path_5.moveTo(size.width * 0.1980469, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.1813809, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.1713809,
        size.height * 0.03333398,
        size.width * 0.1647148,
        size.height * 0.02666797,
        size.width * 0.1647148,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.1647148, size.height * 0.006667969,
        size.width * 0.1713809, 0, size.width * 0.1813809, 0);
    path_5.lineTo(size.width * 0.1980469, 0);
    path_5.cubicTo(
        size.width * 0.2080469,
        0,
        size.width * 0.2147129,
        size.height * 0.006666016,
        size.width * 0.2147129,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.2147129,
        size.height * 0.02666602,
        size.width * 0.2080469,
        size.height * 0.03333398,
        size.width * 0.1980469,
        size.height * 0.03333398);
    path_5.close();
    path_5.moveTo(size.width * 0.1113809, size.height * 0.03333398);
    path_5.lineTo(size.width * 0.09304688, size.height * 0.03333398);
    path_5.cubicTo(
        size.width * 0.08304688,
        size.height * 0.03333398,
        size.width * 0.07638086,
        size.height * 0.02666797,
        size.width * 0.07638086,
        size.height * 0.01666797);
    path_5.cubicTo(size.width * 0.07638086, size.height * 0.006667969,
        size.width * 0.08304688, 0, size.width * 0.09304688, 0);
    path_5.lineTo(size.width * 0.1113809, 0);
    path_5.cubicTo(
        size.width * 0.1213809,
        0,
        size.width * 0.1280469,
        size.height * 0.006666016,
        size.width * 0.1280469,
        size.height * 0.01666602);
    path_5.cubicTo(
        size.width * 0.1280469,
        size.height * 0.02666602,
        size.width * 0.1197129,
        size.height * 0.03333398,
        size.width * 0.1113809,
        size.height * 0.03333398);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.01471289, size.height * 0.04166602);
    path_6.cubicTo(
        size.width * 0.004712891,
        size.height * 0.04166602,
        size.width * -0.001953125,
        size.height * 0.03500000,
        size.width * -0.001953125,
        size.height * 0.02500000);
    path_6.lineTo(size.width * -0.001953125, 0);
    path_6.lineTo(size.width * 0.02304688, 0);
    path_6.cubicTo(
        size.width * 0.03304688,
        0,
        size.width * 0.03971289,
        size.height * 0.006666016,
        size.width * 0.03971289,
        size.height * 0.01666602);
    path_6.cubicTo(
        size.width * 0.03971289,
        size.height * 0.02333203,
        size.width * 0.03637891,
        size.height * 0.03000000,
        size.width * 0.02971289,
        size.height * 0.03166602);
    path_6.cubicTo(
        size.width * 0.02804687,
        size.height * 0.03833398,
        size.width * 0.02138086,
        size.height * 0.04166602,
        size.width * 0.01471289,
        size.height * 0.04166602);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.6550000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.6550000,
        size.width * -0.001953125,
        size.height * 0.6483340,
        size.width * -0.001953125,
        size.height * 0.6383340);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.6200000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.6100000,
        size.width * 0.004712891,
        size.height * 0.6033340,
        size.width * 0.01471289,
        size.height * 0.6033340);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.6033340,
        size.width * 0.03137891,
        size.height * 0.6100000,
        size.width * 0.03137891,
        size.height * 0.6200000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.6383340);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.6466660,
        size.width * 0.02471289,
        size.height * 0.6550000,
        size.width * 0.01471289,
        size.height * 0.6550000);
    path_7.close();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.5666660);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5666660,
        size.width * -0.001953125,
        size.height * 0.5600000,
        size.width * -0.001953125,
        size.height * 0.5500000);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.5333340);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.5233340,
        size.width * 0.004712891,
        size.height * 0.5166680,
        size.width * 0.01471289,
        size.height * 0.5166680);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.5166680,
        size.width * 0.03137891,
        size.height * 0.5233340,
        size.width * 0.03137891,
        size.height * 0.5333340);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.5500000);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.5600000,
        size.width * 0.02471289,
        size.height * 0.5666660,
        size.width * 0.01471289,
        size.height * 0.5666660);
    path_7.close();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.4800000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.4800000,
        size.width * -0.001953125,
        size.height * 0.4733340,
        size.width * -0.001953125,
        size.height * 0.4633340);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.4450000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4350000,
        size.width * 0.004712891,
        size.height * 0.4283340,
        size.width * 0.01471289,
        size.height * 0.4283340);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.4283340,
        size.width * 0.03137891,
        size.height * 0.4350000,
        size.width * 0.03137891,
        size.height * 0.4450000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.4633340);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.4716660,
        size.width * 0.02471289,
        size.height * 0.4800000,
        size.width * 0.01471289,
        size.height * 0.4800000);
    path_7.close();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.3916660);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.3916660,
        size.width * -0.001953125,
        size.height * 0.3850000,
        size.width * -0.001953125,
        size.height * 0.3750000);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.3566660);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.3466660,
        size.width * 0.004712891,
        size.height * 0.3400000,
        size.width * 0.01471289,
        size.height * 0.3400000);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.3400000,
        size.width * 0.03137891,
        size.height * 0.3466660,
        size.width * 0.03137891,
        size.height * 0.3566660);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.3750000);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.3850000,
        size.width * 0.02471289,
        size.height * 0.3916660,
        size.width * 0.01471289,
        size.height * 0.3916660);
    path_7.close();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.3050000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.3050000,
        size.width * -0.001953125,
        size.height * 0.2983340,
        size.width * -0.001953125,
        size.height * 0.2883340);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.2700000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.2600000,
        size.width * 0.004712891,
        size.height * 0.2533340,
        size.width * 0.01471289,
        size.height * 0.2533340);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.2533340,
        size.width * 0.03137891,
        size.height * 0.2600000,
        size.width * 0.03137891,
        size.height * 0.2700000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.2883340);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.2966660,
        size.width * 0.02471289,
        size.height * 0.3050000,
        size.width * 0.01471289,
        size.height * 0.3050000);
    path_7.close();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.2166660);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.2166660,
        size.width * -0.001953125,
        size.height * 0.2100000,
        size.width * -0.001953125,
        size.height * 0.2000000);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.1833340);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.1733340,
        size.width * 0.004712891,
        size.height * 0.1666680,
        size.width * 0.01471289,
        size.height * 0.1666680);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.1666680,
        size.width * 0.03137891,
        size.height * 0.1733340,
        size.width * 0.03137891,
        size.height * 0.1833340);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.2000000);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.2100000,
        size.width * 0.02471289,
        size.height * 0.2166660,
        size.width * 0.01471289,
        size.height * 0.2166660);
    path_7.close();
    path_7.moveTo(size.width * 0.01471289, size.height * 0.1300000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.1300000,
        size.width * -0.001953125,
        size.height * 0.1233340,
        size.width * -0.001953125,
        size.height * 0.1133340);
    path_7.lineTo(size.width * -0.001953125, size.height * 0.09500000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.08500000,
        size.width * 0.004712891,
        size.height * 0.07833398,
        size.width * 0.01471289,
        size.height * 0.07833398);
    path_7.cubicTo(
        size.width * 0.02471289,
        size.height * 0.07833398,
        size.width * 0.03137891,
        size.height * 0.08500000,
        size.width * 0.03137891,
        size.height * 0.09500000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.1133340);
    path_7.cubicTo(
        size.width * 0.03138086,
        size.height * 0.1216660,
        size.width * 0.02471289,
        size.height * 0.1300000,
        size.width * 0.01471289,
        size.height * 0.1300000);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.02304688, size.height * 0.7333340);
    path_8.lineTo(size.width * -0.001953125, size.height * 0.7333340);
    path_8.lineTo(size.width * -0.001953125, size.height * 0.7083340);
    path_8.cubicTo(
        size.width * -0.001953125,
        size.height * 0.6983340,
        size.width * 0.004712891,
        size.height * 0.6916680,
        size.width * 0.01471289,
        size.height * 0.6916680);
    path_8.cubicTo(
        size.width * 0.02137891,
        size.height * 0.6916680,
        size.width * 0.02804687,
        size.height * 0.6950020,
        size.width * 0.02971289,
        size.height * 0.7016680);
    path_8.cubicTo(
        size.width * 0.03471289,
        size.height * 0.7050020,
        size.width * 0.03971289,
        size.height * 0.7100020,
        size.width * 0.03971289,
        size.height * 0.7166680);
    path_8.cubicTo(
        size.width * 0.03971289,
        size.height * 0.7266660,
        size.width * 0.03304688,
        size.height * 0.7333340,
        size.width * 0.02304688,
        size.height * 0.7333340);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.2013809, size.height * 0.7333340);
    path_9.lineTo(size.width * 0.1830469, size.height * 0.7333340);
    path_9.cubicTo(
        size.width * 0.1730469,
        size.height * 0.7333340,
        size.width * 0.1663809,
        size.height * 0.7266680,
        size.width * 0.1663809,
        size.height * 0.7166680);
    path_9.cubicTo(
        size.width * 0.1663809,
        size.height * 0.7066680,
        size.width * 0.1730469,
        size.height * 0.7000000,
        size.width * 0.1830469,
        size.height * 0.7000000);
    path_9.lineTo(size.width * 0.2013809, size.height * 0.7000000);
    path_9.cubicTo(
        size.width * 0.2113809,
        size.height * 0.7000000,
        size.width * 0.2180469,
        size.height * 0.7066660,
        size.width * 0.2180469,
        size.height * 0.7166660);
    path_9.cubicTo(
        size.width * 0.2180469,
        size.height * 0.7266660,
        size.width * 0.2113809,
        size.height * 0.7333340,
        size.width * 0.2013809,
        size.height * 0.7333340);
    path_9.close();
    path_9.moveTo(size.width * 0.1130469, size.height * 0.7333340);
    path_9.lineTo(size.width * 0.09471289, size.height * 0.7333340);
    path_9.cubicTo(
        size.width * 0.08471289,
        size.height * 0.7333340,
        size.width * 0.07804688,
        size.height * 0.7266680,
        size.width * 0.07804688,
        size.height * 0.7166680);
    path_9.cubicTo(
        size.width * 0.07804688,
        size.height * 0.7066680,
        size.width * 0.08471289,
        size.height * 0.7000020,
        size.width * 0.09471289,
        size.height * 0.7000020);
    path_9.lineTo(size.width * 0.1130469, size.height * 0.7000020);
    path_9.cubicTo(
        size.width * 0.1230469,
        size.height * 0.7000020,
        size.width * 0.1297129,
        size.height * 0.7066680,
        size.width * 0.1297129,
        size.height * 0.7166680);
    path_9.cubicTo(
        size.width * 0.1297129,
        size.height * 0.7266680,
        size.width * 0.1213809,
        size.height * 0.7333340,
        size.width * 0.1130469,
        size.height * 0.7333340);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.2813809, size.height * 0.7416660);
    path_10.cubicTo(
        size.width * 0.2747148,
        size.height * 0.7416660,
        size.width * 0.2680469,
        size.height * 0.7383320,
        size.width * 0.2663809,
        size.height * 0.7316660);
    path_10.cubicTo(
        size.width * 0.2613809,
        size.height * 0.7283320,
        size.width * 0.2563809,
        size.height * 0.7233320,
        size.width * 0.2563809,
        size.height * 0.7166660);
    path_10.cubicTo(
        size.width * 0.2563809,
        size.height * 0.7066660,
        size.width * 0.2630469,
        size.height * 0.7000000,
        size.width * 0.2730469,
        size.height * 0.7000000);
    path_10.lineTo(size.width * 0.2980469, size.height * 0.7000000);
    path_10.lineTo(size.width * 0.2980469, size.height * 0.7250000);
    path_10.cubicTo(
        size.width * 0.2980469,
        size.height * 0.7350000,
        size.width * 0.2913809,
        size.height * 0.7416660,
        size.width * 0.2813809,
        size.height * 0.7416660);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.2813809, size.height * 0.9200000);
    path_11.cubicTo(
        size.width * 0.2713809,
        size.height * 0.9200000,
        size.width * 0.2647148,
        size.height * 0.9133340,
        size.width * 0.2647148,
        size.height * 0.9033340);
    path_11.lineTo(size.width * 0.2647148, size.height * 0.8850000);
    path_11.cubicTo(
        size.width * 0.2647148,
        size.height * 0.8750000,
        size.width * 0.2713809,
        size.height * 0.8683340,
        size.width * 0.2813809,
        size.height * 0.8683340);
    path_11.cubicTo(
        size.width * 0.2913809,
        size.height * 0.8683340,
        size.width * 0.2980469,
        size.height * 0.8750000,
        size.width * 0.2980469,
        size.height * 0.8850000);
    path_11.lineTo(size.width * 0.2980469, size.height * 0.9033340);
    path_11.cubicTo(
        size.width * 0.2980469,
        size.height * 0.9133340,
        size.width * 0.2913809,
        size.height * 0.9200000,
        size.width * 0.2813809,
        size.height * 0.9200000);
    path_11.close();
    path_11.moveTo(size.width * 0.2813809, size.height * 0.8316660);
    path_11.cubicTo(
        size.width * 0.2713809,
        size.height * 0.8316660,
        size.width * 0.2647148,
        size.height * 0.8250000,
        size.width * 0.2647148,
        size.height * 0.8150000);
    path_11.lineTo(size.width * 0.2647148, size.height * 0.7966660);
    path_11.cubicTo(
        size.width * 0.2647148,
        size.height * 0.7866660,
        size.width * 0.2713809,
        size.height * 0.7800000,
        size.width * 0.2813809,
        size.height * 0.7800000);
    path_11.cubicTo(
        size.width * 0.2913809,
        size.height * 0.7800000,
        size.width * 0.2980469,
        size.height * 0.7866660,
        size.width * 0.2980469,
        size.height * 0.7966660);
    path_11.lineTo(size.width * 0.2980469, size.height * 0.8150000);
    path_11.cubicTo(
        size.width * 0.2980469,
        size.height * 0.8233340,
        size.width * 0.2913809,
        size.height * 0.8316660,
        size.width * 0.2813809,
        size.height * 0.8316660);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.2897129, size.height);
    path_12.lineTo(size.width * 0.2647129, size.height);
    path_12.lineTo(size.width * 0.2647129, size.height * 0.9750000);
    path_12.cubicTo(
        size.width * 0.2647129,
        size.height * 0.9650000,
        size.width * 0.2713789,
        size.height * 0.9583340,
        size.width * 0.2813789,
        size.height * 0.9583340);
    path_12.cubicTo(
        size.width * 0.2880449,
        size.height * 0.9583340,
        size.width * 0.2947129,
        size.height * 0.9616680,
        size.width * 0.2963789,
        size.height * 0.9683340);
    path_12.cubicTo(
        size.width * 0.3013789,
        size.height * 0.9716680,
        size.width * 0.3063789,
        size.height * 0.9766680,
        size.width * 0.3063789,
        size.height * 0.9833340);
    path_12.cubicTo(
        size.width * 0.3063809,
        size.height * 0.9933340,
        size.width * 0.2997129,
        size.height,
        size.width * 0.2897129,
        size.height);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.9030469, size.height);
    path_13.lineTo(size.width * 0.8847129, size.height);
    path_13.cubicTo(
        size.width * 0.8747129,
        size.height,
        size.width * 0.8680469,
        size.height * 0.9933340,
        size.width * 0.8680469,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.8680469,
        size.height * 0.9733340,
        size.width * 0.8747129,
        size.height * 0.9666680,
        size.width * 0.8847129,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.9030469, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.9130469,
        size.height * 0.9666680,
        size.width * 0.9197129,
        size.height * 0.9733340,
        size.width * 0.9197129,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.9197129,
        size.height * 0.9933340,
        size.width * 0.9113809,
        size.height,
        size.width * 0.9030469,
        size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.8147129, size.height);
    path_13.lineTo(size.width * 0.7980469, size.height);
    path_13.cubicTo(
        size.width * 0.7880469,
        size.height,
        size.width * 0.7813809,
        size.height * 0.9933340,
        size.width * 0.7813809,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.7813809,
        size.height * 0.9733340,
        size.width * 0.7880469,
        size.height * 0.9666680,
        size.width * 0.7980469,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.8147129, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.8247129,
        size.height * 0.9666680,
        size.width * 0.8313789,
        size.height * 0.9733340,
        size.width * 0.8313789,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.8313809,
        size.height * 0.9933340,
        size.width * 0.8247129,
        size.height,
        size.width * 0.8147129,
        size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.7280469, size.height);
    path_13.lineTo(size.width * 0.7097129, size.height);
    path_13.cubicTo(
        size.width * 0.6997129,
        size.height,
        size.width * 0.6930469,
        size.height * 0.9933340,
        size.width * 0.6930469,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.6930469,
        size.height * 0.9733340,
        size.width * 0.6997129,
        size.height * 0.9666680,
        size.width * 0.7097129,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.7280469, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.7380469,
        size.height * 0.9666680,
        size.width * 0.7447129,
        size.height * 0.9733340,
        size.width * 0.7447129,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.7447129,
        size.height * 0.9933340,
        size.width * 0.7363809,
        size.height,
        size.width * 0.7280469,
        size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.6397129, size.height);
    path_13.lineTo(size.width * 0.6213789, size.height);
    path_13.cubicTo(
        size.width * 0.6113789,
        size.height,
        size.width * 0.6047129,
        size.height * 0.9933340,
        size.width * 0.6047129,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.6047129,
        size.height * 0.9733340,
        size.width * 0.6113789,
        size.height * 0.9666680,
        size.width * 0.6213789,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.6397129, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.6497129,
        size.height * 0.9666680,
        size.width * 0.6563789,
        size.height * 0.9733340,
        size.width * 0.6563789,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.6563809,
        size.height * 0.9933340,
        size.width * 0.6497129,
        size.height,
        size.width * 0.6397129,
        size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.5530469, size.height);
    path_13.lineTo(size.width * 0.5347129, size.height);
    path_13.cubicTo(
        size.width * 0.5247129,
        size.height,
        size.width * 0.5180469,
        size.height * 0.9933340,
        size.width * 0.5180469,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.5180469,
        size.height * 0.9733340,
        size.width * 0.5247129,
        size.height * 0.9666680,
        size.width * 0.5347129,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.5530469, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.5630469,
        size.height * 0.9666680,
        size.width * 0.5697129,
        size.height * 0.9733340,
        size.width * 0.5697129,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.5697129,
        size.height * 0.9933340,
        size.width * 0.5613809,
        size.height,
        size.width * 0.5530469,
        size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.4647129, size.height);
    path_13.lineTo(size.width * 0.4480469, size.height);
    path_13.cubicTo(
        size.width * 0.4380469,
        size.height,
        size.width * 0.4313809,
        size.height * 0.9933340,
        size.width * 0.4313809,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.4313809,
        size.height * 0.9733340,
        size.width * 0.4380469,
        size.height * 0.9666680,
        size.width * 0.4480469,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.4647129, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.4747129,
        size.height * 0.9666680,
        size.width * 0.4813789,
        size.height * 0.9733340,
        size.width * 0.4813789,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.4813809,
        size.height * 0.9933340,
        size.width * 0.4747129,
        size.height,
        size.width * 0.4647129,
        size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.3780469, size.height);
    path_13.lineTo(size.width * 0.3597129, size.height);
    path_13.cubicTo(
        size.width * 0.3497129,
        size.height,
        size.width * 0.3430469,
        size.height * 0.9933340,
        size.width * 0.3430469,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.3430469,
        size.height * 0.9733340,
        size.width * 0.3497129,
        size.height * 0.9666680,
        size.width * 0.3597129,
        size.height * 0.9666680);
    path_13.lineTo(size.width * 0.3780469, size.height * 0.9666680);
    path_13.cubicTo(
        size.width * 0.3880469,
        size.height * 0.9666680,
        size.width * 0.3947129,
        size.height * 0.9733340,
        size.width * 0.3947129,
        size.height * 0.9833340);
    path_13.cubicTo(
        size.width * 0.3947129,
        size.height * 0.9933340,
        size.width * 0.3863809,
        size.height,
        size.width * 0.3780469,
        size.height);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.9980469, size.height);
    path_14.lineTo(size.width * 0.9730469, size.height);
    path_14.cubicTo(
        size.width * 0.9630469,
        size.height,
        size.width * 0.9563809,
        size.height * 0.9933340,
        size.width * 0.9563809,
        size.height * 0.9833340);
    path_14.cubicTo(
        size.width * 0.9563809,
        size.height * 0.9766680,
        size.width * 0.9597148,
        size.height * 0.9700000,
        size.width * 0.9663809,
        size.height * 0.9683340);
    path_14.cubicTo(
        size.width * 0.9697148,
        size.height * 0.9633340,
        size.width * 0.9747148,
        size.height * 0.9583340,
        size.width * 0.9813809,
        size.height * 0.9583340);
    path_14.cubicTo(
        size.width * 0.9913809,
        size.height * 0.9583340,
        size.width * 0.9980469,
        size.height * 0.9650000,
        size.width * 0.9980469,
        size.height * 0.9750000);
    path_14.lineTo(size.width * 0.9980469, size.height);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.9216660);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.9216660,
        size.width * 0.9647148,
        size.height * 0.9150000,
        size.width * 0.9647148,
        size.height * 0.9050000);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.8866660);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.8766660,
        size.width * 0.9713809,
        size.height * 0.8700000,
        size.width * 0.9813809,
        size.height * 0.8700000);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.8700000,
        size.width * 0.9980469,
        size.height * 0.8766660,
        size.width * 0.9980469,
        size.height * 0.8866660);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.9050000);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.9133340,
        size.width * 0.9913809,
        size.height * 0.9216660,
        size.width * 0.9813809,
        size.height * 0.9216660);
    path_15.close();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.8333340);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.8333340,
        size.width * 0.9647148,
        size.height * 0.8266680,
        size.width * 0.9647148,
        size.height * 0.8166680);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.8000000);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.7900000,
        size.width * 0.9713809,
        size.height * 0.7833340,
        size.width * 0.9813809,
        size.height * 0.7833340);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.7833340,
        size.width * 0.9980469,
        size.height * 0.7900000,
        size.width * 0.9980469,
        size.height * 0.8000000);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.8166660);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.8266660,
        size.width * 0.9913809,
        size.height * 0.8333340,
        size.width * 0.9813809,
        size.height * 0.8333340);
    path_15.close();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.7466660);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.7466660,
        size.width * 0.9647148,
        size.height * 0.7400000,
        size.width * 0.9647148,
        size.height * 0.7300000);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.7116660);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.7016660,
        size.width * 0.9713809,
        size.height * 0.6950000,
        size.width * 0.9813809,
        size.height * 0.6950000);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.6950000,
        size.width * 0.9980469,
        size.height * 0.7016660,
        size.width * 0.9980469,
        size.height * 0.7116660);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.7300000);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.7383340,
        size.width * 0.9913809,
        size.height * 0.7466660,
        size.width * 0.9813809,
        size.height * 0.7466660);
    path_15.close();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.6583340);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.6583340,
        size.width * 0.9647148,
        size.height * 0.6516680,
        size.width * 0.9647148,
        size.height * 0.6416680);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.6233340);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.6133340,
        size.width * 0.9713809,
        size.height * 0.6066680,
        size.width * 0.9813809,
        size.height * 0.6066680);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.6066680,
        size.width * 0.9980469,
        size.height * 0.6133340,
        size.width * 0.9980469,
        size.height * 0.6233340);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.6416680);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.6516660,
        size.width * 0.9913809,
        size.height * 0.6583340,
        size.width * 0.9813809,
        size.height * 0.6583340);
    path_15.close();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.5716660);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.5716660,
        size.width * 0.9647148,
        size.height * 0.5650000,
        size.width * 0.9647148,
        size.height * 0.5550000);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.5366660);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.5266660,
        size.width * 0.9713809,
        size.height * 0.5200000,
        size.width * 0.9813809,
        size.height * 0.5200000);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.5200000,
        size.width * 0.9980469,
        size.height * 0.5266660,
        size.width * 0.9980469,
        size.height * 0.5366660);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.5550000);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.5633340,
        size.width * 0.9913809,
        size.height * 0.5716660,
        size.width * 0.9813809,
        size.height * 0.5716660);
    path_15.close();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.4833340);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.4833340,
        size.width * 0.9647148,
        size.height * 0.4766680,
        size.width * 0.9647148,
        size.height * 0.4666680);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.4500000);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.4400000,
        size.width * 0.9713809,
        size.height * 0.4333340,
        size.width * 0.9813809,
        size.height * 0.4333340);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.4333340,
        size.width * 0.9980469,
        size.height * 0.4400000,
        size.width * 0.9980469,
        size.height * 0.4500000);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.4666660);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.4766660,
        size.width * 0.9913809,
        size.height * 0.4833340,
        size.width * 0.9813809,
        size.height * 0.4833340);
    path_15.close();
    path_15.moveTo(size.width * 0.9813809, size.height * 0.3966660);
    path_15.cubicTo(
        size.width * 0.9713809,
        size.height * 0.3966660,
        size.width * 0.9647148,
        size.height * 0.3900000,
        size.width * 0.9647148,
        size.height * 0.3800000);
    path_15.lineTo(size.width * 0.9647148, size.height * 0.3616660);
    path_15.cubicTo(
        size.width * 0.9647148,
        size.height * 0.3516660,
        size.width * 0.9713809,
        size.height * 0.3450000,
        size.width * 0.9813809,
        size.height * 0.3450000);
    path_15.cubicTo(
        size.width * 0.9913809,
        size.height * 0.3450000,
        size.width * 0.9980469,
        size.height * 0.3516660,
        size.width * 0.9980469,
        size.height * 0.3616660);
    path_15.lineTo(size.width * 0.9980469, size.height * 0.3800000);
    path_15.cubicTo(
        size.width * 0.9980469,
        size.height * 0.3883340,
        size.width * 0.9913809,
        size.height * 0.3966660,
        size.width * 0.9813809,
        size.height * 0.3966660);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.9813809, size.height * 0.3083340);
    path_16.cubicTo(
        size.width * 0.9747148,
        size.height * 0.3083340,
        size.width * 0.9680469,
        size.height * 0.3050000,
        size.width * 0.9663809,
        size.height * 0.2983340);
    path_16.cubicTo(
        size.width * 0.9613809,
        size.height * 0.2950000,
        size.width * 0.9563809,
        size.height * 0.2900000,
        size.width * 0.9563809,
        size.height * 0.2833340);
    path_16.cubicTo(
        size.width * 0.9563809,
        size.height * 0.2733340,
        size.width * 0.9630469,
        size.height * 0.2666680,
        size.width * 0.9730469,
        size.height * 0.2666680);
    path_16.lineTo(size.width * 0.9980469, size.height * 0.2666680);
    path_16.lineTo(size.width * 0.9980469, size.height * 0.2916680);
    path_16.cubicTo(
        size.width * 0.9980469,
        size.height * 0.3016660,
        size.width * 0.9913809,
        size.height * 0.3083340,
        size.width * 0.9813809,
        size.height * 0.3083340);
    path_16.close();

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.9013809, size.height * 0.3000000);
    path_17.lineTo(size.width * 0.8830469, size.height * 0.3000000);
    path_17.cubicTo(
        size.width * 0.8730469,
        size.height * 0.3000000,
        size.width * 0.8663809,
        size.height * 0.2933340,
        size.width * 0.8663809,
        size.height * 0.2833340);
    path_17.cubicTo(
        size.width * 0.8663809,
        size.height * 0.2733340,
        size.width * 0.8730469,
        size.height * 0.2666680,
        size.width * 0.8830469,
        size.height * 0.2666680);
    path_17.lineTo(size.width * 0.9013809, size.height * 0.2666680);
    path_17.cubicTo(
        size.width * 0.9113809,
        size.height * 0.2666680,
        size.width * 0.9180469,
        size.height * 0.2733340,
        size.width * 0.9180469,
        size.height * 0.2833340);
    path_17.cubicTo(
        size.width * 0.9180469,
        size.height * 0.2933340,
        size.width * 0.9113809,
        size.height * 0.3000000,
        size.width * 0.9013809,
        size.height * 0.3000000);
    path_17.close();
    path_17.moveTo(size.width * 0.8130469, size.height * 0.3000000);
    path_17.lineTo(size.width * 0.7947129, size.height * 0.3000000);
    path_17.cubicTo(
        size.width * 0.7847129,
        size.height * 0.3000000,
        size.width * 0.7780469,
        size.height * 0.2933340,
        size.width * 0.7780469,
        size.height * 0.2833340);
    path_17.cubicTo(
        size.width * 0.7780469,
        size.height * 0.2733340,
        size.width * 0.7847129,
        size.height * 0.2666680,
        size.width * 0.7947129,
        size.height * 0.2666680);
    path_17.lineTo(size.width * 0.8130469, size.height * 0.2666680);
    path_17.cubicTo(
        size.width * 0.8230469,
        size.height * 0.2666680,
        size.width * 0.8297129,
        size.height * 0.2733340,
        size.width * 0.8297129,
        size.height * 0.2833340);
    path_17.cubicTo(
        size.width * 0.8297129,
        size.height * 0.2933340,
        size.width * 0.8213809,
        size.height * 0.3000000,
        size.width * 0.8130469,
        size.height * 0.3000000);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.7313809, size.height * 0.7333340);
    path_18.lineTo(size.width * 0.2647129, size.height * 0.7333340);
    path_18.lineTo(size.width * 0.2647129, size.height * 0.2666660);
    path_18.lineTo(size.width * 0.7313789, size.height * 0.2666660);
    path_18.lineTo(size.width * 0.7313789, size.height * 0.7333340);
    path_18.close();
    path_18.moveTo(size.width * 0.2980469, size.height * 0.7000000);
    path_18.lineTo(size.width * 0.6980469, size.height * 0.7000000);
    path_18.lineTo(size.width * 0.6980469, size.height * 0.3000000);
    path_18.lineTo(size.width * 0.2980469, size.height * 0.3000000);
    path_18.lineTo(size.width * 0.2980469, size.height * 0.7000000);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_18, paint_18_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
