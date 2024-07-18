import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter_Foods extends CustomPainter {
  final color_s;

  RPSCustomPainter_Foods(this.color_s);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color_s.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * -0.08333333, size.height * -0.08333333,
                size.width, size.height),
            bottomRight: Radius.circular(size.width * 0.5000000),
            bottomLeft: Radius.circular(size.width * 0.5000000),
            topLeft: Radius.circular(size.width * 0.5000000),
            topRight: Radius.circular(size.width * 0.5000000)),
        paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4166667, 0);
    path_1.cubicTo(size.width * 0.1865446, 0, 0, size.height * 0.1865479, 0,
        size.height * 0.4166667);
    path_1.cubicTo(
        0,
        size.height * 0.6467855,
        size.width * 0.1865446,
        size.height * 0.8333333,
        size.width * 0.4166667,
        size.height * 0.8333333);
    path_1.cubicTo(
        size.width * 0.6467822,
        size.height * 0.8333333,
        size.width * 0.8333333,
        size.height * 0.6467855,
        size.width * 0.8333333,
        size.height * 0.4166667);
    path_1.cubicTo(size.width * 0.8333333, size.height * 0.1865479,
        size.width * 0.6467822, 0, size.width * 0.4166667, 0);
    path_1.close();
    path_1.moveTo(size.width * 0.6179232, size.height * 0.6554720);
    path_1.lineTo(size.width * 0.6179232, size.height * 0.4947070);
    path_1.lineTo(size.width * 0.6179232, size.height * 0.4801595);
    path_1.lineTo(size.width * 0.6179232, size.height * 0.4743441);
    path_1.lineTo(size.width * 0.6179232, size.height * 0.4626237);
    path_1.lineTo(size.width * 0.6179232, size.height * 0.2625863);
    path_1.cubicTo(
        size.width * 0.6179232,
        size.height * 0.2539600,
        size.width * 0.6136003,
        size.height * 0.2459115,
        size.width * 0.6064225,
        size.height * 0.2411393);
    path_1.cubicTo(
        size.width * 0.5998486,
        size.height * 0.2367546,
        size.width * 0.5916781,
        size.height * 0.2356934,
        size.width * 0.5842399,
        size.height * 0.2381087);
    path_1.cubicTo(
        size.width * 0.5835531,
        size.height * 0.2383219,
        size.width * 0.5828727,
        size.height * 0.2385368,
        size.width * 0.5821989,
        size.height * 0.2388118);
    path_1.lineTo(size.width * 0.5138721, size.height * 0.2674202);
    path_1.cubicTo(
        size.width * 0.5056510,
        size.height * 0.2708545,
        size.width * 0.4997965,
        size.height * 0.2782943,
        size.width * 0.4983708,
        size.height * 0.2870866);
    path_1.lineTo(size.width * 0.4807275, size.height * 0.4940592);
    path_1.cubicTo(
        size.width * 0.4795426,
        size.height * 0.5014339,
        size.width * 0.4816048,
        size.height * 0.5089762,
        size.width * 0.4864046,
        size.height * 0.5146989);
    path_1.cubicTo(
        size.width * 0.4911979,
        size.height * 0.5204346,
        size.width * 0.5450114,
        size.height * 0.5675309,
        size.width * 0.5450114,
        size.height * 0.5675309);
    path_1.lineTo(size.width * 0.5450114, size.height * 0.7014779);
    path_1.cubicTo(
        size.width * 0.5058252,
        size.height * 0.7192090,
        size.width * 0.4623991,
        size.height * 0.7291667,
        size.width * 0.4166667,
        size.height * 0.7291667);
    path_1.cubicTo(
        size.width * 0.3903451,
        size.height * 0.7291667,
        size.width * 0.3647933,
        size.height * 0.7258594,
        size.width * 0.3403564,
        size.height * 0.7197038);
    path_1.lineTo(size.width * 0.3403564, size.height * 0.4867057);
    path_1.cubicTo(
        size.width * 0.3471696,
        size.height * 0.4848926,
        size.width * 0.3536035,
        size.height * 0.4826025,
        size.width * 0.3595980,
        size.height * 0.4798844);
    path_1.cubicTo(
        size.width * 0.3712907,
        size.height * 0.4745947,
        size.width * 0.3813232,
        size.height * 0.4678044,
        size.width * 0.3896891,
        size.height * 0.4603662);
    path_1.cubicTo(
        size.width * 0.4022656,
        size.height * 0.4491764,
        size.width * 0.4111344,
        size.height * 0.4366650,
        size.width * 0.4170850,
        size.height * 0.4248796);
    path_1.cubicTo(
        size.width * 0.4200602,
        size.height * 0.4189648,
        size.width * 0.4223112,
        size.height * 0.4132194,
        size.width * 0.4239062,
        size.height * 0.4076530);
    path_1.cubicTo(
        size.width * 0.4247135,
        size.height * 0.4048747,
        size.width * 0.4253434,
        size.height * 0.4021257,
        size.width * 0.4257943,
        size.height * 0.3993457);
    path_1.cubicTo(
        size.width * 0.4262467,
        size.height * 0.3965658,
        size.width * 0.4265316,
        size.height * 0.3937630,
        size.width * 0.4265316,
        size.height * 0.3907292);
    path_1.cubicTo(
        size.width * 0.4265316,
        size.height * 0.3720540,
        size.width * 0.4265316,
        size.height * 0.2626351,
        size.width * 0.4265316,
        size.height * 0.2626351);
    path_1.cubicTo(
        size.width * 0.4265316,
        size.height * 0.2483870,
        size.width * 0.4149788,
        size.height * 0.2368441,
        size.width * 0.4007373,
        size.height * 0.2368441);
    path_1.cubicTo(
        size.width * 0.3864958,
        size.height * 0.2368441,
        size.width * 0.3749561,
        size.height * 0.2483870,
        size.width * 0.3749561,
        size.height * 0.2626351);
    path_1.cubicTo(
        size.width * 0.3749561,
        size.height * 0.2626351,
        size.width * 0.3749561,
        size.height * 0.2643457,
        size.width * 0.3749561,
        size.height * 0.2673812);
    path_1.cubicTo(
        size.width * 0.3749561,
        size.height * 0.2822852,
        size.width * 0.3749561,
        size.height * 0.3291976,
        size.width * 0.3749561,
        size.height * 0.3613851);
    path_1.cubicTo(
        size.width * 0.3749561,
        size.height * 0.3736556,
        size.width * 0.3650000,
        size.height * 0.3836133,
        size.width * 0.3527165,
        size.height * 0.3836133);
    path_1.cubicTo(
        size.width * 0.3404395,
        size.height * 0.3836133,
        size.width * 0.3304899,
        size.height * 0.3736556,
        size.width * 0.3304899,
        size.height * 0.3613851);
    path_1.cubicTo(
        size.width * 0.3304899,
        size.height * 0.3226318,
        size.width * 0.3304899,
        size.height * 0.2644157,
        size.width * 0.3304899,
        size.height * 0.2644157);
    path_1.cubicTo(
        size.width * 0.3304899,
        size.height * 0.2501774,
        size.width * 0.3189372,
        size.height * 0.2386247,
        size.width * 0.3046891,
        size.height * 0.2386247);
    path_1.cubicTo(
        size.width * 0.2904443,
        size.height * 0.2386247,
        size.width * 0.2788949,
        size.height * 0.2501774,
        size.width * 0.2788949,
        size.height * 0.2644157);
    path_1.cubicTo(
        size.width * 0.2788949,
        size.height * 0.2644157,
        size.width * 0.2788949,
        size.height * 0.2661344,
        size.width * 0.2788949,
        size.height * 0.2691553);
    path_1.cubicTo(
        size.width * 0.2788949,
        size.height * 0.2837956,
        size.width * 0.2788949,
        size.height * 0.3292757,
        size.width * 0.2788949,
        size.height * 0.3613851);
    path_1.cubicTo(
        size.width * 0.2788949,
        size.height * 0.3736556,
        size.width * 0.2689437,
        size.height * 0.3836133,
        size.width * 0.2566618,
        size.height * 0.3836133);
    path_1.cubicTo(
        size.width * 0.2443848,
        size.height * 0.3836133,
        size.width * 0.2344352,
        size.height * 0.3736556,
        size.width * 0.2344352,
        size.height * 0.3613851);
    path_1.cubicTo(
        size.width * 0.2344352,
        size.height * 0.3226628,
        size.width * 0.2344352,
        size.height * 0.2626351,
        size.width * 0.2344352,
        size.height * 0.2626351);
    path_1.cubicTo(
        size.width * 0.2344352,
        size.height * 0.2483870,
        size.width * 0.2228890,
        size.height * 0.2368441,
        size.width * 0.2086442,
        size.height * 0.2368441);
    path_1.cubicTo(
        size.width * 0.1943994,
        size.height * 0.2368441,
        size.width * 0.1828467,
        size.height * 0.2483870,
        size.width * 0.1828467,
        size.height * 0.2626351);
    path_1.cubicTo(
        size.width * 0.1828467,
        size.height * 0.2626351,
        size.width * 0.1828467,
        size.height * 0.2643457,
        size.width * 0.1828467,
        size.height * 0.2673812);
    path_1.cubicTo(
        size.width * 0.1828467,
        size.height * 0.2885726,
        size.width * 0.1828467,
        size.height * 0.3743831,
        size.width * 0.1828467,
        size.height * 0.3907292);
    path_1.cubicTo(
        size.width * 0.1828597,
        size.height * 0.3934310,
        size.width * 0.1830762,
        size.height * 0.3959391,
        size.width * 0.1834408,
        size.height * 0.3984163);
    path_1.cubicTo(
        size.width * 0.1841374,
        size.height * 0.4030485,
        size.width * 0.1853190,
        size.height * 0.4076058,
        size.width * 0.1869564,
        size.height * 0.4123454);
    path_1.cubicTo(
        size.width * 0.1898275,
        size.height * 0.4205762,
        size.width * 0.1941113,
        size.height * 0.4292855,
        size.width * 0.2000879,
        size.height * 0.4380827);
    path_1.cubicTo(
        size.width * 0.2045768,
        size.height * 0.4446631,
        size.width * 0.2100244,
        size.height * 0.4512533,
        size.width * 0.2165609,
        size.height * 0.4574935);
    path_1.cubicTo(
        size.width * 0.2263493,
        size.height * 0.4668294,
        size.width * 0.2386361,
        size.height * 0.4753548,
        size.width * 0.2534489,
        size.height * 0.4814714);
    path_1.cubicTo(
        size.width * 0.2583691,
        size.height * 0.4835075,
        size.width * 0.2635824,
        size.height * 0.4852344,
        size.width * 0.2690316,
        size.height * 0.4866813);
    path_1.lineTo(size.width * 0.2690316, size.height * 0.6920101);
    path_1.cubicTo(
        size.width * 0.1709814,
        size.height * 0.6392269,
        size.width * 0.1041667,
        size.height * 0.5356136,
        size.width * 0.1041667,
        size.height * 0.4166667);
    path_1.cubicTo(
        size.width * 0.1041667,
        size.height * 0.2443538,
        size.width * 0.2443506,
        size.height * 0.1041667,
        size.width * 0.4166667,
        size.height * 0.1041667);
    path_1.cubicTo(
        size.width * 0.5889762,
        size.height * 0.1041667,
        size.width * 0.7291667,
        size.height * 0.2443538,
        size.width * 0.7291667,
        size.height * 0.4166667);
    path_1.cubicTo(
        size.width * 0.7291667,
        size.height * 0.5123633,
        size.width * 0.6858854,
        size.height * 0.5981022,
        size.width * 0.6179232,
        size.height * 0.6554720);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
