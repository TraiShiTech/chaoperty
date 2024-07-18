import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop9 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop9(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2230469, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.2230469,
        size.height * 0.9769531,
        size.width * 0.2297129,
        size.height * 0.9686211,
        size.width * 0.2397129,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.2497129,
        size.height * 0.9686211,
        size.width * 0.2563789,
        size.height * 0.9769551,
        size.width * 0.2563789,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.2563789,
        size.height * 0.9936211,
        size.width * 0.2497129,
        size.height * 1.001953,
        size.width * 0.2397129,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.2297129,
        size.height * 1.001953,
        size.width * 0.2230469,
        size.height * 0.9936191,
        size.width * 0.2230469,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.2897129, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.2897129,
        size.height * 0.9769531,
        size.width * 0.2963789,
        size.height * 0.9686211,
        size.width * 0.3063789,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.3163789,
        size.height * 0.9686211,
        size.width * 0.3230449,
        size.height * 0.9769551,
        size.width * 0.3230449,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.3230449,
        size.height * 0.9936211,
        size.width * 0.3163789,
        size.height * 1.001953,
        size.width * 0.3063789,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.2963809,
        size.height * 1.001953,
        size.width * 0.2897129,
        size.height * 0.9936191,
        size.width * 0.2897129,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.3563809, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.3563809,
        size.height * 0.9769531,
        size.width * 0.3630469,
        size.height * 0.9686211,
        size.width * 0.3730469,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.3830469,
        size.height * 0.9686211,
        size.width * 0.3897129,
        size.height * 0.9769551,
        size.width * 0.3897129,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.3897129,
        size.height * 0.9936211,
        size.width * 0.3830469,
        size.height * 1.001953,
        size.width * 0.3730469,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.3630469,
        size.height * 1.001953,
        size.width * 0.3563809,
        size.height * 0.9936191,
        size.width * 0.3563809,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.4230469, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.4230469,
        size.height * 0.9769531,
        size.width * 0.4313809,
        size.height * 0.9686211,
        size.width * 0.4397129,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.4480449,
        size.height * 0.9686211,
        size.width * 0.4563789,
        size.height * 0.9769551,
        size.width * 0.4563789,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.4563789,
        size.height * 0.9936211,
        size.width * 0.4480449,
        size.height * 1.001953,
        size.width * 0.4397129,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.4313809,
        size.height * 1.001953,
        size.width * 0.4230469,
        size.height * 0.9936191,
        size.width * 0.4230469,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.4897129, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.4897129,
        size.height * 0.9769531,
        size.width * 0.4980469,
        size.height * 0.9686211,
        size.width * 0.5063789,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.5147129,
        size.height * 0.9686211,
        size.width * 0.5230449,
        size.height * 0.9769551,
        size.width * 0.5230449,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.5230449,
        size.height * 0.9936211,
        size.width * 0.5147109,
        size.height * 1.001953,
        size.width * 0.5063789,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.4980469,
        size.height * 1.001953,
        size.width * 0.4897129,
        size.height * 0.9936191,
        size.width * 0.4897129,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.5563809, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.5563809,
        size.height * 0.9769531,
        size.width * 0.5647148,
        size.height * 0.9686211,
        size.width * 0.5730469,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.5813789,
        size.height * 0.9686211,
        size.width * 0.5897129,
        size.height * 0.9769551,
        size.width * 0.5897129,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.5897129,
        size.height * 0.9936211,
        size.width * 0.5813789,
        size.height * 1.001953,
        size.width * 0.5730469,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.5647148,
        size.height * 1.001953,
        size.width * 0.5563809,
        size.height * 0.9936191,
        size.width * 0.5563809,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.6230469, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.6230469,
        size.height * 0.9769531,
        size.width * 0.6313809,
        size.height * 0.9686211,
        size.width * 0.6397129,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.6480449,
        size.height * 0.9686211,
        size.width * 0.6563789,
        size.height * 0.9769551,
        size.width * 0.6563789,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.6563789,
        size.height * 0.9936211,
        size.width * 0.6480449,
        size.height * 1.001953,
        size.width * 0.6397129,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.6313809,
        size.height * 1.001953,
        size.width * 0.6230469,
        size.height * 0.9936191,
        size.width * 0.6230469,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.6897129, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.6897129,
        size.height * 0.9769531,
        size.width * 0.6980469,
        size.height * 0.9686211,
        size.width * 0.7063789,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.7147109,
        size.height * 0.9686211,
        size.width * 0.7230449,
        size.height * 0.9769551,
        size.width * 0.7230449,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.7230449,
        size.height * 0.9936211,
        size.width * 0.7147109,
        size.height * 1.001953,
        size.width * 0.7063789,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.6980469,
        size.height * 1.001953,
        size.width * 0.6897129,
        size.height * 0.9936191,
        size.width * 0.6897129,
        size.height * 0.9852871);
    path_0.moveTo(size.width * 0.7563809, size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.7563809,
        size.height * 0.9769531,
        size.width * 0.7647148,
        size.height * 0.9686211,
        size.width * 0.7730469,
        size.height * 0.9686211);
    path_0.cubicTo(
        size.width * 0.7813789,
        size.height * 0.9686211,
        size.width * 0.7897129,
        size.height * 0.9769551,
        size.width * 0.7897129,
        size.height * 0.9852871);
    path_0.cubicTo(
        size.width * 0.7897129,
        size.height * 0.9936211,
        size.width * 0.7813789,
        size.height * 1.001953,
        size.width * 0.7730469,
        size.height * 1.001953);
    path_0.cubicTo(
        size.width * 0.7647148,
        size.height * 1.001953,
        size.width * 0.7563809,
        size.height * 0.9936191,
        size.width * 0.7563809,
        size.height * 0.9852871);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1730469, size.height * 1.001953);
    path_1.cubicTo(
        size.width * 0.1680469,
        size.height * 1.001953,
        size.width * 0.1647129,
        size.height * 1.000287,
        size.width * 0.1613809,
        size.height * 0.9969531);
    path_1.cubicTo(
        size.width * 0.1580469,
        size.height * 0.9936191,
        size.width * 0.1563809,
        size.height * 0.9902871,
        size.width * 0.1563809,
        size.height * 0.9852871);
    path_1.cubicTo(
        size.width * 0.1563809,
        size.height * 0.9802871,
        size.width * 0.1580469,
        size.height * 0.9769531,
        size.width * 0.1613809,
        size.height * 0.9736211);
    path_1.cubicTo(
        size.width * 0.1680469,
        size.height * 0.9669551,
        size.width * 0.1780469,
        size.height * 0.9669551,
        size.width * 0.1847148,
        size.height * 0.9736211);
    path_1.cubicTo(
        size.width * 0.1880488,
        size.height * 0.9769551,
        size.width * 0.1897148,
        size.height * 0.9802871,
        size.width * 0.1897148,
        size.height * 0.9852871);
    path_1.cubicTo(
        size.width * 0.1897148,
        size.height * 0.9902871,
        size.width * 0.1880488,
        size.height * 0.9936211,
        size.width * 0.1847148,
        size.height * 0.9969531);
    path_1.cubicTo(
        size.width * 0.1813809,
        size.height * 1.000287,
        size.width * 0.1780469,
        size.height * 1.001953,
        size.width * 0.1730469,
        size.height * 1.001953);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1563809, size.height * 0.08361914);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.07361914,
        size.width * 0.1630469,
        size.height * 0.06695313,
        size.width * 0.1730469,
        size.height * 0.06695313);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.06695313,
        size.width * 0.1897129,
        size.height * 0.07361914,
        size.width * 0.1897129,
        size.height * 0.08361914);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.09195313,
        size.width * 0.1813789,
        size.height * 0.1002852,
        size.width * 0.1730469,
        size.height * 0.1002852);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.1002871,
        size.width * 0.1563809,
        size.height * 0.09195312,
        size.width * 0.1563809,
        size.height * 0.08361914);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.1469531);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.1369531,
        size.width * 0.1630469,
        size.height * 0.1302871,
        size.width * 0.1730469,
        size.height * 0.1302871);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.1302871,
        size.width * 0.1897129,
        size.height * 0.1369531,
        size.width * 0.1897129,
        size.height * 0.1469531);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.1569531,
        size.width * 0.1813789,
        size.height * 0.1636191,
        size.width * 0.1730469,
        size.height * 0.1636191);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.1636191,
        size.width * 0.1563809,
        size.height * 0.1569531,
        size.width * 0.1563809,
        size.height * 0.1469531);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.2119531);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.2036191,
        size.width * 0.1630469,
        size.height * 0.1952871,
        size.width * 0.1730469,
        size.height * 0.1952871);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.1952871,
        size.width * 0.1897129,
        size.height * 0.2036211,
        size.width * 0.1897129,
        size.height * 0.2119531);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.2219531,
        size.width * 0.1813789,
        size.height * 0.2286191,
        size.width * 0.1730469,
        size.height * 0.2286191);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.2286191,
        size.width * 0.1563809,
        size.height * 0.2202871,
        size.width * 0.1563809,
        size.height * 0.2119531);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.2769531);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.2669531,
        size.width * 0.1630469,
        size.height * 0.2602871,
        size.width * 0.1730469,
        size.height * 0.2602871);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.2602871,
        size.width * 0.1897129,
        size.height * 0.2669531,
        size.width * 0.1897129,
        size.height * 0.2769531);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.2869531,
        size.width * 0.1813789,
        size.height * 0.2936191,
        size.width * 0.1730469,
        size.height * 0.2936191);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.2936191,
        size.width * 0.1563809,
        size.height * 0.2852871,
        size.width * 0.1563809,
        size.height * 0.2769531);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.3402871);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.3302871,
        size.width * 0.1630469,
        size.height * 0.3236211,
        size.width * 0.1730469,
        size.height * 0.3236211);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.3236211,
        size.width * 0.1897129,
        size.height * 0.3302871,
        size.width * 0.1897129,
        size.height * 0.3402871);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.3502871,
        size.width * 0.1813789,
        size.height * 0.3569531,
        size.width * 0.1730469,
        size.height * 0.3569531);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.3569531,
        size.width * 0.1563809,
        size.height * 0.3502871,
        size.width * 0.1563809,
        size.height * 0.3402871);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.4052871);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.3969531,
        size.width * 0.1630469,
        size.height * 0.3886211,
        size.width * 0.1730469,
        size.height * 0.3886211);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.3886211,
        size.width * 0.1897129,
        size.height * 0.3969551,
        size.width * 0.1897129,
        size.height * 0.4052871);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.4152871,
        size.width * 0.1813789,
        size.height * 0.4219531,
        size.width * 0.1730469,
        size.height * 0.4219531);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.4219531,
        size.width * 0.1563809,
        size.height * 0.4136191,
        size.width * 0.1563809,
        size.height * 0.4052871);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.4702871);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.4602871,
        size.width * 0.1630469,
        size.height * 0.4536211,
        size.width * 0.1730469,
        size.height * 0.4536211);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.4536211,
        size.width * 0.1897129,
        size.height * 0.4602871,
        size.width * 0.1897129,
        size.height * 0.4702871);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.4786211,
        size.width * 0.1813789,
        size.height * 0.4869531,
        size.width * 0.1730469,
        size.height * 0.4869531);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.4869531,
        size.width * 0.1563809,
        size.height * 0.4786191,
        size.width * 0.1563809,
        size.height * 0.4702871);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.5336191);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.5252852,
        size.width * 0.1630469,
        size.height * 0.5169531,
        size.width * 0.1730469,
        size.height * 0.5169531);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.5169531,
        size.width * 0.1897129,
        size.height * 0.5236191,
        size.width * 0.1897129,
        size.height * 0.5336191);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.5436191,
        size.width * 0.1813789,
        size.height * 0.5502852,
        size.width * 0.1730469,
        size.height * 0.5502852);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.5502871,
        size.width * 0.1563809,
        size.height * 0.5436191,
        size.width * 0.1563809,
        size.height * 0.5336191);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.5986191);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.5886191,
        size.width * 0.1630469,
        size.height * 0.5819531,
        size.width * 0.1730469,
        size.height * 0.5819531);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.5819531,
        size.width * 0.1897129,
        size.height * 0.5886191,
        size.width * 0.1897129,
        size.height * 0.5986191);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.6069531,
        size.width * 0.1813789,
        size.height * 0.6152852,
        size.width * 0.1730469,
        size.height * 0.6152852);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.6152871,
        size.width * 0.1563809,
        size.height * 0.6069531,
        size.width * 0.1563809,
        size.height * 0.5986191);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.6636191);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.6536191,
        size.width * 0.1630469,
        size.height * 0.6469531,
        size.width * 0.1730469,
        size.height * 0.6469531);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.6469531,
        size.width * 0.1897129,
        size.height * 0.6536191,
        size.width * 0.1897129,
        size.height * 0.6636191);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.6719531,
        size.width * 0.1813789,
        size.height * 0.6802852,
        size.width * 0.1730469,
        size.height * 0.6802852);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.6802871,
        size.width * 0.1563809,
        size.height * 0.6719531,
        size.width * 0.1563809,
        size.height * 0.6636191);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.7269531);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.7186191,
        size.width * 0.1630469,
        size.height * 0.7102871,
        size.width * 0.1730469,
        size.height * 0.7102871);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.7102871,
        size.width * 0.1897129,
        size.height * 0.7186211,
        size.width * 0.1897129,
        size.height * 0.7269531);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.7369531,
        size.width * 0.1813789,
        size.height * 0.7436191,
        size.width * 0.1730469,
        size.height * 0.7436191);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7436191,
        size.width * 0.1563809,
        size.height * 0.7369531,
        size.width * 0.1563809,
        size.height * 0.7269531);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.7919531);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.7836191,
        size.width * 0.1630469,
        size.height * 0.7752871,
        size.width * 0.1730469,
        size.height * 0.7752871);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.7752871,
        size.width * 0.1897129,
        size.height * 0.7836211,
        size.width * 0.1897129,
        size.height * 0.7919531);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.8002852,
        size.width * 0.1813789,
        size.height * 0.8086191,
        size.width * 0.1730469,
        size.height * 0.8086191);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.8086191,
        size.width * 0.1563809,
        size.height * 0.8002871,
        size.width * 0.1563809,
        size.height * 0.7919531);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.8569531);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.8469531,
        size.width * 0.1630469,
        size.height * 0.8402871,
        size.width * 0.1730469,
        size.height * 0.8402871);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.8402871,
        size.width * 0.1897129,
        size.height * 0.8469531,
        size.width * 0.1897129,
        size.height * 0.8569531);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.8669531,
        size.width * 0.1813789,
        size.height * 0.8736191,
        size.width * 0.1730469,
        size.height * 0.8736191);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.8736191,
        size.width * 0.1563809,
        size.height * 0.8652871,
        size.width * 0.1563809,
        size.height * 0.8569531);
    path_2.moveTo(size.width * 0.1563809, size.height * 0.9202871);
    path_2.cubicTo(
        size.width * 0.1563809,
        size.height * 0.9119531,
        size.width * 0.1630469,
        size.height * 0.9036211,
        size.width * 0.1730469,
        size.height * 0.9036211);
    path_2.cubicTo(
        size.width * 0.1830469,
        size.height * 0.9036211,
        size.width * 0.1897129,
        size.height * 0.9119551,
        size.width * 0.1897129,
        size.height * 0.9202871);
    path_2.cubicTo(
        size.width * 0.1897129,
        size.height * 0.9302871,
        size.width * 0.1813789,
        size.height * 0.9369531,
        size.width * 0.1730469,
        size.height * 0.9369531);
    path_2.cubicTo(
        size.width * 0.1647129,
        size.height * 0.9369531,
        size.width * 0.1563809,
        size.height * 0.9302871,
        size.width * 0.1563809,
        size.height * 0.9202871);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1730469, size.height * 0.03528711);
    path_3.cubicTo(
        size.width * 0.1680469,
        size.height * 0.03528711,
        size.width * 0.1647129,
        size.height * 0.03362109,
        size.width * 0.1613809,
        size.height * 0.03028711);
    path_3.cubicTo(
        size.width * 0.1580488,
        size.height * 0.02695313,
        size.width * 0.1563809,
        size.height * 0.02362109,
        size.width * 0.1563809,
        size.height * 0.01862109);
    path_3.cubicTo(
        size.width * 0.1563809,
        size.height * 0.01362109,
        size.width * 0.1580469,
        size.height * 0.01028711,
        size.width * 0.1613809,
        size.height * 0.006955078);
    path_3.cubicTo(
        size.width * 0.1680469,
        size.height * 0.0002890625,
        size.width * 0.1780469,
        size.height * 0.0002890625,
        size.width * 0.1847148,
        size.height * 0.006955078);
    path_3.cubicTo(
        size.width * 0.1880488,
        size.height * 0.01028906,
        size.width * 0.1897148,
        size.height * 0.01362109,
        size.width * 0.1897148,
        size.height * 0.01862109);
    path_3.cubicTo(
        size.width * 0.1897148,
        size.height * 0.02362109,
        size.width * 0.1880488,
        size.height * 0.02695508,
        size.width * 0.1847148,
        size.height * 0.03028711);
    path_3.cubicTo(
        size.width * 0.1813809,
        size.height * 0.03361914,
        size.width * 0.1780469,
        size.height * 0.03528711,
        size.width * 0.1730469,
        size.height * 0.03528711);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.2230469, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.2230469,
        size.height * 0.01028516,
        size.width * 0.2297129,
        size.height * 0.001953125,
        size.width * 0.2397129,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.2497129,
        size.height * 0.001953125,
        size.width * 0.2563789,
        size.height * 0.008619141,
        size.width * 0.2563789,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.2563789,
        size.height * 0.02861914,
        size.width * 0.2497129,
        size.height * 0.03528516,
        size.width * 0.2397129,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.2297129,
        size.height * 0.03528711,
        size.width * 0.2230469,
        size.height * 0.02695313,
        size.width * 0.2230469,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.2897129, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.2897129,
        size.height * 0.01028516,
        size.width * 0.2963789,
        size.height * 0.001953125,
        size.width * 0.3063789,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.3163789,
        size.height * 0.001953125,
        size.width * 0.3230449,
        size.height * 0.008619141,
        size.width * 0.3230449,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.3230449,
        size.height * 0.02861914,
        size.width * 0.3163789,
        size.height * 0.03528516,
        size.width * 0.3063789,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.2963809,
        size.height * 0.03528711,
        size.width * 0.2897129,
        size.height * 0.02695313,
        size.width * 0.2897129,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.3563809, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.3563809,
        size.height * 0.01028711,
        size.width * 0.3630469,
        size.height * 0.001953125,
        size.width * 0.3730469,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.3830469,
        size.height * 0.001953125,
        size.width * 0.3897129,
        size.height * 0.008619141,
        size.width * 0.3897129,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.3897129,
        size.height * 0.02861914,
        size.width * 0.3830469,
        size.height * 0.03528516,
        size.width * 0.3730469,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.3630469,
        size.height * 0.03528711,
        size.width * 0.3563809,
        size.height * 0.02695313,
        size.width * 0.3563809,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.4230469, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.4230469,
        size.height * 0.01028516,
        size.width * 0.4313809,
        size.height * 0.001953125,
        size.width * 0.4397129,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.4480449,
        size.height * 0.001953125,
        size.width * 0.4563789,
        size.height * 0.008619141,
        size.width * 0.4563789,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.4563789,
        size.height * 0.02861914,
        size.width * 0.4480449,
        size.height * 0.03528516,
        size.width * 0.4397129,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.4313809,
        size.height * 0.03528516,
        size.width * 0.4230469,
        size.height * 0.02695313,
        size.width * 0.4230469,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.4897129, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.4897129,
        size.height * 0.01028711,
        size.width * 0.4980469,
        size.height * 0.001953125,
        size.width * 0.5063809,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.5147148,
        size.height * 0.001953125,
        size.width * 0.5230469,
        size.height * 0.008619141,
        size.width * 0.5230469,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.5230469,
        size.height * 0.02861914,
        size.width * 0.5147129,
        size.height * 0.03528516,
        size.width * 0.5063809,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.4980469,
        size.height * 0.03528711,
        size.width * 0.4897129,
        size.height * 0.02695313,
        size.width * 0.4897129,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.5563809, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.5563809,
        size.height * 0.01028516,
        size.width * 0.5647148,
        size.height * 0.001953125,
        size.width * 0.5730469,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.5813789,
        size.height * 0.001953125,
        size.width * 0.5897129,
        size.height * 0.008619141,
        size.width * 0.5897129,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.5897129,
        size.height * 0.02861914,
        size.width * 0.5813789,
        size.height * 0.03528516,
        size.width * 0.5730469,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.5647148,
        size.height * 0.03528516,
        size.width * 0.5563809,
        size.height * 0.02695313,
        size.width * 0.5563809,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.6230469, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.6230469,
        size.height * 0.01028711,
        size.width * 0.6313809,
        size.height * 0.001953125,
        size.width * 0.6397129,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.6480449,
        size.height * 0.001953125,
        size.width * 0.6563789,
        size.height * 0.008619141,
        size.width * 0.6563789,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.6563789,
        size.height * 0.02861914,
        size.width * 0.6480449,
        size.height * 0.03528516,
        size.width * 0.6397129,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.6313809,
        size.height * 0.03528516,
        size.width * 0.6230469,
        size.height * 0.02695313,
        size.width * 0.6230469,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.6897129, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.6897129,
        size.height * 0.01028516,
        size.width * 0.6980469,
        size.height * 0.001953125,
        size.width * 0.7063789,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.7147109,
        size.height * 0.001953125,
        size.width * 0.7230449,
        size.height * 0.008619141,
        size.width * 0.7230449,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.7230449,
        size.height * 0.02861914,
        size.width * 0.7147109,
        size.height * 0.03528516,
        size.width * 0.7063789,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.6980469,
        size.height * 0.03528516,
        size.width * 0.6897129,
        size.height * 0.02695313,
        size.width * 0.6897129,
        size.height * 0.01861914);
    path_4.moveTo(size.width * 0.7563809, size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.7563809,
        size.height * 0.01028516,
        size.width * 0.7647148,
        size.height * 0.001953125,
        size.width * 0.7730469,
        size.height * 0.001953125);
    path_4.cubicTo(
        size.width * 0.7813789,
        size.height * 0.001953125,
        size.width * 0.7897129,
        size.height * 0.008619141,
        size.width * 0.7897129,
        size.height * 0.01861914);
    path_4.cubicTo(
        size.width * 0.7897129,
        size.height * 0.02861914,
        size.width * 0.7813789,
        size.height * 0.03528516,
        size.width * 0.7730469,
        size.height * 0.03528516);
    path_4.cubicTo(
        size.width * 0.7647148,
        size.height * 0.03528516,
        size.width * 0.7563809,
        size.height * 0.02695313,
        size.width * 0.7563809,
        size.height * 0.01861914);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.8397129, size.height * 0.03528711);
    path_5.cubicTo(
        size.width * 0.8347129,
        size.height * 0.03528711,
        size.width * 0.8313789,
        size.height * 0.03362109,
        size.width * 0.8280469,
        size.height * 0.03028711);
    path_5.cubicTo(
        size.width * 0.8247148,
        size.height * 0.02695313,
        size.width * 0.8230469,
        size.height * 0.02362109,
        size.width * 0.8230469,
        size.height * 0.01862109);
    path_5.cubicTo(
        size.width * 0.8230469,
        size.height * 0.01362109,
        size.width * 0.8247129,
        size.height * 0.01028711,
        size.width * 0.8280469,
        size.height * 0.006955078);
    path_5.cubicTo(
        size.width * 0.8347129,
        size.height * 0.0002890625,
        size.width * 0.8447129,
        size.height * 0.0002890625,
        size.width * 0.8513809,
        size.height * 0.006955078);
    path_5.cubicTo(
        size.width * 0.8547148,
        size.height * 0.01028906,
        size.width * 0.8563809,
        size.height * 0.01362109,
        size.width * 0.8563809,
        size.height * 0.01862109);
    path_5.cubicTo(
        size.width * 0.8563809,
        size.height * 0.02362109,
        size.width * 0.8547148,
        size.height * 0.02695508,
        size.width * 0.8513809,
        size.height * 0.03028711);
    path_5.cubicTo(
        size.width * 0.8480469,
        size.height * 0.03361914,
        size.width * 0.8447129,
        size.height * 0.03528711,
        size.width * 0.8397129,
        size.height * 0.03528711);

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.8230469, size.height * 0.08361914);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.07361914,
        size.width * 0.8313809,
        size.height * 0.06695313,
        size.width * 0.8397129,
        size.height * 0.06695313);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.06695313,
        size.width * 0.8563789,
        size.height * 0.07361914,
        size.width * 0.8563789,
        size.height * 0.08361914);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.09195313,
        size.width * 0.8480449,
        size.height * 0.1002852,
        size.width * 0.8397129,
        size.height * 0.1002852);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.1002852,
        size.width * 0.8230469,
        size.height * 0.09195312,
        size.width * 0.8230469,
        size.height * 0.08361914);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.1469531);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.1369531,
        size.width * 0.8313809,
        size.height * 0.1302871,
        size.width * 0.8397129,
        size.height * 0.1302871);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.1302871,
        size.width * 0.8563789,
        size.height * 0.1369531,
        size.width * 0.8563789,
        size.height * 0.1469531);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.1569531,
        size.width * 0.8480449,
        size.height * 0.1636191,
        size.width * 0.8397129,
        size.height * 0.1636191);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.1636191,
        size.width * 0.8230469,
        size.height * 0.1569531,
        size.width * 0.8230469,
        size.height * 0.1469531);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.2119531);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.2036191,
        size.width * 0.8313809,
        size.height * 0.1952871,
        size.width * 0.8397129,
        size.height * 0.1952871);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.1952871,
        size.width * 0.8563789,
        size.height * 0.2036211,
        size.width * 0.8563789,
        size.height * 0.2119531);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.2219531,
        size.width * 0.8480449,
        size.height * 0.2286191,
        size.width * 0.8397129,
        size.height * 0.2286191);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2286191,
        size.width * 0.8230469,
        size.height * 0.2202871,
        size.width * 0.8230469,
        size.height * 0.2119531);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.2769531);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.2669531,
        size.width * 0.8313809,
        size.height * 0.2602871,
        size.width * 0.8397129,
        size.height * 0.2602871);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.2602871,
        size.width * 0.8563789,
        size.height * 0.2669531,
        size.width * 0.8563789,
        size.height * 0.2769531);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.2869531,
        size.width * 0.8480449,
        size.height * 0.2936191,
        size.width * 0.8397129,
        size.height * 0.2936191);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2936191,
        size.width * 0.8230469,
        size.height * 0.2852871,
        size.width * 0.8230469,
        size.height * 0.2769531);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.3402871);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.3302871,
        size.width * 0.8313809,
        size.height * 0.3236211,
        size.width * 0.8397129,
        size.height * 0.3236211);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.3236211,
        size.width * 0.8563789,
        size.height * 0.3302871,
        size.width * 0.8563789,
        size.height * 0.3402871);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.3502871,
        size.width * 0.8480449,
        size.height * 0.3569531,
        size.width * 0.8397129,
        size.height * 0.3569531);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3569531,
        size.width * 0.8230469,
        size.height * 0.3502871,
        size.width * 0.8230469,
        size.height * 0.3402871);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.4052871);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.3969531,
        size.width * 0.8313809,
        size.height * 0.3886211,
        size.width * 0.8397129,
        size.height * 0.3886211);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.3886211,
        size.width * 0.8563789,
        size.height * 0.3969551,
        size.width * 0.8563789,
        size.height * 0.4052871);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.4152871,
        size.width * 0.8480449,
        size.height * 0.4219531,
        size.width * 0.8397129,
        size.height * 0.4219531);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.4219531,
        size.width * 0.8230469,
        size.height * 0.4136191,
        size.width * 0.8230469,
        size.height * 0.4052871);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.4702871);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.4602871,
        size.width * 0.8313809,
        size.height * 0.4536211,
        size.width * 0.8397129,
        size.height * 0.4536211);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.4536211,
        size.width * 0.8563789,
        size.height * 0.4602871,
        size.width * 0.8563789,
        size.height * 0.4702871);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.4786211,
        size.width * 0.8480449,
        size.height * 0.4869531,
        size.width * 0.8397129,
        size.height * 0.4869531);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.4869531,
        size.width * 0.8230469,
        size.height * 0.4786191,
        size.width * 0.8230469,
        size.height * 0.4702871);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.5336191);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.5252852,
        size.width * 0.8313809,
        size.height * 0.5169531,
        size.width * 0.8397129,
        size.height * 0.5169531);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.5169531,
        size.width * 0.8563789,
        size.height * 0.5236191,
        size.width * 0.8563789,
        size.height * 0.5336191);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.5436191,
        size.width * 0.8480449,
        size.height * 0.5502852,
        size.width * 0.8397129,
        size.height * 0.5502852);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.5502852,
        size.width * 0.8230469,
        size.height * 0.5436191,
        size.width * 0.8230469,
        size.height * 0.5336191);
    path_6.moveTo(size.width * 0.8230469, size.height * 0.5986191);
    path_6.cubicTo(
        size.width * 0.8230469,
        size.height * 0.5886191,
        size.width * 0.8313809,
        size.height * 0.5819531,
        size.width * 0.8397129,
        size.height * 0.5819531);
    path_6.cubicTo(
        size.width * 0.8480449,
        size.height * 0.5819531,
        size.width * 0.8563789,
        size.height * 0.5886191,
        size.width * 0.8563789,
        size.height * 0.5986191);
    path_6.cubicTo(
        size.width * 0.8563789,
        size.height * 0.6069531,
        size.width * 0.8480449,
        size.height * 0.6152852,
        size.width * 0.8397129,
        size.height * 0.6152852);
    path_6.cubicTo(
        size.width * 0.8313809,
        size.height * 0.6152852,
        size.width * 0.8230469,
        size.height * 0.6069531,
        size.width * 0.8230469,
        size.height * 0.5986191);

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.1563809, size.height * 0.9852871);
    path_7.lineTo(size.width * 0.8230469, size.height * 0.9852871);
    path_7.lineTo(size.width * 0.8230469, size.height * 0.6686191);
    path_7.lineTo(size.width * 0.1563809, size.height * 0.6686191);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.8397129, size.height * 1.001953);
    path_8.lineTo(size.width * 0.1397129, size.height * 1.001953);
    path_8.lineTo(size.width * 0.1397129, size.height * 0.6519531);
    path_8.lineTo(size.width * 0.8397129, size.height * 0.6519531);
    path_8.lineTo(size.width * 0.8397129, size.height * 1.001953);
    path_8.close();
    path_8.moveTo(size.width * 0.1730469, size.height * 0.9686191);
    path_8.lineTo(size.width * 0.8063809, size.height * 0.9686191);
    path_8.lineTo(size.width * 0.8063809, size.height * 0.6852871);
    path_8.lineTo(size.width * 0.1730469, size.height * 0.6852871);
    path_8.lineTo(size.width * 0.1730469, size.height * 0.9686191);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.7397129, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.7397129,
        size.height * 0.9769531,
        size.width * 0.7480469,
        size.height * 0.9686211,
        size.width * 0.7563789,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.7563789, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.7647129,
        size.height * 0.9686211,
        size.width * 0.7730449,
        size.height * 0.9769551,
        size.width * 0.7730449,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.7730449, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.7730449,
        size.height * 0.9936211,
        size.width * 0.7647109,
        size.height * 1.001953,
        size.width * 0.7563789,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.7563789, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.7480469,
        size.height * 1.001953,
        size.width * 0.7397129,
        size.height * 0.9936191,
        size.width * 0.7397129,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.6730469, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.6730469,
        size.height * 0.9769531,
        size.width * 0.6813809,
        size.height * 0.9686211,
        size.width * 0.6897129,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.6897129, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.6980469,
        size.height * 0.9686211,
        size.width * 0.7063789,
        size.height * 0.9769551,
        size.width * 0.7063789,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.7063789, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.7063789,
        size.height * 0.9936211,
        size.width * 0.6980449,
        size.height * 1.001953,
        size.width * 0.6897129,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.6897129, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.6813809,
        size.height * 1.001953,
        size.width * 0.6730469,
        size.height * 0.9936191,
        size.width * 0.6730469,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.6063809, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.6063809,
        size.height * 0.9769531,
        size.width * 0.6147148,
        size.height * 0.9686211,
        size.width * 0.6230469,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.6230469, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.6313809,
        size.height * 0.9686211,
        size.width * 0.6397129,
        size.height * 0.9769551,
        size.width * 0.6397129,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.6397129, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.6397129,
        size.height * 0.9936211,
        size.width * 0.6313789,
        size.height * 1.001953,
        size.width * 0.6230469,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.6230469, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.6147129,
        size.height * 1.001953,
        size.width * 0.6063809,
        size.height * 0.9936191,
        size.width * 0.6063809,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.5397129, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.5397129,
        size.height * 0.9769531,
        size.width * 0.5480469,
        size.height * 0.9686211,
        size.width * 0.5563789,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.5563789, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.5647129,
        size.height * 0.9686211,
        size.width * 0.5730449,
        size.height * 0.9769551,
        size.width * 0.5730449,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.5730449, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.5730449,
        size.height * 0.9936211,
        size.width * 0.5647109,
        size.height * 1.001953,
        size.width * 0.5563789,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.5563789, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.5480469,
        size.height * 1.001953,
        size.width * 0.5397129,
        size.height * 0.9936191,
        size.width * 0.5397129,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.4730469, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.4730469,
        size.height * 0.9769531,
        size.width * 0.4797129,
        size.height * 0.9686211,
        size.width * 0.4897129,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.4897129, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.4980469,
        size.height * 0.9686211,
        size.width * 0.5063789,
        size.height * 0.9769551,
        size.width * 0.5063789,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.5063789, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.5063789,
        size.height * 0.9936211,
        size.width * 0.4980449,
        size.height * 1.001953,
        size.width * 0.4897129,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.4897129, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.4797129,
        size.height * 1.001953,
        size.width * 0.4730469,
        size.height * 0.9936191,
        size.width * 0.4730469,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.4063809, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.4063809,
        size.height * 0.9769531,
        size.width * 0.4130469,
        size.height * 0.9686211,
        size.width * 0.4230469,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.4230469, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.4313809,
        size.height * 0.9686211,
        size.width * 0.4397129,
        size.height * 0.9769551,
        size.width * 0.4397129,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.4397129, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.4397129,
        size.height * 0.9936211,
        size.width * 0.4313789,
        size.height * 1.001953,
        size.width * 0.4230469,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.4230469, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.4130469,
        size.height * 1.001953,
        size.width * 0.4063809,
        size.height * 0.9936191,
        size.width * 0.4063809,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.3397129, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.3397129,
        size.height * 0.9769531,
        size.width * 0.3463789,
        size.height * 0.9686211,
        size.width * 0.3563789,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.3563789, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.3647129,
        size.height * 0.9686211,
        size.width * 0.3730449,
        size.height * 0.9769551,
        size.width * 0.3730449,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.3730449, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.3730449,
        size.height * 0.9936211,
        size.width * 0.3647109,
        size.height * 1.001953,
        size.width * 0.3563789,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.3563789, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.3463809,
        size.height * 1.001953,
        size.width * 0.3397129,
        size.height * 0.9936191,
        size.width * 0.3397129,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.2730469, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.2730469,
        size.height * 0.9769531,
        size.width * 0.2797129,
        size.height * 0.9686211,
        size.width * 0.2897129,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.2897129, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.2980469,
        size.height * 0.9686211,
        size.width * 0.3063789,
        size.height * 0.9769551,
        size.width * 0.3063789,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.3063789, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.3063789,
        size.height * 0.9936211,
        size.width * 0.2980449,
        size.height * 1.001953,
        size.width * 0.2897129,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.2897129, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.2797129,
        size.height * 1.001953,
        size.width * 0.2730469,
        size.height * 0.9936191,
        size.width * 0.2730469,
        size.height * 0.9852871);
    path_9.close();
    path_9.moveTo(size.width * 0.2063809, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.2063809,
        size.height * 0.9769531,
        size.width * 0.2130469,
        size.height * 0.9686211,
        size.width * 0.2230469,
        size.height * 0.9686211);
    path_9.lineTo(size.width * 0.2230469, size.height * 0.9686211);
    path_9.cubicTo(
        size.width * 0.2313809,
        size.height * 0.9686211,
        size.width * 0.2397129,
        size.height * 0.9769551,
        size.width * 0.2397129,
        size.height * 0.9852871);
    path_9.lineTo(size.width * 0.2397129, size.height * 0.9852871);
    path_9.cubicTo(
        size.width * 0.2397129,
        size.height * 0.9936211,
        size.width * 0.2313789,
        size.height * 1.001953,
        size.width * 0.2230469,
        size.height * 1.001953);
    path_9.lineTo(size.width * 0.2230469, size.height * 1.001953);
    path_9.cubicTo(
        size.width * 0.2130469,
        size.height * 1.001953,
        size.width * 0.2063809,
        size.height * 0.9936191,
        size.width * 0.2063809,
        size.height * 0.9852871);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.9202871);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.9119531,
        size.width * 0.1463789,
        size.height * 0.9036211,
        size.width * 0.1563789,
        size.height * 0.9036211);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.9036211);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.9036211,
        size.width * 0.1730449,
        size.height * 0.9119551,
        size.width * 0.1730449,
        size.height * 0.9202871);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.9202871);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.9286211,
        size.width * 0.1647109,
        size.height * 0.9369531,
        size.width * 0.1563789,
        size.height * 0.9369531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.9369531);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.9369531,
        size.width * 0.1397129,
        size.height * 0.9302871,
        size.width * 0.1397129,
        size.height * 0.9202871);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.8569531);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.8469531,
        size.width * 0.1463789,
        size.height * 0.8402871,
        size.width * 0.1563789,
        size.height * 0.8402871);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.8402871);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.8402871,
        size.width * 0.1730449,
        size.height * 0.8469531,
        size.width * 0.1730449,
        size.height * 0.8569531);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.8569531);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.8652871,
        size.width * 0.1647109,
        size.height * 0.8736191,
        size.width * 0.1563789,
        size.height * 0.8736191);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.8736191);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.8736191,
        size.width * 0.1397129,
        size.height * 0.8652871,
        size.width * 0.1397129,
        size.height * 0.8569531);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.7919531);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.7836191,
        size.width * 0.1463789,
        size.height * 0.7752871,
        size.width * 0.1563789,
        size.height * 0.7752871);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.7752871);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7752871,
        size.width * 0.1730449,
        size.height * 0.7836211,
        size.width * 0.1730449,
        size.height * 0.7919531);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.7919531);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.8019531,
        size.width * 0.1647109,
        size.height * 0.8086191,
        size.width * 0.1563789,
        size.height * 0.8086191);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.8086191);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.8086191,
        size.width * 0.1397129,
        size.height * 0.8019531,
        size.width * 0.1397129,
        size.height * 0.7919531);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.7269531);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.7169531,
        size.width * 0.1463789,
        size.height * 0.7102871,
        size.width * 0.1563789,
        size.height * 0.7102871);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.7102871);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7102871,
        size.width * 0.1730449,
        size.height * 0.7169531,
        size.width * 0.1730449,
        size.height * 0.7269531);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.7269531);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.7352871,
        size.width * 0.1647109,
        size.height * 0.7436191,
        size.width * 0.1563789,
        size.height * 0.7436191);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.7436191);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.7436191,
        size.width * 0.1397129,
        size.height * 0.7369531,
        size.width * 0.1397129,
        size.height * 0.7269531);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.6636191);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.6536191,
        size.width * 0.1463789,
        size.height * 0.6469531,
        size.width * 0.1563789,
        size.height * 0.6469531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.6469531);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.6469531,
        size.width * 0.1730449,
        size.height * 0.6536191,
        size.width * 0.1730449,
        size.height * 0.6636191);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.6636191);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.6736191,
        size.width * 0.1647109,
        size.height * 0.6802852,
        size.width * 0.1563789,
        size.height * 0.6802852);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.6802852);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.6802871,
        size.width * 0.1397129,
        size.height * 0.6719531,
        size.width * 0.1397129,
        size.height * 0.6636191);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.5986191);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.5886191,
        size.width * 0.1463789,
        size.height * 0.5819531,
        size.width * 0.1563789,
        size.height * 0.5819531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.5819531);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.5819531,
        size.width * 0.1730449,
        size.height * 0.5886191,
        size.width * 0.1730449,
        size.height * 0.5986191);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.5986191);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.6069531,
        size.width * 0.1647109,
        size.height * 0.6152852,
        size.width * 0.1563789,
        size.height * 0.6152852);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.6152852);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.6152871,
        size.width * 0.1397129,
        size.height * 0.6069531,
        size.width * 0.1397129,
        size.height * 0.5986191);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.5336191);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.5252852,
        size.width * 0.1463789,
        size.height * 0.5169531,
        size.width * 0.1563789,
        size.height * 0.5169531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.5169531);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.5169531,
        size.width * 0.1730449,
        size.height * 0.5252871,
        size.width * 0.1730449,
        size.height * 0.5336191);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.5336191);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.5419531,
        size.width * 0.1647109,
        size.height * 0.5502852,
        size.width * 0.1563789,
        size.height * 0.5502852);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.5502852);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.5502871,
        size.width * 0.1397129,
        size.height * 0.5436191,
        size.width * 0.1397129,
        size.height * 0.5336191);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.4702871);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.4602871,
        size.width * 0.1463789,
        size.height * 0.4536211,
        size.width * 0.1563789,
        size.height * 0.4536211);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.4536211);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.4536211,
        size.width * 0.1730449,
        size.height * 0.4602871,
        size.width * 0.1730449,
        size.height * 0.4702871);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.4702871);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.4802871,
        size.width * 0.1647109,
        size.height * 0.4869531,
        size.width * 0.1563789,
        size.height * 0.4869531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.4869531);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.4869531,
        size.width * 0.1397129,
        size.height * 0.4786191,
        size.width * 0.1397129,
        size.height * 0.4702871);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.4052871);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.3952871,
        size.width * 0.1463789,
        size.height * 0.3886211,
        size.width * 0.1563789,
        size.height * 0.3886211);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.3886211);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.3886211,
        size.width * 0.1730449,
        size.height * 0.3952871,
        size.width * 0.1730449,
        size.height * 0.4052871);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.4052871);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.4152871,
        size.width * 0.1647109,
        size.height * 0.4219531,
        size.width * 0.1563789,
        size.height * 0.4219531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.4219531);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.4219531,
        size.width * 0.1397129,
        size.height * 0.4152871,
        size.width * 0.1397129,
        size.height * 0.4052871);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.3402871);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.3319531,
        size.width * 0.1463789,
        size.height * 0.3236211,
        size.width * 0.1563789,
        size.height * 0.3236211);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.3236211);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.3236211,
        size.width * 0.1730449,
        size.height * 0.3319551,
        size.width * 0.1730449,
        size.height * 0.3402871);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.3402871);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.3502871,
        size.width * 0.1647109,
        size.height * 0.3569531,
        size.width * 0.1563789,
        size.height * 0.3569531);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.3569531);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.3569531,
        size.width * 0.1397129,
        size.height * 0.3502871,
        size.width * 0.1397129,
        size.height * 0.3402871);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.2769531);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.2669531,
        size.width * 0.1463789,
        size.height * 0.2602871,
        size.width * 0.1563789,
        size.height * 0.2602871);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.2602871);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.2602871,
        size.width * 0.1730449,
        size.height * 0.2669531,
        size.width * 0.1730449,
        size.height * 0.2769531);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.2769531);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.2852871,
        size.width * 0.1647109,
        size.height * 0.2936191,
        size.width * 0.1563789,
        size.height * 0.2936191);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.2936191);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.2936191,
        size.width * 0.1397129,
        size.height * 0.2852871,
        size.width * 0.1397129,
        size.height * 0.2769531);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.2119531);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.2019531,
        size.width * 0.1463789,
        size.height * 0.1952871,
        size.width * 0.1563789,
        size.height * 0.1952871);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.1952871);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.1952871,
        size.width * 0.1730449,
        size.height * 0.2019531,
        size.width * 0.1730449,
        size.height * 0.2119531);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.2119531);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.2219531,
        size.width * 0.1647109,
        size.height * 0.2286191,
        size.width * 0.1563789,
        size.height * 0.2286191);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.2286191);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.2286191,
        size.width * 0.1397129,
        size.height * 0.2202871,
        size.width * 0.1397129,
        size.height * 0.2119531);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.1469531);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.1369531,
        size.width * 0.1463789,
        size.height * 0.1302871,
        size.width * 0.1563789,
        size.height * 0.1302871);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.1302871);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.1302871,
        size.width * 0.1730449,
        size.height * 0.1369531,
        size.width * 0.1730449,
        size.height * 0.1469531);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.1469531);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.1552871,
        size.width * 0.1647109,
        size.height * 0.1636191,
        size.width * 0.1563789,
        size.height * 0.1636191);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.1636191);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.1636191,
        size.width * 0.1397129,
        size.height * 0.1569531,
        size.width * 0.1397129,
        size.height * 0.1469531);
    path_10.close();
    path_10.moveTo(size.width * 0.1397129, size.height * 0.08361914);
    path_10.cubicTo(
        size.width * 0.1397129,
        size.height * 0.07528516,
        size.width * 0.1463789,
        size.height * 0.06695313,
        size.width * 0.1563789,
        size.height * 0.06695313);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.06695313);
    path_10.cubicTo(
        size.width * 0.1647129,
        size.height * 0.06695313,
        size.width * 0.1730449,
        size.height * 0.07528711,
        size.width * 0.1730449,
        size.height * 0.08361914);
    path_10.lineTo(size.width * 0.1730449, size.height * 0.08361914);
    path_10.cubicTo(
        size.width * 0.1730449,
        size.height * 0.09195313,
        size.width * 0.1647109,
        size.height * 0.1002852,
        size.width * 0.1563789,
        size.height * 0.1002852);
    path_10.lineTo(size.width * 0.1563789, size.height * 0.1002852);
    path_10.cubicTo(
        size.width * 0.1463809,
        size.height * 0.1002871,
        size.width * 0.1397129,
        size.height * 0.09195312,
        size.width * 0.1397129,
        size.height * 0.08361914);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.7397129, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.7397129,
        size.height * 0.008619141,
        size.width * 0.7480469,
        size.height * 0.001953125,
        size.width * 0.7563809,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.7563809, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.7647148,
        size.height * 0.001953125,
        size.width * 0.7730469,
        size.height * 0.008619141,
        size.width * 0.7730469,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.7730469, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.7730469,
        size.height * 0.02695313,
        size.width * 0.7647129,
        size.height * 0.03528516,
        size.width * 0.7563809,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.7563809, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.7480469,
        size.height * 0.03528711,
        size.width * 0.7397129,
        size.height * 0.02695313,
        size.width * 0.7397129,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.6730469, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.6730469,
        size.height * 0.008619141,
        size.width * 0.6813809,
        size.height * 0.001953125,
        size.width * 0.6897129,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.6897129, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.6980469,
        size.height * 0.001953125,
        size.width * 0.7063789,
        size.height * 0.008619141,
        size.width * 0.7063789,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.7063789, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.7063789,
        size.height * 0.02695313,
        size.width * 0.6980449,
        size.height * 0.03528516,
        size.width * 0.6897129,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.6897129, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.6813809,
        size.height * 0.03528711,
        size.width * 0.6730469,
        size.height * 0.02695313,
        size.width * 0.6730469,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.6063809, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.6063809,
        size.height * 0.008619141,
        size.width * 0.6147129,
        size.height * 0.001953125,
        size.width * 0.6230469,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.6230469, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.6313809,
        size.height * 0.001953125,
        size.width * 0.6397129,
        size.height * 0.008619141,
        size.width * 0.6397129,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.6397129, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.6397129,
        size.height * 0.02695313,
        size.width * 0.6313789,
        size.height * 0.03528516,
        size.width * 0.6230469,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.6230469, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.6147129,
        size.height * 0.03528711,
        size.width * 0.6063809,
        size.height * 0.02695313,
        size.width * 0.6063809,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.5397129, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.5397129,
        size.height * 0.008619141,
        size.width * 0.5480469,
        size.height * 0.001953125,
        size.width * 0.5563789,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.5563789, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.5647129,
        size.height * 0.001953125,
        size.width * 0.5730449,
        size.height * 0.008619141,
        size.width * 0.5730449,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.5730449, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.5730449,
        size.height * 0.02695313,
        size.width * 0.5647109,
        size.height * 0.03528516,
        size.width * 0.5563789,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.5563789, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.5480469,
        size.height * 0.03528711,
        size.width * 0.5397129,
        size.height * 0.02695313,
        size.width * 0.5397129,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.4730469, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.4730469,
        size.height * 0.008619141,
        size.width * 0.4797129,
        size.height * 0.001953125,
        size.width * 0.4897129,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.4897129, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.4980469,
        size.height * 0.001953125,
        size.width * 0.5063789,
        size.height * 0.008619141,
        size.width * 0.5063789,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.5063789, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.5063789,
        size.height * 0.02695313,
        size.width * 0.4980449,
        size.height * 0.03528516,
        size.width * 0.4897129,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.4897129, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.4797129,
        size.height * 0.03528711,
        size.width * 0.4730469,
        size.height * 0.02695313,
        size.width * 0.4730469,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.4063809, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.4063809,
        size.height * 0.008619141,
        size.width * 0.4130469,
        size.height * 0.001953125,
        size.width * 0.4230469,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.4230469, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.4313809,
        size.height * 0.001953125,
        size.width * 0.4397129,
        size.height * 0.008619141,
        size.width * 0.4397129,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.4397129, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.4397129,
        size.height * 0.02695313,
        size.width * 0.4313789,
        size.height * 0.03528516,
        size.width * 0.4230469,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.4230469, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.4130469,
        size.height * 0.03528711,
        size.width * 0.4063809,
        size.height * 0.02695313,
        size.width * 0.4063809,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.3397129, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.3397129,
        size.height * 0.008619141,
        size.width * 0.3463789,
        size.height * 0.001953125,
        size.width * 0.3563789,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.3563789, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.3647129,
        size.height * 0.001953125,
        size.width * 0.3730469,
        size.height * 0.008619141,
        size.width * 0.3730469,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.3730469, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.3730469,
        size.height * 0.02695313,
        size.width * 0.3647129,
        size.height * 0.03528516,
        size.width * 0.3563809,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.3563809, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.3463809,
        size.height * 0.03528711,
        size.width * 0.3397129,
        size.height * 0.02695313,
        size.width * 0.3397129,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.2730469, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.2730469,
        size.height * 0.008619141,
        size.width * 0.2797129,
        size.height * 0.001953125,
        size.width * 0.2897129,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.2897129, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.2980469,
        size.height * 0.001953125,
        size.width * 0.3063789,
        size.height * 0.008619141,
        size.width * 0.3063789,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.3063789, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.3063789,
        size.height * 0.02695313,
        size.width * 0.2980449,
        size.height * 0.03528516,
        size.width * 0.2897129,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.2897129, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.2797129,
        size.height * 0.03528711,
        size.width * 0.2730469,
        size.height * 0.02695313,
        size.width * 0.2730469,
        size.height * 0.01861914);
    path_11.close();
    path_11.moveTo(size.width * 0.2063809, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.2063809,
        size.height * 0.008619141,
        size.width * 0.2130469,
        size.height * 0.001953125,
        size.width * 0.2230469,
        size.height * 0.001953125);
    path_11.lineTo(size.width * 0.2230469, size.height * 0.001953125);
    path_11.cubicTo(
        size.width * 0.2313809,
        size.height * 0.001953125,
        size.width * 0.2397129,
        size.height * 0.008619141,
        size.width * 0.2397129,
        size.height * 0.01861914);
    path_11.lineTo(size.width * 0.2397129, size.height * 0.01861914);
    path_11.cubicTo(
        size.width * 0.2397129,
        size.height * 0.02695313,
        size.width * 0.2313789,
        size.height * 0.03528516,
        size.width * 0.2230469,
        size.height * 0.03528516);
    path_11.lineTo(size.width * 0.2230469, size.height * 0.03528516);
    path_11.cubicTo(
        size.width * 0.2130469,
        size.height * 0.03528711,
        size.width * 0.2063809,
        size.height * 0.02695313,
        size.width * 0.2063809,
        size.height * 0.01861914);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.9202871);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.9102871,
        size.width * 0.8147148,
        size.height * 0.9036211,
        size.width * 0.8230469,
        size.height * 0.9036211);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.9036211);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.9036211,
        size.width * 0.8397129,
        size.height * 0.9102871,
        size.width * 0.8397129,
        size.height * 0.9202871);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.9202871);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.9286211,
        size.width * 0.8313789,
        size.height * 0.9369531,
        size.width * 0.8230469,
        size.height * 0.9369531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.9369531);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.9369531,
        size.width * 0.8063809,
        size.height * 0.9302871,
        size.width * 0.8063809,
        size.height * 0.9202871);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.8569531);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.8486191,
        size.width * 0.8147148,
        size.height * 0.8402871,
        size.width * 0.8230469,
        size.height * 0.8402871);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.8402871);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.8402871,
        size.width * 0.8397129,
        size.height * 0.8486211,
        size.width * 0.8397129,
        size.height * 0.8569531);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.8569531);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.8652871,
        size.width * 0.8313789,
        size.height * 0.8736191,
        size.width * 0.8230469,
        size.height * 0.8736191);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.8736191);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.8736191,
        size.width * 0.8063809,
        size.height * 0.8652871,
        size.width * 0.8063809,
        size.height * 0.8569531);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.7919531);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.7836191,
        size.width * 0.8147148,
        size.height * 0.7752871,
        size.width * 0.8230469,
        size.height * 0.7752871);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.7752871);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7752871,
        size.width * 0.8397129,
        size.height * 0.7836211,
        size.width * 0.8397129,
        size.height * 0.7919531);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.7919531);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.8019531,
        size.width * 0.8313789,
        size.height * 0.8086191,
        size.width * 0.8230469,
        size.height * 0.8086191);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.8086191);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.8086191,
        size.width * 0.8063809,
        size.height * 0.8019531,
        size.width * 0.8063809,
        size.height * 0.7919531);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.7269531);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.7169531,
        size.width * 0.8147148,
        size.height * 0.7102871,
        size.width * 0.8230469,
        size.height * 0.7102871);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.7102871);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7102871,
        size.width * 0.8397129,
        size.height * 0.7169531,
        size.width * 0.8397129,
        size.height * 0.7269531);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.7269531);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.7369531,
        size.width * 0.8313789,
        size.height * 0.7436191,
        size.width * 0.8230469,
        size.height * 0.7436191);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.7436191);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.7436191,
        size.width * 0.8063809,
        size.height * 0.7369531,
        size.width * 0.8063809,
        size.height * 0.7269531);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.6636191);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.6536191,
        size.width * 0.8147148,
        size.height * 0.6469531,
        size.width * 0.8230469,
        size.height * 0.6469531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.6469531);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.6469531,
        size.width * 0.8397129,
        size.height * 0.6536191,
        size.width * 0.8397129,
        size.height * 0.6636191);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.6636191);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.6719531,
        size.width * 0.8313789,
        size.height * 0.6802852,
        size.width * 0.8230469,
        size.height * 0.6802852);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.6802852);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.6802871,
        size.width * 0.8063809,
        size.height * 0.6719531,
        size.width * 0.8063809,
        size.height * 0.6636191);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.5986191);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.5902852,
        size.width * 0.8147148,
        size.height * 0.5819531,
        size.width * 0.8230469,
        size.height * 0.5819531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.5819531);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.5819531,
        size.width * 0.8397129,
        size.height * 0.5902871,
        size.width * 0.8397129,
        size.height * 0.5986191);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.5986191);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.6069531,
        size.width * 0.8313789,
        size.height * 0.6152852,
        size.width * 0.8230469,
        size.height * 0.6152852);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.6152852);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.6152871,
        size.width * 0.8063809,
        size.height * 0.6069531,
        size.width * 0.8063809,
        size.height * 0.5986191);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.5336191);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.5236191,
        size.width * 0.8147148,
        size.height * 0.5169531,
        size.width * 0.8230469,
        size.height * 0.5169531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.5169531);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.5169531,
        size.width * 0.8397129,
        size.height * 0.5236191,
        size.width * 0.8397129,
        size.height * 0.5336191);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.5336191);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.5436191,
        size.width * 0.8313789,
        size.height * 0.5502852,
        size.width * 0.8230469,
        size.height * 0.5502852);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.5502852);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.5502871,
        size.width * 0.8063809,
        size.height * 0.5436191,
        size.width * 0.8063809,
        size.height * 0.5336191);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.4702871);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.4619531,
        size.width * 0.8147148,
        size.height * 0.4536211,
        size.width * 0.8230469,
        size.height * 0.4536211);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.4536211);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.4536211,
        size.width * 0.8397129,
        size.height * 0.4619551,
        size.width * 0.8397129,
        size.height * 0.4702871);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.4702871);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.4786211,
        size.width * 0.8313789,
        size.height * 0.4869531,
        size.width * 0.8230469,
        size.height * 0.4869531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.4869531);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.4869531,
        size.width * 0.8063809,
        size.height * 0.4786191,
        size.width * 0.8063809,
        size.height * 0.4702871);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.4052871);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.3969531,
        size.width * 0.8147148,
        size.height * 0.3886211,
        size.width * 0.8230469,
        size.height * 0.3886211);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.3886211);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3886211,
        size.width * 0.8397129,
        size.height * 0.3969551,
        size.width * 0.8397129,
        size.height * 0.4052871);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.4052871);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.4152871,
        size.width * 0.8313789,
        size.height * 0.4219531,
        size.width * 0.8230469,
        size.height * 0.4219531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.4219531);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.4219531,
        size.width * 0.8063809,
        size.height * 0.4152871,
        size.width * 0.8063809,
        size.height * 0.4052871);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.3402871);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.3319531,
        size.width * 0.8147148,
        size.height * 0.3236211,
        size.width * 0.8230469,
        size.height * 0.3236211);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.3236211);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3236211,
        size.width * 0.8397129,
        size.height * 0.3319551,
        size.width * 0.8397129,
        size.height * 0.3402871);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.3402871);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.3502871,
        size.width * 0.8313789,
        size.height * 0.3569531,
        size.width * 0.8230469,
        size.height * 0.3569531);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.3569531);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.3569531,
        size.width * 0.8063809,
        size.height * 0.3502871,
        size.width * 0.8063809,
        size.height * 0.3402871);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.2769531);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.2669531,
        size.width * 0.8147148,
        size.height * 0.2602871,
        size.width * 0.8230469,
        size.height * 0.2602871);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.2602871);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2602871,
        size.width * 0.8397129,
        size.height * 0.2669531,
        size.width * 0.8397129,
        size.height * 0.2769531);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.2769531);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.2869531,
        size.width * 0.8313789,
        size.height * 0.2936191,
        size.width * 0.8230469,
        size.height * 0.2936191);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.2936191);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.2936191,
        size.width * 0.8063809,
        size.height * 0.2852871,
        size.width * 0.8063809,
        size.height * 0.2769531);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.2119531);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.2036191,
        size.width * 0.8147148,
        size.height * 0.1952871,
        size.width * 0.8230469,
        size.height * 0.1952871);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.1952871);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.1952871,
        size.width * 0.8397129,
        size.height * 0.2036211,
        size.width * 0.8397129,
        size.height * 0.2119531);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.2119531);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.2219531,
        size.width * 0.8313789,
        size.height * 0.2286191,
        size.width * 0.8230469,
        size.height * 0.2286191);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.2286191);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.2286191,
        size.width * 0.8063809,
        size.height * 0.2202871,
        size.width * 0.8063809,
        size.height * 0.2119531);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.1469531);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.1369531,
        size.width * 0.8147148,
        size.height * 0.1302871,
        size.width * 0.8230469,
        size.height * 0.1302871);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.1302871);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.1302871,
        size.width * 0.8397129,
        size.height * 0.1369531,
        size.width * 0.8397129,
        size.height * 0.1469531);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.1469531);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.1569531,
        size.width * 0.8313789,
        size.height * 0.1636191,
        size.width * 0.8230469,
        size.height * 0.1636191);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.1636191);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.1636191,
        size.width * 0.8063809,
        size.height * 0.1569531,
        size.width * 0.8063809,
        size.height * 0.1469531);
    path_12.close();
    path_12.moveTo(size.width * 0.8063809, size.height * 0.08361914);
    path_12.cubicTo(
        size.width * 0.8063809,
        size.height * 0.07361914,
        size.width * 0.8147148,
        size.height * 0.06695313,
        size.width * 0.8230469,
        size.height * 0.06695313);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.06695313);
    path_12.cubicTo(
        size.width * 0.8313809,
        size.height * 0.06695313,
        size.width * 0.8397129,
        size.height * 0.07361914,
        size.width * 0.8397129,
        size.height * 0.08361914);
    path_12.lineTo(size.width * 0.8397129, size.height * 0.08361914);
    path_12.cubicTo(
        size.width * 0.8397129,
        size.height * 0.09361914,
        size.width * 0.8313789,
        size.height * 0.1002852,
        size.width * 0.8230469,
        size.height * 0.1002852);
    path_12.lineTo(size.width * 0.8230469, size.height * 0.1002852);
    path_12.cubicTo(
        size.width * 0.8147129,
        size.height * 0.1002871,
        size.width * 0.8063809,
        size.height * 0.09195312,
        size.width * 0.8063809,
        size.height * 0.08361914);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.8397129, size.height * 1.001953);
    path_13.lineTo(size.width * 0.1397129, size.height * 1.001953);
    path_13.lineTo(size.width * 0.1397129, size.height * 0.6519531);
    path_13.lineTo(size.width * 0.8397129, size.height * 0.6519531);
    path_13.lineTo(size.width * 0.8397129, size.height * 1.001953);
    path_13.close();
    path_13.moveTo(size.width * 0.1730469, size.height * 0.9686191);
    path_13.lineTo(size.width * 0.8063809, size.height * 0.9686191);
    path_13.lineTo(size.width * 0.8063809, size.height * 0.6852871);
    path_13.lineTo(size.width * 0.1730469, size.height * 0.6852871);
    path_13.lineTo(size.width * 0.1730469, size.height * 0.9686191);
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
