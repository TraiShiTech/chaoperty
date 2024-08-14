import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/main.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import '../Constant/Myconstant.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import '../Style/view_pagenow.dart';
import 'Dashboard_Screen1.dart';
import 'Dashboard_Screen2.dart';
import 'Dashboard_Screen3.dart';
import 'Dashboard_Screen4.dart';
import 'Dashboard_Screen5.dart';
import 'Dashboard_Screen6.dart';
import 'Dashboard_Screen7.dart';
import 'Dashboard_Screen8.dart';
import 'Dashboard_Screen9.dart';

///
////  คู่มือ  === >>>>> https://help.syncfusion.com/flutter/cartesian-charts/trackball-crosshair#trackball-tooltip-overlap
///
class DashboardScreen extends StatefulWidget {
  final updateMessage;
  final areaModels;
  final areaModels1;
  final areaModels2;
  const DashboardScreen(
      {super.key,
      this.updateMessage,
      this.areaModels,
      this.areaModels1,
      this.areaModels2});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  int ser_pang = 0;
  String? renTal_user, renTal_name, zone_ser, zone_name;
  DateTime now = DateTime.now();
  String? SDatex_total1_;
  String? LDatex_total1_;
  double total1_ = 0.00;
  double total2_ = 0.00;
  double totalcash_ = 0.00;
  double totalbank = 0.00;
  double user_today = 0.00;
  String? YE_Income;
  String? Mon_Income;
  var overview_Ser_Zone_;
  String overview_Zone_ = 'ทั้งหมด';
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<PayMentModel> payMentModels = [];
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<RenTalModel> renTalModels = [];
  List<Widget> demoTransactions = [];
  List<UserModel> userModels = [];
  ///////---------------------------------------------------->
  String? rtname,
      type,
      typex,
      renname,
      bill_name,
      bill_addr,
      bill_tax,
      bill_tel,
      bill_email,
      expbill,
      expbill_name,
      bill_default,
      bill_tser,
      foder,
      rtser;
  ///////////////------------------------------->
  @override
  void initState() {
    super.initState();
    setState(() {
      SDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
      LDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
    });
    checkPreferance();
    read_GC_rental();
    red_Sum_billIncome();
    read_GC_zone();
    read_GC_User();
  }

  //////////////-------------
  Future<Null> read_GC_User() async {
    var formatter = DateFormat('yyyy-MM-dd');
    if (userModels.length != 0) {
      userModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_userSetting.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
          });
          if (DateFormat('yyyy-MM-dd').format(now).toString() ==
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse('${userModel.connected}'))
                  .toString()) {
            user_today++;
          } else {}
        }
      } else {}
    } catch (e) {}
  }

///////////////------------------------------->
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
  }

///////////////------------------------------->
  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';
    renTal_name = preferences.getString('renTalName');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname!.trim();
          var typexs = renTalModel.type!.trim();
          var typexx = renTalModel.typex!.trim();
          var bill_namex = renTalModel.bill_name!.trim();
          var bill_addrx = renTalModel.bill_addr!.trim();
          var bill_taxx = renTalModel.bill_tax!.trim();
          var bill_telx = renTalModel.bill_tel!.trim();
          var bill_emailx = renTalModel.bill_email!.trim();
          var bill_defaultx = renTalModel.bill_default;
          var bill_tserx = renTalModel.tser;
          var name = renTalModel.pn!.trim();
          var foderx = renTalModel.dbn;
          setState(() {
            rtser = renTalModel.ser!.trim();
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            bill_name = bill_namex;
            bill_addr = bill_addrx;
            bill_tax = bill_taxx;
            bill_tel = bill_telx;
            bill_email = bill_emailx;
            bill_default = bill_defaultx;
            bill_tser = bill_tserx;
            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

///////////////------------------------------->
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
        zoneModels_report.add(zoneModelx);
      });

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels.add(zoneModel);
          zoneModels_report.add(zoneModel);
        });
      }
      // zoneModels_report.sort((a, b) => a.zn!.compareTo(b.zn!));
      zoneModels_report.sort((a, b) {
        if (a.zn == 'ทั้งหมด') {
          return -1; // 'all' should come before other elements
        } else if (b.zn == 'ทั้งหมด') {
          return 1; // 'all' should come after other elements
        } else {
          return a.zn!
              .compareTo(b.zn!); // sort other elements in ascending order
        }
      });
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
  }

