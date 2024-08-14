import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:slide_switcher/slide_switcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Constant/Myconstant.dart';
import '../Man_PDF/Man_ChartReport_Generate.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';

class Dashboard_Screen5 extends StatefulWidget {
  const Dashboard_Screen5({super.key});

  @override
  State<Dashboard_Screen5> createState() => _Dashboard_Screen5State();
}

class _Dashboard_Screen5State extends State<Dashboard_Screen5> {
  ChartSeriesController? _chartSeriesController1, _chartSeriesController2;
  final chartKey1 = GlobalKey();
  final chartKey2 = GlobalKey();
  final chartKey3 = GlobalKey();
  final chartKey4 = GlobalKey();
  List<ZoneModel> zoneModels_report = [];
  List<ZoneModel> zoneModels = [];

  List<TeNantModel> teNantModels1 = [];
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<TeNantModel> teNantModels_Cancel = [];
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
  late List<_SalesData> data_tatol_income = [];
  late List<List<_teNantCancelData>> teNant_Cancel;

  List Status = [
    'ปัจจุบัน',
    'หมดสัญญา',
    'ผู้สนใจ',
    'ยกเลิกสัญญา',
  ];
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
      // print(
      //   zoneModels.length,
      // );
    } catch (e) {}
    teNant_Cancel = List.generate(zoneModels_report.length, (_) => []);
  }

  // Future<Null> read_GC_tenant() async {
  //   for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
  //     setState(() {
  //       teNantModels1.clear();
  //     });
  //     var serZone = ' ${zoneModels_report[index1].ser}';
  //     read_GC_tenantSelect1(serZone, index1);
  //   }
  // }

  Future<Null> read_GC_tenant(context1) async {
    setState(() {
      data_tatol_income.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    int total1 = 0;
    int total2 = 0;
    int total3 = 0;
    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      if (index1 == 0) {
        Dialog_(context1);
      } else {}
      setState(() {
        total1 = 0;
        total2 = 0;
        total3 = 0;
      });
      for (int index2 = 0; index2 < Status.length; index2++) {
        // setState(() {
        //   teNantModels1.clear();
        // });

        if (index2 + 1 == 1) {
          String url =
              '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';
          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                TeNantModel teNantModel = TeNantModel.fromJson(map);
                if (teNantModel.quantity == '1') {
                  var daterx = teNantModel.ldate == null
                      ? teNantModel.ldate_q
                      : teNantModel.ldate;

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

                    // print('difference == $difference');

                    var daterx_now = DateTime.now();

                    var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

                    final now = DateTime.now();
                    final earlier =
                        daterx_ldate.subtract(const Duration(days: 0));
                    var daterx_A = now.isAfter(earlier);
                    // print(now.isAfter(earlier)); // true
                    // print(now.isBefore(earlier)); // true

                    if (daterx_A != true) {
                      setState(() {
                        // teNantModels1.add(teNantModel);
                        total1++;
                      });
                    }
                  }
                }
              }
            } else {}

            // setState(() {
            //   data_tatol_income[index1].add(
            //     _SalesData('${zoneModels_report[index1].zn}',
            //         double.parse('${teNantModels1.length}'), 0.00, 0.00),
            //   );
            // });
          } catch (e) {}
        } else if (index2 + 1 == 2) {
          String url =
              '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';

          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                TeNantModel teNantModel = TeNantModel.fromJson(map);
                var daterx = teNantModel.ldate == null
                    ? teNantModel.ldate_q
                    : teNantModel.ldate;

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

                  // print('difference == $difference');

                  var daterx_now = DateTime.now();

                  var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

                  final now = DateTime.now();
                  final earlier =
                      daterx_ldate.subtract(const Duration(days: 0));
                  var daterx_A = now.isAfter(earlier);
                  // print(now.isAfter(earlier)); // true
                  // print(now.isBefore(earlier)); // true

                  if (daterx_A == true) {
                    setState(() {
                      if (teNantModel.quantity == '1') {
                        // teNantModels1.add(teNantModel);
                        total2++;
                      }
                    });
                  }
                }
              }
            } else {}
          } catch (e) {}
        } else if (index2 + 1 == 3) {
          String url =
              '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=${zoneModels_report[index1].ser}';

          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);
            // print(result);
            if (result != null) {
              for (var map in result) {
                TeNantModel teNantModel = TeNantModel.fromJson(map);
                if (teNantModel.quantity == '2' ||
                    teNantModel.quantity == '3') {
                  setState(() {
                    // teNantModels1.add(teNantModel);
                    total3++;
                  });
                }
              }
            } else {}
          } catch (e) {}
        }
      }
      await Future.delayed(const Duration(milliseconds: 100));
      read_GC_tenant_Cancel(index1, total1, total2, total3);

      // setState(() {
      //   data_tatol_income.add(
      //     _SalesData(
      //         '${zoneModels_report[index1].zn}',
      //         double.parse('${total1}'),
      //         double.parse('${total2}'),
      //         double.parse('${total3}'),
      //         0.00),
      //   );
      // });
    }
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context1).pop();
  }

