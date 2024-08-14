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
import '../Report_Dashboard/Dashboard_Screen.dart';
import '../Report_Ortorkor/Report_Ortor_ScreenA.dart';
import '../Report_Ortorkor/Report_Ortor_ScreenB.dart';
import '../Report_Ortorkor/Report_Screen9_1.dart';
import '../Report_choice/Report_Choice_ScreenA.dart';
import '../Report_choice/Report_Choice_ScreenB.dart';
import '../Report_choice/Report_Choice_ScreenC.dart';
import '../Report_choice/Report_Choice_ScreenD.dart';
import '../Report_cm/Report_cm_ScreenA.dart';
import '../Report_cm/Report_cm_ScreenB.dart';
import '../Report_cm/Report_cm_ScreenC.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Style/view_pagenow.dart';
import 'Excel_BankDaily_Report.dart';
import 'Excel_Bankmovemen_Report.dart';
import 'Excel_Cust_Report.dart';
import 'Excel_Daily_Report.dart';
import 'Excel_Expense_Report.dart';
import 'Excel_Income_Report.dart';
import 'Excel_Tax_Report.dart';
import 'Pdf_Bank_Report.dart';
import 'Pdf_Expen_Report.dart';
import 'Pdf_IC_Report.dart';
import 'Pdf__Daily_Report.dart';
import 'Report_Screen1.dart';
import 'Report_Screen10.dart';
import 'Report_Screen11.dart';
import 'Report_Screen3.dart';
import 'Report_Mini/MIni_Ex_BankDaily_Re.dart';
import 'Report_Mini/MIni_Ex_Bankmovemen_Re.dart';
import 'Report_Mini/MIni_Ex_Daily_Re.dart';
import 'Report_Mini/MIni_Ex_Income_Re.dart';
import 'Report_Screen2.dart';
import 'Report_Screen5.dart';
import 'Report_Screen6.dart';
import 'Report_Screen7.dart';
import 'Report_Screen8.dart';
import 'Report_Screen4.dart';
import 'Report_Screen9.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int ser_pang_test = -7;
  int ser_pang = 0;
  ////////--------------------------->
  int ser_pang_CM = -2;
  int ser_pang_Ortor = -1;
  int ser_pang_Choice = -3;

  ///
  ///
  ///
  ////////--------------------------->
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
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 20),
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
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 20),
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
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 20),
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
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 20),
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
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 20),
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
                                  color: AppbackgroundColor.TiTile_Box,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Translate.TranslateAndSetText(
                                        'รายงาน ',
                                        ReportScreen_Color.Colors_Text1_,
                                        TextAlign.center,
                                        FontWeight.w500,
                                        Font_.Fonts_T,
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
                                    child: Center(
                                      child: Translate.TranslateAndSetText(
                                          'รายงาน',
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
                                        TextAlign.center,
                                        FontWeight.w500,
                                        Font_.Fonts_T,
                                        16,
                                        1),
                                    //  AutoSizeText(
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
                                                    child: ScrollConfiguration(
                                                      behavior:
                                                          ScrollConfiguration
                                                                  .of(context)
                                                              .copyWith(
                                                                  dragDevices: {
                                                            PointerDeviceKind
                                                                .touch,
                                                            PointerDeviceKind
                                                                .mouse,
                                                          }),
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SizedBox(
                                                                height: 35,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4.0),
                                                                      child: Translate.TranslateAndSetText(
                                                                          'รายรับ :',
                                                                          ReportScreen_Color
                                                                              .Colors_Text1_,
                                                                          TextAlign
                                                                              .center,
                                                                          FontWeight
                                                                              .w500,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4.0),
                                                                      child: Translate.TranslateAndSetText(
                                                                          'โซน ',
                                                                          ReportScreen_Color
                                                                              .Colors_Text1_,
                                                                          TextAlign
                                                                              .center,
                                                                          FontWeight
                                                                              .w500,
                                                                          Font_
                                                                              .Fonts_T,
                                                                          12,
                                                                          1),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              AppbackgroundColor.Sub_Abg_Colors,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                          // border: Border.all(color: Colors.grey, width: 1),
                                                                        ),
                                                                        width:
                                                                            260,
                                                                        // height: 40,
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            DropdownButtonFormField2(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          focusColor:
                                                                              Colors.white,
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
                                                                            fillColor:
                                                                                Colors.white.withOpacity(0.05),
                                                                            filled:
                                                                                false,
                                                                            isDense:
                                                                                true,
                                                                            contentPadding:
                                                                                EdgeInsets.zero,
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderSide: const BorderSide(color: Colors.red),
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            focusedBorder:
                                                                                const OutlineInputBorder(
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
                                                                            Icons.arrow_drop_down,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.grey,
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
                                                                            border:
                                                                                Border.all(color: Colors.white, width: 1),
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
                                                                            setState(() {
                                                                              overview_Zone_ = value!;
                                                                              overview_Ser_Zone_ = '${zoneModels_report[selectedIndex].ser}';
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
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Translate.TranslateAndSetText(
                                                                        'วันที่ ',
                                                                        ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        TextAlign
                                                                            .center,
                                                                        FontWeight
                                                                            .w500,
                                                                        Font_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _select_financial_StartDate(
                                                                            context);
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.Sub_Abg_Colors,
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                            border:
                                                                                Border.all(color: Colors.grey, width: 1),
                                                                          ),
                                                                          height: 25,
                                                                          width: 120,
                                                                          padding: const EdgeInsets.all(2.0),
                                                                          child: Center(
                                                                            child: Translate.TranslateAndSetText(
                                                                                (SDatex_total1_ == null) ? 'เลือก' : '$SDatex_total1_',
                                                                                Colors.grey,
                                                                                TextAlign.center,
                                                                                FontWeight.w500,
                                                                                Font_.Fonts_T,
                                                                                12,
                                                                                1),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child: Translate.TranslateAndSetText(
                                                                        'ถึง',
                                                                        ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        TextAlign
                                                                            .center,
                                                                        FontWeight
                                                                            .w500,
                                                                        Font_
                                                                            .Fonts_T,
                                                                        16,
                                                                        1),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            8,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _select_financial_LtartDate(
                                                                            context);
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                AppbackgroundColor.Sub_Abg_Colors,
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                            border:
                                                                                Border.all(color: Colors.grey, width: 1),
                                                                          ),
                                                                          height: 25,
                                                                          width: 120,
                                                                          padding: const EdgeInsets.all(2.0),
                                                                          child: Center(
                                                                            child: Translate.TranslateAndSetText(
                                                                                (LDatex_total1_ == null) ? 'เลือก' : '$LDatex_total1_',
                                                                                Colors.grey,
                                                                                TextAlign.center,
                                                                                FontWeight.w500,
                                                                                Font_.Fonts_T,
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
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Translate.TranslateAndSetText(
                                                                      'รายรับ :',
                                                                      ReportScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .center,
                                                                      FontWeight
                                                                          .w500,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      16,
                                                                      1),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Translate.TranslateAndSetText(
                                                                      'โซน ',
                                                                      ReportScreen_Color
                                                                          .Colors_Text1_,
                                                                      TextAlign
                                                                          .center,
                                                                      FontWeight
                                                                          .w500,
                                                                      Font_
                                                                          .Fonts_T,
                                                                      16,
                                                                      1),
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
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Translate.TranslateAndSetText(
                                                                    'วันที่ ',
                                                                    ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .center,
                                                                    FontWeight
                                                                        .w500,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    16,
                                                                    1),
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
                                                                        child: Translate.TranslateAndSetText(
                                                                            (SDatex_total1_ == null)
                                                                                ? 'เลือก'
                                                                                : '$SDatex_total1_',
                                                                            ReportScreen_Color.Colors_Text1_,
                                                                            TextAlign.center,
                                                                            FontWeight.w500,
                                                                            Font_.Fonts_T,
                                                                            16,
                                                                            1),
                                                                      )),
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
                                                                child: Translate.TranslateAndSetText(
                                                                    'ถึง',
                                                                    ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .center,
                                                                    FontWeight
                                                                        .w500,
                                                                    Font_
                                                                        .Fonts_T,
                                                                    16,
                                                                    1),
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
                                                                        child: Translate.TranslateAndSetText(
                                                                            (LDatex_total1_ == null)
                                                                                ? 'เลือก'
                                                                                : '$LDatex_total1_',
                                                                            ReportScreen_Color.Colors_Text1_,
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
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                                GridView.count(
                                    padding: ((MediaQuery.of(context).size.width) <
                                            650)
                                        ? const EdgeInsets.all(2)
                                        : const EdgeInsets.all(5),
                                    crossAxisSpacing:
                                        ((MediaQuery.of(context).size.width) <
                                                650)
                                            ? 10.00
                                            : 16.0,
                                    mainAxisSpacing:
                                        ((MediaQuery.of(context).size.width) <
                                                650)
                                            ? 10.00
                                            : 16.0,
                                    crossAxisCount: (MediaQuery.of(context)
                                                .size
                                                .width) <
                                            650
                                        ? 2
                                        : (MediaQuery.of(context).size.width) <
                                                1330
                                            ? 2
                                            : 4,
                                    childAspectRatio: ((MediaQuery.of(context)
                                                    .size
                                                    .width) <
                                                650 &&
                                            (MediaQuery.of(context).size.width) >
                                                500)
                                        ? 1.2
                                        : ((MediaQuery.of(context).size.width) <
                                                500)
                                            ? 0.8
                                            : 2,
                                    physics: const NeverScrollableScrollPhysics(),
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
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 8),
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
                                                ReportScreen_Color
                                                    .Colors_Text1_,
                                                TextAlign.start,
                                                FontWeight.w500,
                                                FontWeight_.Fonts_T,
                                                12,
                                                1),
                                            // const Text(
                                            //   'พื้นที่',
                                            //   maxLines: 2,
                                            //   overflow:
                                            //       TextOverflow.ellipsis,
                                            //   style: TextStyle(
                                            //     shadows: [
                                            //       Shadow(
                                            //           color: Colors.black,
                                            //           offset:
                                            //               Offset(0, -5))
                                            //     ],
                                            //     color: Colors.transparent,
                                            //     // decoration: TextDecoration
                                            //     //     .underline,
                                            //     decorationColor:
                                            //         Colors.grey,
                                            //     decorationThickness: 4,
                                            //     // decorationStyle:
                                            //     //     TextDecorationStyle
                                            //     //         .dashed,
                                            //     fontSize: 12,
                                            //     fontWeight:
                                            //         FontWeight.bold,
                                            //     fontFamily:
                                            //         FontWeight_.Fonts_T,
                                            //   ),
                                            // ),
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
                                                Expanded(
                                                  // width: ((MediaQuery.of(
                                                  //                 context)
                                                  //             .size
                                                  //             .width) <
                                                  //         650)
                                                  //     ? 40
                                                  //     : 100,
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'ทั้งหมด',
                                                          Colors.blue,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (areaModels == null)
                                                        ? '0 พื้นที่'
                                                        : '${nFormat2.format(double.parse(areaModels.length.toString()))} พื้นที่',
                                                    Colors.blue,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (areaModels == null)
                                                //       ? '0 พื้นที่'
                                                //       : '${nFormat2.format(double.parse(areaModels.length.toString()))} พื้นที่',
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     // decoration:
                                                //     //     TextDecoration.underline,
                                                //     color: Colors.blue,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          (areaModels2.length ==
                                                                  0)
                                                              ? 'ว่าง [0%]'
                                                              : 'ว่าง [${(((areaModels2.length ?? 0.0) * 100) / areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                          Colors.green,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),

                                                  // Text(
                                                  //   (areaModels2.length == 0)
                                                  //       ? 'ว่าง [0%]'
                                                  //       : 'ว่าง [${(((areaModels2.length ?? 0.0) * 100) / areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                  //   // 'ว่าง',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,

                                                  //     // decoration:

                                                  //     //     TextDecoration.underline,

                                                  //     color: Colors.green,

                                                  //     fontWeight:
                                                  //         FontWeight.bold,

                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (areaModels2 == null)
                                                        ? '0 พื้นที่'
                                                        : '${nFormat2.format(double.parse(areaModels2.length.toString()))} พื้นที่',
                                                    Colors.green,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (areaModels2 == null)
                                                //       ? '0 พื้นที่'
                                                //       : '${nFormat2.format(double.parse(areaModels2.length.toString()))} พื้นที่',
                                                //   maxLines: 1,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,

                                                //     // decoration:

                                                //     //     TextDecoration.underline,

                                                //     color: Colors.green,

                                                //     fontWeight: FontWeight.bold,

                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                                  child: Translate.TranslateAndSetText(
                                                      (areaModels1.length == 0)
                                                          ? 'ใกล้หมดสัญญา [0%]'
                                                          : 'ใกล้หมดสัญญา [${(((areaModels1.length ?? 0.0) * 100) / areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                      Colors.red,
                                                      TextAlign.start,
                                                      FontWeight.w500,
                                                      FontWeight_.Fonts_T,
                                                      12,
                                                      1),

                                                  // Text(
                                                  //   (areaModels1.length == 0)
                                                  //       ? 'ใกล้หมดสัญญา [0%]'
                                                  //       : 'ใกล้หมดสัญญา [${(((areaModels1.length ?? 0.0) * 100) / areaModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                  //   // 'ใกล้หมดสัญญา',
                                                  //   maxLines: 3,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,

                                                  //     // decoration:

                                                  //     //     TextDecoration.underline,

                                                  //     color: Colors.red,

                                                  //     fontWeight:
                                                  //         FontWeight.bold,

                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (areaModels1 == null)
                                                        ? '0 พื้นที่'
                                                        : '${nFormat2.format(double.parse(areaModels1.length.toString()))} พื้นที่',
                                                    Colors.red,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (areaModels1 == null)
                                                //       ? '0 พื้นที่'
                                                //       : '${nFormat2.format(double.parse(areaModels1.length.toString()))} พื้นที่',
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,

                                                //     // decoration:

                                                //     //     TextDecoration.underline,

                                                //     color: Colors.red,

                                                //     fontWeight: FontWeight.bold,

                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 8),
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
                                            // const Text(
                                            //   'แอดมิน',
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: TextStyle(
                                            //     shadows: [
                                            //       Shadow(
                                            //           color: Colors.black,
                                            //           offset: Offset(0, -5))
                                            //     ],
                                            //     color: Colors.transparent,
                                            //     // decoration: TextDecoration
                                            //     //     .underline,
                                            //     decorationColor: Colors.grey,
                                            //     decorationThickness: 4,
                                            //     // decorationStyle:
                                            //     //     TextDecorationStyle
                                            //     //         .dashed,
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.bold,
                                            //     fontFamily: FontWeight_.Fonts_T,
                                            //   ),
                                            // ),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    // decoration:
                                                    //     TextDecoration.underline,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'ทั้งหมด',
                                                          Colors.green,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),
                                                  // Text(
                                                  //   'ทั้งหมด',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     // decoration:
                                                  //     //     TextDecoration.underline,
                                                  //     color: Colors.green,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (userModels.isEmpty)
                                                        ? '0 คน'
                                                        : '${nFormat2.format(userModels.length)} คน',
                                                    Colors.green,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (userModels.isEmpty)
                                                //       ? '0 คน'
                                                //       : '${nFormat2.format(userModels.length)} คน',
                                                //   maxLines: 1,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     // decoration:
                                                //     //     TextDecoration.underline,
                                                //     color: Colors.green,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          (user_today == 0.00)
                                                              ? 'วันนี้ [0%]'
                                                              : 'วันนี้ [${(((user_today ?? 0.0) * 100) / userModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                          Colors.red,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),
                                                  //  Text(
                                                  //   (user_today == 0.00)
                                                  //       ? 'วันนี้ [0%]'
                                                  //       : 'วันนี้ [${(((user_today ?? 0.0) * 100) / userModels.length ?? 0.0).toStringAsFixed(2)}%]',
                                                  //   // 'ใช้งานวันนี้',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,

                                                  //     // decoration:

                                                  //     //     TextDecoration.underline,

                                                  //     color: Colors.red,

                                                  //     fontWeight:
                                                  //         FontWeight.bold,

                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    '${nFormat2.format(user_today)} คน',
                                                    Colors.red,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   '${nFormat2.format(user_today)} คน',
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,

                                                //     // decoration:

                                                //     //     TextDecoration.underline,

                                                //     color: Colors.red,

                                                //     fontWeight: FontWeight.bold,

                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 8),
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
                                            // const Text(
                                            //   'รวมรายรับ (ชำระแล้ว Cash/Bank)',
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: TextStyle(
                                            //     shadows: [
                                            //       Shadow(
                                            //           color: Colors.black,
                                            //           offset: Offset(0, -5))
                                            //     ],
                                            //     color: Colors.transparent,
                                            //     // decoration: TextDecoration
                                            //     //     .underline,
                                            //     decorationColor: Colors.grey,
                                            //     decorationThickness: 4,
                                            //     // decorationStyle:
                                            //     //     TextDecorationStyle
                                            //     //         .dashed,
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.bold,
                                            //     fontFamily: FontWeight_.Fonts_T,
                                            //   ),
                                            // ),
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'ทั้งหมด ',
                                                          Colors.blue,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),
                                                  //  Text(
                                                  //   'ทั้งหมด ',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     // decoration:
                                                  //     //     TextDecoration.underline,
                                                  //     color: Colors.blue,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (total1_ == null)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(total1_)} บาท',
                                                    Colors.blue,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (total1_ == null)
                                                //       ? '0.00 บาท'
                                                //       : '${nFormat.format(total1_)} บาท',
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     // decoration:
                                                //     //     TextDecoration.underline,
                                                //     color: Colors.blue,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          (totalcash_ == 0.00)
                                                              ? 'Cash [0%]'
                                                              : 'Cash [${(((totalcash_ ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                                          Colors.green,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),

                                                  // Text(
                                                  //   (totalcash_ == 0.00)
                                                  //       ? 'Cash [0%]'
                                                  //       : 'Cash [${(((totalcash_ ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     // decoration:
                                                  //     //     TextDecoration.underline,
                                                  //     color: Colors.green,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (totalcash_ == null)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(totalcash_)} บาท',
                                                    Colors.green,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (totalcash_ == null)
                                                //       ? '0.00 บาท'
                                                //       : '${nFormat.format(totalcash_)} บาท',
                                                //   maxLines: 1,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     // decoration:
                                                //     //     TextDecoration.underline,
                                                //     color: Colors.green,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          (totalbank == 0.00)
                                                              ? 'Bank [0%]'
                                                              : 'Bank [${(((totalbank ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                                          Colors.red,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),
                                                  // Text(
                                                  //   (totalbank == 0.00)
                                                  //       ? 'Bank [0%]'
                                                  //       : 'Bank [${(((totalbank ?? 0.0) * 100) / total1_ ?? 0.0).toStringAsFixed(2)}%]',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,

                                                  //     // decoration:

                                                  //     //     TextDecoration.underline,

                                                  //     color: Colors.red,

                                                  //     fontWeight:
                                                  //         FontWeight.bold,

                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (totalbank == null)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(totalbank)} บาท',
                                                    Colors.red,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (totalbank == null)
                                                //       ? '0.00 บาท'
                                                //       : '${nFormat.format(totalbank)} บาท',
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,

                                                //     // decoration:

                                                //     //     TextDecoration.underline,

                                                //     color: Colors.red,

                                                //     fontWeight: FontWeight.bold,

                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 8),
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
                                            // const Text(
                                            //   'รวมรายรับ (ชำระแล้ว )',
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: TextStyle(
                                            //     shadows: [
                                            //       Shadow(
                                            //           color: Colors.black,
                                            //           offset: Offset(0, -5))
                                            //     ],
                                            //     color: Colors.transparent,
                                            //     // decoration: TextDecoration
                                            //     //     .underline,
                                            //     decorationColor: Colors.grey,
                                            //     decorationThickness: 4,
                                            //     // decorationStyle:
                                            //     //     TextDecorationStyle
                                            //     //         .dashed,
                                            //     fontSize: 12,
                                            //     fontWeight: FontWeight.bold,
                                            //     fontFamily: FontWeight_.Fonts_T,
                                            //   ),
                                            // ),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    // decoration:
                                                    //     TextDecoration.underline,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'ก่อน-หักส่วนลด',
                                                          Colors.green,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),

                                                  //  Text(
                                                  //   'ก่อน-หักส่วนลด',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     // decoration:
                                                  //     //     TextDecoration.underline,
                                                  //     color: Colors.green,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (total2_ == null)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(total2_)} บาท',
                                                    Colors.green,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),
                                                // Text(
                                                //   (total2_ == null)
                                                //       ? '0.00 บาท'
                                                //       : '${nFormat.format(total2_)} บาท',
                                                //   maxLines: 2,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     // decoration:
                                                //     //     TextDecoration.underline,
                                                //     color: Colors.green,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
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
                                                  child: Translate
                                                      .TranslateAndSetText(
                                                          'หลัง-หักส่วนลด',
                                                          Colors.red,
                                                          TextAlign.start,
                                                          FontWeight.w500,
                                                          FontWeight_.Fonts_T,
                                                          12,
                                                          1),

                                                  //  Text(
                                                  //   'หลัง-หักส่วนลด',
                                                  //   maxLines: 2,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     // decoration:
                                                  //     //     TextDecoration.underline,
                                                  //     color: Colors.red,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontFamily:
                                                  //         FontWeight_.Fonts_T,
                                                  //   ),
                                                  // ),
                                                ),
                                                Translate.TranslateAndSetText(
                                                    (total1_ == null)
                                                        ? '0.00 บาท'
                                                        : '${nFormat.format(total1_)} บาท',
                                                    Colors.red,
                                                    TextAlign.end,
                                                    FontWeight.w500,
                                                    FontWeight_.Fonts_T,
                                                    12,
                                                    1),

                                                // Text(
                                                //   (total1_ == null)
                                                //       ? '0.00 บาท'
                                                //       : '${nFormat.format(total1_)} บาท',
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     // decoration:
                                                //     //     TextDecoration.underline,
                                                //     color: Colors.red,
                                                //     fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //   ),
                                                // ),
                                              ],
                                            ),
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
                  /////////--------------------------------------------->

                  (renTal_user.toString() == '50')
                      ? Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Translate.TranslateAndSetText(
                                  'รายงาน : ',
                                  ReportScreen_Color.Colors_Text1_,
                                  TextAlign.end,
                                  FontWeight.w500,
                                  FontWeight_.Fonts_T,
                                  16,
                                  1),

                              //  Text(
                              //   'รายงาน : ',
                              //   style: TextStyle(
                              //     color: ReportScreen_Color.Colors_Text1_,
                              //     fontWeight: FontWeight.bold,
                              //     fontFamily: FontWeight_.Fonts_T,
                              //   ),
                              // ),
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
                                      for (int index = -7; index < 1; index++)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                ser_pang_test = index;
                                                // if (index == 0) {
                                                //   ser_pang_test = -2;
                                                // } else if (index == 1) {
                                                //   ser_pang_test = -1;
                                                // } else {
                                                //   ser_pang_test = 0;
                                                // }
                                              });
                                            },
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: (index > -3)
                                                    ? (ser_pang_test == index)
                                                        ? Colors.teal[600]
                                                        : Colors.teal[200]
                                                    : (index > -5)
                                                        ? (ser_pang_test ==
                                                                index)
                                                            ? Colors.red
                                                            : Colors.red[200]
                                                        : (ser_pang_test ==
                                                                index)
                                                            ? Colors.blueGrey
                                                            : Colors
                                                                .blueGrey[200],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Center(
                                                child: AutoSizeText(
                                                  minFontSize: 10,
                                                  maxFontSize: 20,
                                                  (index == -7)
                                                      ? 'A-(ประตูCM)'
                                                      : (index == -6)
                                                          ? 'B-(ประตูCM)'
                                                          : (index == -5)
                                                              ? 'C-(ประตูCM)'
                                                              : (index == -4)
                                                                  ? 'A-(อ.ต.)'
                                                                  : (index ==
                                                                          -3)
                                                                      ? 'B-(อ.ต.)'
                                                                      : (index ==
                                                                              -2)
                                                                          ? 'A-(ChoiceMini)'
                                                                          : (index == -1)
                                                                              ? 'B-(ChoiceMini)'
                                                                              : 'C-(ChoiceMini)',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                ser_pang_test = index;
                                              });
                                            },
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                // color: (ser_pang == index + 1 ||
                                                //         ser_pang + index == 0)
                                                //     ? Colors.black54
                                                //     : Colors.black26,
                                                color: (ser_pang_test == index)
                                                    ? Colors.deepPurple
                                                    : Colors.deepPurple[200],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Center(
                                                child: Translate
                                                    .TranslateAndSetText(
                                                        'หน้า ${index}',
                                                        Colors.white,
                                                        TextAlign.end,
                                                        FontWeight.w500,
                                                        FontWeight_.Fonts_T,
                                                        16,
                                                        1),

                                                //  AutoSizeText(
                                                //   minFontSize: 10,
                                                //   maxFontSize: 20,
                                                //   'หน้า ${index}',
                                                //   style: const TextStyle(
                                                //     color: Colors.white,
                                                //     // fontWeight: FontWeight.bold,
                                                //     fontFamily:
                                                //         FontWeight_.Fonts_T,
                                                //     fontWeight: FontWeight.bold,
                                                //   ),
                                                // ),
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
                        )
                      : Row(
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
                                  child: (rtser.toString() == '65')
                                      ? Row(
                                          children: [
                                            for (int index = 0;
                                                index < 3;
                                                index++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (index == 0) {
                                                        ser_pang_CM = -2;
                                                      } else if (index == 1) {
                                                        ser_pang_CM = -1;
                                                      } else {
                                                        ser_pang_CM = 0;
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 125,
                                                    decoration: BoxDecoration(
                                                      color: (ser_pang_CM ==
                                                                  -2 &&
                                                              index == 0)
                                                          ? Colors.blueGrey
                                                          : (ser_pang_CM ==
                                                                      -1 &&
                                                                  index == 1)
                                                              ? Colors.blueGrey
                                                              : (ser_pang_CM ==
                                                                          0 &&
                                                                      index ==
                                                                          2)
                                                                  ? Colors
                                                                      .blueGrey
                                                                  : Colors.blueGrey[
                                                                      200],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
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
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            for (int index = 1;
                                                index < 12;
                                                index++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ser_pang_CM = index;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      // color: (ser_pang == index + 1 ||
                                                      //         ser_pang + index == 0)
                                                      //     ? Colors.black54
                                                      //     : Colors.black26,
                                                      color: (ser_pang_CM ==
                                                              index)
                                                          ? Colors.deepPurple
                                                          : Colors
                                                              .deepPurple[200],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 20,
                                                        'หน้า ${index}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        )
                                      : (rtser.toString() == '72' ||
                                              rtser.toString() == '92' ||
                                              rtser.toString() == '93' ||
                                              rtser.toString() == '94')
                                          ? Row(
                                              children: [
                                                for (int index = 1;
                                                    index < 3;
                                                    index++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (index == 0) {
                                                            ser_pang_Ortor = -2;
                                                          } else if (index ==
                                                              1) {
                                                            ser_pang_Ortor = -1;
                                                          } else {
                                                            ser_pang_Ortor = 0;
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 125,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (ser_pang_Ortor ==
                                                                      -2 &&
                                                                  index == 0)
                                                              ? Colors.blueGrey
                                                              : (ser_pang_Ortor ==
                                                                          -1 &&
                                                                      index ==
                                                                          1)
                                                                  ? Colors
                                                                      .blueGrey
                                                                  : (ser_pang_Ortor ==
                                                                              0 &&
                                                                          index ==
                                                                              2)
                                                                      ? Colors
                                                                          .blueGrey
                                                                      : Colors.blueGrey[
                                                                          200],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 20,
                                                            // 'Exclusive - A',
                                                            // (index == 0)
                                                            //     ? 'Exclusive - A'
                                                            //     :
                                                            (index == 1)
                                                                ? 'Exclusive - A'
                                                                : 'Exclusive - B',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                for (int index = 1;
                                                    index < 12;
                                                    index++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          ser_pang_Ortor =
                                                              index;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: (ser_pang == index + 1 ||
                                                          //         ser_pang + index == 0)
                                                          //     ? Colors.black54
                                                          //     : Colors.black26,
                                                          color: (ser_pang_Ortor ==
                                                                  index)
                                                              ? Colors
                                                                  .deepPurple
                                                              : Colors.deepPurple[
                                                                  200],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 20,
                                                            'หน้า ${index}',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            )
                                          : (rtser.toString() == '106')
                                              ? Row(
                                                  children: [
                                                    for (int index = -3;
                                                        index < 1;
                                                        index++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              ser_pang_Choice =
                                                                  index;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 125,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: (ser_pang_Choice ==
                                                                      index)
                                                                  ? Colors
                                                                      .teal[600]
                                                                  : Colors.teal[
                                                                      200],
                                                              borderRadius:
                                                                  const BorderRadius
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 20,
                                                                (index == -3)
                                                                    ? 'Exclusive - A'
                                                                    : (index ==
                                                                            -2)
                                                                        ? 'Exclusive - B'
                                                                        : (index ==
                                                                                -1)
                                                                            ? 'Exclusive - C'
                                                                            : 'Exclusive - D',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    for (int index = 1;
                                                        index < 13;
                                                        index++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              ser_pang_Choice =
                                                                  index;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: (ser_pang == index + 1 ||
                                                              //         ser_pang + index == 0)
                                                              //     ? Colors.black54
                                                              //     : Colors.black26,
                                                              color: (ser_pang_Choice ==
                                                                      index)
                                                                  ? Colors
                                                                      .deepPurple
                                                                  : Colors.deepPurple[
                                                                      200],
                                                              borderRadius:
                                                                  const BorderRadius
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 20,
                                                                'หน้า ${index}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    for (int index = 0;
                                                        index < 11;
                                                        index++)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              ser_pang =
                                                                  index + 1;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              // color: (ser_pang == index + 1 ||
                                                              //         ser_pang + index == 0)
                                                              //     ? Colors.black54
                                                              //     : Colors.black26,
                                                              color: (ser_pang ==
                                                                          index +
                                                                              1 ||
                                                                      ser_pang +
                                                                              index ==
                                                                          0)
                                                                  ? Colors
                                                                      .deepPurple
                                                                  : Colors.deepPurple[
                                                                      200],
                                                              borderRadius:
                                                                  const BorderRadius
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 20,
                                                                'หน้า ${index + 1}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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

                  /////////---------------------------------------------> Report_Choice_Screen
                  (renTal_user.toString() == '50')
                      ? (ser_pang_test == -7)
                          ? Report_cm_ScreenA()
                          : (ser_pang_test == -6)
                              ? Report_cm_ScreenB()
                              : (ser_pang_test == -5)
                                  ? Report_cm_ScreenC()
                                  : (ser_pang_test == -4)
                                      ? Report_Ortor_ScreenA()
                                      : (ser_pang_test == -3)
                                          ? Report_Ortor_ScreenB()
                                          : (ser_pang_test == -2)
                                              ? Report_Choice_ScreenA()
                                              : (ser_pang_test == -1)
                                                  ? Report_Choice_ScreenB()
                                                  : (ser_pang_test == 0)
                                                      ? Report_Choice_ScreenC()
                                                      : (ser_pang_test == 1)
                                                          ? const ReportScreen1()
                                                          : (ser_pang_test == 2)
                                                              ? const ReportScreen2()
                                                              : (ser_pang_test ==
                                                                      3)
                                                                  ? const ReportScreen3()
                                                                  : (ser_pang_test ==
                                                                          4)
                                                                      ? const ReportScreen4()
                                                                      : (ser_pang_test ==
                                                                              5)
                                                                          ? const ReportScreen5()
                                                                          : (ser_pang_test == 6)
                                                                              ? const ReportScreen6()
                                                                              : (ser_pang_test == 7)
                                                                                  ? const ReportScreen7()
                                                                                  : (ser_pang_test == 8)
                                                                                      ? const ReportScreen8()
                                                                                      : (ser_pang_test == 9)
                                                                                          ? const ReportScreen9()
                                                                                          : (ser_pang_test == 10)
                                                                                              ? const ReportScreen10()
                                                                                              : const ReportScreen11()
                      //     /////////--------------------------------------------->
                      : Man_typeSer(context)
                  /////////--------------------------------------------->DeC_area ////DeC_Zone
                ],
              ),
            ),
          );
  }

  Widget Man_typeSer(BuildContext context) {
    return (rtser.toString() == '65')
        ? CM(context)
        : (rtser.toString() == '72' ||
                rtser.toString() == '92' ||
                rtser.toString() == '93' ||
                rtser.toString() == '94')
            ? Ortor(context)
            : (rtser.toString() == '106')
                ? Choice(context)
                : Normal(context);
  }

  Widget Normal(BuildContext context) {
    return (ser_pang == 1 || ser_pang == 0)
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
                                        ? const ReportScreen9()
                                        : (ser_pang == 10)
                                            ? const ReportScreen10()
                                            : const ReportScreen11();
  }

  Widget CM(BuildContext context) {
    ////-----ser_pang_CM
    return (ser_pang_CM == -2)
        ? Report_cm_ScreenA()
        : (ser_pang_CM == -1)
            ? Report_cm_ScreenB()
            : (ser_pang_CM == 0)
                ? Report_cm_ScreenC()
                : (ser_pang_CM == 1)
                    ? const ReportScreen1()
                    : (ser_pang_CM == 2)
                        ? const ReportScreen2()
                        : (ser_pang_CM == 3)
                            ? const ReportScreen3()
                            : (ser_pang_CM == 4)
                                ? const ReportScreen4()
                                : (ser_pang_CM == 5)
                                    ? const ReportScreen5()
                                    : (ser_pang_CM == 6)
                                        ? const ReportScreen6()
                                        : (ser_pang_CM == 7)
                                            ? const ReportScreen7()
                                            : (ser_pang_CM == 8)
                                                ? const ReportScreen8()
                                                : (ser_pang_CM == 9)
                                                    ? const ReportScreen9()
                                                    : (ser_pang_CM == 10)
                                                        ? const ReportScreen10()
                                                        : const ReportScreen11();
  }

  Widget Ortor(BuildContext context) {
    return (ser_pang_Ortor == -1)
        ? Report_Ortor_ScreenA()
        : (ser_pang_Ortor == 0)
            ? Report_Ortor_ScreenB()
            : (ser_pang_Ortor == 1)
                ? const ReportScreen1()
                : (ser_pang_Ortor == 2)
                    ? const ReportScreen2()
                    : (ser_pang_Ortor == 3)
                        ? const ReportScreen3()
                        : (ser_pang_Ortor == 4)
                            ? const ReportScreen4()
                            : (ser_pang_Ortor == 5)
                                ? const ReportScreen5()
                                : (ser_pang_Ortor == 6)
                                    ? const ReportScreen6()
                                    : (ser_pang_Ortor == 7)
                                        ? const ReportScreen7()
                                        : (ser_pang_Ortor == 8)
                                            ? const ReportScreen8()
                                            : (ser_pang_Ortor == 9)
                                                ? const ReportScreen9()
                                                : (ser_pang_Ortor == 10)
                                                    ? const ReportScreen10()
                                                    : const ReportScreen11();
  }

  Widget Choice(BuildContext context) {
    return (ser_pang_Choice == -3)
        ? Report_Choice_ScreenA()
        : (ser_pang_Choice == -2)
            ? Report_Choice_ScreenB()
            : (ser_pang_Choice == -1)
                ? Report_Choice_ScreenC()
                : (ser_pang_Choice == 0)
                    ? Report_Choice_ScreenD()
                    : (ser_pang_Choice == 1)
                        ? const ReportScreen1()
                        : (ser_pang_Choice == 2)
                            ? const ReportScreen2()
                            : (ser_pang_Choice == 3)
                                ? const ReportScreen3()
                                : (ser_pang_Choice == 4)
                                    ? const ReportScreen4()
                                    : (ser_pang_Choice == 5)
                                        ? const ReportScreen5()
                                        : (ser_pang_Choice == 6)
                                            ? const ReportScreen6()
                                            : (ser_pang_Choice == 7)
                                                ? const ReportScreen7()
                                                : (ser_pang_Choice == 8)
                                                    ? const ReportScreen8()
                                                    : (ser_pang_Choice == 9)
                                                        ? const ReportScreen9()
                                                        : (ser_pang_Choice ==
                                                                10)
                                                            ? const ReportScreen10()
                                                            : const ReportScreen11();
  }
}
