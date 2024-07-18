import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop7 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop7(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9147129, size.height * 0.2833340);
    path_0.cubicTo(
        size.width * 0.9113789,
        size.height * 0.2833340,
        size.width * 0.9080469,
        size.height * 0.2816680,
        size.width * 0.9047129,
        size.height * 0.2800000);
    path_0.lineTo(size.width * 0.8380469, size.height * 0.2300000);
    path_0.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2250000,
        size.width * 0.8297129,
        size.height * 0.2133340,
        size.width * 0.8347129,
        size.height * 0.2066660);
    path_0.cubicTo(
        size.width * 0.8397129,
        size.height * 0.1999980,
        size.width * 0.8513789,
        size.height * 0.1983320,
        size.width * 0.8580469,
        size.height * 0.2033320);
    path_0.lineTo(size.width * 0.9247129, size.height * 0.2533320);
    path_0.cubicTo(
        size.width * 0.9313789,
        size.height * 0.2583320,
        size.width * 0.9330469,
        size.height * 0.2699980,
        size.width * 0.9280469,
        size.height * 0.2766660);
    path_0.cubicTo(
        size.width * 0.9247129,
        size.height * 0.2816660,
        size.width * 0.9197129,
        size.height * 0.2833340,
        size.width * 0.9147129,
        size.height * 0.2833340);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9147129, size.height * 0.2833340);
    path_1.cubicTo(
        size.width * 0.9113789,
        size.height * 0.2833340,
        size.width * 0.9097129,
        size.height * 0.2833340,
        size.width * 0.9080469,
        size.height * 0.2816680);
    path_1.cubicTo(
        size.width * 0.9013809,
        size.height * 0.2783340,
        size.width * 0.8980469,
        size.height * 0.2733340,
        size.width * 0.8980469,
        size.height * 0.2666680);
    path_1.lineTo(size.width * 0.8980469, size.height * 0.2333340);
    path_1.cubicTo(
        size.width * 0.8980469,
        size.height * 0.1233340,
        size.width * 0.8080469,
        size.height * 0.03333398,
        size.width * 0.6980469,
        size.height * 0.03333398);
    path_1.cubicTo(
        size.width * 0.6880469,
        size.height * 0.03333398,
        size.width * 0.6813809,
        size.height * 0.02666797,
        size.width * 0.6813809,
        size.height * 0.01666797);
    path_1.cubicTo(size.width * 0.6813809, size.height * 0.006667969,
        size.width * 0.6880469, 0, size.width * 0.6980469, 0);
    path_1.cubicTo(
        size.width * 0.8263809,
        0,
        size.width * 0.9313809,
        size.height * 0.1050000,
        size.width * 0.9313809,
        size.height * 0.2333340);
    path_1.lineTo(size.width * 0.9713809, size.height * 0.2033340);
    path_1.cubicTo(
        size.width * 0.9780469,
        size.height * 0.1983340,
        size.width * 0.9897148,
        size.height * 0.2000000,
        size.width * 0.9947148,
        size.height * 0.2066680);
    path_1.cubicTo(
        size.width * 0.9997148,
        size.height * 0.2133340,
        size.width * 0.9980488,
        size.height * 0.2250020,
        size.width * 0.9913809,
        size.height * 0.2300020);
    path_1.lineTo(size.width * 0.9247148, size.height * 0.2800020);
    path_1.cubicTo(
        size.width * 0.9213809,
        size.height * 0.2816660,
        size.width * 0.9180469,
        size.height * 0.2833340,
        size.width * 0.9147129,
        size.height * 0.2833340);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffB0B6BB).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1647129, size.height * 0.8000000);
    path_2.cubicTo(
        size.width * 0.1613789,
        size.height * 0.8000000,
        size.width * 0.1580469,
        size.height * 0.7983340,
        size.width * 0.1547129,
        size.height * 0.7966660);
    path_2.lineTo(size.width * 0.08804687, size.height * 0.7466660);
    path_2.cubicTo(
        size.width * 0.08138086,
        size.height * 0.7416660,
        size.width * 0.07971289,
        size.height * 0.7300000,
        size.width * 0.08471289,
        size.height * 0.7233320);
    path_2.cubicTo(
        size.width * 0.08971289,
        size.height * 0.7166660,
        size.width * 0.1013789,
        size.height * 0.7149980,
        size.width * 0.1080469,
        size.height * 0.7199980);
    path_2.lineTo(size.width * 0.1747129, size.height * 0.7699980);
    path_2.cubicTo(
        size.width * 0.1813789,
        size.height * 0.7749980,
        size.width * 0.1830469,
        size.height * 0.7866641,
        size.width * 0.1780469,
        size.height * 0.7933320);
    path_2.cubicTo(
        size.width * 0.1747129,
        size.height * 0.7983340,
        size.width * 0.1697129,
        size.height * 0.8000000,
        size.width * 0.1647129,
        size.height * 0.8000000);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffB0B6BB).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3147129, size.height);
    path_3.cubicTo(
        size.width * 0.1863789,
        size.height,
        size.width * 0.08137891,
        size.height * 0.8950000,
        size.width * 0.08137891,
        size.height * 0.7666660);
    path_3.lineTo(size.width * 0.04137891, size.height * 0.7966660);
    path_3.cubicTo(
        size.width * 0.03471289,
        size.height * 0.8016660,
        size.width * 0.02304492,
        size.height * 0.8000000,
        size.width * 0.01804492,
        size.height * 0.7933320);
    path_3.cubicTo(
        size.width * 0.01304492,
        size.height * 0.7866641,
        size.width * 0.01471094,
        size.height * 0.7749980,
        size.width * 0.02137891,
        size.height * 0.7699980);
    path_3.lineTo(size.width * 0.08804492, size.height * 0.7199980);
    path_3.cubicTo(
        size.width * 0.09304492,
        size.height * 0.7166641,
        size.width * 0.09971094,
        size.height * 0.7149980,
        size.width * 0.1047109,
        size.height * 0.7183320);
    path_3.cubicTo(
        size.width * 0.1113770,
        size.height * 0.7216660,
        size.width * 0.1147109,
        size.height * 0.7266660,
        size.width * 0.1147109,
        size.height * 0.7333320);
    path_3.lineTo(size.width * 0.1147109, size.height * 0.7666660);
    path_3.cubicTo(
        size.width * 0.1147109,
        size.height * 0.8766660,
        size.width * 0.2047109,
        size.height * 0.9666660,
        size.width * 0.3147109,
        size.height * 0.9666660);
    path_3.cubicTo(
        size.width * 0.3247109,
        size.height * 0.9666660,
        size.width * 0.3313770,
        size.height * 0.9733320,
        size.width * 0.3313770,
        size.height * 0.9833320);
    path_3.cubicTo(
        size.width * 0.3313809,
        size.height * 0.9933340,
        size.width * 0.3247129,
        size.height,
        size.width * 0.3147129,
        size.height);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffB0B6BB).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.2380469, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.2380469,
        size.height * 0.3066660,
        size.width * 0.2447129,
        size.height * 0.3000000,
        size.width * 0.2547129,
        size.height * 0.3000000);
    path_4.lineTo(size.width * 0.2547129, size.height * 0.3000000);
    path_4.cubicTo(
        size.width * 0.2630469,
        size.height * 0.3000000,
        size.width * 0.2713789,
        size.height * 0.3066660,
        size.width * 0.2713789,
        size.height * 0.3166660);
    path_4.lineTo(size.width * 0.2713789, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.2713789,
        size.height * 0.3250000,
        size.width * 0.2630449,
        size.height * 0.3333320,
        size.width * 0.2547129,
        size.height * 0.3333320);
    path_4.lineTo(size.width * 0.2547129, size.height * 0.3333320);
    path_4.cubicTo(
        size.width * 0.2447129,
        size.height * 0.3333340,
        size.width * 0.2380469,
        size.height * 0.3250000,
        size.width * 0.2380469,
        size.height * 0.3166660);
    path_4.close();
    path_4.moveTo(size.width * 0.1780469, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.1780469,
        size.height * 0.3066660,
        size.width * 0.1863809,
        size.height * 0.3000000,
        size.width * 0.1947129,
        size.height * 0.3000000);
    path_4.lineTo(size.width * 0.1947129, size.height * 0.3000000);
    path_4.cubicTo(
        size.width * 0.2030469,
        size.height * 0.3000000,
        size.width * 0.2113789,
        size.height * 0.3066660,
        size.width * 0.2113789,
        size.height * 0.3166660);
    path_4.lineTo(size.width * 0.2113789, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.2113789,
        size.height * 0.3250000,
        size.width * 0.2030449,
        size.height * 0.3333320,
        size.width * 0.1947129,
        size.height * 0.3333320);
    path_4.lineTo(size.width * 0.1947129, size.height * 0.3333320);
    path_4.cubicTo(
        size.width * 0.1847129,
        size.height * 0.3333340,
        size.width * 0.1780469,
        size.height * 0.3250000,
        size.width * 0.1780469,
        size.height * 0.3166660);
    path_4.close();
    path_4.moveTo(size.width * 0.1180469, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.1180469,
        size.height * 0.3066660,
        size.width * 0.1263809,
        size.height * 0.3000000,
        size.width * 0.1347129,
        size.height * 0.3000000);
    path_4.lineTo(size.width * 0.1347129, size.height * 0.3000000);
    path_4.cubicTo(
        size.width * 0.1447129,
        size.height * 0.3000000,
        size.width * 0.1513789,
        size.height * 0.3066660,
        size.width * 0.1513789,
        size.height * 0.3166660);
    path_4.lineTo(size.width * 0.1513789, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.1513789,
        size.height * 0.3250000,
        size.width * 0.1447129,
        size.height * 0.3333320,
        size.width * 0.1347129,
        size.height * 0.3333320);
    path_4.lineTo(size.width * 0.1347129, size.height * 0.3333320);
    path_4.cubicTo(
        size.width * 0.1247129,
        size.height * 0.3333340,
        size.width * 0.1180469,
        size.height * 0.3250000,
        size.width * 0.1180469,
        size.height * 0.3166660);
    path_4.close();
    path_4.moveTo(size.width * 0.05804687, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.05804687,
        size.height * 0.3066660,
        size.width * 0.06638086,
        size.height * 0.3000000,
        size.width * 0.07471289,
        size.height * 0.3000000);
    path_4.lineTo(size.width * 0.07471289, size.height * 0.3000000);
    path_4.cubicTo(
        size.width * 0.08471289,
        size.height * 0.3000000,
        size.width * 0.09137891,
        size.height * 0.3066660,
        size.width * 0.09137891,
        size.height * 0.3166660);
    path_4.lineTo(size.width * 0.09137891, size.height * 0.3166660);
    path_4.cubicTo(
        size.width * 0.09137891,
        size.height * 0.3250000,
        size.width * 0.08471289,
        size.height * 0.3333320,
        size.width * 0.07471289,
        size.height * 0.3333320);
    path_4.lineTo(size.width * 0.07471289, size.height * 0.3333320);
    path_4.cubicTo(
        size.width * 0.06471289,
        size.height * 0.3333340,
        size.width * 0.05804687,
        size.height * 0.3250000,
        size.width * 0.05804687,
        size.height * 0.3166660);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * -0.001953125, size.height * 0.6216660);
    path_5.cubicTo(
        size.width * -0.001953125,
        size.height * 0.6133320,
        size.width * 0.004712891,
        size.height * 0.6050000,
        size.width * 0.01471289,
        size.height * 0.6050000);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.6050000);
    path_5.cubicTo(
        size.width * 0.02304688,
        size.height * 0.6050000,
        size.width * 0.03137891,
        size.height * 0.6133340,
        size.width * 0.03137891,
        size.height * 0.6216660);
    path_5.lineTo(size.width * 0.03137891, size.height * 0.6216660);
    path_5.cubicTo(
        size.width * 0.03137891,
        size.height * 0.6316660,
        size.width * 0.02304492,
        size.height * 0.6383320,
        size.width * 0.01471289,
        size.height * 0.6383320);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.6383320);
    path_5.cubicTo(
        size.width * 0.004712891,
        size.height * 0.6383340,
        size.width * -0.001953125,
        size.height * 0.6316660,
        size.width * -0.001953125,
        size.height * 0.6216660);
    path_5.close();
    path_5.moveTo(size.width * -0.001953125, size.height * 0.5616660);
    path_5.cubicTo(
        size.width * -0.001953125,
        size.height * 0.5516660,
        size.width * 0.004712891,
        size.height * 0.5450000,
        size.width * 0.01471289,
        size.height * 0.5450000);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.5450000);
    path_5.cubicTo(
        size.width * 0.02304688,
        size.height * 0.5450000,
        size.width * 0.03137891,
        size.height * 0.5516660,
        size.width * 0.03137891,
        size.height * 0.5616660);
    path_5.lineTo(size.width * 0.03137891, size.height * 0.5616660);
    path_5.cubicTo(
        size.width * 0.03137891,
        size.height * 0.5700000,
        size.width * 0.02304492,
        size.height * 0.5783320,
        size.width * 0.01471289,
        size.height * 0.5783320);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.5783320);
    path_5.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5783340,
        size.width * -0.001953125,
        size.height * 0.5700000,
        size.width * -0.001953125,
        size.height * 0.5616660);
    path_5.close();
    path_5.moveTo(size.width * -0.001953125, size.height * 0.5000000);
    path_5.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4900000,
        size.width * 0.004712891,
        size.height * 0.4833340,
        size.width * 0.01471289,
        size.height * 0.4833340);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.4833340);
    path_5.cubicTo(
        size.width * 0.02304688,
        size.height * 0.4833340,
        size.width * 0.03137891,
        size.height * 0.4900000,
        size.width * 0.03137891,
        size.height * 0.5000000);
    path_5.lineTo(size.width * 0.03137891, size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.03137891,
        size.height * 0.5083340,
        size.width * 0.02304492,
        size.height * 0.5166660,
        size.width * 0.01471289,
        size.height * 0.5166660);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.5166660);
    path_5.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5166660,
        size.width * -0.001953125,
        size.height * 0.5083340,
        size.width * -0.001953125,
        size.height * 0.5000000);
    path_5.close();
    path_5.moveTo(size.width * -0.001953125, size.height * 0.4383340);
    path_5.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4300000,
        size.width * 0.004712891,
        size.height * 0.4216680,
        size.width * 0.01471289,
        size.height * 0.4216680);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.4216680);
    path_5.cubicTo(
        size.width * 0.02304688,
        size.height * 0.4216680,
        size.width * 0.03137891,
        size.height * 0.4300020,
        size.width * 0.03137891,
        size.height * 0.4383340);
    path_5.lineTo(size.width * 0.03137891, size.height * 0.4383340);
    path_5.cubicTo(
        size.width * 0.03137891,
        size.height * 0.4483340,
        size.width * 0.02304492,
        size.height * 0.4550000,
        size.width * 0.01471289,
        size.height * 0.4550000);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.4550000);
    path_5.cubicTo(
        size.width * 0.004712891,
        size.height * 0.4550000,
        size.width * -0.001953125,
        size.height * 0.4483340,
        size.width * -0.001953125,
        size.height * 0.4383340);
    path_5.close();
    path_5.moveTo(size.width * -0.001953125, size.height * 0.3783340);
    path_5.cubicTo(
        size.width * -0.001953125,
        size.height * 0.3683340,
        size.width * 0.004712891,
        size.height * 0.3616680,
        size.width * 0.01471289,
        size.height * 0.3616680);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.3616680);
    path_5.cubicTo(
        size.width * 0.02304688,
        size.height * 0.3616680,
        size.width * 0.03137891,
        size.height * 0.3683340,
        size.width * 0.03137891,
        size.height * 0.3783340);
    path_5.lineTo(size.width * 0.03137891, size.height * 0.3783340);
    path_5.cubicTo(
        size.width * 0.03137891,
        size.height * 0.3866680,
        size.width * 0.02304492,
        size.height * 0.3950000,
        size.width * 0.01471289,
        size.height * 0.3950000);
    path_5.lineTo(size.width * 0.01471289, size.height * 0.3950000);
    path_5.cubicTo(
        size.width * 0.004712891,
        size.height * 0.3950000,
        size.width * -0.001953125,
        size.height * 0.3866660,
        size.width * -0.001953125,
        size.height * 0.3783340);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.2380469, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.2380469,
        size.height * 0.6750000,
        size.width * 0.2447129,
        size.height * 0.6666680,
        size.width * 0.2547129,
        size.height * 0.6666680);
    path_6.lineTo(size.width * 0.2547129, size.height * 0.6666680);
    path_6.cubicTo(
        size.width * 0.2630469,
        size.height * 0.6666680,
        size.width * 0.2713789,
        size.height * 0.6750020,
        size.width * 0.2713789,
        size.height * 0.6833340);
    path_6.lineTo(size.width * 0.2713789, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.2713789,
        size.height * 0.6916680,
        size.width * 0.2630449,
        size.height * 0.7000000,
        size.width * 0.2547129,
        size.height * 0.7000000);
    path_6.lineTo(size.width * 0.2547129, size.height * 0.7000000);
    path_6.cubicTo(
        size.width * 0.2447129,
        size.height * 0.7000000,
        size.width * 0.2380469,
        size.height * 0.6916660,
        size.width * 0.2380469,
        size.height * 0.6833340);
    path_6.close();
    path_6.moveTo(size.width * 0.1780469, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.1780469,
        size.height * 0.6750000,
        size.width * 0.1863809,
        size.height * 0.6666680,
        size.width * 0.1947129,
        size.height * 0.6666680);
    path_6.lineTo(size.width * 0.1947129, size.height * 0.6666680);
    path_6.cubicTo(
        size.width * 0.2030469,
        size.height * 0.6666680,
        size.width * 0.2113789,
        size.height * 0.6750020,
        size.width * 0.2113789,
        size.height * 0.6833340);
    path_6.lineTo(size.width * 0.2113789, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.2113789,
        size.height * 0.6916680,
        size.width * 0.2030449,
        size.height * 0.7000000,
        size.width * 0.1947129,
        size.height * 0.7000000);
    path_6.lineTo(size.width * 0.1947129, size.height * 0.7000000);
    path_6.cubicTo(
        size.width * 0.1847129,
        size.height * 0.7000000,
        size.width * 0.1780469,
        size.height * 0.6916660,
        size.width * 0.1780469,
        size.height * 0.6833340);
    path_6.close();
    path_6.moveTo(size.width * 0.1180469, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.1180469,
        size.height * 0.6750000,
        size.width * 0.1263809,
        size.height * 0.6666680,
        size.width * 0.1347129,
        size.height * 0.6666680);
    path_6.lineTo(size.width * 0.1347129, size.height * 0.6666680);
    path_6.cubicTo(
        size.width * 0.1447129,
        size.height * 0.6666680,
        size.width * 0.1513789,
        size.height * 0.6750020,
        size.width * 0.1513789,
        size.height * 0.6833340);
    path_6.lineTo(size.width * 0.1513789, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.1513789,
        size.height * 0.6916680,
        size.width * 0.1447129,
        size.height * 0.7000000,
        size.width * 0.1347129,
        size.height * 0.7000000);
    path_6.lineTo(size.width * 0.1347129, size.height * 0.7000000);
    path_6.cubicTo(
        size.width * 0.1247129,
        size.height * 0.7000000,
        size.width * 0.1180469,
        size.height * 0.6916660,
        size.width * 0.1180469,
        size.height * 0.6833340);
    path_6.close();
    path_6.moveTo(size.width * 0.05804687, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.05804687,
        size.height * 0.6750000,
        size.width * 0.06638086,
        size.height * 0.6666680,
        size.width * 0.07471289,
        size.height * 0.6666680);
    path_6.lineTo(size.width * 0.07471289, size.height * 0.6666680);
    path_6.cubicTo(
        size.width * 0.08471289,
        size.height * 0.6666680,
        size.width * 0.09137891,
        size.height * 0.6750020,
        size.width * 0.09137891,
        size.height * 0.6833340);
    path_6.lineTo(size.width * 0.09137891, size.height * 0.6833340);
    path_6.cubicTo(
        size.width * 0.09137891,
        size.height * 0.6916680,
        size.width * 0.08471289,
        size.height * 0.7000000,
        size.width * 0.07471289,
        size.height * 0.7000000);
    path_6.lineTo(size.width * 0.07471289, size.height * 0.7000000);
    path_6.cubicTo(
        size.width * 0.06471289,
        size.height * 0.7000000,
        size.width * 0.05804687,
        size.height * 0.6916660,
        size.width * 0.05804687,
        size.height * 0.6833340);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.2980469, size.height * 0.6216660);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.6133320,
        size.width * 0.3047129,
        size.height * 0.6050000,
        size.width * 0.3147129,
        size.height * 0.6050000);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.6050000);
    path_7.cubicTo(
        size.width * 0.3230469,
        size.height * 0.6050000,
        size.width * 0.3313789,
        size.height * 0.6133340,
        size.width * 0.3313789,
        size.height * 0.6216660);
    path_7.lineTo(size.width * 0.3313789, size.height * 0.6216660);
    path_7.cubicTo(
        size.width * 0.3313789,
        size.height * 0.6300000,
        size.width * 0.3230449,
        size.height * 0.6383320,
        size.width * 0.3147129,
        size.height * 0.6383320);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.6383320);
    path_7.cubicTo(
        size.width * 0.3047129,
        size.height * 0.6383340,
        size.width * 0.2980469,
        size.height * 0.6316660,
        size.width * 0.2980469,
        size.height * 0.6216660);
    path_7.close();
    path_7.moveTo(size.width * 0.2980469, size.height * 0.5616660);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.5516660,
        size.width * 0.3047129,
        size.height * 0.5450000,
        size.width * 0.3147129,
        size.height * 0.5450000);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.5450000);
    path_7.cubicTo(
        size.width * 0.3230469,
        size.height * 0.5450000,
        size.width * 0.3313789,
        size.height * 0.5516660,
        size.width * 0.3313789,
        size.height * 0.5616660);
    path_7.lineTo(size.width * 0.3313789, size.height * 0.5616660);
    path_7.cubicTo(
        size.width * 0.3313789,
        size.height * 0.5700000,
        size.width * 0.3230449,
        size.height * 0.5783320,
        size.width * 0.3147129,
        size.height * 0.5783320);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.5783320);
    path_7.cubicTo(
        size.width * 0.3047129,
        size.height * 0.5783340,
        size.width * 0.2980469,
        size.height * 0.5700000,
        size.width * 0.2980469,
        size.height * 0.5616660);
    path_7.close();
    path_7.moveTo(size.width * 0.2980469, size.height * 0.5000000);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.4900000,
        size.width * 0.3047129,
        size.height * 0.4833340,
        size.width * 0.3147129,
        size.height * 0.4833340);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.4833340);
    path_7.cubicTo(
        size.width * 0.3230469,
        size.height * 0.4833340,
        size.width * 0.3313789,
        size.height * 0.4900000,
        size.width * 0.3313789,
        size.height * 0.5000000);
    path_7.lineTo(size.width * 0.3313789, size.height * 0.5000000);
    path_7.cubicTo(
        size.width * 0.3313789,
        size.height * 0.5083340,
        size.width * 0.3230449,
        size.height * 0.5166660,
        size.width * 0.3147129,
        size.height * 0.5166660);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.5166660);
    path_7.cubicTo(
        size.width * 0.3047129,
        size.height * 0.5166660,
        size.width * 0.2980469,
        size.height * 0.5083340,
        size.width * 0.2980469,
        size.height * 0.5000000);
    path_7.close();
    path_7.moveTo(size.width * 0.2980469, size.height * 0.4383340);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.4300000,
        size.width * 0.3047129,
        size.height * 0.4216680,
        size.width * 0.3147129,
        size.height * 0.4216680);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.4216680);
    path_7.cubicTo(
        size.width * 0.3230469,
        size.height * 0.4216680,
        size.width * 0.3313789,
        size.height * 0.4300020,
        size.width * 0.3313789,
        size.height * 0.4383340);
    path_7.lineTo(size.width * 0.3313789, size.height * 0.4383340);
    path_7.cubicTo(
        size.width * 0.3313789,
        size.height * 0.4483340,
        size.width * 0.3230449,
        size.height * 0.4550000,
        size.width * 0.3147129,
        size.height * 0.4550000);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.4550000);
    path_7.cubicTo(
        size.width * 0.3047129,
        size.height * 0.4550000,
        size.width * 0.2980469,
        size.height * 0.4483340,
        size.width * 0.2980469,
        size.height * 0.4383340);
    path_7.close();
    path_7.moveTo(size.width * 0.2980469, size.height * 0.3783340);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.3700000,
        size.width * 0.3047129,
        size.height * 0.3616680,
        size.width * 0.3147129,
        size.height * 0.3616680);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.3616680);
    path_7.cubicTo(
        size.width * 0.3230469,
        size.height * 0.3616680,
        size.width * 0.3313789,
        size.height * 0.3700020,
        size.width * 0.3313789,
        size.height * 0.3783340);
    path_7.lineTo(size.width * 0.3313789, size.height * 0.3783340);
    path_7.cubicTo(
        size.width * 0.3313789,
        size.height * 0.3883340,
        size.width * 0.3230449,
        size.height * 0.3950000,
        size.width * 0.3147129,
        size.height * 0.3950000);
    path_7.lineTo(size.width * 0.3147129, size.height * 0.3950000);
    path_7.cubicTo(
        size.width * 0.3047129,
        size.height * 0.3950000,
        size.width * 0.2980469,
        size.height * 0.3866660,
        size.width * 0.2980469,
        size.height * 0.3783340);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.6813809, size.height * 0.6216660);
    path_8.cubicTo(
        size.width * 0.6813809,
        size.height * 0.6133320,
        size.width * 0.6897148,
        size.height * 0.6050000,
        size.width * 0.6980469,
        size.height * 0.6050000);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.6050000);
    path_8.cubicTo(
        size.width * 0.7063809,
        size.height * 0.6050000,
        size.width * 0.7147129,
        size.height * 0.6133340,
        size.width * 0.7147129,
        size.height * 0.6216660);
    path_8.lineTo(size.width * 0.7147129, size.height * 0.6216660);
    path_8.cubicTo(
        size.width * 0.7147129,
        size.height * 0.6316660,
        size.width * 0.7063789,
        size.height * 0.6383320,
        size.width * 0.6980469,
        size.height * 0.6383320);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.6383320);
    path_8.cubicTo(
        size.width * 0.6897129,
        size.height * 0.6383340,
        size.width * 0.6813809,
        size.height * 0.6316660,
        size.width * 0.6813809,
        size.height * 0.6216660);
    path_8.close();
    path_8.moveTo(size.width * 0.6813809, size.height * 0.5616660);
    path_8.cubicTo(
        size.width * 0.6813809,
        size.height * 0.5516660,
        size.width * 0.6897148,
        size.height * 0.5450000,
        size.width * 0.6980469,
        size.height * 0.5450000);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.5450000);
    path_8.cubicTo(
        size.width * 0.7063809,
        size.height * 0.5450000,
        size.width * 0.7147129,
        size.height * 0.5516660,
        size.width * 0.7147129,
        size.height * 0.5616660);
    path_8.lineTo(size.width * 0.7147129, size.height * 0.5616660);
    path_8.cubicTo(
        size.width * 0.7147129,
        size.height * 0.5700000,
        size.width * 0.7063789,
        size.height * 0.5783320,
        size.width * 0.6980469,
        size.height * 0.5783320);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.5783320);
    path_8.cubicTo(
        size.width * 0.6897129,
        size.height * 0.5783340,
        size.width * 0.6813809,
        size.height * 0.5700000,
        size.width * 0.6813809,
        size.height * 0.5616660);
    path_8.close();
    path_8.moveTo(size.width * 0.6813809, size.height * 0.5000000);
    path_8.cubicTo(
        size.width * 0.6813809,
        size.height * 0.4900000,
        size.width * 0.6897148,
        size.height * 0.4833340,
        size.width * 0.6980469,
        size.height * 0.4833340);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.4833340);
    path_8.cubicTo(
        size.width * 0.7063809,
        size.height * 0.4833340,
        size.width * 0.7147129,
        size.height * 0.4900000,
        size.width * 0.7147129,
        size.height * 0.5000000);
    path_8.lineTo(size.width * 0.7147129, size.height * 0.5000000);
    path_8.cubicTo(
        size.width * 0.7147129,
        size.height * 0.5083340,
        size.width * 0.7063789,
        size.height * 0.5166660,
        size.width * 0.6980469,
        size.height * 0.5166660);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.5166660);
    path_8.cubicTo(
        size.width * 0.6897129,
        size.height * 0.5166660,
        size.width * 0.6813809,
        size.height * 0.5083340,
        size.width * 0.6813809,
        size.height * 0.5000000);
    path_8.close();
    path_8.moveTo(size.width * 0.6813809, size.height * 0.4383340);
    path_8.cubicTo(
        size.width * 0.6813809,
        size.height * 0.4300000,
        size.width * 0.6897148,
        size.height * 0.4216680,
        size.width * 0.6980469,
        size.height * 0.4216680);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.4216680);
    path_8.cubicTo(
        size.width * 0.7063809,
        size.height * 0.4216680,
        size.width * 0.7147129,
        size.height * 0.4300020,
        size.width * 0.7147129,
        size.height * 0.4383340);
    path_8.lineTo(size.width * 0.7147129, size.height * 0.4383340);
    path_8.cubicTo(
        size.width * 0.7147129,
        size.height * 0.4483340,
        size.width * 0.7063789,
        size.height * 0.4550000,
        size.width * 0.6980469,
        size.height * 0.4550000);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.4550000);
    path_8.cubicTo(
        size.width * 0.6897129,
        size.height * 0.4550000,
        size.width * 0.6813809,
        size.height * 0.4483340,
        size.width * 0.6813809,
        size.height * 0.4383340);
    path_8.close();
    path_8.moveTo(size.width * 0.6813809, size.height * 0.3783340);
    path_8.cubicTo(
        size.width * 0.6813809,
        size.height * 0.3683340,
        size.width * 0.6897148,
        size.height * 0.3616680,
        size.width * 0.6980469,
        size.height * 0.3616680);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.3616680);
    path_8.cubicTo(
        size.width * 0.7063809,
        size.height * 0.3616680,
        size.width * 0.7147129,
        size.height * 0.3683340,
        size.width * 0.7147129,
        size.height * 0.3783340);
    path_8.lineTo(size.width * 0.7147129, size.height * 0.3783340);
    path_8.cubicTo(
        size.width * 0.7147129,
        size.height * 0.3866680,
        size.width * 0.7063789,
        size.height * 0.3950000,
        size.width * 0.6980469,
        size.height * 0.3950000);
    path_8.lineTo(size.width * 0.6980469, size.height * 0.3950000);
    path_8.cubicTo(
        size.width * 0.6897129,
        size.height * 0.3950000,
        size.width * 0.6813809,
        size.height * 0.3866660,
        size.width * 0.6813809,
        size.height * 0.3783340);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.8947129, size.height * 0.6833340);
    path_9.cubicTo(
        size.width * 0.8947129,
        size.height * 0.6750000,
        size.width * 0.9030469,
        size.height * 0.6666680,
        size.width * 0.9113789,
        size.height * 0.6666680);
    path_9.lineTo(size.width * 0.9113789, size.height * 0.6666680);
    path_9.cubicTo(
        size.width * 0.9197129,
        size.height * 0.6666680,
        size.width * 0.9280449,
        size.height * 0.6750020,
        size.width * 0.9280449,
        size.height * 0.6833340);
    path_9.lineTo(size.width * 0.9280449, size.height * 0.6833340);
    path_9.cubicTo(
        size.width * 0.9280449,
        size.height * 0.6916680,
        size.width * 0.9197109,
        size.height * 0.7000000,
        size.width * 0.9113789,
        size.height * 0.7000000);
    path_9.lineTo(size.width * 0.9113789, size.height * 0.7000000);
    path_9.cubicTo(
        size.width * 0.9013809,
        size.height * 0.7000000,
        size.width * 0.8947129,
        size.height * 0.6916660,
        size.width * 0.8947129,
        size.height * 0.6833340);
    path_9.close();
    path_9.moveTo(size.width * 0.8230469, size.height * 0.6833340);
    path_9.cubicTo(
        size.width * 0.8230469,
        size.height * 0.6750000,
        size.width * 0.8313809,
        size.height * 0.6666680,
        size.width * 0.8397129,
        size.height * 0.6666680);
    path_9.lineTo(size.width * 0.8397129, size.height * 0.6666680);
    path_9.cubicTo(
        size.width * 0.8480469,
        size.height * 0.6666680,
        size.width * 0.8563789,
        size.height * 0.6750020,
        size.width * 0.8563789,
        size.height * 0.6833340);
    path_9.lineTo(size.width * 0.8563789, size.height * 0.6833340);
    path_9.cubicTo(
        size.width * 0.8563789,
        size.height * 0.6916680,
        size.width * 0.8480449,
        size.height * 0.7000000,
        size.width * 0.8397129,
        size.height * 0.7000000);
    path_9.lineTo(size.width * 0.8397129, size.height * 0.7000000);
    path_9.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7000000,
        size.width * 0.8230469,
        size.height * 0.6916660,
        size.width * 0.8230469,
        size.height * 0.6833340);
    path_9.close();
    path_9.moveTo(size.width * 0.7513809, size.height * 0.6833340);
    path_9.cubicTo(
        size.width * 0.7513809,
        size.height * 0.6750000,
        size.width * 0.7597148,
        size.height * 0.6666680,
        size.width * 0.7680469,
        size.height * 0.6666680);
    path_9.lineTo(size.width * 0.7680469, size.height * 0.6666680);
    path_9.cubicTo(
        size.width * 0.7763809,
        size.height * 0.6666680,
        size.width * 0.7847129,
        size.height * 0.6750020,
        size.width * 0.7847129,
        size.height * 0.6833340);
    path_9.lineTo(size.width * 0.7847129, size.height * 0.6833340);
    path_9.cubicTo(
        size.width * 0.7847129,
        size.height * 0.6916680,
        size.width * 0.7763789,
        size.height * 0.7000000,
        size.width * 0.7680469,
        size.height * 0.7000000);
    path_9.lineTo(size.width * 0.7680469, size.height * 0.7000000);
    path_9.cubicTo(
        size.width * 0.7597129,
        size.height * 0.7000000,
        size.width * 0.7513809,
        size.height * 0.6916660,
        size.width * 0.7513809,
        size.height * 0.6833340);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.9647129, size.height * 0.6216660);
    path_10.cubicTo(
        size.width * 0.9647129,
        size.height * 0.6133320,
        size.width * 0.9730469,
        size.height * 0.6050000,
        size.width * 0.9813789,
        size.height * 0.6050000);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.6050000);
    path_10.cubicTo(
        size.width * 0.9897129,
        size.height * 0.6050000,
        size.width * 0.9980449,
        size.height * 0.6133340,
        size.width * 0.9980449,
        size.height * 0.6216660);
    path_10.lineTo(size.width * 0.9980449, size.height * 0.6216660);
    path_10.cubicTo(
        size.width * 0.9980449,
        size.height * 0.6300000,
        size.width * 0.9897109,
        size.height * 0.6383320,
        size.width * 0.9813789,
        size.height * 0.6383320);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.6383320);
    path_10.cubicTo(
        size.width * 0.9730469,
        size.height * 0.6383340,
        size.width * 0.9647129,
        size.height * 0.6316660,
        size.width * 0.9647129,
        size.height * 0.6216660);
    path_10.close();
    path_10.moveTo(size.width * 0.9647129, size.height * 0.5616660);
    path_10.cubicTo(
        size.width * 0.9647129,
        size.height * 0.5516660,
        size.width * 0.9730469,
        size.height * 0.5450000,
        size.width * 0.9813789,
        size.height * 0.5450000);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.5450000);
    path_10.cubicTo(
        size.width * 0.9897129,
        size.height * 0.5450000,
        size.width * 0.9980449,
        size.height * 0.5516660,
        size.width * 0.9980449,
        size.height * 0.5616660);
    path_10.lineTo(size.width * 0.9980449, size.height * 0.5616660);
    path_10.cubicTo(
        size.width * 0.9980449,
        size.height * 0.5716660,
        size.width * 0.9897109,
        size.height * 0.5783320,
        size.width * 0.9813789,
        size.height * 0.5783320);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.5783320);
    path_10.cubicTo(
        size.width * 0.9730469,
        size.height * 0.5783340,
        size.width * 0.9647129,
        size.height * 0.5700000,
        size.width * 0.9647129,
        size.height * 0.5616660);
    path_10.close();
    path_10.moveTo(size.width * 0.9647129, size.height * 0.5000000);
    path_10.cubicTo(
        size.width * 0.9647129,
        size.height * 0.4900000,
        size.width * 0.9730469,
        size.height * 0.4833340,
        size.width * 0.9813789,
        size.height * 0.4833340);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.4833340);
    path_10.cubicTo(
        size.width * 0.9897129,
        size.height * 0.4833340,
        size.width * 0.9980449,
        size.height * 0.4900000,
        size.width * 0.9980449,
        size.height * 0.5000000);
    path_10.lineTo(size.width * 0.9980449, size.height * 0.5000000);
    path_10.cubicTo(
        size.width * 0.9980449,
        size.height * 0.5083340,
        size.width * 0.9897109,
        size.height * 0.5166660,
        size.width * 0.9813789,
        size.height * 0.5166660);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.5166660);
    path_10.cubicTo(
        size.width * 0.9730469,
        size.height * 0.5166660,
        size.width * 0.9647129,
        size.height * 0.5083340,
        size.width * 0.9647129,
        size.height * 0.5000000);
    path_10.close();
    path_10.moveTo(size.width * 0.9647129, size.height * 0.4383340);
    path_10.cubicTo(
        size.width * 0.9647129,
        size.height * 0.4300000,
        size.width * 0.9730469,
        size.height * 0.4216680,
        size.width * 0.9813789,
        size.height * 0.4216680);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.4216680);
    path_10.cubicTo(
        size.width * 0.9897129,
        size.height * 0.4216680,
        size.width * 0.9980449,
        size.height * 0.4300020,
        size.width * 0.9980449,
        size.height * 0.4383340);
    path_10.lineTo(size.width * 0.9980449, size.height * 0.4383340);
    path_10.cubicTo(
        size.width * 0.9980449,
        size.height * 0.4483340,
        size.width * 0.9897109,
        size.height * 0.4550000,
        size.width * 0.9813789,
        size.height * 0.4550000);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.4550000);
    path_10.cubicTo(
        size.width * 0.9730469,
        size.height * 0.4550000,
        size.width * 0.9647129,
        size.height * 0.4483340,
        size.width * 0.9647129,
        size.height * 0.4383340);
    path_10.close();
    path_10.moveTo(size.width * 0.9647129, size.height * 0.3783340);
    path_10.cubicTo(
        size.width * 0.9647129,
        size.height * 0.3700000,
        size.width * 0.9730469,
        size.height * 0.3616680,
        size.width * 0.9813789,
        size.height * 0.3616680);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.3616680);
    path_10.cubicTo(
        size.width * 0.9897129,
        size.height * 0.3616680,
        size.width * 0.9980449,
        size.height * 0.3700020,
        size.width * 0.9980449,
        size.height * 0.3783340);
    path_10.lineTo(size.width * 0.9980449, size.height * 0.3783340);
    path_10.cubicTo(
        size.width * 0.9980449,
        size.height * 0.3883340,
        size.width * 0.9897109,
        size.height * 0.3950000,
        size.width * 0.9813789,
        size.height * 0.3950000);
    path_10.lineTo(size.width * 0.9813789, size.height * 0.3950000);
    path_10.cubicTo(
        size.width * 0.9730469,
        size.height * 0.3950000,
        size.width * 0.9647129,
        size.height * 0.3866660,
        size.width * 0.9647129,
        size.height * 0.3783340);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.8947129, size.height * 0.3166660);
    path_11.cubicTo(
        size.width * 0.8947129,
        size.height * 0.3066660,
        size.width * 0.9030469,
        size.height * 0.3000000,
        size.width * 0.9113789,
        size.height * 0.3000000);
    path_11.lineTo(size.width * 0.9113789, size.height * 0.3000000);
    path_11.cubicTo(
        size.width * 0.9197129,
        size.height * 0.3000000,
        size.width * 0.9280449,
        size.height * 0.3066660,
        size.width * 0.9280449,
        size.height * 0.3166660);
    path_11.lineTo(size.width * 0.9280449, size.height * 0.3166660);
    path_11.cubicTo(
        size.width * 0.9280449,
        size.height * 0.3250000,
        size.width * 0.9197109,
        size.height * 0.3333320,
        size.width * 0.9113789,
        size.height * 0.3333320);
    path_11.lineTo(size.width * 0.9113789, size.height * 0.3333320);
    path_11.cubicTo(
        size.width * 0.9013809,
        size.height * 0.3333340,
        size.width * 0.8947129,
        size.height * 0.3250000,
        size.width * 0.8947129,
        size.height * 0.3166660);
    path_11.close();
    path_11.moveTo(size.width * 0.8230469, size.height * 0.3166660);
    path_11.cubicTo(
        size.width * 0.8230469,
        size.height * 0.3066660,
        size.width * 0.8313809,
        size.height * 0.3000000,
        size.width * 0.8397129,
        size.height * 0.3000000);
    path_11.lineTo(size.width * 0.8397129, size.height * 0.3000000);
    path_11.cubicTo(
        size.width * 0.8480469,
        size.height * 0.3000000,
        size.width * 0.8563789,
        size.height * 0.3066660,
        size.width * 0.8563789,
        size.height * 0.3166660);
    path_11.lineTo(size.width * 0.8563789, size.height * 0.3166660);
    path_11.cubicTo(
        size.width * 0.8563789,
        size.height * 0.3250000,
        size.width * 0.8480449,
        size.height * 0.3333320,
        size.width * 0.8397129,
        size.height * 0.3333320);
    path_11.lineTo(size.width * 0.8397129, size.height * 0.3333320);
    path_11.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3333340,
        size.width * 0.8230469,
        size.height * 0.3250000,
        size.width * 0.8230469,
        size.height * 0.3166660);
    path_11.close();
    path_11.moveTo(size.width * 0.7513809, size.height * 0.3166660);
    path_11.cubicTo(
        size.width * 0.7513809,
        size.height * 0.3066660,
        size.width * 0.7597148,
        size.height * 0.3000000,
        size.width * 0.7680469,
        size.height * 0.3000000);
    path_11.lineTo(size.width * 0.7680469, size.height * 0.3000000);
    path_11.cubicTo(
        size.width * 0.7763809,
        size.height * 0.3000000,
        size.width * 0.7847129,
        size.height * 0.3066660,
        size.width * 0.7847129,
        size.height * 0.3166660);
    path_11.lineTo(size.width * 0.7847129, size.height * 0.3166660);
    path_11.cubicTo(
        size.width * 0.7847129,
        size.height * 0.3250000,
        size.width * 0.7763789,
        size.height * 0.3333320,
        size.width * 0.7680469,
        size.height * 0.3333320);
    path_11.lineTo(size.width * 0.7680469, size.height * 0.3333320);
    path_11.cubicTo(
        size.width * 0.7597129,
        size.height * 0.3333340,
        size.width * 0.7513809,
        size.height * 0.3250000,
        size.width * 0.7513809,
        size.height * 0.3166660);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff556080).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.3147129, size.height * 0.9833340);
    path_12.lineTo(size.width * 0.6980469, size.height * 0.9833340);
    path_12.lineTo(size.width * 0.6980469, size.height * 0.01666602);
    path_12.lineTo(size.width * 0.3147129, size.height * 0.01666602);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.7147129, size.height);
    path_13.lineTo(size.width * 0.2980469, size.height);
    path_13.lineTo(size.width * 0.2980469, 0);
    path_13.lineTo(size.width * 0.7147129, 0);
    path_13.lineTo(size.width * 0.7147129, size.height);
    path_13.close();
    path_13.moveTo(size.width * 0.3313809, size.height * 0.9666660);
    path_13.lineTo(size.width * 0.6813809, size.height * 0.9666660);
    path_13.lineTo(size.width * 0.6813809, size.height * 0.03333398);
    path_13.lineTo(size.width * 0.3313809, size.height * 0.03333398);
    path_13.lineTo(size.width * 0.3313809, size.height * 0.9666660);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff48A0DC).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.7147129, size.height);
    path_14.lineTo(size.width * 0.2980469, size.height);
    path_14.lineTo(size.width * 0.2980469, 0);
    path_14.lineTo(size.width * 0.7147129, 0);
    path_14.lineTo(size.width * 0.7147129, size.height);
    path_14.close();
    path_14.moveTo(size.width * 0.3313809, size.height * 0.9666660);
    path_14.lineTo(size.width * 0.6813809, size.height * 0.9666660);
    path_14.lineTo(size.width * 0.6813809, size.height * 0.03333398);
    path_14.lineTo(size.width * 0.3313809, size.height * 0.03333398);
    path_14.lineTo(size.width * 0.3313809, size.height * 0.9666660);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.2380469, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.2380469,
        size.height * 0.3066660,
        size.width * 0.2447129,
        size.height * 0.3000000,
        size.width * 0.2547129,
        size.height * 0.3000000);
    path_15.lineTo(size.width * 0.2547129, size.height * 0.3000000);
    path_15.cubicTo(
        size.width * 0.2630469,
        size.height * 0.3000000,
        size.width * 0.2713789,
        size.height * 0.3066660,
        size.width * 0.2713789,
        size.height * 0.3166660);
    path_15.lineTo(size.width * 0.2713789, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.2713789,
        size.height * 0.3250000,
        size.width * 0.2630449,
        size.height * 0.3333320,
        size.width * 0.2547129,
        size.height * 0.3333320);
    path_15.lineTo(size.width * 0.2547129, size.height * 0.3333320);
    path_15.cubicTo(
        size.width * 0.2447129,
        size.height * 0.3333340,
        size.width * 0.2380469,
        size.height * 0.3250000,
        size.width * 0.2380469,
        size.height * 0.3166660);
    path_15.close();
    path_15.moveTo(size.width * 0.1780469, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.1780469,
        size.height * 0.3066660,
        size.width * 0.1863809,
        size.height * 0.3000000,
        size.width * 0.1947129,
        size.height * 0.3000000);
    path_15.lineTo(size.width * 0.1947129, size.height * 0.3000000);
    path_15.cubicTo(
        size.width * 0.2030469,
        size.height * 0.3000000,
        size.width * 0.2113789,
        size.height * 0.3066660,
        size.width * 0.2113789,
        size.height * 0.3166660);
    path_15.lineTo(size.width * 0.2113789, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.2113789,
        size.height * 0.3250000,
        size.width * 0.2030449,
        size.height * 0.3333320,
        size.width * 0.1947129,
        size.height * 0.3333320);
    path_15.lineTo(size.width * 0.1947129, size.height * 0.3333320);
    path_15.cubicTo(
        size.width * 0.1847129,
        size.height * 0.3333340,
        size.width * 0.1780469,
        size.height * 0.3250000,
        size.width * 0.1780469,
        size.height * 0.3166660);
    path_15.close();
    path_15.moveTo(size.width * 0.1180469, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.1180469,
        size.height * 0.3066660,
        size.width * 0.1263809,
        size.height * 0.3000000,
        size.width * 0.1347129,
        size.height * 0.3000000);
    path_15.lineTo(size.width * 0.1347129, size.height * 0.3000000);
    path_15.cubicTo(
        size.width * 0.1447129,
        size.height * 0.3000000,
        size.width * 0.1513789,
        size.height * 0.3066660,
        size.width * 0.1513789,
        size.height * 0.3166660);
    path_15.lineTo(size.width * 0.1513789, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.1513789,
        size.height * 0.3250000,
        size.width * 0.1447129,
        size.height * 0.3333320,
        size.width * 0.1347129,
        size.height * 0.3333320);
    path_15.lineTo(size.width * 0.1347129, size.height * 0.3333320);
    path_15.cubicTo(
        size.width * 0.1247129,
        size.height * 0.3333340,
        size.width * 0.1180469,
        size.height * 0.3250000,
        size.width * 0.1180469,
        size.height * 0.3166660);
    path_15.close();
    path_15.moveTo(size.width * 0.05804687, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.05804687,
        size.height * 0.3066660,
        size.width * 0.06638086,
        size.height * 0.3000000,
        size.width * 0.07471289,
        size.height * 0.3000000);
    path_15.lineTo(size.width * 0.07471289, size.height * 0.3000000);
    path_15.cubicTo(
        size.width * 0.08471289,
        size.height * 0.3000000,
        size.width * 0.09137891,
        size.height * 0.3066660,
        size.width * 0.09137891,
        size.height * 0.3166660);
    path_15.lineTo(size.width * 0.09137891, size.height * 0.3166660);
    path_15.cubicTo(
        size.width * 0.09137891,
        size.height * 0.3250000,
        size.width * 0.08471289,
        size.height * 0.3333320,
        size.width * 0.07471289,
        size.height * 0.3333320);
    path_15.lineTo(size.width * 0.07471289, size.height * 0.3333320);
    path_15.cubicTo(
        size.width * 0.06471289,
        size.height * 0.3333340,
        size.width * 0.05804687,
        size.height * 0.3250000,
        size.width * 0.05804687,
        size.height * 0.3166660);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * -0.001953125, size.height * 0.6216660);
    path_16.cubicTo(
        size.width * -0.001953125,
        size.height * 0.6133320,
        size.width * 0.004712891,
        size.height * 0.6050000,
        size.width * 0.01471289,
        size.height * 0.6050000);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.6050000);
    path_16.cubicTo(
        size.width * 0.02304688,
        size.height * 0.6050000,
        size.width * 0.03137891,
        size.height * 0.6133340,
        size.width * 0.03137891,
        size.height * 0.6216660);
    path_16.lineTo(size.width * 0.03137891, size.height * 0.6216660);
    path_16.cubicTo(
        size.width * 0.03137891,
        size.height * 0.6316660,
        size.width * 0.02304492,
        size.height * 0.6383320,
        size.width * 0.01471289,
        size.height * 0.6383320);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.6383320);
    path_16.cubicTo(
        size.width * 0.004712891,
        size.height * 0.6383340,
        size.width * -0.001953125,
        size.height * 0.6316660,
        size.width * -0.001953125,
        size.height * 0.6216660);
    path_16.close();
    path_16.moveTo(size.width * -0.001953125, size.height * 0.5616660);
    path_16.cubicTo(
        size.width * -0.001953125,
        size.height * 0.5516660,
        size.width * 0.004712891,
        size.height * 0.5450000,
        size.width * 0.01471289,
        size.height * 0.5450000);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.5450000);
    path_16.cubicTo(
        size.width * 0.02304688,
        size.height * 0.5450000,
        size.width * 0.03137891,
        size.height * 0.5516660,
        size.width * 0.03137891,
        size.height * 0.5616660);
    path_16.lineTo(size.width * 0.03137891, size.height * 0.5616660);
    path_16.cubicTo(
        size.width * 0.03137891,
        size.height * 0.5700000,
        size.width * 0.02304492,
        size.height * 0.5783320,
        size.width * 0.01471289,
        size.height * 0.5783320);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.5783320);
    path_16.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5783340,
        size.width * -0.001953125,
        size.height * 0.5700000,
        size.width * -0.001953125,
        size.height * 0.5616660);
    path_16.close();
    path_16.moveTo(size.width * -0.001953125, size.height * 0.5000000);
    path_16.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4900000,
        size.width * 0.004712891,
        size.height * 0.4833340,
        size.width * 0.01471289,
        size.height * 0.4833340);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.4833340);
    path_16.cubicTo(
        size.width * 0.02304688,
        size.height * 0.4833340,
        size.width * 0.03137891,
        size.height * 0.4900000,
        size.width * 0.03137891,
        size.height * 0.5000000);
    path_16.lineTo(size.width * 0.03137891, size.height * 0.5000000);
    path_16.cubicTo(
        size.width * 0.03137891,
        size.height * 0.5083340,
        size.width * 0.02304492,
        size.height * 0.5166660,
        size.width * 0.01471289,
        size.height * 0.5166660);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.5166660);
    path_16.cubicTo(
        size.width * 0.004712891,
        size.height * 0.5166660,
        size.width * -0.001953125,
        size.height * 0.5083340,
        size.width * -0.001953125,
        size.height * 0.5000000);
    path_16.close();
    path_16.moveTo(size.width * -0.001953125, size.height * 0.4383340);
    path_16.cubicTo(
        size.width * -0.001953125,
        size.height * 0.4300000,
        size.width * 0.004712891,
        size.height * 0.4216680,
        size.width * 0.01471289,
        size.height * 0.4216680);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.4216680);
    path_16.cubicTo(
        size.width * 0.02304688,
        size.height * 0.4216680,
        size.width * 0.03137891,
        size.height * 0.4300020,
        size.width * 0.03137891,
        size.height * 0.4383340);
    path_16.lineTo(size.width * 0.03137891, size.height * 0.4383340);
    path_16.cubicTo(
        size.width * 0.03137891,
        size.height * 0.4483340,
        size.width * 0.02304492,
        size.height * 0.4550000,
        size.width * 0.01471289,
        size.height * 0.4550000);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.4550000);
    path_16.cubicTo(
        size.width * 0.004712891,
        size.height * 0.4550000,
        size.width * -0.001953125,
        size.height * 0.4483340,
        size.width * -0.001953125,
        size.height * 0.4383340);
    path_16.close();
    path_16.moveTo(size.width * -0.001953125, size.height * 0.3783340);
    path_16.cubicTo(
        size.width * -0.001953125,
        size.height * 0.3683340,
        size.width * 0.004712891,
        size.height * 0.3616680,
        size.width * 0.01471289,
        size.height * 0.3616680);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.3616680);
    path_16.cubicTo(
        size.width * 0.02304688,
        size.height * 0.3616680,
        size.width * 0.03137891,
        size.height * 0.3683340,
        size.width * 0.03137891,
        size.height * 0.3783340);
    path_16.lineTo(size.width * 0.03137891, size.height * 0.3783340);
    path_16.cubicTo(
        size.width * 0.03137891,
        size.height * 0.3866680,
        size.width * 0.02304492,
        size.height * 0.3950000,
        size.width * 0.01471289,
        size.height * 0.3950000);
    path_16.lineTo(size.width * 0.01471289, size.height * 0.3950000);
    path_16.cubicTo(
        size.width * 0.004712891,
        size.height * 0.3950000,
        size.width * -0.001953125,
        size.height * 0.3866660,
        size.width * -0.001953125,
        size.height * 0.3783340);
    path_16.close();

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.2380469, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.2380469,
        size.height * 0.6750000,
        size.width * 0.2447129,
        size.height * 0.6666680,
        size.width * 0.2547129,
        size.height * 0.6666680);
    path_17.lineTo(size.width * 0.2547129, size.height * 0.6666680);
    path_17.cubicTo(
        size.width * 0.2630469,
        size.height * 0.6666680,
        size.width * 0.2713789,
        size.height * 0.6750020,
        size.width * 0.2713789,
        size.height * 0.6833340);
    path_17.lineTo(size.width * 0.2713789, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.2713789,
        size.height * 0.6916680,
        size.width * 0.2630449,
        size.height * 0.7000000,
        size.width * 0.2547129,
        size.height * 0.7000000);
    path_17.lineTo(size.width * 0.2547129, size.height * 0.7000000);
    path_17.cubicTo(
        size.width * 0.2447129,
        size.height * 0.7000000,
        size.width * 0.2380469,
        size.height * 0.6916660,
        size.width * 0.2380469,
        size.height * 0.6833340);
    path_17.close();
    path_17.moveTo(size.width * 0.1780469, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.1780469,
        size.height * 0.6750000,
        size.width * 0.1863809,
        size.height * 0.6666680,
        size.width * 0.1947129,
        size.height * 0.6666680);
    path_17.lineTo(size.width * 0.1947129, size.height * 0.6666680);
    path_17.cubicTo(
        size.width * 0.2030469,
        size.height * 0.6666680,
        size.width * 0.2113789,
        size.height * 0.6750020,
        size.width * 0.2113789,
        size.height * 0.6833340);
    path_17.lineTo(size.width * 0.2113789, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.2113789,
        size.height * 0.6916680,
        size.width * 0.2030449,
        size.height * 0.7000000,
        size.width * 0.1947129,
        size.height * 0.7000000);
    path_17.lineTo(size.width * 0.1947129, size.height * 0.7000000);
    path_17.cubicTo(
        size.width * 0.1847129,
        size.height * 0.7000000,
        size.width * 0.1780469,
        size.height * 0.6916660,
        size.width * 0.1780469,
        size.height * 0.6833340);
    path_17.close();
    path_17.moveTo(size.width * 0.1180469, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.1180469,
        size.height * 0.6750000,
        size.width * 0.1263809,
        size.height * 0.6666680,
        size.width * 0.1347129,
        size.height * 0.6666680);
    path_17.lineTo(size.width * 0.1347129, size.height * 0.6666680);
    path_17.cubicTo(
        size.width * 0.1447129,
        size.height * 0.6666680,
        size.width * 0.1513789,
        size.height * 0.6750020,
        size.width * 0.1513789,
        size.height * 0.6833340);
    path_17.lineTo(size.width * 0.1513789, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.1513789,
        size.height * 0.6916680,
        size.width * 0.1447129,
        size.height * 0.7000000,
        size.width * 0.1347129,
        size.height * 0.7000000);
    path_17.lineTo(size.width * 0.1347129, size.height * 0.7000000);
    path_17.cubicTo(
        size.width * 0.1247129,
        size.height * 0.7000000,
        size.width * 0.1180469,
        size.height * 0.6916660,
        size.width * 0.1180469,
        size.height * 0.6833340);
    path_17.close();
    path_17.moveTo(size.width * 0.05804687, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.05804687,
        size.height * 0.6750000,
        size.width * 0.06638086,
        size.height * 0.6666680,
        size.width * 0.07471289,
        size.height * 0.6666680);
    path_17.lineTo(size.width * 0.07471289, size.height * 0.6666680);
    path_17.cubicTo(
        size.width * 0.08471289,
        size.height * 0.6666680,
        size.width * 0.09137891,
        size.height * 0.6750020,
        size.width * 0.09137891,
        size.height * 0.6833340);
    path_17.lineTo(size.width * 0.09137891, size.height * 0.6833340);
    path_17.cubicTo(
        size.width * 0.09137891,
        size.height * 0.6916680,
        size.width * 0.08471289,
        size.height * 0.7000000,
        size.width * 0.07471289,
        size.height * 0.7000000);
    path_17.lineTo(size.width * 0.07471289, size.height * 0.7000000);
    path_17.cubicTo(
        size.width * 0.06471289,
        size.height * 0.7000000,
        size.width * 0.05804687,
        size.height * 0.6916660,
        size.width * 0.05804687,
        size.height * 0.6833340);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.2980469, size.height * 0.6216660);
    path_18.cubicTo(
        size.width * 0.2980469,
        size.height * 0.6133320,
        size.width * 0.3047129,
        size.height * 0.6050000,
        size.width * 0.3147129,
        size.height * 0.6050000);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.6050000);
    path_18.cubicTo(
        size.width * 0.3230469,
        size.height * 0.6050000,
        size.width * 0.3313789,
        size.height * 0.6133340,
        size.width * 0.3313789,
        size.height * 0.6216660);
    path_18.lineTo(size.width * 0.3313789, size.height * 0.6216660);
    path_18.cubicTo(
        size.width * 0.3313789,
        size.height * 0.6300000,
        size.width * 0.3230449,
        size.height * 0.6383320,
        size.width * 0.3147129,
        size.height * 0.6383320);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.6383320);
    path_18.cubicTo(
        size.width * 0.3047129,
        size.height * 0.6383340,
        size.width * 0.2980469,
        size.height * 0.6316660,
        size.width * 0.2980469,
        size.height * 0.6216660);
    path_18.close();
    path_18.moveTo(size.width * 0.2980469, size.height * 0.5616660);
    path_18.cubicTo(
        size.width * 0.2980469,
        size.height * 0.5516660,
        size.width * 0.3047129,
        size.height * 0.5450000,
        size.width * 0.3147129,
        size.height * 0.5450000);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.5450000);
    path_18.cubicTo(
        size.width * 0.3230469,
        size.height * 0.5450000,
        size.width * 0.3313789,
        size.height * 0.5516660,
        size.width * 0.3313789,
        size.height * 0.5616660);
    path_18.lineTo(size.width * 0.3313789, size.height * 0.5616660);
    path_18.cubicTo(
        size.width * 0.3313789,
        size.height * 0.5700000,
        size.width * 0.3230449,
        size.height * 0.5783320,
        size.width * 0.3147129,
        size.height * 0.5783320);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.5783320);
    path_18.cubicTo(
        size.width * 0.3047129,
        size.height * 0.5783340,
        size.width * 0.2980469,
        size.height * 0.5700000,
        size.width * 0.2980469,
        size.height * 0.5616660);
    path_18.close();
    path_18.moveTo(size.width * 0.2980469, size.height * 0.5000000);
    path_18.cubicTo(
        size.width * 0.2980469,
        size.height * 0.4900000,
        size.width * 0.3047129,
        size.height * 0.4833340,
        size.width * 0.3147129,
        size.height * 0.4833340);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.4833340);
    path_18.cubicTo(
        size.width * 0.3230469,
        size.height * 0.4833340,
        size.width * 0.3313789,
        size.height * 0.4900000,
        size.width * 0.3313789,
        size.height * 0.5000000);
    path_18.lineTo(size.width * 0.3313789, size.height * 0.5000000);
    path_18.cubicTo(
        size.width * 0.3313789,
        size.height * 0.5083340,
        size.width * 0.3230449,
        size.height * 0.5166660,
        size.width * 0.3147129,
        size.height * 0.5166660);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.5166660);
    path_18.cubicTo(
        size.width * 0.3047129,
        size.height * 0.5166660,
        size.width * 0.2980469,
        size.height * 0.5083340,
        size.width * 0.2980469,
        size.height * 0.5000000);
    path_18.close();
    path_18.moveTo(size.width * 0.2980469, size.height * 0.4383340);
    path_18.cubicTo(
        size.width * 0.2980469,
        size.height * 0.4300000,
        size.width * 0.3047129,
        size.height * 0.4216680,
        size.width * 0.3147129,
        size.height * 0.4216680);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.4216680);
    path_18.cubicTo(
        size.width * 0.3230469,
        size.height * 0.4216680,
        size.width * 0.3313789,
        size.height * 0.4300020,
        size.width * 0.3313789,
        size.height * 0.4383340);
    path_18.lineTo(size.width * 0.3313789, size.height * 0.4383340);
    path_18.cubicTo(
        size.width * 0.3313789,
        size.height * 0.4483340,
        size.width * 0.3230449,
        size.height * 0.4550000,
        size.width * 0.3147129,
        size.height * 0.4550000);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.4550000);
    path_18.cubicTo(
        size.width * 0.3047129,
        size.height * 0.4550000,
        size.width * 0.2980469,
        size.height * 0.4483340,
        size.width * 0.2980469,
        size.height * 0.4383340);
    path_18.close();
    path_18.moveTo(size.width * 0.2980469, size.height * 0.3783340);
    path_18.cubicTo(
        size.width * 0.2980469,
        size.height * 0.3700000,
        size.width * 0.3047129,
        size.height * 0.3616680,
        size.width * 0.3147129,
        size.height * 0.3616680);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.3616680);
    path_18.cubicTo(
        size.width * 0.3230469,
        size.height * 0.3616680,
        size.width * 0.3313789,
        size.height * 0.3700020,
        size.width * 0.3313789,
        size.height * 0.3783340);
    path_18.lineTo(size.width * 0.3313789, size.height * 0.3783340);
    path_18.cubicTo(
        size.width * 0.3313789,
        size.height * 0.3883340,
        size.width * 0.3230449,
        size.height * 0.3950000,
        size.width * 0.3147129,
        size.height * 0.3950000);
    path_18.lineTo(size.width * 0.3147129, size.height * 0.3950000);
    path_18.cubicTo(
        size.width * 0.3047129,
        size.height * 0.3950000,
        size.width * 0.2980469,
        size.height * 0.3866660,
        size.width * 0.2980469,
        size.height * 0.3783340);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_18, paint_18_fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 0.6813809, size.height * 0.6216660);
    path_19.cubicTo(
        size.width * 0.6813809,
        size.height * 0.6133320,
        size.width * 0.6897148,
        size.height * 0.6050000,
        size.width * 0.6980469,
        size.height * 0.6050000);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.6050000);
    path_19.cubicTo(
        size.width * 0.7063809,
        size.height * 0.6050000,
        size.width * 0.7147129,
        size.height * 0.6133340,
        size.width * 0.7147129,
        size.height * 0.6216660);
    path_19.lineTo(size.width * 0.7147129, size.height * 0.6216660);
    path_19.cubicTo(
        size.width * 0.7147129,
        size.height * 0.6316660,
        size.width * 0.7063789,
        size.height * 0.6383320,
        size.width * 0.6980469,
        size.height * 0.6383320);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.6383320);
    path_19.cubicTo(
        size.width * 0.6897129,
        size.height * 0.6383340,
        size.width * 0.6813809,
        size.height * 0.6316660,
        size.width * 0.6813809,
        size.height * 0.6216660);
    path_19.close();
    path_19.moveTo(size.width * 0.6813809, size.height * 0.5616660);
    path_19.cubicTo(
        size.width * 0.6813809,
        size.height * 0.5516660,
        size.width * 0.6897148,
        size.height * 0.5450000,
        size.width * 0.6980469,
        size.height * 0.5450000);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.5450000);
    path_19.cubicTo(
        size.width * 0.7063809,
        size.height * 0.5450000,
        size.width * 0.7147129,
        size.height * 0.5516660,
        size.width * 0.7147129,
        size.height * 0.5616660);
    path_19.lineTo(size.width * 0.7147129, size.height * 0.5616660);
    path_19.cubicTo(
        size.width * 0.7147129,
        size.height * 0.5700000,
        size.width * 0.7063789,
        size.height * 0.5783320,
        size.width * 0.6980469,
        size.height * 0.5783320);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.5783320);
    path_19.cubicTo(
        size.width * 0.6897129,
        size.height * 0.5783340,
        size.width * 0.6813809,
        size.height * 0.5700000,
        size.width * 0.6813809,
        size.height * 0.5616660);
    path_19.close();
    path_19.moveTo(size.width * 0.6813809, size.height * 0.5000000);
    path_19.cubicTo(
        size.width * 0.6813809,
        size.height * 0.4900000,
        size.width * 0.6897148,
        size.height * 0.4833340,
        size.width * 0.6980469,
        size.height * 0.4833340);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.4833340);
    path_19.cubicTo(
        size.width * 0.7063809,
        size.height * 0.4833340,
        size.width * 0.7147129,
        size.height * 0.4900000,
        size.width * 0.7147129,
        size.height * 0.5000000);
    path_19.lineTo(size.width * 0.7147129, size.height * 0.5000000);
    path_19.cubicTo(
        size.width * 0.7147129,
        size.height * 0.5083340,
        size.width * 0.7063789,
        size.height * 0.5166660,
        size.width * 0.6980469,
        size.height * 0.5166660);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.5166660);
    path_19.cubicTo(
        size.width * 0.6897129,
        size.height * 0.5166660,
        size.width * 0.6813809,
        size.height * 0.5083340,
        size.width * 0.6813809,
        size.height * 0.5000000);
    path_19.close();
    path_19.moveTo(size.width * 0.6813809, size.height * 0.4383340);
    path_19.cubicTo(
        size.width * 0.6813809,
        size.height * 0.4300000,
        size.width * 0.6897148,
        size.height * 0.4216680,
        size.width * 0.6980469,
        size.height * 0.4216680);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.4216680);
    path_19.cubicTo(
        size.width * 0.7063809,
        size.height * 0.4216680,
        size.width * 0.7147129,
        size.height * 0.4300020,
        size.width * 0.7147129,
        size.height * 0.4383340);
    path_19.lineTo(size.width * 0.7147129, size.height * 0.4383340);
    path_19.cubicTo(
        size.width * 0.7147129,
        size.height * 0.4483340,
        size.width * 0.7063789,
        size.height * 0.4550000,
        size.width * 0.6980469,
        size.height * 0.4550000);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.4550000);
    path_19.cubicTo(
        size.width * 0.6897129,
        size.height * 0.4550000,
        size.width * 0.6813809,
        size.height * 0.4483340,
        size.width * 0.6813809,
        size.height * 0.4383340);
    path_19.close();
    path_19.moveTo(size.width * 0.6813809, size.height * 0.3783340);
    path_19.cubicTo(
        size.width * 0.6813809,
        size.height * 0.3683340,
        size.width * 0.6897148,
        size.height * 0.3616680,
        size.width * 0.6980469,
        size.height * 0.3616680);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.3616680);
    path_19.cubicTo(
        size.width * 0.7063809,
        size.height * 0.3616680,
        size.width * 0.7147129,
        size.height * 0.3683340,
        size.width * 0.7147129,
        size.height * 0.3783340);
    path_19.lineTo(size.width * 0.7147129, size.height * 0.3783340);
    path_19.cubicTo(
        size.width * 0.7147129,
        size.height * 0.3866680,
        size.width * 0.7063789,
        size.height * 0.3950000,
        size.width * 0.6980469,
        size.height * 0.3950000);
    path_19.lineTo(size.width * 0.6980469, size.height * 0.3950000);
    path_19.cubicTo(
        size.width * 0.6897129,
        size.height * 0.3950000,
        size.width * 0.6813809,
        size.height * 0.3866660,
        size.width * 0.6813809,
        size.height * 0.3783340);
    path_19.close();

    Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
    paint_19_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_19, paint_19_fill);

    Path path_20 = Path();
    path_20.moveTo(size.width * 0.8947129, size.height * 0.6833340);
    path_20.cubicTo(
        size.width * 0.8947129,
        size.height * 0.6750000,
        size.width * 0.9030469,
        size.height * 0.6666680,
        size.width * 0.9113789,
        size.height * 0.6666680);
    path_20.lineTo(size.width * 0.9113789, size.height * 0.6666680);
    path_20.cubicTo(
        size.width * 0.9197129,
        size.height * 0.6666680,
        size.width * 0.9280449,
        size.height * 0.6750020,
        size.width * 0.9280449,
        size.height * 0.6833340);
    path_20.lineTo(size.width * 0.9280449, size.height * 0.6833340);
    path_20.cubicTo(
        size.width * 0.9280449,
        size.height * 0.6916680,
        size.width * 0.9197109,
        size.height * 0.7000000,
        size.width * 0.9113789,
        size.height * 0.7000000);
    path_20.lineTo(size.width * 0.9113789, size.height * 0.7000000);
    path_20.cubicTo(
        size.width * 0.9013809,
        size.height * 0.7000000,
        size.width * 0.8947129,
        size.height * 0.6916660,
        size.width * 0.8947129,
        size.height * 0.6833340);
    path_20.close();
    path_20.moveTo(size.width * 0.8230469, size.height * 0.6833340);
    path_20.cubicTo(
        size.width * 0.8230469,
        size.height * 0.6750000,
        size.width * 0.8313809,
        size.height * 0.6666680,
        size.width * 0.8397129,
        size.height * 0.6666680);
    path_20.lineTo(size.width * 0.8397129, size.height * 0.6666680);
    path_20.cubicTo(
        size.width * 0.8480469,
        size.height * 0.6666680,
        size.width * 0.8563789,
        size.height * 0.6750020,
        size.width * 0.8563789,
        size.height * 0.6833340);
    path_20.lineTo(size.width * 0.8563789, size.height * 0.6833340);
    path_20.cubicTo(
        size.width * 0.8563789,
        size.height * 0.6916680,
        size.width * 0.8480449,
        size.height * 0.7000000,
        size.width * 0.8397129,
        size.height * 0.7000000);
    path_20.lineTo(size.width * 0.8397129, size.height * 0.7000000);
    path_20.cubicTo(
        size.width * 0.8313809,
        size.height * 0.7000000,
        size.width * 0.8230469,
        size.height * 0.6916660,
        size.width * 0.8230469,
        size.height * 0.6833340);
    path_20.close();
    path_20.moveTo(size.width * 0.7513809, size.height * 0.6833340);
    path_20.cubicTo(
        size.width * 0.7513809,
        size.height * 0.6750000,
        size.width * 0.7597148,
        size.height * 0.6666680,
        size.width * 0.7680469,
        size.height * 0.6666680);
    path_20.lineTo(size.width * 0.7680469, size.height * 0.6666680);
    path_20.cubicTo(
        size.width * 0.7763809,
        size.height * 0.6666680,
        size.width * 0.7847129,
        size.height * 0.6750020,
        size.width * 0.7847129,
        size.height * 0.6833340);
    path_20.lineTo(size.width * 0.7847129, size.height * 0.6833340);
    path_20.cubicTo(
        size.width * 0.7847129,
        size.height * 0.6916680,
        size.width * 0.7763789,
        size.height * 0.7000000,
        size.width * 0.7680469,
        size.height * 0.7000000);
    path_20.lineTo(size.width * 0.7680469, size.height * 0.7000000);
    path_20.cubicTo(
        size.width * 0.7597129,
        size.height * 0.7000000,
        size.width * 0.7513809,
        size.height * 0.6916660,
        size.width * 0.7513809,
        size.height * 0.6833340);
    path_20.close();

    Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
    paint_20_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_20, paint_20_fill);

    Path path_21 = Path();
    path_21.moveTo(size.width * 0.9647129, size.height * 0.6216660);
    path_21.cubicTo(
        size.width * 0.9647129,
        size.height * 0.6133320,
        size.width * 0.9730469,
        size.height * 0.6050000,
        size.width * 0.9813789,
        size.height * 0.6050000);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.6050000);
    path_21.cubicTo(
        size.width * 0.9897129,
        size.height * 0.6050000,
        size.width * 0.9980449,
        size.height * 0.6133340,
        size.width * 0.9980449,
        size.height * 0.6216660);
    path_21.lineTo(size.width * 0.9980449, size.height * 0.6216660);
    path_21.cubicTo(
        size.width * 0.9980449,
        size.height * 0.6300000,
        size.width * 0.9897109,
        size.height * 0.6383320,
        size.width * 0.9813789,
        size.height * 0.6383320);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.6383320);
    path_21.cubicTo(
        size.width * 0.9730469,
        size.height * 0.6383340,
        size.width * 0.9647129,
        size.height * 0.6316660,
        size.width * 0.9647129,
        size.height * 0.6216660);
    path_21.close();
    path_21.moveTo(size.width * 0.9647129, size.height * 0.5616660);
    path_21.cubicTo(
        size.width * 0.9647129,
        size.height * 0.5516660,
        size.width * 0.9730469,
        size.height * 0.5450000,
        size.width * 0.9813789,
        size.height * 0.5450000);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.5450000);
    path_21.cubicTo(
        size.width * 0.9897129,
        size.height * 0.5450000,
        size.width * 0.9980449,
        size.height * 0.5516660,
        size.width * 0.9980449,
        size.height * 0.5616660);
    path_21.lineTo(size.width * 0.9980449, size.height * 0.5616660);
    path_21.cubicTo(
        size.width * 0.9980449,
        size.height * 0.5716660,
        size.width * 0.9897109,
        size.height * 0.5783320,
        size.width * 0.9813789,
        size.height * 0.5783320);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.5783320);
    path_21.cubicTo(
        size.width * 0.9730469,
        size.height * 0.5783340,
        size.width * 0.9647129,
        size.height * 0.5700000,
        size.width * 0.9647129,
        size.height * 0.5616660);
    path_21.close();
    path_21.moveTo(size.width * 0.9647129, size.height * 0.5000000);
    path_21.cubicTo(
        size.width * 0.9647129,
        size.height * 0.4900000,
        size.width * 0.9730469,
        size.height * 0.4833340,
        size.width * 0.9813789,
        size.height * 0.4833340);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.4833340);
    path_21.cubicTo(
        size.width * 0.9897129,
        size.height * 0.4833340,
        size.width * 0.9980449,
        size.height * 0.4900000,
        size.width * 0.9980449,
        size.height * 0.5000000);
    path_21.lineTo(size.width * 0.9980449, size.height * 0.5000000);
    path_21.cubicTo(
        size.width * 0.9980449,
        size.height * 0.5083340,
        size.width * 0.9897109,
        size.height * 0.5166660,
        size.width * 0.9813789,
        size.height * 0.5166660);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.5166660);
    path_21.cubicTo(
        size.width * 0.9730469,
        size.height * 0.5166660,
        size.width * 0.9647129,
        size.height * 0.5083340,
        size.width * 0.9647129,
        size.height * 0.5000000);
    path_21.close();
    path_21.moveTo(size.width * 0.9647129, size.height * 0.4383340);
    path_21.cubicTo(
        size.width * 0.9647129,
        size.height * 0.4300000,
        size.width * 0.9730469,
        size.height * 0.4216680,
        size.width * 0.9813789,
        size.height * 0.4216680);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.4216680);
    path_21.cubicTo(
        size.width * 0.9897129,
        size.height * 0.4216680,
        size.width * 0.9980449,
        size.height * 0.4300020,
        size.width * 0.9980449,
        size.height * 0.4383340);
    path_21.lineTo(size.width * 0.9980449, size.height * 0.4383340);
    path_21.cubicTo(
        size.width * 0.9980449,
        size.height * 0.4483340,
        size.width * 0.9897109,
        size.height * 0.4550000,
        size.width * 0.9813789,
        size.height * 0.4550000);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.4550000);
    path_21.cubicTo(
        size.width * 0.9730469,
        size.height * 0.4550000,
        size.width * 0.9647129,
        size.height * 0.4483340,
        size.width * 0.9647129,
        size.height * 0.4383340);
    path_21.close();
    path_21.moveTo(size.width * 0.9647129, size.height * 0.3783340);
    path_21.cubicTo(
        size.width * 0.9647129,
        size.height * 0.3700000,
        size.width * 0.9730469,
        size.height * 0.3616680,
        size.width * 0.9813789,
        size.height * 0.3616680);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.3616680);
    path_21.cubicTo(
        size.width * 0.9897129,
        size.height * 0.3616680,
        size.width * 0.9980449,
        size.height * 0.3700020,
        size.width * 0.9980449,
        size.height * 0.3783340);
    path_21.lineTo(size.width * 0.9980449, size.height * 0.3783340);
    path_21.cubicTo(
        size.width * 0.9980449,
        size.height * 0.3883340,
        size.width * 0.9897109,
        size.height * 0.3950000,
        size.width * 0.9813789,
        size.height * 0.3950000);
    path_21.lineTo(size.width * 0.9813789, size.height * 0.3950000);
    path_21.cubicTo(
        size.width * 0.9730469,
        size.height * 0.3950000,
        size.width * 0.9647129,
        size.height * 0.3866660,
        size.width * 0.9647129,
        size.height * 0.3783340);
    path_21.close();

    Paint paint_21_fill = Paint()..style = PaintingStyle.fill;
    paint_21_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_21, paint_21_fill);

    Path path_22 = Path();
    path_22.moveTo(size.width * 0.8947129, size.height * 0.3166660);
    path_22.cubicTo(
        size.width * 0.8947129,
        size.height * 0.3066660,
        size.width * 0.9030469,
        size.height * 0.3000000,
        size.width * 0.9113789,
        size.height * 0.3000000);
    path_22.lineTo(size.width * 0.9113789, size.height * 0.3000000);
    path_22.cubicTo(
        size.width * 0.9197129,
        size.height * 0.3000000,
        size.width * 0.9280449,
        size.height * 0.3066660,
        size.width * 0.9280449,
        size.height * 0.3166660);
    path_22.lineTo(size.width * 0.9280449, size.height * 0.3166660);
    path_22.cubicTo(
        size.width * 0.9280449,
        size.height * 0.3250000,
        size.width * 0.9197109,
        size.height * 0.3333320,
        size.width * 0.9113789,
        size.height * 0.3333320);
    path_22.lineTo(size.width * 0.9113789, size.height * 0.3333320);
    path_22.cubicTo(
        size.width * 0.9013809,
        size.height * 0.3333340,
        size.width * 0.8947129,
        size.height * 0.3250000,
        size.width * 0.8947129,
        size.height * 0.3166660);
    path_22.close();
    path_22.moveTo(size.width * 0.8230469, size.height * 0.3166660);
    path_22.cubicTo(
        size.width * 0.8230469,
        size.height * 0.3066660,
        size.width * 0.8313809,
        size.height * 0.3000000,
        size.width * 0.8397129,
        size.height * 0.3000000);
    path_22.lineTo(size.width * 0.8397129, size.height * 0.3000000);
    path_22.cubicTo(
        size.width * 0.8480469,
        size.height * 0.3000000,
        size.width * 0.8563789,
        size.height * 0.3066660,
        size.width * 0.8563789,
        size.height * 0.3166660);
    path_22.lineTo(size.width * 0.8563789, size.height * 0.3166660);
    path_22.cubicTo(
        size.width * 0.8563789,
        size.height * 0.3250000,
        size.width * 0.8480449,
        size.height * 0.3333320,
        size.width * 0.8397129,
        size.height * 0.3333320);
    path_22.lineTo(size.width * 0.8397129, size.height * 0.3333320);
    path_22.cubicTo(
        size.width * 0.8313809,
        size.height * 0.3333340,
        size.width * 0.8230469,
        size.height * 0.3250000,
        size.width * 0.8230469,
        size.height * 0.3166660);
    path_22.close();
    path_22.moveTo(size.width * 0.7513809, size.height * 0.3166660);
    path_22.cubicTo(
        size.width * 0.7513809,
        size.height * 0.3066660,
        size.width * 0.7597148,
        size.height * 0.3000000,
        size.width * 0.7680469,
        size.height * 0.3000000);
    path_22.lineTo(size.width * 0.7680469, size.height * 0.3000000);
    path_22.cubicTo(
        size.width * 0.7763809,
        size.height * 0.3000000,
        size.width * 0.7847129,
        size.height * 0.3066660,
        size.width * 0.7847129,
        size.height * 0.3166660);
    path_22.lineTo(size.width * 0.7847129, size.height * 0.3166660);
    path_22.cubicTo(
        size.width * 0.7847129,
        size.height * 0.3250000,
        size.width * 0.7763789,
        size.height * 0.3333320,
        size.width * 0.7680469,
        size.height * 0.3333320);
    path_22.lineTo(size.width * 0.7680469, size.height * 0.3333320);
    path_22.cubicTo(
        size.width * 0.7597129,
        size.height * 0.3333340,
        size.width * 0.7513809,
        size.height * 0.3250000,
        size.width * 0.7513809,
        size.height * 0.3166660);
    path_22.close();

    Paint paint_22_fill = Paint()..style = PaintingStyle.fill;
    paint_22_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_22, paint_22_fill);

    Path path_23 = Path();
    path_23.moveTo(size.width * 0.9147129, size.height * 0.2833340);
    path_23.cubicTo(
        size.width * 0.9113789,
        size.height * 0.2833340,
        size.width * 0.9080469,
        size.height * 0.2816680,
        size.width * 0.9047129,
        size.height * 0.2800000);
    path_23.lineTo(size.width * 0.8380469, size.height * 0.2300000);
    path_23.cubicTo(
        size.width * 0.8313809,
        size.height * 0.2250000,
        size.width * 0.8297129,
        size.height * 0.2133340,
        size.width * 0.8347129,
        size.height * 0.2066660);
    path_23.cubicTo(
        size.width * 0.8397129,
        size.height * 0.1999980,
        size.width * 0.8513789,
        size.height * 0.1983320,
        size.width * 0.8580469,
        size.height * 0.2033320);
    path_23.lineTo(size.width * 0.9247129, size.height * 0.2533320);
    path_23.cubicTo(
        size.width * 0.9313789,
        size.height * 0.2583320,
        size.width * 0.9330469,
        size.height * 0.2699980,
        size.width * 0.9280469,
        size.height * 0.2766660);
    path_23.cubicTo(
        size.width * 0.9247129,
        size.height * 0.2816660,
        size.width * 0.9197129,
        size.height * 0.2833340,
        size.width * 0.9147129,
        size.height * 0.2833340);
    path_23.close();

    Paint paint_23_fill = Paint()..style = PaintingStyle.fill;
    paint_23_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_23, paint_23_fill);

    Path path_24 = Path();
    path_24.moveTo(size.width * 0.9147129, size.height * 0.2833340);
    path_24.cubicTo(
        size.width * 0.9113789,
        size.height * 0.2833340,
        size.width * 0.9097129,
        size.height * 0.2833340,
        size.width * 0.9080469,
        size.height * 0.2816680);
    path_24.cubicTo(
        size.width * 0.9013809,
        size.height * 0.2783340,
        size.width * 0.8980469,
        size.height * 0.2733340,
        size.width * 0.8980469,
        size.height * 0.2666680);
    path_24.lineTo(size.width * 0.8980469, size.height * 0.2333340);
    path_24.cubicTo(
        size.width * 0.8980469,
        size.height * 0.1233340,
        size.width * 0.8080469,
        size.height * 0.03333398,
        size.width * 0.6980469,
        size.height * 0.03333398);
    path_24.cubicTo(
        size.width * 0.6880469,
        size.height * 0.03333398,
        size.width * 0.6813809,
        size.height * 0.02666797,
        size.width * 0.6813809,
        size.height * 0.01666797);
    path_24.cubicTo(size.width * 0.6813809, size.height * 0.006667969,
        size.width * 0.6880469, 0, size.width * 0.6980469, 0);
    path_24.cubicTo(
        size.width * 0.8263809,
        0,
        size.width * 0.9313809,
        size.height * 0.1050000,
        size.width * 0.9313809,
        size.height * 0.2333340);
    path_24.lineTo(size.width * 0.9713809, size.height * 0.2033340);
    path_24.cubicTo(
        size.width * 0.9780469,
        size.height * 0.1983340,
        size.width * 0.9897148,
        size.height * 0.2000000,
        size.width * 0.9947148,
        size.height * 0.2066680);
    path_24.cubicTo(
        size.width * 0.9997148,
        size.height * 0.2133340,
        size.width * 0.9980488,
        size.height * 0.2250020,
        size.width * 0.9913809,
        size.height * 0.2300020);
    path_24.lineTo(size.width * 0.9247148, size.height * 0.2800020);
    path_24.cubicTo(
        size.width * 0.9213809,
        size.height * 0.2816660,
        size.width * 0.9180469,
        size.height * 0.2833340,
        size.width * 0.9147129,
        size.height * 0.2833340);
    path_24.close();

    Paint paint_24_fill = Paint()..style = PaintingStyle.fill;
    paint_24_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_24, paint_24_fill);

    Path path_25 = Path();
    path_25.moveTo(size.width * 0.1647129, size.height * 0.8000000);
    path_25.cubicTo(
        size.width * 0.1613789,
        size.height * 0.8000000,
        size.width * 0.1580469,
        size.height * 0.7983340,
        size.width * 0.1547129,
        size.height * 0.7966660);
    path_25.lineTo(size.width * 0.08804687, size.height * 0.7466660);
    path_25.cubicTo(
        size.width * 0.08138086,
        size.height * 0.7416660,
        size.width * 0.07971289,
        size.height * 0.7300000,
        size.width * 0.08471289,
        size.height * 0.7233320);
    path_25.cubicTo(
        size.width * 0.08971289,
        size.height * 0.7166660,
        size.width * 0.1013789,
        size.height * 0.7149980,
        size.width * 0.1080469,
        size.height * 0.7199980);
    path_25.lineTo(size.width * 0.1747129, size.height * 0.7699980);
    path_25.cubicTo(
        size.width * 0.1813789,
        size.height * 0.7749980,
        size.width * 0.1830469,
        size.height * 0.7866641,
        size.width * 0.1780469,
        size.height * 0.7933320);
    path_25.cubicTo(
        size.width * 0.1747129,
        size.height * 0.7983340,
        size.width * 0.1697129,
        size.height * 0.8000000,
        size.width * 0.1647129,
        size.height * 0.8000000);
    path_25.close();

    Paint paint_25_fill = Paint()..style = PaintingStyle.fill;
    paint_25_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_25, paint_25_fill);

    Path path_26 = Path();
    path_26.moveTo(size.width * 0.3147129, size.height);
    path_26.cubicTo(
        size.width * 0.1863789,
        size.height,
        size.width * 0.08137891,
        size.height * 0.8950000,
        size.width * 0.08137891,
        size.height * 0.7666660);
    path_26.lineTo(size.width * 0.04137891, size.height * 0.7966660);
    path_26.cubicTo(
        size.width * 0.03471289,
        size.height * 0.8016660,
        size.width * 0.02304492,
        size.height * 0.8000000,
        size.width * 0.01804492,
        size.height * 0.7933320);
    path_26.cubicTo(
        size.width * 0.01304492,
        size.height * 0.7866641,
        size.width * 0.01471094,
        size.height * 0.7749980,
        size.width * 0.02137891,
        size.height * 0.7699980);
    path_26.lineTo(size.width * 0.08804492, size.height * 0.7199980);
    path_26.cubicTo(
        size.width * 0.09304492,
        size.height * 0.7166641,
        size.width * 0.09971094,
        size.height * 0.7149980,
        size.width * 0.1047109,
        size.height * 0.7183320);
    path_26.cubicTo(
        size.width * 0.1113770,
        size.height * 0.7216660,
        size.width * 0.1147109,
        size.height * 0.7266660,
        size.width * 0.1147109,
        size.height * 0.7333320);
    path_26.lineTo(size.width * 0.1147109, size.height * 0.7666660);
    path_26.cubicTo(
        size.width * 0.1147109,
        size.height * 0.8766660,
        size.width * 0.2047109,
        size.height * 0.9666660,
        size.width * 0.3147109,
        size.height * 0.9666660);
    path_26.cubicTo(
        size.width * 0.3247109,
        size.height * 0.9666660,
        size.width * 0.3313770,
        size.height * 0.9733320,
        size.width * 0.3313770,
        size.height * 0.9833320);
    path_26.cubicTo(
        size.width * 0.3313809,
        size.height * 0.9933340,
        size.width * 0.3247129,
        size.height,
        size.width * 0.3147129,
        size.height);
    path_26.close();

    Paint paint_26_fill = Paint()..style = PaintingStyle.fill;
    paint_26_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_26, paint_26_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
