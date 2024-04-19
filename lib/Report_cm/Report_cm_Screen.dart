import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_saver/file_saver.dart';
// import 'package:fine_bar_chart/fine_bar_chart.dart';
import 'package:fl_pin_code/pin_code.dart';
import 'package:fl_pin_code/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../Account/Account_Screen.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetUser_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_SCReportTotal_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';

import '../PeopleChao/PeopleChao_Screen.dart';
import '../Report/Report_Screen1.dart';
import '../Report/Report_Screen10.dart';
import '../Report/Report_Screen11.dart';
import '../Report/Report_Screen2.dart';
import '../Report/Report_Screen3.dart';
import '../Report/Report_Screen4.dart';
import '../Report/Report_Screen5.dart';
import '../Report/Report_Screen6.dart';
import '../Report/Report_Screen7.dart';
import '../Report/Report_Screen8.dart';
import '../Report/Report_Screen9.dart';
import '../Report_Dashboard/Dashboard_Screen.dart';
import '../Report_Ortorkor/Report_Screen9_1.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/colors.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Style/view_pagenow.dart';
import 'Report_cm_ScreenA.dart';
import 'Report_cm_ScreenB.dart';
import 'Report_cm_ScreenC.dart';

class Report_cm_Screen extends StatefulWidget {
  const Report_cm_Screen({super.key});

  @override
  State<Report_cm_Screen> createState() => _Report_cm_ScreenState();
}

class _Report_cm_ScreenState extends State<Report_cm_Screen> {
  int ser_pang = -2;

  DateTime datex = DateTime.now();
  int Status_ = 1;
  int PerandDow_ = 1;
  var Value_selectDate;
  var Value_selectDate1;
  var Value_selectDate2;
///////-------------------------------------------
  List<Map<String, dynamic>> datalist001_Incom = [];
  List<RenTalModel> renTalModels = [];
  List<AreaModel> areaModels = [];
  List<AreaModel> areaModels1 = [];
  List<AreaModel> areaModels2 = [];
  List<AreaModel> areaModels3 = [];
  // List<CustomerModel> customerModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<TransReBillModel> _TransReBillDailyBank = [];
  late List<List<dynamic>> TransReBillDailyBank;
  List<PayMentModel> payMentModels = [];
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<TransReBillModel> _TransReBillModels_Income = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Income = [];
  List<TransReBillModel> _TransReBillModels_Bankmovemen = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Bankmovemen = [];

  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  List<UserModel> userModels = [];
  //////////////////////----------------------------------
  String? renTal_user, renTal_name, zone_ser, zone_name;
  DateTime now = DateTime.now();
  String? SDatex_total1_;
  String? LDatex_total1_;
  double total1_ = 0.00;
  double total2_ = 0.00;
  double totalcash_ = 0.00;
  double totalbank = 0.00;
  double user_today = 0.00;
  String rtser = '';
  String Ser_nowpage = '5';
  String? numinvoice;
  int select_1 = 0;
  int select_2 = 0;
  int TransReBillModel_index = 0;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  // late List<List<TransReBillModel>> TransReBillModels;
  double Sum_total_dis = 0.00;
  String _verticalGroupValue_PassW = "EXCEL";
  String _ReportValue_type = "ปกติ";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
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
      foder;
  List newValuePDFimg = [];
  String? bills_name_;
  String? name_slip, name_slip_ser;
  String? base64_Slip, fileName_Slip;
  var Value_selectDate_Daily;

