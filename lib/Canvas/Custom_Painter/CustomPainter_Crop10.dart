import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop10 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop10(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7813809, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.7813809,
        size.height * 0.8750000,
        size.width * 0.7897148,
        size.height * 0.8666680,
        size.width * 0.7980469,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.8063809,
        size.height * 0.8666680,
        size.width * 0.8147129,
        size.height * 0.8750020,
        size.width * 0.8147129,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.8147129, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.8147129,
        size.height * 0.8916680,
        size.width * 0.8063789,
        size.height * 0.9000000,
        size.width * 0.7980469,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.7897129,
        size.height * 0.9000000,
        size.width * 0.7813809,
        size.height * 0.8916660,
        size.width * 0.7813809,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.7147129, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.7147129,
        size.height * 0.8750000,
        size.width * 0.7230469,
        size.height * 0.8666680,
        size.width * 0.7313789,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.7313789, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.7397129,
        size.height * 0.8666680,
        size.width * 0.7480449,
        size.height * 0.8750020,
        size.width * 0.7480449,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.7480449, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.7480449,
        size.height * 0.8916680,
        size.width * 0.7397109,
        size.height * 0.9000000,
        size.width * 0.7313789,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.7313789, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.7230469,
        size.height * 0.9000000,
        size.width * 0.7147129,
        size.height * 0.8916660,
        size.width * 0.7147129,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.6480469, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.6480469,
        size.height * 0.8750000,
        size.width * 0.6563809,
        size.height * 0.8666680,
        size.width * 0.6647129,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.6647129, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.6730469,
        size.height * 0.8666680,
        size.width * 0.6813789,
        size.height * 0.8750020,
        size.width * 0.6813789,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.6813789, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.6813789,
        size.height * 0.8916680,
        size.width * 0.6730449,
        size.height * 0.9000000,
        size.width * 0.6647129,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.6647129, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.6563809,
        size.height * 0.9000000,
        size.width * 0.6480469,
        size.height * 0.8916660,
        size.width * 0.6480469,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.5813809, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.5813809,
        size.height * 0.8750000,
        size.width * 0.5897148,
        size.height * 0.8666680,
        size.width * 0.5980469,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.5980469, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.6063809,
        size.height * 0.8666680,
        size.width * 0.6147129,
        size.height * 0.8750020,
        size.width * 0.6147129,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.6147129, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.6147129,
        size.height * 0.8916680,
        size.width * 0.6063789,
        size.height * 0.9000000,
        size.width * 0.5980469,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.5980469, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.5897129,
        size.height * 0.9000000,
        size.width * 0.5813809,
        size.height * 0.8916660,
        size.width * 0.5813809,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.5147129, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.5147129,
        size.height * 0.8750000,
        size.width * 0.5230469,
        size.height * 0.8666680,
        size.width * 0.5313789,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.5313789, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.5397129,
        size.height * 0.8666680,
        size.width * 0.5480449,
        size.height * 0.8750020,
        size.width * 0.5480449,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.5480449, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.5480449,
        size.height * 0.8916680,
        size.width * 0.5397109,
        size.height * 0.9000000,
        size.width * 0.5313789,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.5313789, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.5230469,
        size.height * 0.9000000,
        size.width * 0.5147129,
        size.height * 0.8916660,
        size.width * 0.5147129,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.4480469, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.4480469,
        size.height * 0.8750000,
        size.width * 0.4547129,
        size.height * 0.8666680,
        size.width * 0.4647129,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.4647129, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.4730469,
        size.height * 0.8666680,
        size.width * 0.4813789,
        size.height * 0.8750020,
        size.width * 0.4813789,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.4813789, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.4813789,
        size.height * 0.8916680,
        size.width * 0.4730449,
        size.height * 0.9000000,
        size.width * 0.4647129,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.4647129, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.4547129,
        size.height * 0.9000000,
        size.width * 0.4480469,
        size.height * 0.8916660,
        size.width * 0.4480469,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.3813809, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.3813809,
        size.height * 0.8750000,
        size.width * 0.3880469,
        size.height * 0.8666680,
        size.width * 0.3980469,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.3980469, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.4063809,
        size.height * 0.8666680,
        size.width * 0.4147129,
        size.height * 0.8750020,
        size.width * 0.4147129,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.4147129, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.4147129,
        size.height * 0.8916680,
        size.width * 0.4063789,
        size.height * 0.9000000,
        size.width * 0.3980469,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.3980469, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.3880469,
        size.height * 0.9000000,
        size.width * 0.3813809,
        size.height * 0.8916660,
        size.width * 0.3813809,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.3147129, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.3147129,
        size.height * 0.8750000,
        size.width * 0.3213789,
        size.height * 0.8666680,
        size.width * 0.3313789,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.3313789, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.3397129,
        size.height * 0.8666680,
        size.width * 0.3480449,
        size.height * 0.8750020,
        size.width * 0.3480449,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.3480449, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.3480449,
        size.height * 0.8916680,
        size.width * 0.3397109,
        size.height * 0.9000000,
        size.width * 0.3313789,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.3313789, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.3213809,
        size.height * 0.9000000,
        size.width * 0.3147129,
        size.height * 0.8916660,
        size.width * 0.3147129,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.2480469, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.2480469,
        size.height * 0.8750000,
        size.width * 0.2547129,
        size.height * 0.8666680,
        size.width * 0.2647129,
        size.height * 0.8666680);
    path_0.lineTo(size.width * 0.2647129, size.height * 0.8666680);
    path_0.cubicTo(
        size.width * 0.2730469,
        size.height * 0.8666680,
        size.width * 0.2813789,
        size.height * 0.8750020,
        size.width * 0.2813789,
        size.height * 0.8833340);
    path_0.lineTo(size.width * 0.2813789, size.height * 0.8833340);
    path_0.cubicTo(
        size.width * 0.2813789,
        size.height * 0.8916680,
        size.width * 0.2730449,
        size.height * 0.9000000,
        size.width * 0.2647129,
        size.height * 0.9000000);
    path_0.lineTo(size.width * 0.2647129, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.2547129,
        size.height * 0.9000000,
        size.width * 0.2480469,
        size.height * 0.8916660,
        size.width * 0.2480469,
        size.height * 0.8833340);
    path_0.close();
    path_0.moveTo(size.width * 0.2147129, size.height * 0.8500000);
    path_0.cubicTo(
        size.width * 0.2147129,
        size.height * 0.8416660,
        size.width * 0.2213789,
        size.height * 0.8333340,
        size.width * 0.2313789,
        size.height * 0.8333340);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.8333340);
    path_0.cubicTo(
        size.width * 0.2397129,
        size.height * 0.8333340,
        size.width * 0.2480449,
        size.height * 0.8416680,
        size.width * 0.2480449,
        size.height * 0.8500000);
    path_0.lineTo(size.width * 0.2480449, size.height * 0.8500000);
    path_0.cubicTo(
        size.width * 0.2480449,
        size.height * 0.8583340,
        size.width * 0.2397109,
        size.height * 0.8666660,
        size.width * 0.2313789,
        size.height * 0.8666660);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.8666660);
    path_0.cubicTo(
        size.width * 0.2213809,
        size.height * 0.8666660,
        size.width * 0.2147129,
        size.height * 0.8583340,
        size.width * 0.2147129,
        size.height * 0.8500000);
    path_0.close();
    path_0.moveTo(size.width * 0.7813809, size.height * 0.8166660);
    path_0.cubicTo(
        size.width * 0.7813809,
        size.height * 0.8066660,
        size.width * 0.7897148,
        size.height * 0.8000000,
        size.width * 0.7980469,
        size.height * 0.8000000);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.8000000);
    path_0.cubicTo(
        size.width * 0.8063809,
        size.height * 0.8000000,
        size.width * 0.8147129,
        size.height * 0.8066660,
        size.width * 0.8147129,
        size.height * 0.8166660);
    path_0.lineTo(size.width * 0.8147129, size.height * 0.8166660);
    path_0.cubicTo(
        size.width * 0.8147129,
        size.height * 0.8250000,
        size.width * 0.8063789,
        size.height * 0.8333320,
        size.width * 0.7980469,
        size.height * 0.8333320);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.8333320);
    path_0.cubicTo(
        size.width * 0.7897129,
        size.height * 0.8333340,
        size.width * 0.7813809,
        size.height * 0.8250000,
        size.width * 0.7813809,
        size.height * 0.8166660);
    path_0.close();
    path_0.moveTo(size.width * 0.8147129, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.8147129,
        size.height * 0.7750000,
        size.width * 0.8230469,
        size.height * 0.7666680,
        size.width * 0.8313789,
        size.height * 0.7666680);
    path_0.lineTo(size.width * 0.8313789, size.height * 0.7666680);
    path_0.cubicTo(
        size.width * 0.8397129,
        size.height * 0.7666680,
        size.width * 0.8480449,
        size.height * 0.7750020,
        size.width * 0.8480449,
        size.height * 0.7833340);
    path_0.lineTo(size.width * 0.8480449, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.8480449,
        size.height * 0.7916680,
        size.width * 0.8397109,
        size.height * 0.8000000,
        size.width * 0.8313789,
        size.height * 0.8000000);
    path_0.lineTo(size.width * 0.8313789, size.height * 0.8000000);
    path_0.cubicTo(
        size.width * 0.8230469,
        size.height * 0.8000000,
        size.width * 0.8147129,
        size.height * 0.7916660,
        size.width * 0.8147129,
        size.height * 0.7833340);
    path_0.close();
    path_0.moveTo(size.width * 0.2147129, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.2147129,
        size.height * 0.7750000,
        size.width * 0.2213789,
        size.height * 0.7666680,
        size.width * 0.2313789,
        size.height * 0.7666680);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.7666680);
    path_0.cubicTo(
        size.width * 0.2397129,
        size.height * 0.7666680,
        size.width * 0.2480449,
        size.height * 0.7750020,
        size.width * 0.2480449,
        size.height * 0.7833340);
    path_0.lineTo(size.width * 0.2480449, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.2480449,
        size.height * 0.7916680,
        size.width * 0.2397109,
        size.height * 0.8000000,
        size.width * 0.2313789,
        size.height * 0.8000000);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.8000000);
    path_0.cubicTo(
        size.width * 0.2213809,
        size.height * 0.8000000,
        size.width * 0.2147129,
        size.height * 0.7916660,
        size.width * 0.2147129,
        size.height * 0.7833340);
    path_0.close();
    path_0.moveTo(size.width * 0.1480469, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.1480469,
        size.height * 0.7750000,
        size.width * 0.1547129,
        size.height * 0.7666680,
        size.width * 0.1647129,
        size.height * 0.7666680);
    path_0.lineTo(size.width * 0.1647129, size.height * 0.7666680);
    path_0.cubicTo(
        size.width * 0.1730469,
        size.height * 0.7666680,
        size.width * 0.1813789,
        size.height * 0.7750020,
        size.width * 0.1813789,
        size.height * 0.7833340);
    path_0.lineTo(size.width * 0.1813789, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.1813789,
        size.height * 0.7916680,
        size.width * 0.1730449,
        size.height * 0.8000000,
        size.width * 0.1647129,
        size.height * 0.8000000);
    path_0.lineTo(size.width * 0.1647129, size.height * 0.8000000);
    path_0.cubicTo(
        size.width * 0.1547129,
        size.height * 0.8000000,
        size.width * 0.1480469,
        size.height * 0.7916660,
        size.width * 0.1480469,
        size.height * 0.7833340);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.7733340,
        size.width * 0.8897148,
        size.height * 0.7666680,
        size.width * 0.8980469,
        size.height * 0.7666680);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.7666680);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.7666680,
        size.width * 0.9147129,
        size.height * 0.7733340,
        size.width * 0.9147129,
        size.height * 0.7833340);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.7833340);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.7916680,
        size.width * 0.9063789,
        size.height * 0.8000000,
        size.width * 0.8980469,
        size.height * 0.8000000);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.8000000);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.8000000,
        size.width * 0.8813809,
        size.height * 0.7916660,
        size.width * 0.8813809,
        size.height * 0.7833340);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.7500000);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.7416660,
        size.width * 0.1213789,
        size.height * 0.7333340,
        size.width * 0.1313789,
        size.height * 0.7333340);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.7333340);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.7333340,
        size.width * 0.1480449,
        size.height * 0.7416680,
        size.width * 0.1480449,
        size.height * 0.7500000);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.7500000);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.7583340,
        size.width * 0.1397109,
        size.height * 0.7666660,
        size.width * 0.1313789,
        size.height * 0.7666660);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.7666660);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.7666660,
        size.width * 0.1147129,
        size.height * 0.7583340,
        size.width * 0.1147129,
        size.height * 0.7500000);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.7166660);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.7066660,
        size.width * 0.8897148,
        size.height * 0.7000000,
        size.width * 0.8980469,
        size.height * 0.7000000);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.7000000);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.7000000,
        size.width * 0.9147129,
        size.height * 0.7066660,
        size.width * 0.9147129,
        size.height * 0.7166660);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.7166660);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.7250000,
        size.width * 0.9063789,
        size.height * 0.7333320,
        size.width * 0.8980469,
        size.height * 0.7333320);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.7333320);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.7333340,
        size.width * 0.8813809,
        size.height * 0.7250000,
        size.width * 0.8813809,
        size.height * 0.7166660);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.6833340);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.6750000,
        size.width * 0.1213789,
        size.height * 0.6666680,
        size.width * 0.1313789,
        size.height * 0.6666680);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.6666680);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.6666680,
        size.width * 0.1480449,
        size.height * 0.6750020,
        size.width * 0.1480449,
        size.height * 0.6833340);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.6833340);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.6916680,
        size.width * 0.1397109,
        size.height * 0.7000000,
        size.width * 0.1313789,
        size.height * 0.7000000);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.7000000);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.7000000,
        size.width * 0.1147129,
        size.height * 0.6916660,
        size.width * 0.1147129,
        size.height * 0.6833340);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.6500000);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.6416660,
        size.width * 0.8897148,
        size.height * 0.6333340,
        size.width * 0.8980469,
        size.height * 0.6333340);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.6333340);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.6333340,
        size.width * 0.9147129,
        size.height * 0.6416680,
        size.width * 0.9147129,
        size.height * 0.6500000);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.6500000);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.6583340,
        size.width * 0.9063789,
        size.height * 0.6666660,
        size.width * 0.8980469,
        size.height * 0.6666660);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.6666660);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.6666660,
        size.width * 0.8813809,
        size.height * 0.6583340,
        size.width * 0.8813809,
        size.height * 0.6500000);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.6166660);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.6083320,
        size.width * 0.1213789,
        size.height * 0.6000000,
        size.width * 0.1313789,
        size.height * 0.6000000);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.6000000);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.6000000,
        size.width * 0.1480449,
        size.height * 0.6083340,
        size.width * 0.1480449,
        size.height * 0.6166660);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.6166660);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.6250000,
        size.width * 0.1397109,
        size.height * 0.6333320,
        size.width * 0.1313789,
        size.height * 0.6333320);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.6333320);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.6333340,
        size.width * 0.1147129,
        size.height * 0.6250000,
        size.width * 0.1147129,
        size.height * 0.6166660);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.5833340);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.5733340,
        size.width * 0.8897148,
        size.height * 0.5666680,
        size.width * 0.8980469,
        size.height * 0.5666680);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.5666680);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.5666680,
        size.width * 0.9147129,
        size.height * 0.5733340,
        size.width * 0.9147129,
        size.height * 0.5833340);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.5833340);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.5916680,
        size.width * 0.9063789,
        size.height * 0.6000000,
        size.width * 0.8980469,
        size.height * 0.6000000);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.6000000);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.6000000,
        size.width * 0.8813809,
        size.height * 0.5916660,
        size.width * 0.8813809,
        size.height * 0.5833340);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.5500000);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.5416660,
        size.width * 0.1213789,
        size.height * 0.5333340,
        size.width * 0.1313789,
        size.height * 0.5333340);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.5333340);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.5333340,
        size.width * 0.1480449,
        size.height * 0.5416680,
        size.width * 0.1480449,
        size.height * 0.5500000);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.5500000);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.5583340,
        size.width * 0.1397109,
        size.height * 0.5666660,
        size.width * 0.1313789,
        size.height * 0.5666660);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.5666660);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.5666660,
        size.width * 0.1147129,
        size.height * 0.5583340,
        size.width * 0.1147129,
        size.height * 0.5500000);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.5166660);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.5066660,
        size.width * 0.8897148,
        size.height * 0.5000000,
        size.width * 0.8980469,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.5000000,
        size.width * 0.9147129,
        size.height * 0.5066660,
        size.width * 0.9147129,
        size.height * 0.5166660);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.5166660);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.5250000,
        size.width * 0.9063789,
        size.height * 0.5333320,
        size.width * 0.8980469,
        size.height * 0.5333320);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.5333320);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.5333340,
        size.width * 0.8813809,
        size.height * 0.5250000,
        size.width * 0.8813809,
        size.height * 0.5166660);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.4833340);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.4733340,
        size.width * 0.1213789,
        size.height * 0.4666680,
        size.width * 0.1313789,
        size.height * 0.4666680);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.4666680);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.4666680,
        size.width * 0.1480449,
        size.height * 0.4733340,
        size.width * 0.1480449,
        size.height * 0.4833340);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.4833340);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.4916680,
        size.width * 0.1397109,
        size.height * 0.5000000,
        size.width * 0.1313789,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.5000000,
        size.width * 0.1147129,
        size.height * 0.4916660,
        size.width * 0.1147129,
        size.height * 0.4833340);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.4500000);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.4400000,
        size.width * 0.8897148,
        size.height * 0.4333340,
        size.width * 0.8980469,
        size.height * 0.4333340);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.4333340);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.4333340,
        size.width * 0.9147129,
        size.height * 0.4400000,
        size.width * 0.9147129,
        size.height * 0.4500000);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.4500000);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.4583340,
        size.width * 0.9063789,
        size.height * 0.4666660,
        size.width * 0.8980469,
        size.height * 0.4666660);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.4666660);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.4666660,
        size.width * 0.8813809,
        size.height * 0.4583340,
        size.width * 0.8813809,
        size.height * 0.4500000);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.4166660);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.4066660,
        size.width * 0.1213789,
        size.height * 0.4000000,
        size.width * 0.1313789,
        size.height * 0.4000000);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.4000000);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.4000000,
        size.width * 0.1480449,
        size.height * 0.4066660,
        size.width * 0.1480449,
        size.height * 0.4166660);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.4166660);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.4250000,
        size.width * 0.1397109,
        size.height * 0.4333320,
        size.width * 0.1313789,
        size.height * 0.4333320);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.4333320);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.4333340,
        size.width * 0.1147129,
        size.height * 0.4250000,
        size.width * 0.1147129,
        size.height * 0.4166660);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.3833340);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.3733340,
        size.width * 0.8897148,
        size.height * 0.3666680,
        size.width * 0.8980469,
        size.height * 0.3666680);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.3666680);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.3666680,
        size.width * 0.9147129,
        size.height * 0.3733340,
        size.width * 0.9147129,
        size.height * 0.3833340);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.3833340);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.3916680,
        size.width * 0.9063789,
        size.height * 0.4000000,
        size.width * 0.8980469,
        size.height * 0.4000000);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.4000000);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.4000000,
        size.width * 0.8813809,
        size.height * 0.3916660,
        size.width * 0.8813809,
        size.height * 0.3833340);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.3500000);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.3400000,
        size.width * 0.1213789,
        size.height * 0.3333340,
        size.width * 0.1313789,
        size.height * 0.3333340);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.3333340);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.3333340,
        size.width * 0.1480449,
        size.height * 0.3400000,
        size.width * 0.1480449,
        size.height * 0.3500000);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.3500000);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.3583340,
        size.width * 0.1397109,
        size.height * 0.3666660,
        size.width * 0.1313789,
        size.height * 0.3666660);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.3666660);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.3666660,
        size.width * 0.1147129,
        size.height * 0.3583340,
        size.width * 0.1147129,
        size.height * 0.3500000);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.3166660);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.3066660,
        size.width * 0.8897148,
        size.height * 0.3000000,
        size.width * 0.8980469,
        size.height * 0.3000000);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.3000000);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.3000000,
        size.width * 0.9147129,
        size.height * 0.3066660,
        size.width * 0.9147129,
        size.height * 0.3166660);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.3166660);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.3250000,
        size.width * 0.9063789,
        size.height * 0.3333320,
        size.width * 0.8980469,
        size.height * 0.3333320);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.3333320);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.3333340,
        size.width * 0.8813809,
        size.height * 0.3250000,
        size.width * 0.8813809,
        size.height * 0.3166660);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.2833340);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.2733340,
        size.width * 0.1213789,
        size.height * 0.2666680,
        size.width * 0.1313789,
        size.height * 0.2666680);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.2666680);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.2666680,
        size.width * 0.1480449,
        size.height * 0.2733340,
        size.width * 0.1480449,
        size.height * 0.2833340);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.2833340);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.2916680,
        size.width * 0.1397109,
        size.height * 0.3000000,
        size.width * 0.1313789,
        size.height * 0.3000000);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.3000000);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.3000000,
        size.width * 0.1147129,
        size.height * 0.2916660,
        size.width * 0.1147129,
        size.height * 0.2833340);
    path_0.close();
    path_0.moveTo(size.width * 0.8813809, size.height * 0.2500000);
    path_0.cubicTo(
        size.width * 0.8813809,
        size.height * 0.2400000,
        size.width * 0.8897148,
        size.height * 0.2333340,
        size.width * 0.8980469,
        size.height * 0.2333340);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.2333340);
    path_0.cubicTo(
        size.width * 0.9063809,
        size.height * 0.2333340,
        size.width * 0.9147129,
        size.height * 0.2400000,
        size.width * 0.9147129,
        size.height * 0.2500000);
    path_0.lineTo(size.width * 0.9147129, size.height * 0.2500000);
    path_0.cubicTo(
        size.width * 0.9147129,
        size.height * 0.2583340,
        size.width * 0.9063789,
        size.height * 0.2666660,
        size.width * 0.8980469,
        size.height * 0.2666660);
    path_0.lineTo(size.width * 0.8980469, size.height * 0.2666660);
    path_0.cubicTo(
        size.width * 0.8897129,
        size.height * 0.2666660,
        size.width * 0.8813809,
        size.height * 0.2583340,
        size.width * 0.8813809,
        size.height * 0.2500000);
    path_0.close();
    path_0.moveTo(size.width * 0.8480469, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.8480469,
        size.height * 0.2066660,
        size.width * 0.8563809,
        size.height * 0.2000000,
        size.width * 0.8647129,
        size.height * 0.2000000);
    path_0.lineTo(size.width * 0.8647129, size.height * 0.2000000);
    path_0.cubicTo(
        size.width * 0.8730469,
        size.height * 0.2000000,
        size.width * 0.8813789,
        size.height * 0.2066660,
        size.width * 0.8813789,
        size.height * 0.2166660);
    path_0.lineTo(size.width * 0.8813789, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.8813789,
        size.height * 0.2250000,
        size.width * 0.8730449,
        size.height * 0.2333320,
        size.width * 0.8647129,
        size.height * 0.2333320);
    path_0.lineTo(size.width * 0.8647129, size.height * 0.2333320);
    path_0.cubicTo(
        size.width * 0.8563809,
        size.height * 0.2333340,
        size.width * 0.8480469,
        size.height * 0.2250000,
        size.width * 0.8480469,
        size.height * 0.2166660);
    path_0.close();
    path_0.moveTo(size.width * 0.7813809, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.7813809,
        size.height * 0.2066660,
        size.width * 0.7897148,
        size.height * 0.2000000,
        size.width * 0.7980469,
        size.height * 0.2000000);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.2000000);
    path_0.cubicTo(
        size.width * 0.8063809,
        size.height * 0.2000000,
        size.width * 0.8147129,
        size.height * 0.2066660,
        size.width * 0.8147129,
        size.height * 0.2166660);
    path_0.lineTo(size.width * 0.8147129, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.8147129,
        size.height * 0.2250000,
        size.width * 0.8063789,
        size.height * 0.2333320,
        size.width * 0.7980469,
        size.height * 0.2333320);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.2333320);
    path_0.cubicTo(
        size.width * 0.7897129,
        size.height * 0.2333340,
        size.width * 0.7813809,
        size.height * 0.2250000,
        size.width * 0.7813809,
        size.height * 0.2166660);
    path_0.close();
    path_0.moveTo(size.width * 0.1813809, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.1813809,
        size.height * 0.2066660,
        size.width * 0.1880469,
        size.height * 0.2000000,
        size.width * 0.1980469,
        size.height * 0.2000000);
    path_0.lineTo(size.width * 0.1980469, size.height * 0.2000000);
    path_0.cubicTo(
        size.width * 0.2063809,
        size.height * 0.2000000,
        size.width * 0.2147129,
        size.height * 0.2066660,
        size.width * 0.2147129,
        size.height * 0.2166660);
    path_0.lineTo(size.width * 0.2147129, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.2147129,
        size.height * 0.2250000,
        size.width * 0.2063789,
        size.height * 0.2333320,
        size.width * 0.1980469,
        size.height * 0.2333320);
    path_0.lineTo(size.width * 0.1980469, size.height * 0.2333320);
    path_0.cubicTo(
        size.width * 0.1880469,
        size.height * 0.2333340,
        size.width * 0.1813809,
        size.height * 0.2250000,
        size.width * 0.1813809,
        size.height * 0.2166660);
    path_0.close();
    path_0.moveTo(size.width * 0.1147129, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.1147129,
        size.height * 0.2066660,
        size.width * 0.1213789,
        size.height * 0.2000000,
        size.width * 0.1313789,
        size.height * 0.2000000);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.2000000);
    path_0.cubicTo(
        size.width * 0.1397129,
        size.height * 0.2000000,
        size.width * 0.1480449,
        size.height * 0.2066660,
        size.width * 0.1480449,
        size.height * 0.2166660);
    path_0.lineTo(size.width * 0.1480449, size.height * 0.2166660);
    path_0.cubicTo(
        size.width * 0.1480449,
        size.height * 0.2250000,
        size.width * 0.1397109,
        size.height * 0.2333320,
        size.width * 0.1313789,
        size.height * 0.2333320);
    path_0.lineTo(size.width * 0.1313789, size.height * 0.2333320);
    path_0.cubicTo(
        size.width * 0.1213809,
        size.height * 0.2333340,
        size.width * 0.1147129,
        size.height * 0.2250000,
        size.width * 0.1147129,
        size.height * 0.2166660);
    path_0.close();
    path_0.moveTo(size.width * 0.2147129, size.height * 0.1833340);
    path_0.cubicTo(
        size.width * 0.2147129,
        size.height * 0.1733340,
        size.width * 0.2213789,
        size.height * 0.1666680,
        size.width * 0.2313789,
        size.height * 0.1666680);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.1666680);
    path_0.cubicTo(
        size.width * 0.2397129,
        size.height * 0.1666680,
        size.width * 0.2480449,
        size.height * 0.1733340,
        size.width * 0.2480449,
        size.height * 0.1833340);
    path_0.lineTo(size.width * 0.2480449, size.height * 0.1833340);
    path_0.cubicTo(
        size.width * 0.2480449,
        size.height * 0.1916680,
        size.width * 0.2397109,
        size.height * 0.2000000,
        size.width * 0.2313789,
        size.height * 0.2000000);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.2000000);
    path_0.cubicTo(
        size.width * 0.2213809,
        size.height * 0.2000000,
        size.width * 0.2147129,
        size.height * 0.1916660,
        size.width * 0.2147129,
        size.height * 0.1833340);
    path_0.close();
    path_0.moveTo(size.width * 0.7813809, size.height * 0.1500000);
    path_0.cubicTo(
        size.width * 0.7813809,
        size.height * 0.1400000,
        size.width * 0.7897148,
        size.height * 0.1333340,
        size.width * 0.7980469,
        size.height * 0.1333340);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.1333340);
    path_0.cubicTo(
        size.width * 0.8063809,
        size.height * 0.1333340,
        size.width * 0.8147129,
        size.height * 0.1400000,
        size.width * 0.8147129,
        size.height * 0.1500000);
    path_0.lineTo(size.width * 0.8147129, size.height * 0.1500000);
    path_0.cubicTo(
        size.width * 0.8147129,
        size.height * 0.1583340,
        size.width * 0.8063789,
        size.height * 0.1666660,
        size.width * 0.7980469,
        size.height * 0.1666660);
    path_0.lineTo(size.width * 0.7980469, size.height * 0.1666660);
    path_0.cubicTo(
        size.width * 0.7897129,
        size.height * 0.1666660,
        size.width * 0.7813809,
        size.height * 0.1583340,
        size.width * 0.7813809,
        size.height * 0.1500000);
    path_0.close();
    path_0.moveTo(size.width * 0.7480469, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.7480469,
        size.height * 0.1066660,
        size.width * 0.7563809,
        size.height * 0.1000000,
        size.width * 0.7647129,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.7647129, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.7730469,
        size.height * 0.1000000,
        size.width * 0.7813789,
        size.height * 0.1066660,
        size.width * 0.7813789,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.7813789, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.7813789,
        size.height * 0.1250000,
        size.width * 0.7730449,
        size.height * 0.1333320,
        size.width * 0.7647129,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.7647129, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.7563809,
        size.height * 0.1333340,
        size.width * 0.7480469,
        size.height * 0.1250000,
        size.width * 0.7480469,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.6813809, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.6813809,
        size.height * 0.1066660,
        size.width * 0.6897148,
        size.height * 0.1000000,
        size.width * 0.6980469,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.6980469, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.7063809,
        size.height * 0.1000000,
        size.width * 0.7147129,
        size.height * 0.1066660,
        size.width * 0.7147129,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.7147129, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.7147129,
        size.height * 0.1250000,
        size.width * 0.7063789,
        size.height * 0.1333320,
        size.width * 0.6980469,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.6980469, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.6897129,
        size.height * 0.1333340,
        size.width * 0.6813809,
        size.height * 0.1250000,
        size.width * 0.6813809,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.6147129, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.6147129,
        size.height * 0.1066660,
        size.width * 0.6230469,
        size.height * 0.1000000,
        size.width * 0.6313789,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.6313789, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.6397129,
        size.height * 0.1000000,
        size.width * 0.6480449,
        size.height * 0.1066660,
        size.width * 0.6480449,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.6480449, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.6480449,
        size.height * 0.1250000,
        size.width * 0.6397109,
        size.height * 0.1333320,
        size.width * 0.6313789,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.6313789, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.6230469,
        size.height * 0.1333340,
        size.width * 0.6147129,
        size.height * 0.1250000,
        size.width * 0.6147129,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.5480469, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.5480469,
        size.height * 0.1066660,
        size.width * 0.5563809,
        size.height * 0.1000000,
        size.width * 0.5647129,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.5647129, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.5730469,
        size.height * 0.1000000,
        size.width * 0.5813789,
        size.height * 0.1066660,
        size.width * 0.5813789,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.5813789, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.5813789,
        size.height * 0.1250000,
        size.width * 0.5730449,
        size.height * 0.1333320,
        size.width * 0.5647129,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.5647129, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.5563809,
        size.height * 0.1333340,
        size.width * 0.5480469,
        size.height * 0.1250000,
        size.width * 0.5480469,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.4813809, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.4813809,
        size.height * 0.1066660,
        size.width * 0.4880469,
        size.height * 0.1000000,
        size.width * 0.4980469,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.4980469, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.5063809,
        size.height * 0.1000000,
        size.width * 0.5147129,
        size.height * 0.1066660,
        size.width * 0.5147129,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.5147129, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.5147129,
        size.height * 0.1250000,
        size.width * 0.5063789,
        size.height * 0.1333320,
        size.width * 0.4980469,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.4980469, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.4880469,
        size.height * 0.1333340,
        size.width * 0.4813809,
        size.height * 0.1250000,
        size.width * 0.4813809,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.4147129, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.4147129,
        size.height * 0.1066660,
        size.width * 0.4213789,
        size.height * 0.1000000,
        size.width * 0.4313789,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.4313789, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.4397129,
        size.height * 0.1000000,
        size.width * 0.4480449,
        size.height * 0.1066660,
        size.width * 0.4480449,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.4480449, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.4480449,
        size.height * 0.1250000,
        size.width * 0.4397109,
        size.height * 0.1333320,
        size.width * 0.4313789,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.4313789, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.4213809,
        size.height * 0.1333340,
        size.width * 0.4147129,
        size.height * 0.1250000,
        size.width * 0.4147129,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.3480469, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.3480469,
        size.height * 0.1066660,
        size.width * 0.3547129,
        size.height * 0.1000000,
        size.width * 0.3647129,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.3647129, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.3730469,
        size.height * 0.1000000,
        size.width * 0.3813789,
        size.height * 0.1066660,
        size.width * 0.3813789,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.3813789, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.3813789,
        size.height * 0.1250000,
        size.width * 0.3730449,
        size.height * 0.1333320,
        size.width * 0.3647129,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.3647129, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.3547129,
        size.height * 0.1333340,
        size.width * 0.3480469,
        size.height * 0.1250000,
        size.width * 0.3480469,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.2813809, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.2813809,
        size.height * 0.1066660,
        size.width * 0.2880469,
        size.height * 0.1000000,
        size.width * 0.2980469,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.2980469, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.3063809,
        size.height * 0.1000000,
        size.width * 0.3147129,
        size.height * 0.1066660,
        size.width * 0.3147129,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.3147129, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.3147129,
        size.height * 0.1250000,
        size.width * 0.3063789,
        size.height * 0.1333320,
        size.width * 0.2980469,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.2980469, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.2880469,
        size.height * 0.1333340,
        size.width * 0.2813809,
        size.height * 0.1250000,
        size.width * 0.2813809,
        size.height * 0.1166660);
    path_0.close();
    path_0.moveTo(size.width * 0.2147129, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.2147129,
        size.height * 0.1066660,
        size.width * 0.2213789,
        size.height * 0.1000000,
        size.width * 0.2313789,
        size.height * 0.1000000);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.1000000);
    path_0.cubicTo(
        size.width * 0.2397129,
        size.height * 0.1000000,
        size.width * 0.2480449,
        size.height * 0.1066660,
        size.width * 0.2480449,
        size.height * 0.1166660);
    path_0.lineTo(size.width * 0.2480449, size.height * 0.1166660);
    path_0.cubicTo(
        size.width * 0.2480449,
        size.height * 0.1250000,
        size.width * 0.2397109,
        size.height * 0.1333320,
        size.width * 0.2313789,
        size.height * 0.1333320);
    path_0.lineTo(size.width * 0.2313789, size.height * 0.1333320);
    path_0.cubicTo(
        size.width * 0.2213809,
        size.height * 0.1333340,
        size.width * 0.2147129,
        size.height * 0.1250000,
        size.width * 0.2147129,
        size.height * 0.1166660);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.01471289, size.height * 0.2166660);
    path_1.lineTo(size.width * 0.2147129, size.height * 0.2166660);
    path_1.lineTo(size.width * 0.2147129, size.height * 0.01666602);
    path_1.lineTo(size.width * 0.01471289, size.height * 0.01666602);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff434C6D).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2313809, size.height * 0.2333340);
    path_2.lineTo(size.width * -0.001953125, size.height * 0.2333340);
    path_2.lineTo(size.width * -0.001953125, 0);
    path_2.lineTo(size.width * 0.2313809, 0);
    path_2.lineTo(size.width * 0.2313809, size.height * 0.2333340);
    path_2.close();
    path_2.moveTo(size.width * 0.03138086, size.height * 0.2000000);
    path_2.lineTo(size.width * 0.1980469, size.height * 0.2000000);
    path_2.lineTo(size.width * 0.1980469, size.height * 0.03333398);
    path_2.lineTo(size.width * 0.03138086, size.height * 0.03333398);
    path_2.lineTo(size.width * 0.03138086, size.height * 0.2000000);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff434C6D).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.01471289, size.height * 0.9833340);
    path_3.lineTo(size.width * 0.2147129, size.height * 0.9833340);
    path_3.lineTo(size.width * 0.2147129, size.height * 0.7833340);
    path_3.lineTo(size.width * 0.01471289, size.height * 0.7833340);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.2313809, size.height);
    path_4.lineTo(size.width * -0.001953125, size.height);
    path_4.lineTo(size.width * -0.001953125, size.height * 0.7666660);
    path_4.lineTo(size.width * 0.2313809, size.height * 0.7666660);
    path_4.lineTo(size.width * 0.2313809, size.height);
    path_4.close();
    path_4.moveTo(size.width * 0.03138086, size.height * 0.9666660);
    path_4.lineTo(size.width * 0.1980469, size.height * 0.9666660);
    path_4.lineTo(size.width * 0.1980469, size.height * 0.8000000);
    path_4.lineTo(size.width * 0.03138086, size.height * 0.8000000);
    path_4.lineTo(size.width * 0.03138086, size.height * 0.9666660);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.7813809, size.height * 0.2166660);
    path_5.lineTo(size.width * 0.9813809, size.height * 0.2166660);
    path_5.lineTo(size.width * 0.9813809, size.height * 0.01666602);
    path_5.lineTo(size.width * 0.7813809, size.height * 0.01666602);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff434C6D).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.9980469, size.height * 0.2333340);
    path_6.lineTo(size.width * 0.7647129, size.height * 0.2333340);
    path_6.lineTo(size.width * 0.7647129, 0);
    path_6.lineTo(size.width * 0.9980469, 0);
    path_6.lineTo(size.width * 0.9980469, size.height * 0.2333340);
    path_6.close();
    path_6.moveTo(size.width * 0.7980469, size.height * 0.2000000);
    path_6.lineTo(size.width * 0.9647129, size.height * 0.2000000);
    path_6.lineTo(size.width * 0.9647129, size.height * 0.03333398);
    path_6.lineTo(size.width * 0.7980469, size.height * 0.03333398);
    path_6.lineTo(size.width * 0.7980469, size.height * 0.2000000);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff434C6D).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.7813809, size.height * 0.9833340);
    path_7.lineTo(size.width * 0.9813809, size.height * 0.9833340);
    path_7.lineTo(size.width * 0.9813809, size.height * 0.7833340);
    path_7.lineTo(size.width * 0.7813809, size.height * 0.7833340);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff434C6D).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.9980469, size.height);
    path_8.lineTo(size.width * 0.7647129, size.height);
    path_8.lineTo(size.width * 0.7647129, size.height * 0.7666660);
    path_8.lineTo(size.width * 0.9980469, size.height * 0.7666660);
    path_8.lineTo(size.width * 0.9980469, size.height);
    path_8.close();
    path_8.moveTo(size.width * 0.7980469, size.height * 0.9666660);
    path_8.lineTo(size.width * 0.9647129, size.height * 0.9666660);
    path_8.lineTo(size.width * 0.9647129, size.height * 0.8000000);
    path_8.lineTo(size.width * 0.7980469, size.height * 0.8000000);
    path_8.lineTo(size.width * 0.7980469, size.height * 0.9666660);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff434C6D).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.2313809, size.height * 0.2333340);
    path_9.lineTo(size.width * -0.001953125, size.height * 0.2333340);
    path_9.lineTo(size.width * -0.001953125, 0);
    path_9.lineTo(size.width * 0.2313809, 0);
    path_9.lineTo(size.width * 0.2313809, size.height * 0.2333340);
    path_9.close();
    path_9.moveTo(size.width * 0.03138086, size.height * 0.2000000);
    path_9.lineTo(size.width * 0.1980469, size.height * 0.2000000);
    path_9.lineTo(size.width * 0.1980469, size.height * 0.03333398);
    path_9.lineTo(size.width * 0.03138086, size.height * 0.03333398);
    path_9.lineTo(size.width * 0.03138086, size.height * 0.2000000);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.2313809, size.height);
    path_10.lineTo(size.width * -0.001953125, size.height);
    path_10.lineTo(size.width * -0.001953125, size.height * 0.7666660);
    path_10.lineTo(size.width * 0.2313809, size.height * 0.7666660);
    path_10.lineTo(size.width * 0.2313809, size.height);
    path_10.close();
    path_10.moveTo(size.width * 0.03138086, size.height * 0.9666660);
    path_10.lineTo(size.width * 0.1980469, size.height * 0.9666660);
    path_10.lineTo(size.width * 0.1980469, size.height * 0.8000000);
    path_10.lineTo(size.width * 0.03138086, size.height * 0.8000000);
    path_10.lineTo(size.width * 0.03138086, size.height * 0.9666660);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.9980469, size.height * 0.2333340);
    path_11.lineTo(size.width * 0.7647129, size.height * 0.2333340);
    path_11.lineTo(size.width * 0.7647129, 0);
    path_11.lineTo(size.width * 0.9980469, 0);
    path_11.lineTo(size.width * 0.9980469, size.height * 0.2333340);
    path_11.close();
    path_11.moveTo(size.width * 0.7980469, size.height * 0.2000000);
    path_11.lineTo(size.width * 0.9647129, size.height * 0.2000000);
    path_11.lineTo(size.width * 0.9647129, size.height * 0.03333398);
    path_11.lineTo(size.width * 0.7980469, size.height * 0.03333398);
    path_11.lineTo(size.width * 0.7980469, size.height * 0.2000000);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.9980469, size.height);
    path_12.lineTo(size.width * 0.7647129, size.height);
    path_12.lineTo(size.width * 0.7647129, size.height * 0.7666660);
    path_12.lineTo(size.width * 0.9980469, size.height * 0.7666660);
    path_12.lineTo(size.width * 0.9980469, size.height);
    path_12.close();
    path_12.moveTo(size.width * 0.7980469, size.height * 0.9666660);
    path_12.lineTo(size.width * 0.9647129, size.height * 0.9666660);
    path_12.lineTo(size.width * 0.9647129, size.height * 0.8000000);
    path_12.lineTo(size.width * 0.7980469, size.height * 0.8000000);
    path_12.lineTo(size.width * 0.7980469, size.height * 0.9666660);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.7647129, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.7647129,
        size.height * 0.8750000,
        size.width * 0.7730469,
        size.height * 0.8666680,
        size.width * 0.7813789,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.7897129,
        size.height * 0.8666680,
        size.width * 0.7980449,
        size.height * 0.8750020,
        size.width * 0.7980449,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.7980449, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.7980449,
        size.height * 0.8916680,
        size.width * 0.7897109,
        size.height * 0.9000000,
        size.width * 0.7813789,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.7730469,
        size.height * 0.9000000,
        size.width * 0.7647129,
        size.height * 0.8916660,
        size.width * 0.7647129,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.6980469, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.6980469,
        size.height * 0.8750000,
        size.width * 0.7063809,
        size.height * 0.8666680,
        size.width * 0.7147129,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.7147129, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.7230469,
        size.height * 0.8666680,
        size.width * 0.7313789,
        size.height * 0.8750020,
        size.width * 0.7313789,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.7313789, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.7313789,
        size.height * 0.8916680,
        size.width * 0.7230449,
        size.height * 0.9000000,
        size.width * 0.7147129,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.7147129, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.7063809,
        size.height * 0.9000000,
        size.width * 0.6980469,
        size.height * 0.8916660,
        size.width * 0.6980469,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.6313809, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.6313809,
        size.height * 0.8750000,
        size.width * 0.6397148,
        size.height * 0.8666680,
        size.width * 0.6480469,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.6480469, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.6563809,
        size.height * 0.8666680,
        size.width * 0.6647129,
        size.height * 0.8750020,
        size.width * 0.6647129,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.6647129, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.6647129,
        size.height * 0.8916680,
        size.width * 0.6563789,
        size.height * 0.9000000,
        size.width * 0.6480469,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.6480469, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.6397129,
        size.height * 0.9000000,
        size.width * 0.6313809,
        size.height * 0.8916660,
        size.width * 0.6313809,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.5647129, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.5647129,
        size.height * 0.8750000,
        size.width * 0.5730469,
        size.height * 0.8666680,
        size.width * 0.5813789,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.5813789, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.5897129,
        size.height * 0.8666680,
        size.width * 0.5980449,
        size.height * 0.8750020,
        size.width * 0.5980449,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.5980449, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.5980449,
        size.height * 0.8916680,
        size.width * 0.5897109,
        size.height * 0.9000000,
        size.width * 0.5813789,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.5813789, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.5730469,
        size.height * 0.9000000,
        size.width * 0.5647129,
        size.height * 0.8916660,
        size.width * 0.5647129,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.4980469, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.4980469,
        size.height * 0.8750000,
        size.width * 0.5063809,
        size.height * 0.8666680,
        size.width * 0.5147129,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.5147129, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.5230469,
        size.height * 0.8666680,
        size.width * 0.5313789,
        size.height * 0.8750020,
        size.width * 0.5313789,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.5313789, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.5313789,
        size.height * 0.8916680,
        size.width * 0.5230449,
        size.height * 0.9000000,
        size.width * 0.5147129,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.5147129, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.5063809,
        size.height * 0.9000000,
        size.width * 0.4980469,
        size.height * 0.8916660,
        size.width * 0.4980469,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.4313809, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.4313809,
        size.height * 0.8750000,
        size.width * 0.4380469,
        size.height * 0.8666680,
        size.width * 0.4480469,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.4480469, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.4563809,
        size.height * 0.8666680,
        size.width * 0.4647129,
        size.height * 0.8750020,
        size.width * 0.4647129,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.4647129, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.4647129,
        size.height * 0.8916680,
        size.width * 0.4563789,
        size.height * 0.9000000,
        size.width * 0.4480469,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.4480469, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.4380469,
        size.height * 0.9000000,
        size.width * 0.4313809,
        size.height * 0.8916660,
        size.width * 0.4313809,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.3647129, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.3647129,
        size.height * 0.8750000,
        size.width * 0.3713789,
        size.height * 0.8666680,
        size.width * 0.3813789,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.3813789, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.3897129,
        size.height * 0.8666680,
        size.width * 0.3980449,
        size.height * 0.8750020,
        size.width * 0.3980449,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.3980449, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.3980449,
        size.height * 0.8916680,
        size.width * 0.3897109,
        size.height * 0.9000000,
        size.width * 0.3813789,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.3813789, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.3713809,
        size.height * 0.9000000,
        size.width * 0.3647129,
        size.height * 0.8916660,
        size.width * 0.3647129,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.2980469, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.2980469,
        size.height * 0.8750000,
        size.width * 0.3047129,
        size.height * 0.8666680,
        size.width * 0.3147129,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.3147129, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.3230469,
        size.height * 0.8666680,
        size.width * 0.3313789,
        size.height * 0.8750020,
        size.width * 0.3313789,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.3313789, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.3313789,
        size.height * 0.8916680,
        size.width * 0.3230449,
        size.height * 0.9000000,
        size.width * 0.3147129,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.3147129, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.3047129,
        size.height * 0.9000000,
        size.width * 0.2980469,
        size.height * 0.8916660,
        size.width * 0.2980469,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.2313809, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.2313809,
        size.height * 0.8750000,
        size.width * 0.2380469,
        size.height * 0.8666680,
        size.width * 0.2480469,
        size.height * 0.8666680);
    path_13.lineTo(size.width * 0.2480469, size.height * 0.8666680);
    path_13.cubicTo(
        size.width * 0.2563809,
        size.height * 0.8666680,
        size.width * 0.2647129,
        size.height * 0.8750020,
        size.width * 0.2647129,
        size.height * 0.8833340);
    path_13.lineTo(size.width * 0.2647129, size.height * 0.8833340);
    path_13.cubicTo(
        size.width * 0.2647129,
        size.height * 0.8916680,
        size.width * 0.2563789,
        size.height * 0.9000000,
        size.width * 0.2480469,
        size.height * 0.9000000);
    path_13.lineTo(size.width * 0.2480469, size.height * 0.9000000);
    path_13.cubicTo(
        size.width * 0.2380469,
        size.height * 0.9000000,
        size.width * 0.2313809,
        size.height * 0.8916660,
        size.width * 0.2313809,
        size.height * 0.8833340);
    path_13.close();
    path_13.moveTo(size.width * 0.1980469, size.height * 0.8500000);
    path_13.cubicTo(
        size.width * 0.1980469,
        size.height * 0.8416660,
        size.width * 0.2047129,
        size.height * 0.8333340,
        size.width * 0.2147129,
        size.height * 0.8333340);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.8333340);
    path_13.cubicTo(
        size.width * 0.2230469,
        size.height * 0.8333340,
        size.width * 0.2313789,
        size.height * 0.8416680,
        size.width * 0.2313789,
        size.height * 0.8500000);
    path_13.lineTo(size.width * 0.2313789, size.height * 0.8500000);
    path_13.cubicTo(
        size.width * 0.2313789,
        size.height * 0.8583340,
        size.width * 0.2230449,
        size.height * 0.8666660,
        size.width * 0.2147129,
        size.height * 0.8666660);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.8666660);
    path_13.cubicTo(
        size.width * 0.2047129,
        size.height * 0.8666660,
        size.width * 0.1980469,
        size.height * 0.8583340,
        size.width * 0.1980469,
        size.height * 0.8500000);
    path_13.close();
    path_13.moveTo(size.width * 0.7647129, size.height * 0.8166660);
    path_13.cubicTo(
        size.width * 0.7647129,
        size.height * 0.8083320,
        size.width * 0.7730469,
        size.height * 0.8000000,
        size.width * 0.7813789,
        size.height * 0.8000000);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.8000000);
    path_13.cubicTo(
        size.width * 0.7897129,
        size.height * 0.8000000,
        size.width * 0.7980449,
        size.height * 0.8083340,
        size.width * 0.7980449,
        size.height * 0.8166660);
    path_13.lineTo(size.width * 0.7980449, size.height * 0.8166660);
    path_13.cubicTo(
        size.width * 0.7980449,
        size.height * 0.8250000,
        size.width * 0.7897109,
        size.height * 0.8333320,
        size.width * 0.7813789,
        size.height * 0.8333320);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.8333320);
    path_13.cubicTo(
        size.width * 0.7730469,
        size.height * 0.8333340,
        size.width * 0.7647129,
        size.height * 0.8250000,
        size.width * 0.7647129,
        size.height * 0.8166660);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.7750000,
        size.width * 0.8730469,
        size.height * 0.7666680,
        size.width * 0.8813789,
        size.height * 0.7666680);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.7666680);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.7666680,
        size.width * 0.8980449,
        size.height * 0.7750020,
        size.width * 0.8980449,
        size.height * 0.7833340);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.7916680,
        size.width * 0.8897109,
        size.height * 0.8000000,
        size.width * 0.8813789,
        size.height * 0.8000000);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.8000000);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.8000000,
        size.width * 0.8647129,
        size.height * 0.7916660,
        size.width * 0.8647129,
        size.height * 0.7833340);
    path_13.close();
    path_13.moveTo(size.width * 0.7980469, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.7980469,
        size.height * 0.7750000,
        size.width * 0.8063809,
        size.height * 0.7666680,
        size.width * 0.8147129,
        size.height * 0.7666680);
    path_13.lineTo(size.width * 0.8147129, size.height * 0.7666680);
    path_13.cubicTo(
        size.width * 0.8230469,
        size.height * 0.7666680,
        size.width * 0.8313789,
        size.height * 0.7750020,
        size.width * 0.8313789,
        size.height * 0.7833340);
    path_13.lineTo(size.width * 0.8313789, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.8313789,
        size.height * 0.7916680,
        size.width * 0.8230449,
        size.height * 0.8000000,
        size.width * 0.8147129,
        size.height * 0.8000000);
    path_13.lineTo(size.width * 0.8147129, size.height * 0.8000000);
    path_13.cubicTo(
        size.width * 0.8063809,
        size.height * 0.8000000,
        size.width * 0.7980469,
        size.height * 0.7916660,
        size.width * 0.7980469,
        size.height * 0.7833340);
    path_13.close();
    path_13.moveTo(size.width * 0.1980469, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.1980469,
        size.height * 0.7750000,
        size.width * 0.2047129,
        size.height * 0.7666680,
        size.width * 0.2147129,
        size.height * 0.7666680);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.7666680);
    path_13.cubicTo(
        size.width * 0.2230469,
        size.height * 0.7666680,
        size.width * 0.2313789,
        size.height * 0.7750020,
        size.width * 0.2313789,
        size.height * 0.7833340);
    path_13.lineTo(size.width * 0.2313789, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.2313789,
        size.height * 0.7916680,
        size.width * 0.2230449,
        size.height * 0.8000000,
        size.width * 0.2147129,
        size.height * 0.8000000);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.8000000);
    path_13.cubicTo(
        size.width * 0.2047129,
        size.height * 0.8000000,
        size.width * 0.1980469,
        size.height * 0.7916660,
        size.width * 0.1980469,
        size.height * 0.7833340);
    path_13.close();
    path_13.moveTo(size.width * 0.1313809, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.1313809,
        size.height * 0.7750000,
        size.width * 0.1380469,
        size.height * 0.7666680,
        size.width * 0.1480469,
        size.height * 0.7666680);
    path_13.lineTo(size.width * 0.1480469, size.height * 0.7666680);
    path_13.cubicTo(
        size.width * 0.1563809,
        size.height * 0.7666680,
        size.width * 0.1647129,
        size.height * 0.7750020,
        size.width * 0.1647129,
        size.height * 0.7833340);
    path_13.lineTo(size.width * 0.1647129, size.height * 0.7833340);
    path_13.cubicTo(
        size.width * 0.1647129,
        size.height * 0.7916680,
        size.width * 0.1563789,
        size.height * 0.8000000,
        size.width * 0.1480469,
        size.height * 0.8000000);
    path_13.lineTo(size.width * 0.1480469, size.height * 0.8000000);
    path_13.cubicTo(
        size.width * 0.1380469,
        size.height * 0.8000000,
        size.width * 0.1313809,
        size.height * 0.7916660,
        size.width * 0.1313809,
        size.height * 0.7833340);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.7500000);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.7416660,
        size.width * 0.1047129,
        size.height * 0.7333340,
        size.width * 0.1147129,
        size.height * 0.7333340);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.7333340);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.7333340,
        size.width * 0.1313789,
        size.height * 0.7416680,
        size.width * 0.1313789,
        size.height * 0.7500000);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.7500000);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.7583340,
        size.width * 0.1230449,
        size.height * 0.7666660,
        size.width * 0.1147129,
        size.height * 0.7666660);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.7666660);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.7666660,
        size.width * 0.09804688,
        size.height * 0.7583340,
        size.width * 0.09804688,
        size.height * 0.7500000);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.7166660);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.7083320,
        size.width * 0.8730469,
        size.height * 0.7000000,
        size.width * 0.8813789,
        size.height * 0.7000000);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.7000000);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.7000000,
        size.width * 0.8980449,
        size.height * 0.7083340,
        size.width * 0.8980449,
        size.height * 0.7166660);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.7166660);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.7250000,
        size.width * 0.8897109,
        size.height * 0.7333320,
        size.width * 0.8813789,
        size.height * 0.7333320);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.7333320);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.7333340,
        size.width * 0.8647129,
        size.height * 0.7250000,
        size.width * 0.8647129,
        size.height * 0.7166660);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.6833340);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.6750000,
        size.width * 0.1047129,
        size.height * 0.6666680,
        size.width * 0.1147129,
        size.height * 0.6666680);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.6666680);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.6666680,
        size.width * 0.1313789,
        size.height * 0.6750020,
        size.width * 0.1313789,
        size.height * 0.6833340);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.6833340);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.6916680,
        size.width * 0.1230449,
        size.height * 0.7000000,
        size.width * 0.1147129,
        size.height * 0.7000000);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.7000000);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.7000000,
        size.width * 0.09804688,
        size.height * 0.6916660,
        size.width * 0.09804688,
        size.height * 0.6833340);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.6500000);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.6416660,
        size.width * 0.8730469,
        size.height * 0.6333340,
        size.width * 0.8813789,
        size.height * 0.6333340);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.6333340);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.6333340,
        size.width * 0.8980449,
        size.height * 0.6416680,
        size.width * 0.8980449,
        size.height * 0.6500000);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.6500000);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.6583340,
        size.width * 0.8897109,
        size.height * 0.6666660,
        size.width * 0.8813789,
        size.height * 0.6666660);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.6666660);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.6666660,
        size.width * 0.8647129,
        size.height * 0.6583340,
        size.width * 0.8647129,
        size.height * 0.6500000);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.6166660);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.6083320,
        size.width * 0.1047129,
        size.height * 0.6000000,
        size.width * 0.1147129,
        size.height * 0.6000000);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.6000000);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.6000000,
        size.width * 0.1313789,
        size.height * 0.6083340,
        size.width * 0.1313789,
        size.height * 0.6166660);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.6166660);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.6250000,
        size.width * 0.1230449,
        size.height * 0.6333320,
        size.width * 0.1147129,
        size.height * 0.6333320);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.6333320);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.6333340,
        size.width * 0.09804688,
        size.height * 0.6250000,
        size.width * 0.09804688,
        size.height * 0.6166660);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.5833340);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.5750000,
        size.width * 0.8730469,
        size.height * 0.5666680,
        size.width * 0.8813789,
        size.height * 0.5666680);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.5666680);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.5666680,
        size.width * 0.8980449,
        size.height * 0.5750020,
        size.width * 0.8980449,
        size.height * 0.5833340);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.5833340);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.5916680,
        size.width * 0.8897109,
        size.height * 0.6000000,
        size.width * 0.8813789,
        size.height * 0.6000000);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.6000000);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.6000000,
        size.width * 0.8647129,
        size.height * 0.5916660,
        size.width * 0.8647129,
        size.height * 0.5833340);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.5500000);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.5416660,
        size.width * 0.1047129,
        size.height * 0.5333340,
        size.width * 0.1147129,
        size.height * 0.5333340);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.5333340);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.5333340,
        size.width * 0.1313789,
        size.height * 0.5416680,
        size.width * 0.1313789,
        size.height * 0.5500000);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.5500000);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.5583340,
        size.width * 0.1230449,
        size.height * 0.5666660,
        size.width * 0.1147129,
        size.height * 0.5666660);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.5666660);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.5666660,
        size.width * 0.09804688,
        size.height * 0.5583340,
        size.width * 0.09804688,
        size.height * 0.5500000);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.5166660);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.5083320,
        size.width * 0.8730469,
        size.height * 0.5000000,
        size.width * 0.8813789,
        size.height * 0.5000000);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.5000000);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.5000000,
        size.width * 0.8980449,
        size.height * 0.5083340,
        size.width * 0.8980449,
        size.height * 0.5166660);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.5166660);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.5250000,
        size.width * 0.8897109,
        size.height * 0.5333320,
        size.width * 0.8813789,
        size.height * 0.5333320);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.5333320);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.5333340,
        size.width * 0.8647129,
        size.height * 0.5250000,
        size.width * 0.8647129,
        size.height * 0.5166660);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.4833340);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.4733340,
        size.width * 0.1047129,
        size.height * 0.4666680,
        size.width * 0.1147129,
        size.height * 0.4666680);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.4666680);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.4666680,
        size.width * 0.1313789,
        size.height * 0.4733340,
        size.width * 0.1313789,
        size.height * 0.4833340);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.4833340);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.4916680,
        size.width * 0.1230449,
        size.height * 0.5000000,
        size.width * 0.1147129,
        size.height * 0.5000000);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.5000000);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.5000000,
        size.width * 0.09804688,
        size.height * 0.4916660,
        size.width * 0.09804688,
        size.height * 0.4833340);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.4500000);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.4400000,
        size.width * 0.8730469,
        size.height * 0.4333340,
        size.width * 0.8813789,
        size.height * 0.4333340);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.4333340);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.4333340,
        size.width * 0.8980449,
        size.height * 0.4400000,
        size.width * 0.8980449,
        size.height * 0.4500000);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.4500000);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.4583340,
        size.width * 0.8897109,
        size.height * 0.4666660,
        size.width * 0.8813789,
        size.height * 0.4666660);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.4666660);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.4666660,
        size.width * 0.8647129,
        size.height * 0.4583340,
        size.width * 0.8647129,
        size.height * 0.4500000);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.4166660);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.4066660,
        size.width * 0.1047129,
        size.height * 0.4000000,
        size.width * 0.1147129,
        size.height * 0.4000000);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.4000000);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.4000000,
        size.width * 0.1313789,
        size.height * 0.4066660,
        size.width * 0.1313789,
        size.height * 0.4166660);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.4166660);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.4250000,
        size.width * 0.1230449,
        size.height * 0.4333320,
        size.width * 0.1147129,
        size.height * 0.4333320);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.4333320);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.4333340,
        size.width * 0.09804688,
        size.height * 0.4250000,
        size.width * 0.09804688,
        size.height * 0.4166660);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.3833340);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.3733340,
        size.width * 0.8730469,
        size.height * 0.3666680,
        size.width * 0.8813789,
        size.height * 0.3666680);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.3666680);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.3666680,
        size.width * 0.8980449,
        size.height * 0.3733340,
        size.width * 0.8980449,
        size.height * 0.3833340);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.3833340);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.3916680,
        size.width * 0.8897109,
        size.height * 0.4000000,
        size.width * 0.8813789,
        size.height * 0.4000000);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.4000000);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.4000000,
        size.width * 0.8647129,
        size.height * 0.3916660,
        size.width * 0.8647129,
        size.height * 0.3833340);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.3500000);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.3400000,
        size.width * 0.1047129,
        size.height * 0.3333340,
        size.width * 0.1147129,
        size.height * 0.3333340);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.3333340);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.3333340,
        size.width * 0.1313789,
        size.height * 0.3400000,
        size.width * 0.1313789,
        size.height * 0.3500000);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.3500000);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.3583340,
        size.width * 0.1230449,
        size.height * 0.3666660,
        size.width * 0.1147129,
        size.height * 0.3666660);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.3666660);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.3666660,
        size.width * 0.09804688,
        size.height * 0.3583340,
        size.width * 0.09804688,
        size.height * 0.3500000);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.3166660);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.3066660,
        size.width * 0.8730469,
        size.height * 0.3000000,
        size.width * 0.8813789,
        size.height * 0.3000000);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.3000000);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.3000000,
        size.width * 0.8980449,
        size.height * 0.3066660,
        size.width * 0.8980449,
        size.height * 0.3166660);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.3166660);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.3250000,
        size.width * 0.8897109,
        size.height * 0.3333320,
        size.width * 0.8813789,
        size.height * 0.3333320);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.3333320);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.3333340,
        size.width * 0.8647129,
        size.height * 0.3250000,
        size.width * 0.8647129,
        size.height * 0.3166660);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.2833340);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.2733340,
        size.width * 0.1047129,
        size.height * 0.2666680,
        size.width * 0.1147129,
        size.height * 0.2666680);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.2666680);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.2666680,
        size.width * 0.1313789,
        size.height * 0.2733340,
        size.width * 0.1313789,
        size.height * 0.2833340);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.2833340);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.2916680,
        size.width * 0.1230449,
        size.height * 0.3000000,
        size.width * 0.1147129,
        size.height * 0.3000000);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.3000000);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.3000000,
        size.width * 0.09804688,
        size.height * 0.2916660,
        size.width * 0.09804688,
        size.height * 0.2833340);
    path_13.close();
    path_13.moveTo(size.width * 0.8647129, size.height * 0.2500000);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.2400000,
        size.width * 0.8730469,
        size.height * 0.2333340,
        size.width * 0.8813789,
        size.height * 0.2333340);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.2333340);
    path_13.cubicTo(
        size.width * 0.8897129,
        size.height * 0.2333340,
        size.width * 0.8980449,
        size.height * 0.2400000,
        size.width * 0.8980449,
        size.height * 0.2500000);
    path_13.lineTo(size.width * 0.8980449, size.height * 0.2500000);
    path_13.cubicTo(
        size.width * 0.8980449,
        size.height * 0.2583340,
        size.width * 0.8897109,
        size.height * 0.2666660,
        size.width * 0.8813789,
        size.height * 0.2666660);
    path_13.lineTo(size.width * 0.8813789, size.height * 0.2666660);
    path_13.cubicTo(
        size.width * 0.8730469,
        size.height * 0.2666660,
        size.width * 0.8647129,
        size.height * 0.2583340,
        size.width * 0.8647129,
        size.height * 0.2500000);
    path_13.close();
    path_13.moveTo(size.width * 0.8313809, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2066660,
        size.width * 0.8397148,
        size.height * 0.2000000,
        size.width * 0.8480469,
        size.height * 0.2000000);
    path_13.lineTo(size.width * 0.8480469, size.height * 0.2000000);
    path_13.cubicTo(
        size.width * 0.8563809,
        size.height * 0.2000000,
        size.width * 0.8647129,
        size.height * 0.2066660,
        size.width * 0.8647129,
        size.height * 0.2166660);
    path_13.lineTo(size.width * 0.8647129, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.8647129,
        size.height * 0.2250000,
        size.width * 0.8563789,
        size.height * 0.2333320,
        size.width * 0.8480469,
        size.height * 0.2333320);
    path_13.lineTo(size.width * 0.8480469, size.height * 0.2333320);
    path_13.cubicTo(
        size.width * 0.8397129,
        size.height * 0.2333340,
        size.width * 0.8313809,
        size.height * 0.2250000,
        size.width * 0.8313809,
        size.height * 0.2166660);
    path_13.close();
    path_13.moveTo(size.width * 0.7647129, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.7647129,
        size.height * 0.2066660,
        size.width * 0.7730469,
        size.height * 0.2000000,
        size.width * 0.7813789,
        size.height * 0.2000000);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.2000000);
    path_13.cubicTo(
        size.width * 0.7897129,
        size.height * 0.2000000,
        size.width * 0.7980449,
        size.height * 0.2066660,
        size.width * 0.7980449,
        size.height * 0.2166660);
    path_13.lineTo(size.width * 0.7980449, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.7980449,
        size.height * 0.2250000,
        size.width * 0.7897109,
        size.height * 0.2333320,
        size.width * 0.7813789,
        size.height * 0.2333320);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.2333320);
    path_13.cubicTo(
        size.width * 0.7730469,
        size.height * 0.2333340,
        size.width * 0.7647129,
        size.height * 0.2250000,
        size.width * 0.7647129,
        size.height * 0.2166660);
    path_13.close();
    path_13.moveTo(size.width * 0.1647129, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.1647129,
        size.height * 0.2066660,
        size.width * 0.1713789,
        size.height * 0.2000000,
        size.width * 0.1813789,
        size.height * 0.2000000);
    path_13.lineTo(size.width * 0.1813789, size.height * 0.2000000);
    path_13.cubicTo(
        size.width * 0.1897129,
        size.height * 0.2000000,
        size.width * 0.1980449,
        size.height * 0.2066660,
        size.width * 0.1980449,
        size.height * 0.2166660);
    path_13.lineTo(size.width * 0.1980449, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.1980449,
        size.height * 0.2250000,
        size.width * 0.1897109,
        size.height * 0.2333320,
        size.width * 0.1813789,
        size.height * 0.2333320);
    path_13.lineTo(size.width * 0.1813789, size.height * 0.2333320);
    path_13.cubicTo(
        size.width * 0.1713809,
        size.height * 0.2333340,
        size.width * 0.1647129,
        size.height * 0.2250000,
        size.width * 0.1647129,
        size.height * 0.2166660);
    path_13.close();
    path_13.moveTo(size.width * 0.09804688, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.09804688,
        size.height * 0.2066660,
        size.width * 0.1047129,
        size.height * 0.2000000,
        size.width * 0.1147129,
        size.height * 0.2000000);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.2000000);
    path_13.cubicTo(
        size.width * 0.1230469,
        size.height * 0.2000000,
        size.width * 0.1313789,
        size.height * 0.2066660,
        size.width * 0.1313789,
        size.height * 0.2166660);
    path_13.lineTo(size.width * 0.1313789, size.height * 0.2166660);
    path_13.cubicTo(
        size.width * 0.1313789,
        size.height * 0.2250000,
        size.width * 0.1230449,
        size.height * 0.2333320,
        size.width * 0.1147129,
        size.height * 0.2333320);
    path_13.lineTo(size.width * 0.1147129, size.height * 0.2333320);
    path_13.cubicTo(
        size.width * 0.1047129,
        size.height * 0.2333340,
        size.width * 0.09804688,
        size.height * 0.2250000,
        size.width * 0.09804688,
        size.height * 0.2166660);
    path_13.close();
    path_13.moveTo(size.width * 0.1980469, size.height * 0.1833340);
    path_13.cubicTo(
        size.width * 0.1980469,
        size.height * 0.1733340,
        size.width * 0.2047129,
        size.height * 0.1666680,
        size.width * 0.2147129,
        size.height * 0.1666680);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.1666680);
    path_13.cubicTo(
        size.width * 0.2230469,
        size.height * 0.1666680,
        size.width * 0.2313789,
        size.height * 0.1733340,
        size.width * 0.2313789,
        size.height * 0.1833340);
    path_13.lineTo(size.width * 0.2313789, size.height * 0.1833340);
    path_13.cubicTo(
        size.width * 0.2313789,
        size.height * 0.1916680,
        size.width * 0.2230449,
        size.height * 0.2000000,
        size.width * 0.2147129,
        size.height * 0.2000000);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.2000000);
    path_13.cubicTo(
        size.width * 0.2047129,
        size.height * 0.2000000,
        size.width * 0.1980469,
        size.height * 0.1916660,
        size.width * 0.1980469,
        size.height * 0.1833340);
    path_13.close();
    path_13.moveTo(size.width * 0.7647129, size.height * 0.1500000);
    path_13.cubicTo(
        size.width * 0.7647129,
        size.height * 0.1400000,
        size.width * 0.7730469,
        size.height * 0.1333340,
        size.width * 0.7813789,
        size.height * 0.1333340);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.1333340);
    path_13.cubicTo(
        size.width * 0.7897129,
        size.height * 0.1333340,
        size.width * 0.7980449,
        size.height * 0.1400000,
        size.width * 0.7980449,
        size.height * 0.1500000);
    path_13.lineTo(size.width * 0.7980449, size.height * 0.1500000);
    path_13.cubicTo(
        size.width * 0.7980449,
        size.height * 0.1583340,
        size.width * 0.7897109,
        size.height * 0.1666660,
        size.width * 0.7813789,
        size.height * 0.1666660);
    path_13.lineTo(size.width * 0.7813789, size.height * 0.1666660);
    path_13.cubicTo(
        size.width * 0.7730469,
        size.height * 0.1666660,
        size.width * 0.7647129,
        size.height * 0.1583340,
        size.width * 0.7647129,
        size.height * 0.1500000);
    path_13.close();
    path_13.moveTo(size.width * 0.7313809, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.7313809,
        size.height * 0.1066660,
        size.width * 0.7397148,
        size.height * 0.1000000,
        size.width * 0.7480469,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.7480469, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.7563809,
        size.height * 0.1000000,
        size.width * 0.7647129,
        size.height * 0.1066660,
        size.width * 0.7647129,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.7647129, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.7647129,
        size.height * 0.1250000,
        size.width * 0.7563789,
        size.height * 0.1333320,
        size.width * 0.7480469,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.7480469, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.7397129,
        size.height * 0.1333340,
        size.width * 0.7313809,
        size.height * 0.1250000,
        size.width * 0.7313809,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.6647129, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.6647129,
        size.height * 0.1066660,
        size.width * 0.6730469,
        size.height * 0.1000000,
        size.width * 0.6813789,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.6813789, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.6897129,
        size.height * 0.1000000,
        size.width * 0.6980449,
        size.height * 0.1066660,
        size.width * 0.6980449,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.6980449, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.6980449,
        size.height * 0.1250000,
        size.width * 0.6897109,
        size.height * 0.1333320,
        size.width * 0.6813789,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.6813789, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.6730469,
        size.height * 0.1333340,
        size.width * 0.6647129,
        size.height * 0.1250000,
        size.width * 0.6647129,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.5980469, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.5980469,
        size.height * 0.1066660,
        size.width * 0.6063809,
        size.height * 0.1000000,
        size.width * 0.6147129,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.6147129, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.6230469,
        size.height * 0.1000000,
        size.width * 0.6313789,
        size.height * 0.1066660,
        size.width * 0.6313789,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.6313789, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.6313789,
        size.height * 0.1250000,
        size.width * 0.6230449,
        size.height * 0.1333320,
        size.width * 0.6147129,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.6147129, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.6063809,
        size.height * 0.1333340,
        size.width * 0.5980469,
        size.height * 0.1250000,
        size.width * 0.5980469,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.5313809, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.5313809,
        size.height * 0.1066660,
        size.width * 0.5397148,
        size.height * 0.1000000,
        size.width * 0.5480469,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.5480469, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.5563809,
        size.height * 0.1000000,
        size.width * 0.5647129,
        size.height * 0.1066660,
        size.width * 0.5647129,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.5647129, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.5647129,
        size.height * 0.1250000,
        size.width * 0.5563789,
        size.height * 0.1333320,
        size.width * 0.5480469,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.5480469, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.5397129,
        size.height * 0.1333340,
        size.width * 0.5313809,
        size.height * 0.1250000,
        size.width * 0.5313809,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.4647129, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.4647129,
        size.height * 0.1066660,
        size.width * 0.4713789,
        size.height * 0.1000000,
        size.width * 0.4813789,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.4813789, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.4897129,
        size.height * 0.1000000,
        size.width * 0.4980449,
        size.height * 0.1066660,
        size.width * 0.4980449,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.4980449, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.4980449,
        size.height * 0.1250000,
        size.width * 0.4897109,
        size.height * 0.1333320,
        size.width * 0.4813789,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.4813789, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.4713809,
        size.height * 0.1333340,
        size.width * 0.4647129,
        size.height * 0.1250000,
        size.width * 0.4647129,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.3980469, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.3980469,
        size.height * 0.1066660,
        size.width * 0.4047129,
        size.height * 0.1000000,
        size.width * 0.4147129,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.4147129, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.4230469,
        size.height * 0.1000000,
        size.width * 0.4313789,
        size.height * 0.1066660,
        size.width * 0.4313789,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.4313789, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.4313789,
        size.height * 0.1250000,
        size.width * 0.4230449,
        size.height * 0.1333320,
        size.width * 0.4147129,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.4147129, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.4047129,
        size.height * 0.1333340,
        size.width * 0.3980469,
        size.height * 0.1250000,
        size.width * 0.3980469,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.3313809, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.3313809,
        size.height * 0.1066660,
        size.width * 0.3380469,
        size.height * 0.1000000,
        size.width * 0.3480469,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.3480469, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.3563809,
        size.height * 0.1000000,
        size.width * 0.3647129,
        size.height * 0.1066660,
        size.width * 0.3647129,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.3647129, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.3647129,
        size.height * 0.1250000,
        size.width * 0.3563789,
        size.height * 0.1333320,
        size.width * 0.3480469,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.3480469, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.3380469,
        size.height * 0.1333340,
        size.width * 0.3313809,
        size.height * 0.1250000,
        size.width * 0.3313809,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.2647129, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.2647129,
        size.height * 0.1066660,
        size.width * 0.2713789,
        size.height * 0.1000000,
        size.width * 0.2813789,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.2813789, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.2897129,
        size.height * 0.1000000,
        size.width * 0.2980449,
        size.height * 0.1066660,
        size.width * 0.2980449,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.2980449, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.2980449,
        size.height * 0.1250000,
        size.width * 0.2897109,
        size.height * 0.1333320,
        size.width * 0.2813789,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.2813789, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.2713809,
        size.height * 0.1333340,
        size.width * 0.2647129,
        size.height * 0.1250000,
        size.width * 0.2647129,
        size.height * 0.1166660);
    path_13.close();
    path_13.moveTo(size.width * 0.1980469, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.1980469,
        size.height * 0.1066660,
        size.width * 0.2047129,
        size.height * 0.1000000,
        size.width * 0.2147129,
        size.height * 0.1000000);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.1000000);
    path_13.cubicTo(
        size.width * 0.2230469,
        size.height * 0.1000000,
        size.width * 0.2313789,
        size.height * 0.1066660,
        size.width * 0.2313789,
        size.height * 0.1166660);
    path_13.lineTo(size.width * 0.2313789, size.height * 0.1166660);
    path_13.cubicTo(
        size.width * 0.2313789,
        size.height * 0.1250000,
        size.width * 0.2230449,
        size.height * 0.1333320,
        size.width * 0.2147129,
        size.height * 0.1333320);
    path_13.lineTo(size.width * 0.2147129, size.height * 0.1333320);
    path_13.cubicTo(
        size.width * 0.2047129,
        size.height * 0.1333340,
        size.width * 0.1980469,
        size.height * 0.1250000,
        size.width * 0.1980469,
        size.height * 0.1166660);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.01471289, size.height);
    path_14.cubicTo(
        size.width * 0.009712891,
        size.height,
        size.width * 0.006378906,
        size.height * 0.9983340,
        size.width * 0.003046875,
        size.height * 0.9950000);
    path_14.cubicTo(
        size.width * -0.003619141,
        size.height * 0.9883340,
        size.width * -0.003619141,
        size.height * 0.9783340,
        size.width * 0.003046875,
        size.height * 0.9716660);
    path_14.lineTo(size.width * 0.2030469, size.height * 0.7716660);
    path_14.cubicTo(
        size.width * 0.2097129,
        size.height * 0.7650000,
        size.width * 0.2197129,
        size.height * 0.7650000,
        size.width * 0.2263809,
        size.height * 0.7716660);
    path_14.cubicTo(
        size.width * 0.2330469,
        size.height * 0.7783320,
        size.width * 0.2330469,
        size.height * 0.7883320,
        size.width * 0.2263809,
        size.height * 0.7950000);
    path_14.lineTo(size.width * 0.02638086, size.height * 0.9950000);
    path_14.cubicTo(
        size.width * 0.02304688,
        size.height * 0.9983340,
        size.width * 0.01971289,
        size.height,
        size.width * 0.01471289,
        size.height);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.01471289, size.height * 0.9000000);
    path_15.cubicTo(
        size.width * 0.009712891,
        size.height * 0.9000000,
        size.width * 0.006378906,
        size.height * 0.8983340,
        size.width * 0.003046875,
        size.height * 0.8950000);
    path_15.cubicTo(
        size.width * -0.003619141,
        size.height * 0.8883340,
        size.width * -0.003619141,
        size.height * 0.8783340,
        size.width * 0.003046875,
        size.height * 0.8716660);
    path_15.lineTo(size.width * 0.1030469, size.height * 0.7716660);
    path_15.cubicTo(
        size.width * 0.1097129,
        size.height * 0.7650000,
        size.width * 0.1197129,
        size.height * 0.7650000,
        size.width * 0.1263809,
        size.height * 0.7716660);
    path_15.cubicTo(
        size.width * 0.1330469,
        size.height * 0.7783320,
        size.width * 0.1330469,
        size.height * 0.7883320,
        size.width * 0.1263809,
        size.height * 0.7950000);
    path_15.lineTo(size.width * 0.02638086, size.height * 0.8950000);
    path_15.cubicTo(
        size.width * 0.02304688,
        size.height * 0.8983340,
        size.width * 0.01971289,
        size.height * 0.9000000,
        size.width * 0.01471289,
        size.height * 0.9000000);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.1147129, size.height);
    path_16.cubicTo(
        size.width * 0.1097129,
        size.height,
        size.width * 0.1063789,
        size.height * 0.9983340,
        size.width * 0.1030469,
        size.height * 0.9950000);
    path_16.cubicTo(
        size.width * 0.09638086,
        size.height * 0.9883340,
        size.width * 0.09638086,
        size.height * 0.9783340,
        size.width * 0.1030469,
        size.height * 0.9716660);
    path_16.lineTo(size.width * 0.2030469, size.height * 0.8716660);
    path_16.cubicTo(
        size.width * 0.2097129,
        size.height * 0.8650000,
        size.width * 0.2197129,
        size.height * 0.8650000,
        size.width * 0.2263809,
        size.height * 0.8716660);
    path_16.cubicTo(
        size.width * 0.2330469,
        size.height * 0.8783320,
        size.width * 0.2330469,
        size.height * 0.8883320,
        size.width * 0.2263809,
        size.height * 0.8950000);
    path_16.lineTo(size.width * 0.1263809, size.height * 0.9950000);
    path_16.cubicTo(
        size.width * 0.1230469,
        size.height * 0.9983340,
        size.width * 0.1197129,
        size.height,
        size.width * 0.1147129,
        size.height);
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
