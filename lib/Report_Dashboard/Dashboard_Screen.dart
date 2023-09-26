import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/main.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import '../Constant/Myconstant.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import 'Dashboard_Screen1.dart';
import 'Dashboard_Screen2.dart';
import 'Dashboard_Screen3.dart';
import 'Dashboard_Screen4.dart';
import 'Dashboard_Screen5.dart';
import 'Dashboard_Screen6.dart';

///
////  คู่มือ  === >>>>> https://help.syncfusion.com/flutter/cartesian-charts/trackball-crosshair#trackball-tooltip-overlap
///
class DashboardScreen extends StatefulWidget {
  final updateMessage;
  const DashboardScreen({super.key, this.updateMessage});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int ser_pang = 0;
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Syncfusion Flutter chart'),
        // ),
        body: Container(
      color: AppbackgroundColor.Abg_Colors,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppbackgroundColor.TiTile_Colors,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'รายงาน ',
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 8,
                        maxFontSize: 20,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ReportScreen_Color.Colors_Text1_,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                      AutoSizeText(
                        ' > > ',
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 8,
                        maxFontSize: 20,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(4.0),
          //       child: Align(
          //         alignment: Alignment.topRight,
          //         child: InkWell(
          //           onTap: () async {
          //             widget.updateMessage(0);
          //           },
          //           child: Container(
          //               width: 130,
          //               padding: const EdgeInsets.all(8.0),
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[900],
          //                 borderRadius: const BorderRadius.only(
          //                     topLeft: Radius.circular(8),
          //                     topRight: Radius.circular(8),
          //                     bottomLeft: Radius.circular(8),
          //                     bottomRight: Radius.circular(8)),
          //                 border: Border.all(color: Colors.white, width: 1),
          //               ),
          //               child: Center(
          //                 child: Text(
          //                   '<<< ย้อนกลับ',
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     fontFamily: FontWeight_.Fonts_T,
          //                   ),
          //                 ),
          //               )),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppbackgroundColor.TiTile_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () async {
                          widget.updateMessage(0);
                        },
                        child: Container(
                            width: 130,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                'รายงาน',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () async {},
                        child: Container(
                            width: 130,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.orange[700],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                'Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          //   child: Container(
          //       decoration: const BoxDecoration(
          //         color: Colors.white30,
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(0),
          //             topRight: Radius.circular(0),
          //             bottomLeft: Radius.circular(10),
          //             bottomRight: Radius.circular(10)),
          //         // border: Border.all(color: Colors.grey, width: 1),
          //       ),
          //       child: Row()),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int index = 0; index < 6; index++)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ser_pang = index;
                              });
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: (ser_pang == index)
                                    ? Colors.black54
                                    : Colors.black26,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: AutoSizeText(
                                  minFontSize: 10,
                                  maxFontSize: 20,
                                  'หน้า ${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          (ser_pang == 0)
              ? Dashboard_Screen1()
              : (ser_pang == 1)
                  ? Dashboard_Screen2()
                  : (ser_pang == 2)
                      ? Dashboard_Screen3()
                      : (ser_pang == 3)
                          ? Dashboard_Screen4()
                          : (ser_pang == 4)
                              ? Dashboard_Screen5()
                              : Dashboard_Screen6()
        ]),
      ),
    ));
  }
}