  var Value_Chang_Zone_Daily;
  var Value_Chang_Zone_Ser_Daily;
  var Value_Chang_Zone_Income;
  var Value_Chang_Zone_Ser_Income;
  String? YE_Income;
  String? Mon_Income;
  var overview_Ser_Zone_;
  String overview_Zone_ = 'ทั้งหมด';
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
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
  @override
  void initState() {
    super.initState();
    setState(() {
      SDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
      LDatex_total1_ = DateFormat('yyyy-MM-dd').format(now);
    });
    checkPreferance();
    read_GC_rental();
    // read_customer();
    read_GC_area1();
    read_GC_PayMentModel();
    read_GC_area2();
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
  Future<Null> read_GC_PayMentModel() async {
    if (payMentModels.length != 0) {
      payMentModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    // print('ren >>>>>> $ren');

    String url =
        '${MyConstant().domain}/GC_Bank_Paytype.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          PayMentModel payMentModel = PayMentModel.fromJson(map);
          setState(() {
            payMentModels.add(payMentModel);
          });
        }
      } else {}
    } catch (e) {}
  }

  Future<Null> read_GC_zone() async {
    if (zoneModels.length != 0) {
      zoneModels.clear();
      zoneModels_report.clear();
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

  Future<Null> check_clear() async {
    setState(() {
      datalist001_Incom.clear();
      // renTalModels.clear();
      // areaModels.clear();
      // areaModels1.clear();
      // areaModels2.clear();
      // areaModels3.clear();

      _TransReBillHistoryModels.clear();
      _TransReBillModels.clear();
      // sCReportTotalModels.clear();
      // sCReportTotalModels2.clear();

      _TransReBillModels_Income.clear();
      _TransReBillHistoryModels_Income.clear();
      _TransReBillModels_Bankmovemen.clear();
      _TransReBillHistoryModels_Bankmovemen.clear();

      sum_pvat = 0.00;
      sum_vat = 0.00;
      sum_wht = 0.00;
      sum_amt = 0.00;
      sum_dis = 0.00;
      sum_disamt = 0.00;
      sum_disp = 0;
      Value_Report = ' ';
      NameFile_ = '';
      Pre_and_Dow = '';

      newValuePDFimg = [];
      bills_name_ = null;
      name_slip = null;
      name_slip_ser = null;
      base64_Slip = null;
      fileName_Slip = null;
      Value_selectDate = null;
      Value_selectDate1 = null;
      Value_selectDate2 = null;
    });
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
  }

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
            if (bill_defaultx == 'P') {
              bills_name_ = 'บิลธรรมดา';
            } else {
              bills_name_ = 'ใบกำกับภาษี';
            }
          });
        }

        for (int index = 0; index < 1; index++) {
          if (renTalModels[0].imglogo!.trim() == '') {
            // newValuePDFimg.add(
            //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
          } else {
            newValuePDFimg.add(
                '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
          }
        }
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

/////////////////----https://flutterawesome.com/tag/dashboard-tag/------------------------------->(รวมรายรับ ชำระแล้ว)https://flutterawesome.com/responsive-flutter-bank-dashboard-ui/
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

/////////////////----------------------------------->(รวมรายรับ ทั้งหมด)
  ///
/////
  ///
///////////--------------------------------------------->(รายงานรายรับ)
  Future<Null> red_Trans_billIncome() async {
    int imd = 0;
    if (_TransReBillModels_Income.length != 0) {
      setState(() {
        _TransReBillModels_Income.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url = (Value_Chang_Zone_Ser_Income.toString() == '0')
        ? '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport_All.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income'
        : '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income';
    int index = 0;
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModels_Incomes =
              TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels_Income.add(_TransReBillModels_Incomes);

            // _TransBillModels.add(_TransBillModel);
          });

          var ciddoc = _TransReBillModels_Incomes.ser!;

          var docnoin = (_TransReBillModels_Incomes.docno == null)
              ? _TransReBillModels_Incomes.refno!
              : _TransReBillModels_Incomes.docno!;
          // print('imd ${imd + 1}');
          // red_Trans_selectIncome(ciddoc, docnoin, index);
          index++;
        }

        // print('result ${_TransReBillModels_Income.length}');

        // TransReBillModels_Income =
        //     List.generate(_TransReBillModels_Income.length, (_) => []);
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานรายรับ)
  Future<Null> red_Trans_selectIncome(ciddoc, docnoin, index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    setState(() {
      _TransReBillHistoryModels_Income.clear();
    });
    String url =
        '${MyConstant().domain}/GC_bill_pay_history_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('red_Trans_selectIncome__${index}');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModels_Incomes =
              TransReBillHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(
              (_TransReBillHistoryModels_Incomes.pvat == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Incomes.pvat!);
          var sum_vatx = double.parse(
              (_TransReBillHistoryModels_Incomes.vat == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Incomes.vat!);
          var sum_whtx = double.parse(
              (_TransReBillHistoryModels_Incomes.wht == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Incomes.wht!);
          var sum_amtx = double.parse(
              (_TransReBillHistoryModels_Incomes.total == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Incomes.total!);

          var numinvoiceent = _TransReBillHistoryModels_Incomes.docno;
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;

            numinvoice = _TransReBillHistoryModels_Incomes.docno;
            _TransReBillHistoryModels_Income.add(
                _TransReBillHistoryModels_Incomes);
          });
        }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคาร)
  Future<Null> red_Trans_billMovemen() async {
    if (_TransReBillModels_Bankmovemen.length != 0) {
      setState(() {
        _TransReBillModels_Bankmovemen.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (Value_Chang_Zone_Ser_Income.toString() == '0')
        ? '${MyConstant().domain}/GC_bill_pay_BC_BankmovemenReport_All.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income'
        : '${MyConstant().domain}/GC_bill_pay_BC_BankmovemenReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModels_Bankmovemens =
              TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels_Bankmovemen.add(_TransReBillModels_Bankmovemens);
          });
        }

        // print('result ${_TransReBillModels_Bankmovemen.length}');
      }
    } catch (e) {}
  }

  ///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคาร)
  Future<Null> red_Trans_selectMovemen(ciddoc, docnoin, index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    setState(() {
      _TransReBillHistoryModels_Bankmovemen.clear();
    });

    String url =
        '${MyConstant().domain}/GC_bill_pay_history_MovemenReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModels_Bankmovemens =
              TransReBillHistoryModel.fromJson(map);

          var sum_pvatx = double.parse(
              (_TransReBillHistoryModels_Bankmovemens.pvat == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Bankmovemens.pvat!);
          var sum_vatx = double.parse(
              (_TransReBillHistoryModels_Bankmovemens.vat == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Bankmovemens.vat!);
          var sum_whtx = double.parse(
              (_TransReBillHistoryModels_Bankmovemens.wht == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Bankmovemens.wht!);
          var sum_amtx = double.parse(
              (_TransReBillHistoryModels_Bankmovemens.total == null)
                  ? '0.00'
                  : _TransReBillHistoryModels_Bankmovemens.total!);

          var numinvoiceent = _TransReBillHistoryModels_Bankmovemens.docno;
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;

            numinvoice = _TransReBillHistoryModels_Bankmovemens.docno;
            _TransReBillHistoryModels_Bankmovemen.add(
                _TransReBillHistoryModels_Bankmovemens);
          });
        }
      }
    } catch (e) {}
    // }
  }

