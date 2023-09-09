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

class DashboardScreen extends StatefulWidget {
  final updateMessage;
  const DashboardScreen({super.key, this.updateMessage});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<TransReBillModel> _TransReBillModels_Income = [];
  List<dynamic> Total_Incomes = [];
  int tappedIndex = -1; // Index of the exploded slice, initially set to -1

  final chartKey1 = GlobalKey();
  final chartKey2 = GlobalKey();
  List<String> YE_Th = [];
  String? YE_Income,
      Mon_Income,
      Value_Chang_Zone_Ser_Income,
      Value_Chang_Zone_Income;
  int currentYear = DateTime.now().year;
  @override
  void initState() {
    for (int i = currentYear; i >= currentYear - 10; i--) {
      YE_Th.add(i.toString());
    }
    super.initState();
    read_GC_zone();
    checkPreferance();

    // red_Trans_billIncome();
  }

  late List<List<_SalesData>> data_tatol_income;

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var rser = preferences.getString('rser');
    System_New_Update();
  }

  System_New_Update() async {
    // String accept_ = showst_update_!;
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(
          '📢ขออภัย !!!!',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("images/pngegg.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
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

  Future<Null> red_Trans_billIncome() async {
    Total_Incomes.clear();
    if (_TransReBillModels_Income.length != 0) {
      setState(() {
        _TransReBillModels_Income.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    if (Value_Chang_Zone_Ser_Income.toString() == '0' &&
        Mon_Income.toString() == '0') {
      for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
        for (int index2 = 0; index2 < thaiMonthNames.length; index2++) {
          Total_Incomes.clear();
          if (_TransReBillModels_Income.length != 0) {
            setState(() {
              _TransReBillModels_Income.clear();
            });
          }
          print('${zoneModels_report.length}  //  ${thaiMonthNames.length}');
          print(
              '${index2 + 1}mont_h : ${thaiMonthNames[index2]} , YE_Income : $YE_Income , serzone : ${zoneModels_report[index1].ser}');

          String url =
              '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport.php?isAdd=true&ren=$ren&mont_h=${index2 + 1}&yea_r=$YE_Income&serzone=${zoneModels_report[index1].ser}';
          try {
            var response = await http.get(Uri.parse(url));

            var result = json.decode(response.body);

            if (result.toString() != 'null') {
              for (var map in result) {
                TransReBillModel _TransReBillModels_Incomes =
                    TransReBillModel.fromJson(map);
                setState(() {
                  _TransReBillModels_Income.add(_TransReBillModels_Incomes);
                });
              }

              print('result ${_TransReBillModels_Income.length}');
            }
          } catch (e) {}

          await Future.delayed(Duration(milliseconds: 200));
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
                                  : double.parse(element.total_bill!)),
                        ).toString())}'}'}')),
            );
          });
        }
      }

      // String url =
      //     '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=${zoneModels_report[index].ser}';
      // try {
      //   var response = await http.get(Uri.parse(url));

      //   var result = json.decode(response.body);

      //   if (result.toString() != 'null') {
      //     for (var map in result) {
      //       TransReBillModel _TransReBillModels_Incomes =
      //           TransReBillModel.fromJson(map);
      //       setState(() {
      //         _TransReBillModels_Income.add(_TransReBillModels_Incomes);
      //       });
      //     }

      //     print('result ${_TransReBillModels_Income.length}');
      //   }
      // } catch (e) {}
      // Total_Incomes.add(
      //     '${(_TransReBillModels_Income.length == 0) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
      //         0.0,
      //         (previousValue, element) =>
      //             previousValue +
      //             (element.total_dis != null
      //                 ? double.parse(element.total_dis!)
      //                 : double.parse(element.total_bill!)),
      //       ).toString()))}'}'
      // );
    } else {
      String url =
          '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);

        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillModel _TransReBillModels_Incomes =
                TransReBillModel.fromJson(map);
            setState(() {
              _TransReBillModels_Income.add(_TransReBillModels_Incomes);
            });
          }

          print('result ${_TransReBillModels_Income.length}');
        }
      } catch (e) {}
      Total_Incomes.add(
          '${(_TransReBillModels_Income.length == 0) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  (element.total_dis != null
                      ? double.parse(element.total_dis!)
                      : double.parse(element.total_bill!)),
            ).toString()))}'}');
    }
  }

