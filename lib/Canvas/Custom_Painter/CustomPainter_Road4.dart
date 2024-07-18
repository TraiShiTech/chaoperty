import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Road4 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Road4(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.7500000);
    path_0.cubicTo(
        size.width * 0.3616660,
        size.height * 0.7500000,
        size.width * 0.2500000,
        size.height * 0.6383340,
        size.width * 0.2500000,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.2500000,
        size.height * 0.3616660,
        size.width * 0.3616660,
        size.height * 0.2500000,
        size.width * 0.5000000,
        size.height * 0.2500000);
    path_0.cubicTo(
        size.width * 0.6383340,
        size.height * 0.2500000,
        size.width * 0.7500000,
        size.height * 0.3616660,
        size.width * 0.7500000,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.7500000,
        size.height * 0.6383340,
        size.width * 0.6383340,
        size.height * 0.7500000,
        size.width * 0.5000000,
        size.height * 0.7500000);
    path_0.moveTo(size.width * 0.5000000, size.height * 0.01666602);
    path_0.cubicTo(
        size.width * 0.2333340,
        size.height * 0.01666602,
        size.width * 0.01666602,
        size.height * 0.2333340,
        size.width * 0.01666602,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.01666602,
        size.height * 0.7666660,
        size.width * 0.2333340,
        size.height * 0.9833340,
        size.width * 0.5000000,
        size.height * 0.9833340);
    path_0.cubicTo(
        size.width * 0.7666660,
        size.height * 0.9833340,
        size.width * 0.9833340,
        size.height * 0.7666660,
        size.width * 0.9833340,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9833340,
        size.height * 0.2333340,
        size.width * 0.7666660,
        size.height * 0.01666602,
        size.width * 0.5000000,
        size.height * 0.01666602);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5000000, size.height * 0.01666602);
    path_1.cubicTo(
        size.width * 0.4916660,
        size.height * 0.01666602,
        size.width * 0.4833340,
        size.height * 0.01666602,
        size.width * 0.4750000,
        size.height * 0.01666602);
    path_1.cubicTo(
        size.width * 0.7300000,
        size.height * 0.03000000,
        size.width * 0.9333340,
        size.height * 0.2416660,
        size.width * 0.9333340,
        size.height * 0.5000000);
    path_1.cubicTo(
        size.width * 0.9333340,
        size.height * 0.7583340,
        size.width * 0.7300000,
        size.height * 0.9700000,
        size.width * 0.4750000,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.4833340,
        size.height * 0.9833340,
        size.width * 0.4916660,
        size.height * 0.9833340,
        size.width * 0.5000000,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.7666660,
        size.height * 0.9833340,
        size.width * 0.9833340,
        size.height * 0.7666680,
        size.width * 0.9833340,
        size.height * 0.5000000);
    path_1.cubicTo(
        size.width * 0.9833340,
        size.height * 0.2333320,
        size.width * 0.7666660,
        size.height * 0.01666602,
        size.width * 0.5000000,
        size.height * 0.01666602);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4916660, size.height * 0.01666602);
    path_2.cubicTo(
        size.width * 0.5000000,
        size.height * 0.01666602,
        size.width * 0.5083320,
        size.height * 0.01666602,
        size.width * 0.5166660,
        size.height * 0.01666602);
    path_2.cubicTo(
        size.width * 0.2616660,
        size.height * 0.03000000,
        size.width * 0.05833398,
        size.height * 0.2416660,
        size.width * 0.05833398,
        size.height * 0.5000000);
    path_2.cubicTo(
        size.width * 0.05833398,
        size.height * 0.7583340,
        size.width * 0.2616680,
        size.height * 0.9700000,
        size.width * 0.5166680,
        size.height * 0.9833340);
    path_2.cubicTo(
        size.width * 0.5083340,
        size.height * 0.9833340,
        size.width * 0.5000020,
        size.height * 0.9833340,
        size.width * 0.4916680,
        size.height * 0.9833340);
    path_2.cubicTo(
        size.width * 0.2250000,
        size.height * 0.9833340,
        size.width * 0.008333984,
        size.height * 0.7666660,
        size.width * 0.008333984,
        size.height * 0.5000000);
    path_2.cubicTo(
        size.width * 0.008333984,
        size.height * 0.2333340,
        size.width * 0.2250000,
        size.height * 0.01666602,
        size.width * 0.4916660,
        size.height * 0.01666602);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.5000000, size.height);
    path_3.cubicTo(size.width * 0.2250000, size.height, 0,
        size.height * 0.7750000, 0, size.height * 0.5000000);
    path_3.cubicTo(0, size.height * 0.2250000, size.width * 0.2250000, 0,
        size.width * 0.5000000, 0);
    path_3.cubicTo(size.width * 0.7750000, 0, size.width,
        size.height * 0.2250000, size.width, size.height * 0.5000000);
    path_3.cubicTo(size.width, size.height * 0.7750000, size.width * 0.7750000,
        size.height, size.width * 0.5000000, size.height);
    path_3.close();
    path_3.moveTo(size.width * 0.5000000, size.height * 0.03333398);
    path_3.cubicTo(
        size.width * 0.2433340,
        size.height * 0.03333398,
        size.width * 0.03333398,
        size.height * 0.2433340,
        size.width * 0.03333398,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.03333398,
        size.height * 0.7566660,
        size.width * 0.2433340,
        size.height * 0.9666660,
        size.width * 0.5000000,
        size.height * 0.9666660);
    path_3.cubicTo(
        size.width * 0.7566660,
        size.height * 0.9666660,
        size.width * 0.9666660,
        size.height * 0.7566660,
        size.width * 0.9666660,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.9666660,
        size.height * 0.2433340,
        size.width * 0.7566660,
        size.height * 0.03333398,
        size.width * 0.5000000,
        size.height * 0.03333398);
    path_3.close();
    path_3.moveTo(size.width * 0.5000000, size.height * 0.7666660);
    path_3.cubicTo(
        size.width * 0.3533340,
        size.height * 0.7666660,
        size.width * 0.2333340,
        size.height * 0.6466660,
        size.width * 0.2333340,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.2333340,
        size.height * 0.3533340,
        size.width * 0.3533340,
        size.height * 0.2333340,
        size.width * 0.5000000,
        size.height * 0.2333340);
    path_3.cubicTo(
        size.width * 0.6466660,
        size.height * 0.2333340,
        size.width * 0.7666660,
        size.height * 0.3533340,
        size.width * 0.7666660,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.7666660,
        size.height * 0.6466660,
        size.width * 0.6466660,
        size.height * 0.7666660,
        size.width * 0.5000000,
        size.height * 0.7666660);
    path_3.close();
    path_3.moveTo(size.width * 0.5000000, size.height * 0.2666660);
    path_3.cubicTo(
        size.width * 0.3716660,
        size.height * 0.2666660,
        size.width * 0.2666660,
        size.height * 0.3716660,
        size.width * 0.2666660,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.2666660,
        size.height * 0.6283340,
        size.width * 0.3716660,
        size.height * 0.7333340,
        size.width * 0.5000000,
        size.height * 0.7333340);
    path_3.cubicTo(
        size.width * 0.6283340,
        size.height * 0.7333340,
        size.width * 0.7333340,
        size.height * 0.6283340,
        size.width * 0.7333340,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.7333340,
        size.height * 0.3716660,
        size.width * 0.6283340,
        size.height * 0.2666660,
        size.width * 0.5000000,
        size.height * 0.2666660);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.5166660, size.height * 0.8833340);
    path_4.cubicTo(
        size.width * 0.5083320,
        size.height * 0.8833340,
        size.width * 0.5000000,
        size.height * 0.8766680,
        size.width * 0.5000000,
        size.height * 0.8666680);
    path_4.cubicTo(
        size.width * 0.5000000,
        size.height * 0.8566680,
        size.width * 0.5066660,
        size.height * 0.8500020,
        size.width * 0.5166660,
        size.height * 0.8500020);
    path_4.cubicTo(
        size.width * 0.5383320,
        size.height * 0.8483359,
        size.width * 0.5583320,
        size.height * 0.8466680,
        size.width * 0.5783320,
        size.height * 0.8416680);
    path_4.cubicTo(
        size.width * 0.5866660,
        size.height * 0.8400020,
        size.width * 0.5966660,
        size.height * 0.8450020,
        size.width * 0.5983320,
        size.height * 0.8550020);
    path_4.cubicTo(
        size.width * 0.5999980,
        size.height * 0.8633359,
        size.width * 0.5949980,
        size.height * 0.8733359,
        size.width * 0.5849980,
        size.height * 0.8750020);
    path_4.cubicTo(
        size.width * 0.5633340,
        size.height * 0.8783340,
        size.width * 0.5400000,
        size.height * 0.8816660,
        size.width * 0.5166660,
        size.height * 0.8833340);
    path_4.lineTo(size.width * 0.5166660, size.height * 0.8833340);
    path_4.close();
    path_4.moveTo(size.width * 0.4183340, size.height * 0.8750000);
    path_4.cubicTo(
        size.width * 0.4166680,
        size.height * 0.8750000,
        size.width * 0.4166680,
        size.height * 0.8750000,
        size.width * 0.4150000,
        size.height * 0.8750000);
    path_4.cubicTo(
        size.width * 0.3933340,
        size.height * 0.8700000,
        size.width * 0.3700000,
        size.height * 0.8633340,
        size.width * 0.3500000,
        size.height * 0.8533340);
    path_4.cubicTo(
        size.width * 0.3416660,
        size.height * 0.8500000,
        size.width * 0.3383340,
        size.height * 0.8400000,
        size.width * 0.3416660,
        size.height * 0.8316680);
    path_4.cubicTo(
        size.width * 0.3450000,
        size.height * 0.8233340,
        size.width * 0.3550000,
        size.height * 0.8200020,
        size.width * 0.3633320,
        size.height * 0.8233340);
    path_4.cubicTo(
        size.width * 0.3833320,
        size.height * 0.8316680,
        size.width * 0.4033320,
        size.height * 0.8383340,
        size.width * 0.4233320,
        size.height * 0.8433340);
    path_4.cubicTo(
        size.width * 0.4316660,
        size.height * 0.8450000,
        size.width * 0.4383320,
        size.height * 0.8550000,
        size.width * 0.4366660,
        size.height * 0.8633340);
    path_4.cubicTo(
        size.width * 0.4333340,
        size.height * 0.8683340,
        size.width * 0.4266660,
        size.height * 0.8750000,
        size.width * 0.4183340,
        size.height * 0.8750000);
    path_4.close();
    path_4.moveTo(size.width * 0.6733340, size.height * 0.8400000);
    path_4.cubicTo(
        size.width * 0.6666680,
        size.height * 0.8400000,
        size.width * 0.6616680,
        size.height * 0.8366660,
        size.width * 0.6583340,
        size.height * 0.8316660);
    path_4.cubicTo(
        size.width * 0.6533340,
        size.height * 0.8233320,
        size.width * 0.6566680,
        size.height * 0.8133320,
        size.width * 0.6650000,
        size.height * 0.8083320);
    path_4.cubicTo(
        size.width * 0.6833340,
        size.height * 0.7983320,
        size.width * 0.7016660,
        size.height * 0.7866660,
        size.width * 0.7166660,
        size.height * 0.7733320);
    path_4.cubicTo(
        size.width * 0.7233320,
        size.height * 0.7683320,
        size.width * 0.7350000,
        size.height * 0.7683320,
        size.width * 0.7400000,
        size.height * 0.7766660);
    path_4.cubicTo(
        size.width * 0.7450000,
        size.height * 0.7833320,
        size.width * 0.7450000,
        size.height * 0.7950000,
        size.width * 0.7366660,
        size.height * 0.8000000);
    path_4.cubicTo(
        size.width * 0.7183320,
        size.height * 0.8150000,
        size.width * 0.7000000,
        size.height * 0.8266660,
        size.width * 0.6800000,
        size.height * 0.8383340);
    path_4.cubicTo(
        size.width * 0.6800000,
        size.height * 0.8383340,
        size.width * 0.6766660,
        size.height * 0.8400000,
        size.width * 0.6733340,
        size.height * 0.8400000);
    path_4.close();
    path_4.moveTo(size.width * 0.2716660, size.height * 0.8033340);
    path_4.cubicTo(
        size.width * 0.2683320,
        size.height * 0.8033340,
        size.width * 0.2650000,
        size.height * 0.8016680,
        size.width * 0.2616660,
        size.height * 0.8000000);
    path_4.cubicTo(
        size.width * 0.2433320,
        size.height * 0.7850000,
        size.width * 0.2266660,
        size.height * 0.7700000,
        size.width * 0.2116660,
        size.height * 0.7533340);
    path_4.cubicTo(
        size.width * 0.2050000,
        size.height * 0.7466680,
        size.width * 0.2066660,
        size.height * 0.7366680,
        size.width * 0.2133320,
        size.height * 0.7300000);
    path_4.cubicTo(
        size.width * 0.2199980,
        size.height * 0.7233340,
        size.width * 0.2299980,
        size.height * 0.7250000,
        size.width * 0.2366660,
        size.height * 0.7316660);
    path_4.cubicTo(
        size.width * 0.2500000,
        size.height * 0.7466660,
        size.width * 0.2650000,
        size.height * 0.7616660,
        size.width * 0.2816660,
        size.height * 0.7750000);
    path_4.cubicTo(
        size.width * 0.2883320,
        size.height * 0.7800000,
        size.width * 0.2900000,
        size.height * 0.7916660,
        size.width * 0.2850000,
        size.height * 0.7983340);
    path_4.cubicTo(
        size.width * 0.2816660,
        size.height * 0.8016660,
        size.width * 0.2766660,
        size.height * 0.8033340,
        size.width * 0.2716660,
        size.height * 0.8033340);
    path_4.close();
    path_4.moveTo(size.width * 0.7966660, size.height * 0.7316660);
    path_4.cubicTo(
        size.width * 0.7933320,
        size.height * 0.7316660,
        size.width * 0.7900000,
        size.height * 0.7300000,
        size.width * 0.7866660,
        size.height * 0.7283320);
    path_4.cubicTo(
        size.width * 0.7800000,
        size.height * 0.7233320,
        size.width * 0.7783320,
        size.height * 0.7133320,
        size.width * 0.7833320,
        size.height * 0.7049980);
    path_4.cubicTo(
        size.width * 0.7949980,
        size.height * 0.6883320,
        size.width * 0.8066660,
        size.height * 0.6699980,
        size.width * 0.8149980,
        size.height * 0.6516641);
    path_4.cubicTo(
        size.width * 0.8183320,
        size.height * 0.6433301,
        size.width * 0.8283320,
        size.height * 0.6399980,
        size.width * 0.8366641,
        size.height * 0.6433301);
    path_4.cubicTo(
        size.width * 0.8449980,
        size.height * 0.6466641,
        size.width * 0.8483301,
        size.height * 0.6566641,
        size.width * 0.8449980,
        size.height * 0.6649961);
    path_4.cubicTo(
        size.width * 0.8349980,
        size.height * 0.6849961,
        size.width * 0.8233320,
        size.height * 0.7049961,
        size.width * 0.8099980,
        size.height * 0.7233301);
    path_4.cubicTo(
        size.width * 0.8066660,
        size.height * 0.7300000,
        size.width * 0.8016660,
        size.height * 0.7316660,
        size.width * 0.7966660,
        size.height * 0.7316660);
    path_4.close();
    path_4.moveTo(size.width * 0.1700000, size.height * 0.6766660);
    path_4.cubicTo(
        size.width * 0.1633340,
        size.height * 0.6766660,
        size.width * 0.1583340,
        size.height * 0.6733320,
        size.width * 0.1550000,
        size.height * 0.6666660);
    path_4.cubicTo(
        size.width * 0.1450000,
        size.height * 0.6466660,
        size.width * 0.1366660,
        size.height * 0.6250000,
        size.width * 0.1300000,
        size.height * 0.6016660);
    path_4.cubicTo(
        size.width * 0.1283340,
        size.height * 0.5933320,
        size.width * 0.1333340,
        size.height * 0.5833320,
        size.width * 0.1416660,
        size.height * 0.5816660);
    path_4.cubicTo(
        size.width * 0.1500000,
        size.height * 0.5800000,
        size.width * 0.1600000,
        size.height * 0.5850000,
        size.width * 0.1616660,
        size.height * 0.5933320);
    path_4.cubicTo(
        size.width * 0.1666660,
        size.height * 0.6133320,
        size.width * 0.1750000,
        size.height * 0.6333320,
        size.width * 0.1833320,
        size.height * 0.6516660);
    path_4.cubicTo(
        size.width * 0.1866660,
        size.height * 0.6600000,
        size.width * 0.1833320,
        size.height * 0.6700000,
        size.width * 0.1749980,
        size.height * 0.6733320);
    path_4.cubicTo(
        size.width * 0.1750000,
        size.height * 0.6750000,
        size.width * 0.1716660,
        size.height * 0.6766660,
        size.width * 0.1700000,
        size.height * 0.6766660);
    path_4.close();
    path_4.moveTo(size.width * 0.8616660, size.height * 0.5816660);
    path_4.cubicTo(
        size.width * 0.8600000,
        size.height * 0.5816660,
        size.width * 0.8600000,
        size.height * 0.5816660,
        size.width * 0.8583320,
        size.height * 0.5816660);
    path_4.cubicTo(
        size.width * 0.8499980,
        size.height * 0.5800000,
        size.width * 0.8433320,
        size.height * 0.5716660,
        size.width * 0.8449980,
        size.height * 0.5616660);
    path_4.cubicTo(
        size.width * 0.8483320,
        size.height * 0.5416660,
        size.width * 0.8499980,
        size.height * 0.5200000,
        size.width * 0.8499980,
        size.height * 0.5000000);
    path_4.cubicTo(
        size.width * 0.8499980,
        size.height * 0.4900000,
        size.width * 0.8566641,
        size.height * 0.4833340,
        size.width * 0.8666641,
        size.height * 0.4833340);
    path_4.cubicTo(
        size.width * 0.8766641,
        size.height * 0.4833340,
        size.width * 0.8833301,
        size.height * 0.4900000,
        size.width * 0.8833301,
        size.height * 0.5000000);
    path_4.lineTo(size.width * 0.8833301, size.height * 0.5000000);
    path_4.cubicTo(
        size.width * 0.8833301,
        size.height * 0.5233340,
        size.width * 0.8816641,
        size.height * 0.5466660,
        size.width * 0.8766641,
        size.height * 0.5683340);
    path_4.cubicTo(
        size.width * 0.8750000,
        size.height * 0.5766660,
        size.width * 0.8683340,
        size.height * 0.5816660,
        size.width * 0.8616660,
        size.height * 0.5816660);
    path_4.close();
    path_4.moveTo(size.width * 0.1333340, size.height * 0.5166660);
    path_4.cubicTo(
        size.width * 0.1233340,
        size.height * 0.5166660,
        size.width * 0.1166680,
        size.height * 0.5100000,
        size.width * 0.1166680,
        size.height * 0.5000000);
    path_4.lineTo(size.width * 0.1333340, size.height * 0.5000000);
    path_4.lineTo(size.width * 0.1166680, size.height * 0.5000000);
    path_4.cubicTo(
        size.width * 0.1166680,
        size.height * 0.4766660,
        size.width * 0.1183340,
        size.height * 0.4533340,
        size.width * 0.1233340,
        size.height * 0.4316660);
    path_4.cubicTo(
        size.width * 0.1250000,
        size.height * 0.4233320,
        size.width * 0.1333340,
        size.height * 0.4166660,
        size.width * 0.1416680,
        size.height * 0.4183320);
    path_4.cubicTo(
        size.width * 0.1500020,
        size.height * 0.4199980,
        size.width * 0.1566680,
        size.height * 0.4283320,
        size.width * 0.1550020,
        size.height * 0.4383320);
    path_4.cubicTo(
        size.width * 0.1516660,
        size.height * 0.4583340,
        size.width * 0.1500000,
        size.height * 0.4800000,
        size.width * 0.1500000,
        size.height * 0.5000000);
    path_4.cubicTo(
        size.width * 0.1500000,
        size.height * 0.5100000,
        size.width * 0.1433340,
        size.height * 0.5166660,
        size.width * 0.1333340,
        size.height * 0.5166660);
    path_4.close();
    path_4.moveTo(size.width * 0.8533340, size.height * 0.4183340);
    path_4.cubicTo(
        size.width * 0.8466680,
        size.height * 0.4183340,
        size.width * 0.8400000,
        size.height * 0.4133340,
        size.width * 0.8366680,
        size.height * 0.4066680);
    path_4.cubicTo(
        size.width * 0.8316680,
        size.height * 0.3866680,
        size.width * 0.8233340,
        size.height * 0.3666680,
        size.width * 0.8150020,
        size.height * 0.3483340);
    path_4.cubicTo(
        size.width * 0.8116680,
        size.height * 0.3400000,
        size.width * 0.8150020,
        size.height * 0.3300000,
        size.width * 0.8233359,
        size.height * 0.3266680);
    path_4.cubicTo(
        size.width * 0.8316699,
        size.height * 0.3233359,
        size.width * 0.8416699,
        size.height * 0.3266680,
        size.width * 0.8450020,
        size.height * 0.3350020);
    path_4.cubicTo(
        size.width * 0.8550020,
        size.height * 0.3550020,
        size.width * 0.8633359,
        size.height * 0.3766680,
        size.width * 0.8700020,
        size.height * 0.4000020);
    path_4.cubicTo(
        size.width * 0.8716680,
        size.height * 0.4083359,
        size.width * 0.8666680,
        size.height * 0.4183359,
        size.width * 0.8583359,
        size.height * 0.4200020);
    path_4.cubicTo(
        size.width * 0.8566660,
        size.height * 0.4183340,
        size.width * 0.8550000,
        size.height * 0.4183340,
        size.width * 0.8533340,
        size.height * 0.4183340);
    path_4.close();
    path_4.moveTo(size.width * 0.1700000, size.height * 0.3583340);
    path_4.cubicTo(
        size.width * 0.1683340,
        size.height * 0.3583340,
        size.width * 0.1650000,
        size.height * 0.3583340,
        size.width * 0.1633340,
        size.height * 0.3566680);
    path_4.cubicTo(
        size.width * 0.1550000,
        size.height * 0.3533340,
        size.width * 0.1516680,
        size.height * 0.3433340,
        size.width * 0.1550000,
        size.height * 0.3350020);
    path_4.cubicTo(
        size.width * 0.1650000,
        size.height * 0.3150020,
        size.width * 0.1766660,
        size.height * 0.2950020,
        size.width * 0.1900000,
        size.height * 0.2766680);
    path_4.cubicTo(
        size.width * 0.1950000,
        size.height * 0.2700020,
        size.width * 0.2050000,
        size.height * 0.2683340,
        size.width * 0.2133340,
        size.height * 0.2733340);
    path_4.cubicTo(
        size.width * 0.2200000,
        size.height * 0.2783340,
        size.width * 0.2216680,
        size.height * 0.2883340,
        size.width * 0.2166680,
        size.height * 0.2966680);
    path_4.cubicTo(
        size.width * 0.2050020,
        size.height * 0.3133340,
        size.width * 0.1933340,
        size.height * 0.3316680,
        size.width * 0.1850020,
        size.height * 0.3500020);
    path_4.cubicTo(
        size.width * 0.1816660,
        size.height * 0.3550000,
        size.width * 0.1750000,
        size.height * 0.3583340,
        size.width * 0.1700000,
        size.height * 0.3583340);
    path_4.close();
    path_4.moveTo(size.width * 0.7750000, size.height * 0.2750000);
    path_4.cubicTo(
        size.width * 0.7700000,
        size.height * 0.2750000,
        size.width * 0.7650000,
        size.height * 0.2733340,
        size.width * 0.7616660,
        size.height * 0.2700000);
    path_4.cubicTo(
        size.width * 0.7483320,
        size.height * 0.2550000,
        size.width * 0.7333320,
        size.height * 0.2400000,
        size.width * 0.7166660,
        size.height * 0.2266660);
    path_4.cubicTo(
        size.width * 0.7100000,
        size.height * 0.2216660,
        size.width * 0.7083320,
        size.height * 0.2100000,
        size.width * 0.7133320,
        size.height * 0.2033320);
    path_4.cubicTo(
        size.width * 0.7183320,
        size.height * 0.1966641,
        size.width * 0.7299980,
        size.height * 0.1949980,
        size.width * 0.7366660,
        size.height * 0.1999980);
    path_4.cubicTo(
        size.width * 0.7550000,
        size.height * 0.2149980,
        size.width * 0.7716660,
        size.height * 0.2299980,
        size.width * 0.7866660,
        size.height * 0.2466641);
    path_4.cubicTo(
        size.width * 0.7933320,
        size.height * 0.2533301,
        size.width * 0.7916660,
        size.height * 0.2633301,
        size.width * 0.7850000,
        size.height * 0.2699980);
    path_4.cubicTo(
        size.width * 0.7833340,
        size.height * 0.2733340,
        size.width * 0.7800000,
        size.height * 0.2750000,
        size.width * 0.7750000,
        size.height * 0.2750000);
    path_4.close();
    path_4.moveTo(size.width * 0.2700000, size.height * 0.2300000);
    path_4.cubicTo(
        size.width * 0.2650000,
        size.height * 0.2300000,
        size.width * 0.2600000,
        size.height * 0.2283340,
        size.width * 0.2566660,
        size.height * 0.2233340);
    path_4.cubicTo(
        size.width * 0.2516660,
        size.height * 0.2166680,
        size.width * 0.2516660,
        size.height * 0.2050000,
        size.width * 0.2600000,
        size.height * 0.2000000);
    path_4.cubicTo(
        size.width * 0.2783340,
        size.height * 0.1850000,
        size.width * 0.2966660,
        size.height * 0.1733340,
        size.width * 0.3166660,
        size.height * 0.1616660);
    path_4.cubicTo(
        size.width * 0.3250000,
        size.height * 0.1566660,
        size.width * 0.3350000,
        size.height * 0.1600000,
        size.width * 0.3400000,
        size.height * 0.1683320);
    path_4.cubicTo(
        size.width * 0.3450000,
        size.height * 0.1766660,
        size.width * 0.3416660,
        size.height * 0.1866660,
        size.width * 0.3333340,
        size.height * 0.1916660);
    path_4.cubicTo(
        size.width * 0.3150000,
        size.height * 0.2016660,
        size.width * 0.2966680,
        size.height * 0.2133320,
        size.width * 0.2816680,
        size.height * 0.2266660);
    path_4.cubicTo(
        size.width * 0.2783340,
        size.height * 0.2300000,
        size.width * 0.2750000,
        size.height * 0.2300000,
        size.width * 0.2700000,
        size.height * 0.2300000);
    path_4.close();
    path_4.moveTo(size.width * 0.6433340, size.height * 0.1783340);
    path_4.cubicTo(
        size.width * 0.6416680,
        size.height * 0.1783340,
        size.width * 0.6383340,
        size.height * 0.1783340,
        size.width * 0.6366680,
        size.height * 0.1766680);
    path_4.cubicTo(
        size.width * 0.6166680,
        size.height * 0.1683340,
        size.width * 0.5966680,
        size.height * 0.1616680,
        size.width * 0.5766680,
        size.height * 0.1566680);
    path_4.cubicTo(
        size.width * 0.5683340,
        size.height * 0.1550020,
        size.width * 0.5616680,
        size.height * 0.1450020,
        size.width * 0.5633340,
        size.height * 0.1366680);
    path_4.cubicTo(
        size.width * 0.5666680,
        size.height * 0.1300020,
        size.width * 0.5750000,
        size.height * 0.1233340,
        size.width * 0.5833340,
        size.height * 0.1266680);
    path_4.cubicTo(
        size.width * 0.6050000,
        size.height * 0.1316680,
        size.width * 0.6283340,
        size.height * 0.1383340,
        size.width * 0.6483340,
        size.height * 0.1483340);
    path_4.cubicTo(
        size.width * 0.6566680,
        size.height * 0.1516680,
        size.width * 0.6600000,
        size.height * 0.1616680,
        size.width * 0.6566680,
        size.height * 0.1700000);
    path_4.cubicTo(
        size.width * 0.6550000,
        size.height * 0.1750000,
        size.width * 0.6500000,
        size.height * 0.1783340,
        size.width * 0.6433340,
        size.height * 0.1783340);
    path_4.close();
    path_4.moveTo(size.width * 0.4166660, size.height * 0.1600000);
    path_4.cubicTo(
        size.width * 0.4083320,
        size.height * 0.1600000,
        size.width * 0.4016660,
        size.height * 0.1550000,
        size.width * 0.4000000,
        size.height * 0.1466660);
    path_4.cubicTo(
        size.width * 0.3983340,
        size.height * 0.1383320,
        size.width * 0.4033340,
        size.height * 0.1283320,
        size.width * 0.4133340,
        size.height * 0.1266660);
    path_4.cubicTo(
        size.width * 0.4350000,
        size.height * 0.1216660,
        size.width * 0.4583340,
        size.height * 0.1183320,
        size.width * 0.4816680,
        size.height * 0.1166660);
    path_4.cubicTo(
        size.width * 0.4900020,
        size.height * 0.1166660,
        size.width * 0.4983340,
        size.height * 0.1233320,
        size.width * 0.4983340,
        size.height * 0.1333320);
    path_4.cubicTo(
        size.width * 0.4983340,
        size.height * 0.1433320,
        size.width * 0.4916680,
        size.height * 0.1499980,
        size.width * 0.4816680,
        size.height * 0.1499980);
    path_4.cubicTo(
        size.width * 0.4600020,
        size.height * 0.1516641,
        size.width * 0.4400020,
        size.height * 0.1533320,
        size.width * 0.4200020,
        size.height * 0.1583320);
    path_4.cubicTo(
        size.width * 0.4200000,
        size.height * 0.1600000,
        size.width * 0.4183340,
        size.height * 0.1600000,
        size.width * 0.4166660,
        size.height * 0.1600000);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