///////////--------------------------------------------->(รายงานประจำวัน)
  Future<Null> red_Trans_bill() async {
    setState(() {
      _TransReBillModels.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (Value_Chang_Zone_Ser_Daily.toString() == '0')
        ? '${MyConstant().domain}/GC_bill_pay_BC_DailyReport_All.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily&serzone=$Value_Chang_Zone_Ser_Daily'
        : '${MyConstant().domain}/GC_bill_pay_BC_DailyReport.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily&serzone=$Value_Chang_Zone_Ser_Daily';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels.add(transReBillModel);
          });
        }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานประจำวัน)
  Future<Null> red_Trans_select(ciddoc, docnoin, index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    setState(() {
      _TransReBillHistoryModels.clear();
    });

    String url =
        '${MyConstant().domain}/GC_bill_pay_history_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //  print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);

          var sum_pvatx = double.parse((_TransReBillHistoryModel.pvat == null)
              ? '0.00'
              : _TransReBillHistoryModel.pvat!);
          var sum_vatx = double.parse((_TransReBillHistoryModel.vat == null)
              ? '0.00'
              : _TransReBillHistoryModel.vat!);
          var sum_whtx = double.parse((_TransReBillHistoryModel.wht == null)
              ? '0.00'
              : _TransReBillHistoryModel.wht!);
          var sum_amtx = double.parse((_TransReBillHistoryModel.total == null)
              ? '0.00'
              : _TransReBillHistoryModel.total!);
          // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          var numinvoiceent = _TransReBillHistoryModel.docno;
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            // sum_disamt = sum_disamtx;
            // sum_disp = sum_dispx;
            numinvoice = _TransReBillHistoryModel.docno;
            _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            // TransReBillModels[index].add(_TransReBillHistoryModel);
          });
        }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคารประจำวัน)
  Future<Null> red_Trans_billDailyBank() async {
    if (_TransReBillDailyBank.length != 0) {
      setState(() {
        _TransReBillDailyBank.clear();
        TransReBillDailyBank = [];
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences
        .getString('renTalSer'); //GC_bill_pay_BC_Bank_DailyReport_All.php

    String url = (Value_Chang_Zone_Ser_Daily.toString() == '0')
        ? '${MyConstant().domain}/GC_bill_pay_BC_Bank_DailyReport_All.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily&serzone=$Value_Chang_Zone_Ser_Daily'
        : '${MyConstant().domain}/GC_bill_pay_BC_Bank_DailyReport.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily&serzone=$Value_Chang_Zone_Ser_Daily';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillDailyBank.add(transReBillModel);
          });
        }

        // print('result ${_TransReBillDailyBank.length}');

        // TransReBillDailyBank =
        //     List.generate(_TransReBillDailyBank.length, (_) => []);
        // red_TransDailyBank_select();
      }
    } catch (e) {}
  }

  ///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคารประจำวัน)
  Future<Null> red_TransDailyBank_select(ciddoc, docnoin, index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    setState(() {
      _TransReBillHistoryModels_Bankmovemen.clear();
    });

    String url =
        '${MyConstant().domain}/GC_bill_pay_historyBank_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel _TransReBillHistoryModel =
              TransReBillHistoryModel.fromJson(map);

          setState(() {
            _TransReBillHistoryModels_Bankmovemen.add(_TransReBillHistoryModel);
          });
        }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รวม ใกล้หมดสัญญา)
  Future<Null> read_GC_area1() async {
    var start = DateTime.now();
    if (areaModels1.length != 0) {
      areaModels1.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    // print('zone >>>>>> $zone');

    String url =
        '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModel);
          });
          if (areaModel.ldate != null) {
            String lastdate = '${areaModel.ldate}';
            var formatter = DateFormat('yyyy-MM-dd');
            var lastDateObject = formatter.parse(lastdate);
            var now = DateTime.now();
            var difference = lastDateObject.difference(now).inDays;
            if (difference == 0) {
              // print('หมดสัญญาวันนี้');
            } else if (difference <= 90 && difference > 0) {
              setState(() {
                areaModels1.add(areaModel);
              });
              // print('ใกล้หมดสัญญา');
            } else if (difference < 0) {
              // print('หมดสัญญา');
            } else {
              // print('ไม่ใกล้หมดสัญญา');
            }
          } else {}
        }
      } else {
        setState(() {
          if (areaModels1.isEmpty) {
            preferences.remove('zoneSer');
            preferences.remove('zonesName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }
      setState(() {
        // _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
    var end = DateTime.now();
    var difference = end.difference(start);
    // print('Time read_GC_area(): ${difference.inSeconds} seconds');
    // print('Time read_GC_area(): ${difference.inSeconds} seconds');
    // print('Time read_GC_area(): ${difference.inSeconds} seconds');
  }

///////////--------------------------------------------->(รวม ว่าง ให้เช่า)
  Future<Null> read_GC_area2() async {
//     quantity
// 1 = เช่าอยู่
// 2 = เสนอราคา
// 3 = เสนอราคามัดจำ
// null = ว่าง
    var start = DateTime.now();
    if (areaModels2.length != 0) {
      areaModels2.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    // print('zone >>>>>> $zone');

    String url = zone == null
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          if (areaModel.quantity == null) {
            setState(() {
              areaModels2.add(areaModel);
            });
          } else if (int.parse(areaModel.quantity!) == 1) {
            setState(() {
              areaModels3.add(areaModel);
            });
          }
        }
      } else {
        setState(() {
          if (areaModels2.isEmpty) {
            preferences.remove('zoneSer');
            preferences.remove('zonesName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }
      setState(() {
        // _areaModels = areaModels;
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
    var end = DateTime.now();
    var difference = end.difference(start);
    // print('Time read_GC_area(): ${difference.inSeconds} seconds');
    // print('Time read_GC_area(): ${difference.inSeconds} seconds');
    // print('Time read_GC_area(): ${difference.inSeconds} seconds');
  }

  ///////---------------------------------------------------->

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 22.0, color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (text) {
        setState(() {
          // serODMOdelss = serODMOdel.where((serODMOdels) {
          //   var notTitle = serODMOdels.email.toLowerCase();
          //   return notTitle.contains(text);
          // }).toList();

          // }
        });
      },
    );
  }

////////////------------------------------------------------------->()
  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  ////////////-----------------------(วันที่รายงานประจำวัน)
  Future<Null> _select_Date_Daily(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่', confirmText: 'ตกลง',
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
        // TransReBillModels = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate_Daily = "${formatter.format(result)}";
        });
        // if (Value_Chang_Zone_Daily != null) {
        //   red_Trans_bill();
        //   red_Trans_billDailyBank();
        // }

        // red_Trans_bill_Groptype_daly();
      }
    });
  }

////////////------------------------------------------>()
  Future<Null> _select_StartDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่เริ่มต้น', confirmText: 'ตกลง',
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
        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate1 = "${formatter.format(result)}";
          Value_selectDate2 = null;
          _TransReBillModels_Income = [];
          _TransReBillHistoryModels_Income = [];
          _TransReBillModels_Bankmovemen = [];
          _TransReBillHistoryModels_Bankmovemen = [];
        });
      }
    });
  }