///////////--------------------------------------------->(รายงานรายรับ)
  // Future<Null> red_Trans_selectIncome() async {
  //   for (int index = 0; index < _TransReBillModels_Income.length; index++) {
  //     if (_TransReBillHistoryModels_Income.length != 0) {
  //       setState(() {
  //         _TransReBillHistoryModels_Income.clear();
  //       });
  //     }
  //     if (TransReBillModels_Income[index].length != 0) {
  //       TransReBillModels_Income[index].clear();
  //     }

  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     var ren = preferences.getString('renTalSer');
  //     var user = preferences.getString('ser');
  //     var ciddoc = _TransReBillModels_Income[index].ser;
  //     var qutser = _TransReBillModels_Income[index].ser_in;
  //     var docnoin = (_TransReBillModels_Income[index].docno == null)
  //         ? _TransReBillModels_Income[index].refno
  //         : _TransReBillModels_Income[index].docno;
  //     String url =
  //         '${MyConstant().domain}/GC_bill_pay_history_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
  //     try {
  //       var response = await http.get(Uri.parse(url));

  //       var result = json.decode(response.body);
  //       print(result);
  //       if (result.toString() != 'null') {
  //         for (var map in result) {
  //           TransReBillHistoryModel _TransReBillHistoryModels_Incomes =
  //               TransReBillHistoryModel.fromJson(map);

  //           var numinvoiceent = _TransReBillHistoryModels_Incomes.docno;
  //           setState(() {
  //             _TransReBillHistoryModels_Income.add(
  //                 _TransReBillHistoryModels_Incomes);
  //             TransReBillModels_Income[index]
  //                 .add(_TransReBillHistoryModels_Incomes);
  //           });
  //         }
  //         // PDf_AdddataList_bill_Income();
  //       }
  //       // setState(() {
  //       //   red_Invoice();
  //       // });
  //     } catch (e) {}
  //   }
  // }
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

  ChartSeriesController? _chartSeriesController1, _chartSeriesController2;
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Syncfusion Flutter chart'),
        // ),
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
                  child: Row(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                mainAxisAlignment: MainAxisAlignment.end,
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
                              color: Colors.grey[900],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                'ย้อนกลับ',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'เดือน :',
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
                      width: 150,
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField2(
                        alignment: Alignment.center,
                        focusColor: Colors.white,
                        autofocus: false,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          enabled: true,
                          hoverColor: Colors.brown,
                          prefixIconColor: Colors.blue,
                          fillColor: Colors.white.withOpacity(0.05),
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
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
                              color: Color.fromARGB(255, 231, 227, 227),
                            ),
                          ),
                        ),
                        isExpanded: false,
                        hint: Text(
                          Mon_Income == null ? 'เลือก' : '$Mon_Income',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
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
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        items: [
                          for (int item = 0; item < 13; item++)
                            DropdownMenuItem<String>(
                              value: '${item}',
                              child: Text(
                                (item.toString() == '0')
                                    ? '$item.ทั้งหมด'
                                    : '$item.${thaiMonthNames[item - 1]}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                        ],

                        onChanged: (value) async {
                          Mon_Income = value;
                          print(Mon_Income);

                          // if (Value_Chang_Zone_Income != null) {
                          //   red_Trans_billIncome();
                          //   // red_Trans_billMovemen();
                          // }
                        },
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
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          enabled: true,
                          hoverColor: Colors.brown,
                          prefixIconColor: Colors.blue,
                          fillColor: Colors.white.withOpacity(0.05),
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
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
                              color: Color.fromARGB(255, 231, 227, 227),
                            ),
                          ),
                        ),
                        isExpanded: false,
                        hint: Text(
                          YE_Income == null ? 'เลือก' : '$YE_Income',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
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
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        items: YE_Th.map((item) => DropdownMenuItem<String>(
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'โซน :',
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
                      width: 260,
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField2(
                        alignment: Alignment.center,
                        focusColor: Colors.white,
                        autofocus: false,
                        decoration: InputDecoration(
                          enabled: true,
                          hoverColor: Colors.brown,
                          prefixIconColor: Colors.blue,
                          fillColor: Colors.white.withOpacity(0.05),
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
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
                              color: Color.fromARGB(255, 231, 227, 227),
                            ),
                          ),
                        ),
                        isExpanded: false,
                        hint: Text(
                          Value_Chang_Zone_Income == null
                              ? 'เลือก'
                              : '$Value_Chang_Zone_Income',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        iconSize: 20,
                        buttonHeight: 40,
                        buttonWidth: 250,
                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          // color: Colors
                          //     .amber,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        items: zoneModels
                            .map((item) => DropdownMenuItem<String>(
                                  value: '${item.zn}',
                                  child: Text(
                                    '${item.zn}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ))
                            .toList(),

                        onChanged: (value) async {
                          int selectedIndex =
                              zoneModels.indexWhere((item) => item.zn == value);

                          setState(() {
                            Value_Chang_Zone_Income = value!;
                            Value_Chang_Zone_Ser_Income =
                                zoneModels[selectedIndex].ser!;
                          });
                          print(
                              'Selected Index: $Value_Chang_Zone_Income  //${Value_Chang_Zone_Ser_Income}');
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      red_Trans_billIncome();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async {
                  captureAndConvertToBase64(chartKey1, '');
                },
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
                    ),
                    child: Center(
                      child: Text(
                        'Export .PNG',
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
          // SfCartesianChart(
          //     title: ChartTitle(text: 'Sales Data'),
          //     // isTrackballBehaviorEnabled: true, // Enable trackball
          //     trackballBehavior: TrackballBehavior(
          //       // Customize trackball appearance
          //       enable: true,
          //       tooltipAlignment: ChartAlignment.center,
          //       hideDelay: 2000,
          //       tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          //       tooltipSettings: InteractiveTooltip(
          //         format: 'point.x: point.y',
          //       ),
          //     ),
          //     primaryXAxis: CategoryAxis(),
          //     series: <ChartSeries<_SalesData, String>>[
          //       for (int index = 0; index < data_tatol_income.length; index++)
          //         LineSeries<_SalesData, String>(
          //             dataSource: data_tatol_income[index],
          //             xValueMapper: (_SalesData sales, _) => sales.year,
          //             yValueMapper: (_SalesData sales, _) => sales.sales,
          //             name: '${zoneModels_report[index].zn}',
          //             // Enable data label
          //             dataLabelSettings: DataLabelSettings(isVisible: true)),
          //     ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.green[50]!.withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: RepaintBoundary(
                  key: chartKey1,
                  child: SfCartesianChart(
                      trackballBehavior: TrackballBehavior(),
                      title: ChartTitle(
                          text:
                              '${data_tatol_income.length} รายงานรายรับ 2023 ${_TransReBillModels_Income.length} ${(_TransReBillModels_Income.length == 0) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
                                  0.0,
                                  (previousValue, element) =>
                                      previousValue +
                                      (element.total_dis != null
                                          ? double.parse(element.total_dis!)
                                          : double.parse(element.total_bill!)),
                                ).toString()))}'}'),
                      legend: Legend(
                          isVisible: true,
                          textStyle: TextStyle(color: Colors.red)),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                      ),
                      // axes: <ChartAxis>[
                      //   NumericAxis(
                      //     numberFormat: NumberFormat.compact(),
                      //     majorGridLines: const MajorGridLines(width: 0),
                      //     opposedPosition: true,
                      //   )
                      // ],
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                            text: 'X-Axis Title',
                            textStyle: TextStyle(fontSize: 16)),
                        labelStyle: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                            text: 'Y-Axis Title',
                            textStyle: TextStyle(fontSize: 16)),
                        labelStyle: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                      // primaryXAxis: CategoryAxis(),
                      axes: <ChartAxis>[
                        NumericAxis(
                          numberFormat: NumberFormat.compact(),
                          majorGridLines: const MajorGridLines(width: 0),
                          opposedPosition: true,
                          name: 'yAxis1',
                          interval: 1000,
                          minimum: 0,
                          // maximum: 1000000
                        )
                      ],
                      series: <ChartSeries<_SalesData, String>>[
                        for (int index = 0;
                            index < data_tatol_income.length;
                            index++)
                          LineSeries<_SalesData, String>(
                            animationDuration: 2000,
                            dataSource: data_tatol_income[index],
                            xValueMapper: (_SalesData sales, _) => sales.monts,
                            yValueMapper: (_SalesData sales, _) => sales.sales,
                            name: '${zoneModels_report[index].zn}',
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              _chartSeriesController2 = controller;
                            },
                            emptyPointSettings: EmptyPointSettings(
                                // Mode of empty point
                                mode: EmptyPointMode.average),
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(
                                labelIntersectAction:
                                    LabelIntersectAction.shift,
                                isVisible: true,
                                textStyle: TextStyle(color: Colors.deepPurple)),
                            yAxisName: 'yAxis1',
                            markerSettings: MarkerSettings(isVisible: true),
                          ),
                      ])

                  // SfCartesianChart(
                  //     // onZooming: handleZooming,
                  //     zoomPanBehavior: ZoomPanBehavior(
                  //       enablePinching: true,
                  //       enablePanning: true,
                  //     ),
                  //     // primaryXAxis: CategoryAxis(),
                  //     // Chart title
                  //     title: ChartTitle(
                  //         text:
                  //             '${data_tatol_income.length} รายงานรายรับ 2023 ${_TransReBillModels_Income.length} ${(_TransReBillModels_Income.length == 0) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
                  //                 0.0,
                  //                 (previousValue, element) =>
                  //                     previousValue +
                  //                     (element.total_dis != null
                  //                         ? double.parse(element.total_dis!)
                  //                         : double.parse(element.total_bill!)),
                  //               ).toString()))}'}'),
                  //     // Enable legend
                  //     legend: Legend(
                  //         isVisible: true,
                  //         textStyle: TextStyle(color: Colors.red)),
                  //     // Enable tooltip format
                  //     tooltipBehavior: TooltipBehavior(
                  //       enable: true,
                  //     ),
                  //     axes: <ChartAxis>[
                  //       NumericAxis(
                  //         numberFormat: NumberFormat.compact(),
                  //         majorGridLines: const MajorGridLines(width: 0),
                  //         opposedPosition: true,
                  //       )
                  //     ],
                  //     primaryXAxis: CategoryAxis(
                  //       title: AxisTitle(
                  //           text: 'X-Axis Title',
                  //           textStyle: TextStyle(fontSize: 16)),
                  //       labelStyle: TextStyle(fontSize: 12, color: Colors.blue),
                  //     ),
                  //     primaryYAxis: NumericAxis(
                  //       title: AxisTitle(
                  //           text: 'Y-Axis Title',
                  //           textStyle: TextStyle(fontSize: 16)),
                  //       labelStyle: TextStyle(fontSize: 12, color: Colors.red),
                  //     ),
                  //     series: <ChartSeries<_SalesData, String>>[
                  //       for (int index = 0;
                  //           index < data_tatol_income.length;
                  //           index++)
                  //         LineSeries<_SalesData, String>(
                  //           animationDuration: 2000,
                  //           dataSource: data_tatol_income[index],
                  //           xValueMapper: (_SalesData sales, _) => sales.monts,
                  //           yValueMapper: (_SalesData sales, _) => sales.sales,
                  //           name: '${zoneModels_report[index].zn}',
                  //           onRendererCreated:
                  //               (ChartSeriesController controller) {
                  //             _chartSeriesController2 = controller;
                  //           },
                  //           emptyPointSettings: EmptyPointSettings(
                  //               // Mode of empty point
                  //               mode: EmptyPointMode.average),
                  //           // Enable data label
                  //           dataLabelSettings: DataLabelSettings(
                  //               labelIntersectAction: LabelIntersectAction.shift,
                  //               isVisible: true,
                  //               textStyle: TextStyle(color: Colors.deepPurple)),
                  //           yAxisName: 'yAxis1',
                  //           markerSettings: MarkerSettings(isVisible: true),
                  //         ),
                  //     ]),
                  ),
            ),
          ),

          // SfCartesianChart(
          //   trackballBehavior: TrackballBehavior(),
          //   primaryXAxis: CategoryAxis(),
          //   // Define primary and secondary Y axes
          //   primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
          //   // secondaryYAxis: NumericAxis(minimum: 0, maximum: 200, interval: 50),
          //   // tooltipBehavior: _tooltip,
          //   series: <ChartSeries<_SalesData, String>>[
          //     for (int index = 0; index < data_tatol_income.length; index++)
          //       LineSeries<_SalesData, String>(
          //         dataSource: data_tatol_income[index],
          //         xValueMapper: (_SalesData sales, _) => sales.monts,
          //         yValueMapper: (_SalesData sales, _) => sales.sales,
          //         name: '${zoneModels_report[index].zn}',
          //         // Associate each series with an axis
          //         yAxisName:
          //             (index % 2 == 0) ? 'primaryYAxis' : 'secondaryYAxis',
          //         // Enable data label
          //         dataLabelSettings: DataLabelSettings(isVisible: true),
          //       ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    captureAndConvertToBase64(chartKey2, '');
                  },
                  child: Text('Export .PNG'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.green[50]!.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: RepaintBoundary(
                  key: chartKey2,
                  child: SfCartesianChart(
                      title: ChartTitle(
                          text: (YE_Income == null)
                              ? 'รายงานรายรับ'
                              : '${data_tatol_income[data_tatol_income.length - 1].length}รายงานรายรับ $YE_Income'),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                      ),
                      primaryXAxis: CategoryAxis(),
                      axes: <ChartAxis>[
                        NumericAxis(
                          numberFormat: NumberFormat.compact(),
                          majorGridLines: const MajorGridLines(width: 0),
                          opposedPosition: true,
                          name: 'yAxis1',
                          interval: 10,
                          minimum: 0,
                        )
                      ],
                      legend: Legend(
                          isVisible: true,
                          textStyle: TextStyle(color: Colors.red)),
                      series: <ChartSeries<_SalesData, String>>[
                        for (int index = 0;
                            index < data_tatol_income.length;
                            index++)
                          ColumnSeries<_SalesData, String>(
                              animationDuration: 2000,
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController1 = controller;
                              },
                              dataSource: data_tatol_income[index],
                              xValueMapper: (_SalesData data, _) => data.monts,
                              yValueMapper: (_SalesData data, _) => data.sales,
                              name: 'Unit Sold'),
                        // for (int index = 0;
                        //     index < data_tatol_income.length;
                        //     index++)
                        //   LineSeries<_SalesData, String>(
                        //     animationDuration: 2000,
                        //     dataSource: data_tatol_income[index],
                        //     xValueMapper: (_SalesData sales, _) => sales.monts,
                        //     yValueMapper: (_SalesData sales, _) => sales.sales,
                        //     name: '${zoneModels_report[index].zn}',
                        //     onRendererCreated:
                        //         (ChartSeriesController controller) {
                        //       _chartSeriesController2 = controller;
                        //     },
                        //     emptyPointSettings: EmptyPointSettings(
                        //         // Mode of empty point
                        //         mode: EmptyPointMode.average),
                        //     // Enable data label
                        //     dataLabelSettings: DataLabelSettings(
                        //         labelIntersectAction: LabelIntersectAction.shift,
                        //         isVisible: true,
                        //         textStyle: TextStyle(color: Colors.deepPurple)),
                        //     yAxisName: 'yAxis1',
                        //     markerSettings: MarkerSettings(isVisible: true),
                        //   ),
                      ]),
                )),
          ),
          // Container(
          //   child: Row(
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           _chartSeriesController2?.animate();
          //         },
          //         child: Container(
          //           color: Colors.grey[400],
          //           child: Text('Line'),
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           _chartSeriesController1?.animate();
          //         },
          //         child: Container(
          //           color: Colors.grey[400],
          //           child: Text('Column'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async {
                  captureAndConvertToBase64(chartKey2, '');
                },
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
                    ),
                    child: Center(
                      child: Text(
                        'Export .PNG',
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
          // ElevatedButton(
          //   onPressed: () async {
          //     captureAndConvertToBase64(chartKey2, '');
          //   },
          //   child: Text('Export Chart as Excel'),
          // ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: RepaintBoundary(
          //       key: chartKey2,
          //       child: GestureDetector(
          //         onTap: () {
          //           // Reset the exploded slice when the chart is tapped
          //           setState(() {
          //             tappedIndex = -1;
          //           });
          //         },
          //         child: SfCircularChart(
          //           series: <PieSeries<SalesData, String>>[
          //             PieSeries<SalesData, String>(
          //               dataSource: <SalesData>[
          //                 SalesData('Category 1', 30),
          //                 SalesData('Category 2', 25),
          //                 SalesData('Category 3', 20),
          //                 SalesData('Category 4', 15),
          //               ],
          //               xValueMapper: (SalesData data, _) => data.year,
          //               yValueMapper: (SalesData data, _) => data.sales,
          //               dataLabelSettings: DataLabelSettings(isVisible: true),
          //               explode: true, // Enable explosion for the entire series
          //               explodeIndex:
          //                   tappedIndex, // Specify the exploded slice index
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ]),
      ),
    ));
  }

  late TooltipBehavior _tooltip;
}

class _SalesData {
  _SalesData(this.monts, this.sales);

  final String monts;
  final double sales;
}

// class SalesData {
//   SalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }
