import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Shop extends CustomPainter {
  final color_s;

  RPSCustomPainter_Shop(this.color_s);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1275391, size.height * 0.3130859);
    path_0.lineTo(size.width * 0.8743164, size.height * 0.3130859);
    path_0.lineTo(size.width * 0.8743164, size.height * 0.8847656);
    path_0.lineTo(size.width * 0.1275391, size.height * 0.8847656);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.8744141, size.height * 0.8976563);
    path_1.lineTo(size.width * 0.1275391, size.height * 0.8976563);
    path_1.cubicTo(
        size.width * 0.1204102,
        size.height * 0.8976563,
        size.width * 0.1146484,
        size.height * 0.8918945,
        size.width * 0.1146484,
        size.height * 0.8847656);
    path_1.lineTo(size.width * 0.1146484, size.height * 0.3130859);
    path_1.cubicTo(
        size.width * 0.1146484,
        size.height * 0.3059570,
        size.width * 0.1204102,
        size.height * 0.3001953,
        size.width * 0.1275391,
        size.height * 0.3001953);
    path_1.lineTo(size.width * 0.8743164, size.height * 0.3001953);
    path_1.cubicTo(
        size.width * 0.8814453,
        size.height * 0.3001953,
        size.width * 0.8872070,
        size.height * 0.3059570,
        size.width * 0.8872070,
        size.height * 0.3130859);
    path_1.lineTo(size.width * 0.8872070, size.height * 0.8847656);
    path_1.cubicTo(
        size.width * 0.8873047,
        size.height * 0.8918945,
        size.width * 0.8815430,
        size.height * 0.8976563,
        size.width * 0.8744141,
        size.height * 0.8976563);
    path_1.close();
    path_1.moveTo(size.width * 0.1405273, size.height * 0.8718750);
    path_1.lineTo(size.width * 0.8615234, size.height * 0.8718750);
    path_1.lineTo(size.width * 0.8615234, size.height * 0.3260742);
    path_1.lineTo(size.width * 0.1405273, size.height * 0.3260742);
    path_1.lineTo(size.width * 0.1405273, size.height * 0.8718750);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff0F0F0F).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.9148437, size.height * 0.9463867);
    path_2.lineTo(size.width * 0.08378906, size.height * 0.9463867);
    path_2.cubicTo(
        size.width * 0.06708984,
        size.height * 0.9463867,
        size.width * 0.05351562,
        size.height * 0.9327148,
        size.width * 0.05351562,
        size.height * 0.9161133);
    path_2.lineTo(size.width * 0.05351562, size.height * 0.9150391);
    path_2.cubicTo(
        size.width * 0.05351562,
        size.height * 0.8983398,
        size.width * 0.06718750,
        size.height * 0.8847656,
        size.width * 0.08378906,
        size.height * 0.8847656);
    path_2.lineTo(size.width * 0.9148437, size.height * 0.8847656);
    path_2.cubicTo(
        size.width * 0.9315430,
        size.height * 0.8847656,
        size.width * 0.9451172,
        size.height * 0.8984375,
        size.width * 0.9451172,
        size.height * 0.9150391);
    path_2.lineTo(size.width * 0.9451172, size.height * 0.9161133);
    path_2.cubicTo(
        size.width * 0.9451172,
        size.height * 0.9327148,
        size.width * 0.9315430,
        size.height * 0.9463867,
        size.width * 0.9148437,
        size.height * 0.9463867);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9143555, size.height * 0.9592773);
    path_3.lineTo(size.width * 0.08427734, size.height * 0.9592773);
    path_3.cubicTo(
        size.width * 0.06015625,
        size.height * 0.9592773,
        size.width * 0.04052734,
        size.height * 0.9396484,
        size.width * 0.04052734,
        size.height * 0.9155273);
    path_3.cubicTo(
        size.width * 0.04052734,
        size.height * 0.8914062,
        size.width * 0.06015625,
        size.height * 0.8717773,
        size.width * 0.08427734,
        size.height * 0.8717773);
    path_3.lineTo(size.width * 0.9142578, size.height * 0.8717773);
    path_3.cubicTo(
        size.width * 0.9383789,
        size.height * 0.8717773,
        size.width * 0.9580078,
        size.height * 0.8914063,
        size.width * 0.9580078,
        size.height * 0.9155273);
    path_3.cubicTo(
        size.width * 0.9580078,
        size.height * 0.9396484,
        size.width * 0.9384766,
        size.height * 0.9592773,
        size.width * 0.9143555,
        size.height * 0.9592773);
    path_3.close();
    path_3.moveTo(size.width * 0.08427734, size.height * 0.8976562);
    path_3.cubicTo(
        size.width * 0.07441406,
        size.height * 0.8976562,
        size.width * 0.06640625,
        size.height * 0.9056641,
        size.width * 0.06640625,
        size.height * 0.9155273);
    path_3.cubicTo(
        size.width * 0.06640625,
        size.height * 0.9253906,
        size.width * 0.07441406,
        size.height * 0.9333984,
        size.width * 0.08427734,
        size.height * 0.9333984);
    path_3.lineTo(size.width * 0.9142578, size.height * 0.9333984);
    path_3.cubicTo(
        size.width * 0.9241211,
        size.height * 0.9333984,
        size.width * 0.9321289,
        size.height * 0.9253906,
        size.width * 0.9321289,
        size.height * 0.9155273);
    path_3.cubicTo(
        size.width * 0.9321289,
        size.height * 0.9056641,
        size.width * 0.9241211,
        size.height * 0.8976562,
        size.width * 0.9142578,
        size.height * 0.8976562);
    path_3.lineTo(size.width * 0.08427734, size.height * 0.8976562);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff141414).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.9279297, size.height * 0.2397461);
    path_4.lineTo(size.width * 0.07402344, size.height * 0.2397461);
    path_4.lineTo(size.width * 0.1444336, size.height * 0.09013672);
    path_4.lineTo(size.width * 0.8575195, size.height * 0.09013672);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.9279297, size.height * 0.2526367);
    path_5.lineTo(size.width * 0.07402344, size.height * 0.2526367);
    path_5.cubicTo(
        size.width * 0.06962891,
        size.height * 0.2526367,
        size.width * 0.06552734,
        size.height * 0.2503906,
        size.width * 0.06308594,
        size.height * 0.2466797);
    path_5.cubicTo(
        size.width * 0.06074219,
        size.height * 0.2429687,
        size.width * 0.06044922,
        size.height * 0.2382813,
        size.width * 0.06230469,
        size.height * 0.2342773);
    path_5.lineTo(size.width * 0.1328125, size.height * 0.08457031);
    path_5.cubicTo(
        size.width * 0.1349609,
        size.height * 0.08007813,
        size.width * 0.1394531,
        size.height * 0.07714844,
        size.width * 0.1445313,
        size.height * 0.07714844);
    path_5.lineTo(size.width * 0.8576172, size.height * 0.07714844);
    path_5.cubicTo(
        size.width * 0.8625977,
        size.height * 0.07714844,
        size.width * 0.8671875,
        size.height * 0.08007813,
        size.width * 0.8693359,
        size.height * 0.08457031);
    path_5.lineTo(size.width * 0.9397461, size.height * 0.2341797);
    path_5.cubicTo(
        size.width * 0.9416016,
        size.height * 0.2381836,
        size.width * 0.9413086,
        size.height * 0.2428711,
        size.width * 0.9389648,
        size.height * 0.2465820);
    path_5.cubicTo(
        size.width * 0.9364258,
        size.height * 0.2503906,
        size.width * 0.9323242,
        size.height * 0.2526367,
        size.width * 0.9279297,
        size.height * 0.2526367);
    path_5.close();
    path_5.moveTo(size.width * 0.09433594, size.height * 0.2268555);
    path_5.lineTo(size.width * 0.9075195, size.height * 0.2268555);
    path_5.lineTo(size.width * 0.8492188, size.height * 0.1030273);
    path_5.lineTo(size.width * 0.1526367, size.height * 0.1030273);
    path_5.lineTo(size.width * 0.09433594, size.height * 0.2268555);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.2578125, size.height * 0.1077148);
    path_6.lineTo(size.width * 0.2005859, size.height * 0.2397461);

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.2005859, size.height * 0.2526367);
    path_7.cubicTo(
        size.width * 0.1988281,
        size.height * 0.2526367,
        size.width * 0.1971680,
        size.height * 0.2522461,
        size.width * 0.1954102,
        size.height * 0.2515625);
    path_7.cubicTo(
        size.width * 0.1888672,
        size.height * 0.2487305,
        size.width * 0.1858398,
        size.height * 0.2411133,
        size.width * 0.1886719,
        size.height * 0.2345703);
    path_7.lineTo(size.width * 0.2458984, size.height * 0.1025391);
    path_7.cubicTo(
        size.width * 0.2487305,
        size.height * 0.09599609,
        size.width * 0.2563477,
        size.height * 0.09296875,
        size.width * 0.2628906,
        size.height * 0.09580078);
    path_7.cubicTo(
        size.width * 0.2694336,
        size.height * 0.09863281,
        size.width * 0.2724609,
        size.height * 0.1062500,
        size.width * 0.2696289,
        size.height * 0.1127930);
    path_7.lineTo(size.width * 0.2124023, size.height * 0.2448242);
    path_7.cubicTo(
        size.width * 0.2103516,
        size.height * 0.2498047,
        size.width * 0.2055664,
        size.height * 0.2526367,
        size.width * 0.2005859,
        size.height * 0.2526367);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.7441406, size.height * 0.1077148);
    path_8.lineTo(size.width * 0.8013672, size.height * 0.2397461);

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.8013672, size.height * 0.2526367);
    path_9.cubicTo(
        size.width * 0.7963867,
        size.height * 0.2526367,
        size.width * 0.7916016,
        size.height * 0.2497070,
        size.width * 0.7895508,
        size.height * 0.2448242);
    path_9.lineTo(size.width * 0.7323242, size.height * 0.1127930);
    path_9.cubicTo(
        size.width * 0.7294922,
        size.height * 0.1062500,
        size.width * 0.7325195,
        size.height * 0.09863281,
        size.width * 0.7390625,
        size.height * 0.09580078);
    path_9.cubicTo(
        size.width * 0.7456055,
        size.height * 0.09296875,
        size.width * 0.7532227,
        size.height * 0.09599609,
        size.width * 0.7560547,
        size.height * 0.1025391);
    path_9.lineTo(size.width * 0.8132812, size.height * 0.2345703);
    path_9.cubicTo(
        size.width * 0.8161133,
        size.height * 0.2411133,
        size.width * 0.8130859,
        size.height * 0.2487305,
        size.width * 0.8065430,
        size.height * 0.2515625);
    path_9.cubicTo(
        size.width * 0.8048828,
        size.height * 0.2523437,
        size.width * 0.8031250,
        size.height * 0.2526367,
        size.width * 0.8013672,
        size.height * 0.2526367);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.3783203, size.height * 0.1077148);
    path_10.lineTo(size.width * 0.3518555, size.height * 0.2397461);

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.3518555, size.height * 0.2526367);
    path_11.cubicTo(
        size.width * 0.3509766,
        size.height * 0.2526367,
        size.width * 0.3501953,
        size.height * 0.2525391,
        size.width * 0.3493164,
        size.height * 0.2523437);
    path_11.cubicTo(
        size.width * 0.3422852,
        size.height * 0.2509766,
        size.width * 0.3377930,
        size.height * 0.2441406,
        size.width * 0.3391602,
        size.height * 0.2371094);
    path_11.lineTo(size.width * 0.3655273, size.height * 0.1050781);
    path_11.cubicTo(
        size.width * 0.3668945,
        size.height * 0.09804687,
        size.width * 0.3737305,
        size.height * 0.09355469,
        size.width * 0.3807617,
        size.height * 0.09492187);
    path_11.cubicTo(
        size.width * 0.3877930,
        size.height * 0.09628906,
        size.width * 0.3922852,
        size.height * 0.1031250,
        size.width * 0.3909180,
        size.height * 0.1101562);
    path_11.lineTo(size.width * 0.3645508, size.height * 0.2421875);
    path_11.cubicTo(
        size.width * 0.3632813,
        size.height * 0.2484375,
        size.width * 0.3579102,
        size.height * 0.2526367,
        size.width * 0.3518555,
        size.height * 0.2526367);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.6236328, size.height * 0.1077148);
    path_12.lineTo(size.width * 0.6500977, size.height * 0.2397461);

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.6500977, size.height * 0.2526367);
    path_13.cubicTo(
        size.width * 0.6440430,
        size.height * 0.2526367,
        size.width * 0.6386719,
        size.height * 0.2484375,
        size.width * 0.6374023,
        size.height * 0.2422852);
    path_13.lineTo(size.width * 0.6110352, size.height * 0.1102539);
    path_13.cubicTo(
        size.width * 0.6096680,
        size.height * 0.1032227,
        size.width * 0.6141602,
        size.height * 0.09648438,
        size.width * 0.6211914,
        size.height * 0.09501953);
    path_13.cubicTo(
        size.width * 0.6282227,
        size.height * 0.09365234,
        size.width * 0.6349609,
        size.height * 0.09814453,
        size.width * 0.6364258,
        size.height * 0.1051758);
    path_13.lineTo(size.width * 0.6627930, size.height * 0.2372070);
    path_13.cubicTo(
        size.width * 0.6641602,
        size.height * 0.2442383,
        size.width * 0.6596680,
        size.height * 0.2509766,
        size.width * 0.6526367,
        size.height * 0.2524414);
    path_13.cubicTo(
        size.width * 0.6517578,
        size.height * 0.2525391,
        size.width * 0.6508789,
        size.height * 0.2526367,
        size.width * 0.6500977,
        size.height * 0.2526367);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.5009766, size.height * 0.1077148);
    path_14.lineTo(size.width * 0.5009766, size.height * 0.2397461);

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.5009766, size.height * 0.2526367);
    path_15.cubicTo(
        size.width * 0.4938477,
        size.height * 0.2526367,
        size.width * 0.4880859,
        size.height * 0.2468750,
        size.width * 0.4880859,
        size.height * 0.2397461);
    path_15.lineTo(size.width * 0.4880859, size.height * 0.1077148);
    path_15.cubicTo(
        size.width * 0.4880859,
        size.height * 0.1005859,
        size.width * 0.4938477,
        size.height * 0.09482422,
        size.width * 0.5009766,
        size.height * 0.09482422);
    path_15.cubicTo(
        size.width * 0.5081055,
        size.height * 0.09482422,
        size.width * 0.5138672,
        size.height * 0.1005859,
        size.width * 0.5138672,
        size.height * 0.1077148);
    path_15.lineTo(size.width * 0.5138672, size.height * 0.2397461);
    path_15.cubicTo(
        size.width * 0.5138672,
        size.height * 0.2468750,
        size.width * 0.5081055,
        size.height * 0.2526367,
        size.width * 0.5009766,
        size.height * 0.2526367);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.8970703, size.height * 0.2397461);
    path_16.cubicTo(
        size.width * 0.9408203,
        size.height * 0.2397461,
        size.width * 0.9762695,
        size.height * 0.2751953,
        size.width * 0.9762695,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.9762695,
        size.height * 0.3626953,
        size.width * 0.9408203,
        size.height * 0.3981445,
        size.width * 0.8970703,
        size.height * 0.3981445);
    path_16.cubicTo(
        size.width * 0.8533203,
        size.height * 0.3981445,
        size.width * 0.8178711,
        size.height * 0.3626953,
        size.width * 0.8178711,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.8178711,
        size.height * 0.3626953,
        size.width * 0.7824219,
        size.height * 0.3981445,
        size.width * 0.7386719,
        size.height * 0.3981445);
    path_16.cubicTo(
        size.width * 0.6949219,
        size.height * 0.3981445,
        size.width * 0.6594727,
        size.height * 0.3626953,
        size.width * 0.6594727,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.6594727,
        size.height * 0.3626953,
        size.width * 0.6240234,
        size.height * 0.3981445,
        size.width * 0.5802734,
        size.height * 0.3981445);
    path_16.cubicTo(
        size.width * 0.5365234,
        size.height * 0.3981445,
        size.width * 0.5009766,
        size.height * 0.3626953,
        size.width * 0.5009766,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.5009766,
        size.height * 0.3626953,
        size.width * 0.4655273,
        size.height * 0.3981445,
        size.width * 0.4217773,
        size.height * 0.3981445);
    path_16.cubicTo(
        size.width * 0.3780273,
        size.height * 0.3981445,
        size.width * 0.3425781,
        size.height * 0.3626953,
        size.width * 0.3425781,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.3425781,
        size.height * 0.3626953,
        size.width * 0.3071289,
        size.height * 0.3981445,
        size.width * 0.2633789,
        size.height * 0.3981445);
    path_16.cubicTo(
        size.width * 0.2196289,
        size.height * 0.3981445,
        size.width * 0.1841797,
        size.height * 0.3626953,
        size.width * 0.1841797,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.1841797,
        size.height * 0.3626953,
        size.width * 0.1487305,
        size.height * 0.3981445,
        size.width * 0.1049805,
        size.height * 0.3981445);
    path_16.cubicTo(
        size.width * 0.06123047,
        size.height * 0.3981445,
        size.width * 0.02578125,
        size.height * 0.3626953,
        size.width * 0.02578125,
        size.height * 0.3189453);
    path_16.cubicTo(
        size.width * 0.02578125,
        size.height * 0.2751953,
        size.width * 0.06123047,
        size.height * 0.2397461,
        size.width * 0.1049805,
        size.height * 0.2397461);
    path_16.lineTo(size.width * 0.8950195, size.height * 0.2397461);

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.8970703, size.height * 0.4111328);
    path_17.cubicTo(
        size.width * 0.8633789,
        size.height * 0.4111328,
        size.width * 0.8338867,
        size.height * 0.3929687,
        size.width * 0.8178711,
        size.height * 0.3660156);
    path_17.cubicTo(
        size.width * 0.8017578,
        size.height * 0.3929688,
        size.width * 0.7722656,
        size.height * 0.4111328,
        size.width * 0.7386719,
        size.height * 0.4111328);
    path_17.cubicTo(
        size.width * 0.7049805,
        size.height * 0.4111328,
        size.width * 0.6754883,
        size.height * 0.3929687,
        size.width * 0.6594727,
        size.height * 0.3660156);
    path_17.cubicTo(
        size.width * 0.6433594,
        size.height * 0.3930664,
        size.width * 0.6138672,
        size.height * 0.4111328,
        size.width * 0.5802734,
        size.height * 0.4111328);
    path_17.cubicTo(
        size.width * 0.5466797,
        size.height * 0.4111328,
        size.width * 0.5170898,
        size.height * 0.3929687,
        size.width * 0.5010742,
        size.height * 0.3660156);
    path_17.cubicTo(
        size.width * 0.4849609,
        size.height * 0.3930664,
        size.width * 0.4554687,
        size.height * 0.4111328,
        size.width * 0.4218750,
        size.height * 0.4111328);
    path_17.cubicTo(
        size.width * 0.3881836,
        size.height * 0.4111328,
        size.width * 0.3586914,
        size.height * 0.3929687,
        size.width * 0.3426758,
        size.height * 0.3660156);
    path_17.cubicTo(
        size.width * 0.3265625,
        size.height * 0.3930664,
        size.width * 0.2970703,
        size.height * 0.4111328,
        size.width * 0.2634766,
        size.height * 0.4111328);
    path_17.cubicTo(
        size.width * 0.2298828,
        size.height * 0.4111328,
        size.width * 0.2002930,
        size.height * 0.3929687,
        size.width * 0.1842773,
        size.height * 0.3660156);
    path_17.cubicTo(
        size.width * 0.1679688,
        size.height * 0.3929687,
        size.width * 0.1384766,
        size.height * 0.4111328,
        size.width * 0.1047852,
        size.height * 0.4111328);
    path_17.cubicTo(
        size.width * 0.05400391,
        size.height * 0.4111328,
        size.width * 0.01259766,
        size.height * 0.3698242,
        size.width * 0.01259766,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.01259766,
        size.height * 0.2681641,
        size.width * 0.05390625,
        size.height * 0.2267578,
        size.width * 0.1047852,
        size.height * 0.2267578);
    path_17.lineTo(size.width * 0.8969727, size.height * 0.2267578);
    path_17.cubicTo(
        size.width * 0.9477539,
        size.height * 0.2267578,
        size.width * 0.9891602,
        size.height * 0.2680664,
        size.width * 0.9891602,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.9892578,
        size.height * 0.3698242,
        size.width * 0.9479492,
        size.height * 0.4111328,
        size.width * 0.8970703,
        size.height * 0.4111328);
    path_17.close();
    path_17.moveTo(size.width * 0.8307617, size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.8307617,
        size.height * 0.3554688,
        size.width * 0.8605469,
        size.height * 0.3852539,
        size.width * 0.8970703,
        size.height * 0.3852539);
    path_17.cubicTo(
        size.width * 0.9335938,
        size.height * 0.3852539,
        size.width * 0.9633789,
        size.height * 0.3554688,
        size.width * 0.9633789,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.9633789,
        size.height * 0.2824219,
        size.width * 0.9335938,
        size.height * 0.2526367,
        size.width * 0.8970703,
        size.height * 0.2526367);
    path_17.lineTo(size.width * 0.1048828, size.height * 0.2526367);
    path_17.cubicTo(
        size.width * 0.06835938,
        size.height * 0.2526367,
        size.width * 0.03857422,
        size.height * 0.2824219,
        size.width * 0.03857422,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.03857422,
        size.height * 0.3554688,
        size.width * 0.06835938,
        size.height * 0.3852539,
        size.width * 0.1048828,
        size.height * 0.3852539);
    path_17.cubicTo(
        size.width * 0.1414063,
        size.height * 0.3852539,
        size.width * 0.1711914,
        size.height * 0.3554688,
        size.width * 0.1711914,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.1711914,
        size.height * 0.3118164,
        size.width * 0.1769531,
        size.height * 0.3060547,
        size.width * 0.1840820,
        size.height * 0.3060547);
    path_17.cubicTo(
        size.width * 0.1912109,
        size.height * 0.3060547,
        size.width * 0.1969727,
        size.height * 0.3118164,
        size.width * 0.1969727,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.1969727,
        size.height * 0.3554688,
        size.width * 0.2267578,
        size.height * 0.3852539,
        size.width * 0.2632813,
        size.height * 0.3852539);
    path_17.cubicTo(
        size.width * 0.2998047,
        size.height * 0.3852539,
        size.width * 0.3295898,
        size.height * 0.3554688,
        size.width * 0.3295898,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.3295898,
        size.height * 0.3118164,
        size.width * 0.3353516,
        size.height * 0.3060547,
        size.width * 0.3424805,
        size.height * 0.3060547);
    path_17.cubicTo(
        size.width * 0.3496094,
        size.height * 0.3060547,
        size.width * 0.3553711,
        size.height * 0.3118164,
        size.width * 0.3553711,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.3553711,
        size.height * 0.3554688,
        size.width * 0.3851562,
        size.height * 0.3852539,
        size.width * 0.4216797,
        size.height * 0.3852539);
    path_17.cubicTo(
        size.width * 0.4582031,
        size.height * 0.3852539,
        size.width * 0.4879883,
        size.height * 0.3554688,
        size.width * 0.4879883,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.4879883,
        size.height * 0.3118164,
        size.width * 0.4937500,
        size.height * 0.3060547,
        size.width * 0.5008789,
        size.height * 0.3060547);
    path_17.cubicTo(
        size.width * 0.5080078,
        size.height * 0.3060547,
        size.width * 0.5137695,
        size.height * 0.3118164,
        size.width * 0.5137695,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.5137695,
        size.height * 0.3554688,
        size.width * 0.5435547,
        size.height * 0.3852539,
        size.width * 0.5800781,
        size.height * 0.3852539);
    path_17.cubicTo(
        size.width * 0.6166016,
        size.height * 0.3852539,
        size.width * 0.6463867,
        size.height * 0.3554688,
        size.width * 0.6463867,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.6463867,
        size.height * 0.3118164,
        size.width * 0.6521484,
        size.height * 0.3060547,
        size.width * 0.6592773,
        size.height * 0.3060547);
    path_17.cubicTo(
        size.width * 0.6664063,
        size.height * 0.3060547,
        size.width * 0.6721680,
        size.height * 0.3118164,
        size.width * 0.6721680,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.6721680,
        size.height * 0.3554688,
        size.width * 0.7019531,
        size.height * 0.3852539,
        size.width * 0.7384766,
        size.height * 0.3852539);
    path_17.cubicTo(
        size.width * 0.7750000,
        size.height * 0.3852539,
        size.width * 0.8047852,
        size.height * 0.3554688,
        size.width * 0.8047852,
        size.height * 0.3189453);
    path_17.cubicTo(
        size.width * 0.8047852,
        size.height * 0.3118164,
        size.width * 0.8105469,
        size.height * 0.3060547,
        size.width * 0.8176758,
        size.height * 0.3060547);
    path_17.cubicTo(
        size.width * 0.8248047,
        size.height * 0.3060547,
        size.width * 0.8307617,
        size.height * 0.3118164,
        size.width * 0.8307617,
        size.height * 0.3189453);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.color = Color(0xff191919).withOpacity(1.0);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.3893555, size.height * 0.8847656);
    path_18.lineTo(size.width * 0.2229492, size.height * 0.8847656);
    path_18.cubicTo(
        size.width * 0.2120117,
        size.height * 0.8847656,
        size.width * 0.2031250,
        size.height * 0.8758789,
        size.width * 0.2031250,
        size.height * 0.8649414);
    path_18.lineTo(size.width * 0.2031250, size.height * 0.5582031);
    path_18.cubicTo(
        size.width * 0.2031250,
        size.height * 0.5472656,
        size.width * 0.2120117,
        size.height * 0.5383789,
        size.width * 0.2229492,
        size.height * 0.5383789);
    path_18.lineTo(size.width * 0.3893555, size.height * 0.5383789);
    path_18.cubicTo(
        size.width * 0.4002930,
        size.height * 0.5383789,
        size.width * 0.4091797,
        size.height * 0.5472656,
        size.width * 0.4091797,
        size.height * 0.5582031);
    path_18.lineTo(size.width * 0.4091797, size.height * 0.8649414);
    path_18.cubicTo(
        size.width * 0.4090820,
        size.height * 0.8758789,
        size.width * 0.4001953,
        size.height * 0.8847656,
        size.width * 0.3893555,
        size.height * 0.8847656);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_18, paint_18_fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 0.3889648, size.height * 0.8976563);
    path_19.lineTo(size.width * 0.2232422, size.height * 0.8976563);
    path_19.cubicTo(
        size.width * 0.2049805,
        size.height * 0.8976563,
        size.width * 0.1902344,
        size.height * 0.8828125,
        size.width * 0.1902344,
        size.height * 0.8646484);
    path_19.lineTo(size.width * 0.1902344, size.height * 0.5585938);
    path_19.cubicTo(
        size.width * 0.1902344,
        size.height * 0.5403320,
        size.width * 0.2050781,
        size.height * 0.5255859,
        size.width * 0.2232422,
        size.height * 0.5255859);
    path_19.lineTo(size.width * 0.3889648, size.height * 0.5255859);
    path_19.cubicTo(
        size.width * 0.4072266,
        size.height * 0.5255859,
        size.width * 0.4219727,
        size.height * 0.5404297,
        size.width * 0.4219727,
        size.height * 0.5585938);
    path_19.lineTo(size.width * 0.4219727, size.height * 0.8646484);
    path_19.cubicTo(
        size.width * 0.4219727,
        size.height * 0.8828125,
        size.width * 0.4072266,
        size.height * 0.8976562,
        size.width * 0.3889648,
        size.height * 0.8976562);
    path_19.close();
    path_19.moveTo(size.width * 0.2232422, size.height * 0.5513672);
    path_19.cubicTo(
        size.width * 0.2192383,
        size.height * 0.5513672,
        size.width * 0.2160156,
        size.height * 0.5545898,
        size.width * 0.2160156,
        size.height * 0.5585938);
    path_19.lineTo(size.width * 0.2160156, size.height * 0.8646484);
    path_19.cubicTo(
        size.width * 0.2160156,
        size.height * 0.8686523,
        size.width * 0.2192383,
        size.height * 0.8718750,
        size.width * 0.2232422,
        size.height * 0.8718750);
    path_19.lineTo(size.width * 0.3889648, size.height * 0.8718750);
    path_19.cubicTo(
        size.width * 0.3929687,
        size.height * 0.8718750,
        size.width * 0.3961914,
        size.height * 0.8686523,
        size.width * 0.3961914,
        size.height * 0.8646484);
    path_19.lineTo(size.width * 0.3961914, size.height * 0.5585938);
    path_19.cubicTo(
        size.width * 0.3961914,
        size.height * 0.5545898,
        size.width * 0.3929687,
        size.height * 0.5513672,
        size.width * 0.3889648,
        size.height * 0.5513672);
    path_19.lineTo(size.width * 0.2232422, size.height * 0.5513672);
    path_19.close();

    Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
    paint_19_fill.color = Color(0xff111111).withOpacity(1.0);
    canvas.drawPath(path_19, paint_19_fill);

    Path path_20 = Path();
    path_20.moveTo(size.width * 0.2392578, size.height * 0.7162109);
    path_20.moveTo(size.width * 0.2250000, size.height * 0.7162109);
    path_20.arcToPoint(Offset(size.width * 0.2535156, size.height * 0.7162109),
        radius: Radius.elliptical(
            size.width * 0.01425781, size.height * 0.01425781),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_20.arcToPoint(Offset(size.width * 0.2250000, size.height * 0.7162109),
        radius: Radius.elliptical(
            size.width * 0.01425781, size.height * 0.01425781),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_20.close();

    Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
    paint_20_fill.color = Color(0xff0C0C0C).withOpacity(1.0);
    canvas.drawPath(path_20, paint_20_fill);

    Path path_21 = Path();
    path_21.moveTo(size.width * 0.7702148, size.height * 0.6842773);
    path_21.lineTo(size.width * 0.5655273, size.height * 0.6842773);
    path_21.cubicTo(
        size.width * 0.5597656,
        size.height * 0.6842773,
        size.width * 0.5550781,
        size.height * 0.6795898,
        size.width * 0.5550781,
        size.height * 0.6738281);
    path_21.lineTo(size.width * 0.5550781, size.height * 0.5768555);
    path_21.cubicTo(
        size.width * 0.5550781,
        size.height * 0.5710938,
        size.width * 0.5597656,
        size.height * 0.5664063,
        size.width * 0.5655273,
        size.height * 0.5664063);
    path_21.lineTo(size.width * 0.7703125, size.height * 0.5664063);
    path_21.cubicTo(
        size.width * 0.7760742,
        size.height * 0.5664063,
        size.width * 0.7807617,
        size.height * 0.5710937,
        size.width * 0.7807617,
        size.height * 0.5768555);
    path_21.lineTo(size.width * 0.7807617, size.height * 0.6738281);
    path_21.cubicTo(
        size.width * 0.7806641,
        size.height * 0.6796875,
        size.width * 0.7759766,
        size.height * 0.6842773,
        size.width * 0.7702148,
        size.height * 0.6842773);
    path_21.close();

    Paint paint_21_fill = Paint()..style = PaintingStyle.fill;
    paint_21_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_21, paint_21_fill);

    Path path_22 = Path();
    path_22.moveTo(size.width * 0.7701172, size.height * 0.6972656);
    path_22.lineTo(size.width * 0.5656250, size.height * 0.6972656);
    path_22.cubicTo(
        size.width * 0.5526367,
        size.height * 0.6972656,
        size.width * 0.5420898,
        size.height * 0.6867188,
        size.width * 0.5420898,
        size.height * 0.6737305);
    path_22.lineTo(size.width * 0.5420898, size.height * 0.5770508);
    path_22.cubicTo(
        size.width * 0.5420898,
        size.height * 0.5640625,
        size.width * 0.5526367,
        size.height * 0.5535156,
        size.width * 0.5656250,
        size.height * 0.5535156);
    path_22.lineTo(size.width * 0.7700195, size.height * 0.5535156);
    path_22.cubicTo(
        size.width * 0.7830078,
        size.height * 0.5535156,
        size.width * 0.7935547,
        size.height * 0.5640625,
        size.width * 0.7935547,
        size.height * 0.5770508);
    path_22.lineTo(size.width * 0.7935547, size.height * 0.6737305);
    path_22.cubicTo(
        size.width * 0.7935547,
        size.height * 0.6867187,
        size.width * 0.7830078,
        size.height * 0.6972656,
        size.width * 0.7701172,
        size.height * 0.6972656);
    path_22.close();
    path_22.moveTo(size.width * 0.5679688, size.height * 0.6713867);
    path_22.lineTo(size.width * 0.7676758, size.height * 0.6713867);
    path_22.lineTo(size.width * 0.7676758, size.height * 0.5793945);
    path_22.lineTo(size.width * 0.5679688, size.height * 0.5793945);
    path_22.lineTo(size.width * 0.5679688, size.height * 0.6713867);
    path_22.close();

    Paint paint_22_fill = Paint()..style = PaintingStyle.fill;
    paint_22_fill.color = Color(0xff0F0F0F).withOpacity(1.0);
    canvas.drawPath(path_22, paint_22_fill);

    Path path_23 = Path();
    path_23.moveTo(size.width * 0.7750000, size.height * 0.7327148);
    path_23.lineTo(size.width * 0.5607422, size.height * 0.7327148);
    path_23.cubicTo(
        size.width * 0.5475586,
        size.height * 0.7327148,
        size.width * 0.5369141,
        size.height * 0.7220703,
        size.width * 0.5369141,
        size.height * 0.7088867);
    path_23.lineTo(size.width * 0.5369141, size.height * 0.7081055);
    path_23.cubicTo(
        size.width * 0.5369141,
        size.height * 0.6949219,
        size.width * 0.5475586,
        size.height * 0.6842773,
        size.width * 0.5607422,
        size.height * 0.6842773);
    path_23.lineTo(size.width * 0.7750000, size.height * 0.6842773);
    path_23.cubicTo(
        size.width * 0.7881836,
        size.height * 0.6842773,
        size.width * 0.7988281,
        size.height * 0.6949219,
        size.width * 0.7988281,
        size.height * 0.7081055);
    path_23.lineTo(size.width * 0.7988281, size.height * 0.7088867);
    path_23.cubicTo(
        size.width * 0.7988281,
        size.height * 0.7220703,
        size.width * 0.7881836,
        size.height * 0.7327148,
        size.width * 0.7750000,
        size.height * 0.7327148);
    path_23.close();

    Paint paint_23_fill = Paint()..style = PaintingStyle.fill;
    paint_23_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_23, paint_23_fill);

    Path path_24 = Path();
    path_24.moveTo(size.width * 0.7746094, size.height * 0.7456055);
    path_24.lineTo(size.width * 0.5611328, size.height * 0.7456055);
    path_24.cubicTo(
        size.width * 0.5406250,
        size.height * 0.7456055,
        size.width * 0.5240234,
        size.height * 0.7289062,
        size.width * 0.5240234,
        size.height * 0.7084961);
    path_24.cubicTo(
        size.width * 0.5240234,
        size.height * 0.6879883,
        size.width * 0.5407227,
        size.height * 0.6713867,
        size.width * 0.5611328,
        size.height * 0.6713867);
    path_24.lineTo(size.width * 0.7746094, size.height * 0.6713867);
    path_24.cubicTo(
        size.width * 0.7951172,
        size.height * 0.6713867,
        size.width * 0.8117188,
        size.height * 0.6880859,
        size.width * 0.8117188,
        size.height * 0.7084961);
    path_24.cubicTo(
        size.width * 0.8117188,
        size.height * 0.7290039,
        size.width * 0.7951172,
        size.height * 0.7456055,
        size.width * 0.7746094,
        size.height * 0.7456055);
    path_24.close();
    path_24.moveTo(size.width * 0.5611328, size.height * 0.6972656);
    path_24.cubicTo(
        size.width * 0.5548828,
        size.height * 0.6972656,
        size.width * 0.5498047,
        size.height * 0.7023438,
        size.width * 0.5498047,
        size.height * 0.7085938);
    path_24.cubicTo(
        size.width * 0.5498047,
        size.height * 0.7148438,
        size.width * 0.5548828,
        size.height * 0.7199219,
        size.width * 0.5611328,
        size.height * 0.7199219);
    path_24.lineTo(size.width * 0.7746094, size.height * 0.7199219);
    path_24.cubicTo(
        size.width * 0.7808594,
        size.height * 0.7199219,
        size.width * 0.7859375,
        size.height * 0.7148438,
        size.width * 0.7859375,
        size.height * 0.7085938);
    path_24.cubicTo(
        size.width * 0.7859375,
        size.height * 0.7023438,
        size.width * 0.7808594,
        size.height * 0.6972656,
        size.width * 0.7746094,
        size.height * 0.6972656);
    path_24.lineTo(size.width * 0.5611328, size.height * 0.6972656);
    path_24.close();

    Paint paint_24_fill = Paint()..style = PaintingStyle.fill;
    paint_24_fill.color = Color(0xff0F0F0F).withOpacity(1.0);
    canvas.drawPath(path_24, paint_24_fill);

    Path path_25 = Path();
    path_25.moveTo(size.width * 0.8690430, size.height * 0.1077148);
    path_25.lineTo(size.width * 0.1329102, size.height * 0.1077148);
    path_25.cubicTo(
        size.width * 0.1162109,
        size.height * 0.1077148,
        size.width * 0.1026367,
        size.height * 0.09404297,
        size.width * 0.1026367,
        size.height * 0.07744141);
    path_25.lineTo(size.width * 0.1026367, size.height * 0.07636719);
    path_25.cubicTo(
        size.width * 0.1026367,
        size.height * 0.05966797,
        size.width * 0.1163086,
        size.height * 0.04609375,
        size.width * 0.1329102,
        size.height * 0.04609375);
    path_25.lineTo(size.width * 0.8690430, size.height * 0.04609375);
    path_25.cubicTo(
        size.width * 0.8857422,
        size.height * 0.04609375,
        size.width * 0.8993164,
        size.height * 0.05976563,
        size.width * 0.8993164,
        size.height * 0.07636719);
    path_25.lineTo(size.width * 0.8993164, size.height * 0.07744141);
    path_25.cubicTo(
        size.width * 0.8993164,
        size.height * 0.09404297,
        size.width * 0.8856445,
        size.height * 0.1077148,
        size.width * 0.8690430,
        size.height * 0.1077148);
    path_25.close();

    Paint paint_25_fill = Paint()..style = PaintingStyle.fill;
    paint_25_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_25, paint_25_fill);

    Path path_26 = Path();
    path_26.moveTo(size.width * 0.8685547, size.height * 0.1206055);
    path_26.lineTo(size.width * 0.1333984, size.height * 0.1206055);
    path_26.cubicTo(
        size.width * 0.1092773,
        size.height * 0.1206055,
        size.width * 0.08964844,
        size.height * 0.1009766,
        size.width * 0.08964844,
        size.height * 0.07685547);
    path_26.cubicTo(
        size.width * 0.08964844,
        size.height * 0.05273438,
        size.width * 0.1093750,
        size.height * 0.03320313,
        size.width * 0.1333984,
        size.height * 0.03320313);
    path_26.lineTo(size.width * 0.8684570, size.height * 0.03320313);
    path_26.cubicTo(
        size.width * 0.8925781,
        size.height * 0.03320313,
        size.width * 0.9122070,
        size.height * 0.05283203,
        size.width * 0.9122070,
        size.height * 0.07695312);
    path_26.cubicTo(
        size.width * 0.9122070,
        size.height * 0.1010742,
        size.width * 0.8925781,
        size.height * 0.1206055,
        size.width * 0.8685547,
        size.height * 0.1206055);
    path_26.close();
    path_26.moveTo(size.width * 0.1333984, size.height * 0.05898437);
    path_26.cubicTo(
        size.width * 0.1235352,
        size.height * 0.05898437,
        size.width * 0.1155273,
        size.height * 0.06699219,
        size.width * 0.1155273,
        size.height * 0.07685547);
    path_26.cubicTo(
        size.width * 0.1155273,
        size.height * 0.08671875,
        size.width * 0.1235352,
        size.height * 0.09472656,
        size.width * 0.1333984,
        size.height * 0.09472656);
    path_26.lineTo(size.width * 0.8684570, size.height * 0.09472656);
    path_26.cubicTo(
        size.width * 0.8783203,
        size.height * 0.09472656,
        size.width * 0.8863281,
        size.height * 0.08671875,
        size.width * 0.8863281,
        size.height * 0.07685547);
    path_26.cubicTo(
        size.width * 0.8863281,
        size.height * 0.06699219,
        size.width * 0.8783203,
        size.height * 0.05898438,
        size.width * 0.8684570,
        size.height * 0.05898438);
    path_26.lineTo(size.width * 0.1333984, size.height * 0.05898438);
    path_26.close();

    Paint paint_26_fill = Paint()..style = PaintingStyle.fill;
    paint_26_fill.color = Color(0xff141414).withOpacity(1.0);
    canvas.drawPath(path_26, paint_26_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