////////////------------------------------------------->()
  Future<Null> _select_EndDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่สุดท้าย', confirmText: 'ตกลง', cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime.now(),
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
        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate2 = "${formatter.format(result)}";
        });
        // red_Trans_billIncome();

        // red_Trans_billMovemen();
      }
    });
  }

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

//////////////////////////////////----------------------------------------->
  int Status_s = 0;
  int? _message1;
  void updateMessage(int newMessage) {
    setState(() {
      _message1 = newMessage;
      Status_s = newMessage;
    });
  }

  ///----------------------------------------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(const Duration(seconds: 4), () {
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

  ///----------------------------------------------------------->
  Widget build(BuildContext context) {
    return (Status_s == 1)
        ? DashboardScreen(
            updateMessage: updateMessage,
            areaModels: areaModels,
            areaModels1: areaModels1,
            areaModels2: areaModels2,
          )
        : SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
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
                                  color: AppbackgroundColor.TiTile_Colors,
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
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: viewpage(context, '$Ser_nowpage'),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppbackgroundColor.TiTile_Box,
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
                                onTap: () async {},
                                child: Container(
                                    width: 130,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: (Status_s == 0)
                                          ? Colors.blue[700]
                                          : Colors.blue[200],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    child: const Center(
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
                                onTap: () async {
                                  setState(() {
                                    Status_s = 1;
                                  });
                                },
                                child: Container(
                                    width: 130,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange[200],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
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
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(8, 8, 2, 8),
                                    child: AutoSizeText(
                                      'ภาพรวมการดำเนินการ ',
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 8,
                                      maxFontSize: 20,
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.topLeft,
                          //   child: viewpage(context, '$Ser_nowpage'),
                          // ),
                        ],
                      )),
/////---------------------------------------------->
                  // (!Responsive.isDesktop(context))
                  //     ? BodyHome_mobile()
                  //     : BodyHome_Web(),

                  Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 270,
                        decoration: const BoxDecoration(
                          color: AppbackgroundColor.TiTile_Box,
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
                                    if ((MediaQuery.of(context).size.width) >
                                        650)
                                      const Expanded(
                                          flex: 1, child: SizedBox()),
                                    Expanded(
                                      flex: 1,
                                      child:
                                          ((MediaQuery.of(context).size.width) >
                                                  650)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 8, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
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
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                            height: 35,
                                                            child: Row(
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'รายรับ :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ReportScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'โซน ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ReportScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: AppbackgroundColor
                                                                          .Sub_Abg_Colors,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    width: 260,
                                                                    // height: 40,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        DropdownButtonFormField2(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      focusColor:
                                                                          Colors
                                                                              .white,
                                                                      autofocus:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        enabled:
                                                                            true,
                                                                        hoverColor:
                                                                            Colors.brown,
                                                                        prefixIconColor:
                                                                            Colors.blue,
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.05),
                                                                        filled:
                                                                            false,
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.zero,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(color: Colors.red),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            bottomRight:
                                                                                Radius.circular(10),
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                231,
                                                                                227,
                                                                                227),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      isExpanded:
                                                                          false,
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
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      iconSize:
                                                                          20,

                                                                      buttonHeight:
                                                                          40,
                                                                      buttonWidth:
                                                                          250,
                                                                      dropdownDecoration:
                                                                          BoxDecoration(
                                                                        // color: Colors
                                                                        //     .amber,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 1),
                                                                      ),
                                                                      items: zoneModels_report
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

                                                                      onChanged:
                                                                          (value) async {
                                                                        int selectedIndex = zoneModels_report.indexWhere((item) =>
                                                                            item.zn ==
                                                                            value);
                                                                        setState(
                                                                            () {
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
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                  'วันที่ ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    _select_financial_StartDate(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: AppbackgroundColor
                                                                            .Sub_Abg_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      height: 25,
                                                                      width: 120,
                                                                      padding: const EdgeInsets.all(2.0),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          (SDatex_total1_ == null)
                                                                              ? 'เลือก'
                                                                              : '$SDatex_total1_',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ),
                                                              const Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: Text(
                                                                  'ถึง',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    _select_financial_LtartDate(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: AppbackgroundColor
                                                                            .Sub_Abg_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      height: 25,
                                                                      width: 120,
                                                                      padding: const EdgeInsets.all(2.0),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          (LDatex_total1_ == null)
                                                                              ? 'เลือก'
                                                                              : '$LDatex_total1_',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          6, 0, 6, 4),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
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
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            height: 35,
                                                            child: Row(
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'รายรับ :',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ReportScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'โซน ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ReportScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: AppbackgroundColor
                                                                          .Sub_Abg_Colors,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                                    ),
                                                                    width: 240,
                                                                    // height: 40,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        DropdownButtonFormField2(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      focusColor:
                                                                          Colors
                                                                              .white,
                                                                      autofocus:
                                                                          false,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        enabled:
                                                                            true,
                                                                        hoverColor:
                                                                            Colors.brown,
                                                                        prefixIconColor:
                                                                            Colors.blue,
                                                                        fillColor: Colors
                                                                            .white
                                                                            .withOpacity(0.05),
                                                                        filled:
                                                                            false,
                                                                        isDense:
                                                                            true,
                                                                        contentPadding:
                                                                            EdgeInsets.zero,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              const BorderSide(color: Colors.red),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(10),
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            bottomRight:
                                                                                Radius.circular(10),
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                231,
                                                                                227,
                                                                                227),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      isExpanded:
                                                                          false,
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
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      iconSize:
                                                                          20,

                                                                      buttonHeight:
                                                                          40,
                                                                      buttonWidth:
                                                                          240,
                                                                      dropdownDecoration:
                                                                          BoxDecoration(
                                                                        // color: Colors
                                                                        //     .amber,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 1),
                                                                      ),
                                                                      items: zoneModels_report
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

                                                                      onChanged:
                                                                          (value) async {
                                                                        int selectedIndex = zoneModels_report.indexWhere((item) =>
                                                                            item.zn ==
                                                                            value);
                                                                        setState(
                                                                            () {
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
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                  'วันที่ ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    _select_financial_StartDate(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: AppbackgroundColor
                                                                            .Sub_Abg_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      height: 25,
                                                                      width: 110,
                                                                      padding: const EdgeInsets.all(2.0),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          (SDatex_total1_ == null)
                                                                              ? 'เลือก'
                                                                              : '$SDatex_total1_',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ),
                                                              const Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: Text(
                                                                  'ถึง',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        8,
                                                                        0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    _select_financial_LtartDate(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: AppbackgroundColor
                                                                            .Sub_Abg_Colors,
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: 1),
                                                                      ),
                                                                      height: 25,
                                                                      width: 110,
                                                                      padding: const EdgeInsets.all(2.0),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          (LDatex_total1_ == null)
                                                                              ? 'เลือก'
                                                                              : '$LDatex_total1_',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text2_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
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
                                StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(seconds: 0)),
                                    builder: (context, snapshot) {
                                      return GridView.count(
                                          padding: ((MediaQuery.of(context)
                                                      .size
                                                      .width) <
                                                  650)
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
                                                  : 4,
                                          childAspectRatio:
                                              ((MediaQuery.of(context)
                                                              .size
                                                              .width) <
                                                          650 &&
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .width) >
                                                          500)
                                                  ? 1.2
                                                  : ((MediaQuery.of(context)
                                                              .size
                                                              .width) <
                                                          500)
                                                      ? 0.8
                                                      : 2,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Container(
                                              padding: ((MediaQuery.of(context)
                                                          .size
                                                          .width) <
                                                      650)
                                                  ? const EdgeInsets.all(5.0)
                                                  : const EdgeInsets.all(24.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                // color: Color(0xFFA8BFDB),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color:
                                                            Colors.orange[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons.map_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'พื้นที่',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      shadows: [
                                                        Shadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, -5))
                                                      ],
                                                      color: Colors.transparent,
                                                      // decoration: TextDecoration
                                                      //     .underline,
                                                      decorationColor:
                                                          Colors.grey,
                                                      decorationThickness: 4,
                                                      // decorationStyle:
                                                      //     TextDecorationStyle
                                                      //         .dashed,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Expanded(flex: 1,
                                                  //       child: Divider(
                                                  //         color: Colors.grey[300],
                                                  //         height: 2.0,
                                                  //       ),
                                                  //     ), Expanded(flex: 1,
                                                  //       child:SizedBox(),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        // width: ((MediaQuery.of(
                                                        //                 context)
                                                        //             .size
                                                        //             .width) <
                                                        //         650)
                                                        //     ? 40
                                                        //     : 100,
                                                        child: Text(
                                                          'ทั้งหมด',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (areaModels == null)
                                                            ? '0 พื้นที่'
                                                            : '${nFormat2.format(double.parse(areaModels.length.toString()))} พื้นที่',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
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
                                                          (areaModels2.length ==
                                                                  0)
                                                              ? 'ว่าง [0%]'
                                                              : 'ว่าง [${(((areaModels2.length ?? 0.0) * 100) / areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,

                                                            // decoration:

                                                            //     TextDecoration.underline,

                                                            color: Colors.green,

                                                            fontWeight:
                                                                FontWeight.bold,

                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (areaModels2 == null)
                                                            ? '0 พื้นที่'
                                                            : '${nFormat2.format(double.parse(areaModels2.length.toString()))} พื้นที่',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,

                                                          // decoration:

                                                          //     TextDecoration.underline,

                                                          color: Colors.green,

                                                          fontWeight:
                                                              FontWeight.bold,

                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
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
                                                          (areaModels1.length ==
                                                                  0)
                                                              ? 'ใกล้หมดสัญญา [0%]'
                                                              : 'ใกล้หมดสัญญา [${(((areaModels1.length ?? 0.0) * 100) / areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,

                                                            // decoration:

                                                            //     TextDecoration.underline,

                                                            color: Colors.red,

                                                            fontWeight:
                                                                FontWeight.bold,

                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (areaModels1 == null)
                                                            ? '0 พื้นที่'
                                                            : '${nFormat2.format(double.parse(areaModels1.length.toString()))} พื้นที่',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,

                                                          // decoration:

                                                          //     TextDecoration.underline,

                                                          color: Colors.red,

                                                          fontWeight:
                                                              FontWeight.bold,

                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: ((MediaQuery.of(context)
                                                          .size
                                                          .width) <
                                                      650)
                                                  ? const EdgeInsets.all(5.0)
                                                  : const EdgeInsets.all(24.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                // color: Color(0xFFA8BFDB),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.blue[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons.people,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'แอดมิน',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      shadows: [
                                                        Shadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, -5))
                                                      ],
                                                      color: Colors.transparent,
                                                      // decoration: TextDecoration
                                                      //     .underline,
                                                      decorationColor:
                                                          Colors.grey,
                                                      decorationThickness: 4,
                                                      // decorationStyle:
                                                      //     TextDecorationStyle
                                                      //         .dashed,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        // width: ((MediaQuery.of(
                                                        //                 context)
                                                        //             .size
                                                        //             .width) <
                                                        //         650)
                                                        //     ? 40
                                                        //     : 100,
                                                        child: Text(
                                                          'ทั้งหมด',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (userModels.isEmpty)
                                                            ? '0 คน'
                                                            : '${nFormat2.format(userModels.length)} คน',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
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
                                                          (user_today == 0.00)
                                                              ? 'วันนี้ [0%]'
                                                              : 'วันนี้ [${(((user_today ?? 0.0) * 100) / userModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,

                                                            // decoration:

                                                            //     TextDecoration.underline,

                                                            color: Colors.red,

                                                            fontWeight:
                                                                FontWeight.bold,

                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${nFormat2.format(user_today)} คน',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,

                                                          // decoration:

                                                          //     TextDecoration.underline,

                                                          color: Colors.red,

                                                          fontWeight:
                                                              FontWeight.bold,

                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: ((MediaQuery.of(context)
                                                          .size
                                                          .width) <
                                                      650)
                                                  ? const EdgeInsets.all(5.0)
                                                  : const EdgeInsets.all(24.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                // color: Color(0xFFA8BFDB),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.red[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .account_balance_wallet,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'รวมรายรับ (ชำระแล้ว Cash/Bank)',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      shadows: [
                                                        Shadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, -5))
                                                      ],
                                                      color: Colors.transparent,
                                                      // decoration: TextDecoration
                                                      //     .underline,
                                                      decorationColor:
                                                          Colors.grey,
                                                      decorationThickness: 4,
                                                      // decorationStyle:
                                                      //     TextDecorationStyle
                                                      //         .dashed,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        // width: ((MediaQuery.of(
                                                        //                 context)
                                                        //             .size
                                                        //             .width) <
                                                        //         650)
                                                        //     ? 40
                                                        //     : 100,
                                                        child: Text(
                                                          'ทั้งหมด',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (total1_ == null)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(total1_)} บาท',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
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
                                                          (totalcash_ == 0.00)
                                                              ? 'Cash [0%]'
                                                              : 'Cash [${(((totalcash_ ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (totalcash_ == null)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(totalcash_)} บาท',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
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
                                                          (totalbank == 0.00)
                                                              ? 'Bank [0%]'
                                                              : 'Bank [${(((totalbank ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,

                                                            // decoration:

                                                            //     TextDecoration.underline,

                                                            color: Colors.red,

                                                            fontWeight:
                                                                FontWeight.bold,

                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (totalbank == null)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(totalbank)} บาท',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,

                                                          // decoration:

                                                          //     TextDecoration.underline,

                                                          color: Colors.red,

                                                          fontWeight:
                                                              FontWeight.bold,

                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: ((MediaQuery.of(context)
                                                          .size
                                                          .width) <
                                                      650)
                                                  ? const EdgeInsets.all(5.0)
                                                  : const EdgeInsets.all(24.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                // color: Color(0xFFA8BFDB),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 8, 8),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.teal[700],
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .monetization_on_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'รวมรายรับ (ชำระแล้ว )',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      shadows: [
                                                        Shadow(
                                                            color: Colors.black,
                                                            offset:
                                                                Offset(0, -5))
                                                      ],
                                                      color: Colors.transparent,
                                                      // decoration: TextDecoration
                                                      //     .underline,
                                                      decorationColor:
                                                          Colors.grey,
                                                      decorationThickness: 4,
                                                      // decorationStyle:
                                                      //     TextDecorationStyle
                                                      //         .dashed,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        // width: ((MediaQuery.of(
                                                        //                 context)
                                                        //             .size
                                                        //             .width) <
                                                        //         650)
                                                        //     ? 40
                                                        //     : 100,
                                                        child: Text(
                                                          'ก่อน-หักส่วนลด',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (total2_ == null)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(total2_)} บาท',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        // width: ((MediaQuery.of(
                                                        //                 context)
                                                        //             .size
                                                        //             .width) <
                                                        //         650)
                                                        //     ? 40
                                                        //     : 100,
                                                        child: Text(
                                                          'หลัง-หักส่วนลด',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            // decoration:
                                                            //     TextDecoration.underline,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        (total1_ == null)
                                                            ? '0.00 บาท'
                                                            : '${nFormat.format(total1_)} บาท',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]
                                          // itemBuilder: (context, index) =>
                                          //     demoTransactions[index],
                                          );
                                    })
                              ]),
                        ),
                      )),
