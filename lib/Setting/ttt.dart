// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easy_table/flutter_easy_table.dart';

import 'package:scroll_pos/scroll_pos.dart';

class Singleimage extends StatefulWidget {
  const Singleimage({
    super.key,
  });

  @override
  State<Singleimage> createState() => _SingleimageState();
}

class _SingleimageState extends State<Singleimage> {
  final ScrollController _controller = ScrollController();
  final double _height = 100.0;

  List tt = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21
  ];
  int t = 0;
  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: () {
          setState(() {
            t = t + 2;
          });
          if (t >= tt.length.toInt()) {
            print('t > tt.length');
            print(tt.length.toInt());
          } else {
            _animateToIndex(t);
            print(t);
          }
        },
      ),
      body: Container(
        height: 300,
        child: ListView.builder(
          controller: _controller,
          itemCount: tt.length,
          itemBuilder: (_, i) {
            return SizedBox(
              height: _height,
              child: Card(
                color: i == 10 ? Colors.blue : null,
                child: Center(child: Text('${tt[i]}')),
              ),
            );
          },
        ),
      ),
    );
  }
}
