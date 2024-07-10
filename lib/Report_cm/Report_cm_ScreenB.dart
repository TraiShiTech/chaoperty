import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_model_REprot_CM.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Excel_DailyReport_category_cm.dart';

class Report_cm_ScreenB extends StatefulWidget {
  const Report_cm_ScreenB({super.key});

  @override
  State<Report_cm_ScreenB> createState() => _Report_cm_ScreenBState();
}

class _Report_cm_ScreenBState extends State<Report_cm_ScreenB> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  List<ZoneModel> zoneModels_report = [];
  List<ZoneModel> zoneModels_report_Sub_zone = [];
  List<ZoneModel> zoneModeels_report_Ser_Sub_zone = [];

  List<ExpModel> expModels = [];
  String? renTal_user, renTal_name;
  String? YE_Income_Type_Mon_User;
  String? Mon_Income_Type_Mon_User;
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  // List<TransReBillModelRECM> _TransReBillModels = [];

  List<TransReBillModelRECM> _TransReBillModels_GropType_Mon = [];
  List<TransReBillModelRECM> _TransReBillModels_GropType_Sub_zone = [];

  List<TransReBillModelRECM> _TransReBillModels_GropType_Daily = [];
  List<TransReBillModelRECM> _TransReBillModels_GropType_Daily_Sub_zone = [];

  String? Value_selectDate_Daily_Type_;
  String? Value_select_lastDate_Daily_Type_;
  List<String> monthsInThai = [
    'มกราคม', // January
    'กุมภาพันธ์', // February
    'มีนาคม', // March
    'เมษายน', // April
    'พฤษภาคม', // May
    'มิถุนายน', // June
    'กรกฎาคม', // July
    'สิงหาคม', // August
    'กันยายน', // September
    'ตุลาคม', // October
    'พฤศจิกายน', // November
    'ธันวาคม', // December
  ];
  ///////---------------------------------------------------->
  String _verticalGroupValue_PassW = "EXCEL";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
  ///////---------------------------------------------------->
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_Exp();
    read_GC_Sub_zone();
  }

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
    if (zoneModels_report.length != 0) {
      zoneModels_report.clear();
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
          // zoneModels.add(zoneModel);
          zoneModels_report.add(zoneModel);
        });
        if (zoneModel.sub_zone.toString() == '0') {
        } else {
          setState(() {
            zoneModeels_report_Ser_Sub_zone.add(zoneModel);
          });
        }
      }
      zoneModels_report.sort((a, b) {
        return int.parse(a.number_zn!).compareTo(int.parse(b.number_zn!));
      });
      zoneModeels_report_Ser_Sub_zone.sort((a, b) {
        return int.parse(a.number_zn!).compareTo(int.parse(b.number_zn!));
      });

      // zoneModels.sort((a, b) {
      //   if (a.zn == 'ทั้งหมด') {
      //     return -1; // 'all' should come before other elements
      //   } else if (b.zn == 'ทั้งหมด') {
      //     return 1; // 'all' should come after other elements
      //   } else {
      //     return a.zn!
      //         .compareTo(b.zn!); // sort other elements in ascending order
      //   }
      // });
    } catch (e) {}
  }

  Future<Null> read_GC_Sub_zone() async {
    if (zoneModels_report_Sub_zone.length != 0) {
      zoneModels_report_Sub_zone.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone_sub.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        ZoneModel zoneModel = ZoneModel.fromJson(map);
        setState(() {
          zoneModels_report_Sub_zone.add(zoneModel);
        });
      }

      zoneModels_report_Sub_zone.sort((a, b) {
        return int.parse(a.number_zn!).compareTo(int.parse(b.number_zn!));
      });
    } catch (e) {}
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_ReportB_Cm.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ExpModel expModel = ExpModel.fromJson(map);

          setState(() {
            expModels.add(expModel);
          });
        }
      } else {}
    } catch (e) {}
  }
