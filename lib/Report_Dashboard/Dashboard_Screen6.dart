import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:slide_switcher/slide_switcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';

class Dashboard_Screen6 extends StatefulWidget {
  const Dashboard_Screen6({super.key});

  @override
  State<Dashboard_Screen6> createState() => _Dashboard_Screen6State();
}

class _Dashboard_Screen6State extends State<Dashboard_Screen6> {
  ChartSeriesController? _chartSeriesController1, _chartSeriesController2;
  final chartKey1 = GlobalKey();
  final chartKey2 = GlobalKey();
  final chartKey3 = GlobalKey();
  final chartKey4 = GlobalKey();
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<ZoneModel> zoneModels_report = [];
  List<ZoneModel> zoneModels = [];
  List<AreaModel> areaModels = [];
  String? renTal_user,
      renTal_name,
      Status_pe,
      Status_pe_ser,
      Value_Chang_Zone_People,
      Value_Chang_Zone_People_Ser,
      Value_Chang_Zone_People_Cancel,
      Value_Chang_Zone_People_Ser_Cancel,
      Visit_1,
      Visit_2;

  List Status = [
    'ใกล้หมดสัญญา',
    'เสนอราคา',
    'ว่าง',
    'เช่าอยู่',
  ];
  late List<_areaData> data_tatol_area = [];
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
  }

  /////////------------------------------------------------------------->
  Future<Null> checkPreferance() async {
    int currentYear = DateTime.now().year;
    for (int i = currentYear; i >= currentYear - 10; i--) {
      YE_Th.add(i.toString());
    }
    for (int i2 = 0; i2 < 12; i2++) {
      Mont_Th.add('${i2 + 1}');
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
    // System_New_Update();
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      // Map<String, dynamic> map = Map();
      // map['ser'] = '0';
      // map['rser'] = '0';
      // map['zn'] = 'ทั้งหมด';
      // map['qty'] = '0';
      // map['img'] = '0';
      // map['data_update'] = '0';

      // ZoneModel zoneModelx = ZoneModel.fromJson(map);

      // setState(() {
      //   zoneModels.add(zoneModelx);
      // });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
          zoneModels_report.add(zoneModel);
        });
      }
      zoneModels_report.sort((a, b) => a.zn!.compareTo(b.zn!));
      zoneModels.sort((a, b) {
        if (a.zn == 'ทั้งหมด') {
          return -1; // 'all' should come before other elements
        } else if (b.zn == 'ทั้งหมด') {
          return 1; // 'all' should come after other elements
        } else {
          return a.zn!
              .compareTo(b.zn!); // sort other elements in ascending order
        }
      });
      print(
        zoneModels.length,
      );
    } catch (e) {}
  }

  //////////------------------------------------------------------->(รายงาน ข้อมูลพื้นที่เช่า)

  Future<Null> read_GC_areaSelect(context1) async {
    setState(() {
      areaModels.clear();
      data_tatol_area.clear;
      data_tatol_area = [];
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    int total1 = 0;
    int total2 = 0;
    int total3 = 0;
    int total4 = 0;
    int total5 = 0;
    int total6 = 0;
    int total7 = 0;
    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      if (index1 == 0) {
        Dialog_(context1);
      } else {}
      setState(() {
        total1 = 0;
        total2 = 0;
        total3 = 0;
        total4 = 0;
        total5 = 0;
        total6 = 0;
        total7 = 0;
      });
      for (int index2 = 0; index2 < Status.length; index2++) {
        if (index2 + 1 == 1) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';
          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                setState(() {
                  total1++;
                  // areaModels.add(areaModel);
                });
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 2) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';

          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                var daterx = areaModel.ldate;

                if (daterx != null) {
                  int daysBetween(DateTime from, DateTime to) {
                    from = DateTime(from.year, from.month, from.day);
                    to = DateTime(to.year, to.month, to.day);
                    return (to.difference(from).inHours / 24).round();
                  }

                  var birthday = DateTime.parse('$daterx 00:00:00.000')
                      .add(const Duration(days: -30));
                  var date2 = DateTime.now();
                  var difference = daysBetween(birthday, date2);

                  print('difference == $difference');

                  if (difference < 30 && difference > 0) {
                    setState(() {
                      total2++;
                      // areaModels.add(areaModel);
                    });
                  }
                }
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 3) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';

          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                if (areaModel.quantity == '2' || areaModel.quantity == '3') {
                  setState(() {
                    total3++;
                    // areaModels.add(areaModel);
                  });
                }
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 4) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';

          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                if (areaModel.quantity == null) {
                  setState(() {
                    total4++;
                    // areaModels.add(areaModel);
                  });
                }
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 5) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';
          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                if (int.parse(areaModel.quantity!) == 1) {
                  setState(() {
                    total5++;
                    // areaModels.add(areaModel);
                  });
                }
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 6) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';
          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                if (areaModel.quantity != '1') {
                  setState(() {
                    total6++;
                    // areaModels.add(areaModel);
                  });
                }
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 7) {
          String url =
              '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';

          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                AreaModel areaModel = AreaModel.fromJson(map);
                if (areaModel.quantity == '1' || areaModel.quantity == null) {
                  setState(() {
                    total7++;
                    // areaModels.add(areaModel);
                  });
                }
              }
            } else {}
          } catch (e) {}
        }
      }
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        data_tatol_area.add(
          _areaData(
              '${zoneModels_report[index1].zn}',
              double.parse('${total1}'),
              double.parse('${total2}'),
              double.parse('${total3}'),
              double.parse('${total4}'),
              double.parse('${total5}'),
              double.parse('${total6}'),
              double.parse('${total7}')),
        );
      });
    }
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context1).pop();
  }

  Dialog_(context) {
    // if (index1 + 1 == zoneModels_report.length) {
    //   setState(() {
    //     YE_Income = null;
    //   });
    // }
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          // Future.delayed(
          //     const Duration(
          //         seconds:
          //             1),
          //     () {
          //   Navigator.of(
          //           context)
          //       .pop();
          // });
          return Dialog(
            child: SizedBox(
              height: 20,
              width: 80,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  "images/gif-LOGOchao.gif",
                  fit: BoxFit.cover,
                  height: 20,
                  width: 80,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.TiTile_Colors,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงาน ข้อมูลพื้นที่เช่า : ',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                read_GC_areaSelect(context);
                              },
                              child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green[700],
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'ค้นหา',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            AppbackgroundColor.TiTile_Colors.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: SlideSwitcher(
                                    containerBorder: Border.all(
                                        color: Colors.grey, width: 1),
                                    slidersColors: [Colors.white],
                                    containerBorderRadius: 10,
                                    onSelect: (index) async {
                                      setState(() {
                                        // switcherIndex1 = index;
                                        setState(() {
                                          Visit_1 = '${index + 1}';
                                        });
                                      });
                                    },
                                    containerHeight: 35,
                                    containerWight: 100,
                                    containerColor: Colors.grey,
                                    children: [
                                      Icon(
                                        Icons.line_axis,
                                        color: (Visit_1 == '1')
                                            ? Colors.blue[900]
                                            : Colors.black,
                                      ),
                                      Icon(
                                        Icons.view_column,
                                        color: (Visit_1 == '2')
                                            ? Colors.blue[900]
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.green[50]!.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      (Visit_1 == '1' || Visit_1 == null)
                          ? RepaintBoundary(
                              key: chartKey1,
                              child: SfCartesianChart(
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                    tooltipDisplayMode:
                                        TrackballDisplayMode.groupAllPoints,
                                    tooltipSettings: const InteractiveTooltip(
                                        format: 'point.y พื้นที่',
                                        enable: true,
                                        color: Colors.black54),
                                    markerSettings: const TrackballMarkerSettings(
                                        markerVisibility:
                                            TrackballVisibilityMode.visible),
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enableMouseWheelZooming: true,
                                      maximumZoomLevel: 0.5,
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x,
                                      enablePanning: true,
                                      enableSelectionZooming: true,
                                      enableDoubleTapZooming: true),
                                  // trackballBehavior: TrackballBehavior(),
                                  title: ChartTitle(text: 'รายงานพื้นที่เช่า'),
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  // primaryYAxis: NumericAxis(isInversed: false),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'โซน',
                                        textStyle: const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (พื้นที่)',
                                        textStyle: const TextStyle(fontSize: 16)),
                                    numberFormat: NumberFormat.compact(),
                                    isInversed: false,
                                    //  interval: 1000,
                                    minimum: 0,
                                    isVisible:
                                        true, // Set isVisible to false to hide the left y-axis   116
                                  ),
                                  // axes: <ChartAxis>[
                                  //   NumericAxis(
                                  //       numberFormat: NumberFormat.compact(),
                                  //       majorGridLines: const MajorGridLines(width: 0),
                                  //       opposedPosition: true,
                                  //       name: 'yAxis1',
                                  //       interval: 1000,
                                  //       minimum: 0,
                                  //       labelAlignment: LabelAlignment.start
                                  //       // maximum: 1000000
                                  //       ),
                                  // ],
                                  series: <ChartSeries<_areaData, String>>[
                                    LineSeries<_areaData, String>(
                                      color: Colors.green,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status1,
                                      name: '${Status[0]} ',
                                    ),
                                    LineSeries<_areaData, String>(
                                      color: Colors.orange,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status2,
                                      name: '${Status[1]} ',
                                    ),
                                    LineSeries<_areaData, String>(
                                      color: Colors.blue,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status3,
                                      name: '${Status[2]} ',
                                    ),
                                    LineSeries<_areaData, String>(
                                      color: Colors.red,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status4,
                                      name: '${Status[3]} ',
                                    ),
                                  ]))
                          : RepaintBoundary(
                              key: chartKey2,
                              child: SfCartesianChart(
                                  title: ChartTitle(text: 'รายงานพื้นที่เช่า'),
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enableMouseWheelZooming: true,
                                      maximumZoomLevel: 0.05,
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x,
                                      enablePanning: true,
                                      enableSelectionZooming: true,
                                      enableDoubleTapZooming: true),
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                    tooltipDisplayMode:
                                        TrackballDisplayMode.groupAllPoints,
                                    tooltipSettings: const InteractiveTooltip(
                                        format: 'point.y  พื้นที่',
                                        enable: true,
                                        color: Colors.black54),
                                    markerSettings: const TrackballMarkerSettings(
                                        markerVisibility:
                                            TrackballVisibilityMode.visible),
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'โซน',
                                        textStyle: const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (พื้นที่)',
                                        textStyle: const TextStyle(fontSize: 16)),
                                    numberFormat: NumberFormat.compact(),
                                    isInversed: false,
                                    //  interval: 1000,
                                    minimum: 0,
                                    isVisible:
                                        true, // Set isVisible to false to hide the left y-axis   116
                                  ),
                                  // axes: <ChartAxis>[
                                  //   NumericAxis(
                                  //     numberFormat: NumberFormat.compact(),
                                  //     majorGridLines: const MajorGridLines(width: 0),
                                  //     opposedPosition: true,
                                  //     name: 'yAxis1',
                                  //     interval: 10,
                                  //     minimum: 0,
                                  //   )
                                  // ],
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  series: <ChartSeries<_areaData, String>>[
                                    ColumnSeries<_areaData, String>(
                                      color: Colors.green,
                                      trackColor: Colors.green,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status1,
                                      name: '${Status[0]} ',
                                    ),
                                    ColumnSeries<_areaData, String>(
                                      color: Colors.orange,
                                      trackColor: Colors.orange,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status2,
                                      name: '${Status[1]} ',
                                    ),
                                    ColumnSeries<_areaData, String>(
                                      color: Colors.blue,
                                      trackColor: Colors.blue,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status3,
                                      name: '${Status[2]} ',
                                    ),
                                    ColumnSeries<_areaData, String>(
                                      color: Colors.red,
                                      trackColor: Colors.red,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_area,
                                      xValueMapper: (_areaData data, _) =>
                                          data.zone,
                                      yValueMapper: (_areaData data, _) =>
                                          data.status4,
                                      name: '${Status[3]} ',
                                    ),
                                  ]),
                            ),
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (Visit_1 == '1' || Visit_1 == null) {
                                      captureAndConvertToBase64(chartKey1, '');
                                    } else {
                                      captureAndConvertToBase64(chartKey2, '');
                                    }
                                  },
                                  child: Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red[700],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'SAVE(.PNG)',
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]))));
  }
}

class _areaData {
  _areaData(this.zone, this.status1, this.status2, this.status3, this.status4,
      this.status5, this.status6, this.status7);

  final String zone;
  final double status1;
  final double status2;
  final double status3;
  final double status4;
  final double status5;
  final double status6;
  final double status7;
}