////---------------------------------------------->
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'รายงาน : ',
                          style: TextStyle(
                            color: ReportScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        ),
                      ),
                      Expanded(
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
                                for (int index = 0; index < 3; index++)
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (index == 0) {
                                            ser_pang = -2;
                                          } else if (index == 1) {
                                            ser_pang = -1;
                                          } else {
                                            ser_pang = 0;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 125,
                                        decoration: BoxDecoration(
                                          color: (ser_pang == -2 && index == 0)
                                              ? Colors.blueGrey
                                              : (ser_pang == -1 && index == 1)
                                                  ? Colors.blueGrey
                                                  : (ser_pang == 0 &&
                                                          index == 2)
                                                      ? Colors.blueGrey
                                                      : Colors.blueGrey[200],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                            (index == 0)
                                                ? 'Exclusive - A'
                                                : (index == 1)
                                                    ? 'Exclusive - B'
                                                    : 'Exclusive - C',
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
                                  ),
                                for (int index = 1; index < 12; index++)
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
                                          // color: (ser_pang == index + 1 ||
                                          //         ser_pang + index == 0)
                                          //     ? Colors.black54
                                          //     : Colors.black26,
                                          color: (ser_pang == index)
                                              ? Colors.deepPurple
                                              : Colors.deepPurple[200],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 20,
                                            'หน้า ${index}',
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
                  (ser_pang == -2)
                      ? Report_cm_ScreenA()
                      : (ser_pang == -1)
                          ? Report_cm_ScreenB()
                          : (ser_pang == 0)
                              ? Report_cm_ScreenC()
                              : (ser_pang == 1)
                                  ? const ReportScreen1()
                                  : (ser_pang == 2)
                                      ? const ReportScreen2()
                                      : (ser_pang == 3)
                                          ? const ReportScreen3()
                                          : (ser_pang == 4)
                                              ? const ReportScreen4()
                                              : (ser_pang == 5)
                                                  ? const ReportScreen5()
                                                  : (ser_pang == 6)
                                                      ? const ReportScreen6()
                                                      : (ser_pang == 7)
                                                          ? const ReportScreen7()
                                                          : (ser_pang == 8)
                                                              ? const ReportScreen8()
                                                              : (ser_pang == 9)
                                                                  ?
                                                                  // (rtser.toString() == '72' ||
                                                                  //         rtser.toString() ==
                                                                  //             '92' ||
                                                                  //         rtser.toString() ==
                                                                  //             '93' ||
                                                                  //         rtser.toString() ==
                                                                  //             '94')
                                                                  //     ? const ReportScreen9_1() ////องค์การตลาด กระทรวงมหาดไทย
                                                                  //     :
                                                                  const ReportScreen9()
                                                                  : (ser_pang ==
                                                                          10)
                                                                      ? const ReportScreen10()
                                                                      : const ReportScreen11()
                ],
              ),
            ),
          );
  }
}

