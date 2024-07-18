import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop3 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop3(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.03138086, size.height * 0.8583340);
    path_0.cubicTo(
        size.width * 0.02638086,
        size.height * 0.8583340,
        size.width * 0.02304688,
        size.height * 0.8566680,
        size.width * 0.01971484,
        size.height * 0.8533340);
    path_0.cubicTo(
        size.width * 0.01638086,
        size.height * 0.8500000,
        size.width * 0.01471484,
        size.height * 0.8466680,
        size.width * 0.01471484,
        size.height * 0.8416680);
    path_0.cubicTo(
        size.width * 0.01471484,
        size.height * 0.8366680,
        size.width * 0.01638086,
        size.height * 0.8333340,
        size.width * 0.01971484,
        size.height * 0.8300020);
    path_0.cubicTo(
        size.width * 0.02638086,
        size.height * 0.8233359,
        size.width * 0.03638086,
        size.height * 0.8233359,
        size.width * 0.04304883,
        size.height * 0.8300020);
    path_0.cubicTo(
        size.width * 0.04638281,
        size.height * 0.8333359,
        size.width * 0.04804883,
        size.height * 0.8366680,
        size.width * 0.04804883,
        size.height * 0.8416680);
    path_0.cubicTo(
        size.width * 0.04804883,
        size.height * 0.8466680,
        size.width * 0.04638281,
        size.height * 0.8500020,
        size.width * 0.04304883,
        size.height * 0.8533340);
    path_0.cubicTo(
        size.width * 0.03971289,
        size.height * 0.8566660,
        size.width * 0.03638086,
        size.height * 0.8583340,
        size.width * 0.03138086,
        size.height * 0.8583340);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.01471289, size.height * 0.2416660);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.2316660,
        size.width * 0.02137891,
        size.height * 0.2250000,
        size.width * 0.03137891,
        size.height * 0.2250000);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.2250000,
        size.width * 0.04804492,
        size.height * 0.2316660,
        size.width * 0.04804492,
        size.height * 0.2416660);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.2516660,
        size.width * 0.03971094,
        size.height * 0.2583320,
        size.width * 0.03137891,
        size.height * 0.2583320);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.2583320,
        size.width * 0.01471289,
        size.height * 0.2500000,
        size.width * 0.01471289,
        size.height * 0.2416660);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.3083340);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.2983340,
        size.width * 0.02137891,
        size.height * 0.2916680,
        size.width * 0.03137891,
        size.height * 0.2916680);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.2916680,
        size.width * 0.04804492,
        size.height * 0.2983340,
        size.width * 0.04804492,
        size.height * 0.3083340);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.3183340,
        size.width * 0.03971094,
        size.height * 0.3250000,
        size.width * 0.03137891,
        size.height * 0.3250000);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.3250000,
        size.width * 0.01471289,
        size.height * 0.3166660,
        size.width * 0.01471289,
        size.height * 0.3083340);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.3750000);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.3650000,
        size.width * 0.02137891,
        size.height * 0.3583340,
        size.width * 0.03137891,
        size.height * 0.3583340);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.3583340,
        size.width * 0.04804688,
        size.height * 0.3650000,
        size.width * 0.04804688,
        size.height * 0.3750000);
    path_1.cubicTo(
        size.width * 0.04804688,
        size.height * 0.3850000,
        size.width * 0.03971289,
        size.height * 0.3916660,
        size.width * 0.03138086,
        size.height * 0.3916660);
    path_1.cubicTo(
        size.width * 0.02304883,
        size.height * 0.3916660,
        size.width * 0.01471289,
        size.height * 0.3833340,
        size.width * 0.01471289,
        size.height * 0.3750000);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.4416660);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.4333320,
        size.width * 0.02137891,
        size.height * 0.4250000,
        size.width * 0.03137891,
        size.height * 0.4250000);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.4250000,
        size.width * 0.04804492,
        size.height * 0.4333340,
        size.width * 0.04804492,
        size.height * 0.4416660);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.4516660,
        size.width * 0.03971094,
        size.height * 0.4583320,
        size.width * 0.03137891,
        size.height * 0.4583320);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.4583320,
        size.width * 0.01471289,
        size.height * 0.4500000,
        size.width * 0.01471289,
        size.height * 0.4416660);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.5083340);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.5000000,
        size.width * 0.02137891,
        size.height * 0.4916680,
        size.width * 0.03137891,
        size.height * 0.4916680);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.4916680,
        size.width * 0.04804688,
        size.height * 0.5000000,
        size.width * 0.04804688,
        size.height * 0.5083340);
    path_1.cubicTo(
        size.width * 0.04804688,
        size.height * 0.5183340,
        size.width * 0.03971289,
        size.height * 0.5250000,
        size.width * 0.03138086,
        size.height * 0.5250000);
    path_1.cubicTo(
        size.width * 0.02304883,
        size.height * 0.5250000,
        size.width * 0.01471289,
        size.height * 0.5166660,
        size.width * 0.01471289,
        size.height * 0.5083340);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.5750000);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.5666660,
        size.width * 0.02137891,
        size.height * 0.5583340,
        size.width * 0.03137891,
        size.height * 0.5583340);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.5583340,
        size.width * 0.04804492,
        size.height * 0.5666680,
        size.width * 0.04804492,
        size.height * 0.5750000);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.5850000,
        size.width * 0.03971094,
        size.height * 0.5916660,
        size.width * 0.03137891,
        size.height * 0.5916660);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.5916660,
        size.width * 0.01471289,
        size.height * 0.5833340,
        size.width * 0.01471289,
        size.height * 0.5750000);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.6416660);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.6333320,
        size.width * 0.02137891,
        size.height * 0.6250000,
        size.width * 0.03137891,
        size.height * 0.6250000);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.6250000,
        size.width * 0.04804492,
        size.height * 0.6333340,
        size.width * 0.04804492,
        size.height * 0.6416660);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.6516660,
        size.width * 0.03971094,
        size.height * 0.6583320,
        size.width * 0.03137891,
        size.height * 0.6583320);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.6583320,
        size.width * 0.01471289,
        size.height * 0.6500000,
        size.width * 0.01471289,
        size.height * 0.6416660);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.7083340);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.7000000,
        size.width * 0.02137891,
        size.height * 0.6916680,
        size.width * 0.03137891,
        size.height * 0.6916680);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.6916680,
        size.width * 0.04804492,
        size.height * 0.7000020,
        size.width * 0.04804492,
        size.height * 0.7083340);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.7166660,
        size.width * 0.03971094,
        size.height * 0.7250000,
        size.width * 0.03137891,
        size.height * 0.7250000);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.7250000,
        size.width * 0.01471289,
        size.height * 0.7166660,
        size.width * 0.01471289,
        size.height * 0.7083340);
    path_1.moveTo(size.width * 0.01471289, size.height * 0.7750000);
    path_1.cubicTo(
        size.width * 0.01471289,
        size.height * 0.7666660,
        size.width * 0.02137891,
        size.height * 0.7583340,
        size.width * 0.03137891,
        size.height * 0.7583340);
    path_1.cubicTo(
        size.width * 0.04137891,
        size.height * 0.7583340,
        size.width * 0.04804492,
        size.height * 0.7666680,
        size.width * 0.04804492,
        size.height * 0.7750000);
    path_1.cubicTo(
        size.width * 0.04804492,
        size.height * 0.7833320,
        size.width * 0.03971094,
        size.height * 0.7916660,
        size.width * 0.03137891,
        size.height * 0.7916660);
    path_1.cubicTo(
        size.width * 0.02304687,
        size.height * 0.7916660,
        size.width * 0.01471289,
        size.height * 0.7833340,
        size.width * 0.01471289,
        size.height * 0.7750000);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.03138086, size.height * 0.1916660);
    path_2.cubicTo(
        size.width * 0.02638086,
        size.height * 0.1916660,
        size.width * 0.02304688,
        size.height * 0.1900000,
        size.width * 0.01971484,
        size.height * 0.1866660);
    path_2.cubicTo(
        size.width * 0.01638086,
        size.height * 0.1833320,
        size.width * 0.01471484,
        size.height * 0.1800000,
        size.width * 0.01471484,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.01471484,
        size.height * 0.1700000,
        size.width * 0.01638086,
        size.height * 0.1666660,
        size.width * 0.01971484,
        size.height * 0.1633340);
    path_2.cubicTo(
        size.width * 0.02638086,
        size.height * 0.1566680,
        size.width * 0.03804883,
        size.height * 0.1566680,
        size.width * 0.04304883,
        size.height * 0.1633340);
    path_2.cubicTo(
        size.width * 0.04638281,
        size.height * 0.1666680,
        size.width * 0.04804883,
        size.height * 0.1700000,
        size.width * 0.04804883,
        size.height * 0.1750000);
    path_2.cubicTo(
        size.width * 0.04804883,
        size.height * 0.1800000,
        size.width * 0.04638281,
        size.height * 0.1833340,
        size.width * 0.04304883,
        size.height * 0.1866660);
    path_2.cubicTo(
        size.width * 0.03971289,
        size.height * 0.1900000,
        size.width * 0.03638086,
        size.height * 0.1916660,
        size.width * 0.03138086,
        size.height * 0.1916660);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.07971289, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.07971289,
        size.height * 0.1666660,
        size.width * 0.08637891,
        size.height * 0.1583340,
        size.width * 0.09637891,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.1063789,
        size.height * 0.1583340,
        size.width * 0.1130469,
        size.height * 0.1650000,
        size.width * 0.1130469,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.1130469,
        size.height * 0.1850000,
        size.width * 0.1063809,
        size.height * 0.1916660,
        size.width * 0.09638086,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.08638086,
        size.height * 0.1916660,
        size.width * 0.07971289,
        size.height * 0.1833340,
        size.width * 0.07971289,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.1430469, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.1430469,
        size.height * 0.1666660,
        size.width * 0.1497129,
        size.height * 0.1583340,
        size.width * 0.1597129,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.1697129,
        size.height * 0.1583340,
        size.width * 0.1763789,
        size.height * 0.1650000,
        size.width * 0.1763789,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.1763789,
        size.height * 0.1850000,
        size.width * 0.1697129,
        size.height * 0.1916660,
        size.width * 0.1597129,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.1513809,
        size.height * 0.1916660,
        size.width * 0.1430469,
        size.height * 0.1833340,
        size.width * 0.1430469,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.2080469, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.2080469,
        size.height * 0.1666660,
        size.width * 0.2147129,
        size.height * 0.1583340,
        size.width * 0.2247129,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.2347129,
        size.height * 0.1583340,
        size.width * 0.2413789,
        size.height * 0.1650000,
        size.width * 0.2413789,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.2413789,
        size.height * 0.1850000,
        size.width * 0.2347129,
        size.height * 0.1916660,
        size.width * 0.2247129,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.2147129,
        size.height * 0.1916660,
        size.width * 0.2080469,
        size.height * 0.1833340,
        size.width * 0.2080469,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.2730469, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.2730469,
        size.height * 0.1666660,
        size.width * 0.2797129,
        size.height * 0.1583340,
        size.width * 0.2897129,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.2980469,
        size.height * 0.1583340,
        size.width * 0.3063789,
        size.height * 0.1650000,
        size.width * 0.3063789,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.3063789,
        size.height * 0.1850000,
        size.width * 0.2980449,
        size.height * 0.1916660,
        size.width * 0.2897129,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.2797129,
        size.height * 0.1916660,
        size.width * 0.2730469,
        size.height * 0.1833340,
        size.width * 0.2730469,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.3363809, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.3363809,
        size.height * 0.1666660,
        size.width * 0.3447148,
        size.height * 0.1583340,
        size.width * 0.3530469,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.3630469,
        size.height * 0.1583340,
        size.width * 0.3697129,
        size.height * 0.1650000,
        size.width * 0.3697129,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.3697129,
        size.height * 0.1850000,
        size.width * 0.3630469,
        size.height * 0.1916660,
        size.width * 0.3530469,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.3447129,
        size.height * 0.1916660,
        size.width * 0.3363809,
        size.height * 0.1833340,
        size.width * 0.3363809,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.4013809, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.4013809,
        size.height * 0.1666660,
        size.width * 0.4080469,
        size.height * 0.1583340,
        size.width * 0.4180469,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.4263809,
        size.height * 0.1583340,
        size.width * 0.4347129,
        size.height * 0.1650000,
        size.width * 0.4347129,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.4347129,
        size.height * 0.1850000,
        size.width * 0.4263789,
        size.height * 0.1916660,
        size.width * 0.4180469,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.4080469,
        size.height * 0.1916660,
        size.width * 0.4013809,
        size.height * 0.1833340,
        size.width * 0.4013809,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.4663809, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.4663809,
        size.height * 0.1666660,
        size.width * 0.4730469,
        size.height * 0.1583340,
        size.width * 0.4830469,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.4930469,
        size.height * 0.1583340,
        size.width * 0.4997129,
        size.height * 0.1650000,
        size.width * 0.4997129,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.4997129,
        size.height * 0.1850000,
        size.width * 0.4930469,
        size.height * 0.1916660,
        size.width * 0.4830469,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.4730469,
        size.height * 0.1916660,
        size.width * 0.4663809,
        size.height * 0.1833340,
        size.width * 0.4663809,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.5297129, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.5297129,
        size.height * 0.1666660,
        size.width * 0.5380469,
        size.height * 0.1583340,
        size.width * 0.5463789,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.5563789,
        size.height * 0.1583340,
        size.width * 0.5630449,
        size.height * 0.1650000,
        size.width * 0.5630449,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.5630449,
        size.height * 0.1850000,
        size.width * 0.5563789,
        size.height * 0.1916660,
        size.width * 0.5463789,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.5380469,
        size.height * 0.1916660,
        size.width * 0.5297129,
        size.height * 0.1833340,
        size.width * 0.5297129,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.5947129, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.5947129,
        size.height * 0.1666660,
        size.width * 0.6030469,
        size.height * 0.1583340,
        size.width * 0.6113789,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.6213789,
        size.height * 0.1583340,
        size.width * 0.6280449,
        size.height * 0.1650000,
        size.width * 0.6280449,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.6280449,
        size.height * 0.1850000,
        size.width * 0.6213789,
        size.height * 0.1916660,
        size.width * 0.6113789,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.6013789,
        size.height * 0.1916660,
        size.width * 0.5947129,
        size.height * 0.1833340,
        size.width * 0.5947129,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.6597129, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.6597129,
        size.height * 0.1666660,
        size.width * 0.6663789,
        size.height * 0.1583340,
        size.width * 0.6763789,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.6847129,
        size.height * 0.1583340,
        size.width * 0.6930449,
        size.height * 0.1650000,
        size.width * 0.6930449,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.6930449,
        size.height * 0.1850000,
        size.width * 0.6847109,
        size.height * 0.1916660,
        size.width * 0.6763789,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.6663809,
        size.height * 0.1916660,
        size.width * 0.6597129,
        size.height * 0.1833340,
        size.width * 0.6597129,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.7230469, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.7230469,
        size.height * 0.1666660,
        size.width * 0.7313809,
        size.height * 0.1583340,
        size.width * 0.7397129,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.7497129,
        size.height * 0.1583340,
        size.width * 0.7563789,
        size.height * 0.1650000,
        size.width * 0.7563789,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.7563789,
        size.height * 0.1850000,
        size.width * 0.7497129,
        size.height * 0.1916660,
        size.width * 0.7397129,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.7313809,
        size.height * 0.1916660,
        size.width * 0.7230469,
        size.height * 0.1833340,
        size.width * 0.7230469,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.7880469, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.7880469,
        size.height * 0.1666660,
        size.width * 0.7963809,
        size.height * 0.1583340,
        size.width * 0.8047129,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.8130449,
        size.height * 0.1583340,
        size.width * 0.8213789,
        size.height * 0.1650000,
        size.width * 0.8213789,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.8213789,
        size.height * 0.1850000,
        size.width * 0.8130449,
        size.height * 0.1916660,
        size.width * 0.8047129,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.7963809,
        size.height * 0.1916660,
        size.width * 0.7880469,
        size.height * 0.1833340,
        size.width * 0.7880469,
        size.height * 0.1750000);
    path_3.moveTo(size.width * 0.8530469, size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.8530469,
        size.height * 0.1666660,
        size.width * 0.8597129,
        size.height * 0.1583340,
        size.width * 0.8697129,
        size.height * 0.1583340);
    path_3.cubicTo(
        size.width * 0.8780469,
        size.height * 0.1583340,
        size.width * 0.8863789,
        size.height * 0.1650000,
        size.width * 0.8863789,
        size.height * 0.1750000);
    path_3.cubicTo(
        size.width * 0.8863789,
        size.height * 0.1850000,
        size.width * 0.8780449,
        size.height * 0.1916660,
        size.width * 0.8697129,
        size.height * 0.1916660);
    path_3.cubicTo(
        size.width * 0.8597129,
        size.height * 0.1916660,
        size.width * 0.8530469,
        size.height * 0.1833340,
        size.width * 0.8530469,
        size.height * 0.1750000);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.07971289, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.07971289,
        size.height * 0.8333320,
        size.width * 0.08637891,
        size.height * 0.8250000,
        size.width * 0.09637891,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.1063789,
        size.height * 0.8250000,
        size.width * 0.1130449,
        size.height * 0.8333340,
        size.width * 0.1130449,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.1130449,
        size.height * 0.8499980,
        size.width * 0.1063789,
        size.height * 0.8583320,
        size.width * 0.09637891,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.08637891,
        size.height * 0.8583320,
        size.width * 0.07971289,
        size.height * 0.8500000,
        size.width * 0.07971289,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.1430469, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.1430469,
        size.height * 0.8333320,
        size.width * 0.1497129,
        size.height * 0.8250000,
        size.width * 0.1597129,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.1697129,
        size.height * 0.8250000,
        size.width * 0.1763789,
        size.height * 0.8333340,
        size.width * 0.1763789,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.1763789,
        size.height * 0.8499980,
        size.width * 0.1697129,
        size.height * 0.8583320,
        size.width * 0.1597129,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.1513809,
        size.height * 0.8583340,
        size.width * 0.1430469,
        size.height * 0.8500000,
        size.width * 0.1430469,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.2080469, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.2080469,
        size.height * 0.8333320,
        size.width * 0.2147129,
        size.height * 0.8250000,
        size.width * 0.2247129,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.2347129,
        size.height * 0.8250000,
        size.width * 0.2413789,
        size.height * 0.8333340,
        size.width * 0.2413789,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.2413789,
        size.height * 0.8499980,
        size.width * 0.2347129,
        size.height * 0.8583320,
        size.width * 0.2247129,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.2147129,
        size.height * 0.8583320,
        size.width * 0.2080469,
        size.height * 0.8500000,
        size.width * 0.2080469,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.2730469, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.2730469,
        size.height * 0.8333320,
        size.width * 0.2797129,
        size.height * 0.8250000,
        size.width * 0.2897129,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.2980469,
        size.height * 0.8250000,
        size.width * 0.3063789,
        size.height * 0.8333340,
        size.width * 0.3063789,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.3063789,
        size.height * 0.8499980,
        size.width * 0.2980449,
        size.height * 0.8583320,
        size.width * 0.2897129,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.2797129,
        size.height * 0.8583340,
        size.width * 0.2730469,
        size.height * 0.8500000,
        size.width * 0.2730469,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.3363809, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.3363809,
        size.height * 0.8333320,
        size.width * 0.3447148,
        size.height * 0.8250000,
        size.width * 0.3530469,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.3630469,
        size.height * 0.8250000,
        size.width * 0.3697129,
        size.height * 0.8333340,
        size.width * 0.3697129,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.3697129,
        size.height * 0.8499980,
        size.width * 0.3630469,
        size.height * 0.8583320,
        size.width * 0.3530469,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.3447129,
        size.height * 0.8583340,
        size.width * 0.3363809,
        size.height * 0.8500000,
        size.width * 0.3363809,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.4013809, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.4013809,
        size.height * 0.8333320,
        size.width * 0.4080469,
        size.height * 0.8250000,
        size.width * 0.4180469,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.4263809,
        size.height * 0.8250000,
        size.width * 0.4347129,
        size.height * 0.8333340,
        size.width * 0.4347129,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.4347129,
        size.height * 0.8499980,
        size.width * 0.4263789,
        size.height * 0.8583320,
        size.width * 0.4180469,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.4080469,
        size.height * 0.8583340,
        size.width * 0.4013809,
        size.height * 0.8500000,
        size.width * 0.4013809,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.4663809, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.4663809,
        size.height * 0.8333320,
        size.width * 0.4730469,
        size.height * 0.8250000,
        size.width * 0.4830469,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.4930469,
        size.height * 0.8250000,
        size.width * 0.4997129,
        size.height * 0.8333340,
        size.width * 0.4997129,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.4997129,
        size.height * 0.8499980,
        size.width * 0.4930469,
        size.height * 0.8583320,
        size.width * 0.4830469,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.4730469,
        size.height * 0.8583340,
        size.width * 0.4663809,
        size.height * 0.8500000,
        size.width * 0.4663809,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.5297129, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.5297129,
        size.height * 0.8333320,
        size.width * 0.5380469,
        size.height * 0.8250000,
        size.width * 0.5463789,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.5563789,
        size.height * 0.8250000,
        size.width * 0.5630449,
        size.height * 0.8333340,
        size.width * 0.5630449,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.5630449,
        size.height * 0.8499980,
        size.width * 0.5563789,
        size.height * 0.8583320,
        size.width * 0.5463789,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.5380469,
        size.height * 0.8583340,
        size.width * 0.5297129,
        size.height * 0.8500000,
        size.width * 0.5297129,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.5947129, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.5947129,
        size.height * 0.8333320,
        size.width * 0.6030469,
        size.height * 0.8250000,
        size.width * 0.6113789,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.6213789,
        size.height * 0.8250000,
        size.width * 0.6280449,
        size.height * 0.8333340,
        size.width * 0.6280449,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.6280449,
        size.height * 0.8499980,
        size.width * 0.6213789,
        size.height * 0.8583320,
        size.width * 0.6113789,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.6013789,
        size.height * 0.8583320,
        size.width * 0.5947129,
        size.height * 0.8500000,
        size.width * 0.5947129,
        size.height * 0.8416660);
    path_4.moveTo(size.width * 0.6597129, size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.6597129,
        size.height * 0.8333320,
        size.width * 0.6663789,
        size.height * 0.8250000,
        size.width * 0.6763789,
        size.height * 0.8250000);
    path_4.cubicTo(
        size.width * 0.6847129,
        size.height * 0.8250000,
        size.width * 0.6930449,
        size.height * 0.8333340,
        size.width * 0.6930449,
        size.height * 0.8416660);
    path_4.cubicTo(
        size.width * 0.6930449,
        size.height * 0.8499980,
        size.width * 0.6847109,
        size.height * 0.8583320,
        size.width * 0.6763789,
        size.height * 0.8583320);
    path_4.cubicTo(
        size.width * 0.6663809,
        size.height * 0.8583340,
        size.width * 0.6597129,
        size.height * 0.8500000,
        size.width * 0.6597129,
        size.height * 0.8416660);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.6647129, size.height * 0.8250000);
    path_5.lineTo(size.width * 0.9813809, size.height * 0.8250000);
    path_5.lineTo(size.width * 0.9813809, size.height * 0.1583340);
    path_5.lineTo(size.width * 0.6647129, size.height * 0.1583340);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.9980469, size.height * 0.8416660);
    path_6.lineTo(size.width * 0.6480469, size.height * 0.8416660);
    path_6.lineTo(size.width * 0.6480469, size.height * 0.1416660);
    path_6.lineTo(size.width * 0.9980469, size.height * 0.1416660);
    path_6.lineTo(size.width * 0.9980469, size.height * 0.8416660);
    path_6.close();
    path_6.moveTo(size.width * 0.6813809, size.height * 0.8083340);
    path_6.lineTo(size.width * 0.9647148, size.height * 0.8083340);
    path_6.lineTo(size.width * 0.9647148, size.height * 0.1750000);
    path_6.lineTo(size.width * 0.6813809, size.height * 0.1750000);
    path_6.lineTo(size.width * 0.6813809, size.height * 0.8083340);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.7583340);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.7500000,
        size.width * 0.004712891,
        size.height * 0.7416680,
        size.width * 0.01471289,
        size.height * 0.7416680);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.7416680);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.7416680,
        size.width * 0.03137891,
        size.height * 0.7500020,
        size.width * 0.03137891,
        size.height * 0.7583340);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.7583340);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.7666680,
        size.width * 0.02304492,
        size.height * 0.7750000,
        size.width * 0.01471289,
        size.height * 0.7750000);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.7750000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.7750000,
        size.width * -0.001953125,
        size.height * 0.7666660,
        size.width * -0.001953125,
        size.height * 0.7583340);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.6916660);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.6833320,
        size.width * 0.004712891,
        size.height * 0.6750000,
        size.width * 0.01471289,
        size.height * 0.6750000);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.6750000);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.6750000,
        size.width * 0.03137891,
        size.height * 0.6833340,
        size.width * 0.03137891,
        size.height * 0.6916660);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.6916660);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.7000000,
        size.width * 0.02304492,
        size.height * 0.7083320,
        size.width * 0.01471289,
        size.height * 0.7083320);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.7083320);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.7083340,
        size.width * -0.001953125,
        size.height * 0.7000000,
        size.width * -0.001953125,
        size.height * 0.6916660);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.6250000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.6166660,
        size.width * 0.004712891,
        size.height * 0.6083340,
        size.width * 0.01471289,
        size.height * 0.6083340);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.6083340);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.6083340,
        size.width * 0.03137891,
        size.height * 0.6166680,
        size.width * 0.03137891,
        size.height * 0.6250000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.6250000);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.6333340,
        size.width * 0.02304492,
        size.height * 0.6416660,
        size.width * 0.01471289,
        size.height * 0.6416660);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.6416660);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.6416660,
        size.width * -0.001953125,
        size.height * 0.6333340,
        size.width * -0.001953125,
        size.height * 0.6250000);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.5583340);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.5500000,
        size.width * 0.004712891,
        size.height * 0.5416680,
        size.width * 0.01471289,
        size.height * 0.5416680);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.5416680);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.5416680,
        size.width * 0.03137891,
        size.height * 0.5500020,
        size.width * 0.03137891,
        size.height * 0.5583340);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.5583340);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.5666680,
        size.width * 0.02304492,
        size.height * 0.5750000,
        size.width * 0.01471289,
        size.height * 0.5750000);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.5750000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5750000,
        size.width * -0.001953125,
        size.height * 0.5666660,
        size.width * -0.001953125,
        size.height * 0.5583340);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.4916660);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4816660,
        size.width * 0.004712891,
        size.height * 0.4750000,
        size.width * 0.01471289,
        size.height * 0.4750000);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.4750000);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.4750000,
        size.width * 0.03137891,
        size.height * 0.4816660,
        size.width * 0.03137891,
        size.height * 0.4916660);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.4916660);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.5000000,
        size.width * 0.02304492,
        size.height * 0.5083320,
        size.width * 0.01471289,
        size.height * 0.5083320);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.5083320);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5083340,
        size.width * -0.001953125,
        size.height * 0.5000000,
        size.width * -0.001953125,
        size.height * 0.4916660);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.4250000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4150000,
        size.width * 0.004712891,
        size.height * 0.4083340,
        size.width * 0.01471289,
        size.height * 0.4083340);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.4083340);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.4083340,
        size.width * 0.03137891,
        size.height * 0.4150000,
        size.width * 0.03137891,
        size.height * 0.4250000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.4250000);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.4333340,
        size.width * 0.02304492,
        size.height * 0.4416660,
        size.width * 0.01471289,
        size.height * 0.4416660);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.4416660);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.4416660,
        size.width * -0.001953125,
        size.height * 0.4333340,
        size.width * -0.001953125,
        size.height * 0.4250000);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.3583340);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.3483340,
        size.width * 0.004712891,
        size.height * 0.3416680,
        size.width * 0.01471289,
        size.height * 0.3416680);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.3416680);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.3416680,
        size.width * 0.03137891,
        size.height * 0.3483340,
        size.width * 0.03137891,
        size.height * 0.3583340);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.3583340);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.3666680,
        size.width * 0.02304492,
        size.height * 0.3750000,
        size.width * 0.01471289,
        size.height * 0.3750000);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.3750000);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.3750000,
        size.width * -0.001953125,
        size.height * 0.3666660,
        size.width * -0.001953125,
        size.height * 0.3583340);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.2916660);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.2816660,
        size.width * 0.004712891,
        size.height * 0.2750000,
        size.width * 0.01471289,
        size.height * 0.2750000);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.2750000);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.2750000,
        size.width * 0.03137891,
        size.height * 0.2816660,
        size.width * 0.03137891,
        size.height * 0.2916660);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.2916660);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.3000000,
        size.width * 0.02304492,
        size.height * 0.3083320,
        size.width * 0.01471289,
        size.height * 0.3083320);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.3083320);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.3083340,
        size.width * -0.001953125,
        size.height * 0.3000000,
        size.width * -0.001953125,
        size.height * 0.2916660);
    path_7.close();
    path_7.moveTo(size.width * -0.001953125, size.height * 0.2250000);
    path_7.cubicTo(
        size.width * -0.001953125,
        size.height * 0.2150000,
        size.width * 0.004712891,
        size.height * 0.2083340,
        size.width * 0.01471289,
        size.height * 0.2083340);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.2083340);
    path_7.cubicTo(
        size.width * 0.02304688,
        size.height * 0.2083340,
        size.width * 0.03137891,
        size.height * 0.2150000,
        size.width * 0.03137891,
        size.height * 0.2250000);
    path_7.lineTo(size.width * 0.03137891, size.height * 0.2250000);
    path_7.cubicTo(
        size.width * 0.03137891,
        size.height * 0.2333340,
        size.width * 0.02304492,
        size.height * 0.2416660,
        size.width * 0.01471289,
        size.height * 0.2416660);
    path_7.lineTo(size.width * 0.01471289, size.height * 0.2416660);
    path_7.cubicTo(
        size.width * 0.004712891,
        size.height * 0.2416660,
        size.width * -0.001953125,
        size.height * 0.2333340,
        size.width * -0.001953125,
        size.height * 0.2250000);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.8997129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.8997129,
        size.height * 0.1483340,
        size.width * 0.9063789,
        size.height * 0.1416680,
        size.width * 0.9163789,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.9163789, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.9247129,
        size.height * 0.1416680,
        size.width * 0.9330449,
        size.height * 0.1483340,
        size.width * 0.9330449,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.9330449, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.9330449,
        size.height * 0.1666680,
        size.width * 0.9247109,
        size.height * 0.1750000,
        size.width * 0.9163789,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.9163789, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.9080469,
        size.height * 0.1750000,
        size.width * 0.8997129,
        size.height * 0.1666660,
        size.width * 0.8997129,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.8363809, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.8363809,
        size.height * 0.1483340,
        size.width * 0.8447148,
        size.height * 0.1416680,
        size.width * 0.8530469,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.8530469, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.8613809,
        size.height * 0.1416680,
        size.width * 0.8697129,
        size.height * 0.1483340,
        size.width * 0.8697129,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.8697129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.8697129,
        size.height * 0.1666680,
        size.width * 0.8613789,
        size.height * 0.1750000,
        size.width * 0.8530469,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.8530469, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.8430469,
        size.height * 0.1750000,
        size.width * 0.8363809,
        size.height * 0.1666660,
        size.width * 0.8363809,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.7713809, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.7713809,
        size.height * 0.1483340,
        size.width * 0.7797148,
        size.height * 0.1416680,
        size.width * 0.7880469,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.7880469, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.7980469,
        size.height * 0.1416680,
        size.width * 0.8047129,
        size.height * 0.1483340,
        size.width * 0.8047129,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.8047129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.8047129,
        size.height * 0.1666680,
        size.width * 0.7980469,
        size.height * 0.1750000,
        size.width * 0.7880469,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.7880469, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.7780469,
        size.height * 0.1750000,
        size.width * 0.7713809,
        size.height * 0.1666660,
        size.width * 0.7713809,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.7063809, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.7063809,
        size.height * 0.1483340,
        size.width * 0.7130469,
        size.height * 0.1416680,
        size.width * 0.7230469,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.7230469, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.7313809,
        size.height * 0.1416680,
        size.width * 0.7397129,
        size.height * 0.1483340,
        size.width * 0.7397129,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.7397129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.7397129,
        size.height * 0.1666680,
        size.width * 0.7313789,
        size.height * 0.1750000,
        size.width * 0.7230469,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.7230469, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.7147129,
        size.height * 0.1750000,
        size.width * 0.7063809,
        size.height * 0.1666660,
        size.width * 0.7063809,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.6430469, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.6430469,
        size.height * 0.1483340,
        size.width * 0.6513809,
        size.height * 0.1416680,
        size.width * 0.6597129,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.6597129, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.6680469,
        size.height * 0.1416680,
        size.width * 0.6763789,
        size.height * 0.1483340,
        size.width * 0.6763789,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.6763789, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.6763789,
        size.height * 0.1666680,
        size.width * 0.6680449,
        size.height * 0.1750000,
        size.width * 0.6597129,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.6597129, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.6497129,
        size.height * 0.1750000,
        size.width * 0.6430469,
        size.height * 0.1666660,
        size.width * 0.6430469,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.5780469, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.5780469,
        size.height * 0.1483340,
        size.width * 0.5863809,
        size.height * 0.1416680,
        size.width * 0.5947129,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.5947129, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.6030469,
        size.height * 0.1416680,
        size.width * 0.6113789,
        size.height * 0.1483340,
        size.width * 0.6113789,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.6113789, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.6113789,
        size.height * 0.1666680,
        size.width * 0.6030449,
        size.height * 0.1750000,
        size.width * 0.5947129,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.5947129, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.5847129,
        size.height * 0.1750000,
        size.width * 0.5780469,
        size.height * 0.1666660,
        size.width * 0.5780469,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.5130469, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.5130469,
        size.height * 0.1483340,
        size.width * 0.5197129,
        size.height * 0.1416680,
        size.width * 0.5297129,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.5297129, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.5397129,
        size.height * 0.1416680,
        size.width * 0.5463789,
        size.height * 0.1483340,
        size.width * 0.5463789,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.5463789, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.5463789,
        size.height * 0.1666680,
        size.width * 0.5397129,
        size.height * 0.1750000,
        size.width * 0.5297129,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.5297129, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.5213809,
        size.height * 0.1750000,
        size.width * 0.5130469,
        size.height * 0.1666660,
        size.width * 0.5130469,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.4497129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.4497129,
        size.height * 0.1483340,
        size.width * 0.4580469,
        size.height * 0.1416680,
        size.width * 0.4663789,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.4663789, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.4747129,
        size.height * 0.1416680,
        size.width * 0.4830449,
        size.height * 0.1483340,
        size.width * 0.4830449,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.4830449, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.4830449,
        size.height * 0.1666680,
        size.width * 0.4747109,
        size.height * 0.1750000,
        size.width * 0.4663789,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.4663789, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.4563809,
        size.height * 0.1750000,
        size.width * 0.4497129,
        size.height * 0.1666660,
        size.width * 0.4497129,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.3847129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.3847129,
        size.height * 0.1483340,
        size.width * 0.3930469,
        size.height * 0.1416680,
        size.width * 0.4013789,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.4013789, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.4113789,
        size.height * 0.1416680,
        size.width * 0.4180449,
        size.height * 0.1483340,
        size.width * 0.4180449,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.4180449, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.4180449,
        size.height * 0.1666680,
        size.width * 0.4113789,
        size.height * 0.1750000,
        size.width * 0.4013789,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.4013789, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.3913809,
        size.height * 0.1750000,
        size.width * 0.3847129,
        size.height * 0.1666660,
        size.width * 0.3847129,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.3197129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.3197129,
        size.height * 0.1483340,
        size.width * 0.3280469,
        size.height * 0.1416680,
        size.width * 0.3363789,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.3363789, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.3463789,
        size.height * 0.1416680,
        size.width * 0.3530449,
        size.height * 0.1483340,
        size.width * 0.3530449,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.3530449, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.3530449,
        size.height * 0.1666680,
        size.width * 0.3447109,
        size.height * 0.1750000,
        size.width * 0.3363789,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.3363789, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.3280469,
        size.height * 0.1750000,
        size.width * 0.3197129,
        size.height * 0.1666660,
        size.width * 0.3197129,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.2563809, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.2563809,
        size.height * 0.1483340,
        size.width * 0.2647148,
        size.height * 0.1416680,
        size.width * 0.2730469,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.2730469, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.2830469,
        size.height * 0.1416680,
        size.width * 0.2897129,
        size.height * 0.1483340,
        size.width * 0.2897129,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.2897129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.2897129,
        size.height * 0.1666680,
        size.width * 0.2830469,
        size.height * 0.1750000,
        size.width * 0.2730469,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.2730469, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.2630469,
        size.height * 0.1750000,
        size.width * 0.2563809,
        size.height * 0.1666660,
        size.width * 0.2563809,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.1913809, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.1913809,
        size.height * 0.1483340,
        size.width * 0.1997148,
        size.height * 0.1416680,
        size.width * 0.2080469,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.2080469, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.2180469,
        size.height * 0.1416680,
        size.width * 0.2247129,
        size.height * 0.1483340,
        size.width * 0.2247129,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.2247129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.2247129,
        size.height * 0.1666680,
        size.width * 0.2180469,
        size.height * 0.1750000,
        size.width * 0.2080469,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.2080469, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.1980469,
        size.height * 0.1750000,
        size.width * 0.1913809,
        size.height * 0.1666660,
        size.width * 0.1913809,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.1263809, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.1263809,
        size.height * 0.1483340,
        size.width * 0.1330469,
        size.height * 0.1416680,
        size.width * 0.1430469,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.1430469, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.1530469,
        size.height * 0.1416680,
        size.width * 0.1597129,
        size.height * 0.1483340,
        size.width * 0.1597129,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.1597129, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.1597129,
        size.height * 0.1666680,
        size.width * 0.1530469,
        size.height * 0.1750000,
        size.width * 0.1430469,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.1430469, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.1347129,
        size.height * 0.1750000,
        size.width * 0.1263809,
        size.height * 0.1666660,
        size.width * 0.1263809,
        size.height * 0.1583340);
    path_8.close();
    path_8.moveTo(size.width * 0.06304688, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.06304688,
        size.height * 0.1483340,
        size.width * 0.06971289,
        size.height * 0.1416680,
        size.width * 0.07971289,
        size.height * 0.1416680);
    path_8.lineTo(size.width * 0.07971289, size.height * 0.1416680);
    path_8.cubicTo(
        size.width * 0.08971289,
        size.height * 0.1416680,
        size.width * 0.09637891,
        size.height * 0.1483340,
        size.width * 0.09637891,
        size.height * 0.1583340);
    path_8.lineTo(size.width * 0.09637891, size.height * 0.1583340);
    path_8.cubicTo(
        size.width * 0.09637891,
        size.height * 0.1666680,
        size.width * 0.08971289,
        size.height * 0.1750000,
        size.width * 0.07971289,
        size.height * 0.1750000);
    path_8.lineTo(size.width * 0.07971289, size.height * 0.1750000);
    path_8.cubicTo(
        size.width * 0.06971289,
        size.height * 0.1750000,
        size.width * 0.06304688,
        size.height * 0.1666660,
        size.width * 0.06304688,
        size.height * 0.1583340);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.7583340);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.7500000,
        size.width * 0.9730469,
        size.height * 0.7416680,
        size.width * 0.9813789,
        size.height * 0.7416680);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.7416680);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.7416680,
        size.width * 0.9980449,
        size.height * 0.7500020,
        size.width * 0.9980449,
        size.height * 0.7583340);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.7583340);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.7666680,
        size.width * 0.9897109,
        size.height * 0.7750000,
        size.width * 0.9813789,
        size.height * 0.7750000);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.7750000);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.7750000,
        size.width * 0.9647129,
        size.height * 0.7666660,
        size.width * 0.9647129,
        size.height * 0.7583340);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.6916660);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.6816660,
        size.width * 0.9730469,
        size.height * 0.6750000,
        size.width * 0.9813789,
        size.height * 0.6750000);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.6750000);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.6750000,
        size.width * 0.9980449,
        size.height * 0.6816660,
        size.width * 0.9980449,
        size.height * 0.6916660);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.6916660);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.7000000,
        size.width * 0.9897109,
        size.height * 0.7083320,
        size.width * 0.9813789,
        size.height * 0.7083320);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.7083320);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.7083340,
        size.width * 0.9647129,
        size.height * 0.7000000,
        size.width * 0.9647129,
        size.height * 0.6916660);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.6250000);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.6166660,
        size.width * 0.9730469,
        size.height * 0.6083340,
        size.width * 0.9813789,
        size.height * 0.6083340);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.6083340);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.6083340,
        size.width * 0.9980449,
        size.height * 0.6166680,
        size.width * 0.9980449,
        size.height * 0.6250000);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.6250000);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.6333340,
        size.width * 0.9897109,
        size.height * 0.6416660,
        size.width * 0.9813789,
        size.height * 0.6416660);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.6416660);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.6416660,
        size.width * 0.9647129,
        size.height * 0.6333340,
        size.width * 0.9647129,
        size.height * 0.6250000);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.5583340);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.5483340,
        size.width * 0.9730469,
        size.height * 0.5416680,
        size.width * 0.9813789,
        size.height * 0.5416680);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.5416680);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.5416680,
        size.width * 0.9980449,
        size.height * 0.5483340,
        size.width * 0.9980449,
        size.height * 0.5583340);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.5583340);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.5666680,
        size.width * 0.9897109,
        size.height * 0.5750000,
        size.width * 0.9813789,
        size.height * 0.5750000);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.5750000);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.5750000,
        size.width * 0.9647129,
        size.height * 0.5666660,
        size.width * 0.9647129,
        size.height * 0.5583340);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.4916660);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.4816660,
        size.width * 0.9730469,
        size.height * 0.4750000,
        size.width * 0.9813789,
        size.height * 0.4750000);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.4750000);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.4750000,
        size.width * 0.9980449,
        size.height * 0.4816660,
        size.width * 0.9980449,
        size.height * 0.4916660);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.4916660);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.5000000,
        size.width * 0.9897109,
        size.height * 0.5083320,
        size.width * 0.9813789,
        size.height * 0.5083320);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.5083320);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.5083340,
        size.width * 0.9647129,
        size.height * 0.5000000,
        size.width * 0.9647129,
        size.height * 0.4916660);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.4250000);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.4150000,
        size.width * 0.9730469,
        size.height * 0.4083340,
        size.width * 0.9813789,
        size.height * 0.4083340);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.4083340);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.4083340,
        size.width * 0.9980449,
        size.height * 0.4150000,
        size.width * 0.9980449,
        size.height * 0.4250000);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.4250000);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.4333340,
        size.width * 0.9897109,
        size.height * 0.4416660,
        size.width * 0.9813789,
        size.height * 0.4416660);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.4416660);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.4416660,
        size.width * 0.9647129,
        size.height * 0.4333340,
        size.width * 0.9647129,
        size.height * 0.4250000);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.3583340);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.3483340,
        size.width * 0.9730469,
        size.height * 0.3416680,
        size.width * 0.9813789,
        size.height * 0.3416680);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.3416680);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.3416680,
        size.width * 0.9980449,
        size.height * 0.3483340,
        size.width * 0.9980449,
        size.height * 0.3583340);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.3583340);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.3666680,
        size.width * 0.9897109,
        size.height * 0.3750000,
        size.width * 0.9813789,
        size.height * 0.3750000);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.3750000);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.3750000,
        size.width * 0.9647129,
        size.height * 0.3666660,
        size.width * 0.9647129,
        size.height * 0.3583340);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.2916660);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.2816660,
        size.width * 0.9730469,
        size.height * 0.2750000,
        size.width * 0.9813789,
        size.height * 0.2750000);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.2750000);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.2750000,
        size.width * 0.9980449,
        size.height * 0.2816660,
        size.width * 0.9980449,
        size.height * 0.2916660);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.2916660);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.3000000,
        size.width * 0.9897109,
        size.height * 0.3083320,
        size.width * 0.9813789,
        size.height * 0.3083320);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.3083320);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.3083340,
        size.width * 0.9647129,
        size.height * 0.3000000,
        size.width * 0.9647129,
        size.height * 0.2916660);
    path_9.close();
    path_9.moveTo(size.width * 0.9647129, size.height * 0.2250000);
    path_9.cubicTo(
        size.width * 0.9647129,
        size.height * 0.2150000,
        size.width * 0.9730469,
        size.height * 0.2083340,
        size.width * 0.9813789,
        size.height * 0.2083340);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.2083340);
    path_9.cubicTo(
        size.width * 0.9897129,
        size.height * 0.2083340,
        size.width * 0.9980449,
        size.height * 0.2150000,
        size.width * 0.9980449,
        size.height * 0.2250000);
    path_9.lineTo(size.width * 0.9980449, size.height * 0.2250000);
    path_9.cubicTo(
        size.width * 0.9980449,
        size.height * 0.2333340,
        size.width * 0.9897109,
        size.height * 0.2416660,
        size.width * 0.9813789,
        size.height * 0.2416660);
    path_9.lineTo(size.width * 0.9813789, size.height * 0.2416660);
    path_9.cubicTo(
        size.width * 0.9730469,
        size.height * 0.2416660,
        size.width * 0.9647129,
        size.height * 0.2333340,
        size.width * 0.9647129,
        size.height * 0.2250000);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.8997129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.8997129,
        size.height * 0.8166660,
        size.width * 0.9080469,
        size.height * 0.8083340,
        size.width * 0.9163789,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.9163789, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.9263789,
        size.height * 0.8083340,
        size.width * 0.9330449,
        size.height * 0.8166680,
        size.width * 0.9330449,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.9330449, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.9330449,
        size.height * 0.8333340,
        size.width * 0.9263789,
        size.height * 0.8416660,
        size.width * 0.9163789,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.9163789, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.9080469,
        size.height * 0.8416660,
        size.width * 0.8997129,
        size.height * 0.8333340,
        size.width * 0.8997129,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.8363809, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.8363809,
        size.height * 0.8166660,
        size.width * 0.8430469,
        size.height * 0.8083340,
        size.width * 0.8530469,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.8530469, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.8613809,
        size.height * 0.8083340,
        size.width * 0.8697129,
        size.height * 0.8166680,
        size.width * 0.8697129,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.8697129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.8697129,
        size.height * 0.8333340,
        size.width * 0.8613789,
        size.height * 0.8416660,
        size.width * 0.8530469,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.8530469, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.8430469,
        size.height * 0.8416660,
        size.width * 0.8363809,
        size.height * 0.8333340,
        size.width * 0.8363809,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.7713809, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.7713809,
        size.height * 0.8166660,
        size.width * 0.7797148,
        size.height * 0.8083340,
        size.width * 0.7880469,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.7880469, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.7980469,
        size.height * 0.8083340,
        size.width * 0.8047129,
        size.height * 0.8166680,
        size.width * 0.8047129,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.8047129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.8047129,
        size.height * 0.8333340,
        size.width * 0.7980469,
        size.height * 0.8416660,
        size.width * 0.7880469,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.7880469, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.7780469,
        size.height * 0.8416660,
        size.width * 0.7713809,
        size.height * 0.8333340,
        size.width * 0.7713809,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.7063809, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.7063809,
        size.height * 0.8166660,
        size.width * 0.7130469,
        size.height * 0.8083340,
        size.width * 0.7230469,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.7230469, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.7313809,
        size.height * 0.8083340,
        size.width * 0.7397129,
        size.height * 0.8166680,
        size.width * 0.7397129,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.7397129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.7397129,
        size.height * 0.8333340,
        size.width * 0.7313789,
        size.height * 0.8416660,
        size.width * 0.7230469,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.7230469, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.7147129,
        size.height * 0.8416660,
        size.width * 0.7063809,
        size.height * 0.8333340,
        size.width * 0.7063809,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.6430469, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.6430469,
        size.height * 0.8166660,
        size.width * 0.6497129,
        size.height * 0.8083340,
        size.width * 0.6597129,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.6597129, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.6680469,
        size.height * 0.8083340,
        size.width * 0.6763789,
        size.height * 0.8166680,
        size.width * 0.6763789,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.6763789, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.6763789,
        size.height * 0.8333340,
        size.width * 0.6697129,
        size.height * 0.8416660,
        size.width * 0.6597129,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.6597129, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.6497129,
        size.height * 0.8416660,
        size.width * 0.6430469,
        size.height * 0.8333340,
        size.width * 0.6430469,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.5780469, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.5780469,
        size.height * 0.8166660,
        size.width * 0.5863809,
        size.height * 0.8083340,
        size.width * 0.5947129,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.5947129, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.6030469,
        size.height * 0.8083340,
        size.width * 0.6113789,
        size.height * 0.8166680,
        size.width * 0.6113789,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.6113789, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.6113789,
        size.height * 0.8333340,
        size.width * 0.6030449,
        size.height * 0.8416660,
        size.width * 0.5947129,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.5947129, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.5847129,
        size.height * 0.8416660,
        size.width * 0.5780469,
        size.height * 0.8333340,
        size.width * 0.5780469,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.5130469, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.5130469,
        size.height * 0.8166660,
        size.width * 0.5213809,
        size.height * 0.8083340,
        size.width * 0.5297129,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.5297129, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.5380469,
        size.height * 0.8083340,
        size.width * 0.5463789,
        size.height * 0.8166680,
        size.width * 0.5463789,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.5463789, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.5463789,
        size.height * 0.8333340,
        size.width * 0.5380449,
        size.height * 0.8416660,
        size.width * 0.5297129,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.5297129, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.5213809,
        size.height * 0.8416660,
        size.width * 0.5130469,
        size.height * 0.8333340,
        size.width * 0.5130469,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.4497129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.4497129,
        size.height * 0.8166660,
        size.width * 0.4563789,
        size.height * 0.8083340,
        size.width * 0.4663789,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.4663789, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.4763789,
        size.height * 0.8083340,
        size.width * 0.4830449,
        size.height * 0.8166680,
        size.width * 0.4830449,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.4830449, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.4830449,
        size.height * 0.8333340,
        size.width * 0.4763789,
        size.height * 0.8416660,
        size.width * 0.4663789,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.4663789, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.4563809,
        size.height * 0.8416660,
        size.width * 0.4497129,
        size.height * 0.8333340,
        size.width * 0.4497129,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.3847129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.3847129,
        size.height * 0.8166660,
        size.width * 0.3913789,
        size.height * 0.8083340,
        size.width * 0.4013789,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.4013789, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.4113789,
        size.height * 0.8083340,
        size.width * 0.4180449,
        size.height * 0.8166680,
        size.width * 0.4180449,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.4180449, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.4180449,
        size.height * 0.8333340,
        size.width * 0.4113789,
        size.height * 0.8416660,
        size.width * 0.4013789,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.4013789, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.3913809,
        size.height * 0.8416660,
        size.width * 0.3847129,
        size.height * 0.8333340,
        size.width * 0.3847129,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.3197129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.3197129,
        size.height * 0.8166660,
        size.width * 0.3280469,
        size.height * 0.8083340,
        size.width * 0.3363789,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.3363789, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.3463789,
        size.height * 0.8083340,
        size.width * 0.3530449,
        size.height * 0.8166680,
        size.width * 0.3530449,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.3530449, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.3530449,
        size.height * 0.8333340,
        size.width * 0.3463789,
        size.height * 0.8416660,
        size.width * 0.3363789,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.3363789, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.3280469,
        size.height * 0.8416660,
        size.width * 0.3197129,
        size.height * 0.8333340,
        size.width * 0.3197129,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.2563809, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.2563809,
        size.height * 0.8166660,
        size.width * 0.2630469,
        size.height * 0.8083340,
        size.width * 0.2730469,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.2730469, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.2830469,
        size.height * 0.8083340,
        size.width * 0.2897129,
        size.height * 0.8166680,
        size.width * 0.2897129,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.2897129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.2897129,
        size.height * 0.8333340,
        size.width * 0.2830469,
        size.height * 0.8416660,
        size.width * 0.2730469,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.2730469, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.2630469,
        size.height * 0.8416660,
        size.width * 0.2563809,
        size.height * 0.8333340,
        size.width * 0.2563809,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.1913809, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.1913809,
        size.height * 0.8166660,
        size.width * 0.1980469,
        size.height * 0.8083340,
        size.width * 0.2080469,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.2080469, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.2180469,
        size.height * 0.8083340,
        size.width * 0.2247129,
        size.height * 0.8166680,
        size.width * 0.2247129,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.2247129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.2247129,
        size.height * 0.8333340,
        size.width * 0.2180469,
        size.height * 0.8416660,
        size.width * 0.2080469,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.2080469, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.1980469,
        size.height * 0.8416660,
        size.width * 0.1913809,
        size.height * 0.8333340,
        size.width * 0.1913809,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.1263809, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.1263809,
        size.height * 0.8166660,
        size.width * 0.1330469,
        size.height * 0.8083340,
        size.width * 0.1430469,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.1430469, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.1513809,
        size.height * 0.8083340,
        size.width * 0.1597129,
        size.height * 0.8166680,
        size.width * 0.1597129,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.1597129, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.1597129,
        size.height * 0.8333340,
        size.width * 0.1513789,
        size.height * 0.8416660,
        size.width * 0.1430469,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.1430469, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.1347129,
        size.height * 0.8416660,
        size.width * 0.1263809,
        size.height * 0.8333340,
        size.width * 0.1263809,
        size.height * 0.8250000);
    path_10.close();
    path_10.moveTo(size.width * 0.06304688, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.06304688,
        size.height * 0.8166660,
        size.width * 0.07138086,
        size.height * 0.8083340,
        size.width * 0.07971289,
        size.height * 0.8083340);
    path_10.lineTo(size.width * 0.07971289, size.height * 0.8083340);
    path_10.cubicTo(
        size.width * 0.08804688,
        size.height * 0.8083340,
        size.width * 0.09637891,
        size.height * 0.8166680,
        size.width * 0.09637891,
        size.height * 0.8250000);
    path_10.lineTo(size.width * 0.09637891, size.height * 0.8250000);
    path_10.cubicTo(
        size.width * 0.09637891,
        size.height * 0.8333340,
        size.width * 0.08804492,
        size.height * 0.8416660,
        size.width * 0.07971289,
        size.height * 0.8416660);
    path_10.lineTo(size.width * 0.07971289, size.height * 0.8416660);
    path_10.cubicTo(
        size.width * 0.06971289,
        size.height * 0.8416660,
        size.width * 0.06304688,
        size.height * 0.8333340,
        size.width * 0.06304688,
        size.height * 0.8250000);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.9980469, size.height * 0.8416660);
    path_11.lineTo(size.width * 0.6480469, size.height * 0.8416660);
    path_11.lineTo(size.width * 0.6480469, size.height * 0.1416660);
    path_11.lineTo(size.width * 0.9980469, size.height * 0.1416660);
    path_11.lineTo(size.width * 0.9980469, size.height * 0.8416660);
    path_11.close();
    path_11.moveTo(size.width * 0.6813809, size.height * 0.8083340);
    path_11.lineTo(size.width * 0.9647148, size.height * 0.8083340);
    path_11.lineTo(size.width * 0.9647148, size.height * 0.1750000);
    path_11.lineTo(size.width * 0.6813809, size.height * 0.1750000);
    path_11.lineTo(size.width * 0.6813809, size.height * 0.8083340);
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