//////////////////////---------------------------------------->(รายงานรายรับรายเดือนแยกตามประเภท)

  Future<Null> red_Trans_bill_Groptype_Mon() async {
    if (_TransReBillModels_GropType_Mon.length != 0) {
      setState(() {
        _TransReBillModels_GropType_Mon.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_MonthReportType_CMma.php?isAdd=true&ren=$ren&yea_r=$YE_Income_Type_Mon_User&mont_h=$Mon_Income_Type_Mon_User';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM transReBillModel =
              TransReBillModelRECM.fromJson(map);

          setState(() {
            _TransReBillModels_GropType_Mon.add(transReBillModel);
          });
        }

        // print('result ${_TransReBillModels_GropType_Mon.length}');
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill_Groptype_Mon_Sub_zone() async {
    if (_TransReBillModels_GropType_Sub_zone.length != 0) {
      setState(() {
        _TransReBillModels_GropType_Sub_zone.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_MonthReportType_CMma_SubZone.php?isAdd=true&ren=$ren&yea_r=$YE_Income_Type_Mon_User&mont_h=$Mon_Income_Type_Mon_User';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM transReBillModel =
              TransReBillModelRECM.fromJson(map);

          setState(() {
            _TransReBillModels_GropType_Sub_zone.add(transReBillModel);
          });
        }

        // print('result ${_TransReBillModels_GropType_Sub_zone.length}');
      }
    } catch (e) {}
  }

///////////////////////////---------------------------------->
  String calculateTotalArea_Zone(int index1) {
    Set<String> uniqueDocnos = {};
    double totalArea = 0.0;

    for (int index = 0;
        index < _TransReBillModels_GropType_Mon.length;
        index++) {
      if (_TransReBillModels_GropType_Mon[index].room_number.toString() !=
          'ล็อคเสียบ') {
        if (!uniqueDocnos
            .contains(_TransReBillModels_GropType_Mon[index].docno)) {
          if (_TransReBillModels_GropType_Mon[index].zser == null) {
            totalArea += double.parse(
                _TransReBillModels_GropType_Mon[index].zser1 ==
                        zoneModels_report[index1].ser
                    ? _TransReBillModels_GropType_Mon[index].area == null ||
                            _TransReBillModels_GropType_Mon[index].area! == ''
                        ? 1.toString()
                        : _TransReBillModels_GropType_Mon[index].area.toString()
                    : 0.toString());
          } else {
            totalArea += double.parse(
                _TransReBillModels_GropType_Mon[index].zser ==
                        zoneModels_report[index1].ser
                    ? _TransReBillModels_GropType_Mon[index].area == null ||
                            _TransReBillModels_GropType_Mon[index].area! == ''
                        ? 1.toString()
                        : _TransReBillModels_GropType_Mon[index].area.toString()
                    : 0.toString());
          }
          uniqueDocnos.add(_TransReBillModels_GropType_Mon[index].docno!);
        }
      }
    }

    return totalArea.toString();
  }

  String calculateTotalArea_Zone_Sub(int index1) {
    Set<String> uniqueDocnos = {};
    double totalArea = 0.0;

    for (int index = 0;
        index < _TransReBillModels_GropType_Sub_zone.length;
        index++) {
      if (_TransReBillModels_GropType_Sub_zone[index].room_number.toString() !=
          'ล็อคเสียบ') {
        if (!uniqueDocnos
            .contains(_TransReBillModels_GropType_Sub_zone[index].docno)) {
          if (_TransReBillModels_GropType_Sub_zone[index].zser == null) {
            totalArea += double.parse(
                _TransReBillModels_GropType_Sub_zone[index].zser1 ==
                        zoneModeels_report_Ser_Sub_zone[index1].ser
                    ? _TransReBillModels_GropType_Sub_zone[index].area ==
                                null ||
                            _TransReBillModels_GropType_Sub_zone[index].area! ==
                                ''
                        ? 1.toString()
                        : _TransReBillModels_GropType_Sub_zone[index]
                            .area
                            .toString()
                    : 0.toString());
          } else {
            totalArea += double.parse(
                _TransReBillModels_GropType_Sub_zone[index].zser ==
                        zoneModeels_report_Ser_Sub_zone[index1].ser
                    ? _TransReBillModels_GropType_Sub_zone[index].area ==
                                null ||
                            _TransReBillModels_GropType_Sub_zone[index].area! ==
                                ''
                        ? 1.toString()
                        : _TransReBillModels_GropType_Sub_zone[index]
                            .area
                            .toString()
                    : 0.toString());
          }
          uniqueDocnos.add(_TransReBillModels_GropType_Sub_zone[index].docno!);
        }
      }
    }

    return totalArea.toString();
  }

  String calculateTotalBills_Zone(int index1) {
    Set<String> uniqueDocnos = {};
    double totalBills = 0.0;

    totalBills = (_TransReBillModels_GropType_Mon.length == 0)
        ? 0.00
        : double.parse((_TransReBillModels_GropType_Mon.map((e) =>
            (e.zser == null)
                ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                        e.expser! == '1' &&
                        e.room_number.toString() != 'ล็อคเสียบ'
                    ? e.total_expname == null || e.total_expname! == ''
                        ? 0.toString()
                        : e.total_expname.toString()
                    : 0.toString())
                : double.parse(e.zser == zoneModels_report[index1].ser &&
                        e.expser! == '1' &&
                        e.room_number.toString() != 'ล็อคเสียบ'
                    ? e.total_expname == null || e.total_expname! == ''
                        ? 0.toString()
                        : e.total_expname.toString()
                    : 0.toString())).reduce((a, b) => a + b)).toString());
    return totalBills.toString();
  }

  String calculateTotalBills_Zone_Sub(int index1) {
    Set<String> uniqueDocnos = {};
    double totalBills = 0.0;

    totalBills = (_TransReBillModels_GropType_Sub_zone.length == 0)
        ? 0.00
        : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) =>
            (e.zser == null)
                ? double.parse(
                    e.zser1 == zoneModeels_report_Ser_Sub_zone[index1].ser &&
                            e.expser! == '1' &&
                            e.room_number.toString() != 'ล็อคเสียบ'
                        ? e.total_expname == null || e.total_expname! == ''
                            ? 0.toString()
                            : e.total_expname.toString()
                        : 0.toString())
                : double.parse(
                    e.zser == zoneModeels_report_Ser_Sub_zone[index1].ser &&
                            e.expser! == '1' &&
                            e.room_number.toString() != 'ล็อคเสียบ'
                        ? e.total_expname == null || e.total_expname! == ''
                            ? 0.toString()
                            : e.total_expname.toString()
                        : 0.toString())).reduce((a, b) => a + b)).toString());
    return totalBills.toString();
  }

  String calculateTotalBills_AllZone() {
    Set<String> uniqueDocnos = {};
    double totalAllBills = 0.0;

    for (int index = 0; index < zoneModels_report.length; index++) {
      totalAllBills += (_TransReBillModels_GropType_Mon.length == 0)
          ? 0.00
          : double.parse((_TransReBillModels_GropType_Mon.map((e) =>
              (e.zser == null)
                  ? double.parse(e.zser1 == zoneModels_report[index].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() != 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())
                  : double.parse(e.zser == zoneModels_report[index].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() != 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())).reduce((a, b) => a + b)).toString());
    }
    for (int index = 0; index < zoneModels_report.length; index++) {
      totalAllBills += (_TransReBillModels_GropType_Sub_zone.length == 0)
          ? 0.00
          : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) =>
              (e.zser == null)
                  ? double.parse(e.zser1 == zoneModels_report[index].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() != 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())
                  : double.parse(e.zser == zoneModels_report[index].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() != 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())).reduce((a, b) => a + b)).toString());
    }

    return totalAllBills.toString();
  }

  String calculateTotalArea_AllZone() {
    Set<String> uniqueDocnos = {};
    double totalAllArea = 0.0;

    for (int index = 0;
        index < _TransReBillModels_GropType_Mon.length;
        index++) {
      if (_TransReBillModels_GropType_Mon[index].room_number.toString() !=
          'ล็อคเสียบ') {
        if (!uniqueDocnos
            .contains(_TransReBillModels_GropType_Mon[index].docno)) {
          totalAllArea += double.parse(
              _TransReBillModels_GropType_Mon[index].area == null ||
                      _TransReBillModels_GropType_Mon[index].area! == ''
                  ? 1.toString()
                  : _TransReBillModels_GropType_Mon[index].area.toString());

          uniqueDocnos.add(_TransReBillModels_GropType_Mon[index].docno!);
        }
      }
    }
    for (int index = 0;
        index < _TransReBillModels_GropType_Sub_zone.length;
        index++) {
      if (_TransReBillModels_GropType_Sub_zone[index].room_number.toString() !=
          'ล็อคเสียบ') {
        if (!uniqueDocnos
            .contains(_TransReBillModels_GropType_Sub_zone[index].docno)) {
          totalAllArea += double.parse(
              _TransReBillModels_GropType_Sub_zone[index].area == null ||
                      _TransReBillModels_GropType_Sub_zone[index].area! == ''
                  ? 1.toString()
                  : _TransReBillModels_GropType_Sub_zone[index]
                      .area
                      .toString());

          uniqueDocnos.add(_TransReBillModels_GropType_Sub_zone[index].docno!);
        }
      }
    }

    return totalAllArea.toString();
  }

  String calculateTotal_B1_AllZone() {
    double total7Kana = 0.0;

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      (zoneModels_report[index1].jon! == '1' &&
              zoneModels_report[index1].jon_book! == '1')
          ? total7Kana += double.parse(calculateTotalBills_Zone(index1)!) -
              ((double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_1}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_2}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_3}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_4}')))
          : total7Kana += double.parse(calculateTotalArea_Zone(index1)!) *
              double.parse('${zoneModels_report[index1].b_1}');
    }

    for (int index2 = 0; index2 < zoneModels_report_Sub_zone.length; index2++) {
      total7Kana += double.parse(calculateTotal_B1_SubZone(
          '${zoneModels_report_Sub_zone[index2].ser}'));
    }

    return total7Kana.toString();
  }

  String calculateTotal_B1_SubZone(Subzone) {
    double total7Kana = 0.0;

    for (int index3 = 0;
        index3 < zoneModeels_report_Ser_Sub_zone.length;
        index3++) {
      if (zoneModeels_report_Ser_Sub_zone[index3].sub_zone.toString() ==
          '${Subzone}') {
        (zoneModeels_report_Ser_Sub_zone[index3].jon! == '1' &&
                zoneModeels_report_Ser_Sub_zone[index3].jon_book! == '1')
            ? total7Kana += double.parse(
                    calculateTotalBills_Zone_Sub(index3)!) -
                ((double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_1}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_2}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_3}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_4}')))
            : total7Kana += double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                double.parse('${zoneModeels_report_Ser_Sub_zone[index3].b_1}');
      }
    }

    return total7Kana.toString();
  }

  String calculateTotal_B2_AllZone() {
    double totalBA = 0.0;

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      (zoneModels_report[index1].jon! == '1' &&
              zoneModels_report[index1].jon_book! == '2')
          ? totalBA += double.parse(calculateTotalBills_Zone(index1)!) -
              ((double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_1}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_2}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_3}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_4}')))
          : totalBA += double.parse(calculateTotalArea_Zone(index1)!) *
              double.parse('${zoneModels_report[index1].b_2}');
      //////////------------------------>
      totalBA += (_TransReBillModels_GropType_Mon.length == 0)
          ? 0.00
          : double.parse((_TransReBillModels_GropType_Mon.map((e) =>
              (e.zser == null)
                  ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() == 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())
                  : double.parse(e.zser == zoneModels_report[index1].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() == 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())).reduce((a, b) => a + b)).toString());
      //////////------------------------>
      for (int index_exp = 0; index_exp < expModels.length; index_exp++) {
        if (expModels[index_exp].ser.toString() != '1') {
          totalBA += (_TransReBillModels_GropType_Mon.length == 0)
              ? 0.00
              : double.parse((_TransReBillModels_GropType_Mon.map((e) =>
                  (e.zser == null)
                      ? double.parse(e.zser1 == zoneModels_report[index1].ser &&
                              e.expser! == '${expModels[index_exp].ser}'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())
                      : double.parse(e.zser == zoneModels_report[index1].ser &&
                              e.expser! == '${expModels[index_exp].ser}'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())).reduce((a, b) => a + b)).toString());
        }
      }
      //////////------------------------>
    }

    for (int index2 = 0; index2 < zoneModels_report_Sub_zone.length; index2++) {
      ////---------------->
      totalBA += double.parse(calculateTotal_B2_SubZone(
          '${zoneModels_report_Sub_zone[index2].ser}'));
      ////---------------->
      totalBA += (_TransReBillModels_GropType_Sub_zone.length < 1)
          ? 0.00
          : (double.parse((_TransReBillModels_GropType_Sub_zone.map((e) =>
              (e.zser == null)
                  ? double.parse(
                      e.zser1 == zoneModels_report_Sub_zone[index2].ser &&
                              e.expser! == '1' &&
                              e.room_number.toString() == 'ล็อคเสียบ'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())
                  : double.parse(e.zser ==
                              zoneModels_report_Sub_zone[index2].ser &&
                          e.expser! == '1' &&
                          e.room_number.toString() == 'ล็อคเสียบ'
                      ? e.total_expname == null || e.total_expname! == ''
                          ? 0.toString()
                          : e.total_expname.toString()
                      : 0.toString())).reduce((a, b) => a + b)).toString()));
      ////---------------->
      for (int index_exp = 0; index_exp < expModels.length; index_exp++) {
        if (expModels[index_exp].ser.toString() != '1') {
          totalBA += (_TransReBillModels_GropType_Sub_zone.length == 0)
              ? 0.00
              : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) =>
                  (e.zser == null)
                      ? double.parse(e.zser1 == zoneModels_report[index2].ser &&
                              e.expser! == '${expModels[index_exp].ser}'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())
                      : double.parse(e.zser == zoneModels_report[index2].ser &&
                              e.expser! == '${expModels[index_exp].ser}'
                          ? e.total_expname == null || e.total_expname! == ''
                              ? 0.toString()
                              : e.total_expname.toString()
                          : 0.toString())).reduce((a, b) => a + b)).toString());
        }
      }
      ////---------------->
    }

    return totalBA.toString();
  }

  String calculateTotal_B2_SubZone(Subzone) {
    double totalBA = 0.0;

    for (int index3 = 0;
        index3 < zoneModeels_report_Ser_Sub_zone.length;
        index3++) {
      if (zoneModeels_report_Ser_Sub_zone[index3].sub_zone.toString() ==
          '${Subzone}') {
        (zoneModeels_report_Ser_Sub_zone[index3].jon! == '1' &&
                zoneModeels_report_Ser_Sub_zone[index3].jon_book! == '2')
            ? totalBA += double.parse(calculateTotalBills_Zone_Sub(index3)!) -
                ((double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_1}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_2}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_3}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_4}')))
            : totalBA += double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                double.parse('${zoneModeels_report_Ser_Sub_zone[index3].b_2}');
      }
    }

    return totalBA.toString();
  }

  String calculateTotal_B3_AllZone() {
    double totalB3 = 0.0;

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      (zoneModels_report[index1].jon! == '1' &&
              zoneModels_report[index1].jon_book! == '3')
          ? totalB3 += double.parse(calculateTotalBills_Zone(index1)!) -
              ((double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_1}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_2}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_3}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_4}')))
          : totalB3 += double.parse(calculateTotalArea_Zone(index1)!) *
              double.parse('${zoneModels_report[index1].b_3}');
    }

    for (int index2 = 0; index2 < zoneModels_report_Sub_zone.length; index2++) {
      totalB3 += double.parse(
          calculateTotal_B3_SubZone(zoneModels_report_Sub_zone[index2].ser));
    }

    //////////------------------------------------------->

    return totalB3.toString();
  }

  String calculateTotal_B3_SubZone(Subzone) {
    double totalB3 = 0.0;

    for (int in_dex = 0;
        in_dex < zoneModeels_report_Ser_Sub_zone.length;
        in_dex++) {
      if (zoneModeels_report_Ser_Sub_zone[in_dex].sub_zone.toString() ==
          '${Subzone}') {
        (_TransReBillModels_GropType_Sub_zone.length == 0)
            ? totalB3 += 0.00
            : (zoneModeels_report_Ser_Sub_zone[in_dex].jon! == '1' &&
                    zoneModeels_report_Ser_Sub_zone[in_dex].jon_book! == '3')
                ? totalB3 += (double.parse(calculateTotalBills_Zone_Sub(in_dex)!) -
                    ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) *
                            double.parse(
                                '${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) +
                        (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) *
                            double.parse(
                                '${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) +
                        (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) *
                            double.parse(
                                '${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) +
                        (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) *
                            double.parse(
                                '${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))
                : totalB3 +=
                    (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}'));
      }
    }

    return totalB3.toString();
  }

  String calculateTotal_B4_AllZone() {
    double totalB4 = 0.0;

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      (zoneModels_report[index1].jon! == '1' &&
              zoneModels_report[index1].jon_book! == '4')
          ? totalB4 += double.parse(calculateTotalBills_Zone(index1)!) -
              ((double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_1}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_2}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_3}')) +
                  (double.parse(calculateTotalArea_Zone(index1)!) *
                      double.parse('${zoneModels_report[index1].b_4}')))
          : totalB4 += double.parse(calculateTotalArea_Zone(index1)!) *
              double.parse('${zoneModels_report[index1].b_4}');
    }
    for (int index2 = 0; index2 < zoneModels_report_Sub_zone.length; index2++) {
      totalB4 += double.parse(
          calculateTotal_B4_SubZone(zoneModels_report_Sub_zone[index2].ser));
    }
    return totalB4.toString();
  }

  String calculateTotal_B4_SubZone(Subzone) {
    double totalB4 = 0.0;

    for (int index3 = 0;
        index3 < zoneModeels_report_Ser_Sub_zone.length;
        index3++) {
      if (zoneModeels_report_Ser_Sub_zone[index3].sub_zone.toString() ==
          '${Subzone}') {
        (zoneModeels_report_Ser_Sub_zone[index3].jon! == '1' &&
                zoneModeels_report_Ser_Sub_zone[index3].jon_book! == '4')
            ? totalB4 += double.parse(calculateTotalBills_Zone_Sub(index3)!) -
                ((double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_1}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_2}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_3}')) +
                    (double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                        double.parse(
                            '${zoneModeels_report_Ser_Sub_zone[index3].b_4}')))
            : totalB4 += double.parse(calculateTotalArea_Zone_Sub(index3)!) *
                double.parse('${zoneModeels_report_Ser_Sub_zone[index3].b_4}');
      }
    }

    return totalB4.toString();
  }

  String calculateTotal_Expstser4() {
    double Total_zone = 0.00;
    double Total_Sub_zone = 0.00;

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      Total_zone += (_TransReBillModels_GropType_Mon.length == 0)
          ? 0.00
          : double.parse(
              '${(_TransReBillModels_GropType_Mon.length == 0) ? 0.00 : double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report[index1].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report[index1].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString())}');
    }
    for (int index3 = 0; index3 < zoneModels_report_Sub_zone.length; index3++) {
      Total_Sub_zone += (_TransReBillModels_GropType_Sub_zone.length == 0)
          ? 0.00
          : double.parse(
              '${(_TransReBillModels_GropType_Sub_zone.length == 0) ? 0.00 : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report_Sub_zone[index3].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report_Sub_zone[index3].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report_Sub_zone[index3].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report_Sub_zone[index3].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString())}');
    }
    double sum_all = Total_zone + Total_Sub_zone;
    return sum_all.toString();
  }

  Future<Null> red_Trans_bill_Groptype_daly() async {
    if (_TransReBillModels_GropType_Mon.length != 0) {
      setState(() {
        _TransReBillModels_GropType_Mon.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_DailyReport_CMma_type.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily_Type_&ldate=$Value_select_lastDate_Daily_Type_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM transReBillModel =
              TransReBillModelRECM.fromJson(map);

          setState(() {
            _TransReBillModels_GropType_Mon.add(transReBillModel);
          });
        }

        // print('result ${_TransReBillModels_GropType_Mon.length}');
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill_Groptype_daly_Sub_zone() async {
    if (_TransReBillModels_GropType_Sub_zone.length != 0) {
      setState(() {
        _TransReBillModels_GropType_Sub_zone.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_DailyReport_CMma_type_Sub_zone.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily_Type_&ldate=$Value_select_lastDate_Daily_Type_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM transReBillModel =
              TransReBillModelRECM.fromJson(map);

          setState(() {
            _TransReBillModels_GropType_Sub_zone.add(transReBillModel);
          });
        }

        // print('result ${_TransReBillModels_GropType_Sub_zone.length}');
      }
    } catch (e) {}
  }

////////////-----------------------(วันที่รายงาน รายชื่อผู้เช่ารายวันแยกตามประเภท)
  String first_Date = '2023-09-01';
  String last_Date = '2023-09-05';
  Future<Null> _select_Date_Daily_type(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
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
        // TransReBillModels = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_select_lastDate_Daily_Type_ = null;
          Value_selectDate_Daily_Type_ = "${formatter.format(result)}";
        });
        // red_Trans_bill();
      }
    });
  }

  Future<Null> _select_LastDate_Daily_type(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
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
    picked.then((result) async {
      var SDate =
          DateFormat('dd-MM-yyyy').parse('$Value_selectDate_Daily_Type_');
      var LDate = DateFormat('dd-MM-yyyy').parse('$result');
      if (picked != null) {
        // print('LDate is before SDate');
        // TransReBillModels = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_select_lastDate_Daily_Type_ = "${formatter.format(result)}";
        });
        // red_Trans_bill();
      }
      // if (LDate.isBefore(SDate)) {
      // } else {
      //   if (picked != null) {
      //     print('LDate is before SDate');
      //     // TransReBillModels = [];

      //     var formatter = DateFormat('y-MM-d');
      //     print("${formatter.format(result!)}");
      //     setState(() {
      //       Value_select_lastDate_Daily_Type_ = "${formatter.format(result)}";
      //     });
      //     // red_Trans_bill();
      //   }
      // }
    });
  }