////////////----------------------------------------------------->(รายงาน ข้อมูลผู้เช่า(ยกเลิกสัญญา))

  Future<Null> read_GC_tenant_Cancel(index1, total1, total2, total3) async {
    setState(() {
      teNantModels_Cancel.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_tenant_Cancel_Zone.php?isAdd=true&ren=$ren&ser_zone=${zoneModels_report[index1].ser}';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModelsCancel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels_Cancel.add(teNantModelsCancel);
          });
        }
      } else {}
      // print('result ${teNantModels_Cancel.length}');

      // setState(() {
      //   teNant_Cancel[index1].add(
      //     _teNantCancelData('${zoneModels_report[index1].zn}',
      //         double.parse('${teNantModels_Cancel.length}')),
      //   );
      // });
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        data_tatol_income.add(
          _SalesData(
              '${zoneModels_report[index1].zn}',
              double.parse('${total1}'),
              double.parse('${total2}'),
              double.parse('${total3}'),
              double.parse('${teNantModels_Cancel.length}')),
        );
      });
    } catch (e) {}
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                ' รายงาน ข้อมูลผู้เช่า : ',
                                ReportScreen_Color.Colors_Text2_,
                                TextAlign.center,
                                FontWeight.w500,
                                Font_.Fonts_T,
                                16,
                                1),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                read_GC_tenant(context);
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
                                  child: Center(
                                    child: Translate.TranslateAndSetText(
                                        'ค้นหา',
                                        Colors.white,
                                        TextAlign.center,
                                        FontWeight.w500,
                                        Font_.Fonts_T,
                                        16,
                                        1),
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
                                        format: 'point.y สัญญา',
                                        enable: true,
                                        color: Colors.black54),
                                    markerSettings:
                                        const TrackballMarkerSettings(
                                            markerVisibility:
                                                TrackballVisibilityMode
                                                    .visible),
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
                                  title: ChartTitle(text: 'รายงานผู้เช่า'),
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  // primaryYAxis: NumericAxis(isInversed: false),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'โซน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (สัญญา)',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
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
                                  series: <ChartSeries<_SalesData, String>>[
                                    LineSeries<_SalesData, String>(
                                      color: Colors.green,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status1,
                                      name: '${Status[0]} ',
                                    ),
                                    LineSeries<_SalesData, String>(
                                      color: Colors.orange,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status2,
                                      name: '${Status[1]} ',
                                    ),
                                    LineSeries<_SalesData, String>(
                                      color: Colors.blue,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status3,
                                      name: '${Status[2]} ',
                                    ),
                                    LineSeries<_SalesData, String>(
                                      color: Colors.red,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status4,
                                      name: '${Status[3]} ',
                                    ),
                                  ]))
                          : RepaintBoundary(
                              key: chartKey2,
                              child: SfCartesianChart(
                                  title: ChartTitle(text: 'รายงานผู้เช่า'),
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
                                        format: 'point.y  สัญญา',
                                        enable: true,
                                        color: Colors.black54),
                                    markerSettings:
                                        const TrackballMarkerSettings(
                                            markerVisibility:
                                                TrackballVisibilityMode
                                                    .visible),
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'โซน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (สัญญา)',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
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
                                  series: <ChartSeries<_SalesData, String>>[
                                    ColumnSeries<_SalesData, String>(
                                      color: Colors.green,
                                      trackColor: Colors.green,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status1,
                                      name: '${Status[0]} ',
                                    ),
                                    ColumnSeries<_SalesData, String>(
                                      color: Colors.orange,
                                      trackColor: Colors.orange,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status2,
                                      name: '${Status[1]} ',
                                    ),
                                    ColumnSeries<_SalesData, String>(
                                      color: Colors.blue,
                                      trackColor: Colors.blue,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status3,
                                      name: '${Status[2]} ',
                                    ),
                                    ColumnSeries<_SalesData, String>(
                                      color: Colors.red,
                                      trackColor: Colors.red,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController1 = controller;
                                      },
                                      dataSource: data_tatol_income,
                                      xValueMapper: (_SalesData data, _) =>
                                          data.zone,
                                      yValueMapper: (_SalesData data, _) =>
                                          data.status4,
                                      name: '${Status[3]} ',
                                    ),
                                  ]),
                            ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Align(
                      //         alignment: Alignment.centerRight,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: InkWell(
                      //             onTap: () async {
                      //               if (Visit_1 == '1' || Visit_1 == null) {
                      //                 captureAndConvertToBase64(chartKey1, '');
                      //               } else {
                      //                 captureAndConvertToBase64(chartKey2, '');
                      //               }
                      //             },
                      //             child: Container(
                      //                 width: 120,
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.red[700],
                      //                   borderRadius: const BorderRadius.only(
                      //                       topLeft: Radius.circular(8),
                      //                       topRight: Radius.circular(8),
                      //                       bottomLeft: Radius.circular(8),
                      //                       bottomRight: Radius.circular(8)),
                      //                 ),
                      //                 child: const Center(
                      //                   child: Text(
                      //                     'SAVE(.PNG)',
                      //                     style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontFamily: FontWeight_.Fonts_T,
                      //                     ),
                      //                   ),
                      //                 )),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Visit_1 == '1' || Visit_1 == null) {
                              capture(chartKey1, chartKey3);
                            } else {
                              capture(chartKey2, chartKey4);
                            }
                          },
                          child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green[700],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Translate.TranslateAndSetText(
                                    'พิมพ์',
                                    Colors.white,
                                    TextAlign.center,
                                    FontWeight.w500,
                                    Font_.Fonts_T,
                                    16,
                                    1),
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
    );
  }

  dynamic capture(chartKey01, chartKey02) async {
    final boundary01 =
        chartKey01.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image01 = await boundary01.toImage(
        pixelRatio: 3.0); // Adjust pixelRatio as needed

    // Convert the captured image to bytes
    final byteData01 = await image01.toByteData(format: ImageByteFormat.png);
    final buffer01 = byteData01!.buffer.asUint8List();
/////////------------------------------->

    Man_ChartReport_GeneratePDF.man_chartReport_GeneratePDF(
        context, buffer01, '', '5');
  }
}

class _SalesData {
  _SalesData(this.zone, this.status1, this.status2, this.status3, this.status4);

  final String zone;
  final double status1;
  final double status2;
  final double status3;
  final double status4;
}

class _teNantCancelData {
  _teNantCancelData(this.zone, this.Total);

  final String zone;
  final double Total;
}
