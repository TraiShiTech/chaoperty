import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/colors.dart';
import 'Custom_Painter/CustomPainter_Circle.dart';
import 'Custom_Painter/CustomPainter_Crop.dart';
import 'Custom_Painter/CustomPainter_Crop10.dart';
import 'Custom_Painter/CustomPainter_Crop2.dart';
import 'Custom_Painter/CustomPainter_Crop3.dart';
import 'Custom_Painter/CustomPainter_Crop4.dart';
import 'Custom_Painter/CustomPainter_Crop5.dart';
import 'Custom_Painter/CustomPainter_Crop6.dart';
import 'Custom_Painter/CustomPainter_Crop7.dart';
import 'Custom_Painter/CustomPainter_Crop8.dart';
import 'Custom_Painter/CustomPainter_Crop9.dart';
import 'Custom_Painter/CustomPainter_Drink.dart';
import 'Custom_Painter/CustomPainter_Foods.dart';
import 'Custom_Painter/CustomPainter_Map.dart';
import 'Custom_Painter/CustomPainter_Rectangle.dart';
import 'Custom_Painter/CustomPainter_Road1.dart';
import 'Custom_Painter/CustomPainter_Road2.dart';
import 'Custom_Painter/CustomPainter_Road3.dart';
import 'Custom_Painter/CustomPainter_Road4.dart';
import 'Custom_Painter/CustomPainter_Road5.dart';
import 'Custom_Painter/CustomPainter_Road6.dart';
import 'Custom_Painter/CustomPainter_Shop.dart';
import 'Custom_Painter/CustomPainter_Shop2.dart';
import 'Custom_Painter/CustomPainter_Triangle.dart';

Widget TypeNode(context, color, color_text, nodeData, type) {
  if (type.toString() == 'Circle') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Circle(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Rectangle') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Rectangle(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Triangle') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Triangle(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Road1') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Road1(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Road2') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Road2(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Road3') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Road3(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Road4') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Road4(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Road5') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Road5(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Road6') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Road6(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop2') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop2(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop3') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop3(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop4') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop4(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop5') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop5(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop6') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop6(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop7') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop7(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop8') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop8(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop9') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop9(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Crop10') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Crop10(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Shop1') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Shop(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Shop2') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Shop2(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Drink') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Drink(color),
      // painter: RPSCustomPainter_Drink(
      //   brush: Paint()..color = color,
      //   builder: (brush, canvas, rect) {
      //     // Draw triangle
      //     final path = Path()
      //       ..moveTo(rect.left, rect.bottom)
      //       ..lineTo(rect.right, rect.bottom)
      //       ..lineTo(rect.center.dx, rect.top)
      //       ..close();
      //     canvas.drawPath(path, brush);
      //   },
      // ),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else if (type.toString() == 'Map') {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Map(color),
      // painter: RPSCustomPainter_Drink(
      //   brush: Paint()..color = color,
      //   builder: (brush, canvas, rect) {
      //     // Draw triangle
      //     final path = Path()
      //       ..moveTo(rect.left, rect.bottom)
      //       ..lineTo(rect.right, rect.bottom)
      //       ..lineTo(rect.center.dx, rect.top)
      //       ..close();
      //     canvas.drawPath(path, brush);
      //   },
      // ),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  } else {
    return CustomPaint(
      size: Size(
        double.parse(nodeData.width.toString()),
        double.parse(nodeData.height.toString()),
      ),
      painter: RPSCustomPainter_Foods(color),
      child: Center(
          child: Stack(
        children: <Widget>[
          // Stroked text as border.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.blue[700]!,
            ),
          ),
          // Solid text as fill.
          Text(
            nodeData.lncode.toString(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: Font_.Fonts_T,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  }
}