/////////////////---------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(seconds: 4), () {
            Navigator.of(context).pop();
          });
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

    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext builderContext) {
    //       Timer(Duration(seconds: 3), () {
    //         Navigator.of(context).pop();
    //       });

    //       return AlertDialog(
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         content: Container(
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //       );
    //     });
  }

  /////////////////---------------------------->
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child:
                ListView(padding: const EdgeInsets.all(8), children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.lime[200],

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'พิเศษ : เครือตลาดประตูเชียงใหม่ ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: Font_.Fonts_T,
                    ),
                  ),
                ),
              ),
              ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
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
                            value: Mon_Income_Type_Mon_User,
                            // hint: Text(
                            //   Mon_Income == null
                            //       ? 'เลือก'
                            //       : '$Mon_Income',
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
                              for (int item = 1; item < 13; item++)
                                DropdownMenuItem<String>(
                                  value: '${item}',
                                  child: Text(
                                    '${monthsInThai[item - 1]}',
                                    //'${item}',
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
                              Mon_Income_Type_Mon_User = value;

                              // if (Value_Chang_Zone_Income !=
                              //     null) {
                              //   red_Trans_billIncome();
                              //   red_Trans_billMovemen();
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
                            value: YE_Income_Type_Mon_User,
                            // hint: Text(
                            //   YE_Income == null
                            //       ? 'เลือก'
                            //       : '$YE_Income',
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
                              YE_Income_Type_Mon_User = value;

                              // if (Value_Chang_Zone_Income !=
                              //     null) {
                              //   red_Trans_billIncome();
                              //   red_Trans_billMovemen();
                              // }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              Value_selectDate_Daily_Type_ = null;
                              Value_select_lastDate_Daily_Type_ = null;
                            });

                            if (YE_Income_Type_Mon_User != null &&
                                Mon_Income_Type_Mon_User != null) {
                              Dia_log();
                              red_Trans_bill_Groptype_Mon();
                              red_Trans_bill_Groptype_Mon_Sub_zone();
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
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'เรียกดู',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (_TransReBillModels_GropType_Mon.length == 0 &&
                            _TransReBillModels_GropType_Sub_zone.length == 0 &&
                            Value_selectDate_Daily_Type_ == null &&
                            Value_select_lastDate_Daily_Type_ == null)
                        ? null
                        : (YE_Income_Type_Mon_User == null ||
                                Mon_Income_Type_Mon_User == null)
                            ? null
                            : () {
                                RE_IncomeMont_Type_Widget();
                              },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (Value_selectDate_Daily_Type_ != null ||
                              Value_select_lastDate_Daily_Type_ != null)
                          ? 'รายงาน รายรับแยกตามประเภท (รายเดือน)'
                          : (_TransReBillModels_GropType_Mon.length != 0 ||
                                  _TransReBillModels_GropType_Sub_zone.length !=
                                      0)
                              ? (YE_Income_Type_Mon_User != null &&
                                          Mon_Income_Type_Mon_User != null ||
                                      _TransReBillModels_GropType_Mon.length !=
                                          0 ||
                                      _TransReBillModels_GropType_Sub_zone
                                              .length !=
                                          0)
                                  ? 'รายงาน รายรับแยกตามประเภท (รายเดือน) (พบข้อมูล ✔️)'
                                  : 'รายงาน รายรับแยกตามประเภท (รายเดือน) (ไม่พบข้อมูล ✖️)'
                              : 'รายงาน รายรับแยกตามประเภท (รายเดือน)',
                      // (YE_Income_Type_Mon_User != null &&
                      //         _TransReBillModels_GropType_Mon.length == 0 &&
                      //         Mon_Income_Type_Mon_User != null)
                      //     ? 'รายงาน รายรับแยกตามประเภท (รายเดือน) (ไม่พบข้อมูล ✖️)'
                      //     : (YE_Income_Type_Mon_User != null &&
                      //             _TransReBillModels_GropType_Mon.length != 0 &&
                      //             Mon_Income_Type_Mon_User != null)
                      //         ? 'รายงาน รายรับแยกตามประเภท (รายเดือน) (ไม่พบข้อมูล ✔️)'
                      //         : 'รายงาน รายรับแยกตามประเภท (รายเดือน)',
                      style: const TextStyle(
                        color: ReportScreen_Color.Colors_Text2_,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 4.0,
                    child: Divider(
                      color: Colors.grey[300],
                      height: 4.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'วันที่ :',
                      style: TextStyle(
                        color: ReportScreen_Color.Colors_Text2_,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _select_Date_Daily_type(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          width: 120,
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              (Value_selectDate_Daily_Type_ == null)
                                  ? 'เลือก'
                                  : '$Value_selectDate_Daily_Type_',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      (Value_selectDate_Daily_Type_ != null)
                          ? 'ถึง  ( กรุณาเลือกวันที่เริ่ม )'
                          : 'ถึง',
                      style: const TextStyle(
                        color: ReportScreen_Color.Colors_Text2_,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T,
                      ),
                    ),
                  ),
                  if (Value_selectDate_Daily_Type_ != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _select_LastDate_Daily_type(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: AppbackgroundColor.Sub_Abg_Colors,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            width: 120,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                (Value_select_lastDate_Daily_Type_ == null)
                                    ? 'เลือก'
                                    : '$Value_select_lastDate_Daily_Type_',
                                style: const TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            )),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          YE_Income_Type_Mon_User = null;
                          Mon_Income_Type_Mon_User = null;
                          _TransReBillModels_GropType_Mon.clear();
                          _TransReBillModels_GropType_Sub_zone.clear();
                        });

                        if (Value_select_lastDate_Daily_Type_ != null &&
                            Value_selectDate_Daily_Type_ != null) {
                          Dia_log();
                          red_Trans_bill_Groptype_daly();
                          red_Trans_bill_Groptype_daly_Sub_zone();
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
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'เรียกดู',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (YE_Income_Type_Mon_User != null ||
                            Mon_Income_Type_Mon_User != null)
                        ? null
                        : (Value_selectDate_Daily_Type_ == null ||
                                Value_select_lastDate_Daily_Type_ == null)
                            ? null
                            : () {
                                RE_Income_Daily_Type_Widget();
                              },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (YE_Income_Type_Mon_User != null ||
                              Mon_Income_Type_Mon_User != null)
                          ? 'รายงาน รายรับแยกตามประเภท (รายสัปดาห์)'
                          : (_TransReBillModels_GropType_Mon.length != 0 ||
                                  _TransReBillModels_GropType_Sub_zone.length !=
                                      0)
                              ? (Value_selectDate_Daily_Type_ != null &&
                                          Value_select_lastDate_Daily_Type_ !=
                                              null ||
                                      _TransReBillModels_GropType_Mon.length !=
                                          0 ||
                                      _TransReBillModels_GropType_Sub_zone
                                              .length !=
                                          0)
                                  ? 'รายงาน รายรับแยกตามประเภท (รายสัปดาห์) (พบข้อมูล ✔️)'
                                  : 'รายงาน รายรับแยกตามประเภท (รายสัปดาห์) (ไม่พบข้อมูล ✖️)'
                              : 'รายงาน รายรับแยกตามประเภท (รายสัปดาห์)',
                      style: const TextStyle(
                        color: ReportScreen_Color.Colors_Text2_,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T,
                      ),
                    ),
                  ),
                ],
              ),
            ])));
  }

  RE_IncomeMont_Type_Widget() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              const Center(
                  child: Text(
                'รายงาน รายรับแยกตามประเภท (รายเดือน)',
                style: TextStyle(
                  color: ReportScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T,
                ),
              )),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        (YE_Income_Type_Mon_User == null)
                            ? 'เดือน: ?'
                            : 'เดือน: ${monthsInThai[int.parse('${Mon_Income_Type_Mon_User}') - 1]} ($YE_Income_Type_Mon_User)',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: ReportScreen_Color.Colors_Text1_,
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        'ทั้งหมด: ${zoneModels_report.length}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ReportScreen_Color.Colors_Text1_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 1),
              const Divider(),
              const SizedBox(height: 1),
            ],
          ),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 0)),
              builder: (context, snapshot) {
                return ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          Container(
                            // color: Colors.grey[50],
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.925
                                : (_TransReBillModels_GropType_Mon.length == 0)
                                    ? MediaQuery.of(context).size.width
                                    : 1200,
                            child: Column(
                              children: [
                                Container(
                                  // width: 1050,
                                  decoration: BoxDecoration(
                                    color: AppbackgroundColor.TiTile_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'โซน',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'ยอดเต็ม',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Text(
                                      //     'ยอดหักส่วนลด',
                                      //     textAlign:
                                      //         TextAlign
                                      //             .right,
                                      //     style:
                                      //         TextStyle(
                                      //       color: ReportScreen_Color
                                      //           .Colors_Text1_,
                                      //       fontWeight:
                                      //           FontWeight
                                      //               .bold,
                                      //       fontFamily:
                                      //           FontWeight_
                                      //               .Fonts_T,
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'เมตร',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '7คณา',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'บริหาร',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Text(
                                      //     'ธนาคาร',
                                      //     textAlign: TextAlign.center,
                                      //     style: TextStyle(
                                      //       color: ReportScreen_Color.Colors_Text1_,
                                      //       fontWeight: FontWeight.bold,
                                      //       fontFamily: FontWeight_.Fonts_T,
                                      //     ),
                                      //   ),
                                      // ),

                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'บ.3',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'บ.4',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child:
                                        // (_TransReBillModels_GropType_Mon
                                        //                 .length <
                                        //             1 &&
                                        //         _TransReBillModels_GropType_Sub_zone
                                        //                 .length <
                                        //             1)
                                        //     ? const Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Center(
                                        //             child: Text(
                                        //               'ไม่พบข้อมูล ',
                                        //               style: TextStyle(
                                        //                 color: ReportScreen_Color
                                        //                     .Colors_Text1_,
                                        //                 fontWeight: FontWeight.bold,
                                        //                 fontFamily:
                                        //                     FontWeight_.Fonts_T,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       )
                                        //     :
                                        SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int index1 = 0;
                                          index1 < zoneModels_report.length;
                                          index1++)
                                        if (zoneModels_report[index1]
                                                .sub_zone
                                                .toString() ==
                                            '0')
                                          ListTile(
                                            title: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black12,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 4),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${zoneModels_report[index1].zn}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight: FontWeight.w100,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          // '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!))}',

                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '${nFormat.format(double.parse(calculateTotalBills_Sumdis_Zone(index1)!))}',
                                                      //     textAlign: TextAlign.right,
                                                      //     style: TextStyle(
                                                      //       color: ('${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!))}' == '0.00') ? Colors.red[400] : ReportScreen_Color.Colors_Text1_,
                                                      //       // fontWeight: FontWeight.bold,
                                                      //       fontFamily: Font_.Fonts_T,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '1')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}'))}',

                                                          // 'คูณ ${zoneModels_report[index1].b_1}',

                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '2')
                                                                  ?
                                                                  //'${calculateTotalBills_Zone(index1)}'

                                                                  //'${calculateTotalBills_Zone(index1)} - [ ( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_1})+ ( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_2}) +( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_3}) + ( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_4})'
                                                                  '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '3')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '4')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))}',
                                                          // 'คูณ ${zoneModels_report[index1].b_4}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //////////////------------------------------------------------>

                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '- ล็อคเสียบ/ขาจร',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  for (int index_exp = 0;
                                                      index_exp <
                                                          expModels.length;
                                                      index_exp++)
                                                    if (expModels[index_exp]
                                                            .ser
                                                            .toString() !=
                                                        '1')
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '- ${expModels[index_exp].expname}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          // const Expanded(
                                                          //   flex: 1,
                                                          //   child: Text(
                                                          //     '',
                                                          //     textAlign: TextAlign.right,
                                                          //     style: TextStyle(
                                                          //       color: ReportScreen_Color.Colors_Text1_,
                                                          //       // fontWeight: FontWeight.bold,
                                                          //       fontFamily: Font_.Fonts_T,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              (_TransReBillModels_GropType_Mon
                                                                          .length <
                                                                      1)
                                                                  ? '0.00'
                                                                  : '${nFormat.format(double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '- อื่นๆ ',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      // const Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '',
                                                      //     textAlign: TextAlign.right,
                                                      //     style: TextStyle(
                                                      //       color: ReportScreen_Color.Colors_Text1_,
                                                      //       // fontWeight: FontWeight.bold,
                                                      //       fontFamily: Font_.Fonts_T,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse('${(_TransReBillModels_GropType_Mon.length == 0) ? 0.00 : double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report[index1].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report[index1].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString())}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      for (int index3 = 0;
                                          index3 <
                                              zoneModels_report_Sub_zone.length;
                                          index3++)
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black12,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      //  '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      '${zoneModels_report_Sub_zone[index3].zn} ',

                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              for (int in_dex = 0;
                                                  in_dex <
                                                      zoneModeels_report_Ser_Sub_zone
                                                          .length;
                                                  in_dex++)
                                                if (zoneModeels_report_Ser_Sub_zone[
                                                            in_dex]
                                                        .sub_zone
                                                        .toString() ==
                                                    zoneModels_report_Sub_zone[
                                                            index3]
                                                        .ser
                                                        .toString())
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          //  '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          '** ${zoneModeels_report_Ser_Sub_zone[in_dex].zn} ',

                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.w100,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModeels_report_Ser_Sub_zone[in_dex].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModeels_report_Ser_Sub_zone[in_dex].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '1')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}'))}',

                                                          // 'คูณ ${zoneModels_report[index1].b_1}',

                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '2')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '3')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '4')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))}',
                                                          // 'คูณ ${zoneModels_report[index1].b_4}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      // '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      'รวม :',

                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : ' ${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B1_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B2_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B3_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B4_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '- ล็อคเสียบ/ขาจร',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              for (int index_exp = 0;
                                                  index_exp < expModels.length;
                                                  index_exp++)
                                                if (expModels[index_exp]
                                                        .ser
                                                        .toString() !=
                                                    '1')
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '- ${expModels[index_exp].expname}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      // const Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '',
                                                      //     textAlign: TextAlign.right,
                                                      //     style: TextStyle(
                                                      //       color: ReportScreen_Color.Colors_Text1_,
                                                      //       // fontWeight: FontWeight.bold,
                                                      //       fontFamily: Font_.Fonts_T,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone! == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.sub_zone! == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '- อื่นๆ ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  // const Expanded(
                                                  //   flex: 1,
                                                  //   child: Text(
                                                  //     '',
                                                  //     textAlign: TextAlign.right,
                                                  //     style: TextStyle(
                                                  //       color: ReportScreen_Color.Colors_Text1_,
                                                  //       // fontWeight: FontWeight.bold,
                                                  //       fontFamily: Font_.Fonts_T,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse('${(_TransReBillModels_GropType_Sub_zone.length == 0) ? 0.00 : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report_Sub_zone[index3].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report_Sub_zone[index3].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report_Sub_zone[index3].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report_Sub_zone[index3].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString())}'))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ])));
              }),
          actions: <Widget>[
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 0)),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 20, 4),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120,
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.925
                                  : (_TransReBillModels_GropType_Mon.length ==
                                          0)
                                      ? MediaQuery.of(context).size.width
                                      : 1200,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวม ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมยอดเต็ม',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child:
                                          //       Text(
                                          //     'รวมหักส่วนล',
                                          //     textAlign:
                                          //         TextAlign.right,
                                          //     style:
                                          //         TextStyle(
                                          //       color:
                                          //           ReportScreen_Color.Colors_Text1_,
                                          //       fontWeight:
                                          //           FontWeight.bold,
                                          //       fontFamily:
                                          //           FontWeight_.Fonts_T,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมเมตร',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวม7คณา',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมบริหาร',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมบ.3',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมบ.4',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotalBills_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child:
                                          //       Text(
                                          //     (_TransReBillModels_GropType.length ==
                                          //             0)
                                          //         ? '0.00'
                                          //         : '${nFormat.format(double.parse('${calculateTotalBills_Sumdis_AllZone().toString()}'))}',
                                          //     textAlign:
                                          //         TextAlign.right,
                                          //     style:
                                          //         const TextStyle(
                                          //       color:
                                          //           ReportScreen_Color.Colors_Text1_,
                                          //       fontFamily:
                                          //           Font_.Fonts_T,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotalArea_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight:
                                                //     FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotal_B1_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight:
                                                //     FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? calculateTotal_Expstser4()
                                                  : '${nFormat.format(double.parse('${calculateTotal_B2_AllZone().toString()}') + double.parse('${calculateTotal_Expstser4()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight:
                                                //     FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotal_B3_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotal_B4_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 1),
            const Divider(),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 0)),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ///_TransReBillModels_GropType_Sub_zone _TransReBillModels_GropType_Mon
                          if (_TransReBillModels_GropType_Sub_zone.length !=
                                  0 ||
                              _TransReBillModels_GropType_Mon.length != 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Container(
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
                                    child: Text(
                                      'Export file',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (_TransReBillModels_GropType_Sub_zone
                                              .length ==
                                          0 &&
                                      _TransReBillModels_GropType_Mon.length ==
                                          0) {
                                  } else {
                                    setState(() {
                                      Value_Report =
                                          'รายงานรายรับแยกตามประเภทรายเดือน';
                                      Pre_and_Dow = 'Download';
                                    });
                                    _showMyDialog_SAVE();
                                  }
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'ปิด',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  Mon_Income_Type_Mon_User = null;
                                  YE_Income_Type_Mon_User = null;
                                  _TransReBillModels_GropType_Mon.clear();
                                  _TransReBillModels_GropType_Sub_zone.clear();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }

/////////------------------------------------------------->
  RE_Income_Daily_Type_Widget() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                const Center(
                    child: Text(
                  'รายงาน รายรับแยกตามประเภท (รายสัปดาห์) ',
                  style: TextStyle(
                    color: ReportScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          (Value_selectDate_Daily_Type_ == null ||
                                  Value_select_lastDate_Daily_Type_ == null)
                              ? 'วันที่: ?'
                              : 'วันที่: ${Value_selectDate_Daily_Type_} ถึง $Value_select_lastDate_Daily_Type_',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: ReportScreen_Color.Colors_Text1_,
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          'ทั้งหมด: ${zoneModels_report.length}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 14,
                            color: ReportScreen_Color.Colors_Text1_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 1),
                const Divider(),
                const SizedBox(height: 1),
              ],
            ),
          ),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 0)),
              builder: (context, snapshot) {
                return ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          Container(
                            // color: Colors.grey[50],
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.925
                                : (_TransReBillModels_GropType_Mon.length == 0)
                                    ? MediaQuery.of(context).size.width
                                    : 1200,
                            child: Column(
                              children: [
                                Container(
                                  // width: 1050,
                                  decoration: BoxDecoration(
                                    color: AppbackgroundColor.TiTile_Colors,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'โซน',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'ยอดเต็ม',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Text(
                                      //     'ยอดหักส่วนลด',
                                      //     textAlign:
                                      //         TextAlign
                                      //             .right,
                                      //     style:
                                      //         TextStyle(
                                      //       color: ReportScreen_Color
                                      //           .Colors_Text1_,
                                      //       fontWeight:
                                      //           FontWeight
                                      //               .bold,
                                      //       fontFamily:
                                      //           FontWeight_
                                      //               .Fonts_T,
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'เมตร',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '7คณา',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'บริหาร',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Text(
                                      //     'ธนาคาร',
                                      //     textAlign: TextAlign.center,
                                      //     style: TextStyle(
                                      //       color: ReportScreen_Color.Colors_Text1_,
                                      //       fontWeight: FontWeight.bold,
                                      //       fontFamily: FontWeight_.Fonts_T,
                                      //     ),
                                      //   ),
                                      // ),

                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'บ.3',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'บ.4',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child:
                                        // (_TransReBillModels_GropType_Mon
                                        //                 .length <
                                        //             1 &&
                                        //         _TransReBillModels_GropType_Sub_zone
                                        //                 .length <
                                        //             1)
                                        //     ? const Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Center(
                                        //             child: Text(
                                        //               'ไม่พบข้อมูล ',
                                        //               style: TextStyle(
                                        //                 color: ReportScreen_Color
                                        //                     .Colors_Text1_,
                                        //                 fontWeight: FontWeight.bold,
                                        //                 fontFamily:
                                        //                     FontWeight_.Fonts_T,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       )
                                        //     :
                                        SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int index1 = 0;
                                          index1 < zoneModels_report.length;
                                          index1++)
                                        if (zoneModels_report[index1]
                                                .sub_zone
                                                .toString() ==
                                            '0')
                                          ListTile(
                                            title: Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black12,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 4),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${zoneModels_report[index1].zn}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight: FontWeight.w100,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          // '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!))}',

                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '${nFormat.format(double.parse(calculateTotalBills_Sumdis_Zone(index1)!))}',
                                                      //     textAlign: TextAlign.right,
                                                      //     style: TextStyle(
                                                      //       color: ('${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!))}' == '0.00') ? Colors.red[400] : ReportScreen_Color.Colors_Text1_,
                                                      //       // fontWeight: FontWeight.bold,
                                                      //       fontFamily: Font_.Fonts_T,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '1')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}'))}',

                                                          // 'คูณ ${zoneModels_report[index1].b_1}',

                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '2')
                                                                  ?
                                                                  //'${calculateTotalBills_Zone(index1)}'

                                                                  //'${calculateTotalBills_Zone(index1)} - [ ( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_1})+ ( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_2}) +( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_3}) + ( ${calculateTotalArea_Zone(index1)} x ${zoneModels_report[index1].b_4})'
                                                                  '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '3')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : (zoneModels_report[index1]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModels_report[index1]
                                                                              .jon_book! ==
                                                                          '4')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone(index1)!) - ((double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_1}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_2}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_3}')) + (double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone(index1)!) * double.parse('${zoneModels_report[index1].b_4}'))}',
                                                          // 'คูณ ${zoneModels_report[index1].b_4}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //////////////------------------------------------------------>

                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '- ล็อคเสียบ/ขาจร',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length <
                                                                  1)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  for (int index_exp = 0;
                                                      index_exp <
                                                          expModels.length;
                                                      index_exp++)
                                                    if (expModels[index_exp]
                                                            .ser
                                                            .toString() !=
                                                        '1')
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '- ${expModels[index_exp].expname}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          // const Expanded(
                                                          //   flex: 1,
                                                          //   child: Text(
                                                          //     '',
                                                          //     textAlign: TextAlign.right,
                                                          //     style: TextStyle(
                                                          //       color: ReportScreen_Color.Colors_Text1_,
                                                          //       // fontWeight: FontWeight.bold,
                                                          //       fontFamily: Font_.Fonts_T,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              (_TransReBillModels_GropType_Mon
                                                                          .length <
                                                                      1)
                                                                  ? '0.00'
                                                                  : '${nFormat.format(double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '- อื่นๆ ',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      // const Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '',
                                                      //     textAlign: TextAlign.right,
                                                      //     style: TextStyle(
                                                      //       color: ReportScreen_Color.Colors_Text1_,
                                                      //       // fontWeight: FontWeight.bold,
                                                      //       fontFamily: Font_.Fonts_T,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Mon
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse('${(_TransReBillModels_GropType_Mon.length == 0) ? 0.00 : double.parse((_TransReBillModels_GropType_Mon.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report[index1].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report[index1].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report[index1].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report[index1].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString())}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      for (int index3 = 0;
                                          index3 <
                                              zoneModels_report_Sub_zone.length;
                                          index3++)
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black12,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      //  '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      '${zoneModels_report_Sub_zone[index3].zn} ',

                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              for (int in_dex = 0;
                                                  in_dex <
                                                      zoneModeels_report_Ser_Sub_zone
                                                          .length;
                                                  in_dex++)
                                                if (zoneModeels_report_Ser_Sub_zone[
                                                            in_dex]
                                                        .sub_zone
                                                        .toString() ==
                                                    zoneModels_report_Sub_zone[
                                                            index3]
                                                        .ser
                                                        .toString())
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          //  '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          '** ${zoneModeels_report_Ser_Sub_zone[in_dex].zn} ',

                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.w100,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModeels_report_Ser_Sub_zone[in_dex].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModeels_report_Ser_Sub_zone[in_dex].ser && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '1')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}'))}',

                                                          // 'คูณ ${zoneModels_report[index1].b_1}',

                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '2')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '3')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}'))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : (zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon! ==
                                                                          '1' &&
                                                                      zoneModeels_report_Ser_Sub_zone[in_dex]
                                                                              .jon_book! ==
                                                                          '4')
                                                                  ? '${nFormat.format(double.parse(calculateTotalBills_Zone_Sub(in_dex)!) - ((double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_1}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_2}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_3}')) + (double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))))}'
                                                                  : '${nFormat.format(double.parse(calculateTotalArea_Zone_Sub(in_dex)!) * double.parse('${zoneModeels_report_Ser_Sub_zone[in_dex].b_4}'))}',
                                                          // 'คูณ ${zoneModels_report[index1].b_4}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      // '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '1' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      'รวม :',

                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : ' ${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString()) : double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() != 'ล็อคเสียบ' ? e.area == null || e.area! == '' ? 0.toString() : e.area.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B1_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B2_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B3_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse(calculateTotal_B4_SubZone('${zoneModels_report_Sub_zone[index3].ser}')))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '- ล็อคเสียบ/ขาจร',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.sub_zone == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '1' && e.room_number.toString() == 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              for (int index_exp = 0;
                                                  index_exp < expModels.length;
                                                  index_exp++)
                                                if (expModels[index_exp]
                                                        .ser
                                                        .toString() !=
                                                    '1')
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '- ${expModels[index_exp].expname}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      // const Expanded(
                                                      //   flex: 1,
                                                      //   child: Text(
                                                      //     '',
                                                      //     textAlign: TextAlign.right,
                                                      //     style: TextStyle(
                                                      //       color: ReportScreen_Color.Colors_Text1_,
                                                      //       // fontWeight: FontWeight.bold,
                                                      //       fontFamily: Font_.Fonts_T,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          (_TransReBillModels_GropType_Sub_zone
                                                                      .length ==
                                                                  0)
                                                              ? '0.00'
                                                              : '${nFormat.format(double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.sub_zone! == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.sub_zone! == '${zoneModels_report_Sub_zone[index3].ser}' && e.expser! == '${expModels[index_exp].ser}' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString()))}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '- อื่นๆ ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  // const Expanded(
                                                  //   flex: 1,
                                                  //   child: Text(
                                                  //     '',
                                                  //     textAlign: TextAlign.right,
                                                  //     style: TextStyle(
                                                  //       color: ReportScreen_Color.Colors_Text1_,
                                                  //       // fontWeight: FontWeight.bold,
                                                  //       fontFamily: Font_.Fonts_T,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (_TransReBillModels_GropType_Sub_zone
                                                                  .length ==
                                                              0)
                                                          ? '0.00'
                                                          : '${nFormat.format(double.parse('${(_TransReBillModels_GropType_Sub_zone.length == 0) ? 0.00 : double.parse((_TransReBillModels_GropType_Sub_zone.map((e) => (e.zser == null) ? double.parse(e.zser1 == zoneModels_report_Sub_zone[index3].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report_Sub_zone[index3].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString()) : double.parse(e.zser == zoneModels_report_Sub_zone[index3].ser && e.expser! == '4' && e.expname.toString() == 'อื่นๆ(ค่า${zoneModels_report_Sub_zone[index3].zn})' && e.room_number.toString() != 'ล็อคเสียบ' ? e.total_expname == null || e.total_expname! == '' ? 0.toString() : e.total_expname.toString() : 0.toString())).reduce((a, b) => a + b)).toString())}'))}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ])));
              }),
          actions: <Widget>[
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 0)),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 20, 4),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120,
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.925
                                  : (_TransReBillModels_GropType_Mon.length ==
                                          0)
                                      ? MediaQuery.of(context).size.width
                                      : 1200,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวม',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมยอดเต็ม',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child:
                                          //       Text(
                                          //     'รวมหักส่วนล',
                                          //     textAlign:
                                          //         TextAlign.right,
                                          //     style:
                                          //         TextStyle(
                                          //       color:
                                          //           ReportScreen_Color.Colors_Text1_,
                                          //       fontWeight:
                                          //           FontWeight.bold,
                                          //       fontFamily:
                                          //           FontWeight_.Fonts_T,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมเมตร',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวม7คณา',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมบริหาร',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมบ.3',
                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                              //  '${_TransReBillModels[index1].ramtd}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมบ.4',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotalBills_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child:
                                          //       Text(
                                          //     (_TransReBillModels_GropType.length ==
                                          //             0)
                                          //         ? '0.00'
                                          //         : '${nFormat.format(double.parse('${calculateTotalBills_Sumdis_AllZone().toString()}'))}',
                                          //     textAlign:
                                          //         TextAlign.right,
                                          //     style:
                                          //         const TextStyle(
                                          //       color:
                                          //           ReportScreen_Color.Colors_Text1_,
                                          //       fontFamily:
                                          //           Font_.Fonts_T,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotalArea_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight:
                                                //     FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotal_B1_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight:
                                                //     FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? calculateTotal_Expstser4()
                                                  : '${nFormat.format(double.parse('${calculateTotal_B2_AllZone().toString()}') + double.parse('${calculateTotal_Expstser4()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight:
                                                //     FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Text(
                                          //     (_TransReBillModels_GropType_Mon
                                          //                     .length ==
                                          //                 0 &&
                                          //             _TransReBillModels_GropType_Sub_zone
                                          //                     .length ==
                                          //                 0)
                                          //         ? '0.00'
                                          //         : '${nFormat.format(double.parse('${calculateTotal_B2_AllZone().toString()}'))}',
                                          //     textAlign: TextAlign.right,
                                          //     style: const TextStyle(
                                          //       color: ReportScreen_Color
                                          //           .Colors_Text1_,
                                          //       // fontWeight:
                                          //       //     FontWeight.bold,
                                          //       fontFamily: Font_.Fonts_T,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotal_B3_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_GropType_Mon
                                                              .length ==
                                                          0 &&
                                                      _TransReBillModels_GropType_Sub_zone
                                                              .length ==
                                                          0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse('${calculateTotal_B4_AllZone().toString()}'))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 1),
            const Divider(),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 0)),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ///_TransReBillModels_GropType_Sub_zone _TransReBillModels_GropType_Mon
                          if (_TransReBillModels_GropType_Sub_zone.length !=
                                  0 ||
                              _TransReBillModels_GropType_Mon.length != 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Container(
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Center(
                                    child: Text(
                                      'Export file',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (_TransReBillModels_GropType_Sub_zone
                                              .length ==
                                          0 &&
                                      _TransReBillModels_GropType_Mon.length ==
                                          0) {
                                  } else {
                                    setState(() {
                                      Value_Report =
                                          'รายงานรายรับรายวันแยกตามประเภท';
                                      Pre_and_Dow = 'Download';
                                    });
                                    _showMyDialog_SAVE();
                                  }
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'ปิด',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  Value_select_lastDate_Daily_Type_ = null;
                                  Value_selectDate_Daily_Type_ = null;
                                  Mon_Income_Type_Mon_User = null;
                                  YE_Income_Type_Mon_User = null;
                                  _TransReBillModels_GropType_Mon.clear();
                                  _TransReBillModels_GropType_Sub_zone.clear();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }

////////////------------------------------------------------------>(Export file)
  Future<void> _showMyDialog_SAVE() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 0)),
          builder: (context, snapshot) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                title: Container(
                  width: 300,
                  height: 50,
                  child: Stack(
                    children: [
                      Container(
                        width: 200,
                        child: Center(
                          child: Text(
                            '$Value_Report',
                            style: const TextStyle(
                              color: ReportScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            // width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'ปิด',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      const Text(
                        'สกุลไฟล์ :',
                        style: TextStyle(
                          color: ReportScreen_Color.Colors_Text2_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: Font_.Fonts_T,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          groupValue: _verticalGroupValue_PassW,
                          horizontalAlignment: MainAxisAlignment.spaceAround,
                          onChanged: (value) {
                            setState(() {
                              FormNameFile_text.clear();
                            });
                            setState(() {
                              _verticalGroupValue_PassW = value ?? '';
                            });
                          },
                          items: const <String>[
                            // "PDF",
                            "EXCEL",
                          ],
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: ReportScreen_Color.Colors_Text2_,
                            // fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T,
                          ),
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () async {
                            InkWell_onTap(context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 25,
                                backgroundImage: (_verticalGroupValue_PassW ==
                                        'PDF')
                                    ? const AssetImage('images/IconPDF.gif')
                                    : const AssetImage('images/excel_icon.gif'),
                              ),
                              Container(
                                width: 80,
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                                // decoration: const BoxDecoration(
                                //   border: Border(
                                //     bottom: BorderSide(
                                //         color: Colors.white),
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  } ////////////------------------------------------------>

  void InkWell_onTap(context) async {
    setState(() {
      NameFile_ = '';
      NameFile_ = FormNameFile_text.text;
    });

    if (_verticalGroupValue_NameFile == 'กำหนดเอง') {
    } else {
      if (_verticalGroupValue_PassW == 'PDF') {
        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'ภาษี') {
        } else if (Value_Report == 'รายงานรายรับแยกตามประเภทรายเดือน') {
          Excgen_DailyReport_category_cm.excgen_DailyReport_category_cm(
              '2',
              context,
              NameFile_,
              renTal_name,
              _verticalGroupValue_NameFile,
              '${monthsInThai[int.parse('${Mon_Income_Type_Mon_User}') - 1]} ($YE_Income_Type_Mon_User)',
              zoneModels_report,
              zoneModels_report_Sub_zone,
              zoneModeels_report_Ser_Sub_zone,
              _TransReBillModels_GropType_Mon,
              _TransReBillModels_GropType_Sub_zone,
              expModels);
        } else if (Value_Report == 'รายงานรายรับรายวันแยกตามประเภท') {
          Excgen_DailyReport_category_cm.excgen_DailyReport_category_cm(
              '1',
              context,
              NameFile_,
              renTal_name,
              _verticalGroupValue_NameFile,
              '${Value_selectDate_Daily_Type_} ถึง ${Value_select_lastDate_Daily_Type_}',
              zoneModels_report,
              zoneModels_report_Sub_zone,
              zoneModeels_report_Ser_Sub_zone,
              _TransReBillModels_GropType_Mon,
              _TransReBillModels_GropType_Sub_zone,
              expModels);
        }

        Navigator.of(context).pop();
      }
    }
  }
}