///////////----------------------------------------->
// class PreviewReportScreen extends StatelessWidget {
//   final pw.Document doc;
//   final Status_;
//   PreviewReportScreen({super.key, required this.doc, this.Status_});

//   static const customSwatch = MaterialColor(
//     0xFF8DB95A,
//     <int, Color>{
//       50: Color(0xFFC2FD7F),
//       100: Color(0xFFB6EE77),
//       200: Color(0xFFB2E875),
//       300: Color(0xFFACDF71),
//       400: Color(0xFFA7DA6E),
//       500: Color(0xFFA1D16A),
//       600: Color(0xFF94BF62),
//       700: Color(0xFF90B961),
//       800: Color(0xFF85AB5A),
//       900: Color(0xFF7A9B54),
//     },
//   );
//   String day_ =
//       '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

//   String Tim_ =
//       '${DateTime.now().hour}.${DateTime.now().minute}.${DateTime.now().second}';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: customSwatch,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Color.fromARGB(255, 141, 185, 90),
//           leading: IconButton(
//             onPressed: () async {
//               SharedPreferences preferences =
//                   await SharedPreferences.getInstance();

//               String? _route = preferences.getString('route');
//               MaterialPageRoute materialPageRoute = MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       AdminScafScreen(route: _route));
//               Navigator.pushAndRemoveUntil(
//                   context, materialPageRoute, (route) => false);
//             },
//             icon: const Icon(
//               Icons.arrow_back_outlined,
//               color: Colors.white,
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             "${Status_}",
//             style: const TextStyle(
//                 color: Colors.white, fontFamily: FontWeight_.Fonts_T),
//           ),
//         ),
//         body: PdfPreview(
//           build: (format) => doc.save(),
//           allowSharing: false,
//           allowPrinting: true, canChangePageFormat: false,
//           canChangeOrientation: false, canDebug: false,
//           maxPageWidth: MediaQuery.of(context).size.width * 0.6,
//           // scrollViewDecoration:,
//           initialPageFormat: PdfPageFormat.a4,
//           pdfFileName: "${Status_}[$day_].pdf",
//         ),
//       ),
//     );
//   }
// }