///////////////------------------------------->
  Future<Null> red_Sum_billIncome() async {
    setState(() {
      total1_ = 0.00;
      total2_ = 0.00;
      totalcash_ = 0.00;
      totalbank = 0.00;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ttt = '2023-11-01';
    String url = (overview_Ser_Zone_.toString() == '0' ||
            overview_Ser_Zone_ == null)
        ? '${MyConstant().domain}/GC_SCReport_total1.php?isAdd=true&ren=$ren&sdate=$SDatex_total1_&ldate=$LDatex_total1_'
        : '${MyConstant().domain}/GC_SCReport_total1_zone.php?isAdd=true&ren=$ren&sdate=$SDatex_total1_&ldate=$LDatex_total1_&ser_zone=$overview_Ser_Zone_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModels_Incomes =
              TransReBillModel.fromJson(map);
          setState(() {
            total1_ = (_TransReBillModels_Incomes.total_dis.toString() ==
                    '0.00')
                ? total1_ + double.parse(_TransReBillModels_Incomes.total_bill!)
                : total1_ +
                    (double.parse(_TransReBillModels_Incomes.total_bill!) -
                        double.parse(_TransReBillModels_Incomes.total_dis!));

            total2_ = (_TransReBillModels_Incomes.total_bill == null)
                ? total2_ + 0.00
                : total2_ +
                    double.parse(_TransReBillModels_Incomes.total_bill!);

            totalcash_ = (_TransReBillModels_Incomes.type.toString().trim() ==
                    'CASH')
                ? (_TransReBillModels_Incomes.total_dis.toString() == '0.00')
                    ? totalcash_ +
                        double.parse(_TransReBillModels_Incomes.total_bill!)
                    : totalcash_ +
                        (double.parse(_TransReBillModels_Incomes.total_bill!) -
                            double.parse(_TransReBillModels_Incomes.total_dis!))
                : totalcash_ + 0.00;

            totalbank = (_TransReBillModels_Incomes.type.toString().trim() ==
                        'AC' ||
                    _TransReBillModels_Incomes.type.toString().trim() == 'OP')
                ? (_TransReBillModels_Incomes.total_dis.toString() == '0.00')
                    ? totalbank +
                        double.parse(_TransReBillModels_Incomes.total_bill!)
                    : totalbank +
                        (double.parse(_TransReBillModels_Incomes.total_bill!) -
                            double.parse(_TransReBillModels_Incomes.total_dis!))
                : totalbank + 0.00;
          });
          // print(
          //     '${_TransReBillModels_Incomes.type.toString().trim()} /// ${totalbank}');
        }
      }
    } catch (e) {}
  }

