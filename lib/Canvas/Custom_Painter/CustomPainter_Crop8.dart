import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop8 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop8(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8397129, size.height);
    path_0.cubicTo(
        size.width * 0.8347129,
        size.height,
        size.width * 0.8313789,
        size.height * 0.9983340,
        size.width * 0.8280469,
        size.height * 0.9950000);
    path_0.cubicTo(
        size.width * 0.8247148,
        size.height * 0.9916660,
        size.width * 0.8230469,
        size.height * 0.9883340,
        size.width * 0.8230469,
        size.height * 0.9833340);
    path_0.cubicTo(
        size.width * 0.8230469,
        size.height * 0.9783340,
        size.width * 0.8247129,
        size.height * 0.9750000,
        size.width * 0.8280469,
        size.height * 0.9716680);
    path_0.cubicTo(
        size.width * 0.8347129,
        size.height * 0.9650020,
        size.width * 0.8447129,
        size.height * 0.9650020,
        size.width * 0.8513809,
        size.height * 0.9716680);
    path_0.cubicTo(
        size.width * 0.8547148,
        size.height * 0.9750020,
        size.width * 0.8563809,
        size.height * 0.9800020,
        size.width * 0.8563809,
        size.height * 0.9833340);
    path_0.cubicTo(
        size.width * 0.8563809,
        size.height * 0.9883340,
        size.width * 0.8547148,
        size.height * 0.9916680,
        size.width * 0.8513809,
        size.height * 0.9950000);
    path_0.cubicTo(
        size.width * 0.8480469,
        size.height * 0.9983340,
        size.width * 0.8447129,
        size.height,
        size.width * 0.8397129,
        size.height);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2230469, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.2230469,
        size.height * 0.9750000,
        size.width * 0.2297129,
        size.height * 0.9666680,
        size.width * 0.2397129,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.2497129,
        size.height * 0.9666680,
        size.width * 0.2563789,
        size.height * 0.9750020,
        size.width * 0.2563789,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.2563789,
        size.height * 0.9916680,
        size.width * 0.2497129,
        size.height,
        size.width * 0.2397129,
        size.height);
    path_1.cubicTo(
        size.width * 0.2297129,
        size.height,
        size.width * 0.2230469,
        size.height * 0.9916660,
        size.width * 0.2230469,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.2897129, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.2897129,
        size.height * 0.9750000,
        size.width * 0.2963789,
        size.height * 0.9666680,
        size.width * 0.3063789,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.3163789,
        size.height * 0.9666680,
        size.width * 0.3230449,
        size.height * 0.9750020,
        size.width * 0.3230449,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.3230449,
        size.height * 0.9916680,
        size.width * 0.3163789,
        size.height,
        size.width * 0.3063789,
        size.height);
    path_1.cubicTo(
        size.width * 0.2963809,
        size.height,
        size.width * 0.2897129,
        size.height * 0.9916660,
        size.width * 0.2897129,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.3563809, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.3563809,
        size.height * 0.9750000,
        size.width * 0.3630469,
        size.height * 0.9666680,
        size.width * 0.3730469,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.3830469,
        size.height * 0.9666680,
        size.width * 0.3897129,
        size.height * 0.9750020,
        size.width * 0.3897129,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.3897129,
        size.height * 0.9916680,
        size.width * 0.3830469,
        size.height,
        size.width * 0.3730469,
        size.height);
    path_1.cubicTo(
        size.width * 0.3630469,
        size.height,
        size.width * 0.3563809,
        size.height * 0.9916660,
        size.width * 0.3563809,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.4230469, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.4230469,
        size.height * 0.9750000,
        size.width * 0.4313809,
        size.height * 0.9666680,
        size.width * 0.4397129,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.4480449,
        size.height * 0.9666680,
        size.width * 0.4563789,
        size.height * 0.9750020,
        size.width * 0.4563789,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.4563789,
        size.height * 0.9916680,
        size.width * 0.4480449,
        size.height,
        size.width * 0.4397129,
        size.height);
    path_1.cubicTo(
        size.width * 0.4313809,
        size.height,
        size.width * 0.4230469,
        size.height * 0.9916660,
        size.width * 0.4230469,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.4897129, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.4897129,
        size.height * 0.9750000,
        size.width * 0.4980469,
        size.height * 0.9666680,
        size.width * 0.5063789,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.5147129,
        size.height * 0.9666680,
        size.width * 0.5230449,
        size.height * 0.9750020,
        size.width * 0.5230449,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.5230449,
        size.height * 0.9916680,
        size.width * 0.5147109,
        size.height,
        size.width * 0.5063789,
        size.height);
    path_1.cubicTo(
        size.width * 0.4980469,
        size.height,
        size.width * 0.4897129,
        size.height * 0.9916660,
        size.width * 0.4897129,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.5563809, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.5563809,
        size.height * 0.9750000,
        size.width * 0.5647148,
        size.height * 0.9666680,
        size.width * 0.5730469,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.5813789,
        size.height * 0.9666680,
        size.width * 0.5897129,
        size.height * 0.9750020,
        size.width * 0.5897129,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.5897129,
        size.height * 0.9916680,
        size.width * 0.5813789,
        size.height,
        size.width * 0.5730469,
        size.height);
    path_1.cubicTo(
        size.width * 0.5647148,
        size.height,
        size.width * 0.5563809,
        size.height * 0.9916660,
        size.width * 0.5563809,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.6230469, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.6230469,
        size.height * 0.9750000,
        size.width * 0.6313809,
        size.height * 0.9666680,
        size.width * 0.6397129,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.6480449,
        size.height * 0.9666680,
        size.width * 0.6563789,
        size.height * 0.9750020,
        size.width * 0.6563789,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.6563789,
        size.height * 0.9916680,
        size.width * 0.6480449,
        size.height,
        size.width * 0.6397129,
        size.height);
    path_1.cubicTo(
        size.width * 0.6313809,
        size.height,
        size.width * 0.6230469,
        size.height * 0.9916660,
        size.width * 0.6230469,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.6897129, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.6897129,
        size.height * 0.9750000,
        size.width * 0.6980469,
        size.height * 0.9666680,
        size.width * 0.7063789,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.7147109,
        size.height * 0.9666680,
        size.width * 0.7230449,
        size.height * 0.9750020,
        size.width * 0.7230449,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.7230449,
        size.height * 0.9916680,
        size.width * 0.7147109,
        size.height,
        size.width * 0.7063789,
        size.height);
    path_1.cubicTo(
        size.width * 0.6980469,
        size.height,
        size.width * 0.6897129,
        size.height * 0.9916660,
        size.width * 0.6897129,
        size.height * 0.9833340);
    path_1.moveTo(size.width * 0.7563809, size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.7563809,
        size.height * 0.9750000,
        size.width * 0.7647148,
        size.height * 0.9666680,
        size.width * 0.7730469,
        size.height * 0.9666680);
    path_1.cubicTo(
        size.width * 0.7813789,
        size.height * 0.9666680,
        size.width * 0.7897129,
        size.height * 0.9750020,
        size.width * 0.7897129,
        size.height * 0.9833340);
    path_1.cubicTo(
        size.width * 0.7897129,
        size.height * 0.9916680,
        size.width * 0.7813789,
        size.height,
        size.width * 0.7730469,
        size.height);
    path_1.cubicTo(
        size.width * 0.7647148,
        size.height,
        size.width * 0.7563809,
        size.height * 0.9916660,
        size.width * 0.7563809,
        size.height * 0.9833340);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1730469, size.height);
    path_2.cubicTo(
        size.width * 0.1680469,
        size.height,
        size.width * 0.1647129,
        size.height * 0.9983340,
        size.width * 0.1613809,
        size.height * 0.9950000);
    path_2.cubicTo(
        size.width * 0.1580488,
        size.height * 0.9916660,
        size.width * 0.1563809,
        size.height * 0.9883340,
        size.width * 0.1563809,
        size.height * 0.9833340);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.9783340,
        size.width * 0.1580469,
        size.height * 0.9750000,
        size.width * 0.1613809,
        size.height * 0.9716680);
    path_2.cubicTo(
        size.width * 0.1680469,
        size.height * 0.9650020,
        size.width * 0.1780469,
        size.height * 0.9650020,
        size.width * 0.1847148,
        size.height * 0.9716680);
    path_2.cubicTo(
        size.width * 0.1880488,
        size.height * 0.9750020,
        size.width * 0.1897148,
        size.height * 0.9783340,
        size.width * 0.1897148,
        size.height * 0.9833340);
    path_2.cubicTo(
        size.width * 0.1897148,
        size.height * 0.9883340,
        size.width * 0.1880488,
        size.height * 0.9916680,
        size.width * 0.1847148,
        size.height * 0.9950000);
    path_2.cubicTo(
        size.width * 0.1813809,
        size.height * 0.9983340,
        size.width * 0.1780469,
        size.height,
        size.width * 0.1730469,
        size.height);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1563809, size.height * 0.3383340);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.3300000,
        size.width * 0.1630469,
        size.height * 0.3216680,
        size.width * 0.1730469,
        size.height * 0.3216680);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.3216680,
        size.width * 0.1897129,
        size.height * 0.3300020,
        size.width * 0.1897129,
        size.height * 0.3383340);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.3483340,
        size.width * 0.1813789,
        size.height * 0.3550000,
        size.width * 0.1730469,
        size.height * 0.3550000);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.3550000,
        size.width * 0.1563809,
        size.height * 0.3483340,
        size.width * 0.1563809,
        size.height * 0.3383340);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.4033340);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.3950000,
        size.width * 0.1630469,
        size.height * 0.3866680,
        size.width * 0.1730469,
        size.height * 0.3866680);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.3866680,
        size.width * 0.1897129,
        size.height * 0.3950020,
        size.width * 0.1897129,
        size.height * 0.4033340);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.4116660,
        size.width * 0.1813789,
        size.height * 0.4200000,
        size.width * 0.1730469,
        size.height * 0.4200000);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.4200000,
        size.width * 0.1563809,
        size.height * 0.4116660,
        size.width * 0.1563809,
        size.height * 0.4033340);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.4683340);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.4583340,
        size.width * 0.1630469,
        size.height * 0.4516680,
        size.width * 0.1730469,
        size.height * 0.4516680);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.4516680,
        size.width * 0.1897129,
        size.height * 0.4583340,
        size.width * 0.1897129,
        size.height * 0.4683340);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.4766680,
        size.width * 0.1813789,
        size.height * 0.4850000,
        size.width * 0.1730469,
        size.height * 0.4850000);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.4850000,
        size.width * 0.1563809,
        size.height * 0.4766660,
        size.width * 0.1563809,
        size.height * 0.4683340);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.5316660);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.5233320,
        size.width * 0.1630469,
        size.height * 0.5150000,
        size.width * 0.1730469,
        size.height * 0.5150000);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.5150000,
        size.width * 0.1897129,
        size.height * 0.5233340,
        size.width * 0.1897129,
        size.height * 0.5316660);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.5400000,
        size.width * 0.1813789,
        size.height * 0.5483320,
        size.width * 0.1730469,
        size.height * 0.5483320);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.5483340,
        size.width * 0.1563809,
        size.height * 0.5416660,
        size.width * 0.1563809,
        size.height * 0.5316660);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.5966660);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.5883320,
        size.width * 0.1630469,
        size.height * 0.5800000,
        size.width * 0.1730469,
        size.height * 0.5800000);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.5800000,
        size.width * 0.1897129,
        size.height * 0.5883340,
        size.width * 0.1897129,
        size.height * 0.5966660);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.6066660,
        size.width * 0.1813789,
        size.height * 0.6133320,
        size.width * 0.1730469,
        size.height * 0.6133320);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.6133340,
        size.width * 0.1563809,
        size.height * 0.6050000,
        size.width * 0.1563809,
        size.height * 0.5966660);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.6616660);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.6516660,
        size.width * 0.1630469,
        size.height * 0.6450000,
        size.width * 0.1730469,
        size.height * 0.6450000);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.6450000,
        size.width * 0.1897129,
        size.height * 0.6516660,
        size.width * 0.1897129,
        size.height * 0.6616660);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.6700000,
        size.width * 0.1813789,
        size.height * 0.6783320,
        size.width * 0.1730469,
        size.height * 0.6783320);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.6783340,
        size.width * 0.1563809,
        size.height * 0.6700000,
        size.width * 0.1563809,
        size.height * 0.6616660);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.7250000);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.7150000,
        size.width * 0.1630469,
        size.height * 0.7083340,
        size.width * 0.1730469,
        size.height * 0.7083340);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.7083340,
        size.width * 0.1897129,
        size.height * 0.7150000,
        size.width * 0.1897129,
        size.height * 0.7250000);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.7350000,
        size.width * 0.1813789,
        size.height * 0.7416660,
        size.width * 0.1730469,
        size.height * 0.7416660);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7416660,
        size.width * 0.1563809,
        size.height * 0.7350000,
        size.width * 0.1563809,
        size.height * 0.7250000);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.7900000);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.7816660,
        size.width * 0.1630469,
        size.height * 0.7733340,
        size.width * 0.1730469,
        size.height * 0.7733340);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.7733340,
        size.width * 0.1897129,
        size.height * 0.7816680,
        size.width * 0.1897129,
        size.height * 0.7900000);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.7983320,
        size.width * 0.1813789,
        size.height * 0.8066660,
        size.width * 0.1730469,
        size.height * 0.8066660);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.8066660,
        size.width * 0.1563809,
        size.height * 0.7983340,
        size.width * 0.1563809,
        size.height * 0.7900000);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.8550000);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.8450000,
        size.width * 0.1630469,
        size.height * 0.8383340,
        size.width * 0.1730469,
        size.height * 0.8383340);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.8383340,
        size.width * 0.1897129,
        size.height * 0.8450000,
        size.width * 0.1897129,
        size.height * 0.8550000);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.8633340,
        size.width * 0.1813789,
        size.height * 0.8716660,
        size.width * 0.1730469,
        size.height * 0.8716660);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.8716660,
        size.width * 0.1563809,
        size.height * 0.8633340,
        size.width * 0.1563809,
        size.height * 0.8550000);
    path_3.moveTo(size.width * 0.1563809, size.height * 0.9183340);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.9100000,
        size.width * 0.1630469,
        size.height * 0.9016680,
        size.width * 0.1730469,
        size.height * 0.9016680);
    path_3.cubicTo(
        size.width * 0.1830469,
        size.height * 0.9016680,
        size.width * 0.1897129,
        size.height * 0.9100020,
        size.width * 0.1897129,
        size.height * 0.9183340);
    path_3.cubicTo(
        size.width * 0.1897129,
        size.height * 0.9283340,
        size.width * 0.1813789,
        size.height * 0.9350000,
        size.width * 0.1730469,
        size.height * 0.9350000);
    path_3.cubicTo(
        size.width * 0.1647129,
        size.height * 0.9350000,
        size.width * 0.1563809,
        size.height * 0.9283340,
        size.width * 0.1563809,
        size.height * 0.9183340);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.8230469, size.height * 0.3383340);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.3300000,
        size.width * 0.8313809,
        size.height * 0.3216680,
        size.width * 0.8397129,
        size.height * 0.3216680);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.3216680,
        size.width * 0.8563789,
        size.height * 0.3300020,
        size.width * 0.8563789,
        size.height * 0.3383340);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.3483340,
        size.width * 0.8480449,
        size.height * 0.3550000,
        size.width * 0.8397129,
        size.height * 0.3550000);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3550000,
        size.width * 0.8230469,
        size.height * 0.3483340,
        size.width * 0.8230469,
        size.height * 0.3383340);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.4033340);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.3950000,
        size.width * 0.8313809,
        size.height * 0.3866680,
        size.width * 0.8397129,
        size.height * 0.3866680);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.3866680,
        size.width * 0.8563789,
        size.height * 0.3950020,
        size.width * 0.8563789,
        size.height * 0.4033340);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.4116660,
        size.width * 0.8480449,
        size.height * 0.4200000,
        size.width * 0.8397129,
        size.height * 0.4200000);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.4200000,
        size.width * 0.8230469,
        size.height * 0.4116660,
        size.width * 0.8230469,
        size.height * 0.4033340);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.4683340);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.4583340,
        size.width * 0.8313809,
        size.height * 0.4516680,
        size.width * 0.8397129,
        size.height * 0.4516680);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.4516680,
        size.width * 0.8563789,
        size.height * 0.4583340,
        size.width * 0.8563789,
        size.height * 0.4683340);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.4766680,
        size.width * 0.8480449,
        size.height * 0.4850000,
        size.width * 0.8397129,
        size.height * 0.4850000);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.4850000,
        size.width * 0.8230469,
        size.height * 0.4766660,
        size.width * 0.8230469,
        size.height * 0.4683340);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.5316660);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.5233320,
        size.width * 0.8313809,
        size.height * 0.5150000,
        size.width * 0.8397129,
        size.height * 0.5150000);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.5150000,
        size.width * 0.8563789,
        size.height * 0.5233340,
        size.width * 0.8563789,
        size.height * 0.5316660);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.5400000,
        size.width * 0.8480449,
        size.height * 0.5483320,
        size.width * 0.8397129,
        size.height * 0.5483320);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.5483320,
        size.width * 0.8230469,
        size.height * 0.5416660,
        size.width * 0.8230469,
        size.height * 0.5316660);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.5966660);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.5883320,
        size.width * 0.8313809,
        size.height * 0.5800000,
        size.width * 0.8397129,
        size.height * 0.5800000);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.5800000,
        size.width * 0.8563789,
        size.height * 0.5883340,
        size.width * 0.8563789,
        size.height * 0.5966660);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.6066660,
        size.width * 0.8480449,
        size.height * 0.6133320,
        size.width * 0.8397129,
        size.height * 0.6133320);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.6133320,
        size.width * 0.8230469,
        size.height * 0.6050000,
        size.width * 0.8230469,
        size.height * 0.5966660);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.6616660);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.6516660,
        size.width * 0.8313809,
        size.height * 0.6450000,
        size.width * 0.8397129,
        size.height * 0.6450000);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.6450000,
        size.width * 0.8563789,
        size.height * 0.6516660,
        size.width * 0.8563789,
        size.height * 0.6616660);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.6700000,
        size.width * 0.8480449,
        size.height * 0.6783320,
        size.width * 0.8397129,
        size.height * 0.6783320);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.6783320,
        size.width * 0.8230469,
        size.height * 0.6700000,
        size.width * 0.8230469,
        size.height * 0.6616660);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.7250000);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.7150000,
        size.width * 0.8313809,
        size.height * 0.7083340,
        size.width * 0.8397129,
        size.height * 0.7083340);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.7083340,
        size.width * 0.8563789,
        size.height * 0.7150000,
        size.width * 0.8563789,
        size.height * 0.7250000);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.7350000,
        size.width * 0.8480449,
        size.height * 0.7416660,
        size.width * 0.8397129,
        size.height * 0.7416660);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7416660,
        size.width * 0.8230469,
        size.height * 0.7350000,
        size.width * 0.8230469,
        size.height * 0.7250000);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.7900000);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.7816660,
        size.width * 0.8313809,
        size.height * 0.7733340,
        size.width * 0.8397129,
        size.height * 0.7733340);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.7733340,
        size.width * 0.8563789,
        size.height * 0.7816680,
        size.width * 0.8563789,
        size.height * 0.7900000);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.7983320,
        size.width * 0.8480449,
        size.height * 0.8066660,
        size.width * 0.8397129,
        size.height * 0.8066660);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.8066660,
        size.width * 0.8230469,
        size.height * 0.7983340,
        size.width * 0.8230469,
        size.height * 0.7900000);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.8550000);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.8450000,
        size.width * 0.8313809,
        size.height * 0.8383340,
        size.width * 0.8397129,
        size.height * 0.8383340);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.8383340,
        size.width * 0.8563789,
        size.height * 0.8450000,
        size.width * 0.8563789,
        size.height * 0.8550000);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.8633340,
        size.width * 0.8480449,
        size.height * 0.8716660,
        size.width * 0.8397129,
        size.height * 0.8716660);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.8716660,
        size.width * 0.8230469,
        size.height * 0.8633340,
        size.width * 0.8230469,
        size.height * 0.8550000);
    path_4.moveTo(size.width * 0.8230469, size.height * 0.9183340);
    path_4.cubicTo(
        size.width * 0.8230469,
        size.height * 0.9100000,
        size.width * 0.8313809,
        size.height * 0.9016680,
        size.width * 0.8397129,
        size.height * 0.9016680);
    path_4.cubicTo(
        size.width * 0.8480449,
        size.height * 0.9016680,
        size.width * 0.8563789,
        size.height * 0.9100020,
        size.width * 0.8563789,
        size.height * 0.9183340);
    path_4.cubicTo(
        size.width * 0.8563789,
        size.height * 0.9283340,
        size.width * 0.8480449,
        size.height * 0.9350000,
        size.width * 0.8397129,
        size.height * 0.9350000);
    path_4.cubicTo(
        size.width * 0.8313809,
        size.height * 0.9350000,
        size.width * 0.8230469,
        size.height * 0.9283340,
        size.width * 0.8230469,
        size.height * 0.9183340);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.1563809, size.height * 0.3333340);
    path_5.lineTo(size.width * 0.8230469, size.height * 0.3333340);
    path_5.lineTo(size.width * 0.8230469, size.height * 0.01666602);
    path_5.lineTo(size.width * 0.1563809, size.height * 0.01666602);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.8397129, size.height * 0.3500000);
    path_6.lineTo(size.width * 0.1397129, size.height * 0.3500000);
    path_6.lineTo(size.width * 0.1397129, 0);
    path_6.lineTo(size.width * 0.8397129, 0);
    path_6.lineTo(size.width * 0.8397129, size.height * 0.3500000);
    path_6.close();
    path_6.moveTo(size.width * 0.1730469, size.height * 0.3166660);
    path_6.lineTo(size.width * 0.8063809, size.height * 0.3166660);
    path_6.lineTo(size.width * 0.8063809, size.height * 0.03333398);
    path_6.lineTo(size.width * 0.1730469, size.height * 0.03333398);
    path_6.lineTo(size.width * 0.1730469, size.height * 0.3166660);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.7397129, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.7397129,
        size.height * 0.9750000,
        size.width * 0.7480469,
        size.height * 0.9666680,
        size.width * 0.7563789,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.7563789, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.7647129,
        size.height * 0.9666680,
        size.width * 0.7730449,
        size.height * 0.9750020,
        size.width * 0.7730449,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.7730449, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.7730449,
        size.height * 0.9916680,
        size.width * 0.7647109,
        size.height,
        size.width * 0.7563789,
        size.height);
    path_7.lineTo(size.width * 0.7563789, size.height);
    path_7.cubicTo(
        size.width * 0.7480469,
        size.height,
        size.width * 0.7397129,
        size.height * 0.9916660,
        size.width * 0.7397129,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.6730469, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.6730469,
        size.height * 0.9750000,
        size.width * 0.6813809,
        size.height * 0.9666680,
        size.width * 0.6897129,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.6897129, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.6980469,
        size.height * 0.9666680,
        size.width * 0.7063789,
        size.height * 0.9750020,
        size.width * 0.7063789,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.7063789, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.7063789,
        size.height * 0.9916680,
        size.width * 0.6980449,
        size.height,
        size.width * 0.6897129,
        size.height);
    path_7.lineTo(size.width * 0.6897129, size.height);
    path_7.cubicTo(
        size.width * 0.6813809,
        size.height,
        size.width * 0.6730469,
        size.height * 0.9916660,
        size.width * 0.6730469,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.6063809, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.6063809,
        size.height * 0.9750000,
        size.width * 0.6147148,
        size.height * 0.9666680,
        size.width * 0.6230469,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.6230469, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.6313809,
        size.height * 0.9666680,
        size.width * 0.6397129,
        size.height * 0.9750020,
        size.width * 0.6397129,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.6397129, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.6397129,
        size.height * 0.9916680,
        size.width * 0.6313789,
        size.height,
        size.width * 0.6230469,
        size.height);
    path_7.lineTo(size.width * 0.6230469, size.height);
    path_7.cubicTo(
        size.width * 0.6147129,
        size.height,
        size.width * 0.6063809,
        size.height * 0.9916660,
        size.width * 0.6063809,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.5397129, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.5397129,
        size.height * 0.9750000,
        size.width * 0.5480469,
        size.height * 0.9666680,
        size.width * 0.5563789,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.5563789, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.5647129,
        size.height * 0.9666680,
        size.width * 0.5730449,
        size.height * 0.9750020,
        size.width * 0.5730449,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.5730449, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.5730449,
        size.height * 0.9916680,
        size.width * 0.5647109,
        size.height,
        size.width * 0.5563789,
        size.height);
    path_7.lineTo(size.width * 0.5563789, size.height);
    path_7.cubicTo(
        size.width * 0.5480469,
        size.height,
        size.width * 0.5397129,
        size.height * 0.9916660,
        size.width * 0.5397129,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.4730469, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.4730469,
        size.height * 0.9750000,
        size.width * 0.4797129,
        size.height * 0.9666680,
        size.width * 0.4897129,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.4897129, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.4980469,
        size.height * 0.9666680,
        size.width * 0.5063789,
        size.height * 0.9750020,
        size.width * 0.5063789,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.5063789, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.5063789,
        size.height * 0.9916680,
        size.width * 0.4980449,
        size.height,
        size.width * 0.4897129,
        size.height);
    path_7.lineTo(size.width * 0.4897129, size.height);
    path_7.cubicTo(
        size.width * 0.4797129,
        size.height,
        size.width * 0.4730469,
        size.height * 0.9916660,
        size.width * 0.4730469,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.4063809, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.4063809,
        size.height * 0.9750000,
        size.width * 0.4130469,
        size.height * 0.9666680,
        size.width * 0.4230469,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.4230469, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.4313809,
        size.height * 0.9666680,
        size.width * 0.4397129,
        size.height * 0.9750020,
        size.width * 0.4397129,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.4397129, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.4397129,
        size.height * 0.9916680,
        size.width * 0.4313789,
        size.height,
        size.width * 0.4230469,
        size.height);
    path_7.lineTo(size.width * 0.4230469, size.height);
    path_7.cubicTo(
        size.width * 0.4130469,
        size.height,
        size.width * 0.4063809,
        size.height * 0.9916660,
        size.width * 0.4063809,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.3397129, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.3397129,
        size.height * 0.9750000,
        size.width * 0.3463789,
        size.height * 0.9666680,
        size.width * 0.3563789,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.3563789, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.3647129,
        size.height * 0.9666680,
        size.width * 0.3730449,
        size.height * 0.9750020,
        size.width * 0.3730449,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.3730449, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.3730449,
        size.height * 0.9916680,
        size.width * 0.3647109,
        size.height,
        size.width * 0.3563789,
        size.height);
    path_7.lineTo(size.width * 0.3563789, size.height);
    path_7.cubicTo(
        size.width * 0.3463809,
        size.height,
        size.width * 0.3397129,
        size.height * 0.9916660,
        size.width * 0.3397129,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.2730469, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.2730469,
        size.height * 0.9750000,
        size.width * 0.2797129,
        size.height * 0.9666680,
        size.width * 0.2897129,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.2897129, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.9666680,
        size.width * 0.3063789,
        size.height * 0.9750020,
        size.width * 0.3063789,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.3063789, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.3063789,
        size.height * 0.9916680,
        size.width * 0.2980449,
        size.height,
        size.width * 0.2897129,
        size.height);
    path_7.lineTo(size.width * 0.2897129, size.height);
    path_7.cubicTo(
        size.width * 0.2797129,
        size.height,
        size.width * 0.2730469,
        size.height * 0.9916660,
        size.width * 0.2730469,
        size.height * 0.9833340);
    path_7.close();
    path_7.moveTo(size.width * 0.2063809, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.2063809,
        size.height * 0.9750000,
        size.width * 0.2130469,
        size.height * 0.9666680,
        size.width * 0.2230469,
        size.height * 0.9666680);
    path_7.lineTo(size.width * 0.2230469, size.height * 0.9666680);
    path_7.cubicTo(
        size.width * 0.2313809,
        size.height * 0.9666680,
        size.width * 0.2397129,
        size.height * 0.9750020,
        size.width * 0.2397129,
        size.height * 0.9833340);
    path_7.lineTo(size.width * 0.2397129, size.height * 0.9833340);
    path_7.cubicTo(
        size.width * 0.2397129,
        size.height * 0.9916680,
        size.width * 0.2313789,
        size.height,
        size.width * 0.2230469,
        size.height);
    path_7.lineTo(size.width * 0.2230469, size.height);
    path_7.cubicTo(
        size.width * 0.2130469,
        size.height,
        size.width * 0.2063809,
        size.height * 0.9916660,
        size.width * 0.2063809,
        size.height * 0.9833340);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.9183340);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.9100000,
        size.width * 0.1463789,
        size.height * 0.9016680,
        size.width * 0.1563789,
        size.height * 0.9016680);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.9016680);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.9016680,
        size.width * 0.1730449,
        size.height * 0.9100020,
        size.width * 0.1730449,
        size.height * 0.9183340);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.9183340);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.9266680,
        size.width * 0.1647109,
        size.height * 0.9350000,
        size.width * 0.1563789,
        size.height * 0.9350000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.9350000);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.9350000,
        size.width * 0.1397129,
        size.height * 0.9283340,
        size.width * 0.1397129,
        size.height * 0.9183340);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.8550000);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.8450000,
        size.width * 0.1463789,
        size.height * 0.8383340,
        size.width * 0.1563789,
        size.height * 0.8383340);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.8383340);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.8383340,
        size.width * 0.1730449,
        size.height * 0.8450000,
        size.width * 0.1730449,
        size.height * 0.8550000);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.8550000);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.8633340,
        size.width * 0.1647109,
        size.height * 0.8716660,
        size.width * 0.1563789,
        size.height * 0.8716660);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.8716660);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.8716660,
        size.width * 0.1397129,
        size.height * 0.8633340,
        size.width * 0.1397129,
        size.height * 0.8550000);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.7900000);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.7816660,
        size.width * 0.1463789,
        size.height * 0.7733340,
        size.width * 0.1563789,
        size.height * 0.7733340);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.7733340);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7733340,
        size.width * 0.1730449,
        size.height * 0.7816680,
        size.width * 0.1730449,
        size.height * 0.7900000);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.7900000);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.8000000,
        size.width * 0.1647109,
        size.height * 0.8066660,
        size.width * 0.1563789,
        size.height * 0.8066660);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.8066660);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.8066660,
        size.width * 0.1397129,
        size.height * 0.8000000,
        size.width * 0.1397129,
        size.height * 0.7900000);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.7250000);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.7150000,
        size.width * 0.1463789,
        size.height * 0.7083340,
        size.width * 0.1563789,
        size.height * 0.7083340);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.7083340);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7083340,
        size.width * 0.1730449,
        size.height * 0.7150000,
        size.width * 0.1730449,
        size.height * 0.7250000);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.7250000);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.7333340,
        size.width * 0.1647109,
        size.height * 0.7416660,
        size.width * 0.1563789,
        size.height * 0.7416660);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.7416660);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.7416660,
        size.width * 0.1397129,
        size.height * 0.7350000,
        size.width * 0.1397129,
        size.height * 0.7250000);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.6616660);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.6516660,
        size.width * 0.1463789,
        size.height * 0.6450000,
        size.width * 0.1563789,
        size.height * 0.6450000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.6450000);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.6450000,
        size.width * 0.1730449,
        size.height * 0.6516660,
        size.width * 0.1730449,
        size.height * 0.6616660);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.6616660);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.6716660,
        size.width * 0.1647109,
        size.height * 0.6783320,
        size.width * 0.1563789,
        size.height * 0.6783320);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.6783320);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.6783340,
        size.width * 0.1397129,
        size.height * 0.6700000,
        size.width * 0.1397129,
        size.height * 0.6616660);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.5966660);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.5866660,
        size.width * 0.1463789,
        size.height * 0.5800000,
        size.width * 0.1563789,
        size.height * 0.5800000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.5800000);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.5800000,
        size.width * 0.1730449,
        size.height * 0.5866660,
        size.width * 0.1730449,
        size.height * 0.5966660);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.5966660);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.6050000,
        size.width * 0.1647109,
        size.height * 0.6133320,
        size.width * 0.1563789,
        size.height * 0.6133320);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.6133320);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.6133340,
        size.width * 0.1397129,
        size.height * 0.6050000,
        size.width * 0.1397129,
        size.height * 0.5966660);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.5316660);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.5233320,
        size.width * 0.1463789,
        size.height * 0.5150000,
        size.width * 0.1563789,
        size.height * 0.5150000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.5150000);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.5150000,
        size.width * 0.1730449,
        size.height * 0.5233340,
        size.width * 0.1730449,
        size.height * 0.5316660);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.5316660);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.5400000,
        size.width * 0.1647109,
        size.height * 0.5483320,
        size.width * 0.1563789,
        size.height * 0.5483320);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.5483320);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.5483340,
        size.width * 0.1397129,
        size.height * 0.5416660,
        size.width * 0.1397129,
        size.height * 0.5316660);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.4683340);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.4583340,
        size.width * 0.1463789,
        size.height * 0.4516680,
        size.width * 0.1563789,
        size.height * 0.4516680);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.4516680);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.4516680,
        size.width * 0.1730449,
        size.height * 0.4583340,
        size.width * 0.1730449,
        size.height * 0.4683340);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.4683340);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.4783340,
        size.width * 0.1647109,
        size.height * 0.4850000,
        size.width * 0.1563789,
        size.height * 0.4850000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.4850000);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.4850000,
        size.width * 0.1397129,
        size.height * 0.4766660,
        size.width * 0.1397129,
        size.height * 0.4683340);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.4033340);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.3933340,
        size.width * 0.1463789,
        size.height * 0.3866680,
        size.width * 0.1563789,
        size.height * 0.3866680);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.3866680);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.3866680,
        size.width * 0.1730449,
        size.height * 0.3933340,
        size.width * 0.1730449,
        size.height * 0.4033340);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.4033340);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.4133340,
        size.width * 0.1647109,
        size.height * 0.4200000,
        size.width * 0.1563789,
        size.height * 0.4200000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.4200000);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.4200000,
        size.width * 0.1397129,
        size.height * 0.4133340,
        size.width * 0.1397129,
        size.height * 0.4033340);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.3383340);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.3300000,
        size.width * 0.1463789,
        size.height * 0.3216680,
        size.width * 0.1563789,
        size.height * 0.3216680);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.3216680);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.3216680,
        size.width * 0.1730449,
        size.height * 0.3300020,
        size.width * 0.1730449,
        size.height * 0.3383340);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.3383340);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.3483340,
        size.width * 0.1647109,
        size.height * 0.3550000,
        size.width * 0.1563789,
        size.height * 0.3550000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.3550000);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.3550000,
        size.width * 0.1397129,
        size.height * 0.3483340,
        size.width * 0.1397129,
        size.height * 0.3383340);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.2750000);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.2650000,
        size.width * 0.1463789,
        size.height * 0.2583340,
        size.width * 0.1563789,
        size.height * 0.2583340);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.2583340);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.2583340,
        size.width * 0.1730449,
        size.height * 0.2650000,
        size.width * 0.1730449,
        size.height * 0.2750000);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.2750000);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.2833340,
        size.width * 0.1647109,
        size.height * 0.2916660,
        size.width * 0.1563789,
        size.height * 0.2916660);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.2916660);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.2916660,
        size.width * 0.1397129,
        size.height * 0.2833340,
        size.width * 0.1397129,
        size.height * 0.2750000);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.2100000);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.2000000,
        size.width * 0.1463789,
        size.height * 0.1933340,
        size.width * 0.1563789,
        size.height * 0.1933340);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.1933340);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.1933340,
        size.width * 0.1730449,
        size.height * 0.2000000,
        size.width * 0.1730449,
        size.height * 0.2100000);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.2100000);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.2200000,
        size.width * 0.1647109,
        size.height * 0.2266660,
        size.width * 0.1563789,
        size.height * 0.2266660);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.2266660);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.2266660,
        size.width * 0.1397129,
        size.height * 0.2183340,
        size.width * 0.1397129,
        size.height * 0.2100000);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.1450000);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.1350000,
        size.width * 0.1463789,
        size.height * 0.1283340,
        size.width * 0.1563789,
        size.height * 0.1283340);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.1283340);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.1283340,
        size.width * 0.1730449,
        size.height * 0.1350000,
        size.width * 0.1730449,
        size.height * 0.1450000);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.1450000);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.1533340,
        size.width * 0.1647109,
        size.height * 0.1616660,
        size.width * 0.1563789,
        size.height * 0.1616660);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.1616660);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.1616660,
        size.width * 0.1397129,
        size.height * 0.1550000,
        size.width * 0.1397129,
        size.height * 0.1450000);
    path_8.close();
    path_8.moveTo(size.width * 0.1397129, size.height * 0.08166602);
    path_8.cubicTo(
        size.width * 0.1397129,
        size.height * 0.07333203,
        size.width * 0.1463789,
        size.height * 0.06500000,
        size.width * 0.1563789,
        size.height * 0.06500000);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.06500000);
    path_8.cubicTo(
        size.width * 0.1647129,
        size.height * 0.06500000,
        size.width * 0.1730449,
        size.height * 0.07333398,
        size.width * 0.1730449,
        size.height * 0.08166602);
    path_8.lineTo(size.width * 0.1730449, size.height * 0.08166602);
    path_8.cubicTo(
        size.width * 0.1730449,
        size.height * 0.09000000,
        size.width * 0.1647109,
        size.height * 0.09833203,
        size.width * 0.1563789,
        size.height * 0.09833203);
    path_8.lineTo(size.width * 0.1563789, size.height * 0.09833203);
    path_8.cubicTo(
        size.width * 0.1463809,
        size.height * 0.09833398,
        size.width * 0.1397129,
        size.height * 0.09000000,
        size.width * 0.1397129,
        size.height * 0.08166602);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.7397129, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.7397129, size.height * 0.006666016,
        size.width * 0.7480469, 0, size.width * 0.7563809, 0);
    path_9.lineTo(size.width * 0.7563809, 0);
    path_9.cubicTo(
        size.width * 0.7647148,
        0,
        size.width * 0.7730469,
        size.height * 0.006666016,
        size.width * 0.7730469,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.7730469, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.7730469,
        size.height * 0.02500000,
        size.width * 0.7647129,
        size.height * 0.03333203,
        size.width * 0.7563809,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.7563809, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.7480469,
        size.height * 0.03333398,
        size.width * 0.7397129,
        size.height * 0.02500000,
        size.width * 0.7397129,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.6730469, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.6730469, size.height * 0.006666016,
        size.width * 0.6813809, 0, size.width * 0.6897129, 0);
    path_9.lineTo(size.width * 0.6897129, 0);
    path_9.cubicTo(
        size.width * 0.6980469,
        0,
        size.width * 0.7063789,
        size.height * 0.006666016,
        size.width * 0.7063789,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.7063789, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.7063789,
        size.height * 0.02500000,
        size.width * 0.6980449,
        size.height * 0.03333203,
        size.width * 0.6897129,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.6897129, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.6813809,
        size.height * 0.03333398,
        size.width * 0.6730469,
        size.height * 0.02500000,
        size.width * 0.6730469,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.6063809, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.6063809, size.height * 0.006666016,
        size.width * 0.6147129, 0, size.width * 0.6230469, 0);
    path_9.lineTo(size.width * 0.6230469, 0);
    path_9.cubicTo(
        size.width * 0.6313809,
        0,
        size.width * 0.6397129,
        size.height * 0.006666016,
        size.width * 0.6397129,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.6397129, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.6397129,
        size.height * 0.02500000,
        size.width * 0.6313789,
        size.height * 0.03333203,
        size.width * 0.6230469,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.6230469, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.6147129,
        size.height * 0.03333398,
        size.width * 0.6063809,
        size.height * 0.02500000,
        size.width * 0.6063809,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.5397129, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.5397129, size.height * 0.006666016,
        size.width * 0.5480469, 0, size.width * 0.5563789, 0);
    path_9.lineTo(size.width * 0.5563789, 0);
    path_9.cubicTo(
        size.width * 0.5647129,
        0,
        size.width * 0.5730449,
        size.height * 0.006666016,
        size.width * 0.5730449,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.5730449, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.5730449,
        size.height * 0.02500000,
        size.width * 0.5647109,
        size.height * 0.03333203,
        size.width * 0.5563789,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.5563789, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.5480469,
        size.height * 0.03333398,
        size.width * 0.5397129,
        size.height * 0.02500000,
        size.width * 0.5397129,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.4730469, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.4730469, size.height * 0.006666016,
        size.width * 0.4797129, 0, size.width * 0.4897129, 0);
    path_9.lineTo(size.width * 0.4897129, 0);
    path_9.cubicTo(
        size.width * 0.4980469,
        0,
        size.width * 0.5063789,
        size.height * 0.006666016,
        size.width * 0.5063789,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.5063789, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.5063789,
        size.height * 0.02500000,
        size.width * 0.4980449,
        size.height * 0.03333203,
        size.width * 0.4897129,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.4897129, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.4797129,
        size.height * 0.03333398,
        size.width * 0.4730469,
        size.height * 0.02500000,
        size.width * 0.4730469,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.4063809, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.4063809, size.height * 0.006666016,
        size.width * 0.4130469, 0, size.width * 0.4230469, 0);
    path_9.lineTo(size.width * 0.4230469, 0);
    path_9.cubicTo(
        size.width * 0.4313809,
        0,
        size.width * 0.4397129,
        size.height * 0.006666016,
        size.width * 0.4397129,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.4397129, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.4397129,
        size.height * 0.02500000,
        size.width * 0.4313789,
        size.height * 0.03333203,
        size.width * 0.4230469,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.4230469, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.4130469,
        size.height * 0.03333398,
        size.width * 0.4063809,
        size.height * 0.02500000,
        size.width * 0.4063809,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.3397129, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.3397129, size.height * 0.006666016,
        size.width * 0.3463789, 0, size.width * 0.3563789, 0);
    path_9.lineTo(size.width * 0.3563789, 0);
    path_9.cubicTo(
        size.width * 0.3647129,
        0,
        size.width * 0.3730469,
        size.height * 0.006666016,
        size.width * 0.3730469,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.3730469, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.3730469,
        size.height * 0.02500000,
        size.width * 0.3647129,
        size.height * 0.03333203,
        size.width * 0.3563809,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.3563809, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.3463809,
        size.height * 0.03333398,
        size.width * 0.3397129,
        size.height * 0.02500000,
        size.width * 0.3397129,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.2730469, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.2730469, size.height * 0.006666016,
        size.width * 0.2797129, 0, size.width * 0.2897129, 0);
    path_9.lineTo(size.width * 0.2897129, 0);
    path_9.cubicTo(
        size.width * 0.2980469,
        0,
        size.width * 0.3063789,
        size.height * 0.006666016,
        size.width * 0.3063789,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.3063789, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.3063789,
        size.height * 0.02500000,
        size.width * 0.2980449,
        size.height * 0.03333203,
        size.width * 0.2897129,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.2897129, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.2797129,
        size.height * 0.03333398,
        size.width * 0.2730469,
        size.height * 0.02500000,
        size.width * 0.2730469,
        size.height * 0.01666602);
    path_9.close();
    path_9.moveTo(size.width * 0.2063809, size.height * 0.01666602);
    path_9.cubicTo(size.width * 0.2063809, size.height * 0.006666016,
        size.width * 0.2130469, 0, size.width * 0.2230469, 0);
    path_9.lineTo(size.width * 0.2230469, 0);
    path_9.cubicTo(
        size.width * 0.2313809,
        0,
        size.width * 0.2397129,
        size.height * 0.006666016,
        size.width * 0.2397129,
        size.height * 0.01666602);
    path_9.lineTo(size.width * 0.2397129, size.height * 0.01666602);
    path_9.cubicTo(
        size.width * 0.2397129,
        size.height * 0.02500000,
        size.width * 0.2313789,
        size.height * 0.03333203,
        size.width * 0.2230469,
        size.height * 0.03333203);
    path_9.lineTo(size.width * 0.2230469, size.height * 0.03333203);
    path_9.cubicTo(
        size.width * 0.2130469,
        size.height * 0.03333398,
        size.width * 0.2063809,
        size.height * 0.02500000,
        size.width * 0.2063809,
        size.height * 0.01666602);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.9183340);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.9083340,
        size.width * 0.8147148,
        size.height * 0.9016680,
        size.width * 0.8230469,
        size.height * 0.9016680);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.9016680);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.9016680,
        size.width * 0.8397129,
        size.height * 0.9083340,
        size.width * 0.8397129,
        size.height * 0.9183340);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.9183340);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.9266680,
        size.width * 0.8313789,
        size.height * 0.9350000,
        size.width * 0.8230469,
        size.height * 0.9350000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.9350000);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.9350000,
        size.width * 0.8063809,
        size.height * 0.9283340,
        size.width * 0.8063809,
        size.height * 0.9183340);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.8550000);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.8466660,
        size.width * 0.8147148,
        size.height * 0.8383340,
        size.width * 0.8230469,
        size.height * 0.8383340);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.8383340);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.8383340,
        size.width * 0.8397129,
        size.height * 0.8466680,
        size.width * 0.8397129,
        size.height * 0.8550000);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.8550000);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.8633340,
        size.width * 0.8313789,
        size.height * 0.8716660,
        size.width * 0.8230469,
        size.height * 0.8716660);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.8716660);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.8716660,
        size.width * 0.8063809,
        size.height * 0.8633340,
        size.width * 0.8063809,
        size.height * 0.8550000);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.7900000);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.7816660,
        size.width * 0.8147148,
        size.height * 0.7733340,
        size.width * 0.8230469,
        size.height * 0.7733340);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.7733340);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7733340,
        size.width * 0.8397129,
        size.height * 0.7816680,
        size.width * 0.8397129,
        size.height * 0.7900000);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.7900000);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.8000000,
        size.width * 0.8313789,
        size.height * 0.8066660,
        size.width * 0.8230469,
        size.height * 0.8066660);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.8066660);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.8066660,
        size.width * 0.8063809,
        size.height * 0.8000000,
        size.width * 0.8063809,
        size.height * 0.7900000);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.7250000);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.7150000,
        size.width * 0.8147148,
        size.height * 0.7083340,
        size.width * 0.8230469,
        size.height * 0.7083340);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.7083340);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7083340,
        size.width * 0.8397129,
        size.height * 0.7150000,
        size.width * 0.8397129,
        size.height * 0.7250000);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.7250000);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.7350000,
        size.width * 0.8313789,
        size.height * 0.7416660,
        size.width * 0.8230469,
        size.height * 0.7416660);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.7416660);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.7416660,
        size.width * 0.8063809,
        size.height * 0.7350000,
        size.width * 0.8063809,
        size.height * 0.7250000);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.6616660);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.6516660,
        size.width * 0.8147148,
        size.height * 0.6450000,
        size.width * 0.8230469,
        size.height * 0.6450000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.6450000);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.6450000,
        size.width * 0.8397129,
        size.height * 0.6516660,
        size.width * 0.8397129,
        size.height * 0.6616660);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.6616660);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.6700000,
        size.width * 0.8313789,
        size.height * 0.6783320,
        size.width * 0.8230469,
        size.height * 0.6783320);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.6783320);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.6783340,
        size.width * 0.8063809,
        size.height * 0.6700000,
        size.width * 0.8063809,
        size.height * 0.6616660);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.5966660);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.5883320,
        size.width * 0.8147148,
        size.height * 0.5800000,
        size.width * 0.8230469,
        size.height * 0.5800000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.5800000);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.5800000,
        size.width * 0.8397129,
        size.height * 0.5883340,
        size.width * 0.8397129,
        size.height * 0.5966660);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.5966660);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.6050000,
        size.width * 0.8313789,
        size.height * 0.6133320,
        size.width * 0.8230469,
        size.height * 0.6133320);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.6133320);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.6133340,
        size.width * 0.8063809,
        size.height * 0.6050000,
        size.width * 0.8063809,
        size.height * 0.5966660);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.5316660);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.5216660,
        size.width * 0.8147148,
        size.height * 0.5150000,
        size.width * 0.8230469,
        size.height * 0.5150000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.5150000);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.5150000,
        size.width * 0.8397129,
        size.height * 0.5216660,
        size.width * 0.8397129,
        size.height * 0.5316660);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.5316660);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.5416660,
        size.width * 0.8313789,
        size.height * 0.5483320,
        size.width * 0.8230469,
        size.height * 0.5483320);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.5483320);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.5483340,
        size.width * 0.8063809,
        size.height * 0.5416660,
        size.width * 0.8063809,
        size.height * 0.5316660);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.4683340);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.4600000,
        size.width * 0.8147148,
        size.height * 0.4516680,
        size.width * 0.8230469,
        size.height * 0.4516680);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.4516680);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.4516680,
        size.width * 0.8397129,
        size.height * 0.4600020,
        size.width * 0.8397129,
        size.height * 0.4683340);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.4683340);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.4766680,
        size.width * 0.8313789,
        size.height * 0.4850000,
        size.width * 0.8230469,
        size.height * 0.4850000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.4850000);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.4850000,
        size.width * 0.8063809,
        size.height * 0.4766660,
        size.width * 0.8063809,
        size.height * 0.4683340);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.4033340);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.3950000,
        size.width * 0.8147148,
        size.height * 0.3866680,
        size.width * 0.8230469,
        size.height * 0.3866680);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.3866680);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3866680,
        size.width * 0.8397129,
        size.height * 0.3950020,
        size.width * 0.8397129,
        size.height * 0.4033340);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.4033340);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.4133340,
        size.width * 0.8313789,
        size.height * 0.4200000,
        size.width * 0.8230469,
        size.height * 0.4200000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.4200000);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.4200000,
        size.width * 0.8063809,
        size.height * 0.4133340,
        size.width * 0.8063809,
        size.height * 0.4033340);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.3383340);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.3300000,
        size.width * 0.8147148,
        size.height * 0.3216680,
        size.width * 0.8230469,
        size.height * 0.3216680);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.3216680);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3216680,
        size.width * 0.8397129,
        size.height * 0.3300020,
        size.width * 0.8397129,
        size.height * 0.3383340);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.3383340);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.3483340,
        size.width * 0.8313789,
        size.height * 0.3550000,
        size.width * 0.8230469,
        size.height * 0.3550000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.3550000);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.3550000,
        size.width * 0.8063809,
        size.height * 0.3483340,
        size.width * 0.8063809,
        size.height * 0.3383340);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.2750000);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.2650000,
        size.width * 0.8147148,
        size.height * 0.2583340,
        size.width * 0.8230469,
        size.height * 0.2583340);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.2583340);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2583340,
        size.width * 0.8397129,
        size.height * 0.2650000,
        size.width * 0.8397129,
        size.height * 0.2750000);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.2750000);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.2850000,
        size.width * 0.8313789,
        size.height * 0.2916660,
        size.width * 0.8230469,
        size.height * 0.2916660);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.2916660);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.2916660,
        size.width * 0.8063809,
        size.height * 0.2833340,
        size.width * 0.8063809,
        size.height * 0.2750000);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.2100000);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.2016660,
        size.width * 0.8147148,
        size.height * 0.1933340,
        size.width * 0.8230469,
        size.height * 0.1933340);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.1933340);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.1933340,
        size.width * 0.8397129,
        size.height * 0.2016680,
        size.width * 0.8397129,
        size.height * 0.2100000);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.2100000);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.2200000,
        size.width * 0.8313789,
        size.height * 0.2266660,
        size.width * 0.8230469,
        size.height * 0.2266660);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.2266660);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.2266660,
        size.width * 0.8063809,
        size.height * 0.2183340,
        size.width * 0.8063809,
        size.height * 0.2100000);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.1450000);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.1350000,
        size.width * 0.8147148,
        size.height * 0.1283340,
        size.width * 0.8230469,
        size.height * 0.1283340);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.1283340);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.1283340,
        size.width * 0.8397129,
        size.height * 0.1350000,
        size.width * 0.8397129,
        size.height * 0.1450000);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.1450000);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.1550000,
        size.width * 0.8313789,
        size.height * 0.1616660,
        size.width * 0.8230469,
        size.height * 0.1616660);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.1616660);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.1616660,
        size.width * 0.8063809,
        size.height * 0.1550000,
        size.width * 0.8063809,
        size.height * 0.1450000);
    path_10.close();
    path_10.moveTo(size.width * 0.8063809, size.height * 0.08166602);
    path_10.cubicTo(
        size.width * 0.8063809,
        size.height * 0.07166602,
        size.width * 0.8147148,
        size.height * 0.06500000,
        size.width * 0.8230469,
        size.height * 0.06500000);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.06500000);
    path_10.cubicTo(
        size.width * 0.8313809,
        size.height * 0.06500000,
        size.width * 0.8397129,
        size.height * 0.07166602,
        size.width * 0.8397129,
        size.height * 0.08166602);
    path_10.lineTo(size.width * 0.8397129, size.height * 0.08166602);
    path_10.cubicTo(
        size.width * 0.8397129,
        size.height * 0.09166602,
        size.width * 0.8313789,
        size.height * 0.09833203,
        size.width * 0.8230469,
        size.height * 0.09833203);
    path_10.lineTo(size.width * 0.8230469, size.height * 0.09833203);
    path_10.cubicTo(
        size.width * 0.8147129,
        size.height * 0.09833398,
        size.width * 0.8063809,
        size.height * 0.09000000,
        size.width * 0.8063809,
        size.height * 0.08166602);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.8397129, size.height * 0.3500000);
    path_11.lineTo(size.width * 0.1397129, size.height * 0.3500000);
    path_11.lineTo(size.width * 0.1397129, 0);
    path_11.lineTo(size.width * 0.8397129, 0);
    path_11.lineTo(size.width * 0.8397129, size.height * 0.3500000);
    path_11.close();
    path_11.moveTo(size.width * 0.1730469, size.height * 0.3166660);
    path_11.lineTo(size.width * 0.8063809, size.height * 0.3166660);
    path_11.lineTo(size.width * 0.8063809, size.height * 0.03333398);
    path_11.lineTo(size.width * 0.1730469, size.height * 0.03333398);
    path_11.lineTo(size.width * 0.1730469, size.height * 0.3166660);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
