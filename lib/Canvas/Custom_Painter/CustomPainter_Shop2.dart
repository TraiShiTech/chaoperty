import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

import 'dart:ui' as ui;
import 'dart:ui' as ui;

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Shop2 extends CustomPainter {
  final color_s;
  RPSCustomPainter_Shop2(this.color_s);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.09667969, size.height * 0.2311523);
    path_0.lineTo(size.width * 0.9074219, size.height * 0.2311523);
    path_0.lineTo(size.width * 0.9074219, size.height * 0.8630859);
    path_0.lineTo(size.width * 0.09667969, size.height * 0.8630859);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9074219, size.height * 0.8718750);
    path_1.lineTo(size.width * 0.09667969, size.height * 0.8718750);
    path_1.cubicTo(
        size.width * 0.09179688,
        size.height * 0.8718750,
        size.width * 0.08789063,
        size.height * 0.8679687,
        size.width * 0.08789063,
        size.height * 0.8630859);
    path_1.lineTo(size.width * 0.08789063, size.height * 0.2311523);
    path_1.cubicTo(
        size.width * 0.08789063,
        size.height * 0.2262695,
        size.width * 0.09179688,
        size.height * 0.2223633,
        size.width * 0.09667969,
        size.height * 0.2223633);
    path_1.lineTo(size.width * 0.9074219, size.height * 0.2223633);
    path_1.cubicTo(
        size.width * 0.9123047,
        size.height * 0.2223633,
        size.width * 0.9162109,
        size.height * 0.2262695,
        size.width * 0.9162109,
        size.height * 0.2311523);
    path_1.lineTo(size.width * 0.9162109, size.height * 0.8630859);
    path_1.cubicTo(
        size.width * 0.9162109,
        size.height * 0.8679687,
        size.width * 0.9122070,
        size.height * 0.8718750,
        size.width * 0.9074219,
        size.height * 0.8718750);
    path_1.close();
    path_1.moveTo(size.width * 0.1054688, size.height * 0.8542969);
    path_1.lineTo(size.width * 0.8986328, size.height * 0.8542969);
    path_1.lineTo(size.width * 0.8986328, size.height * 0.2399414);
    path_1.lineTo(size.width * 0.1054688, size.height * 0.2399414);
    path_1.lineTo(size.width * 0.1054688, size.height * 0.8542969);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff3E4152).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.9853516, size.height * 0.2214844);
    path_2.lineTo(size.width * 0.01875000, size.height * 0.2214844);
    path_2.lineTo(size.width * 0.06386719, size.height * 0.09638672);
    path_2.lineTo(size.width * 0.9402344, size.height * 0.09638672);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffc1d6e2).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9853516, size.height * 0.2302734);
    path_3.lineTo(size.width * 0.01875000, size.height * 0.2302734);
    path_3.cubicTo(
        size.width * 0.01591797,
        size.height * 0.2302734,
        size.width * 0.01318359,
        size.height * 0.2289063,
        size.width * 0.01152344,
        size.height * 0.2265625);
    path_3.cubicTo(
        size.width * 0.009863281,
        size.height * 0.2242187,
        size.width * 0.009472656,
        size.height * 0.2211914,
        size.width * 0.01044922,
        size.height * 0.2185547);
    path_3.lineTo(size.width * 0.05556641, size.height * 0.09335937);
    path_3.cubicTo(
        size.width * 0.05683594,
        size.height * 0.08984375,
        size.width * 0.06015625,
        size.height * 0.08759766,
        size.width * 0.06386719,
        size.height * 0.08759766);
    path_3.lineTo(size.width * 0.9402344, size.height * 0.08759766);
    path_3.cubicTo(
        size.width * 0.9439453,
        size.height * 0.08759766,
        size.width * 0.9472656,
        size.height * 0.08994141,
        size.width * 0.9485352,
        size.height * 0.09335937);
    path_3.lineTo(size.width * 0.9936523, size.height * 0.2184570);
    path_3.cubicTo(
        size.width * 0.9946289,
        size.height * 0.2211914,
        size.width * 0.9942383,
        size.height * 0.2241211,
        size.width * 0.9925781,
        size.height * 0.2264648);
    path_3.cubicTo(
        size.width * 0.9909180,
        size.height * 0.2288086,
        size.width * 0.9881836,
        size.height * 0.2302734,
        size.width * 0.9853516,
        size.height * 0.2302734);
    path_3.close();
    path_3.moveTo(size.width * 0.03125000, size.height * 0.2126953);
    path_3.lineTo(size.width * 0.9728516, size.height * 0.2126953);
    path_3.lineTo(size.width * 0.9340820, size.height * 0.1051758);
    path_3.lineTo(size.width * 0.07001953, size.height * 0.1051758);
    path_3.lineTo(size.width * 0.03125000, size.height * 0.2126953);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff3E4152).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.1860352, size.height * 0.3554688);
    path_4.lineTo(size.width * 0.3721680, size.height * 0.3554688);
    path_4.lineTo(size.width * 0.3721680, size.height * 0.5525391);
    path_4.lineTo(size.width * 0.1860352, size.height * 0.5525391);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffc1d6e2).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.3720703, size.height * 0.5613281);
    path_5.lineTo(size.width * 0.1860352, size.height * 0.5613281);
    path_5.cubicTo(
        size.width * 0.1811523,
        size.height * 0.5613281,
        size.width * 0.1772461,
        size.height * 0.5574219,
        size.width * 0.1772461,
        size.height * 0.5525391);
    path_5.lineTo(size.width * 0.1772461, size.height * 0.3554688);
    path_5.cubicTo(
        size.width * 0.1772461,
        size.height * 0.3505859,
        size.width * 0.1811523,
        size.height * 0.3466797,
        size.width * 0.1860352,
        size.height * 0.3466797);
    path_5.lineTo(size.width * 0.3720703, size.height * 0.3466797);
    path_5.cubicTo(
        size.width * 0.3769531,
        size.height * 0.3466797,
        size.width * 0.3808594,
        size.height * 0.3505859,
        size.width * 0.3808594,
        size.height * 0.3554688);
    path_5.lineTo(size.width * 0.3808594, size.height * 0.5525391);
    path_5.cubicTo(
        size.width * 0.3808594,
        size.height * 0.5574219,
        size.width * 0.3769531,
        size.height * 0.5613281,
        size.width * 0.3720703,
        size.height * 0.5613281);
    path_5.close();
    path_5.moveTo(size.width * 0.1948242, size.height * 0.5437500);
    path_5.lineTo(size.width * 0.3632813, size.height * 0.5437500);
    path_5.lineTo(size.width * 0.3632813, size.height * 0.3642578);
    path_5.lineTo(size.width * 0.1948242, size.height * 0.3642578);
    path_5.lineTo(size.width * 0.1948242, size.height * 0.5437500);
    path_5.close();
    path_5.moveTo(size.width * 0.7967773, size.height * 0.7454102);
    path_5.lineTo(size.width * 0.1860352, size.height * 0.7454102);
    path_5.cubicTo(
        size.width * 0.1811523,
        size.height * 0.7454102,
        size.width * 0.1772461,
        size.height * 0.7415039,
        size.width * 0.1772461,
        size.height * 0.7366211);
    path_5.cubicTo(
        size.width * 0.1772461,
        size.height * 0.7317383,
        size.width * 0.1811523,
        size.height * 0.7278320,
        size.width * 0.1860352,
        size.height * 0.7278320);
    path_5.lineTo(size.width * 0.7967773, size.height * 0.7278320);
    path_5.cubicTo(
        size.width * 0.8016602,
        size.height * 0.7278320,
        size.width * 0.8055664,
        size.height * 0.7317383,
        size.width * 0.8055664,
        size.height * 0.7366211);
    path_5.cubicTo(
        size.width * 0.8055664,
        size.height * 0.7415039,
        size.width * 0.8015625,
        size.height * 0.7454102,
        size.width * 0.7967773,
        size.height * 0.7454102);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xff3E4152).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.5799805, size.height * 0.4671875);
    path_6.arcToPoint(Offset(size.width * 0.6973633, size.height * 0.4671875),
        radius: Radius.elliptical(
            size.width * 0.05869141, size.height * 0.06718750),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.5799805, size.height * 0.4671875),
        radius: Radius.elliptical(
            size.width * 0.05869141, size.height * 0.06718750),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xffc1d6e2).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.6386719, size.height * 0.5431641);
    path_7.cubicTo(
        size.width * 0.6014648,
        size.height * 0.5431641,
        size.width * 0.5711914,
        size.height * 0.5090820,
        size.width * 0.5711914,
        size.height * 0.4671875);
    path_7.cubicTo(
        size.width * 0.5711914,
        size.height * 0.4252930,
        size.width * 0.6014648,
        size.height * 0.3912109,
        size.width * 0.6386719,
        size.height * 0.3912109);
    path_7.cubicTo(
        size.width * 0.6758789,
        size.height * 0.3912109,
        size.width * 0.7061523,
        size.height * 0.4252930,
        size.width * 0.7061523,
        size.height * 0.4671875);
    path_7.cubicTo(
        size.width * 0.7062500,
        size.height * 0.5090820,
        size.width * 0.6759766,
        size.height * 0.5431641,
        size.width * 0.6386719,
        size.height * 0.5431641);
    path_7.close();
    path_7.moveTo(size.width * 0.6386719, size.height * 0.4086914);
    path_7.cubicTo(
        size.width * 0.6111328,
        size.height * 0.4086914,
        size.width * 0.5887695,
        size.height * 0.4348633,
        size.width * 0.5887695,
        size.height * 0.4670898);
    path_7.cubicTo(
        size.width * 0.5887695,
        size.height * 0.4993164,
        size.width * 0.6111328,
        size.height * 0.5254883,
        size.width * 0.6386719,
        size.height * 0.5254883);
    path_7.cubicTo(
        size.width * 0.6662109,
        size.height * 0.5254883,
        size.width * 0.6885742,
        size.height * 0.4993164,
        size.width * 0.6885742,
        size.height * 0.4670898);
    path_7.cubicTo(
        size.width * 0.6885742,
        size.height * 0.4348633,
        size.width * 0.6662109,
        size.height * 0.4086914,
        size.width * 0.6386719,
        size.height * 0.4086914);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xff3E4152).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.6863281, size.height * 0.8996094);
    path_8.lineTo(size.width * 0.5910156, size.height * 0.8996094);
    path_8.lineTo(size.width * 0.5528320, size.height * 0.7068359);
    path_8.lineTo(size.width * 0.5910156, size.height * 0.5471680);
    path_8.lineTo(size.width * 0.6863281, size.height * 0.5471680);
    path_8.lineTo(size.width * 0.7246094, size.height * 0.7065430);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xffc1d6e2).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.6863281, size.height * 0.9083984);
    path_9.lineTo(size.width * 0.5910156, size.height * 0.9083984);
    path_9.cubicTo(
        size.width * 0.5868164,
        size.height * 0.9083984,
        size.width * 0.5832031,
        size.height * 0.9054688,
        size.width * 0.5824219,
        size.height * 0.9012695);
    path_9.lineTo(size.width * 0.5442383, size.height * 0.7083984);
    path_9.cubicTo(
        size.width * 0.5439453,
        size.height * 0.7071289,
        size.width * 0.5440430,
        size.height * 0.7058594,
        size.width * 0.5443359,
        size.height * 0.7046875);
    path_9.lineTo(size.width * 0.5825195, size.height * 0.5450195);
    path_9.cubicTo(
        size.width * 0.5834961,
        size.height * 0.5411133,
        size.width * 0.5870117,
        size.height * 0.5382813,
        size.width * 0.5911133,
        size.height * 0.5382813);
    path_9.lineTo(size.width * 0.6864258, size.height * 0.5382813);
    path_9.cubicTo(
        size.width * 0.6905273,
        size.height * 0.5382813,
        size.width * 0.6940430,
        size.height * 0.5411133,
        size.width * 0.6950195,
        size.height * 0.5450195);
    path_9.lineTo(size.width * 0.7332031, size.height * 0.7043945);
    path_9.cubicTo(
        size.width * 0.7334961,
        size.height * 0.7056641,
        size.width * 0.7334961,
        size.height * 0.7069336,
        size.width * 0.7333008,
        size.height * 0.7081055);
    path_9.lineTo(size.width * 0.6950195, size.height * 0.9013672);
    path_9.cubicTo(
        size.width * 0.6941406,
        size.height * 0.9054688,
        size.width * 0.6905273,
        size.height * 0.9083984,
        size.width * 0.6863281,
        size.height * 0.9083984);
    path_9.close();
    path_9.moveTo(size.width * 0.5982422, size.height * 0.8908203);
    path_9.lineTo(size.width * 0.6791016, size.height * 0.8908203);
    path_9.lineTo(size.width * 0.7155273, size.height * 0.7066406);
    path_9.lineTo(size.width * 0.6793945, size.height * 0.5558594);
    path_9.lineTo(size.width * 0.5979492, size.height * 0.5558594);
    path_9.lineTo(size.width * 0.5618164, size.height * 0.7069336);
    path_9.lineTo(size.width * 0.5982422, size.height * 0.8908203);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff3E4152).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
