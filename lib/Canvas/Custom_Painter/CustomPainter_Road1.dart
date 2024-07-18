import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Road1 extends CustomPainter {
  final color_s;

  RPSCustomPainter_Road1(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7304450, size.height * 0.9827155);
    path_0.lineTo(size.width * 0.6805090, size.height * 0.01728645);
    path_0.lineTo(size.width * 0.3143102, size.height * 0.01728645);
    path_0.lineTo(size.width * 0.2643742, size.height * 0.9827155);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6805090, size.height * 0.01728645);
    path_1.lineTo(size.width * 0.6305729, size.height * 0.01728645);
    path_1.lineTo(size.width * 0.6805090, size.height * 0.9827155);
    path_1.lineTo(size.width * 0.7304450, size.height * 0.9827155);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.3143102, size.height * 0.03393114);
    path_2.lineTo(size.width * 0.3642462, size.height * 0.03393114);
    path_2.lineTo(size.width * 0.3143102, size.height * 0.9993602);
    path_2.lineTo(size.width * 0.2643742, size.height * 0.9993602);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.8336448, size.height * 0.7080674);
    path_3.cubicTo(
        size.width * 0.7903662,
        size.height * 0.7596673,
        size.width * 0.8186640,
        size.height * 0.8428947,
        size.width * 0.8852447,
        size.height * 0.8495521);
    path_3.cubicTo(
        size.width * 0.8885744,
        size.height * 0.8495521,
        size.width * 0.8919022,
        size.height * 0.8495521,
        size.width * 0.8952319,
        size.height * 0.8495521);
    path_3.lineTo(size.width * 0.8968958, size.height * 0.8495521);
    path_3.cubicTo(
        size.width * 0.9684701,
        size.height * 0.8478883,
        size.width * 1.003425,
        size.height * 0.7613312,
        size.width * 0.9568190,
        size.height * 0.7080674);
    path_3.lineTo(size.width * 0.9168702, size.height * 0.6597953);
    path_3.cubicTo(
        size.width * 0.9052191,
        size.height * 0.6464783,
        size.width * 0.8852447,
        size.height * 0.6464783,
        size.width * 0.8735916,
        size.height * 0.6597953);
    path_3.lineTo(size.width * 0.8336448, size.height * 0.7080674);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff00DA6C).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.03466847, size.height * 0.1920625);
    path_4.cubicTo(
        size.width * -0.008610062,
        size.height * 0.2436624,
        size.width * 0.01968767,
        size.height * 0.3268898,
        size.width * 0.08626837,
        size.height * 0.3335473);
    path_4.cubicTo(
        size.width * 0.08959809,
        size.height * 0.3335473,
        size.width * 0.09292586,
        size.height * 0.3335473,
        size.width * 0.09625558,
        size.height * 0.3335473);
    path_4.lineTo(size.width * 0.09792141, size.height * 0.3335473);
    path_4.cubicTo(
        size.width * 0.1694957,
        size.height * 0.3318834,
        size.width * 0.2044509,
        size.height * 0.2453263,
        size.width * 0.1578446,
        size.height * 0.1920625);
    path_4.lineTo(size.width * 0.1195597, size.height * 0.1437904);
    path_4.cubicTo(
        size.width * 0.1079086,
        size.height * 0.1304735,
        size.width * 0.08793421,
        size.height * 0.1304735,
        size.width * 0.07628117,
        size.height * 0.1437904);
    path_4.lineTo(size.width * 0.03466847, size.height * 0.1920625);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xff00DA6C).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.03466847, size.height * 0.7080674);
    path_5.cubicTo(
        size.width * -0.008610062,
        size.height * 0.7596673,
        size.width * 0.01968767,
        size.height * 0.8428947,
        size.width * 0.08626837,
        size.height * 0.8495521);
    path_5.cubicTo(
        size.width * 0.08959809,
        size.height * 0.8495521,
        size.width * 0.09292586,
        size.height * 0.8495521,
        size.width * 0.09625558,
        size.height * 0.8495521);
    path_5.lineTo(size.width * 0.09792141, size.height * 0.8495521);
    path_5.cubicTo(
        size.width * 0.1694957,
        size.height * 0.8478883,
        size.width * 0.2044509,
        size.height * 0.7613312,
        size.width * 0.1578446,
        size.height * 0.7080674);
    path_5.lineTo(size.width * 0.1178958, size.height * 0.6597953);
    path_5.cubicTo(
        size.width * 0.1062447,
        size.height * 0.6464783,
        size.width * 0.08627033,
        size.height * 0.6464783,
        size.width * 0.07461729,
        size.height * 0.6597953);
    path_5.lineTo(size.width * 0.03466847, size.height * 0.7080674);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff00DA6C).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.8336448, size.height * 0.1920625);
    path_6.cubicTo(
        size.width * 0.7903662,
        size.height * 0.2436624,
        size.width * 0.8186640,
        size.height * 0.3268898,
        size.width * 0.8852447,
        size.height * 0.3335473);
    path_6.cubicTo(
        size.width * 0.8885744,
        size.height * 0.3335473,
        size.width * 0.8919022,
        size.height * 0.3335473,
        size.width * 0.8952319,
        size.height * 0.3335473);
    path_6.lineTo(size.width * 0.8968958, size.height * 0.3335473);
    path_6.cubicTo(
        size.width * 0.9684701,
        size.height * 0.3318834,
        size.width * 1.003425,
        size.height * 0.2453263,
        size.width * 0.9568190,
        size.height * 0.1920625);
    path_6.lineTo(size.width * 0.9168702, size.height * 0.1437904);
    path_6.cubicTo(
        size.width * 0.9052191,
        size.height * 0.1304735,
        size.width * 0.8852447,
        size.height * 0.1304735,
        size.width * 0.8735916,
        size.height * 0.1437904);
    path_6.lineTo(size.width * 0.8336448, size.height * 0.1920625);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xff00DA6C).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.9601507, size.height * 0.1920625);
    path_7.lineTo(size.width * 0.9202019, size.height * 0.1437904);
    path_7.cubicTo(
        size.width * 0.9085508,
        size.height * 0.1304735,
        size.width * 0.8885764,
        size.height * 0.1304735,
        size.width * 0.8769233,
        size.height * 0.1437904);
    path_7.lineTo(size.width * 0.8735936, size.height * 0.1471201);
    path_7.lineTo(size.width * 0.9102127, size.height * 0.1903986);
    path_7.cubicTo(
        size.width * 0.9518254,
        size.height * 0.2386708,
        size.width * 0.9285232,
        size.height * 0.3119090,
        size.width * 0.8719278,
        size.height * 0.3285556);
    path_7.cubicTo(
        size.width * 0.8769214,
        size.height * 0.3302195,
        size.width * 0.8819150,
        size.height * 0.3318853,
        size.width * 0.8869086,
        size.height * 0.3318853);
    path_7.cubicTo(
        size.width * 0.8902383,
        size.height * 0.3318853,
        size.width * 0.8935661,
        size.height * 0.3318853,
        size.width * 0.8968958,
        size.height * 0.3318853);
    path_7.lineTo(size.width * 0.8985597, size.height * 0.3318853);
    path_7.cubicTo(
        size.width * 0.9701379,
        size.height * 0.3318834,
        size.width * 1.005093,
        size.height * 0.2453263,
        size.width * 0.9601507,
        size.height * 0.1920625);

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff00AD55).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.9601507, size.height * 0.7080674);
    path_8.lineTo(size.width * 0.9202019, size.height * 0.6597953);
    path_8.cubicTo(
        size.width * 0.9085508,
        size.height * 0.6464783,
        size.width * 0.8885764,
        size.height * 0.6464783,
        size.width * 0.8769233,
        size.height * 0.6597953);
    path_8.lineTo(size.width * 0.8735936, size.height * 0.6631250);
    path_8.lineTo(size.width * 0.9102127, size.height * 0.7064035);
    path_8.cubicTo(
        size.width * 0.9518254,
        size.height * 0.7546756,
        size.width * 0.9285232,
        size.height * 0.8279138,
        size.width * 0.8719278,
        size.height * 0.8445605);
    path_8.cubicTo(
        size.width * 0.8769214,
        size.height * 0.8462244,
        size.width * 0.8819150,
        size.height * 0.8478902,
        size.width * 0.8869086,
        size.height * 0.8478902);
    path_8.cubicTo(
        size.width * 0.8902383,
        size.height * 0.8478902,
        size.width * 0.8935661,
        size.height * 0.8478902,
        size.width * 0.8968958,
        size.height * 0.8478902);
    path_8.lineTo(size.width * 0.8985597, size.height * 0.8478902);
    path_8.cubicTo(
        size.width * 0.9701379,
        size.height * 0.8478883,
        size.width * 1.005093,
        size.height * 0.7613331,
        size.width * 0.9601507,
        size.height * 0.7080674);

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff00AD55).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.1611744, size.height * 0.1920625);
    path_9.lineTo(size.width * 0.1195597, size.height * 0.1437904);
    path_9.cubicTo(
        size.width * 0.1079086,
        size.height * 0.1304735,
        size.width * 0.08793421,
        size.height * 0.1304735,
        size.width * 0.07628117,
        size.height * 0.1437904);
    path_9.lineTo(size.width * 0.07295340, size.height * 0.1471201);
    path_9.lineTo(size.width * 0.1095725, size.height * 0.1903986);
    path_9.cubicTo(
        size.width * 0.1511852,
        size.height * 0.2386708,
        size.width * 0.1278830,
        size.height * 0.3119090,
        size.width * 0.07128757,
        size.height * 0.3285556);
    path_9.cubicTo(
        size.width * 0.07628117,
        size.height * 0.3302195,
        size.width * 0.08127477,
        size.height * 0.3318853,
        size.width * 0.08626837,
        size.height * 0.3318853);
    path_9.cubicTo(
        size.width * 0.08959809,
        size.height * 0.3318853,
        size.width * 0.09292586,
        size.height * 0.3318853,
        size.width * 0.09625558,
        size.height * 0.3318853);
    path_9.lineTo(size.width * 0.09792141, size.height * 0.3318853);
    path_9.cubicTo(
        size.width * 0.1711616,
        size.height * 0.3318834,
        size.width * 0.2061168,
        size.height * 0.2453263,
        size.width * 0.1611744,
        size.height * 0.1920625);

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff00AD55).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.1611744, size.height * 0.7080674);
    path_10.lineTo(size.width * 0.1212255, size.height * 0.6597953);
    path_10.cubicTo(
        size.width * 0.1095745,
        size.height * 0.6464783,
        size.width * 0.08960004,
        size.height * 0.6464783,
        size.width * 0.07794701,
        size.height * 0.6597953);
    path_10.lineTo(size.width * 0.07461729, size.height * 0.6631250);
    path_10.lineTo(size.width * 0.1112364, size.height * 0.7064035);
    path_10.cubicTo(
        size.width * 0.1528491,
        size.height * 0.7546756,
        size.width * 0.1295469,
        size.height * 0.8279138,
        size.width * 0.07295145,
        size.height * 0.8445605);
    path_10.cubicTo(
        size.width * 0.07794505,
        size.height * 0.8462244,
        size.width * 0.08293866,
        size.height * 0.8478902,
        size.width * 0.08793226,
        size.height * 0.8478902);
    path_10.cubicTo(
        size.width * 0.09126198,
        size.height * 0.8478902,
        size.width * 0.09458974,
        size.height * 0.8478902,
        size.width * 0.09791946,
        size.height * 0.8478902);
    path_10.lineTo(size.width * 0.09958335, size.height * 0.8478902);
    path_10.cubicTo(
        size.width * 0.1711616,
        size.height * 0.8478883,
        size.width * 0.2061168,
        size.height * 0.7613331,
        size.width * 0.1611744,
        size.height * 0.7080674);

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xff00AD55).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.9801251, size.height * 0.03393114);
    path_11.lineTo(size.width * 0.01469406, size.height * 0.03393114);
    path_11.cubicTo(
        size.width * 0.004706860,
        size.height * 0.03393114,
        size.width * -0.001950626,
        size.height * 0.02727365,
        size.width * -0.001950626,
        size.height * 0.01728645);
    path_11.cubicTo(
        size.width * -0.001950626,
        size.height * 0.007299242,
        size.width * 0.004706860,
        size.height * 0.0006417559,
        size.width * 0.01469406,
        size.height * 0.0006417559);
    path_11.lineTo(size.width * 0.9801231, size.height * 0.0006417559);
    path_11.cubicTo(
        size.width * 0.9901103,
        size.height * 0.0006417559,
        size.width * 0.9967678,
        size.height * 0.007299242,
        size.width * 0.9967678,
        size.height * 0.01728645);
    path_11.cubicTo(
        size.width * 0.9967678,
        size.height * 0.02727365,
        size.width * 0.9901123,
        size.height * 0.03393114,
        size.width * 0.9801251,
        size.height * 0.03393114);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.7304450, size.height * 0.9993602);
    path_12.lineTo(size.width * 0.2643742, size.height * 0.9993602);
    path_12.cubicTo(
        size.width * 0.2593806,
        size.height * 0.9993602,
        size.width * 0.2560508,
        size.height * 0.9976963,
        size.width * 0.2527231,
        size.height * 0.9943666);
    path_12.cubicTo(
        size.width * 0.2493934,
        size.height * 0.9910369,
        size.width * 0.2477295,
        size.height * 0.9860433,
        size.width * 0.2477295,
        size.height * 0.9827155);
    path_12.lineTo(size.width * 0.2976655, size.height * 0.01728645);
    path_12.cubicTo(
        size.width * 0.2976655,
        size.height * 0.007299242,
        size.width * 0.3059888,
        size.height * 0.0006417559,
        size.width * 0.3143102,
        size.height * 0.0006417559);
    path_12.lineTo(size.width * 0.6805070, size.height * 0.0006417559);
    path_12.cubicTo(
        size.width * 0.6888303,
        size.height * 0.0006417559,
        size.width * 0.6971517,
        size.height * 0.007299242,
        size.width * 0.6971517,
        size.height * 0.01562256);
    path_12.lineTo(size.width * 0.7470897, size.height * 0.9810516);
    path_12.cubicTo(
        size.width * 0.7470897,
        size.height * 0.9860452,
        size.width * 0.7454258,
        size.height * 0.9893749,
        size.width * 0.7420961,
        size.height * 0.9927027);
    path_12.cubicTo(
        size.width * 0.7387663,
        size.height * 0.9976963,
        size.width * 0.7354386,
        size.height * 0.9993602,
        size.width * 0.7304450,
        size.height * 0.9993602);
    path_12.close();
    path_12.moveTo(size.width * 0.2826847, size.height * 0.9660708);
    path_12.lineTo(size.width * 0.7137983, size.height * 0.9660708);
    path_12.lineTo(size.width * 0.6655282, size.height * 0.03393114);
    path_12.lineTo(size.width * 0.3292910, size.height * 0.03393114);
    path_12.lineTo(size.width * 0.2826847, size.height * 0.9660708);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.4974096, size.height * 0.9993602);
    path_13.cubicTo(
        size.width * 0.4874224,
        size.height * 0.9993602,
        size.width * 0.4807649,
        size.height * 0.9927027,
        size.width * 0.4807649,
        size.height * 0.9827155);
    path_13.lineTo(size.width * 0.4807649, size.height * 0.8828435);
    path_13.cubicTo(
        size.width * 0.4807649,
        size.height * 0.8728563,
        size.width * 0.4874224,
        size.height * 0.8661988,
        size.width * 0.4974096,
        size.height * 0.8661988);
    path_13.cubicTo(
        size.width * 0.5073968,
        size.height * 0.8661988,
        size.width * 0.5140543,
        size.height * 0.8728563,
        size.width * 0.5140543,
        size.height * 0.8828435);
    path_13.lineTo(size.width * 0.5140543, size.height * 0.9827155);
    path_13.cubicTo(
        size.width * 0.5140543,
        size.height * 0.9927027,
        size.width * 0.5073968,
        size.height * 0.9993602,
        size.width * 0.4974096,
        size.height * 0.9993602);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.4974096, size.height * 0.7829714);
    path_14.cubicTo(
        size.width * 0.4874224,
        size.height * 0.7829714,
        size.width * 0.4807649,
        size.height * 0.7763139,
        size.width * 0.4807649,
        size.height * 0.7663267);
    path_14.lineTo(size.width * 0.4807649, size.height * 0.6664547);
    path_14.cubicTo(
        size.width * 0.4807649,
        size.height * 0.6564675,
        size.width * 0.4874224,
        size.height * 0.6498100,
        size.width * 0.4974096,
        size.height * 0.6498100);
    path_14.cubicTo(
        size.width * 0.5073968,
        size.height * 0.6498100,
        size.width * 0.5140543,
        size.height * 0.6564675,
        size.width * 0.5140543,
        size.height * 0.6664547);
    path_14.lineTo(size.width * 0.5140543, size.height * 0.7663267);
    path_14.cubicTo(
        size.width * 0.5140543,
        size.height * 0.7763139,
        size.width * 0.5073968,
        size.height * 0.7829714,
        size.width * 0.4974096,
        size.height * 0.7829714);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.4974096, size.height * 0.5665827);
    path_15.cubicTo(
        size.width * 0.4874224,
        size.height * 0.5665827,
        size.width * 0.4807649,
        size.height * 0.5599252,
        size.width * 0.4807649,
        size.height * 0.5499380);
    path_15.lineTo(size.width * 0.4807649, size.height * 0.4500659);
    path_15.cubicTo(
        size.width * 0.4807649,
        size.height * 0.4400787,
        size.width * 0.4874224,
        size.height * 0.4334212,
        size.width * 0.4974096,
        size.height * 0.4334212);
    path_15.cubicTo(
        size.width * 0.5073968,
        size.height * 0.4334212,
        size.width * 0.5140543,
        size.height * 0.4400787,
        size.width * 0.5140543,
        size.height * 0.4500659);
    path_15.lineTo(size.width * 0.5140543, size.height * 0.5499380);
    path_15.cubicTo(
        size.width * 0.5140543,
        size.height * 0.5599232,
        size.width * 0.5073968,
        size.height * 0.5665827,
        size.width * 0.4974096,
        size.height * 0.5665827);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.4974096, size.height * 0.3501919);
    path_16.cubicTo(
        size.width * 0.4874224,
        size.height * 0.3501919,
        size.width * 0.4807649,
        size.height * 0.3435345,
        size.width * 0.4807649,
        size.height * 0.3335473);
    path_16.lineTo(size.width * 0.4807649, size.height * 0.2336752);
    path_16.cubicTo(
        size.width * 0.4807649,
        size.height * 0.2236880,
        size.width * 0.4874224,
        size.height * 0.2170305,
        size.width * 0.4974096,
        size.height * 0.2170305);
    path_16.cubicTo(
        size.width * 0.5073968,
        size.height * 0.2170305,
        size.width * 0.5140543,
        size.height * 0.2236880,
        size.width * 0.5140543,
        size.height * 0.2336752);
    path_16.lineTo(size.width * 0.5140543, size.height * 0.3335473);
    path_16.cubicTo(
        size.width * 0.5140543,
        size.height * 0.3435345,
        size.width * 0.5073968,
        size.height * 0.3501919,
        size.width * 0.4974096,
        size.height * 0.3501919);
    path_16.close();

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.4974096, size.height * 0.1338032);
    path_17.cubicTo(
        size.width * 0.4874224,
        size.height * 0.1338032,
        size.width * 0.4807649,
        size.height * 0.1271457,
        size.width * 0.4807649,
        size.height * 0.1171585);
    path_17.lineTo(size.width * 0.4807649, size.height * 0.01728645);
    path_17.cubicTo(
        size.width * 0.4807649,
        size.height * 0.007299242,
        size.width * 0.4874224,
        size.height * 0.0006417559,
        size.width * 0.4974096,
        size.height * 0.0006417559);
    path_17.cubicTo(
        size.width * 0.5073968,
        size.height * 0.0006417559,
        size.width * 0.5140543,
        size.height * 0.007299242,
        size.width * 0.5140543,
        size.height * 0.01728645);
    path_17.lineTo(size.width * 0.5140543, size.height * 0.1171585);
    path_17.cubicTo(
        size.width * 0.5140543,
        size.height * 0.1271457,
        size.width * 0.5073968,
        size.height * 0.1338032,
        size.width * 0.4974096,
        size.height * 0.1338032);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.09792141, size.height * 0.3501919);
    path_18.cubicTo(
        size.width * 0.09459170,
        size.height * 0.3501919,
        size.width * 0.08959809,
        size.height * 0.3501919,
        size.width * 0.08627033,
        size.height * 0.3501919);
    path_18.cubicTo(
        size.width * 0.04965123,
        size.height * 0.3468622,
        size.width * 0.01968962,
        size.height * 0.3235600,
        size.width * 0.006372694,
        size.height * 0.2886048);
    path_18.cubicTo(
        size.width * -0.008608111,
        size.height * 0.2519857,
        size.width * -0.001950626,
        size.height * 0.2120369,
        size.width * 0.02301738,
        size.height * 0.1820753);
    path_18.lineTo(size.width * 0.06296620, size.height * 0.1338032);
    path_18.cubicTo(
        size.width * 0.08127672,
        size.height * 0.1121649,
        size.width * 0.1145661,
        size.height * 0.1121649,
        size.width * 0.1328766,
        size.height * 0.1338032);
    path_18.lineTo(size.width * 0.1728254, size.height * 0.1820753);
    path_18.cubicTo(
        size.width * 0.1994573,
        size.height * 0.2137008,
        size.width * 0.2044509,
        size.height * 0.2553155,
        size.width * 0.1878062,
        size.height * 0.2919346);
    path_18.cubicTo(
        size.width * 0.1711616,
        size.height * 0.3268898,
        size.width * 0.1378702,
        size.height * 0.3501939,
        size.width * 0.09958530,
        size.height * 0.3501939);
    path_18.lineTo(size.width * 0.09792141, size.height * 0.3501939);
    path_18.close();
    path_18.moveTo(size.width * 0.09792141, size.height * 0.1504479);
    path_18.cubicTo(
        size.width * 0.09625753,
        size.height * 0.1504479,
        size.width * 0.09292781,
        size.height * 0.1504479,
        size.width * 0.08959809,
        size.height * 0.1537776);
    path_18.lineTo(size.width * 0.04798539, size.height * 0.2020497);
    path_18.cubicTo(
        size.width * 0.03134070,
        size.height * 0.2220241,
        size.width * 0.02634710,
        size.height * 0.2503219,
        size.width * 0.03633431,
        size.height * 0.2752899);
    path_18.cubicTo(
        size.width * 0.04632151,
        size.height * 0.2985940,
        size.width * 0.06463203,
        size.height * 0.3135748,
        size.width * 0.08960004,
        size.height * 0.3169026);
    path_18.cubicTo(
        size.width * 0.09292976,
        size.height * 0.3169026,
        size.width * 0.09625753,
        size.height * 0.3169026,
        size.width * 0.09792336,
        size.height * 0.3169026);
    path_18.lineTo(size.width * 0.09792336, size.height * 0.3335473);
    path_18.lineTo(size.width * 0.09958725, size.height * 0.3169026);
    path_18.cubicTo(
        size.width * 0.1262191,
        size.height * 0.3169026,
        size.width * 0.1478594,
        size.height * 0.3019218,
        size.width * 0.1578466,
        size.height * 0.2769537);
    path_18.cubicTo(
        size.width * 0.1694977,
        size.height * 0.2519857,
        size.width * 0.1661699,
        size.height * 0.2220241,
        size.width * 0.1478594,
        size.height * 0.2020497);
    path_18.lineTo(size.width * 0.1079086, size.height * 0.1537776);
    path_18.cubicTo(
        size.width * 0.1045789,
        size.height * 0.1504479,
        size.width * 0.09958530,
        size.height * 0.1504479,
        size.width * 0.09792141,
        size.height * 0.1504479);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_18, paint_18_fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 0.09792141, size.height * 0.4334193);
    path_19.cubicTo(
        size.width * 0.08793421,
        size.height * 0.4334193,
        size.width * 0.08127672,
        size.height * 0.4267618,
        size.width * 0.08127672,
        size.height * 0.4167746);
    path_19.lineTo(size.width * 0.08127672, size.height * 0.2669665);
    path_19.cubicTo(
        size.width * 0.08127672,
        size.height * 0.2569793,
        size.width * 0.08793421,
        size.height * 0.2503219,
        size.width * 0.09792141,
        size.height * 0.2503219);
    path_19.cubicTo(
        size.width * 0.1079086,
        size.height * 0.2503219,
        size.width * 0.1145661,
        size.height * 0.2569793,
        size.width * 0.1145661,
        size.height * 0.2669665);
    path_19.lineTo(size.width * 0.1145661, size.height * 0.4167746);
    path_19.cubicTo(
        size.width * 0.1145661,
        size.height * 0.4267618,
        size.width * 0.1079086,
        size.height * 0.4334193,
        size.width * 0.09792141,
        size.height * 0.4334193);
    path_19.close();

    Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
    paint_19_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_19, paint_19_fill);

    Path path_20 = Path();
    path_20.moveTo(size.width * 0.09792141, size.height * 0.8661988);
    path_20.cubicTo(
        size.width * 0.09459170,
        size.height * 0.8661988,
        size.width * 0.08959809,
        size.height * 0.8661988,
        size.width * 0.08627033,
        size.height * 0.8661988);
    path_20.cubicTo(
        size.width * 0.04965123,
        size.height * 0.8628691,
        size.width * 0.01968962,
        size.height * 0.8395669,
        size.width * 0.006372694,
        size.height * 0.8046117);
    path_20.cubicTo(
        size.width * -0.008608111,
        size.height * 0.7679906,
        size.width * -0.001950626,
        size.height * 0.7280418,
        size.width * 0.02301738,
        size.height * 0.6980802);
    path_20.lineTo(size.width * 0.06296620, size.height * 0.6498081);
    path_20.cubicTo(
        size.width * 0.07961089,
        size.height * 0.6298337,
        size.width * 0.1145661,
        size.height * 0.6298337,
        size.width * 0.1312127,
        size.height * 0.6498081);
    path_20.lineTo(size.width * 0.1711616, size.height * 0.6980802);
    path_20.cubicTo(
        size.width * 0.1977935,
        size.height * 0.7297057,
        size.width * 0.2027871,
        size.height * 0.7713203,
        size.width * 0.1861424,
        size.height * 0.8079394);
    path_20.cubicTo(
        size.width * 0.1694957,
        size.height * 0.8428947,
        size.width * 0.1362063,
        size.height * 0.8661988,
        size.width * 0.09792141,
        size.height * 0.8661988);
    path_20.lineTo(size.width * 0.09792141, size.height * 0.8661988);
    path_20.close();
    path_20.moveTo(size.width * 0.09792141, size.height * 0.6664547);
    path_20.cubicTo(
        size.width * 0.09625753,
        size.height * 0.6664547,
        size.width * 0.09126393,
        size.height * 0.6664547,
        size.width * 0.08959809,
        size.height * 0.6714483);
    path_20.lineTo(size.width * 0.04798539, size.height * 0.7180546);
    path_20.cubicTo(
        size.width * 0.03134070,
        size.height * 0.7380290,
        size.width * 0.02634710,
        size.height * 0.7663267,
        size.width * 0.03633431,
        size.height * 0.7912947);
    path_20.cubicTo(
        size.width * 0.04632151,
        size.height * 0.8145989,
        size.width * 0.06463203,
        size.height * 0.8295797,
        size.width * 0.08960004,
        size.height * 0.8329074);
    path_20.cubicTo(
        size.width * 0.09292976,
        size.height * 0.8329074,
        size.width * 0.09459365,
        size.height * 0.8329074,
        size.width * 0.09792336,
        size.height * 0.8329074);
    path_20.lineTo(size.width * 0.09792336, size.height * 0.8495521);
    path_20.lineTo(size.width * 0.09958725, size.height * 0.8329074);
    path_20.cubicTo(
        size.width * 0.1262191,
        size.height * 0.8329074,
        size.width * 0.1478594,
        size.height * 0.8179266,
        size.width * 0.1578466,
        size.height * 0.7929586);
    path_20.cubicTo(
        size.width * 0.1694977,
        size.height * 0.7679906,
        size.width * 0.1661699,
        size.height * 0.7380290,
        size.width * 0.1478594,
        size.height * 0.7180546);
    path_20.lineTo(size.width * 0.1079106, size.height * 0.6697825);
    path_20.cubicTo(
        size.width * 0.1045789,
        size.height * 0.6664547,
        size.width * 0.09958530,
        size.height * 0.6664547,
        size.width * 0.09792141,
        size.height * 0.6664547);
    path_20.close();

    Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
    paint_20_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_20, paint_20_fill);

    Path path_21 = Path();
    path_21.moveTo(size.width * 0.09792141, size.height * 0.9494242);
    path_21.cubicTo(
        size.width * 0.08793421,
        size.height * 0.9494242,
        size.width * 0.08127672,
        size.height * 0.9427667,
        size.width * 0.08127672,
        size.height * 0.9327795);
    path_21.lineTo(size.width * 0.08127672, size.height * 0.7829714);
    path_21.cubicTo(
        size.width * 0.08127672,
        size.height * 0.7729842,
        size.width * 0.08793421,
        size.height * 0.7663267,
        size.width * 0.09792141,
        size.height * 0.7663267);
    path_21.cubicTo(
        size.width * 0.1079086,
        size.height * 0.7663267,
        size.width * 0.1145661,
        size.height * 0.7729842,
        size.width * 0.1145661,
        size.height * 0.7829714);
    path_21.lineTo(size.width * 0.1145661, size.height * 0.9327795);
    path_21.cubicTo(
        size.width * 0.1145661,
        size.height * 0.9427667,
        size.width * 0.1079086,
        size.height * 0.9494242,
        size.width * 0.09792141,
        size.height * 0.9494242);
    path_21.close();

    Paint paint_21_fill = Paint()..style = PaintingStyle.fill;
    paint_21_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_21, paint_21_fill);

    Path path_22 = Path();
    path_22.moveTo(size.width * 0.8968977, size.height * 0.3501919);
    path_22.cubicTo(
        size.width * 0.8935680,
        size.height * 0.3501919,
        size.width * 0.8885744,
        size.height * 0.3501919,
        size.width * 0.8852466,
        size.height * 0.3501919);
    path_22.cubicTo(
        size.width * 0.8486275,
        size.height * 0.3468622,
        size.width * 0.8186659,
        size.height * 0.3235600,
        size.width * 0.8053490,
        size.height * 0.2886048);
    path_22.cubicTo(
        size.width * 0.7903682,
        size.height * 0.2519857,
        size.width * 0.7970257,
        size.height * 0.2120369,
        size.width * 0.8219937,
        size.height * 0.1820753);
    path_22.lineTo(size.width * 0.8619425, size.height * 0.1338032);
    path_22.cubicTo(
        size.width * 0.8785872,
        size.height * 0.1138288,
        size.width * 0.9135424,
        size.height * 0.1138288,
        size.width * 0.9301891,
        size.height * 0.1338032);
    path_22.lineTo(size.width * 0.9701379, size.height * 0.1820753);
    path_22.cubicTo(
        size.width * 0.9967698,
        size.height * 0.2137008,
        size.width * 1.001763,
        size.height * 0.2553155,
        size.width * 0.9851187,
        size.height * 0.2935984);
    path_22.cubicTo(
        size.width * 0.9684740,
        size.height * 0.3285537,
        size.width * 0.9351827,
        size.height * 0.3518578,
        size.width * 0.8968977,
        size.height * 0.3518578);
    path_22.lineTo(size.width * 0.8968977, size.height * 0.3501919);
    path_22.close();
    path_22.moveTo(size.width * 0.8968977, size.height * 0.1504479);
    path_22.cubicTo(
        size.width * 0.8952338,
        size.height * 0.1504479,
        size.width * 0.8902402,
        size.height * 0.1504479,
        size.width * 0.8885744,
        size.height * 0.1554415);
    path_22.lineTo(size.width * 0.8469617, size.height * 0.2020497);
    path_22.cubicTo(
        size.width * 0.8303170,
        size.height * 0.2220241,
        size.width * 0.8253234,
        size.height * 0.2503219,
        size.width * 0.8353106,
        size.height * 0.2752899);
    path_22.cubicTo(
        size.width * 0.8452978,
        size.height * 0.2985940,
        size.width * 0.8636083,
        size.height * 0.3135748,
        size.width * 0.8885764,
        size.height * 0.3169026);
    path_22.cubicTo(
        size.width * 0.8919061,
        size.height * 0.3169026,
        size.width * 0.8935700,
        size.height * 0.3169026,
        size.width * 0.8968997,
        size.height * 0.3169026);
    path_22.lineTo(size.width * 0.8968997, size.height * 0.3335473);
    path_22.lineTo(size.width * 0.8985636, size.height * 0.3169026);
    path_22.cubicTo(
        size.width * 0.9251955,
        size.height * 0.3169026,
        size.width * 0.9468357,
        size.height * 0.3019218,
        size.width * 0.9568229,
        size.height * 0.2769537);
    path_22.cubicTo(
        size.width * 0.9684740,
        size.height * 0.2519857,
        size.width * 0.9651462,
        size.height * 0.2220241,
        size.width * 0.9468357,
        size.height * 0.2020497);
    path_22.lineTo(size.width * 0.9068869, size.height * 0.1537776);
    path_22.cubicTo(
        size.width * 0.9035552,
        size.height * 0.1504479,
        size.width * 0.8985616,
        size.height * 0.1504479,
        size.width * 0.8968977,
        size.height * 0.1504479);
    path_22.close();

    Paint paint_22_fill = Paint()..style = PaintingStyle.fill;
    paint_22_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_22, paint_22_fill);

    Path path_23 = Path();
    path_23.moveTo(size.width * 0.8968977, size.height * 0.4334193);
    path_23.cubicTo(
        size.width * 0.8869105,
        size.height * 0.4334193,
        size.width * 0.8802530,
        size.height * 0.4267618,
        size.width * 0.8802530,
        size.height * 0.4167746);
    path_23.lineTo(size.width * 0.8802530, size.height * 0.2669665);
    path_23.cubicTo(
        size.width * 0.8802530,
        size.height * 0.2569793,
        size.width * 0.8869105,
        size.height * 0.2503219,
        size.width * 0.8968977,
        size.height * 0.2503219);
    path_23.cubicTo(
        size.width * 0.9068849,
        size.height * 0.2503219,
        size.width * 0.9135424,
        size.height * 0.2569793,
        size.width * 0.9135424,
        size.height * 0.2669665);
    path_23.lineTo(size.width * 0.9135424, size.height * 0.4167746);
    path_23.cubicTo(
        size.width * 0.9135424,
        size.height * 0.4267618,
        size.width * 0.9068849,
        size.height * 0.4334193,
        size.width * 0.8968977,
        size.height * 0.4334193);
    path_23.close();

    Paint paint_23_fill = Paint()..style = PaintingStyle.fill;
    paint_23_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_23, paint_23_fill);

    Path path_24 = Path();
    path_24.moveTo(size.width * 0.8968977, size.height * 0.8661988);
    path_24.cubicTo(
        size.width * 0.8935680,
        size.height * 0.8661988,
        size.width * 0.8885744,
        size.height * 0.8661988,
        size.width * 0.8852466,
        size.height * 0.8661988);
    path_24.cubicTo(
        size.width * 0.8486275,
        size.height * 0.8628691,
        size.width * 0.8186659,
        size.height * 0.8395669,
        size.width * 0.8053490,
        size.height * 0.8046117);
    path_24.cubicTo(
        size.width * 0.7903682,
        size.height * 0.7679926,
        size.width * 0.7970257,
        size.height * 0.7280438,
        size.width * 0.8219937,
        size.height * 0.6980821);
    path_24.lineTo(size.width * 0.8636064, size.height * 0.6498100);
    path_24.cubicTo(
        size.width * 0.8719297,
        size.height * 0.6398228,
        size.width * 0.8852447,
        size.height * 0.6331653,
        size.width * 0.8985616,
        size.height * 0.6331653);
    path_24.lineTo(size.width * 0.8985616, size.height * 0.6331653);
    path_24.cubicTo(
        size.width * 0.9118785,
        size.height * 0.6331653,
        size.width * 0.9235296,
        size.height * 0.6381589,
        size.width * 0.9335168,
        size.height * 0.6498100);
    path_24.lineTo(size.width * 0.9734656, size.height * 0.6980821);
    path_24.cubicTo(
        size.width * 1.000098,
        size.height * 0.7297076,
        size.width * 1.005091,
        size.height * 0.7713223,
        size.width * 0.9884464,
        size.height * 0.8079414);
    path_24.cubicTo(
        size.width * 0.9718018,
        size.height * 0.8428966,
        size.width * 0.9385104,
        size.height * 0.8662007,
        size.width * 0.9002255,
        size.height * 0.8662007);
    path_24.lineTo(size.width * 0.8968977, size.height * 0.8661988);
    path_24.close();
    path_24.moveTo(size.width * 0.8968977, size.height * 0.6664547);
    path_24.cubicTo(
        size.width * 0.8952338,
        size.height * 0.6664547,
        size.width * 0.8902402,
        size.height * 0.6664547,
        size.width * 0.8885744,
        size.height * 0.6714483);
    path_24.lineTo(size.width * 0.8469617, size.height * 0.7180546);
    path_24.cubicTo(
        size.width * 0.8303170,
        size.height * 0.7380290,
        size.width * 0.8253234,
        size.height * 0.7663267,
        size.width * 0.8353106,
        size.height * 0.7912947);
    path_24.cubicTo(
        size.width * 0.8452978,
        size.height * 0.8145989,
        size.width * 0.8636083,
        size.height * 0.8295797,
        size.width * 0.8885764,
        size.height * 0.8329074);
    path_24.cubicTo(
        size.width * 0.8919061,
        size.height * 0.8329074,
        size.width * 0.8935700,
        size.height * 0.8329074,
        size.width * 0.8968997,
        size.height * 0.8329074);
    path_24.lineTo(size.width * 0.8968997, size.height * 0.8495521);
    path_24.lineTo(size.width * 0.8985636, size.height * 0.8329074);
    path_24.cubicTo(
        size.width * 0.9251955,
        size.height * 0.8329074,
        size.width * 0.9468357,
        size.height * 0.8179266,
        size.width * 0.9568229,
        size.height * 0.7929586);
    path_24.cubicTo(
        size.width * 0.9684740,
        size.height * 0.7679906,
        size.width * 0.9651462,
        size.height * 0.7380290,
        size.width * 0.9468357,
        size.height * 0.7180546);
    path_24.lineTo(size.width * 0.9068869, size.height * 0.6697825);
    path_24.cubicTo(
        size.width * 0.9035552,
        size.height * 0.6664547,
        size.width * 0.8985616,
        size.height * 0.6664547,
        size.width * 0.8968977,
        size.height * 0.6664547);
    path_24.close();

    Paint paint_24_fill = Paint()..style = PaintingStyle.fill;
    paint_24_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_24, paint_24_fill);

    Path path_25 = Path();
    path_25.moveTo(size.width * 0.8968977, size.height * 0.9494242);
    path_25.cubicTo(
        size.width * 0.8869105,
        size.height * 0.9494242,
        size.width * 0.8802530,
        size.height * 0.9427667,
        size.width * 0.8802530,
        size.height * 0.9327795);
    path_25.lineTo(size.width * 0.8802530, size.height * 0.7829714);
    path_25.cubicTo(
        size.width * 0.8802530,
        size.height * 0.7729842,
        size.width * 0.8869105,
        size.height * 0.7663267,
        size.width * 0.8968977,
        size.height * 0.7663267);
    path_25.cubicTo(
        size.width * 0.9068849,
        size.height * 0.7663267,
        size.width * 0.9135424,
        size.height * 0.7729842,
        size.width * 0.9135424,
        size.height * 0.7829714);
    path_25.lineTo(size.width * 0.9135424, size.height * 0.9327795);
    path_25.cubicTo(
        size.width * 0.9135424,
        size.height * 0.9427667,
        size.width * 0.9068849,
        size.height * 0.9494242,
        size.width * 0.8968977,
        size.height * 0.9494242);
    path_25.close();

    Paint paint_25_fill = Paint()..style = PaintingStyle.fill;
    paint_25_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_25, paint_25_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
