import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Crop extends CustomPainter {
  final color_s;

  RPSCustomPainter_Crop(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9845352, size.height * 0.03608203);
    path_0.lineTo(size.width * 0.9845352, size.height * 0.9639180);
    path_0.cubicTo(
        size.width * 0.9845352,
        size.height * 0.9752578,
        size.width * 0.9752559,
        size.height * 0.9845371,
        size.width * 0.9639160,
        size.height * 0.9845371);
    path_0.lineTo(size.width * 0.03608203, size.height * 0.9845371);
    path_0.cubicTo(
        size.width * 0.02474219,
        size.height * 0.9845371,
        size.width * 0.01546289,
        size.height * 0.9752578,
        size.width * 0.01546289,
        size.height * 0.9639180);
    path_0.lineTo(size.width * 0.01546289, size.height * 0.03608203);
    path_0.cubicTo(
        size.width * 0.01546289,
        size.height * 0.02474219,
        size.width * 0.02474219,
        size.height * 0.01546289,
        size.width * 0.03608203,
        size.height * 0.01546289);
    path_0.lineTo(size.width * 0.9639180, size.height * 0.01546289);
    path_0.cubicTo(
        size.width * 0.9752578,
        size.height * 0.01546484,
        size.width * 0.9845352,
        size.height * 0.02474219,
        size.width * 0.9845352,
        size.height * 0.03608203);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1522969, size.height * 0.01546484);
    path_1.lineTo(size.width * 0.03608203, size.height * 0.01546484);
    path_1.cubicTo(
        size.width * 0.02474219,
        size.height * 0.01546484,
        size.width * 0.01546289,
        size.height * 0.02474414,
        size.width * 0.01546289,
        size.height * 0.03608398);
    path_1.lineTo(size.width * 0.01546289, size.height * 0.9639199);
    path_1.cubicTo(
        size.width * 0.01546289,
        size.height * 0.9752598,
        size.width * 0.02474219,
        size.height * 0.9845391,
        size.width * 0.03608203,
        size.height * 0.9845391);
    path_1.lineTo(size.width * 0.9639180, size.height * 0.9845391);
    path_1.cubicTo(
        size.width * 0.9752578,
        size.height * 0.9845391,
        size.width * 0.9845371,
        size.height * 0.9752598,
        size.width * 0.9845371,
        size.height * 0.9639199);
    path_1.lineTo(size.width * 0.9845371, size.height * 0.9604922);
    path_1.cubicTo(
        size.width * 0.5509121,
        size.height * 0.8372168,
        size.width * 0.2206875,
        size.height * 0.4696660,
        size.width * 0.1522969,
        size.height * 0.01546484);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffE7ECED).withOpacity(1.0);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.8092793, size.height * 0.7371133,
            size.width * 0.09278320, size.height * 0.08247461),
        paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.8092793, size.height * 0.8195879);
    path_3.lineTo(size.width * 0.8092793, size.height * 0.9123711);
    path_3.lineTo(size.width * 0.7268047, size.height * 0.9123711);
    path_3.lineTo(size.width * 0.7268047, size.height * 0.8195879);
    path_3.lineTo(size.width * 0.7268047, size.height * 0.7371133);
    path_3.lineTo(size.width * 0.7268047, size.height * 0.2713398);
    path_3.lineTo(size.width * 0.8092793, size.height * 0.1845352);
    path_3.lineTo(size.width * 0.8092793, size.height * 0.7371133);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffAFB6BB).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.8092793, size.height * 0.1804121);
    path_4.lineTo(size.width * 0.8092793, size.height * 0.1845352);
    path_4.lineTo(size.width * 0.7268047, size.height * 0.2713398);
    path_4.lineTo(size.width * 0.7268047, size.height * 0.2628867);
    path_4.lineTo(size.width * 0.2835059, size.height * 0.2628867);
    path_4.lineTo(size.width * 0.2835059, size.height * 0.1804121);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffAFB6BB).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.7268047, size.height * 0.7371133);
    path_5.lineTo(size.width * 0.7268047, size.height * 0.8195879);
    path_5.lineTo(size.width * 0.2010312, size.height * 0.8195879);
    path_5.lineTo(size.width * 0.2010312, size.height * 0.2628867);
    path_5.lineTo(size.width * 0.2010312, size.height * 0.1804121);
    path_5.lineTo(size.width * 0.2010312, size.height * 0.08762891);
    path_5.lineTo(size.width * 0.2835059, size.height * 0.08762891);
    path_5.lineTo(size.width * 0.2835059, size.height * 0.1804121);
    path_5.lineTo(size.width * 0.2835059, size.height * 0.2628867);
    path_5.lineTo(size.width * 0.2835059, size.height * 0.7371133);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xffE7ECED).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xffAFB6BB).withOpacity(1.0);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.1082480, size.height * 0.1804121,
            size.width * 0.09278320, size.height * 0.08247461),
        paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.9639180, 0);
    path_7.lineTo(size.width * 0.03608203, 0);
    path_7.cubicTo(size.width * 0.01618750, 0, 0, size.height * 0.01618750, 0,
        size.height * 0.03608203);
    path_7.lineTo(0, size.height * 0.9639180);
    path_7.cubicTo(0, size.height * 0.9838125, size.width * 0.01618750,
        size.height, size.width * 0.03608203, size.height);
    path_7.lineTo(size.width * 0.9639180, size.height);
    path_7.cubicTo(size.width * 0.9838125, size.height, size.width,
        size.height * 0.9838125, size.width, size.height * 0.9639180);
    path_7.lineTo(size.width, size.height * 0.03608203);
    path_7.cubicTo(size.width, size.height * 0.01618750, size.width * 0.9838125,
        0, size.width * 0.9639180, 0);
    path_7.close();
    path_7.moveTo(size.width * 0.9690723, size.height * 0.9639180);
    path_7.cubicTo(
        size.width * 0.9690723,
        size.height * 0.9667109,
        size.width * 0.9667109,
        size.height * 0.9690723,
        size.width * 0.9639180,
        size.height * 0.9690723);
    path_7.lineTo(size.width * 0.03608203, size.height * 0.9690723);
    path_7.cubicTo(
        size.width * 0.03328906,
        size.height * 0.9690723,
        size.width * 0.03092773,
        size.height * 0.9667109,
        size.width * 0.03092773,
        size.height * 0.9639180);
    path_7.lineTo(size.width * 0.03092773, size.height * 0.03608203);
    path_7.cubicTo(
        size.width * 0.03092773,
        size.height * 0.03328906,
        size.width * 0.03328906,
        size.height * 0.03092773,
        size.width * 0.03608203,
        size.height * 0.03092773);
    path_7.lineTo(size.width * 0.9639180, size.height * 0.03092773);
    path_7.cubicTo(
        size.width * 0.9667109,
        size.height * 0.03092773,
        size.width * 0.9690723,
        size.height * 0.03328906,
        size.width * 0.9690723,
        size.height * 0.03608203);
    path_7.lineTo(size.width * 0.9690723, size.height * 0.9639180);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.8247422, size.height * 0.1907207);
    path_8.lineTo(size.width * 0.9029512, size.height * 0.1086035);
    path_8.lineTo(size.width * 0.8805566, size.height * 0.08727344);
    path_8.lineTo(size.width * 0.8065781, size.height * 0.1649473);
    path_8.lineTo(size.width * 0.2989688, size.height * 0.1649473);
    path_8.lineTo(size.width * 0.2989688, size.height * 0.07216406);
    path_8.lineTo(size.width * 0.1855664, size.height * 0.07216406);
    path_8.lineTo(size.width * 0.1855664, size.height * 0.1649473);
    path_8.lineTo(size.width * 0.09278320, size.height * 0.1649473);
    path_8.lineTo(size.width * 0.09278320, size.height * 0.2783496);
    path_8.lineTo(size.width * 0.1855664, size.height * 0.2783496);
    path_8.lineTo(size.width * 0.1855664, size.height * 0.8350508);
    path_8.lineTo(size.width * 0.7113398, size.height * 0.8350508);
    path_8.lineTo(size.width * 0.7113398, size.height * 0.9278340);
    path_8.lineTo(size.width * 0.8247422, size.height * 0.9278340);
    path_8.lineTo(size.width * 0.8247422, size.height * 0.8350508);
    path_8.lineTo(size.width * 0.9175254, size.height * 0.8350508);
    path_8.lineTo(size.width * 0.9175254, size.height * 0.7216484);
    path_8.lineTo(size.width * 0.8247422, size.height * 0.7216484);
    path_8.lineTo(size.width * 0.8247422, size.height * 0.1907207);
    path_8.close();
    path_8.moveTo(size.width * 0.7771738, size.height * 0.1958770);
    path_8.lineTo(size.width * 0.7282012, size.height * 0.2474238);
    path_8.lineTo(size.width * 0.2989688, size.height * 0.2474238);
    path_8.lineTo(size.width * 0.2989688, size.height * 0.1958770);
    path_8.lineTo(size.width * 0.7771738, size.height * 0.1958770);
    path_8.close();
    path_8.moveTo(size.width * 0.7113398, size.height * 0.3100195);
    path_8.lineTo(size.width * 0.7113398, size.height * 0.7216504);
    path_8.lineTo(size.width * 0.3195703, size.height * 0.7216504);
    path_8.lineTo(size.width * 0.7113398, size.height * 0.3100195);
    path_8.close();
    path_8.moveTo(size.width * 0.2989688, size.height * 0.6984355);
    path_8.lineTo(size.width * 0.2989688, size.height * 0.2783496);
    path_8.lineTo(size.width * 0.6987852, size.height * 0.2783496);
    path_8.lineTo(size.width * 0.2989688, size.height * 0.6984355);
    path_8.close();
    path_8.moveTo(size.width * 0.1237109, size.height * 0.2474219);
    path_8.lineTo(size.width * 0.1237109, size.height * 0.1958750);
    path_8.lineTo(size.width * 0.1855664, size.height * 0.1958750);
    path_8.lineTo(size.width * 0.1855664, size.height * 0.2474219);
    path_8.lineTo(size.width * 0.1237109, size.height * 0.2474219);
    path_8.close();
    path_8.moveTo(size.width * 0.2164941, size.height * 0.8041230);
    path_8.lineTo(size.width * 0.2164941, size.height * 0.1030937);
    path_8.lineTo(size.width * 0.2680410, size.height * 0.1030937);
    path_8.lineTo(size.width * 0.2680410, size.height * 0.7525781);
    path_8.lineTo(size.width * 0.7113398, size.height * 0.7525781);
    path_8.lineTo(size.width * 0.7113398, size.height * 0.8041250);
    path_8.lineTo(size.width * 0.2164941, size.height * 0.8041250);
    path_8.close();
    path_8.moveTo(size.width * 0.7422676, size.height * 0.8969082);
    path_8.lineTo(size.width * 0.7422676, size.height * 0.2775156);
    path_8.lineTo(size.width * 0.7938145, size.height * 0.2232617);
    path_8.lineTo(size.width * 0.7938145, size.height * 0.8969063);
    path_8.lineTo(size.width * 0.7422676, size.height * 0.8969063);
    path_8.close();
    path_8.moveTo(size.width * 0.8865977, size.height * 0.7525781);
    path_8.lineTo(size.width * 0.8865977, size.height * 0.8041250);
    path_8.lineTo(size.width * 0.8247422, size.height * 0.8041250);
    path_8.lineTo(size.width * 0.8247422, size.height * 0.7525781);
    path_8.lineTo(size.width * 0.8865977, size.height * 0.7525781);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.2628867, size.height * 0.9278359);
    path_9.lineTo(size.width * 0.07216406, size.height * 0.9278359);
    path_9.lineTo(size.width * 0.07216406, size.height * 0.7371133);
    path_9.lineTo(size.width * 0.1030937, size.height * 0.7371133);
    path_9.lineTo(size.width * 0.1030937, size.height * 0.8969082);
    path_9.lineTo(size.width * 0.2628867, size.height * 0.8969082);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xffFFFFFF).withOpacity(1.0);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.3041230, size.height * 0.8969082,
            size.width * 0.04123633, size.height * 0.03092773),
        paint_10_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
