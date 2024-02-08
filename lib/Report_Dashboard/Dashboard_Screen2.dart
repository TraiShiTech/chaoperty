import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart' as html;
import '../Constant/Myconstant.dart';
import '../Man_PDF/Man_ChartReport_Generate.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import 'dart:ui' as ui;

///
////  คู่มือ  === >>>>> https://help.syncfusion.com/flutter/cartesian-charts/trackball-crosshair#trackball-tooltip-overlap
///
class Dashboard_Screen2 extends StatefulWidget {
  const Dashboard_Screen2({super.key});

  @override
  State<Dashboard_Screen2> createState() => _Dashboard_Screen2State();
}

class _Dashboard_Screen2State extends State<Dashboard_Screen2> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<TransReBillModel> _TransReBillModels_Income = [];
  List<dynamic> Total_Incomes = [];
  int tappedIndex = -1; // Index of the exploded slice, initially set to -1
  int ser_pang = 0;
  final chartKey1 = GlobalKey();
  final chartKey2 = GlobalKey();
  final chartKey3 = GlobalKey();
  final chartKey4 = GlobalKey();
  List<String> YE_Th = [];
  String? YE_Income,
      Mon_Income,
      Value_Chang_Zone_Ser_Income,
      Value_Chang_Zone_Income,
      Visit_1,
      Visit_2;
  int currentYear = DateTime.now().year;
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    _cartesianChartKey = GlobalKey();
    for (int i = currentYear; i >= currentYear - 10; i--) {
      YE_Th.add(i.toString());
    }
    super.initState();
    read_GC_zone();
    checkPreferance();

    // red_Trans_billIncome();
  }

  late List<List<_SalesData>> data_tatol_income;
  late List<_SalesData2> data_tatol_income2 = [];
  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var rser = preferences.getString('rser');
    // System_New_Update();
  }

  System_New_Update() async {
    // String accept_ = showst_update_!;
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: const Text(
          '📢ขออภัย !!!!',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/pngegg.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'ขออภัย ขณะนี้ฟังก์ชั่นก์ DashBoard อยู่ในช่วงทดสอบ ..!!!!!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'รับทราบ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

///////////--------------------------------------------->(รายงานรายรับ)
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
      print(result);
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['rser'] = '0';
      map['zn'] = 'ทั้งหมด';
      map['qty'] = '0';
      map['img'] = '0';
      map['data_update'] = '0';

      ZoneModel zoneModelx = ZoneModel.fromJson(map);

      setState(() {
        zoneModels.add(zoneModelx);
      });

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
    } catch (e) {}

    data_tatol_income = List.generate(zoneModels_report.length, (_) => []);
  }

  double cash_total = 0.00;
  double Bank_total = 0.00;
  Future<Null> red_Trans_billIncome(context1) async {
    Total_Incomes.clear();
    setState(() {
      data_tatol_income.clear();
      _TransReBillModels_Income.clear();
      data_tatol_income = List.generate(zoneModels_report.length, (_) => []);
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      if (index1 == 0) {
        Dialog_(context1, index1);
      } else {}
      for (int index2 = 0; index2 < thaiMonthNames.length; index2++) {
        setState(() {
          Total_Incomes.clear();
          Total_Incomes = [];
          _TransReBillModels_Income.clear();
        });
        // print('${zoneModels_report.length}  //  ${thaiMonthNames.length}');
        // print(
        //     '${index2 + 1}mont_h : ${thaiMonthNames[index2]} , YE_Income : $YE_Income , serzone : ${zoneModels_report[index1].ser}');

        String url =
            '${MyConstant().domain}/GC_bill_pay_BC_IncomeDisReport.php?isAdd=true&ren=$ren&mont_h=${index2 + 1}&yea_r=$YE_Income&serzone=${zoneModels_report[index1].ser}';
        //  '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport.php?isAdd=true&ren=$ren&mont_h=${index2 + 1}&yea_r=$YE_Income&serzone=${zoneModels_report[index1].ser}';
        try {
          var response = await http.get(Uri.parse(url));

          var result = json.decode(response.body);

          if (result.toString() != 'null') {
            for (var map in result) {
              TransReBillModel _TransReBillModels_Incomes =
                  TransReBillModel.fromJson(map);

              if (_TransReBillModels_Incomes.total_dis != null) {
                setState(() {
                  _TransReBillModels_Income.add(_TransReBillModels_Incomes);

                  // _TransBillModels.add(_TransBillModel);
                });
              }
            }

            print('result ${_TransReBillModels_Income.length}');
          }
        } catch (e) {}

        await Future.delayed(const Duration(milliseconds: 200));
        setState(() {
          data_tatol_income[index1].add(
            _SalesData(
                '${thaiMonthNames[index2]}',
                double.parse(
                    '${'${(_TransReBillModels_Income.length == 0) ? '0.00' : '${double.parse(_TransReBillModels_Income.fold(
                        0.0,
                        (previousValue, element) =>
                            previousValue +
                            (element.total_dis != null
                                ? double.parse(element.total_dis!)
                                : (element.total_bill == null)
                                    ? 0.00
                                    : double.parse(element.total_bill!)),
                      ).toString())}'}'}')),
          );
        });
      }
      if (index1 + 1 == zoneModels_report.length) {
        await Future.delayed(const Duration(milliseconds: 100));
        Dialog_(context1, index1);
      } else {}
    }
  }

  Future<Null> red_Trans_billIncome_cash_Bank() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    setState(() {
      data_tatol_income2.clear();
    });
    for (int index2 = 0; index2 < thaiMonthNames.length; index2++) {
      setState(() {
        cash_total = 0.00;
        Bank_total = 0.00;
      });
      String url =
          '${MyConstant().domain}/GC_bill_pay_BC_IncomeDisReport_All.php?isAdd=true&ren=$ren&mont_h=${index2 + 1}&yea_r=$YE_Income&serzone=';
      // '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport_All.php?isAdd=true&ren=$ren&mont_h=${index2 + 1}&yea_r=$YE_Income&serzone=';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);

        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillModel _TransReBillModels_Incomes =
                TransReBillModel.fromJson(map);
            if (_TransReBillModels_Incomes.total_dis != null) {
              if (_TransReBillModels_Incomes.type.toString() == 'OP' ||
                  _TransReBillModels_Incomes.type.toString() == 'AC') {
                Bank_total = (_TransReBillModels_Incomes.total_dis != null)
                    ? Bank_total +
                        double.parse('${_TransReBillModels_Incomes.total_dis}')
                    : Bank_total +
                        double.parse(
                            '${_TransReBillModels_Incomes.total_bill}');
              } else if (_TransReBillModels_Incomes.type.toString() == 'CASH') {
                cash_total = (_TransReBillModels_Incomes.total_dis != null)
                    ? cash_total +
                        double.parse('${_TransReBillModels_Incomes.total_dis}')
                    : cash_total +
                        double.parse(
                            '${_TransReBillModels_Incomes.total_bill}');
              }
            }
          }

          print('result ${_TransReBillModels_Income.length}');
        }
      } catch (e) {}
      await Future.delayed(const Duration(milliseconds: 200));

      setState(() {
        data_tatol_income2.add(
          _SalesData2('${thaiMonthNames[index2]}', Bank_total, cash_total),
        );
      });
    }
  }

  Dialog_(context, index1) {
    // if (index1 + 1 == zoneModels_report.length) {
    //   setState(() {
    //     YE_Income = null;
    //   });
    // }
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          if (index1 + 1 == zoneModels_report.length) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {}
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

  String formatTooltip(dynamic dataPoint) {
    final numberFormat = NumberFormat("#,##0", "en_US");
    final formattedValue = numberFormat.format(dataPoint.sales);
    return 'Sales: $formattedValue';
  }

  List<String> thaiMonthNames = [
    'ม.ค.',
    'ก.พ',
    'มี.ค',
    'เม.ย',
    'พ.ค',
    'มิ.ย',
    'ก.ค',
    'ส.ค',
    'ก.ย',
    'ต.ค',
    'พ.ย.',
    'ธ.ค',
  ];

  // List<_SalesData> data = [
  //   _SalesData('${thaiMonthNames[0]}', 35),
  //   _SalesData(thaiMonthNames[1], 28),
  //   _SalesData(thaiMonthNames[2], 34),
  //   _SalesData(thaiMonthNames[3], 32),
  //   _SalesData(thaiMonthNames[4], 40),
  //   _SalesData(thaiMonthNames[5], 50),
  //   _SalesData(thaiMonthNames[6], 45),
  //   _SalesData(thaiMonthNames[7], 55),
  //   _SalesData(thaiMonthNames[8], 48),
  //   _SalesData(thaiMonthNames[9], 52),
  //   _SalesData(thaiMonthNames[10], 60),
  //   _SalesData(thaiMonthNames[11], 58),
  // ];
  // List<_SalesData> data = [
  //   _SalesData('มกราคม', 5000),
  //   _SalesData('กุมภาพันธ์', 28),
  //   _SalesData('มีนาคม', 50),
  //   _SalesData('เมษายน', 32),
  //   _SalesData('พฤษภาคม', 500),
  //   _SalesData('มิถุนายน', 50), // Add data for June
  //   _SalesData('กรกฎาคม', 10), // Add data for July
  //   _SalesData('สิงหาคม', 55), // Add data for August
  //   _SalesData('กันยายน', 215), // Add data for September
  //   _SalesData('ตุลาคม', 100), // Add data for October
  //   _SalesData('พฤศจิกายน', 60), // Add data for November
  //   _SalesData('ธันวาคม', 1274), // Add data for December
  // ];
//https://support.syncfusion.com/kb/article/10649/how-to-create-excel-charts-in-an-excel-programmatically-in-flutter
//https://www.syncfusion.com/flutter-widgets/flutter-charts/chart-types/pie-chart?utm_source=pubdev&utm_medium=listing&utm_campaign=flutter-charts-pubdev

  ChartSeriesController? _chartSeriesController1,
      _chartSeriesController2,
      _chartSeriesController3,
      _chartSeriesController4;
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
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [

              //       ],
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
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
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงาน รายรับ (เฉพาะรายการที่มีส่วนลด): ',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ปี :',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              ),
                              Padding(
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
                                  width: 120,
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField2(
                                    alignment: Alignment.center,
                                    focusColor: Colors.white,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.center,
                                      enabled: true,
                                      hoverColor: Colors.brown,
                                      prefixIconColor: Colors.blue,
                                      fillColor: Colors.white.withOpacity(0.05),
                                      filled: false,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 231, 227, 227),
                                        ),
                                      ),
                                    ),
                                    isExpanded: false,
                                    value: YE_Income,
                                    // hint: Text(
                                    //   YE_Income == null ? 'เลือก' : '$YE_Income',
                                    //   maxLines: 2,
                                    //   textAlign: TextAlign.center,
                                    //   style: const TextStyle(
                                    //     overflow: TextOverflow.ellipsis,
                                    //     fontSize: 14,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    iconSize: 20,
                                    buttonHeight: 40,
                                    buttonWidth: 200,
                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      // color: Colors
                                      //     .amber,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    items: YE_Th.map((item) =>
                                        DropdownMenuItem<String>(
                                          value: '${item}',
                                          child: Text(
                                            '${item}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )).toList(),

                                    onChanged: (value) async {
                                      YE_Income = value;

                                      // if (Value_Chang_Zone_Income != null) {
                                      //   red_Trans_billIncome();
                                      //   // red_Trans_billMovemen();
                                      // }
                                    },
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (YE_Income == null) {
                                  } else {
                                    red_Trans_billIncome(context);
                                    red_Trans_billIncome_cash_Bank();
                                  }
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
                            ],
                          ),
                        ),
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
                                        format: 'point.y ',
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
                                  title: ChartTitle(
                                      text: (YE_Income == null)
                                          ? 'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด)'
                                          : 'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด) $YE_Income'),
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  // primaryYAxis: NumericAxis(isInversed: false),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'เดือน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (บาท)',
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
                                    for (int index = 0;
                                        index < data_tatol_income.length;
                                        index++)
                                      LineSeries<_SalesData, String>(
                                        // color: Colors.green,
                                        animationDuration: 100,
                                        onRendererCreated:
                                            (ChartSeriesController controller) {
                                          _chartSeriesController1 = controller;
                                        },
                                        dataSource: data_tatol_income[index],
                                        xValueMapper: (_SalesData data, _) =>
                                            data.monts,
                                        yValueMapper: (_SalesData data, _) =>
                                            data.sales,
                                        name: '${zoneModels_report[index].zn}',
                                      ),
                                    // LineSeries<_SalesData, String>(
                                    //   animationDuration: 2000,
                                    //   dataSource: data_tatol_income[index],
                                    //   xValueMapper: (_SalesData sales, _) =>
                                    //       sales.monts,
                                    //   yValueMapper: (_SalesData sales, _) =>
                                    //       sales.sales,
                                    //   name: '${zoneModels_report[index].zn}',
                                    //   onRendererCreated:
                                    //       (ChartSeriesController controller) {
                                    //     _chartSeriesController1 = controller;
                                    //   },
                                    //   emptyPointSettings: EmptyPointSettings(
                                    //       mode: EmptyPointMode.average),
                                    //   dataLabelSettings: DataLabelSettings(
                                    //       labelIntersectAction:
                                    //           LabelIntersectAction.shift,
                                    //       isVisible: true,
                                    //       textStyle: TextStyle(
                                    //           color: Colors.deepPurple)),
                                    //   yAxisName: 'yAxis1',
                                    //   markerSettings:
                                    //       MarkerSettings(isVisible: true),
                                    // ),
                                  ]))
                          : RepaintBoundary(
                              key: chartKey2,
                              child: SfCartesianChart(
                                  title: ChartTitle(
                                      text: (YE_Income == null)
                                          ? 'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด)'
                                          : 'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด) $YE_Income'),
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
                                        format: 'point.y ',
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
                                        text: 'เดือน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (บาท)',
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
                                    for (int index = 0;
                                        index < data_tatol_income.length;
                                        index++)
                                      ColumnSeries<_SalesData, String>(
                                        animationDuration: 100,
                                        onRendererCreated:
                                            (ChartSeriesController controller) {
                                          _chartSeriesController2 = controller;
                                        },
                                        dataSource: data_tatol_income[index],
                                        xValueMapper: (_SalesData data, _) =>
                                            data.monts,
                                        yValueMapper: (_SalesData data, _) =>
                                            data.sales,
                                        name: '${zoneModels_report[index].zn}',
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
///////////--------------------------------------------------------------->

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.green[50]!.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      (Visit_1 == '1' || Visit_1 == null)
                          ? RepaintBoundary(
                              key: chartKey3,
                              child: SfCartesianChart(
                                  trackballBehavior: TrackballBehavior(
                                    activationMode: ActivationMode.singleTap,
                                    enable: true,
                                    tooltipDisplayMode:
                                        TrackballDisplayMode.groupAllPoints,
                                    tooltipSettings: const InteractiveTooltip(
                                        format: 'point.y ',
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
                                  title: ChartTitle(
                                      text: (YE_Income == null)
                                          ? 'รายงานรายรับ cash/bank (เฉพาะรายการที่มีส่วนลด)'
                                          : 'รายงานรายรับ cash/bank (เฉพาะรายการที่มีส่วนลด) $YE_Income'),
                                  legend: Legend(
                                      isVisible: true,
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  // primaryYAxis: NumericAxis(isInversed: false),
                                  primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'เดือน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (บาท)',
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
                                  series: <ChartSeries<_SalesData2, String>>[
                                    LineSeries<_SalesData2, String>(
                                      color: Colors.green,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController3 = controller;
                                      },
                                      dataSource: data_tatol_income2,
                                      xValueMapper: (_SalesData2 data, _) =>
                                          data.monts,
                                      yValueMapper: (_SalesData2 data, _) =>
                                          data.cash,
                                      name: 'cash',
                                    ),
                                    LineSeries<_SalesData2, String>(
                                      color: Colors.blue,
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController3 = controller;
                                      },
                                      dataSource: data_tatol_income2,
                                      xValueMapper: (_SalesData2 data, _) =>
                                          data.monts,
                                      yValueMapper: (_SalesData2 data, _) =>
                                          data.bank,
                                      name: 'bank',
                                    ),
                                    // LineSeries<_SalesData, String>(
                                    //   animationDuration: 2000,
                                    //   dataSource: data_tatol_income[index],
                                    //   xValueMapper: (_SalesData sales, _) =>
                                    //       sales.monts,
                                    //   yValueMapper: (_SalesData sales, _) =>
                                    //       sales.sales,
                                    //   name: '${zoneModels_report[index].zn}',
                                    //   onRendererCreated:
                                    //       (ChartSeriesController controller) {
                                    //     _chartSeriesController1 = controller;
                                    //   },
                                    //   emptyPointSettings: EmptyPointSettings(
                                    //       mode: EmptyPointMode.average),
                                    //   dataLabelSettings: DataLabelSettings(
                                    //       labelIntersectAction:
                                    //           LabelIntersectAction.shift,
                                    //       isVisible: true,
                                    //       textStyle: TextStyle(
                                    //           color: Colors.deepPurple)),
                                    //   yAxisName: 'yAxis1',
                                    //   markerSettings:
                                    //       MarkerSettings(isVisible: true),
                                    // ),
                                  ]))
                          : RepaintBoundary(
                              key: chartKey4,
                              child: SfCartesianChart(
                                  key: _cartesianChartKey,
                                  title: ChartTitle(
                                      text: (YE_Income == null)
                                          ? 'รายงานรายรับ cash/bank (เฉพาะรายการที่มีส่วนลด)'
                                          : 'รายงานรายรับ cash/bank (เฉพาะรายการที่มีส่วนลด) $YE_Income'),
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
                                        format: 'point.y ',
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
                                        text: 'เดือน',
                                        textStyle:
                                            const TextStyle(fontSize: 16)),
                                    labelStyle: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                        text: 'หน่วย (บาท)',
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
                                  series: <ChartSeries<_SalesData2, String>>[
                                    ColumnSeries<_SalesData2, String>(
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController4 = controller;
                                      },
                                      dataSource: data_tatol_income2,
                                      xValueMapper: (_SalesData2 data, _) =>
                                          data.monts,
                                      yValueMapper: (_SalesData2 data, _) =>
                                          data.cash,
                                      name: 'cash',
                                    ),
                                    ColumnSeries<_SalesData2, String>(
                                      animationDuration: 100,
                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController4 = controller;
                                      },
                                      dataSource: data_tatol_income2,
                                      xValueMapper: (_SalesData2 data, _) =>
                                          data.monts,
                                      yValueMapper: (_SalesData2 data, _) =>
                                          data.bank,
                                      name: 'bank',
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
                      //                 captureAndConvertToBase64(chartKey3, '');
                      //               } else {
                      //                 captureAndConvertToBase64(chartKey4, '');
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
                              child: const Center(
                                child: Text(
                                  'พิมพ์',
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
    );
  }

  late GlobalKey<SfCartesianChartState> _cartesianChartKey;
  dynamic capture(chartKey01, chartKey02) async {
    final boundary01 =
        chartKey01.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image01 = await boundary01.toImage(
        pixelRatio: 3.0); // Adjust pixelRatio as needed

    // Convert the captured image to bytes
    final byteData01 = await image01.toByteData(format: ImageByteFormat.png);
    final buffer01 = byteData01!.buffer.asUint8List();
/////////------------------------------->
    final boundary02 =
        chartKey02.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image02 = await boundary02.toImage(
        pixelRatio: 3.0); // Adjust pixelRatio as needed

    // Convert the captured image to bytes
    final byteData02 = await image02.toByteData(format: ImageByteFormat.png);
    final buffer02 = byteData02!.buffer.asUint8List();

    // generatePDF(buffer01, buffer02);

    Man_ChartReport_GeneratePDF.man_chartReport_GeneratePDF(
        context, buffer01, buffer02, '2');
  }
}

class _SalesData {
  _SalesData(this.monts, this.sales);

  final String monts;
  final double sales;
}

class _SalesData2 {
  _SalesData2(this.monts, this.bank, this.cash);

  final String monts;
  final double bank;
  final double cash;
}
