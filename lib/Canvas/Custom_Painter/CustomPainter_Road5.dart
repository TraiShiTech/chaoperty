import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Road5 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Road5(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9813809, size.height * 0.3833340);
    path_0.lineTo(size.width * 0.7747129, size.height * 0.3833340);
    path_0.cubicTo(
        size.width * 0.7447129,
        size.height * 0.3116680,
        size.width * 0.6863789,
        size.height * 0.2533340,
        size.width * 0.6147129,
        size.height * 0.2233340);
    path_0.lineTo(size.width * 0.6147129, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.3813809, size.height * 0.01666602);
    path_0.lineTo(size.width * 0.3813809, size.height * 0.2233320);
    path_0.cubicTo(
        size.width * 0.3097148,
        size.height * 0.2533320,
        size.width * 0.2513809,
        size.height * 0.3116660,
        size.width * 0.2213809,
        size.height * 0.3833320);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.3833320);
    path_0.lineTo(size.width * 0.01471289, size.height * 0.6166660);
    path_0.lineTo(size.width * 0.2213789, size.height * 0.6166660);
    path_0.cubicTo(
        size.width * 0.2513789,
        size.height * 0.6883320,
        size.width * 0.3097129,
        size.height * 0.7466660,
        size.width * 0.3813789,
        size.height * 0.7766660);
    path_0.lineTo(size.width * 0.3813789, size.height * 0.9833320);
    path_0.lineTo(size.width * 0.6147129, size.height * 0.9833320);
    path_0.lineTo(size.width * 0.6147129, size.height * 0.7766660);
    path_0.cubicTo(
        size.width * 0.6863789,
        size.height * 0.7466660,
        size.width * 0.7447129,
        size.height * 0.6883320,
        size.width * 0.7747129,
        size.height * 0.6166660);
    path_0.lineTo(size.width * 0.9813789, size.height * 0.6166660);
    path_0.lineTo(size.width * 0.9813789, size.height * 0.3833340);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9313809, size.height * 0.6166660);
    path_1.lineTo(size.width * 0.9813809, size.height * 0.6166660);
    path_1.lineTo(size.width * 0.9813809, size.height * 0.3833340);
    path_1.lineTo(size.width * 0.9313809, size.height * 0.3833340);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.01471289, size.height * 0.6166660);
    path_2.lineTo(size.width * 0.06471289, size.height * 0.6166660);
    path_2.lineTo(size.width * 0.06471289, size.height * 0.3833340);
    path_2.lineTo(size.width * 0.01471289, size.height * 0.3833340);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.6313809, size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.6313809,
        size.height * 0.5733340,
        size.width * 0.5713809,
        size.height * 0.6333340,
        size.width * 0.4980469,
        size.height * 0.6333340);
    path_3.cubicTo(
        size.width * 0.4247129,
        size.height * 0.6333340,
        size.width * 0.3647129,
        size.height * 0.5733340,
        size.width * 0.3647129,
        size.height * 0.5000000);
    path_3.cubicTo(
        size.width * 0.3647129,
        size.height * 0.4266660,
        size.width * 0.4247129,
        size.height * 0.3666660,
        size.width * 0.4980469,
        size.height * 0.3666660);
    path_3.cubicTo(
        size.width * 0.5713809,
        size.height * 0.3666660,
        size.width * 0.6313809,
        size.height * 0.4266660,
        size.width * 0.6313809,
        size.height * 0.5000000);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffFDCC00).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4980469, size.height * 0.3666660);
    path_4.cubicTo(
        size.width * 0.4897129,
        size.height * 0.3666660,
        size.width * 0.4813809,
        size.height * 0.3683320,
        size.width * 0.4730469,
        size.height * 0.3683320);
    path_4.cubicTo(
        size.width * 0.5347129,
        size.height * 0.3799980,
        size.width * 0.5813809,
        size.height * 0.4349980,
        size.width * 0.5813809,
        size.height * 0.4999980);
    path_4.cubicTo(
        size.width * 0.5813809,
        size.height * 0.5649980,
        size.width * 0.5347148,
        size.height * 0.6199980,
        size.width * 0.4730469,
        size.height * 0.6316641);
    path_4.cubicTo(
        size.width * 0.4813809,
        size.height * 0.6333301,
        size.width * 0.4897129,
        size.height * 0.6333301,
        size.width * 0.4980469,
        size.height * 0.6333301);
    path_4.cubicTo(
        size.width * 0.5713809,
        size.height * 0.6333301,
        size.width * 0.6313809,
        size.height * 0.5733301,
        size.width * 0.6313809,
        size.height * 0.4999961);
    path_4.cubicTo(
        size.width * 0.6313809,
        size.height * 0.4266621,
        size.width * 0.5713809,
        size.height * 0.3666660,
        size.width * 0.4980469,
        size.height * 0.3666660);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffFFA800).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.6500000);
    path_5.cubicTo(
        size.width * 0.4147129,
        size.height * 0.6500000,
        size.width * 0.3480469,
        size.height * 0.5833340,
        size.width * 0.3480469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.3480469,
        size.height * 0.4166660,
        size.width * 0.4147129,
        size.height * 0.3500000,
        size.width * 0.4980469,
        size.height * 0.3500000);
    path_5.cubicTo(
        size.width * 0.5813809,
        size.height * 0.3500000,
        size.width * 0.6480469,
        size.height * 0.4166660,
        size.width * 0.6480469,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.6480469,
        size.height * 0.5833340,
        size.width * 0.5813809,
        size.height * 0.6500000,
        size.width * 0.4980469,
        size.height * 0.6500000);
    path_5.close();
    path_5.moveTo(size.width * 0.4980469, size.height * 0.3833340);
    path_5.cubicTo(
        size.width * 0.4330469,
        size.height * 0.3833340,
        size.width * 0.3813809,
        size.height * 0.4350000,
        size.width * 0.3813809,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.3813809,
        size.height * 0.5650000,
        size.width * 0.4330469,
        size.height * 0.6166660,
        size.width * 0.4980469,
        size.height * 0.6166660);
    path_5.cubicTo(
        size.width * 0.5630469,
        size.height * 0.6166660,
        size.width * 0.6147129,
        size.height * 0.5650000,
        size.width * 0.6147129,
        size.height * 0.5000000);
    path_5.cubicTo(
        size.width * 0.6147129,
        size.height * 0.4350000,
        size.width * 0.5630469,
        size.height * 0.3833340,
        size.width * 0.4980469,
        size.height * 0.3833340);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.6313809, size.height);
    path_6.lineTo(size.width * 0.3647129, size.height);
    path_6.lineTo(size.width * 0.3647129, size.height * 0.7866660);
    path_6.cubicTo(
        size.width * 0.2980469,
        size.height * 0.7550000,
        size.width * 0.2413789,
        size.height * 0.7000000,
        size.width * 0.2113789,
        size.height * 0.6333320);
    path_6.lineTo(size.width * -0.001953125, size.height * 0.6333320);
    path_6.lineTo(size.width * -0.001953125, size.height * 0.3666660);
    path_6.lineTo(size.width * 0.2113809, size.height * 0.3666660);
    path_6.cubicTo(
        size.width * 0.2430469,
        size.height * 0.3000000,
        size.width * 0.2980469,
        size.height * 0.2433320,
        size.width * 0.3647148,
        size.height * 0.2133320);
    path_6.lineTo(size.width * 0.3647148, 0);
    path_6.lineTo(size.width * 0.6313809, 0);
    path_6.lineTo(size.width * 0.6313809, size.height * 0.2133340);
    path_6.cubicTo(
        size.width * 0.6980469,
        size.height * 0.2450000,
        size.width * 0.7547148,
        size.height * 0.3000000,
        size.width * 0.7847148,
        size.height * 0.3666680);
    path_6.lineTo(size.width * 0.9980469, size.height * 0.3666680);
    path_6.lineTo(size.width * 0.9980469, size.height * 0.6333340);
    path_6.lineTo(size.width * 0.7847129, size.height * 0.6333340);
    path_6.cubicTo(
        size.width * 0.7530469,
        size.height * 0.7000000,
        size.width * 0.6980469,
        size.height * 0.7566680,
        size.width * 0.6313789,
        size.height * 0.7866680);
    path_6.lineTo(size.width * 0.6313789, size.height);
    path_6.close();
    path_6.moveTo(size.width * 0.3980469, size.height * 0.9666660);
    path_6.lineTo(size.width * 0.5980469, size.height * 0.9666660);
    path_6.lineTo(size.width * 0.5980469, size.height * 0.7650000);
    path_6.lineTo(size.width * 0.6080469, size.height * 0.7600000);
    path_6.cubicTo(
        size.width * 0.6747129,
        size.height * 0.7316660,
        size.width * 0.7297129,
        size.height * 0.6766660,
        size.width * 0.7597129,
        size.height * 0.6083340);
    path_6.lineTo(size.width * 0.7647129, size.height * 0.5983340);
    path_6.lineTo(size.width * 0.9647129, size.height * 0.5983340);
    path_6.lineTo(size.width * 0.9647129, size.height * 0.4000000);
    path_6.lineTo(size.width * 0.7630469, size.height * 0.4000000);
    path_6.lineTo(size.width * 0.7580469, size.height * 0.3900000);
    path_6.cubicTo(
        size.width * 0.7297129,
        size.height * 0.3233340,
        size.width * 0.6747129,
        size.height * 0.2683340,
        size.width * 0.6063809,
        size.height * 0.2383340);
    path_6.lineTo(size.width * 0.5980469, size.height * 0.2350000);
    path_6.lineTo(size.width * 0.5980469, size.height * 0.03333398);
    path_6.lineTo(size.width * 0.3980469, size.height * 0.03333398);
    path_6.lineTo(size.width * 0.3980469, size.height * 0.2350000);
    path_6.lineTo(size.width * 0.3880469, size.height * 0.2400000);
    path_6.cubicTo(
        size.width * 0.3213809,
        size.height * 0.2683340,
        size.width * 0.2663809,
        size.height * 0.3233340,
        size.width * 0.2363809,
        size.height * 0.3916660);
    path_6.lineTo(size.width * 0.2330469, size.height * 0.4000000);
    path_6.lineTo(size.width * 0.03138086, size.height * 0.4000000);
    path_6.lineTo(size.width * 0.03138086, size.height * 0.6000000);
    path_6.lineTo(size.width * 0.2330469, size.height * 0.6000000);
    path_6.lineTo(size.width * 0.2380469, size.height * 0.6100000);
    path_6.cubicTo(
        size.width * 0.2663809,
        size.height * 0.6766660,
        size.width * 0.3213809,
        size.height * 0.7316660,
        size.width * 0.3897129,
        size.height * 0.7616660);
    path_6.lineTo(size.width * 0.3997129, size.height * 0.7666660);
    path_6.lineTo(size.width * 0.3997129, size.height * 0.9666660);
    path_6.lineTo(size.width * 0.3980469, size.height * 0.9666660);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.4980469, size.height * 0.7333340);
    path_7.cubicTo(
        size.width * 0.4763809,
        size.height * 0.7333340,
        size.width * 0.4547129,
        size.height * 0.7300000,
        size.width * 0.4347129,
        size.height * 0.7250000);
    path_7.cubicTo(
        size.width * 0.4263789,
        size.height * 0.7233340,
        size.width * 0.4213789,
        size.height * 0.7133340,
        size.width * 0.4230469,
        size.height * 0.7050000);
    path_7.cubicTo(
        size.width * 0.4247129,
        size.height * 0.6966660,
        size.width * 0.4347129,
        size.height * 0.6916660,
        size.width * 0.4430469,
        size.height * 0.6933340);
    path_7.cubicTo(
        size.width * 0.4630469,
        size.height * 0.6983340,
        size.width * 0.4830469,
        size.height * 0.7016680,
        size.width * 0.5047129,
        size.height * 0.7000000);
    path_7.cubicTo(
        size.width * 0.5130469,
        size.height * 0.6983340,
        size.width * 0.5213789,
        size.height * 0.7066660,
        size.width * 0.5213789,
        size.height * 0.7166660);
    path_7.cubicTo(
        size.width * 0.5213789,
        size.height * 0.7266660,
        size.width * 0.5147129,
        size.height * 0.7333320,
        size.width * 0.5047129,
        size.height * 0.7333320);
    path_7.cubicTo(
        size.width * 0.5030469,
        size.height * 0.7333340,
        size.width * 0.5013809,
        size.height * 0.7333340,
        size.width * 0.4980469,
        size.height * 0.7333340);
    path_7.close();
    path_7.moveTo(size.width * 0.6013809, size.height * 0.7066660);
    path_7.cubicTo(
        size.width * 0.5947148,
        size.height * 0.7066660,
        size.width * 0.5897148,
        size.height * 0.7033320,
        size.width * 0.5863809,
        size.height * 0.6983320);
    path_7.cubicTo(
        size.width * 0.5813809,
        size.height * 0.6899980,
        size.width * 0.5847148,
        size.height * 0.6799980,
        size.width * 0.5930469,
        size.height * 0.6749980);
    path_7.cubicTo(
        size.width * 0.6113809,
        size.height * 0.6649980,
        size.width * 0.6280469,
        size.height * 0.6533320,
        size.width * 0.6413809,
        size.height * 0.6383320);
    path_7.cubicTo(
        size.width * 0.6480469,
        size.height * 0.6316660,
        size.width * 0.6580469,
        size.height * 0.6316660,
        size.width * 0.6647148,
        size.height * 0.6383320);
    path_7.cubicTo(
        size.width * 0.6713809,
        size.height * 0.6449980,
        size.width * 0.6713809,
        size.height * 0.6549980,
        size.width * 0.6647148,
        size.height * 0.6616660);
    path_7.cubicTo(
        size.width * 0.6480488,
        size.height * 0.6783320,
        size.width * 0.6280488,
        size.height * 0.6933320,
        size.width * 0.6080488,
        size.height * 0.7050000);
    path_7.cubicTo(
        size.width * 0.6063809,
        size.height * 0.7066660,
        size.width * 0.6030469,
        size.height * 0.7066660,
        size.width * 0.6013809,
        size.height * 0.7066660);
    path_7.close();
    path_7.moveTo(size.width * 0.3530469, size.height * 0.6766660);
    path_7.cubicTo(
        size.width * 0.3497129,
        size.height * 0.6766660,
        size.width * 0.3447129,
        size.height * 0.6750000,
        size.width * 0.3413809,
        size.height * 0.6716660);
    path_7.cubicTo(
        size.width * 0.3230469,
        size.height * 0.6550000,
        size.width * 0.3080469,
        size.height * 0.6366660,
        size.width * 0.2963809,
        size.height * 0.6166660);
    path_7.cubicTo(
        size.width * 0.2913809,
        size.height * 0.6083320,
        size.width * 0.2947148,
        size.height * 0.5983320,
        size.width * 0.3030469,
        size.height * 0.5933320);
    path_7.cubicTo(
        size.width * 0.3113809,
        size.height * 0.5883320,
        size.width * 0.3213809,
        size.height * 0.5916660,
        size.width * 0.3263809,
        size.height * 0.5999980);
    path_7.cubicTo(
        size.width * 0.3363809,
        size.height * 0.6183320,
        size.width * 0.3497148,
        size.height * 0.6333320,
        size.width * 0.3647148,
        size.height * 0.6483320);
    path_7.cubicTo(
        size.width * 0.3713809,
        size.height * 0.6549980,
        size.width * 0.3713809,
        size.height * 0.6649980,
        size.width * 0.3663809,
        size.height * 0.6716660);
    path_7.cubicTo(
        size.width * 0.3613809,
        size.height * 0.6750000,
        size.width * 0.3563809,
        size.height * 0.6766660,
        size.width * 0.3530469,
        size.height * 0.6766660);
    path_7.close();
    path_7.moveTo(size.width * 0.7047129, size.height * 0.5816660);
    path_7.cubicTo(
        size.width * 0.7030469,
        size.height * 0.5816660,
        size.width * 0.7013789,
        size.height * 0.5816660,
        size.width * 0.6997129,
        size.height * 0.5816660);
    path_7.cubicTo(
        size.width * 0.6913789,
        size.height * 0.5783320,
        size.width * 0.6863789,
        size.height * 0.5700000,
        size.width * 0.6880469,
        size.height * 0.5600000);
    path_7.cubicTo(
        size.width * 0.6947129,
        size.height * 0.5400000,
        size.width * 0.6980469,
        size.height * 0.5200000,
        size.width * 0.6980469,
        size.height * 0.5000000);
    path_7.cubicTo(
        size.width * 0.6980469,
        size.height * 0.4916660,
        size.width * 0.6980469,
        size.height * 0.4816660,
        size.width * 0.6963809,
        size.height * 0.4733340);
    path_7.cubicTo(
        size.width * 0.6947148,
        size.height * 0.4650000,
        size.width * 0.7013809,
        size.height * 0.4566680,
        size.width * 0.7113809,
        size.height * 0.4550000);
    path_7.cubicTo(
        size.width * 0.7213809,
        size.height * 0.4533320,
        size.width * 0.7280469,
        size.height * 0.4600000,
        size.width * 0.7297148,
        size.height * 0.4700000);
    path_7.cubicTo(
        size.width * 0.7313809,
        size.height * 0.4800000,
        size.width * 0.7313809,
        size.height * 0.4900000,
        size.width * 0.7313809,
        size.height * 0.5000000);
    path_7.cubicTo(
        size.width * 0.7313809,
        size.height * 0.5233340,
        size.width * 0.7280469,
        size.height * 0.5483340,
        size.width * 0.7197148,
        size.height * 0.5700000);
    path_7.cubicTo(
        size.width * 0.7180469,
        size.height * 0.5783340,
        size.width * 0.7113809,
        size.height * 0.5816660,
        size.width * 0.7047129,
        size.height * 0.5816660);
    path_7.close();
    path_7.moveTo(size.width * 0.2813809, size.height * 0.5316660);
    path_7.cubicTo(
        size.width * 0.2730469,
        size.height * 0.5316660,
        size.width * 0.2647148,
        size.height * 0.5250000,
        size.width * 0.2647148,
        size.height * 0.5166660);
    path_7.cubicTo(
        size.width * 0.2647148,
        size.height * 0.5116660,
        size.width * 0.2647148,
        size.height * 0.5066660,
        size.width * 0.2647148,
        size.height * 0.5016660);
    path_7.cubicTo(
        size.width * 0.2647148,
        size.height * 0.4833320,
        size.width * 0.2663809,
        size.height * 0.4633320,
        size.width * 0.2713809,
        size.height * 0.4466660);
    path_7.cubicTo(
        size.width * 0.2730469,
        size.height * 0.4383320,
        size.width * 0.2830469,
        size.height * 0.4316660,
        size.width * 0.2913809,
        size.height * 0.4350000);
    path_7.cubicTo(
        size.width * 0.2997148,
        size.height * 0.4366660,
        size.width * 0.3063809,
        size.height * 0.4466660,
        size.width * 0.3030469,
        size.height * 0.4550000);
    path_7.cubicTo(
        size.width * 0.2997129,
        size.height * 0.4683340,
        size.width * 0.2980469,
        size.height * 0.4833340,
        size.width * 0.2980469,
        size.height * 0.5000000);
    path_7.cubicTo(
        size.width * 0.2980469,
        size.height * 0.5050000,
        size.width * 0.2980469,
        size.height * 0.5083340,
        size.width * 0.2980469,
        size.height * 0.5133340);
    path_7.cubicTo(
        size.width * 0.2997129,
        size.height * 0.5216660,
        size.width * 0.2913809,
        size.height * 0.5300000,
        size.width * 0.2813809,
        size.height * 0.5316660);
    path_7.cubicTo(
        size.width * 0.2830469,
        size.height * 0.5316660,
        size.width * 0.2813809,
        size.height * 0.5316660,
        size.width * 0.2813809,
        size.height * 0.5316660);
    path_7.close();
    path_7.moveTo(size.width * 0.6780469, size.height * 0.3950000);
    path_7.cubicTo(
        size.width * 0.6730469,
        size.height * 0.3950000,
        size.width * 0.6680469,
        size.height * 0.3916660,
        size.width * 0.6647129,
        size.height * 0.3883340);
    path_7.cubicTo(
        size.width * 0.6530469,
        size.height * 0.3716680,
        size.width * 0.6397129,
        size.height * 0.3566680,
        size.width * 0.6230469,
        size.height * 0.3433340);
    path_7.cubicTo(
        size.width * 0.6163809,
        size.height * 0.3383340,
        size.width * 0.6147129,
        size.height * 0.3266680,
        size.width * 0.6197129,
        size.height * 0.3200000);
    path_7.cubicTo(
        size.width * 0.6247129,
        size.height * 0.3133320,
        size.width * 0.6363789,
        size.height * 0.3116660,
        size.width * 0.6430469,
        size.height * 0.3166660);
    path_7.cubicTo(
        size.width * 0.6613809,
        size.height * 0.3316660,
        size.width * 0.6780469,
        size.height * 0.3500000,
        size.width * 0.6913809,
        size.height * 0.3683320);
    path_7.cubicTo(
        size.width * 0.6963809,
        size.height * 0.3766660,
        size.width * 0.6947148,
        size.height * 0.3866660,
        size.width * 0.6863809,
        size.height * 0.3916660);
    path_7.cubicTo(
        size.width * 0.6847129,
        size.height * 0.3950000,
        size.width * 0.6813809,
        size.height * 0.3950000,
        size.width * 0.6780469,
        size.height * 0.3950000);
    path_7.close();
    path_7.moveTo(size.width * 0.3330469, size.height * 0.3766660);
    path_7.cubicTo(
        size.width * 0.3297129,
        size.height * 0.3766660,
        size.width * 0.3247129,
        size.height * 0.3750000,
        size.width * 0.3230469,
        size.height * 0.3733320);
    path_7.cubicTo(
        size.width * 0.3163809,
        size.height * 0.3666660,
        size.width * 0.3147129,
        size.height * 0.3566660,
        size.width * 0.3213809,
        size.height * 0.3499980);
    path_7.cubicTo(
        size.width * 0.3363809,
        size.height * 0.3316641,
        size.width * 0.3547148,
        size.height * 0.3166641,
        size.width * 0.3747148,
        size.height * 0.3033320);
    path_7.cubicTo(
        size.width * 0.3830488,
        size.height * 0.2983320,
        size.width * 0.3930488,
        size.height * 0.2999980,
        size.width * 0.3980488,
        size.height * 0.3083320);
    path_7.cubicTo(
        size.width * 0.4030488,
        size.height * 0.3166660,
        size.width * 0.4013828,
        size.height * 0.3266660,
        size.width * 0.3930488,
        size.height * 0.3316660);
    path_7.cubicTo(
        size.width * 0.3763828,
        size.height * 0.3433320,
        size.width * 0.3597148,
        size.height * 0.3566660,
        size.width * 0.3463828,
        size.height * 0.3716660);
    path_7.cubicTo(
        size.width * 0.3413809,
        size.height * 0.3750000,
        size.width * 0.3380469,
        size.height * 0.3766660,
        size.width * 0.3330469,
        size.height * 0.3766660);
    path_7.close();
    path_7.moveTo(size.width * 0.5430469, size.height * 0.3050000);
    path_7.cubicTo(
        size.width * 0.5413809,
        size.height * 0.3050000,
        size.width * 0.5413809,
        size.height * 0.3050000,
        size.width * 0.5397129,
        size.height * 0.3050000);
    path_7.cubicTo(
        size.width * 0.5197129,
        size.height * 0.3000000,
        size.width * 0.4980469,
        size.height * 0.3000000,
        size.width * 0.4780469,
        size.height * 0.3016660);
    path_7.cubicTo(
        size.width * 0.4680469,
        size.height * 0.3033320,
        size.width * 0.4613809,
        size.height * 0.2966660,
        size.width * 0.4597129,
        size.height * 0.2866660);
    path_7.cubicTo(
        size.width * 0.4580449,
        size.height * 0.2766660,
        size.width * 0.4647129,
        size.height * 0.2700000,
        size.width * 0.4747129,
        size.height * 0.2683320);
    path_7.cubicTo(
        size.width * 0.4980469,
        size.height * 0.2666660,
        size.width * 0.5230469,
        size.height * 0.2666660,
        size.width * 0.5463789,
        size.height * 0.2716660);
    path_7.cubicTo(
        size.width * 0.5547129,
        size.height * 0.2733320,
        size.width * 0.5613789,
        size.height * 0.2816660,
        size.width * 0.5597129,
        size.height * 0.2916660);
    path_7.cubicTo(
        size.width * 0.5580469,
        size.height * 0.3000000,
        size.width * 0.5513809,
        size.height * 0.3050000,
        size.width * 0.5430469,
        size.height * 0.3050000);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.4980469, size.height * 0.1166660);
    path_8.cubicTo(
        size.width * 0.4880469,
        size.height * 0.1166660,
        size.width * 0.4813809,
        size.height * 0.1100000,
        size.width * 0.4813809,
        size.height * 0.1000000);
    path_8.lineTo(size.width * 0.4813809, size.height * 0.08333398);
    path_8.cubicTo(
        size.width * 0.4813809,
        size.height * 0.07333398,
        size.width * 0.4880469,
        size.height * 0.06666797,
        size.width * 0.4980469,
        size.height * 0.06666797);
    path_8.cubicTo(
        size.width * 0.5080469,
        size.height * 0.06666797,
        size.width * 0.5147129,
        size.height * 0.07333398,
        size.width * 0.5147129,
        size.height * 0.08333398);
    path_8.lineTo(size.width * 0.5147129, size.height * 0.1000000);
    path_8.cubicTo(
        size.width * 0.5147129,
        size.height * 0.1100000,
        size.width * 0.5080469,
        size.height * 0.1166660,
        size.width * 0.4980469,
        size.height * 0.1166660);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.4980469, size.height * 0.2166660);
    path_9.cubicTo(
        size.width * 0.4880469,
        size.height * 0.2166660,
        size.width * 0.4813809,
        size.height * 0.2100000,
        size.width * 0.4813809,
        size.height * 0.2000000);
    path_9.lineTo(size.width * 0.4813809, size.height * 0.1666660);
    path_9.cubicTo(
        size.width * 0.4813809,
        size.height * 0.1566660,
        size.width * 0.4880469,
        size.height * 0.1500000,
        size.width * 0.4980469,
        size.height * 0.1500000);
    path_9.cubicTo(
        size.width * 0.5080469,
        size.height * 0.1500000,
        size.width * 0.5147129,
        size.height * 0.1566660,
        size.width * 0.5147129,
        size.height * 0.1666660);
    path_9.lineTo(size.width * 0.5147129, size.height * 0.2000000);
    path_9.cubicTo(
        size.width * 0.5147129,
        size.height * 0.2100000,
        size.width * 0.5080469,
        size.height * 0.2166660,
        size.width * 0.4980469,
        size.height * 0.2166660);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.4980469, size.height * 0.8500000);
    path_10.cubicTo(
        size.width * 0.4880469,
        size.height * 0.8500000,
        size.width * 0.4813809,
        size.height * 0.8433340,
        size.width * 0.4813809,
        size.height * 0.8333340);
    path_10.lineTo(size.width * 0.4813809, size.height * 0.8000000);
    path_10.cubicTo(
        size.width * 0.4813809,
        size.height * 0.7900000,
        size.width * 0.4880469,
        size.height * 0.7833340,
        size.width * 0.4980469,
        size.height * 0.7833340);
    path_10.cubicTo(
        size.width * 0.5080469,
        size.height * 0.7833340,
        size.width * 0.5147129,
        size.height * 0.7900000,
        size.width * 0.5147129,
        size.height * 0.8000000);
    path_10.lineTo(size.width * 0.5147129, size.height * 0.8333340);
    path_10.cubicTo(
        size.width * 0.5147129,
        size.height * 0.8433340,
        size.width * 0.5080469,
        size.height * 0.8500000,
        size.width * 0.4980469,
        size.height * 0.8500000);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.4980469, size.height * 0.9333340);
    path_11.cubicTo(
        size.width * 0.4880469,
        size.height * 0.9333340,
        size.width * 0.4813809,
        size.height * 0.9266680,
        size.width * 0.4813809,
        size.height * 0.9166680);
    path_11.lineTo(size.width * 0.4813809, size.height * 0.9000000);
    path_11.cubicTo(
        size.width * 0.4813809,
        size.height * 0.8900000,
        size.width * 0.4880469,
        size.height * 0.8833340,
        size.width * 0.4980469,
        size.height * 0.8833340);
    path_11.cubicTo(
        size.width * 0.5080469,
        size.height * 0.8833340,
        size.width * 0.5147129,
        size.height * 0.8900000,
        size.width * 0.5147129,
        size.height * 0.9000000);
    path_11.lineTo(size.width * 0.5147129, size.height * 0.9166660);
    path_11.cubicTo(
        size.width * 0.5147129,
        size.height * 0.9266660,
        size.width * 0.5080469,
        size.height * 0.9333340,
        size.width * 0.4980469,
        size.height * 0.9333340);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.9147129, size.height * 0.5166660);
    path_12.lineTo(size.width * 0.8980469, size.height * 0.5166660);
    path_12.cubicTo(
        size.width * 0.8880469,
        size.height * 0.5166660,
        size.width * 0.8813809,
        size.height * 0.5100000,
        size.width * 0.8813809,
        size.height * 0.5000000);
    path_12.cubicTo(
        size.width * 0.8813809,
        size.height * 0.4900000,
        size.width * 0.8880469,
        size.height * 0.4833340,
        size.width * 0.8980469,
        size.height * 0.4833340);
    path_12.lineTo(size.width * 0.9147129, size.height * 0.4833340);
    path_12.cubicTo(
        size.width * 0.9247129,
        size.height * 0.4833340,
        size.width * 0.9313789,
        size.height * 0.4900000,
        size.width * 0.9313789,
        size.height * 0.5000000);
    path_12.cubicTo(
        size.width * 0.9313809,
        size.height * 0.5100000,
        size.width * 0.9247129,
        size.height * 0.5166660,
        size.width * 0.9147129,
        size.height * 0.5166660);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.8313809, size.height * 0.5166660);
    path_13.lineTo(size.width * 0.7980469, size.height * 0.5166660);
    path_13.cubicTo(
        size.width * 0.7880469,
        size.height * 0.5166660,
        size.width * 0.7813809,
        size.height * 0.5100000,
        size.width * 0.7813809,
        size.height * 0.5000000);
    path_13.cubicTo(
        size.width * 0.7813809,
        size.height * 0.4900000,
        size.width * 0.7880469,
        size.height * 0.4833340,
        size.width * 0.7980469,
        size.height * 0.4833340);
    path_13.lineTo(size.width * 0.8313809, size.height * 0.4833340);
    path_13.cubicTo(
        size.width * 0.8413809,
        size.height * 0.4833340,
        size.width * 0.8480469,
        size.height * 0.4900000,
        size.width * 0.8480469,
        size.height * 0.5000000);
    path_13.cubicTo(
        size.width * 0.8480469,
        size.height * 0.5100000,
        size.width * 0.8413809,
        size.height * 0.5166660,
        size.width * 0.8313809,
        size.height * 0.5166660);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.1980469, size.height * 0.5166660);
    path_14.lineTo(size.width * 0.1647129, size.height * 0.5166660);
    path_14.cubicTo(
        size.width * 0.1547129,
        size.height * 0.5166660,
        size.width * 0.1480469,
        size.height * 0.5100000,
        size.width * 0.1480469,
        size.height * 0.5000000);
    path_14.cubicTo(
        size.width * 0.1480469,
        size.height * 0.4900000,
        size.width * 0.1547129,
        size.height * 0.4833340,
        size.width * 0.1647129,
        size.height * 0.4833340);
    path_14.lineTo(size.width * 0.1980469, size.height * 0.4833340);
    path_14.cubicTo(
        size.width * 0.2080469,
        size.height * 0.4833340,
        size.width * 0.2147129,
        size.height * 0.4900000,
        size.width * 0.2147129,
        size.height * 0.5000000);
    path_14.cubicTo(
        size.width * 0.2147129,
        size.height * 0.5100000,
        size.width * 0.2080469,
        size.height * 0.5166660,
        size.width * 0.1980469,
        size.height * 0.5166660);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.09804688, size.height * 0.5166660);
    path_15.lineTo(size.width * 0.08138086, size.height * 0.5166660);
    path_15.cubicTo(
        size.width * 0.07138086,
        size.height * 0.5166660,
        size.width * 0.06471484,
        size.height * 0.5100000,
        size.width * 0.06471484,
        size.height * 0.5000000);
    path_15.cubicTo(
        size.width * 0.06471484,
        size.height * 0.4900000,
        size.width * 0.07138086,
        size.height * 0.4833340,
        size.width * 0.08138086,
        size.height * 0.4833340);
    path_15.lineTo(size.width * 0.09804688, size.height * 0.4833340);
    path_15.cubicTo(
        size.width * 0.1080469,
        size.height * 0.4833340,
        size.width * 0.1147129,
        size.height * 0.4900000,
        size.width * 0.1147129,
        size.height * 0.5000000);
    path_15.cubicTo(
        size.width * 0.1147129,
        size.height * 0.5100000,
        size.width * 0.1080469,
        size.height * 0.5166660,
        size.width * 0.09804688,
        size.height * 0.5166660);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
