import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop5 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop5(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2416660);
    path_0.cubicTo(
        0,
        size.height * 0.2316660,
        size.width * 0.006666016,
        size.height * 0.2250000,
        size.width * 0.01666602,
        size.height * 0.2250000);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.2250000,
        size.width * 0.03333203,
        size.height * 0.2316660,
        size.width * 0.03333203,
        size.height * 0.2416660);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.2516660,
        size.width * 0.02499805,
        size.height * 0.2583320,
        size.width * 0.01666602,
        size.height * 0.2583320);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.2583320, 0,
        size.height * 0.2500000, 0, size.height * 0.2416660);
    path_0.moveTo(0, size.height * 0.3083340);
    path_0.cubicTo(
        0,
        size.height * 0.2983340,
        size.width * 0.006666016,
        size.height * 0.2916680,
        size.width * 0.01666602,
        size.height * 0.2916680);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.2916680,
        size.width * 0.03333203,
        size.height * 0.2983340,
        size.width * 0.03333203,
        size.height * 0.3083340);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.3183340,
        size.width * 0.02499805,
        size.height * 0.3250000,
        size.width * 0.01666602,
        size.height * 0.3250000);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.3250000, 0,
        size.height * 0.3166660, 0, size.height * 0.3083340);
    path_0.moveTo(0, size.height * 0.3750000);
    path_0.cubicTo(
        0,
        size.height * 0.3650000,
        size.width * 0.006666016,
        size.height * 0.3583340,
        size.width * 0.01666602,
        size.height * 0.3583340);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.3583340,
        size.width * 0.03333203,
        size.height * 0.3650000,
        size.width * 0.03333203,
        size.height * 0.3750000);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.3850000,
        size.width * 0.02499805,
        size.height * 0.3916660,
        size.width * 0.01666602,
        size.height * 0.3916660);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.3916660, 0,
        size.height * 0.3833340, 0, size.height * 0.3750000);
    path_0.moveTo(0, size.height * 0.4416660);
    path_0.cubicTo(
        0,
        size.height * 0.4333320,
        size.width * 0.006666016,
        size.height * 0.4250000,
        size.width * 0.01666602,
        size.height * 0.4250000);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.4250000,
        size.width * 0.03333203,
        size.height * 0.4333340,
        size.width * 0.03333203,
        size.height * 0.4416660);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.4516660,
        size.width * 0.02499805,
        size.height * 0.4583320,
        size.width * 0.01666602,
        size.height * 0.4583320);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.4583320, 0,
        size.height * 0.4500000, 0, size.height * 0.4416660);
    path_0.moveTo(0, size.height * 0.5083340);
    path_0.cubicTo(
        0,
        size.height * 0.5000000,
        size.width * 0.006666016,
        size.height * 0.4916680,
        size.width * 0.01666602,
        size.height * 0.4916680);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.4916680,
        size.width * 0.03333203,
        size.height * 0.5000020,
        size.width * 0.03333203,
        size.height * 0.5083340);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.5183340,
        size.width * 0.02499805,
        size.height * 0.5250000,
        size.width * 0.01666602,
        size.height * 0.5250000);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.5250000, 0,
        size.height * 0.5166660, 0, size.height * 0.5083340);
    path_0.moveTo(0, size.height * 0.5750000);
    path_0.cubicTo(
        0,
        size.height * 0.5666660,
        size.width * 0.006666016,
        size.height * 0.5583340,
        size.width * 0.01666602,
        size.height * 0.5583340);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.5583340,
        size.width * 0.03333203,
        size.height * 0.5666680,
        size.width * 0.03333203,
        size.height * 0.5750000);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.5850000,
        size.width * 0.02499805,
        size.height * 0.5916660,
        size.width * 0.01666602,
        size.height * 0.5916660);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.5916660, 0,
        size.height * 0.5833340, 0, size.height * 0.5750000);
    path_0.moveTo(0, size.height * 0.6416660);
    path_0.cubicTo(
        0,
        size.height * 0.6333340,
        size.width * 0.006666016,
        size.height * 0.6250000,
        size.width * 0.01666602,
        size.height * 0.6250000);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.6250000,
        size.width * 0.03333203,
        size.height * 0.6333340,
        size.width * 0.03333203,
        size.height * 0.6416660);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.6516660,
        size.width * 0.02499805,
        size.height * 0.6583320,
        size.width * 0.01666602,
        size.height * 0.6583320);
    path_0.cubicTo(size.width * 0.008333984, size.height * 0.6583320, 0,
        size.height * 0.6500000, 0, size.height * 0.6416660);
    path_0.moveTo(0, size.height * 0.7083340);
    path_0.cubicTo(
        0,
        size.height * 0.7000000,
        size.width * 0.006666016,
        size.height * 0.6916680,
        size.width * 0.01666602,
        size.height * 0.6916680);
    path_0.cubicTo(
        size.width * 0.02666602,
        size.height * 0.6916680,
        size.width * 0.03333203,
        size.height * 0.7000020,
        size.width * 0.03333203,
        size.height * 0.7083340);
    path_0.cubicTo(
        size.width * 0.03333203,
        size.height * 0.7166660,
        size.width * 0.02500000,
        size.height * 0.7250000,
        size.width * 0.01666602,
        size.height * 0.7250000);
    path_0.cubicTo(size.width * 0.008332031, size.height * 0.7250000, 0,
        size.height * 0.7166660, 0, size.height * 0.7083340);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.01666602, size.height * 0.1916660);
    path_1.cubicTo(
        size.width * 0.01166602,
        size.height * 0.1916660,
        size.width * 0.008332031,
        size.height * 0.1900000,
        size.width * 0.005000000,
        size.height * 0.1866660);
    path_1.cubicTo(size.width * 0.001666016, size.height * 0.1833340, 0,
        size.height * 0.1800000, 0, size.height * 0.1750000);
    path_1.cubicTo(
        0,
        size.height * 0.1700000,
        size.width * 0.001666016,
        size.height * 0.1666660,
        size.width * 0.005000000,
        size.height * 0.1633340);
    path_1.cubicTo(
        size.width * 0.01166602,
        size.height * 0.1566680,
        size.width * 0.02333398,
        size.height * 0.1566680,
        size.width * 0.02833398,
        size.height * 0.1633340);
    path_1.cubicTo(
        size.width * 0.03166797,
        size.height * 0.1666680,
        size.width * 0.03333398,
        size.height * 0.1700000,
        size.width * 0.03333398,
        size.height * 0.1750000);
    path_1.cubicTo(
        size.width * 0.03333398,
        size.height * 0.1800000,
        size.width * 0.03166797,
        size.height * 0.1833340,
        size.width * 0.02833398,
        size.height * 0.1866660);
    path_1.cubicTo(
        size.width * 0.02500000,
        size.height * 0.1900000,
        size.width * 0.02166602,
        size.height * 0.1916660,
        size.width * 0.01666602,
        size.height * 0.1916660);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.06500000, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.06500000,
        size.height * 0.1666660,
        size.width * 0.07166602,
        size.height * 0.1583340,
        size.width * 0.08166602,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.09166602,
        size.height * 0.1583340,
        size.width * 0.09833203,
        size.height * 0.1650000,
        size.width * 0.09833203,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.09833203,
        size.height * 0.1850000,
        size.width * 0.09166602,
        size.height * 0.1916660,
        size.width * 0.08166602,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.07166602,
        size.height * 0.1916660,
        size.width * 0.06500000,
        size.height * 0.1833340,
        size.width * 0.06500000,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.1283340, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.1283340,
        size.height * 0.1666660,
        size.width * 0.1350000,
        size.height * 0.1583340,
        size.width * 0.1450000,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.1550000,
        size.height * 0.1583340,
        size.width * 0.1616660,
        size.height * 0.1650000,
        size.width * 0.1616660,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.1616660,
        size.height * 0.1850000,
        size.width * 0.1550000,
        size.height * 0.1916660,
        size.width * 0.1450000,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.1366660,
        size.height * 0.1916660,
        size.width * 0.1283340,
        size.height * 0.1833340,
        size.width * 0.1283340,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.1933340, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.1933340,
        size.height * 0.1666660,
        size.width * 0.2000000,
        size.height * 0.1583340,
        size.width * 0.2100000,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.2200000,
        size.height * 0.1583340,
        size.width * 0.2266660,
        size.height * 0.1650000,
        size.width * 0.2266660,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.2266660,
        size.height * 0.1850000,
        size.width * 0.2200000,
        size.height * 0.1916660,
        size.width * 0.2100000,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.2000000,
        size.height * 0.1916660,
        size.width * 0.1933340,
        size.height * 0.1833340,
        size.width * 0.1933340,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.2583340, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.2583340,
        size.height * 0.1666660,
        size.width * 0.2650000,
        size.height * 0.1583340,
        size.width * 0.2750000,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.2833340,
        size.height * 0.1583340,
        size.width * 0.2916660,
        size.height * 0.1650000,
        size.width * 0.2916660,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.2916660,
        size.height * 0.1850000,
        size.width * 0.2833320,
        size.height * 0.1916660,
        size.width * 0.2750000,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.2650000,
        size.height * 0.1916660,
        size.width * 0.2583340,
        size.height * 0.1833340,
        size.width * 0.2583340,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.3216660, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.3216660,
        size.height * 0.1666660,
        size.width * 0.3300000,
        size.height * 0.1583340,
        size.width * 0.3383320,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.3483320,
        size.height * 0.1583340,
        size.width * 0.3549980,
        size.height * 0.1650000,
        size.width * 0.3549980,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.3549980,
        size.height * 0.1850000,
        size.width * 0.3483320,
        size.height * 0.1916660,
        size.width * 0.3383320,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.3300000,
        size.height * 0.1916660,
        size.width * 0.3216660,
        size.height * 0.1833340,
        size.width * 0.3216660,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.3866660, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.3866660,
        size.height * 0.1666660,
        size.width * 0.3933320,
        size.height * 0.1583340,
        size.width * 0.4033320,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.4116660,
        size.height * 0.1583340,
        size.width * 0.4199980,
        size.height * 0.1650000,
        size.width * 0.4199980,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.4199980,
        size.height * 0.1850000,
        size.width * 0.4116641,
        size.height * 0.1916660,
        size.width * 0.4033320,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.3933340,
        size.height * 0.1916660,
        size.width * 0.3866660,
        size.height * 0.1833340,
        size.width * 0.3866660,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.4516660, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.4516660,
        size.height * 0.1666660,
        size.width * 0.4583320,
        size.height * 0.1583340,
        size.width * 0.4683320,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.4783320,
        size.height * 0.1583340,
        size.width * 0.4849980,
        size.height * 0.1650000,
        size.width * 0.4849980,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.4849980,
        size.height * 0.1850000,
        size.width * 0.4783320,
        size.height * 0.1916660,
        size.width * 0.4683320,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.4583320,
        size.height * 0.1916660,
        size.width * 0.4516660,
        size.height * 0.1833340,
        size.width * 0.4516660,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.5150000, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.5150000,
        size.height * 0.1666660,
        size.width * 0.5233340,
        size.height * 0.1583340,
        size.width * 0.5316660,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.5416660,
        size.height * 0.1583340,
        size.width * 0.5483320,
        size.height * 0.1650000,
        size.width * 0.5483320,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.5483320,
        size.height * 0.1850000,
        size.width * 0.5416660,
        size.height * 0.1916660,
        size.width * 0.5316660,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.5233340,
        size.height * 0.1916660,
        size.width * 0.5150000,
        size.height * 0.1833340,
        size.width * 0.5150000,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.5800000, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.5800000,
        size.height * 0.1666660,
        size.width * 0.5883340,
        size.height * 0.1583340,
        size.width * 0.5966660,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.6066660,
        size.height * 0.1583340,
        size.width * 0.6133320,
        size.height * 0.1650000,
        size.width * 0.6133320,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.6133320,
        size.height * 0.1850000,
        size.width * 0.6066660,
        size.height * 0.1916660,
        size.width * 0.5966660,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.5866660,
        size.height * 0.1916660,
        size.width * 0.5800000,
        size.height * 0.1833340,
        size.width * 0.5800000,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.6450000, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.6450000,
        size.height * 0.1666660,
        size.width * 0.6516660,
        size.height * 0.1583340,
        size.width * 0.6616660,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.6700000,
        size.height * 0.1583340,
        size.width * 0.6783320,
        size.height * 0.1650000,
        size.width * 0.6783320,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.6783320,
        size.height * 0.1850000,
        size.width * 0.6699980,
        size.height * 0.1916660,
        size.width * 0.6616660,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.6516660,
        size.height * 0.1916660,
        size.width * 0.6450000,
        size.height * 0.1833340,
        size.width * 0.6450000,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.7083340, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.7083340,
        size.height * 0.1666660,
        size.width * 0.7166680,
        size.height * 0.1583340,
        size.width * 0.7250000,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.7350000,
        size.height * 0.1583340,
        size.width * 0.7416660,
        size.height * 0.1650000,
        size.width * 0.7416660,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.7416660,
        size.height * 0.1850000,
        size.width * 0.7350000,
        size.height * 0.1916660,
        size.width * 0.7250000,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.7166660,
        size.height * 0.1916660,
        size.width * 0.7083340,
        size.height * 0.1833340,
        size.width * 0.7083340,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.7733340, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.7733340,
        size.height * 0.1666660,
        size.width * 0.7816680,
        size.height * 0.1583340,
        size.width * 0.7900000,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.8000000,
        size.height * 0.1583340,
        size.width * 0.8066660,
        size.height * 0.1650000,
        size.width * 0.8066660,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.8066660,
        size.height * 0.1850000,
        size.width * 0.8000000,
        size.height * 0.1916660,
        size.width * 0.7900000,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.7800000,
        size.height * 0.1916660,
        size.width * 0.7733340,
        size.height * 0.1833340,
        size.width * 0.7733340,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.8383340, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.8383340,
        size.height * 0.1666660,
        size.width * 0.8450000,
        size.height * 0.1583340,
        size.width * 0.8550000,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.8633340,
        size.height * 0.1583340,
        size.width * 0.8716660,
        size.height * 0.1650000,
        size.width * 0.8716660,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.8716660,
        size.height * 0.1850000,
        size.width * 0.8633320,
        size.height * 0.1916660,
        size.width * 0.8550000,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.8450000,
        size.height * 0.1916660,
        size.width * 0.8383340,
        size.height * 0.1833340,
        size.width * 0.8383340,
        size.height * 0.1750000);
    path_2.moveTo(size.width * 0.9016660, size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.9016660,
        size.height * 0.1666660,
        size.width * 0.9100000,
        size.height * 0.1583340,
        size.width * 0.9183320,
        size.height * 0.1583340);
    path_2.cubicTo(
        size.width * 0.9283320,
        size.height * 0.1583340,
        size.width * 0.9349980,
        size.height * 0.1650000,
        size.width * 0.9349980,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.9349980,
        size.height * 0.1850000,
        size.width * 0.9283320,
        size.height * 0.1916660,
        size.width * 0.9183320,
        size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.9100000,
        size.height * 0.1916660,
        size.width * 0.9016660,
        size.height * 0.1833340,
        size.width * 0.9016660,
        size.height * 0.1750000);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9833340, size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.9783340,
        size.height * 0.1916660,
        size.width * 0.9750000,
        size.height * 0.1900000,
        size.width * 0.9716680,
        size.height * 0.1866660);
    path_3.cubicTo(
        size.width * 0.9683340,
        size.height * 0.1833320,
        size.width * 0.9666680,
        size.height * 0.1800000,
        size.width * 0.9666680,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.9666680,
        size.height * 0.1700000,
        size.width * 0.9683340,
        size.height * 0.1666660,
        size.width * 0.9716680,
        size.height * 0.1633340);
    path_3.cubicTo(
        size.width * 0.9783340,
        size.height * 0.1566680,
        size.width * 0.9883340,
        size.height * 0.1566680,
        size.width * 0.9950020,
        size.height * 0.1633340);
    path_3.cubicTo(
        size.width * 0.9983359,
        size.height * 0.1666680,
        size.width * 1.000002,
        size.height * 0.1700000,
        size.width * 1.000002,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 1.000002,
        size.height * 0.1800000,
        size.width * 0.9983359,
        size.height * 0.1833340,
        size.width * 0.9950020,
        size.height * 0.1866660);
    path_3.cubicTo(
        size.width * 0.9916660,
        size.height * 0.1900000,
        size.width * 0.9883340,
        size.height * 0.1916660,
        size.width * 0.9833340,
        size.height * 0.1916660);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.9666660, size.height * 0.2416660);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.2316660,
        size.width * 0.9750000,
        size.height * 0.2250000,
        size.width * 0.9833320,
        size.height * 0.2250000);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.2250000,
        size.width * 0.9999980,
        size.height * 0.2316660,
        size.width * 0.9999980,
        size.height * 0.2416660);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.2516660,
        size.width * 0.9916641,
        size.height * 0.2583320,
        size.width * 0.9833320,
        size.height * 0.2583320);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.2583340,
        size.width * 0.9666660,
        size.height * 0.2500000,
        size.width * 0.9666660,
        size.height * 0.2416660);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.3083340);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.2983340,
        size.width * 0.9750000,
        size.height * 0.2916680,
        size.width * 0.9833320,
        size.height * 0.2916680);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.2916680,
        size.width * 0.9999980,
        size.height * 0.2983340,
        size.width * 0.9999980,
        size.height * 0.3083340);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.3183340,
        size.width * 0.9916641,
        size.height * 0.3250000,
        size.width * 0.9833320,
        size.height * 0.3250000);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.3250000,
        size.width * 0.9666660,
        size.height * 0.3166660,
        size.width * 0.9666660,
        size.height * 0.3083340);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.3750000);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.3650000,
        size.width * 0.9750000,
        size.height * 0.3583340,
        size.width * 0.9833320,
        size.height * 0.3583340);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.3583340,
        size.width * 0.9999980,
        size.height * 0.3650000,
        size.width * 0.9999980,
        size.height * 0.3750000);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.3850000,
        size.width * 0.9916641,
        size.height * 0.3916660,
        size.width * 0.9833320,
        size.height * 0.3916660);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.3916660,
        size.width * 0.9666660,
        size.height * 0.3833340,
        size.width * 0.9666660,
        size.height * 0.3750000);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.4416660);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.4333320,
        size.width * 0.9750000,
        size.height * 0.4250000,
        size.width * 0.9833320,
        size.height * 0.4250000);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.4250000,
        size.width * 0.9999980,
        size.height * 0.4333340,
        size.width * 0.9999980,
        size.height * 0.4416660);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.4516660,
        size.width * 0.9916641,
        size.height * 0.4583320,
        size.width * 0.9833320,
        size.height * 0.4583320);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.4583340,
        size.width * 0.9666660,
        size.height * 0.4500000,
        size.width * 0.9666660,
        size.height * 0.4416660);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.5083340);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.5000000,
        size.width * 0.9750000,
        size.height * 0.4916680,
        size.width * 0.9833320,
        size.height * 0.4916680);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.4916680,
        size.width * 0.9999980,
        size.height * 0.5000020,
        size.width * 0.9999980,
        size.height * 0.5083340);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.5183340,
        size.width * 0.9916641,
        size.height * 0.5250000,
        size.width * 0.9833320,
        size.height * 0.5250000);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.5250000,
        size.width * 0.9666660,
        size.height * 0.5166660,
        size.width * 0.9666660,
        size.height * 0.5083340);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.5750000);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.5666660,
        size.width * 0.9750000,
        size.height * 0.5583340,
        size.width * 0.9833320,
        size.height * 0.5583340);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.5583340,
        size.width * 0.9999980,
        size.height * 0.5666680,
        size.width * 0.9999980,
        size.height * 0.5750000);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.5850000,
        size.width * 0.9916641,
        size.height * 0.5916660,
        size.width * 0.9833320,
        size.height * 0.5916660);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.5916660,
        size.width * 0.9666660,
        size.height * 0.5833340,
        size.width * 0.9666660,
        size.height * 0.5750000);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.6416660);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.6333320,
        size.width * 0.9750000,
        size.height * 0.6250000,
        size.width * 0.9833320,
        size.height * 0.6250000);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.6250000,
        size.width * 0.9999980,
        size.height * 0.6333340,
        size.width * 0.9999980,
        size.height * 0.6416660);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.6516660,
        size.width * 0.9916641,
        size.height * 0.6583320,
        size.width * 0.9833320,
        size.height * 0.6583320);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.6583340,
        size.width * 0.9666660,
        size.height * 0.6500000,
        size.width * 0.9666660,
        size.height * 0.6416660);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.7083340);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.7000000,
        size.width * 0.9750000,
        size.height * 0.6916680,
        size.width * 0.9833320,
        size.height * 0.6916680);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.6916680,
        size.width * 0.9999980,
        size.height * 0.7000020,
        size.width * 0.9999980,
        size.height * 0.7083340);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.7166660,
        size.width * 0.9916641,
        size.height * 0.7250000,
        size.width * 0.9833320,
        size.height * 0.7250000);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.7250000,
        size.width * 0.9666660,
        size.height * 0.7166660,
        size.width * 0.9666660,
        size.height * 0.7083340);
    path_4.moveTo(size.width * 0.9666660, size.height * 0.7750000);
    path_4.cubicTo(
        size.width * 0.9666660,
        size.height * 0.7666660,
        size.width * 0.9750000,
        size.height * 0.7583340,
        size.width * 0.9833320,
        size.height * 0.7583340);
    path_4.cubicTo(
        size.width * 0.9916660,
        size.height * 0.7583340,
        size.width * 0.9999980,
        size.height * 0.7666680,
        size.width * 0.9999980,
        size.height * 0.7750000);
    path_4.cubicTo(
        size.width * 0.9999980,
        size.height * 0.7833320,
        size.width * 0.9916641,
        size.height * 0.7916660,
        size.width * 0.9833320,
        size.height * 0.7916660);
    path_4.cubicTo(
        size.width * 0.9750000,
        size.height * 0.7916660,
        size.width * 0.9666660,
        size.height * 0.7833340,
        size.width * 0.9666660,
        size.height * 0.7750000);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.9833340, size.height * 0.8583340);
    path_5.cubicTo(
        size.width * 0.9783340,
        size.height * 0.8583340,
        size.width * 0.9750000,
        size.height * 0.8566680,
        size.width * 0.9716680,
        size.height * 0.8533340);
    path_5.cubicTo(
        size.width * 0.9683340,
        size.height * 0.8500000,
        size.width * 0.9666680,
        size.height * 0.8466680,
        size.width * 0.9666680,
        size.height * 0.8416680);
    path_5.cubicTo(
        size.width * 0.9666680,
        size.height * 0.8366680,
        size.width * 0.9683340,
        size.height * 0.8333340,
        size.width * 0.9716680,
        size.height * 0.8300020);
    path_5.cubicTo(
        size.width * 0.9783340,
        size.height * 0.8233359,
        size.width * 0.9883340,
        size.height * 0.8233359,
        size.width * 0.9950020,
        size.height * 0.8300020);
    path_5.cubicTo(
        size.width * 0.9983359,
        size.height * 0.8333359,
        size.width * 1.000002,
        size.height * 0.8383359,
        size.width * 1.000002,
        size.height * 0.8416680);
    path_5.cubicTo(
        size.width * 1.000002,
        size.height * 0.8466680,
        size.width * 0.9983359,
        size.height * 0.8500020,
        size.width * 0.9950020,
        size.height * 0.8533340);
    path_5.cubicTo(
        size.width * 0.9916660,
        size.height * 0.8566660,
        size.width * 0.9883340,
        size.height * 0.8583340,
        size.width * 0.9833340,
        size.height * 0.8583340);

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.3216660, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.3216660,
        size.height * 0.8333320,
        size.width * 0.3300000,
        size.height * 0.8250000,
        size.width * 0.3383320,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.3483320,
        size.height * 0.8250000,
        size.width * 0.3549980,
        size.height * 0.8333340,
        size.width * 0.3549980,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.3549980,
        size.height * 0.8499980,
        size.width * 0.3483320,
        size.height * 0.8583320,
        size.width * 0.3383320,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.3300000,
        size.height * 0.8583340,
        size.width * 0.3216660,
        size.height * 0.8500000,
        size.width * 0.3216660,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.3866660, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.3866660,
        size.height * 0.8333320,
        size.width * 0.3933320,
        size.height * 0.8250000,
        size.width * 0.4033320,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.4116660,
        size.height * 0.8250000,
        size.width * 0.4199980,
        size.height * 0.8333340,
        size.width * 0.4199980,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.4199980,
        size.height * 0.8499980,
        size.width * 0.4116641,
        size.height * 0.8583320,
        size.width * 0.4033320,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.3933340,
        size.height * 0.8583340,
        size.width * 0.3866660,
        size.height * 0.8500000,
        size.width * 0.3866660,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.4516660, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.4516660,
        size.height * 0.8333320,
        size.width * 0.4583320,
        size.height * 0.8250000,
        size.width * 0.4683320,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.4783320,
        size.height * 0.8250000,
        size.width * 0.4849980,
        size.height * 0.8333340,
        size.width * 0.4849980,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.4849980,
        size.height * 0.8499980,
        size.width * 0.4783320,
        size.height * 0.8583320,
        size.width * 0.4683320,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.4583320,
        size.height * 0.8583320,
        size.width * 0.4516660,
        size.height * 0.8500000,
        size.width * 0.4516660,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.5150000, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.5150000,
        size.height * 0.8333320,
        size.width * 0.5233340,
        size.height * 0.8250000,
        size.width * 0.5316660,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.5416660,
        size.height * 0.8250000,
        size.width * 0.5483320,
        size.height * 0.8333340,
        size.width * 0.5483320,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.5483320,
        size.height * 0.8499980,
        size.width * 0.5416660,
        size.height * 0.8583320,
        size.width * 0.5316660,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.5233340,
        size.height * 0.8583340,
        size.width * 0.5150000,
        size.height * 0.8500000,
        size.width * 0.5150000,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.5800000, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.5800000,
        size.height * 0.8333320,
        size.width * 0.5883340,
        size.height * 0.8250000,
        size.width * 0.5966660,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.6066660,
        size.height * 0.8250000,
        size.width * 0.6133320,
        size.height * 0.8333340,
        size.width * 0.6133320,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.6133320,
        size.height * 0.8499980,
        size.width * 0.6066660,
        size.height * 0.8583320,
        size.width * 0.5966660,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.5866660,
        size.height * 0.8583320,
        size.width * 0.5800000,
        size.height * 0.8500000,
        size.width * 0.5800000,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.6450000, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.6450000,
        size.height * 0.8333320,
        size.width * 0.6516660,
        size.height * 0.8250000,
        size.width * 0.6616660,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.6700000,
        size.height * 0.8250000,
        size.width * 0.6783320,
        size.height * 0.8333340,
        size.width * 0.6783320,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.6783320,
        size.height * 0.8499980,
        size.width * 0.6699980,
        size.height * 0.8583320,
        size.width * 0.6616660,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.6516660,
        size.height * 0.8583340,
        size.width * 0.6450000,
        size.height * 0.8500000,
        size.width * 0.6450000,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.7083340, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.7083340,
        size.height * 0.8333320,
        size.width * 0.7166680,
        size.height * 0.8250000,
        size.width * 0.7250000,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.7350000,
        size.height * 0.8250000,
        size.width * 0.7416660,
        size.height * 0.8333340,
        size.width * 0.7416660,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.7416660,
        size.height * 0.8499980,
        size.width * 0.7350000,
        size.height * 0.8583320,
        size.width * 0.7250000,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.7166660,
        size.height * 0.8583340,
        size.width * 0.7083340,
        size.height * 0.8500000,
        size.width * 0.7083340,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.7733340, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.7733340,
        size.height * 0.8333320,
        size.width * 0.7816680,
        size.height * 0.8250000,
        size.width * 0.7900000,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.8000000,
        size.height * 0.8250000,
        size.width * 0.8066660,
        size.height * 0.8333340,
        size.width * 0.8066660,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.8066660,
        size.height * 0.8499980,
        size.width * 0.8000000,
        size.height * 0.8583320,
        size.width * 0.7900000,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.7800000,
        size.height * 0.8583340,
        size.width * 0.7733340,
        size.height * 0.8500000,
        size.width * 0.7733340,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.8383340, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.8383340,
        size.height * 0.8333320,
        size.width * 0.8450000,
        size.height * 0.8250000,
        size.width * 0.8550000,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.8633340,
        size.height * 0.8250000,
        size.width * 0.8716660,
        size.height * 0.8333340,
        size.width * 0.8716660,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.8716660,
        size.height * 0.8499980,
        size.width * 0.8633320,
        size.height * 0.8583320,
        size.width * 0.8550000,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.8450000,
        size.height * 0.8583340,
        size.width * 0.8383340,
        size.height * 0.8500000,
        size.width * 0.8383340,
        size.height * 0.8416660);
    path_6.moveTo(size.width * 0.9016660, size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.9016660,
        size.height * 0.8333320,
        size.width * 0.9100000,
        size.height * 0.8250000,
        size.width * 0.9183320,
        size.height * 0.8250000);
    path_6.cubicTo(
        size.width * 0.9283320,
        size.height * 0.8250000,
        size.width * 0.9349980,
        size.height * 0.8333340,
        size.width * 0.9349980,
        size.height * 0.8416660);
    path_6.cubicTo(
        size.width * 0.9349980,
        size.height * 0.8499980,
        size.width * 0.9283320,
        size.height * 0.8583320,
        size.width * 0.9183320,
        size.height * 0.8583320);
    path_6.cubicTo(
        size.width * 0.9100000,
        size.height * 0.8583340,
        size.width * 0.9016660,
        size.height * 0.8500000,
        size.width * 0.9016660,
        size.height * 0.8416660);

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.01666602, size.height * 0.8250000);
    path_7.lineTo(size.width * 0.3333340, size.height * 0.8250000);
    path_7.lineTo(size.width * 0.3333340, size.height * 0.1583340);
    path_7.lineTo(size.width * 0.01666602, size.height * 0.1583340);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.3500000, size.height * 0.8416660);
    path_8.lineTo(0, size.height * 0.8416660);
    path_8.lineTo(0, size.height * 0.1416660);
    path_8.lineTo(size.width * 0.3500000, size.height * 0.1416660);
    path_8.lineTo(size.width * 0.3500000, size.height * 0.8416660);
    path_8.close();
    path_8.moveTo(size.width * 0.03333398, size.height * 0.8083340);
    path_8.lineTo(size.width * 0.3166680, size.height * 0.8083340);
    path_8.lineTo(size.width * 0.3166680, size.height * 0.1750000);
    path_8.lineTo(size.width * 0.03333398, size.height * 0.1750000);
    path_8.lineTo(size.width * 0.03333398, size.height * 0.8083340);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(0, size.height * 0.7583340);
    path_9.cubicTo(
        0,
        size.height * 0.7500000,
        size.width * 0.006666016,
        size.height * 0.7416680,
        size.width * 0.01666602,
        size.height * 0.7416680);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.7416680);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.7416680,
        size.width * 0.03333203,
        size.height * 0.7500020,
        size.width * 0.03333203,
        size.height * 0.7583340);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.7583340);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.7666680,
        size.width * 0.02499805,
        size.height * 0.7750000,
        size.width * 0.01666602,
        size.height * 0.7750000);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.7750000);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.7750000, 0,
        size.height * 0.7666660, 0, size.height * 0.7583340);
    path_9.close();
    path_9.moveTo(0, size.height * 0.6916660);
    path_9.cubicTo(
        0,
        size.height * 0.6833320,
        size.width * 0.006666016,
        size.height * 0.6750000,
        size.width * 0.01666602,
        size.height * 0.6750000);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.6750000);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.6750000,
        size.width * 0.03333203,
        size.height * 0.6833340,
        size.width * 0.03333203,
        size.height * 0.6916660);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.6916660);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.7000000,
        size.width * 0.02499805,
        size.height * 0.7083320,
        size.width * 0.01666602,
        size.height * 0.7083320);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.7083320);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.7083340, 0,
        size.height * 0.7000000, 0, size.height * 0.6916660);
    path_9.close();
    path_9.moveTo(0, size.height * 0.6250000);
    path_9.cubicTo(
        0,
        size.height * 0.6166660,
        size.width * 0.006666016,
        size.height * 0.6083340,
        size.width * 0.01666602,
        size.height * 0.6083340);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.6083340);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.6083340,
        size.width * 0.03333203,
        size.height * 0.6166680,
        size.width * 0.03333203,
        size.height * 0.6250000);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.6250000);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.6333340,
        size.width * 0.02499805,
        size.height * 0.6416660,
        size.width * 0.01666602,
        size.height * 0.6416660);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.6416660);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.6416660, 0,
        size.height * 0.6333340, 0, size.height * 0.6250000);
    path_9.close();
    path_9.moveTo(0, size.height * 0.5583340);
    path_9.cubicTo(
        0,
        size.height * 0.5500000,
        size.width * 0.006666016,
        size.height * 0.5416680,
        size.width * 0.01666602,
        size.height * 0.5416680);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.5416680);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.5416680,
        size.width * 0.03333203,
        size.height * 0.5500020,
        size.width * 0.03333203,
        size.height * 0.5583340);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.5583340);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.5666680,
        size.width * 0.02499805,
        size.height * 0.5750000,
        size.width * 0.01666602,
        size.height * 0.5750000);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.5750000);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.5750000, 0,
        size.height * 0.5666660, 0, size.height * 0.5583340);
    path_9.close();
    path_9.moveTo(0, size.height * 0.4916660);
    path_9.cubicTo(
        0,
        size.height * 0.4816660,
        size.width * 0.006666016,
        size.height * 0.4750000,
        size.width * 0.01666602,
        size.height * 0.4750000);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.4750000);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.4750000,
        size.width * 0.03333203,
        size.height * 0.4816660,
        size.width * 0.03333203,
        size.height * 0.4916660);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.4916660);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.5000000,
        size.width * 0.02499805,
        size.height * 0.5083320,
        size.width * 0.01666602,
        size.height * 0.5083320);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.5083320);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.5083340, 0,
        size.height * 0.5000000, 0, size.height * 0.4916660);
    path_9.close();
    path_9.moveTo(0, size.height * 0.4250000);
    path_9.cubicTo(
        0,
        size.height * 0.4150000,
        size.width * 0.006666016,
        size.height * 0.4083340,
        size.width * 0.01666602,
        size.height * 0.4083340);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.4083340);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.4083340,
        size.width * 0.03333203,
        size.height * 0.4150000,
        size.width * 0.03333203,
        size.height * 0.4250000);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.4250000);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.4333340,
        size.width * 0.02499805,
        size.height * 0.4416660,
        size.width * 0.01666602,
        size.height * 0.4416660);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.4416660);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.4416660, 0,
        size.height * 0.4333340, 0, size.height * 0.4250000);
    path_9.close();
    path_9.moveTo(0, size.height * 0.3583340);
    path_9.cubicTo(
        0,
        size.height * 0.3483340,
        size.width * 0.006666016,
        size.height * 0.3416680,
        size.width * 0.01666602,
        size.height * 0.3416680);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.3416680);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.3416680,
        size.width * 0.03333203,
        size.height * 0.3483340,
        size.width * 0.03333203,
        size.height * 0.3583340);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.3583340);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.3666680,
        size.width * 0.02499805,
        size.height * 0.3750000,
        size.width * 0.01666602,
        size.height * 0.3750000);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.3750000);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.3750000, 0,
        size.height * 0.3666660, 0, size.height * 0.3583340);
    path_9.close();
    path_9.moveTo(0, size.height * 0.2916660);
    path_9.cubicTo(
        0,
        size.height * 0.2816660,
        size.width * 0.006666016,
        size.height * 0.2750000,
        size.width * 0.01666602,
        size.height * 0.2750000);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.2750000);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.2750000,
        size.width * 0.03333203,
        size.height * 0.2816660,
        size.width * 0.03333203,
        size.height * 0.2916660);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.2916660);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.3000000,
        size.width * 0.02499805,
        size.height * 0.3083320,
        size.width * 0.01666602,
        size.height * 0.3083320);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.3083320);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.3083340, 0,
        size.height * 0.3000000, 0, size.height * 0.2916660);
    path_9.close();
    path_9.moveTo(0, size.height * 0.2250000);
    path_9.cubicTo(
        0,
        size.height * 0.2150000,
        size.width * 0.006666016,
        size.height * 0.2083340,
        size.width * 0.01666602,
        size.height * 0.2083340);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.2083340);
    path_9.cubicTo(
        size.width * 0.02500000,
        size.height * 0.2083340,
        size.width * 0.03333203,
        size.height * 0.2150000,
        size.width * 0.03333203,
        size.height * 0.2250000);
    path_9.lineTo(size.width * 0.03333203, size.height * 0.2250000);
    path_9.cubicTo(
        size.width * 0.03333203,
        size.height * 0.2333340,
        size.width * 0.02499805,
        size.height * 0.2416660,
        size.width * 0.01666602,
        size.height * 0.2416660);
    path_9.lineTo(size.width * 0.01666602, size.height * 0.2416660);
    path_9.cubicTo(size.width * 0.006666016, size.height * 0.2416660, 0,
        size.height * 0.2333340, 0, size.height * 0.2250000);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.9016660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.9016660,
        size.height * 0.1483340,
        size.width * 0.9083320,
        size.height * 0.1416680,
        size.width * 0.9183320,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.9183320, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.9266660,
        size.height * 0.1416680,
        size.width * 0.9349980,
        size.height * 0.1483340,
        size.width * 0.9349980,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.9349980, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.9349980,
        size.height * 0.1666680,
        size.width * 0.9266641,
        size.height * 0.1750000,
        size.width * 0.9183320,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.9183320, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.9100000,
        size.height * 0.1750000,
        size.width * 0.9016660,
        size.height * 0.1666660,
        size.width * 0.9016660,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.8383340, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.8383340,
        size.height * 0.1483340,
        size.width * 0.8466680,
        size.height * 0.1416680,
        size.width * 0.8550000,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.8550000, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.8633340,
        size.height * 0.1416680,
        size.width * 0.8716660,
        size.height * 0.1483340,
        size.width * 0.8716660,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.8716660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.8716660,
        size.height * 0.1666680,
        size.width * 0.8633320,
        size.height * 0.1750000,
        size.width * 0.8550000,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.8550000, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.8450000,
        size.height * 0.1750000,
        size.width * 0.8383340,
        size.height * 0.1666660,
        size.width * 0.8383340,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.7733340, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.7733340,
        size.height * 0.1483340,
        size.width * 0.7816680,
        size.height * 0.1416680,
        size.width * 0.7900000,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.7900000, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.8000000,
        size.height * 0.1416680,
        size.width * 0.8066660,
        size.height * 0.1483340,
        size.width * 0.8066660,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.8066660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.8066660,
        size.height * 0.1666680,
        size.width * 0.8000000,
        size.height * 0.1750000,
        size.width * 0.7900000,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.7900000, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.7800000,
        size.height * 0.1750000,
        size.width * 0.7733340,
        size.height * 0.1666660,
        size.width * 0.7733340,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.7083340, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.7083340,
        size.height * 0.1483340,
        size.width * 0.7150000,
        size.height * 0.1416680,
        size.width * 0.7250000,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.7250000, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.7333340,
        size.height * 0.1416680,
        size.width * 0.7416660,
        size.height * 0.1483340,
        size.width * 0.7416660,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.7416660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.7416660,
        size.height * 0.1666680,
        size.width * 0.7333320,
        size.height * 0.1750000,
        size.width * 0.7250000,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.7250000, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.7166660,
        size.height * 0.1750000,
        size.width * 0.7083340,
        size.height * 0.1666660,
        size.width * 0.7083340,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.6450000, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.6450000,
        size.height * 0.1483340,
        size.width * 0.6533340,
        size.height * 0.1416680,
        size.width * 0.6616660,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.6616660, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.6700000,
        size.height * 0.1416680,
        size.width * 0.6783320,
        size.height * 0.1483340,
        size.width * 0.6783320,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.6783320, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.6783320,
        size.height * 0.1666680,
        size.width * 0.6699980,
        size.height * 0.1750000,
        size.width * 0.6616660,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.6616660, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.6516660,
        size.height * 0.1750000,
        size.width * 0.6450000,
        size.height * 0.1666660,
        size.width * 0.6450000,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.5800000, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.5800000,
        size.height * 0.1483340,
        size.width * 0.5883340,
        size.height * 0.1416680,
        size.width * 0.5966660,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.5966660, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.6050000,
        size.height * 0.1416680,
        size.width * 0.6133320,
        size.height * 0.1483340,
        size.width * 0.6133320,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.6133320, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.6133320,
        size.height * 0.1666680,
        size.width * 0.6049980,
        size.height * 0.1750000,
        size.width * 0.5966660,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.5966660, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.5866660,
        size.height * 0.1750000,
        size.width * 0.5800000,
        size.height * 0.1666660,
        size.width * 0.5800000,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.5150000, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.5150000,
        size.height * 0.1483340,
        size.width * 0.5216660,
        size.height * 0.1416680,
        size.width * 0.5316660,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.5316660, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.5416660,
        size.height * 0.1416680,
        size.width * 0.5483320,
        size.height * 0.1483340,
        size.width * 0.5483320,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.5483320, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.5483320,
        size.height * 0.1666680,
        size.width * 0.5416660,
        size.height * 0.1750000,
        size.width * 0.5316660,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.5316660, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.5233340,
        size.height * 0.1750000,
        size.width * 0.5150000,
        size.height * 0.1666660,
        size.width * 0.5150000,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.4516660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.4516660,
        size.height * 0.1483340,
        size.width * 0.4600000,
        size.height * 0.1416680,
        size.width * 0.4683320,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.4683320, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.4766660,
        size.height * 0.1416680,
        size.width * 0.4849980,
        size.height * 0.1483340,
        size.width * 0.4849980,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.4849980, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.4849980,
        size.height * 0.1666680,
        size.width * 0.4766641,
        size.height * 0.1750000,
        size.width * 0.4683320,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.4683320, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.4583340,
        size.height * 0.1750000,
        size.width * 0.4516660,
        size.height * 0.1666660,
        size.width * 0.4516660,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.3866660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.3866660,
        size.height * 0.1483340,
        size.width * 0.3950000,
        size.height * 0.1416680,
        size.width * 0.4033320,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.4033320, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.4133320,
        size.height * 0.1416680,
        size.width * 0.4199980,
        size.height * 0.1483340,
        size.width * 0.4199980,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.4199980, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.4199980,
        size.height * 0.1666680,
        size.width * 0.4133320,
        size.height * 0.1750000,
        size.width * 0.4033320,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.4033320, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.3933340,
        size.height * 0.1750000,
        size.width * 0.3866660,
        size.height * 0.1666660,
        size.width * 0.3866660,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.3216660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.3216660,
        size.height * 0.1483340,
        size.width * 0.3300000,
        size.height * 0.1416680,
        size.width * 0.3383320,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.3383320, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.3483320,
        size.height * 0.1416680,
        size.width * 0.3549980,
        size.height * 0.1483340,
        size.width * 0.3549980,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.3549980, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.3549980,
        size.height * 0.1666680,
        size.width * 0.3466641,
        size.height * 0.1750000,
        size.width * 0.3383320,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.3383320, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.3300000,
        size.height * 0.1750000,
        size.width * 0.3216660,
        size.height * 0.1666660,
        size.width * 0.3216660,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.2583340, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.2583340,
        size.height * 0.1483340,
        size.width * 0.2666680,
        size.height * 0.1416680,
        size.width * 0.2750000,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.2750000, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.2850000,
        size.height * 0.1416680,
        size.width * 0.2916660,
        size.height * 0.1483340,
        size.width * 0.2916660,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.2916660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.2916660,
        size.height * 0.1666680,
        size.width * 0.2850000,
        size.height * 0.1750000,
        size.width * 0.2750000,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.2750000, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.2650000,
        size.height * 0.1750000,
        size.width * 0.2583340,
        size.height * 0.1666660,
        size.width * 0.2583340,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.1933340, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.1933340,
        size.height * 0.1483340,
        size.width * 0.2016680,
        size.height * 0.1416680,
        size.width * 0.2100000,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.2100000, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.2200000,
        size.height * 0.1416680,
        size.width * 0.2266660,
        size.height * 0.1483340,
        size.width * 0.2266660,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.2266660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.2266660,
        size.height * 0.1666680,
        size.width * 0.2200000,
        size.height * 0.1750000,
        size.width * 0.2100000,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.2100000, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.2000000,
        size.height * 0.1750000,
        size.width * 0.1933340,
        size.height * 0.1666660,
        size.width * 0.1933340,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.1283340, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.1283340,
        size.height * 0.1483340,
        size.width * 0.1350000,
        size.height * 0.1416680,
        size.width * 0.1450000,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.1450000, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.1550000,
        size.height * 0.1416680,
        size.width * 0.1616660,
        size.height * 0.1483340,
        size.width * 0.1616660,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.1616660, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.1616660,
        size.height * 0.1666680,
        size.width * 0.1550000,
        size.height * 0.1750000,
        size.width * 0.1450000,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.1450000, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.1366660,
        size.height * 0.1750000,
        size.width * 0.1283340,
        size.height * 0.1666660,
        size.width * 0.1283340,
        size.height * 0.1583340);
    path_10.close();
    path_10.moveTo(size.width * 0.06500000, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.06500000,
        size.height * 0.1483340,
        size.width * 0.07166602,
        size.height * 0.1416680,
        size.width * 0.08166602,
        size.height * 0.1416680);
    path_10.lineTo(size.width * 0.08166602, size.height * 0.1416680);
    path_10.cubicTo(
        size.width * 0.09166602,
        size.height * 0.1416680,
        size.width * 0.09833203,
        size.height * 0.1483340,
        size.width * 0.09833203,
        size.height * 0.1583340);
    path_10.lineTo(size.width * 0.09833203, size.height * 0.1583340);
    path_10.cubicTo(
        size.width * 0.09833203,
        size.height * 0.1666680,
        size.width * 0.09166602,
        size.height * 0.1750000,
        size.width * 0.08166602,
        size.height * 0.1750000);
    path_10.lineTo(size.width * 0.08166602, size.height * 0.1750000);
    path_10.cubicTo(
        size.width * 0.07166602,
        size.height * 0.1750000,
        size.width * 0.06500000,
        size.height * 0.1666660,
        size.width * 0.06500000,
        size.height * 0.1583340);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.7583340);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.7500000,
        size.width * 0.9750000,
        size.height * 0.7416680,
        size.width * 0.9833320,
        size.height * 0.7416680);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.7416680);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.7416680,
        size.width * 0.9999980,
        size.height * 0.7500020,
        size.width * 0.9999980,
        size.height * 0.7583340);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.7583340);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.7666680,
        size.width * 0.9916641,
        size.height * 0.7750000,
        size.width * 0.9833320,
        size.height * 0.7750000);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.7750000);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.7750000,
        size.width * 0.9666660,
        size.height * 0.7666660,
        size.width * 0.9666660,
        size.height * 0.7583340);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.6916660);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.6816660,
        size.width * 0.9750000,
        size.height * 0.6750000,
        size.width * 0.9833320,
        size.height * 0.6750000);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.6750000);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.6750000,
        size.width * 0.9999980,
        size.height * 0.6816660,
        size.width * 0.9999980,
        size.height * 0.6916660);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.6916660);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.7000000,
        size.width * 0.9916641,
        size.height * 0.7083320,
        size.width * 0.9833320,
        size.height * 0.7083320);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.7083320);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.7083340,
        size.width * 0.9666660,
        size.height * 0.7000000,
        size.width * 0.9666660,
        size.height * 0.6916660);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.6250000);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.6166660,
        size.width * 0.9750000,
        size.height * 0.6083340,
        size.width * 0.9833320,
        size.height * 0.6083340);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.6083340);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.6083340,
        size.width * 0.9999980,
        size.height * 0.6166680,
        size.width * 0.9999980,
        size.height * 0.6250000);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.6250000);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.6333340,
        size.width * 0.9916641,
        size.height * 0.6416660,
        size.width * 0.9833320,
        size.height * 0.6416660);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.6416660);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.6416660,
        size.width * 0.9666660,
        size.height * 0.6333340,
        size.width * 0.9666660,
        size.height * 0.6250000);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.5583340);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.5483340,
        size.width * 0.9750000,
        size.height * 0.5416680,
        size.width * 0.9833320,
        size.height * 0.5416680);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.5416680);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.5416680,
        size.width * 0.9999980,
        size.height * 0.5483340,
        size.width * 0.9999980,
        size.height * 0.5583340);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.5583340);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.5666680,
        size.width * 0.9916641,
        size.height * 0.5750000,
        size.width * 0.9833320,
        size.height * 0.5750000);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.5750000);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.5750000,
        size.width * 0.9666660,
        size.height * 0.5666660,
        size.width * 0.9666660,
        size.height * 0.5583340);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.4916660);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.4816660,
        size.width * 0.9750000,
        size.height * 0.4750000,
        size.width * 0.9833320,
        size.height * 0.4750000);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.4750000);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.4750000,
        size.width * 0.9999980,
        size.height * 0.4816660,
        size.width * 0.9999980,
        size.height * 0.4916660);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.4916660);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.5000000,
        size.width * 0.9916641,
        size.height * 0.5083320,
        size.width * 0.9833320,
        size.height * 0.5083320);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.5083320);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.5083340,
        size.width * 0.9666660,
        size.height * 0.5000000,
        size.width * 0.9666660,
        size.height * 0.4916660);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.4250000);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.4150000,
        size.width * 0.9750000,
        size.height * 0.4083340,
        size.width * 0.9833320,
        size.height * 0.4083340);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.4083340);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.4083340,
        size.width * 0.9999980,
        size.height * 0.4150000,
        size.width * 0.9999980,
        size.height * 0.4250000);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.4250000);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.4333340,
        size.width * 0.9916641,
        size.height * 0.4416660,
        size.width * 0.9833320,
        size.height * 0.4416660);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.4416660);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.4416660,
        size.width * 0.9666660,
        size.height * 0.4333340,
        size.width * 0.9666660,
        size.height * 0.4250000);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.3583340);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.3483340,
        size.width * 0.9750000,
        size.height * 0.3416680,
        size.width * 0.9833320,
        size.height * 0.3416680);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.3416680);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.3416680,
        size.width * 0.9999980,
        size.height * 0.3483340,
        size.width * 0.9999980,
        size.height * 0.3583340);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.3583340);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.3666680,
        size.width * 0.9916641,
        size.height * 0.3750000,
        size.width * 0.9833320,
        size.height * 0.3750000);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.3750000);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.3750000,
        size.width * 0.9666660,
        size.height * 0.3666660,
        size.width * 0.9666660,
        size.height * 0.3583340);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.2916660);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.2816660,
        size.width * 0.9750000,
        size.height * 0.2750000,
        size.width * 0.9833320,
        size.height * 0.2750000);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.2750000);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.2750000,
        size.width * 0.9999980,
        size.height * 0.2816660,
        size.width * 0.9999980,
        size.height * 0.2916660);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.2916660);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.3000000,
        size.width * 0.9916641,
        size.height * 0.3083320,
        size.width * 0.9833320,
        size.height * 0.3083320);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.3083320);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.3083340,
        size.width * 0.9666660,
        size.height * 0.3000000,
        size.width * 0.9666660,
        size.height * 0.2916660);
    path_11.close();
    path_11.moveTo(size.width * 0.9666660, size.height * 0.2250000);
    path_11.cubicTo(
        size.width * 0.9666660,
        size.height * 0.2150000,
        size.width * 0.9750000,
        size.height * 0.2083340,
        size.width * 0.9833320,
        size.height * 0.2083340);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.2083340);
    path_11.cubicTo(
        size.width * 0.9916660,
        size.height * 0.2083340,
        size.width * 0.9999980,
        size.height * 0.2150000,
        size.width * 0.9999980,
        size.height * 0.2250000);
    path_11.lineTo(size.width * 0.9999980, size.height * 0.2250000);
    path_11.cubicTo(
        size.width * 0.9999980,
        size.height * 0.2333340,
        size.width * 0.9916641,
        size.height * 0.2416660,
        size.width * 0.9833320,
        size.height * 0.2416660);
    path_11.lineTo(size.width * 0.9833320, size.height * 0.2416660);
    path_11.cubicTo(
        size.width * 0.9750000,
        size.height * 0.2416660,
        size.width * 0.9666660,
        size.height * 0.2333340,
        size.width * 0.9666660,
        size.height * 0.2250000);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.9016660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.9016660,
        size.height * 0.8166660,
        size.width * 0.9100000,
        size.height * 0.8083340,
        size.width * 0.9183320,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.9183320, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.9283320,
        size.height * 0.8083340,
        size.width * 0.9349980,
        size.height * 0.8166680,
        size.width * 0.9349980,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.9349980, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.9349980,
        size.height * 0.8333340,
        size.width * 0.9283320,
        size.height * 0.8416660,
        size.width * 0.9183320,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.9183320, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.9100000,
        size.height * 0.8416660,
        size.width * 0.9016660,
        size.height * 0.8333340,
        size.width * 0.9016660,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.8383340, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.8383340,
        size.height * 0.8166660,
        size.width * 0.8450000,
        size.height * 0.8083340,
        size.width * 0.8550000,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.8550000, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.8633340,
        size.height * 0.8083340,
        size.width * 0.8716660,
        size.height * 0.8166680,
        size.width * 0.8716660,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.8716660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.8716660,
        size.height * 0.8333340,
        size.width * 0.8633320,
        size.height * 0.8416660,
        size.width * 0.8550000,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.8550000, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.8450000,
        size.height * 0.8416660,
        size.width * 0.8383340,
        size.height * 0.8333340,
        size.width * 0.8383340,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.7733340, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.7733340,
        size.height * 0.8166660,
        size.width * 0.7816680,
        size.height * 0.8083340,
        size.width * 0.7900000,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.7900000, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.8000000,
        size.height * 0.8083340,
        size.width * 0.8066660,
        size.height * 0.8166680,
        size.width * 0.8066660,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.8066660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.8066660,
        size.height * 0.8333340,
        size.width * 0.8000000,
        size.height * 0.8416660,
        size.width * 0.7900000,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.7900000, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.7800000,
        size.height * 0.8416660,
        size.width * 0.7733340,
        size.height * 0.8333340,
        size.width * 0.7733340,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.7083340, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.7083340,
        size.height * 0.8166660,
        size.width * 0.7150000,
        size.height * 0.8083340,
        size.width * 0.7250000,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.7250000, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.7333340,
        size.height * 0.8083340,
        size.width * 0.7416660,
        size.height * 0.8166680,
        size.width * 0.7416660,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.7416660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.7416660,
        size.height * 0.8333340,
        size.width * 0.7333320,
        size.height * 0.8416660,
        size.width * 0.7250000,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.7250000, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.7166660,
        size.height * 0.8416660,
        size.width * 0.7083340,
        size.height * 0.8333340,
        size.width * 0.7083340,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.6450000, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.6450000,
        size.height * 0.8166660,
        size.width * 0.6516660,
        size.height * 0.8083340,
        size.width * 0.6616660,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.6616660, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.6700000,
        size.height * 0.8083340,
        size.width * 0.6783320,
        size.height * 0.8166680,
        size.width * 0.6783320,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.6783320, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.6783320,
        size.height * 0.8333340,
        size.width * 0.6716660,
        size.height * 0.8416660,
        size.width * 0.6616660,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.6616660, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.6516660,
        size.height * 0.8416660,
        size.width * 0.6450000,
        size.height * 0.8333340,
        size.width * 0.6450000,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.5800000, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.5800000,
        size.height * 0.8166660,
        size.width * 0.5883340,
        size.height * 0.8083340,
        size.width * 0.5966660,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.5966660, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.6050000,
        size.height * 0.8083340,
        size.width * 0.6133320,
        size.height * 0.8166680,
        size.width * 0.6133320,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.6133320, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.6133320,
        size.height * 0.8333340,
        size.width * 0.6049980,
        size.height * 0.8416660,
        size.width * 0.5966660,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.5966660, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.5866660,
        size.height * 0.8416660,
        size.width * 0.5800000,
        size.height * 0.8333340,
        size.width * 0.5800000,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.5150000, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.5150000,
        size.height * 0.8166660,
        size.width * 0.5233340,
        size.height * 0.8083340,
        size.width * 0.5316660,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.5316660, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.5400000,
        size.height * 0.8083340,
        size.width * 0.5483320,
        size.height * 0.8166680,
        size.width * 0.5483320,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.5483320, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.5483320,
        size.height * 0.8333340,
        size.width * 0.5399980,
        size.height * 0.8416660,
        size.width * 0.5316660,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.5316660, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.5233340,
        size.height * 0.8416660,
        size.width * 0.5150000,
        size.height * 0.8333340,
        size.width * 0.5150000,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.4516660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.4516660,
        size.height * 0.8166660,
        size.width * 0.4583320,
        size.height * 0.8083340,
        size.width * 0.4683320,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.4683320, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.4783320,
        size.height * 0.8083340,
        size.width * 0.4849980,
        size.height * 0.8166680,
        size.width * 0.4849980,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.4849980, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.4849980,
        size.height * 0.8333340,
        size.width * 0.4783320,
        size.height * 0.8416660,
        size.width * 0.4683320,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.4683320, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.4583340,
        size.height * 0.8416660,
        size.width * 0.4516660,
        size.height * 0.8333340,
        size.width * 0.4516660,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.3866660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.3866660,
        size.height * 0.8166660,
        size.width * 0.3933320,
        size.height * 0.8083340,
        size.width * 0.4033320,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.4033320, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.4133320,
        size.height * 0.8083340,
        size.width * 0.4199980,
        size.height * 0.8166680,
        size.width * 0.4199980,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.4199980, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.4199980,
        size.height * 0.8333340,
        size.width * 0.4133320,
        size.height * 0.8416660,
        size.width * 0.4033320,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.4033320, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.3933340,
        size.height * 0.8416660,
        size.width * 0.3866660,
        size.height * 0.8333340,
        size.width * 0.3866660,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.3216660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.3216660,
        size.height * 0.8166660,
        size.width * 0.3300000,
        size.height * 0.8083340,
        size.width * 0.3383320,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.3383320, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.3483320,
        size.height * 0.8083340,
        size.width * 0.3549980,
        size.height * 0.8166680,
        size.width * 0.3549980,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.3549980, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.3549980,
        size.height * 0.8333340,
        size.width * 0.3483320,
        size.height * 0.8416660,
        size.width * 0.3383320,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.3383320, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.3300000,
        size.height * 0.8416660,
        size.width * 0.3216660,
        size.height * 0.8333340,
        size.width * 0.3216660,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.2583340, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.2583340,
        size.height * 0.8166660,
        size.width * 0.2650000,
        size.height * 0.8083340,
        size.width * 0.2750000,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.2750000, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.2850000,
        size.height * 0.8083340,
        size.width * 0.2916660,
        size.height * 0.8166680,
        size.width * 0.2916660,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.2916660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.2916660,
        size.height * 0.8333340,
        size.width * 0.2850000,
        size.height * 0.8416660,
        size.width * 0.2750000,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.2750000, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.2650000,
        size.height * 0.8416660,
        size.width * 0.2583340,
        size.height * 0.8333340,
        size.width * 0.2583340,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.1933340, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.1933340,
        size.height * 0.8166660,
        size.width * 0.2000000,
        size.height * 0.8083340,
        size.width * 0.2100000,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.2100000, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.2200000,
        size.height * 0.8083340,
        size.width * 0.2266660,
        size.height * 0.8166680,
        size.width * 0.2266660,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.2266660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.2266660,
        size.height * 0.8333340,
        size.width * 0.2200000,
        size.height * 0.8416660,
        size.width * 0.2100000,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.2100000, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.2000000,
        size.height * 0.8416660,
        size.width * 0.1933340,
        size.height * 0.8333340,
        size.width * 0.1933340,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.1283340, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.1283340,
        size.height * 0.8166660,
        size.width * 0.1350000,
        size.height * 0.8083340,
        size.width * 0.1450000,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.1450000, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.1533340,
        size.height * 0.8083340,
        size.width * 0.1616660,
        size.height * 0.8166680,
        size.width * 0.1616660,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.1616660, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.1616660,
        size.height * 0.8333340,
        size.width * 0.1533320,
        size.height * 0.8416660,
        size.width * 0.1450000,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.1450000, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.1366660,
        size.height * 0.8416660,
        size.width * 0.1283340,
        size.height * 0.8333340,
        size.width * 0.1283340,
        size.height * 0.8250000);
    path_12.close();
    path_12.moveTo(size.width * 0.06500000, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.06500000,
        size.height * 0.8166660,
        size.width * 0.07333398,
        size.height * 0.8083340,
        size.width * 0.08166602,
        size.height * 0.8083340);
    path_12.lineTo(size.width * 0.08166602, size.height * 0.8083340);
    path_12.cubicTo(
        size.width * 0.09000000,
        size.height * 0.8083340,
        size.width * 0.09833203,
        size.height * 0.8166680,
        size.width * 0.09833203,
        size.height * 0.8250000);
    path_12.lineTo(size.width * 0.09833203, size.height * 0.8250000);
    path_12.cubicTo(
        size.width * 0.09833203,
        size.height * 0.8333340,
        size.width * 0.08999805,
        size.height * 0.8416660,
        size.width * 0.08166602,
        size.height * 0.8416660);
    path_12.lineTo(size.width * 0.08166602, size.height * 0.8416660);
    path_12.cubicTo(
        size.width * 0.07166602,
        size.height * 0.8416660,
        size.width * 0.06500000,
        size.height * 0.8333340,
        size.width * 0.06500000,
        size.height * 0.8250000);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.3500000, size.height * 0.8416660);
    path_13.lineTo(0, size.height * 0.8416660);
    path_13.lineTo(0, size.height * 0.1416660);
    path_13.lineTo(size.width * 0.3500000, size.height * 0.1416660);
    path_13.lineTo(size.width * 0.3500000, size.height * 0.8416660);
    path_13.close();
    path_13.moveTo(size.width * 0.03333398, size.height * 0.8083340);
    path_13.lineTo(size.width * 0.3166680, size.height * 0.8083340);
    path_13.lineTo(size.width * 0.3166680, size.height * 0.1750000);
    path_13.lineTo(size.width * 0.03333398, size.height * 0.1750000);
    path_13.lineTo(size.width * 0.03333398, size.height * 0.8083340);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