///////////////------------------------------->

  Future<Null> _select_financial_StartDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่เริ่มต้น', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      // selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppBarColors.ABar_Colors, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    picked.then((result) {
      if (picked != null) {
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          SDatex_total1_ = "${formatter.format(result)}";
        });
        red_Sum_billIncome();
      }
    });
  }

  Future<Null> _select_financial_LtartDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่สุดท้าย', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      // selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppBarColors.ABar_Colors, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    picked.then((result) {
      if (picked != null) {
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          LDatex_total1_ = "${formatter.format(result)}";
        });
        red_Sum_billIncome();
      }
    });
  }

  /////////////////-------------------------->
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppbackgroundColor.TiTile_Box,
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
                            Translate.TranslateAndSetText(
                                'รายงาน ',
                                ReportScreen_Color.Colors_Text1_,
                                TextAlign.end,
                                FontWeight.w500,
                                FontWeight_.Fonts_T,
                                16,
                                1),

                            // AutoSizeText(
                            //   'รายงาน ',
                            //   overflow: TextOverflow.ellipsis,
                            //   minFontSize: 8,
                            //   maxFontSize: 20,
                            //   style: TextStyle(
                            //     decoration: TextDecoration.underline,
                            //     color: ReportScreen_Color.Colors_Text1_,
                            //     fontWeight: FontWeight.bold,
                            //     fontFamily: FontWeight_.Fonts_T,
                            //   ),
                            // ),
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
              ),
              Align(
                alignment: Alignment.centerRight,
                child: viewpage(context, '5'),
              ),
            ],
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
                color: AppbackgroundColor.TiTile_Box,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
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
                              child: Translate.TranslateAndSetText(
                                  'รายงาน',
                                  Colors.white,
                                  TextAlign.end,
                                  FontWeight.w500,
                                  FontWeight_.Fonts_T,
                                  16,
                                  1),
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
                            child: const Center(
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
          Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 2, 8),
                            child: Translate.TranslateAndSetText(
                                'ภาพรวมการดำเนินการ ',
                                ReportScreen_Color.Colors_Text1_,
                                TextAlign.end,
                                FontWeight.w500,
                                FontWeight_.Fonts_T,
                                16,
                                1),
                            // AutoSizeText(
                            //   'ภาพรวมการดำเนินการ ',
                            //   overflow: TextOverflow.ellipsis,
                            //   minFontSize: 8,
                            //   maxFontSize: 20,
                            //   style: TextStyle(
                            //     color: ReportScreen_Color.Colors_Text1_,
                            //     fontWeight: FontWeight.bold,
                            //     fontFamily: FontWeight_.Fonts_T,
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          ////
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 270,
                decoration: BoxDecoration(
                  color: AppbackgroundColor.TiTile_Colors,
                  // color: AppbackgroundColor.TiTile_Box,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if ((MediaQuery.of(context).size.width) > 1200)
                              Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 1,
                              child: ((MediaQuery.of(context).size.width) > 650)
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          }),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                    height: 35,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Translate
                                                              .TranslateAndSetText(
                                                                  'รายรับ :',
                                                                  ReportScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign.end,
                                                                  FontWeight
                                                                      .w500,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  12,
                                                                  1),

                                                          //  Text(
                                                          //   'รายรับ :',
                                                          //   style: TextStyle(
                                                          //     color: ReportScreen_Color
                                                          //         .Colors_Text2_,
                                                          //     fontWeight:
                                                          //         FontWeight
                                                          //             .bold,
                                                          //     fontFamily:
                                                          //         FontWeight_
                                                          //             .Fonts_T,
                                                          //   ),
                                                          // ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Translate
                                                              .TranslateAndSetText(
                                                                  'โซน ',
                                                                  ReportScreen_Color
                                                                      .Colors_Text1_,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .w500,
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                                  12,
                                                                  1),

                                                          //  Text(
                                                          //   'โซน ',
                                                          //   style: TextStyle(
                                                          //     color: ReportScreen_Color
                                                          //         .Colors_Text2_,
                                                          //     // fontWeight: FontWeight.bold,
                                                          //     fontFamily:
                                                          //         Font_.Fonts_T,
                                                          //   ),
                                                          // ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              // border: Border.all(color: Colors.grey, width: 1),
                                                            ),
                                                            width: 260,
                                                            // height: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child:
                                                                DropdownButtonFormField2(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              focusColor:
                                                                  Colors.white,
                                                              autofocus: false,
                                                              decoration:
                                                                  InputDecoration(
                                                                enabled: true,
                                                                hoverColor:
                                                                    Colors
                                                                        .brown,
                                                                prefixIconColor:
                                                                    Colors.blue,
                                                                fillColor: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.05),
                                                                filled: false,
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      const BorderSide(
                                                                          color:
                                                                              Colors.red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                focusedBorder:
                                                                    const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            231,
                                                                            227,
                                                                            227),
                                                                  ),
                                                                ),
                                                              ),
                                                              isExpanded: false,
                                                              value:
                                                                  overview_Zone_,
                                                              // hint: Text(
                                                              //   Value_Chang_Zone_Income ==
                                                              //           null
                                                              //       ? 'เลือก'
                                                              //       : '$Value_Chang_Zone_Income',
                                                              //   maxLines: 2,
                                                              //   textAlign: TextAlign.center,
                                                              //   style: const TextStyle(
                                                              //     overflow:
                                                              //         TextOverflow.ellipsis,
                                                              //     fontSize: 14,
                                                              //     color: Colors.grey,
                                                              //   ),
                                                              // ),
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              iconSize: 20,

                                                              buttonHeight: 40,
                                                              buttonWidth: 250,
                                                              dropdownDecoration:
                                                                  BoxDecoration(
                                                                // color: Colors
                                                                //     .amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 1),
                                                              ),
                                                              items:
                                                                  zoneModels_report
                                                                      .map((item) =>
                                                                          DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                '${item.zn}',
                                                                            child:
                                                                                Text(
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

                                                              onChanged:
                                                                  (value) async {
                                                                int selectedIndex =
                                                                    zoneModels_report.indexWhere(
                                                                        (item) =>
                                                                            item.zn ==
                                                                            value);
                                                                setState(() {
                                                                  overview_Zone_ =
                                                                      value!;
                                                                  overview_Ser_Zone_ =
                                                                      '${zoneModels_report[selectedIndex].ser}';
                                                                });

                                                                red_Sum_billIncome();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Translate
                                                            .TranslateAndSetText(
                                                                'วันที่ ',
                                                                ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.start,
                                                                FontWeight.w500,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                12,
                                                                1),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 0, 8, 0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            _select_financial_StartDate(
                                                                context);
                                                          },
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                              ),
                                                              height: 25,
                                                              width: 120,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Center(
                                                                child: Translate.TranslateAndSetText(
                                                                    (SDatex_total1_ ==
                                                                            null)
                                                                        ? 'เลือก'
                                                                        : '$SDatex_total1_',
                                                                    Colors.grey,
                                                                    TextAlign
                                                                        .start,
                                                                    FontWeight
                                                                        .w500,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    12,
                                                                    1),
                                                              )),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                8, 0, 8, 0),
                                                        child: Translate
                                                            .TranslateAndSetText(
                                                                'ถึง',
                                                                ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.start,
                                                                FontWeight.w500,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                12,
                                                                1),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 0, 8, 0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            _select_financial_LtartDate(
                                                                context);
                                                          },
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                    .Sub_Abg_Colors,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                              ),
                                                              height: 25,
                                                              width: 120,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Center(
                                                                child: Translate.TranslateAndSetText(
                                                                    (LDatex_total1_ ==
                                                                            null)
                                                                        ? 'เลือก'
                                                                        : '$LDatex_total1_',
                                                                    Colors.grey,
                                                                    TextAlign
                                                                        .start,
                                                                    FontWeight
                                                                        .w500,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    12,
                                                                    1),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 0, 6, 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 35,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'รายรับ :',
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              TextAlign.start,
                                                              FontWeight.w500,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              16,
                                                              1),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Translate
                                                          .TranslateAndSetText(
                                                              'โซน ',
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              TextAlign.start,
                                                              FontWeight.w500,
                                                              FontWeight_
                                                                  .Fonts_T,
                                                              16,
                                                              1),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          // border: Border.all(color: Colors.grey, width: 1),
                                                        ),
                                                        width: 240,
                                                        // height: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child:
                                                            DropdownButtonFormField2(
                                                          alignment:
                                                              Alignment.center,
                                                          focusColor:
                                                              Colors.white,
                                                          autofocus: false,
                                                          decoration:
                                                              InputDecoration(
                                                            enabled: true,
                                                            hoverColor:
                                                                Colors.brown,
                                                            prefixIconColor:
                                                                Colors.blue,
                                                            fillColor: Colors
                                                                .white
                                                                .withOpacity(
                                                                    0.05),
                                                            filled: false,
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            focusedBorder:
                                                                const OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        231,
                                                                        227,
                                                                        227),
                                                              ),
                                                            ),
                                                          ),
                                                          isExpanded: false,
                                                          value: overview_Zone_,
                                                          // hint: Text(
                                                          //   Value_Chang_Zone_Income ==
                                                          //           null
                                                          //       ? 'เลือก'
                                                          //       : '$Value_Chang_Zone_Income',
                                                          //   maxLines: 2,
                                                          //   textAlign: TextAlign.center,
                                                          //   style: const TextStyle(
                                                          //     overflow:
                                                          //         TextOverflow.ellipsis,
                                                          //     fontSize: 14,
                                                          //     color: Colors.grey,
                                                          //   ),
                                                          // ),
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.black,
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                          iconSize: 20,

                                                          buttonHeight: 40,
                                                          buttonWidth: 240,
                                                          dropdownDecoration:
                                                              BoxDecoration(
                                                            // color: Colors
                                                            //     .amber,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1),
                                                          ),
                                                          items:
                                                              zoneModels_report
                                                                  .map((item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            '${item.zn}',
                                                                        child:
                                                                            Text(
                                                                          '${item.zn}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  .toList(),

                                                          onChanged:
                                                              (value) async {
                                                            int selectedIndex =
                                                                zoneModels_report
                                                                    .indexWhere(
                                                                        (item) =>
                                                                            item.zn ==
                                                                            value);
                                                            setState(() {
                                                              overview_Zone_ =
                                                                  value!;
                                                              overview_Ser_Zone_ =
                                                                  '${zoneModels_report[selectedIndex].ser}';
                                                            });

                                                            red_Sum_billIncome();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'วันที่ ',
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.start,
                                                            FontWeight.w500,
                                                            FontWeight_.Fonts_T,
                                                            16,
                                                            1),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 8, 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _select_financial_StartDate(
                                                            context);
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          height: 25,
                                                          width: 110,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Center(
                                                            child: Translate.TranslateAndSetText(
                                                                (SDatex_total1_ ==
                                                                        null)
                                                                    ? 'เลือก'
                                                                    : '$SDatex_total1_',
                                                                ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.start,
                                                                FontWeight.w500,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                16,
                                                                1),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 0, 8, 0),
                                                    child: Translate
                                                        .TranslateAndSetText(
                                                            'ถึง',
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                            TextAlign.start,
                                                            FontWeight.w500,
                                                            FontWeight_.Fonts_T,
                                                            16,
                                                            1),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 8, 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _select_financial_LtartDate(
                                                            context);
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                .Sub_Abg_Colors,
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1),
                                                          ),
                                                          height: 25,
                                                          width: 110,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Center(
                                                            child: Translate.TranslateAndSetText(
                                                                (LDatex_total1_ ==
                                                                        null)
                                                                    ? 'เลือก'
                                                                    : '$LDatex_total1_',
                                                                ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                TextAlign.start,
                                                                FontWeight.w500,
                                                                FontWeight_
                                                                    .Fonts_T,
                                                                16,
                                                                1),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        GridView.count(
                            padding: ((MediaQuery.of(context).size.width) < 650)
                                ? const EdgeInsets.all(2)
                                : const EdgeInsets.all(5),
                            crossAxisSpacing:
                                ((MediaQuery.of(context).size.width) < 650)
                                    ? 10.00
                                    : 16.0,
                            mainAxisSpacing:
                                ((MediaQuery.of(context).size.width) < 650)
                                    ? 10.00
                                    : 16.0,
                            crossAxisCount:
                                (MediaQuery.of(context).size.width) < 650
                                    ? 2
                                    : (MediaQuery.of(context).size.width) < 1330
                                        ? 2
                                        : 4,
                            childAspectRatio: (Responsive.isDesktop(context))
                                ? ((MediaQuery.of(context).size.width) >= 1200)
                                    ? 2
                                    : 0.8
                                : ((MediaQuery.of(context).size.width) < 650 &&
                                        (MediaQuery.of(context).size.width) >
                                            500)
                                    ? 1.2
                                    : ((MediaQuery.of(context).size.width) <
                                                780 &&
                                            (MediaQuery.of(context)
                                                    .size
                                                    .width) >
                                                650)
                                        ? 0.8
                                        : ((MediaQuery.of(context).size.width) <
                                                500)
                                            ? 0.8
                                            : 0.8,
                            // childAspectRatio: ((MediaQuery.of(context)
                            //                 .size
                            //                 .width) <
                            //             650 &&
                            //         (MediaQuery.of(context).size.width) >
                            //             500)
                            //     ? 1.2
                            //     : ((MediaQuery.of(context).size.width) <
                            //             500)
                            //         ? 0.8
                            //         : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                padding:
                                    ((MediaQuery.of(context).size.width) < 650)
                                        ? const EdgeInsets.all(5.0)
                                        : const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  // color: Color(0xFFA8BFDB),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.orange[700],
                                        ),
                                        child: const Icon(
                                          Icons.map_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Translate.TranslateAndSetText(
                                        'พื้นที่',
                                        ReportScreen_Color.Colors_Text1_,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        FontWeight_.Fonts_T,
                                        12,
                                        1),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              'ทั้งหมด',
                                              Colors.blue,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (total1_).clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (widget.areaModels == null)
                                                ? '0 พื้นที่'
                                                : '${nFormat2.format(double.parse(widget.areaModels.length.toString()))} พื้นที่',
                                            Colors.blue,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),

                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.blue[300],
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              (widget.areaModels2.length == 0)
                                                  ? 'ว่าง [0%]'
                                                  : 'ว่าง [${(((widget.areaModels2.length ?? 0.0) * 100) / widget.areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                              Colors.green,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (double.parse(widget
                                                    .areaModels2.length
                                                    .toString()) /
                                                double.parse(widget
                                                    .areaModels.length
                                                    .toString()))
                                            .clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (widget.areaModels2 == null)
                                                ? '0 พื้นที่'
                                                : '${nFormat2.format(double.parse(widget.areaModels2.length.toString()))} พื้นที่',
                                            Colors.green,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),

                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.green[300],
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 120,
                                          child: Translate.TranslateAndSetText(
                                              (widget.areaModels1.length == 0)
                                                  ? 'ใกล้หมด.. [0%]'
                                                  : 'ใกล้หมด.. [${(((widget.areaModels1.length ?? 0.0) * 100) / widget.areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                              Colors.red,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (double.parse(widget
                                                    .areaModels1.length
                                                    .toString()) /
                                                double.parse(widget
                                                    .areaModels.length
                                                    .toString()))
                                            .clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (widget.areaModels1 == null)
                                                ? '0 พื้นที่'
                                                : '${nFormat2.format(double.parse(widget.areaModels1.length.toString()))} พื้นที่',
                                            Colors.red,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),

                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.red[300],
                                      ),
                                    ),
                                    // Text(
                                    //   (total2_ == null) ? '0.00' : '${nFormat.format(total2_)}',
                                    // ),
                                    // const Text(
                                    //   'บาท',
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    ((MediaQuery.of(context).size.width) < 650)
                                        ? const EdgeInsets.all(5.0)
                                        : const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  // color: Color(0xFFA8BFDB),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.blue[700],
                                        ),
                                        child: const Icon(
                                          Icons.people,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Translate.TranslateAndSetText(
                                        'แอดมิน',
                                        Colors.black,
                                        TextAlign.end,
                                        FontWeight.w500,
                                        FontWeight_.Fonts_T,
                                        12,
                                        1),
                                    const Row(
                                      children: [
                                        Expanded(
                                          // width: ((MediaQuery.of(
                                          //                 context)
                                          //             .size
                                          //             .width) <
                                          //         650)
                                          //     ? 40
                                          //     : 100,
                                          child: Text(
                                            '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              // decoration:
                                              //     TextDecoration.underline,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            // decoration:
                                            //     TextDecoration.underline,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              'ทั้งหมด',
                                              Colors.green,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (double.parse(
                                                userModels.length.toString()))
                                            .clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (userModels.isEmpty)
                                                ? '0 คน'
                                                : '${nFormat2.format(userModels.length)} คน',
                                            Colors.green,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.green[300],
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              (user_today == 0.00)
                                                  ? 'วันนี้ [0%]'
                                                  : 'วันนี้ [${(((user_today ?? 0.0) * 100) / userModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                              Colors.red,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (user_today /
                                                double.parse(userModels.length
                                                    .toString()))
                                            .clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            '${nFormat2.format(user_today)} คน',
                                            Colors.red,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),

                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.red[300],
                                      ),
                                    ),
                                    // Text(
                                    //   (total2_ == null) ? '0.00' : '${nFormat.format(total2_)}',
                                    // ),
                                    // const Text(
                                    //   'บาท',
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    ((MediaQuery.of(context).size.width) < 650)
                                        ? const EdgeInsets.all(5.0)
                                        : const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  // color: Color(0xFFA8BFDB),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.red[700],
                                        ),
                                        child: const Icon(
                                          Icons.account_balance_wallet,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Translate.TranslateAndSetText(
                                        'รวมรายรับ (ชำระแล้ว Cash/Bank)',
                                        Colors.black,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        FontWeight_.Fonts_T,
                                        12,
                                        1),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              'ทั้งหมด ',
                                              Colors.blue,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (total1_).clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (total1_ == null)
                                                ? '0.00 บาท'
                                                : '${nFormat.format(total1_)} บาท',
                                            Colors.blue,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.blue[300],
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              (totalcash_ == 0.00)
                                                  ? 'Cash [0%]'
                                                  : 'Cash [${(((totalcash_ ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                              Colors.green,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (totalcash_ / total1_)
                                            .clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (totalcash_ == null)
                                                ? '0.00 บาท'
                                                : '${nFormat.format(totalcash_)} บาท',
                                            Colors.green,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.green[300],
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              (totalbank == 0.00)
                                                  ? 'Bank [0%]'
                                                  : 'Bank [${(((totalbank ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                              Colors.red,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (totalbank / total1_)
                                            .clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (totalbank == null)
                                                ? '0.00 บาท'
                                                : '${nFormat.format(totalbank)} บาท',
                                            Colors.red,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.red[300],
                                      ),
                                    ),
                                    // Text(
                                    //   (total2_ == null) ? '0.00' : '${nFormat.format(total2_)}',
                                    // ),
                                    // const Text(
                                    //   'บาท',
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    ((MediaQuery.of(context).size.width) < 650)
                                        ? const EdgeInsets.all(5.0)
                                        : const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  // color: Color(0xFFA8BFDB),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.teal[700],
                                        ),
                                        child: const Icon(
                                          Icons.monetization_on_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Translate.TranslateAndSetText(
                                        'รวมรายรับ (ชำระแล้ว )',
                                        Colors.black,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        FontWeight_.Fonts_T,
                                        12,
                                        1),
                                    const Row(
                                      children: [
                                        Expanded(
                                          // width: ((MediaQuery.of(
                                          //                 context)
                                          //             .size
                                          //             .width) <
                                          //         650)
                                          //     ? 40
                                          //     : 100,
                                          child: Text(
                                            '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              // decoration:
                                              //     TextDecoration.underline,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            // decoration:
                                            //     TextDecoration.underline,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              'ก่อน-หักส่วนลด',
                                              Colors.green,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent: (total2_).clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (total2_ == null)
                                                ? '0.00 บาท'
                                                : '${nFormat.format(total2_)} บาท',
                                            Colors.green,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.green[300],
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     10,
                                        animation: true,
                                        lineHeight: 14.0,
                                        leading: Container(
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
                                              ? 40
                                              : 100,
                                          child: Translate.TranslateAndSetText(
                                              'หลัง-หักส่วนลด',
                                              Colors.red,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              FontWeight_.Fonts_T,
                                              12,
                                              1),
                                        ),
                                        animationDuration: 3000,
                                        percent:
                                            (total1_ / total2_).clamp(0.0, 1.0),
                                        center: Translate.TranslateAndSetText(
                                            (total1_ == null)
                                                ? '0.00 บาท'
                                                : '${nFormat.format(total1_)} บาท',
                                            Colors.red,
                                            TextAlign.end,
                                            FontWeight.w500,
                                            FontWeight_.Fonts_T,
                                            12,
                                            1),

                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.red[300],
                                      ),
                                    ),

                                    // Text(
                                    //   (total2_ == null) ? '0.00' : '${nFormat.format(total2_)}',
                                    // ),
                                    // const Text(
                                    //   'บาท',
                                    // ),
                                  ],
                                ),
                              ),
                            ]
                            // itemBuilder: (context, index) =>
                            //     demoTransactions[index],
                            )
                      ]),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dashboard : ',
                  style: TextStyle(
                    color: ReportScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int index = 0; index < 8; index++)
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
                                    style: const TextStyle(
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
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     decoration: const BoxDecoration(
          //       color: Colors.white30,
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(0),
          //           topRight: Radius.circular(0),
          //           bottomLeft: Radius.circular(10),
          //           bottomRight: Radius.circular(10)),
          //       // border: Border.all(color: Colors.grey, width: 1),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
          //               child: Text(
          //                 'รายงาน',
          //                 style: TextStyle(
          //                   color: ReportScreen_Color.Colors_Text1_,
          //                   fontWeight: FontWeight.bold,
          //                   fontFamily: FontWeight_.Fonts_T,
          //                 ),
          //               ),
          //             ),
          //             for (int index = 0; index < 9; index++)
          //               Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: InkWell(
          //                   onTap: () {
          //                     setState(() {
          //                       ser_pang = index;
          //                     });
          //                   },
          //                   child: Container(
          //                     width: 100,
          //                     decoration: BoxDecoration(
          //                       color: (ser_pang == index)
          //                           ? Colors.black54
          //                           : Colors.black26,
          //                       borderRadius: const BorderRadius.only(
          //                         topLeft: Radius.circular(10),
          //                         topRight: Radius.circular(10),
          //                         bottomLeft: Radius.circular(10),
          //                         bottomRight: Radius.circular(10),
          //                       ),
          //                       border:
          //                           Border.all(color: Colors.white, width: 2),
          //                     ),
          //                     padding: const EdgeInsets.all(5.0),
          //                     child: Center(
          //                       child: AutoSizeText(
          //                         minFontSize: 10,
          //                         maxFontSize: 20,
          //                         'หน้า ${index + 1}',
          //                         style: const TextStyle(
          //                           color: Colors.white,
          //                           // fontWeight: FontWeight.bold,
          //                           fontFamily: FontWeight_.Fonts_T,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          (ser_pang == 0)
              ? const Dashboard_Screen1()
              : (ser_pang == 1)
                  ? const Dashboard_Screen2()
                  : (ser_pang == 2)
                      ? const Dashboard_Screen3()
                      : (ser_pang == 3)
                          ? const Dashboard_Screen4()
                          : (ser_pang == 4)
                              ? const Dashboard_Screen5()
                              : (ser_pang == 5)
                                  ? const Dashboard_Screen6()
                                  : (ser_pang == 6)
                                      ? const Dashboard_Screen7()
                                      : (ser_pang == 7)
                                          ? const Dashboard_Screen9()
                                          : const Dashboard_Screen9()
        ]),
      ),
    ));
  }
}
