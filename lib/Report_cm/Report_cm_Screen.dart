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
import '../Model/GetContractx_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_SCReportTotal_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Model/trans_re_bill_model_REprot_CM.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Report/Report_Screen2.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/colors.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'Excel_Bankmovemen_Report_cm.dart';
import 'Excel_Custo_Report_cm.dart';
import 'Excel_DailyReport_category_cm.dart';
import 'Excel_Daily_Report_cm.dart';
import 'Excel_Daily_Report_cus_cm.dart';
import 'Excel_Expense_Report_cm.dart';
import 'Excel_Income_Report_cm.dart';
import 'Excel_Tax_Report_cm.dart';
import 'Excgen_tenants _zone_cm.dart';
import 'Report_cm_Screen2.dart';

class Report_cm_Screen extends StatefulWidget {
  const Report_cm_Screen({super.key});

  @override
  State<Report_cm_Screen> createState() => _Report_cm_ScreenState();
}

class _Report_cm_ScreenState extends State<Report_cm_Screen> {
  int ser_pang = 0;
  DateTime datex = DateTime.now();
  int Status_ = 1;
  int PerandDow_ = 1;
  var Value_selectDate_Daily;

  var Value_Chang_Zone_Daily;
  var Value_Chang_Zone_Ser_Daily;

  var Value_Chang_Zone_Income;
  var Value_Chang_Zone_Ser_Income;

  // var Value_selectDate_Daily_Type_;
  var Value_selectDate_daly_cus;
  var Value_selectDate1;
  var Value_selectDate2;
  var Value_Chang_Zone_;
  var Value_YE_Zone_;
  var Value_Chang_Zone_Ser_;
  double Sum_total_dis = 0.00;
///////-------------------------------------------
  List<Map<String, dynamic>> datalist001_Incom = [];
  List<RenTalModel> renTalModels = [];
  List<PayMentModel> payMentModels = [];
  List<CustomerModel> customerModels = [];
  List<ContractxModel> contractxModels = [];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<AreaModel> areaModels = [];
  List<AreaModel> areaModels1 = [];
  List<AreaModel> areaModels2 = [];
  List<AreaModel> areaModels3 = [];
  // List<CustomerModel> customerModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<TransReBillModelRECM> _TransReBillModels = [];
  List<TransReBillModelRECM> _TransReBillModels_GropType = [];
  List<TransReBillModelRECM> _TransReBillModels_cus = [];

  List<ExpModel> expModels = [];
  List<TransReBillModelRECM> _TransReBillModels_Income = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Income = [];
  List<TransReBillModelRECM> _TransReBillModels_Bankmovemen = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Bankmovemen = [];
  // List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  late List<List<dynamic>> TransReBillModels_Income;
  late List<List<dynamic>> TransReBillModels_Bankmovemen;
  late List<List<dynamic>> TransReBillModels;
  late List<List<dynamic>> TransReBillModels_cus;

  List<List<TransReBillHistoryModel>> custo_TransReBillHistoryModels = [];

  //////////////////////----------------------------------
  String? renTal_user, renTal_name, zone_ser, zone_name;
  String? numinvoice;
  int select_1 = 0;
  int select_2 = 0;
  int TransReBillModel_index = 0;
  DateTime now = DateTime.now();
  String? SDatex_total1_;
  String? LDatex_total1_;
  double total1_ = 0.00;
  double total2_ = 0.00;

  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");

  String _verticalGroupValue_PassW = "EXCEL";
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
  String? YE_;
  String? Mon_;
  String? YE_Income;
  String? Mon_Income;
  String overview_Ser_Zone_ = '0';
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  String? ciddoc_Cusdaly_Cm;
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
    read_GC_Exp();
    read_GC_zone();
    read_GC_PayMentModel();
    checkPreferance();
    read_GC_rental();

    read_GC_area1();
    read_GC_area2();
    red_Sum_billIncome();

    TransReBillModels_Income = [];
    TransReBillModels_Bankmovemen = [];
    TransReBillModels = [];
    TransReBillModels_cus = [];
  }

  Future<Null> read_GC_PayMentModel() async {
    if (payMentModels.length != 0) {
      payMentModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('ren >>>>>> $ren');

    String url =
        '${MyConstant().domain}/GC_Bank_Paytype.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
    if (zoneModels_report.length != 0) {
      zoneModels_report.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
      }
      zoneModels_report.sort((a, b) {
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

  Future<Null> setState_() async {
    setState(() {
      YE_ = null;
      Mon_ = null;

      Value_selectDate_Daily = null;
      // Value_selectDate_Daily_Type_ = null;
      Value_selectDate_daly_cus = null;
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
          } else {
            newValuePDFimg.add(
                '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
          }
        }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

/////////////////----------------------------------->(รวมรายรับ ชำระแล้ว)
  Future<Null> red_Sum_billIncome() async {
    setState(() {
      total1_ = 0.00;
      total2_ = 0.00;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (overview_Ser_Zone_.toString() != '0')
        ? '${MyConstant().domain}/GC_SCReport_total1_zone.php?isAdd=true&ren=$ren&sdate=$SDatex_total1_&ldate=$LDatex_total1_&ser_zone=$overview_Ser_Zone_'
        : '${MyConstant().domain}/GC_SCReport_total1.php?isAdd=true&ren=$ren&sdate=$SDatex_total1_&ldate=$LDatex_total1_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModels_Incomes =
              TransReBillModel.fromJson(map);
          setState(() {
            total1_ = (_TransReBillModels_Incomes.total_dis == null)
                ? total1_ + double.parse(_TransReBillModels_Incomes.total_bill!)
                : total1_ + double.parse(_TransReBillModels_Incomes.total_dis!);

            total2_ = (_TransReBillModels_Incomes.total_bill == null)
                ? total2_ + 0.00
                : total2_ +
                    double.parse(_TransReBillModels_Incomes.total_bill!);

            //  (_TransReBillModels_Incomes.total_bill == null ||
            //         _TransReBillModels_Incomes.total_bill.toString() == '')
            //     ? total1_ + 0.00
            //     : total1_ +
            //         double.parse(_TransReBillModels_Incomes.total_bill!);
          });
          print(_TransReBillModels_Incomes.amt);
        }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานรายรับ)

  Future<Null> red_Trans_billIncome() async {
    if (_TransReBillModels_Income.length != 0) {
      setState(() {
        _TransReBillModels_Income.clear();
        TransReBillModels_Income = [];
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport_Cm.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM _TransReBillModels_Incomes =
              TransReBillModelRECM.fromJson(map);
          setState(() {
            _TransReBillModels_Income.add(_TransReBillModels_Incomes);
          });
        }

        print('result ${_TransReBillModels_Income.length}');

        TransReBillModels_Income =
            List.generate(_TransReBillModels_Income.length, (_) => []);
        red_Trans_selectIncome();
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานรายรับ)
  Future<Null> red_Trans_selectIncome() async {
    for (int index = 0; index < _TransReBillModels_Income.length; index++) {
      if (_TransReBillHistoryModels_Income.length != 0) {
        setState(() {
          _TransReBillHistoryModels_Income.clear();
        });
      }
      if (TransReBillModels_Income[index].length != 0) {
        TransReBillModels_Income[index].clear();
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      var user = preferences.getString('ser');
      var ciddoc = _TransReBillModels_Income[index].ser;
      var qutser = _TransReBillModels_Income[index].ser_in;
      var docnoin = (_TransReBillModels_Income[index].docno == null)
          ? _TransReBillModels_Income[index].refno
          : _TransReBillModels_Income[index].docno;
      String url =
          '${MyConstant().domain}/GC_bill_pay_history_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillHistoryModel _TransReBillHistoryModels_Incomes =
                TransReBillHistoryModel.fromJson(map);

            var sum_pvatx =
                double.parse(_TransReBillHistoryModels_Incomes.pvat!);
            var sum_vatx = double.parse(_TransReBillHistoryModels_Incomes.vat!);
            var sum_whtx = double.parse(_TransReBillHistoryModels_Incomes.wht!);
            var sum_amtx =
                double.parse(_TransReBillHistoryModels_Incomes.total!);

            var numinvoiceent = _TransReBillHistoryModels_Incomes.docno;
            setState(() {
              numinvoice = _TransReBillHistoryModels_Incomes.docno;
              _TransReBillHistoryModels_Income.add(
                  _TransReBillHistoryModels_Incomes);
              TransReBillModels_Income[index]
                  .add(_TransReBillHistoryModels_Incomes);
            });
          }
        }
      } catch (e) {}
    }
  }

///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคาร)
  Future<Null> red_Trans_billMovemen() async {
    if (_TransReBillModels_Bankmovemen.length != 0) {
      setState(() {
        _TransReBillModels_Bankmovemen.clear();
        TransReBillModels_Bankmovemen = [];
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_BankmovemenReport_CMma.php?isAdd=true&ren=$ren&mont_h=$Mon_Income&yea_r=$YE_Income&serzone=$Value_Chang_Zone_Ser_Income';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM _TransReBillModels_Bankmovemens =
              TransReBillModelRECM.fromJson(map);
          setState(() {
            _TransReBillModels_Bankmovemen.add(_TransReBillModels_Bankmovemens);
          });
        }

        print('result ${_TransReBillModels_Bankmovemen.length}');

        TransReBillModels_Bankmovemen =
            List.generate(_TransReBillModels_Bankmovemen.length, (_) => []);
        red_Trans_selectMovemen();
      }
    } catch (e) {}
  }

  ///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคาร)
  Future<Null> red_Trans_selectMovemen() async {
    for (int index = 0;
        index < _TransReBillModels_Bankmovemen.length;
        index++) {
      if (_TransReBillHistoryModels_Bankmovemen.length != 0) {
        setState(() {
          _TransReBillHistoryModels_Bankmovemen.clear();
        });
      }
      if (TransReBillModels_Bankmovemen[index].length != 0) {
        TransReBillModels_Bankmovemen[index].clear();
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      var user = preferences.getString('ser');
      var ciddoc = _TransReBillModels_Bankmovemen[index].ser;
      var qutser = _TransReBillModels_Bankmovemen[index].ser_in;
      var docnoin = (_TransReBillModels_Bankmovemen[index].docno == null)
          ? _TransReBillModels_Bankmovemen[index].refno
          : _TransReBillModels_Bankmovemen[index].docno;
      String url =
          '${MyConstant().domain}/GC_bill_pay_history_MovemenReport_CMma.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillHistoryModel _TransReBillHistoryModels_Bankmovemens =
                TransReBillHistoryModel.fromJson(map);

            var sum_pvatx =
                double.parse(_TransReBillHistoryModels_Bankmovemens.pvat!);
            var sum_vatx =
                double.parse(_TransReBillHistoryModels_Bankmovemens.vat!);
            var sum_whtx =
                double.parse(_TransReBillHistoryModels_Bankmovemens.wht!);
            var sum_amtx =
                double.parse(_TransReBillHistoryModels_Bankmovemens.total!);

            var numinvoiceent = _TransReBillHistoryModels_Bankmovemens.docno;
            setState(() {
              numinvoice = _TransReBillHistoryModels_Bankmovemens.docno;
              _TransReBillHistoryModels_Bankmovemen.add(
                  _TransReBillHistoryModels_Bankmovemens);
              TransReBillModels_Bankmovemen[index]
                  .add(_TransReBillHistoryModels_Bankmovemens);
            });
          }
        }
      } catch (e) {}
    }
  }

///////////--------------------------------------------->(รายงานประจำวัน)
  Future<Null> red_Trans_bill() async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
        TransReBillModels = [];
        // Sum_total_dis = 0.00;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_DailyReport_CMma.php?isAdd=true&ren=$ren&date=$Value_selectDate_Daily&serzone=$Value_Chang_Zone_Ser_Daily';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM transReBillModel =
              TransReBillModelRECM.fromJson(map);
          setState(() {
            _TransReBillModels.add(transReBillModel);
          });
        }

        print('result ${_TransReBillModels.length}');

        TransReBillModels = List.generate(_TransReBillModels.length, (_) => []);

        red_Trans_select();
      }
    } catch (e) {}
  }

  double calculateTotalValue_Daily_Cm(index_exp) {
    double totalValue = 0.0;
    for (int index1 = 0; index1 < _TransReBillModels.length; index1++) {
      double valueToAdd = TransReBillModels[index1].fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            (element.expser.toString() == expModels[index_exp].ser.toString() &&
                    element.total.toString() != '' &&
                    element.total != null
                ? double.parse(element.total!)
                : 0),
      );
      totalValue += valueToAdd;
    }
    return totalValue;
  }

//////////////--------------------------------------------------->
  String calculateTotalBills_Zone(int index1) {
    Set<String> uniqueDocnos = {};
    double totalBills = 0.0;

    totalBills = double.parse((_TransReBillModels_GropType.map((e) =>
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

    // for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
    //   if (_TransReBillModels_GropType[index].room_number.toString() !=
    //       'ล็อคเสียบ') {
    //     if (!uniqueDocnos.contains(_TransReBillModels_GropType[index].docno)) {
    //       if (_TransReBillModels_GropType[index].zser == null) {
    //         totalBills += double.parse(_TransReBillModels_GropType[index]
    //                     .zser1 ==
    //                 zoneModels_report[index1].ser
    //             ? _TransReBillModels_GropType[index].total_expname == null ||
    //                     _TransReBillModels_GropType[index].total_expname! == ''
    //                 ? 0.toString()
    //                 : _TransReBillModels_GropType[index]
    //                     .total_expname
    //                     .toString()
    //             : 0.toString());
    //       } else {
    //         totalBills += double.parse(_TransReBillModels_GropType[index]
    //                     .zser ==
    //                 zoneModels_report[index1].ser
    //             ? _TransReBillModels_GropType[index].total_expname == null ||
    //                     _TransReBillModels_GropType[index].total_expname! == ''
    //                 ? 0.toString()
    //                 : _TransReBillModels_GropType[index]
    //                     .total_expname
    //                     .toString()
    //             : 0.toString());
    //       }
    //       uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
    //     }
    //   }
    // }

    return totalBills.toString();
  }

  String calculateTotalBills_Sumdis_Zone(int index1) {
    Set<String> uniqueDocnos = {};
    double totalBills = 0.0;
    // double totalBills_dis = 0.0;

    for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
      if (!uniqueDocnos.contains(_TransReBillModels_GropType[index].docno)) {
        if (_TransReBillModels_GropType[index].zser == null) {
          if (_TransReBillModels_GropType[index].total_dis == null) {
            totalBills += double.parse(_TransReBillModels_GropType[index]
                        .zser1 ==
                    zoneModels_report[index1].ser
                ? _TransReBillModels_GropType[index].total_bill == null ||
                        _TransReBillModels_GropType[index].total_bill! == ''
                    ? 0.toString()
                    : _TransReBillModels_GropType[index].total_bill.toString()
                : 0.toString());
          } else {
            totalBills += double.parse(_TransReBillModels_GropType[index]
                        .zser1 ==
                    zoneModels_report[index1].ser
                ? _TransReBillModels_GropType[index].total_dis == null ||
                        _TransReBillModels_GropType[index].total_dis! == ''
                    ? 0.toString()
                    : _TransReBillModels_GropType[index].total_dis.toString()
                : 0.toString());
          }
        } else {
          if (_TransReBillModels_GropType[index].total_dis == null) {
            totalBills += double.parse(_TransReBillModels_GropType[index]
                        .zser ==
                    zoneModels_report[index1].ser
                ? _TransReBillModels_GropType[index].total_bill == null ||
                        _TransReBillModels_GropType[index].total_bill! == ''
                    ? 0.toString()
                    : _TransReBillModels_GropType[index].total_bill.toString()
                : 0.toString());
          } else {
            totalBills += double.parse(_TransReBillModels_GropType[index]
                        .zser ==
                    zoneModels_report[index1].ser
                ? _TransReBillModels_GropType[index].total_dis == null ||
                        _TransReBillModels_GropType[index].total_dis! == ''
                    ? 0.toString()
                    : _TransReBillModels_GropType[index].total_dis.toString()
                : 0.toString());
          }
        }
        uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
      }
    }

    return totalBills.toString();
  }

  String calculateTotalArea_Zone(int index1) {
    Set<String> uniqueDocnos = {};
    double totalArea = 0.0;

    for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
      if (_TransReBillModels_GropType[index].room_number.toString() !=
          'ล็อคเสียบ') {
        if (!uniqueDocnos.contains(_TransReBillModels_GropType[index].docno)) {
          if (_TransReBillModels_GropType[index].zser == null) {
            totalArea += double.parse(
                _TransReBillModels_GropType[index].zser1 ==
                        zoneModels_report[index1].ser
                    ? _TransReBillModels_GropType[index].area == null ||
                            _TransReBillModels_GropType[index].area! == ''
                        ? 1.toString()
                        : _TransReBillModels_GropType[index].area.toString()
                    : 0.toString());
          } else {
            totalArea += double.parse(_TransReBillModels_GropType[index].zser ==
                    zoneModels_report[index1].ser
                ? _TransReBillModels_GropType[index].area == null ||
                        _TransReBillModels_GropType[index].area! == ''
                    ? 1.toString()
                    : _TransReBillModels_GropType[index].area.toString()
                : 0.toString());
          }
          uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
        }
      }
    }

    return totalArea.toString();
  }

  String calculateTotalBills_AllZone() {
    Set<String> uniqueDocnos = {};
    double totalAllBills = 0.0;

    for (int index = 0; index < zoneModels_report.length; index++) {
      totalAllBills += double.parse((_TransReBillModels_GropType.map((e) =>
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
      // if (_TransReBillModels_GropType[index].room_number.toString() !=
      //     'ล็อคเสียบ') {
      //   if (!uniqueDocnos.contains(_TransReBillModels_GropType[index].docno)) {
      //     totalAllBills += double.parse(_TransReBillModels_GropType[index]
      //                     .total_expname ==
      //                 null ||
      //             _TransReBillModels_GropType[index].total_expname.toString() ==
      //                 ''
      //         ? 0.toString()
      //         : _TransReBillModels_GropType[index].total_expname.toString());

      //     uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
      //   }
      // }
    }

    return totalAllBills.toString();
  }

  String calculateTotalBills_Sumdis_AllZone() {
    Set<String> uniqueDocnos = {};
    double totalAllBills = 0.0;

    for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
      if (!uniqueDocnos.contains(_TransReBillModels_GropType[index].docno)) {
        if (_TransReBillModels_GropType[index].total_dis == null) {
          totalAllBills += double.parse(_TransReBillModels_GropType[index]
                          .total_bill ==
                      null ||
                  _TransReBillModels_GropType[index].total_bill.toString() == ''
              ? 0.toString()
              : _TransReBillModels_GropType[index].total_bill.toString());
        } else {
          totalAllBills += double.parse(
              _TransReBillModels_GropType[index].total_dis == null ||
                      _TransReBillModels_GropType[index].total_dis.toString() ==
                          ''
                  ? 0.toString()
                  : _TransReBillModels_GropType[index].total_dis.toString());
        }

        uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
      }
    }

    return totalAllBills.toString();
  }

  String calculateTotalArea_AllZone() {
    Set<String> uniqueDocnos = {};
    double totalAllArea = 0.0;

    for (int index = 0; index < _TransReBillModels_GropType.length; index++) {
      if (_TransReBillModels_GropType[index].room_number.toString() !=
          'ล็อคเสียบ') {
        if (!uniqueDocnos.contains(_TransReBillModels_GropType[index].docno)) {
          totalAllArea += double.parse(
              _TransReBillModels_GropType[index].area == null ||
                      _TransReBillModels_GropType[index].area! == ''
                  ? 1.toString()
                  : _TransReBillModels_GropType[index].area.toString());

          uniqueDocnos.add(_TransReBillModels_GropType[index].docno!);
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
      // (zoneModels_report[index1].jon! == '1' &&
      //         zoneModels_report[index1].jon_book! == '1')
      //     ? total7Kana += double.parse(calculateTotalBills_Zone(index1)!) -
      //         (double.parse(calculateTotalArea_Zone(index1)!) *
      //             double.parse('${zoneModels_report[index1].b_2}'))
      //     : total7Kana += double.parse(calculateTotalArea_Zone(index1)!) *
      //         double.parse('${zoneModels_report[index1].b_1}');
    }

    return total7Kana.toString();
  }

  String calculateTotal_B2_AllZone() {
    double totalBA = 0.0;

    for (int index1 = 0; index1 < zoneModels_report.length; index1++) {
      // totalBA += double.parse(calculateTotalArea_Zone(index1)!) *
      //     double.parse('${zoneModels_report[index1].b_2}');

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
      totalBA += double.parse((_TransReBillModels_GropType.map((e) =>
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
          totalBA += double.parse((_TransReBillModels_GropType.map((e) =>
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
      // (zoneModels_report[index1].jon! == '1' &&
      //         zoneModels_report[index1].jon_book! == '3')
      //     ? totalB3 += double.parse(calculateTotalBills_Zone(index1)!) -
      //         (double.parse(calculateTotalArea_Zone(index1)!) *
      //             double.parse('${zoneModels_report[index1].b_2}'))
      //     : totalB3 += double.parse(calculateTotalArea_Zone(index1)!) *
      //         double.parse('${zoneModels_report[index1].b_3}');
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
      // (zoneModels_report[index1].jon! == '1' &&
      //         zoneModels_report[index1].jon_book! == '4')
      //     ? totalB4 += double.parse(calculateTotalBills_Zone(index1)!) -
      //         (double.parse(calculateTotalArea_Zone(index1)!) *
      //             double.parse('${zoneModels_report[index1].b_2}'))
      //     : totalB4 += double.parse(calculateTotalArea_Zone(index1)!) *
      //         double.parse('${zoneModels_report[index1].b_4}');
    }
    return totalB4.toString();
  }

  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_exp_Report_Cm.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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

///////////--------------------------------------------->(รายงานประจำวันรายบุคคล)

  Future<Null> red_Trans_bill_custo_Cm() async {
    if (_TransReBillModels_cus.length != 0) {
      setState(() {
        _TransReBillModels_cus.clear();
        TransReBillModels_cus = [];
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_DailyReport_Custo_CMma.php?isAdd=true&ren=$ren&date=$Value_selectDate_daly_cus&ciddoc=$ciddoc_Cusdaly_Cm';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModelRECM transReBillModel =
              TransReBillModelRECM.fromJson(map);
          setState(() {
            _TransReBillModels_cus.add(transReBillModel);
          });
        }

        print('result ${_TransReBillModels_cus.length}');

        TransReBillModels_cus =
            List.generate(_TransReBillModels_cus.length, (_) => []);

        red_Trans_select_cus();
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select_cus() async {
    String index_st = 'true';
    for (int index = 0; index < TransReBillModels_cus.length; index++) {
      if (_TransReBillHistoryModels.length != 0) {
        setState(() {
          index_st = 'true';
          _TransReBillHistoryModels.clear();
        });
      }
      if (TransReBillModels_cus[index].length != 0) {
        TransReBillModels_cus[index].clear();
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      var user = preferences.getString('ser');
      var ciddoc = _TransReBillModels_cus[index].ser;
      var qutser = _TransReBillModels_cus[index].ser_in;
      var docnoin = _TransReBillModels_cus[index].docno;
      String url =
          '${MyConstant().domain}/GC_bill_pay_history_DailyReport_CMma.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      int ii = 0;
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillHistoryModel _TransReBillHistoryModel =
                TransReBillHistoryModel.fromJson(map);

            var sum_pvatx = double.parse(_TransReBillHistoryModel.pvat!);
            var sum_vatx = double.parse(_TransReBillHistoryModel.vat!);
            var sum_whtx = double.parse(_TransReBillHistoryModel.wht!);
            var sum_amtx = double.parse(_TransReBillHistoryModel.total!);

            var numinvoiceent = _TransReBillHistoryModel.docno;
            setState(() {
              numinvoice = _TransReBillHistoryModel.docno;

              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
              TransReBillModels_cus[index].add(_TransReBillHistoryModel);
            });
            if (index_st == 'true') {
              setState(() {
                index_st = 'false';
              });
            } else {}
          }
        }
      } catch (e) {}
    }
  }

  /////------------------------------------------------------------->(รายชื่อผู้เช่า //รายงานประจำวันรายบุคคล)
  Future<Null> GC_coutumer_daly_CM() async {
    if (teNantModels.isNotEmpty) {
      setState(() {
        teNantModels.clear();
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_custo_se_daly_CMma.php?isAdd=true&ren=$ren&datexS=$Value_selectDate_daly_cus';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);
          });
        }
        setState(() {
          _teNantModels = teNantModels;
        });

        custo_TransReBillHistoryModels =
            List.generate(teNantModels.length, (_) => []);
        await GC_coutumer_select_c_contractx();
        await red_select_Custo_Trans();
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานประจำวัน)

  Future<Null> red_Trans_select() async {
    String index_st = 'true';
    for (int index = 0; index < _TransReBillModels.length; index++) {
      if (_TransReBillHistoryModels.length != 0) {
        setState(() {
          index_st = 'true';
          _TransReBillHistoryModels.clear();
        });
      }
      if (TransReBillModels[index].length != 0) {
        TransReBillModels[index].clear();
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      var user = preferences.getString('ser');
      var ciddoc = _TransReBillModels[index].ser;
      var qutser = _TransReBillModels[index].ser_in;
      var docnoin = _TransReBillModels[index].docno;
      String url =
          '${MyConstant().domain}/GC_bill_pay_history_DailyReport_CMma.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      int ii = 0;
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillHistoryModel _TransReBillHistoryModel =
                TransReBillHistoryModel.fromJson(map);

            var sum_pvatx = double.parse(_TransReBillHistoryModel.pvat!);
            var sum_vatx = double.parse(_TransReBillHistoryModel.vat!);
            var sum_whtx = double.parse(_TransReBillHistoryModel.wht!);
            var sum_amtx = double.parse(_TransReBillHistoryModel.total!);

            var numinvoiceent = _TransReBillHistoryModel.docno;
            setState(() {
              numinvoice = _TransReBillHistoryModel.docno;

              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
              TransReBillModels[index].add(_TransReBillHistoryModel);
            });

            if (index_st == 'true') {
              setState(() {
                index_st = 'false';
              });
            } else {}
          }
        }
        // setState(() {
        //   red_Invoice();
        // });
      } catch (e) {}
    }
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

    print('zone >>>>>> $zone');

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
              print('หมดสัญญาวันนี้');
            } else if (difference <= 90 && difference > 0) {
              setState(() {
                areaModels1.add(areaModel);
              });
              print('ใกล้หมดสัญญา');
            } else if (difference < 0) {
              print('หมดสัญญา');
            } else {
              print('ไม่ใกล้หมดสัญญา');
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
    print('Time read_GC_area(): ${difference.inSeconds} seconds');
    print('Time read_GC_area(): ${difference.inSeconds} seconds');
    print('Time read_GC_area(): ${difference.inSeconds} seconds');
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

    print('zone >>>>>> $zone');

    String url = zone == null
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
        zone_ser = preferences.getString('zoneSer');
        zone_name = preferences.getString('zonesName');
      });
    } catch (e) {}
    var end = DateTime.now();
    var difference = end.difference(start);
  }

/////------------------------------------------------------------->(รายงานผู้เช่าแยกตามโซน)
  ///
  Future<Null> read_GC_tenant() async {
    if (teNantModels.isNotEmpty) {
      setState(() {
        teNantModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    print('zone>>>>>>zone>>>>>$Value_Chang_Zone_Ser_');

    String url =
        '${MyConstant().domain}/GC_tenant_Cm.php?isAdd=true&ren=$ren&zone=$Value_Chang_Zone_Ser_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);
          });
        }
      } else {
        setState(() {
          if (teNantModels.isEmpty) {
            preferences.remove('zonePSer');
            preferences.remove('zonesPName');
            zone_ser = null;
            zone_name = null;
          }
        });
      }

      setState(() {
        _teNantModels = teNantModels;
      });
    } catch (e) {}
  }

/////------------------------------------------------------------->(รายงานผู้เช่า)

  Future<Null> GC_coutumer() async {
    if (teNantModels.isNotEmpty) {
      setState(() {
        teNantModels.clear();
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_custo_se_CMma.php?isAdd=true&ren=$ren&monthS=$Mon_&yearS=$YE_&type=1';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        // for (var map in result) {
        //   CustomerModel customerModel = CustomerModel.fromJson(map);
        //   setState(() {
        //     customerModels.add(customerModel);
        //   });
        // }
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            teNantModels.add(teNantModel);
          });

          // GC_coutumer_select_c_contractx('${teNantModel.cid}');
        }
        // coutumer_rent_CM = List.generate(teNantModels.length, (_) => []);
        // coutumer_tank_CM = List.generate(teNantModels.length, (_) => []);
        // coutumer_electricity_CM = List.generate(teNantModels.length, (_) => []);
        // coutumer_MOMO_CM = List.generate(teNantModels.length, (_) => []);
        // coutumer_rent_area_CM = List.generate(teNantModels.length, (_) => []);
        // coutumer_total_sum_CM = List.generate(teNantModels.length, (_) => []);
        custo_TransReBillHistoryModels =
            List.generate(teNantModels.length, (_) => []);
        await GC_coutumer_select_c_contractx();
        await red_select_Custo_Trans();
      }
    } catch (e) {}
  }

  Future<Null> red_select_Custo_Trans() async {
    for (int index = 0; index < teNantModels.length; index++) {
      if (custo_TransReBillHistoryModels[index].length != 0) {
        setState(() {
          custo_TransReBillHistoryModels[index].clear();
        });
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      var user = preferences.getString('ser');
      // var ciddoc = widget.Get_Value_cid;
      // var qutser = widget.Get_Value_NameShop_index;

      String url =
          '${MyConstant().domain}/GC_custo_bill_pay_history_ReportCM.php?isAdd=true&ren=$ren&cidser=${teNantModels[index].cid}&montser=${Mon_}&yearser=${YE_}';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillHistoryModel _TransReBillHistoryModel =
                TransReBillHistoryModel.fromJson(map);
            print(
                '${index + 1}/${teNantModels.length} : docno***docno*docno***${_TransReBillHistoryModel.docno}');
            setState(() {
              custo_TransReBillHistoryModels[index]
                  .add(_TransReBillHistoryModel);
            });
          }
        }
      } catch (e) {}
    }
  }

  // late List<List<dynamic>> coutumer_rent_CM;
  // late List<List<dynamic>> coutumer_tank_CM;
  // late List<List<dynamic>> coutumer_electricity_CM;
  // late List<List<dynamic>> coutumer_MOMO_CM;
  // late List<List<dynamic>> coutumer_rent_area_CM;
  // late List<List<dynamic>> coutumer_total_sum_CM;

  Future<Null> GC_coutumer_select_c_contractx() async {
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;
    for (int index = 0; index < teNantModels.length; index++) {
      if (contractxModels.length != 0) {
        setState(() {
          contractxModels.clear();
          // coutumer_rent_CM[index].clear();
          // coutumer_tank_CM[index].clear();
          // coutumer_electricity_CM[index].clear();
          // coutumer_MOMO_CM[index].clear();
          // coutumer_rent_area_CM[index].clear();
          // coutumer_total_sum_CM[index].clear();
        });
      }
      double Sumsum = 0.00;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      String url =
          '${MyConstant().domain}/GC_custo_select_c_contractx_CMma.php?isAdd=true&ren=$ren&sercid=${teNantModels[index].cid}';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print('result $ciddoc');
        if (result.toString() != 'null') {
          for (var map in result) {
            ContractxModel contractxModel = ContractxModel.fromJson(map);
            setState(() {
              contractxModels.add(contractxModel);
            });
          }
          // coutumer_total_sum_CM[index].add('${Sumsum}');
          print('contractxModel.length : ${contractxModels.length}');
        }
      } catch (e) {}
    }
  }
  ///////---------------------------------------------------->

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 22.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (text) {
        text = text.toLowerCase();
        setState(() {
          teNantModels = _teNantModels.where((teNantModelss) {
            var notTitle = teNantModelss.cid!.toLowerCase();
            var notTitle2 = teNantModelss.cname!.toLowerCase();
            var notTitle3 = teNantModelss.sname!.toLowerCase();
            var notTitle4 = teNantModelss.ln!.toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text);
          }).toList();

          // }
        });
      },
    );
  }
//////////////-----------------------------------------------------ฬ>

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
        var formatter = DateFormat('y-MM-d');
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
        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          LDatex_total1_ = "${formatter.format(result)}";
        });
        red_Sum_billIncome();
      }
    });
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
        TransReBillModels = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate_daly_cus = null;
          Value_selectDate_Daily = "${formatter.format(result)}";
        });

        // red_Trans_bill_Groptype_daly();
      }
    });
  }

////////////-----------------------(วันที่รายงาน รายชื่อผู้เช่ารายวันแยกตามประเภท)
  ///
  // Future<Null> _select_Date_Daily_type(BuildContext context) async {
  //   final Future<DateTime?> picked = showDatePicker(
  //     // locale: const Locale('th', 'TH'),
  //     helpText: 'เลือกวันที่', confirmText: 'ตกลง',
  //     cancelText: 'ยกเลิก',
  //     context: context,
  //     initialDate: DateTime(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
  //     initialDatePickerMode: DatePickerMode.day,
  //     firstDate: DateTime(2023, 1, 1),
  //     lastDate: DateTime(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day),
  //     // selectableDayPredicate: _decideWhichDayToEnable,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: AppBarColors.ABar_Colors, // header background color
  //             onPrimary: Colors.white, // header text color
  //             onSurface: Colors.black, // body text color
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               primary: Colors.black, // button text color
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   picked.then((result) {
  //     if (picked != null) {
  //       TransReBillModels = [];

  //       var formatter = DateFormat('y-MM-d');
  //       print("${formatter.format(result!)}");
  //       setState(() {
  //         Value_selectDate_daly_cus = null;
  //         Value_selectDate_Daily = null;
  //         Value_selectDate_Daily_Type_ = "${formatter.format(result)}";
  //       });
  //       // red_Trans_bill();
  //       red_Trans_bill_Groptype_daly();
  //     }
  //   });
  // }

//////////------------------------------------->
  Future<Null> _select_Date_daly_cus(BuildContext context) async {
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
        TransReBillModels_cus = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate_Daily = null;

          Value_selectDate_daly_cus = "${formatter.format(result)}";
        });
        red_Trans_bill_custo_Cm();
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
        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate1 = "${formatter.format(result)}";
          Value_selectDate2 = null;
          _TransReBillModels_Income = [];
          _TransReBillHistoryModels_Income = [];
          _TransReBillModels_Bankmovemen = [];
          _TransReBillHistoryModels_Bankmovemen = [];
          TransReBillModels_Income = [];
          TransReBillModels_Bankmovemen = [];
          // TransReBillModels = [];
        });

        // List<TransReBillModel> _TransReBillModels_Income = [];
        // List<TransReBillHistoryModel> _TransReBillHistoryModels_Income = [];
        // List<TransReBillModel> _TransReBillModels_Bankmovemen = [];
        // List<TransReBillHistoryModel> _TransReBillHistoryModels_Bankmovemen = [];
        // late List<List<dynamic>> TransReBillModels_Income;
        // late List<List<dynamic>> TransReBillModels_Bankmovemen;
        //   late List<List<dynamic>> TransReBillModels;
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
        red_Trans_billIncome();

        red_Trans_billMovemen();
      }
    });
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
                                setState_();
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
  }

////////////------------------------------------------>
  void InkWell_onTap(context) async {
    setState(() {
      NameFile_ = '';
      NameFile_ = FormNameFile_text.text;
    });

    if (_verticalGroupValue_NameFile == 'กำหนดเอง') {
    } else {
      if (_verticalGroupValue_PassW == 'PDF') {
        // if (Value_Report == 'ภาษี') {
        //   _displayPdf_();
        // } else if (Value_Report == 'รายงานรายรับ') {
        //   _displayPdf_();
        // } else if (Value_Report == 'รายงานรายจ่าย') {
        //   _displayPdf_();
        // } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
        //   _displayPdf_();
        // } else if (Value_Report == 'รายงานประจำวัน') {
        //   _displayPdf_();
        // } else if (Value_Report == 'รายงานรายรับรายวันแยกตามประเภท') {
        //   _displayPdf_();
        // } else if (Value_Report == 'รายงานรายชื่อผู้เช่าแยกตามโซน') {
        //   _displayPdf_();
        // }

        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'ภาษี') {
          Excgen_TaxReport_cm.exportExcel_TaxReport_cm(
              context, NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานรายรับ') {
          Excgen_IncomeReport_cm.exportExcel_IncomeReport_cm(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              Value_Report,
              _TransReBillModels_Income,
              TransReBillModels_Income,
              bill_name,
              Value_selectDate1,
              Value_selectDate2,
              zoneModels_report,
              Value_Chang_Zone_Income,
              Mon_Income,
              YE_Income);
        } else if (Value_Report == 'รายงานรายจ่าย') {
          Excgen_ExpenseReport_cm.exportExcel_ExpenseReport_cm(
              context, NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          Excgen_BankmovemenReport_cm.exportExcel_BankmovemenReport_cm(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              Value_Report,
              _TransReBillModels_Bankmovemen,
              TransReBillModels_Bankmovemen,
              bill_name,
              Value_selectDate1,
              Value_selectDate2,
              zoneModels_report,
              Value_Chang_Zone_Income,
              Mon_Income,
              YE_Income,
              payMentModels);
        } else if (Value_Report == 'รายงานประจำวัน') {
          Excgen_DailyReport_cm.exportExcel_DailyReport_cm(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              Value_Report,
              _TransReBillModels,
              TransReBillModels,
              bill_name,
              Value_selectDate_Daily,
              zoneModels_report,
              expModels,
              Value_Chang_Zone_Daily);
        } else if (Value_Report == 'รายงานรายชื่อผู้เช่าแยกตามโซน') {
          Excgen_tenants_zone_cm.excgen_tenants_zone_cm(
              context,
              NameFile_,
              renTal_name,
              _verticalGroupValue_NameFile,
              Value_Chang_Zone_,
              teNantModels);
          //Excgen_tenants _zone_cm
          // Excgen_DailyReport_category_cm.excgen_DailyReport_category_cm(
          //     context,
          //     NameFile_,
          //     renTal_name,
          //     _verticalGroupValue_NameFile,
          //     Value_selectDate,
          //     zoneModels_report,
          //     _TransReBillModels_GropType);
        } else if (Value_Report == 'รายงานรายบุคคล') {
          // Excgen_DailyReport_cus_cm.exportExcel_DailyReport_cus_cm(
          //     context,
          //     NameFile_,
          //     _verticalGroupValue_NameFile,
          //     Value_Report,
          //     _TransReBillModels_cus,
          //     TransReBillModels_cus,
          //     bill_name,
          //     Value_selectDate_daly_cus,
          //     rent_CM_cus,
          //     tank_CM_cus,
          //     electricity_CM_cus,
          //     MOMO_CM_cus,
          //     rent_area_CM_cus,
          //     sum_numDay_refno_CM_cus,
          //     zoneModels_report);
        } else if (Value_Report == 'รายงานผู้เช่า') {
          // Excgen_Custo_cm.exportExcel_Custo_cm(
          //     context,
          //     NameFile_,
          //     _verticalGroupValue_NameFile,
          //     Value_Report,
          //     teNantModels,
          //     bill_name,
          //     Value_selectDate_Daily,
          //     coutumer_MOMO_CM,
          //     coutumer_tank_CM,
          //     coutumer_rent_area_CM,
          //     coutumer_electricity_CM,
          //     coutumer_total_sum_CM,
          //     custo_TransReBillHistoryModels,
          //     YE_,
          //     Mon_);
        }

        Navigator.of(context).pop();
      }
    }
  }

  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext builderContext) {
          Timer(Duration(seconds: 4), () {
            Navigator.of(context).pop();
          });

          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
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
                        InkWell(
                          onTap: () {
                            //sendLineMessage();
                            // sendLineMessageToUser();
                            // sendLineMessage();
                          },
                          child: const AutoSizeText(
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
                        ),
                        const AutoSizeText(
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
            const Padding(
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
                              child: AutoSizeText(
                                'ภาพรวมการดำเนินการเดือนปัจจุบัน ',
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
                  ],
                )),
/////---------------------------------------------->
            (!Responsive.isDesktop(context))
                ? BodyHome_mobile()
                : BodyHome_Web(),
////---------------------------------------------->
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'รายงาน',
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
                          for (int index = 0; index < 2; index++)
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
                                        ? Colors.deepPurple[700]
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
              ],
            ),

            (ser_pang == 1)
                ? Report_cm_Screen2()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงานรูปแบบพิเศษเฉพาะ ',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'เดือน :',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
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
                                              fillColor: Colors.white
                                                  .withOpacity(0.05),
                                              filled: false,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 231, 227, 227),
                                                ),
                                              ),
                                            ),
                                            isExpanded: false,
                                            value: Mon_Income,
                                            // hint: Text(
                                            //   Mon_Income == null
                                            //       ? 'เลือก'
                                            //       : '$Mon_Income',
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            items: [
                                              for (int item = 1;
                                                  item < 13;
                                                  item++)
                                                DropdownMenuItem<String>(
                                                  value: '${item}',
                                                  child: Text(
                                                    '${monthsInThai[item - 1]}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                            ],

                                            onChanged: (value) async {
                                              Mon_Income = value;
                                            },
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'ปี :',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
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
                                              fillColor: Colors.white
                                                  .withOpacity(0.05),
                                              filled: false,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
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
                                            //   YE_Income == null
                                            //       ? 'เลือก'
                                            //       : '$YE_Income',
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            items: YE_Th.map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: '${item}',
                                                  child: Text(
                                                    '${item}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )).toList(),

                                            onChanged: (value) async {
                                              YE_Income = value;
                                            },
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'โซน :',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
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
                                              fillColor: Colors.white
                                                  .withOpacity(0.05),
                                              filled: false,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 231, 227, 227),
                                                ),
                                              ),
                                            ),
                                            isExpanded: false,
                                            value: Value_Chang_Zone_Income,
                                            // hint: Text(
                                            //   Value_Chang_Zone_Income == null
                                            //       ? 'เลือก'
                                            //       : '$Value_Chang_Zone_Income',
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
                                            buttonWidth: 250,
                                            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              // color: Colors
                                              //     .amber,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            items: zoneModels_report
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: '${item.zn}',
                                                      child: Text(
                                                        '${item.zn}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),

                                            onChanged: (value) async {
                                              int selectedIndex =
                                                  zoneModels_report.indexWhere(
                                                      (item) =>
                                                          item.zn == value);

                                              setState(() {
                                                Value_Chang_Zone_Income =
                                                    value!;
                                                Value_Chang_Zone_Ser_Income =
                                                    zoneModels_report[
                                                            selectedIndex]
                                                        .ser!;
                                              });
                                              print(
                                                  'Selected Index: $Value_Chang_Zone_Income  //${Value_Chang_Zone_Ser_Income}');
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            if (Value_Chang_Zone_Income !=
                                                null) {
                                              red_Trans_billIncome();
                                              red_Trans_billMovemen();
                                            }
                                            Dia_log();
                                          },
                                          child: Container(
                                              width: 100,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.green[700],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'ค้นหา',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // (_TransReBillModels_Income.isEmpty)
                                //     ? Container(
                                //         decoration: BoxDecoration(
                                //           color: Colors.yellow[600],
                                //           borderRadius: const BorderRadius.only(
                                //               topLeft: Radius.circular(10),
                                //               topRight: Radius.circular(10),
                                //               bottomLeft: Radius.circular(10),
                                //               bottomRight: Radius.circular(10)),
                                //           border: Border.all(
                                //               color: Colors.grey, width: 1),
                                //         ),
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Center(
                                //           child: Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: const [
                                //               Text(
                                //                 'เรียกดู',
                                //                 style: TextStyle(
                                //                   color: ReportScreen_Color
                                //                       .Colors_Text1_,
                                //                   fontWeight: FontWeight.bold,
                                //                   fontFamily: FontWeight_.Fonts_T,
                                //                 ),
                                //               ),
                                //               Icon(
                                //                 Icons.navigate_next,
                                //                 color: Colors.grey,
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       )
                                //     : (TransReBillModels_Income[
                                //                     _TransReBillModels_Income.length -
                                //                         1]
                                //                 .length ==
                                //             0)
                                //         ? Text('data')
                                //         :
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[600],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'เรียกดู',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text1_,
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
                                  onTap:
                                      // (_TransReBillModels_Income.isEmpty ||
                                      //         Value_selectDate1 == null ||
                                      //         Value_selectDate2 == null)
                                      //     ? null
                                      //     : (TransReBillModels_Income[
                                      //                 _TransReBillModels_Income
                                      //                         .length -
                                      //                     1]
                                      //             .isEmpty)
                                      //         ? null
                                      //         :
                                      () async {
                                    Insert_log.Insert_logs(
                                        'รายงาน', 'กดดูรายงานรายรับ');
                                    // List show_more = [];
                                    int? show_more;

                                    // double Sum_Ramt_ = 0.0;
                                    // double Sum_Ramtd_ = 0.0;
                                    // double Sum_Amt_ = 0.0;
                                    // double Sum_Total_ = 0.0;
                                    // double Sum_dis_ = 0.0;

                                    setState(() {
                                      Sum_total_dis = 0.00;
                                    });

                                    // for (int indexsum1 = 0;
                                    //     indexsum1 < _TransReBillModels_Income.length;
                                    //     indexsum1++) {
                                    //   Sum_Ramt_ = Sum_Ramt_ +
                                    //       double.parse((_TransReBillModels_Income[
                                    //                       indexsum1]
                                    //                   .ramt ==
                                    //               null)
                                    //           ? '0.00'
                                    //           : _TransReBillModels_Income[indexsum1]
                                    //               .ramt!);

                                    //   Sum_Ramtd_ = Sum_Ramtd_ +
                                    //       double.parse((_TransReBillModels_Income[
                                    //                       indexsum1]
                                    //                   .ramtd ==
                                    //               null)
                                    //           ? '0.00'
                                    //           : _TransReBillModels_Income[indexsum1]
                                    //               .ramtd!);

                                    //   Sum_Amt_ = Sum_Amt_ +
                                    //       double.parse((_TransReBillModels_Income[
                                    //                       indexsum1]
                                    //                   .amt ==
                                    //               null)
                                    //           ? '0.00'
                                    //           : _TransReBillModels_Income[indexsum1]
                                    //               .amt!);

                                    //   Sum_Total_ = Sum_Total_ +
                                    //       double.parse((_TransReBillModels_Income[
                                    //                       indexsum1]
                                    //                   .total_bill ==
                                    //               null)
                                    //           ? '0.00'
                                    //           : _TransReBillModels_Income[indexsum1]
                                    //               .total_bill!);

                                    //   Sum_dis_ = (_TransReBillModels_Income[indexsum1]
                                    //               .total_dis ==
                                    //           null)
                                    //       ? Sum_dis_ + 0.00
                                    //       : Sum_dis_ +
                                    //           (double.parse(_TransReBillModels_Income[
                                    //                       indexsum1]
                                    //                   .total_bill!) -
                                    //               double.parse(
                                    //                   _TransReBillModels_Income[
                                    //                           indexsum1]
                                    //                       .total_dis!));

                                    //   Sum_total_dis = (_TransReBillModels_Income[
                                    //                   indexsum1]
                                    //               .total_dis ==
                                    //           null)
                                    //       ? Sum_total_dis +
                                    //           double.parse(
                                    //               _TransReBillModels_Income[indexsum1]
                                    //                   .total_bill!)
                                    //       : Sum_total_dis +
                                    //           double.parse(
                                    //               _TransReBillModels_Income[indexsum1]
                                    //                   .total_dis!);
                                    // }

                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                (Value_Chang_Zone_Income ==
                                                        null)
                                                    ? 'รายงานรายรับ (กรุณาเลือกโซน)'
                                                    : 'รายงานรายรับ (โซน : $Value_Chang_Zone_Income)',
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              )),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        (Mon_Income == null &&
                                                                YE_Income ==
                                                                    null)
                                                            ? 'เดือน : ? (?) '
                                                            : (Mon_Income ==
                                                                    null)
                                                                ? 'เดือน : ? ($YE_Income) '
                                                                : (YE_Income ==
                                                                        null)
                                                                    ? 'เดือน : $Mon_Income (?) '
                                                                    : 'เดือน : $Mon_Income ($YE_Income) ',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          fontSize: 14,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'ทั้งหมด: ${_TransReBillModels_Income.length}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
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
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return ScrollConfiguration(
                                                  behavior: ScrollConfiguration
                                                          .of(context)
                                                      .copyWith(dragDevices: {
                                                    PointerDeviceKind.touch,
                                                    PointerDeviceKind.mouse,
                                                  }),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          // color: Colors.grey[50],
                                                          width: (Responsive
                                                                  .isDesktop(
                                                                      context))
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.9
                                                              : (_TransReBillModels_Income
                                                                          .length ==
                                                                      0)
                                                                  ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width
                                                                  : 800,
                                                          // height:
                                                          //     MediaQuery.of(context)
                                                          //             .size
                                                          //             .height *
                                                          //         0.3,
                                                          child: (_TransReBillModels_Income
                                                                      .length ==
                                                                  0)
                                                              ? const Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        'ไม่พบข้อมูล ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  children: <Widget>[
                                                                    // for (int index1 = 0;
                                                                    //     index1 <
                                                                    //         _TransReBillModels
                                                                    //             .length;
                                                                    //     index1++)
                                                                    Expanded(
                                                                        // height: MediaQuery.of(context).size.height *
                                                                        //     0.45,
                                                                        child: ListView
                                                                            .builder(
                                                                      itemCount:
                                                                          _TransReBillModels_Income
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index1) {
                                                                        return ListTile(
                                                                          title:
                                                                              SizedBox(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        decoration: const BoxDecoration(
                                                                                          color: AppbackgroundColor.TiTile_Colors,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                        child: Text(
                                                                                          //            '${_TransReBillModels_Income[index1].docno}',
                                                                                          _TransReBillModels_Income[index1].docno == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].refno}',
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontFamily: FontWeight_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      // Expanded(
                                                                                      //   child: Text(
                                                                                      //     (_TransReBillModels_Income[index1].sname == null || _TransReBillModels_Income[index1].sname == Null) ? '${_TransReBillModels_Income[index1].remark1}' : '${_TransReBillModels_Income[index1].sname}',
                                                                                      //     textAlign: TextAlign.end,
                                                                                      //     style: const TextStyle(
                                                                                      //       color: ReportScreen_Color.Colors_Text1_,
                                                                                      //       fontWeight: FontWeight.bold,
                                                                                      //       fontFamily: FontWeight_.Fonts_T,
                                                                                      //     ),
                                                                                      //   ),
                                                                                      // )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if (show_more != index1)
                                                                                  SizedBox(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                          ),
                                                                                          // padding: const EdgeInsets.all(4.0),
                                                                                          child: const Row(
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                width: 20,
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'โซน',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'รหัสพื้นที่',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              // Expanded(
                                                                                              //   flex: 1,
                                                                                              //   child: Text(
                                                                                              //     'ชื่อร้านค้า',
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
                                                                                                  'วันที่',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'ชื่อร้านค้า',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'รูปแบบชำระ',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
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
                                                                                                  'รายการทั้งหมด',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              // Expanded(
                                                                                              //   flex: 1,
                                                                                              //   child: Text(
                                                                                              //     'รวม70%',
                                                                                              //     textAlign: TextAlign.right,
                                                                                              //     style: TextStyle(
                                                                                              //       color: ReportScreen_Color.Colors_Text1_,
                                                                                              //       fontWeight: FontWeight.bold,
                                                                                              //       fontFamily: FontWeight_.Fonts_T,
                                                                                              //     ),
                                                                                              //   ),
                                                                                              // ),
                                                                                              // Expanded(
                                                                                              //   flex: 1,
                                                                                              //   child: Text(
                                                                                              //     'รวม30%',
                                                                                              //     textAlign: TextAlign.right,
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
                                                                                                  'ส่วนลด',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'ราคารวม',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'หักส่วนลด',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'Slip',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  '...',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.grey[200],
                                                                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                          ),
                                                                                          // padding: const EdgeInsets.all(4.0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              const SizedBox(
                                                                                                width: 20,
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Income[index1].zn == null) ? '${_TransReBillModels_Income[index1].znn}' : '${_TransReBillModels_Income[index1].zn}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Income[index1].ln == null) ? '${_TransReBillModels_Income[index1].room_number}' : '${_TransReBillModels_Income[index1].ln}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  '${_TransReBillModels_Income[index1].daterec}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Income[index1].sname == null || _TransReBillModels_Income[index1].sname.toString() == '' || _TransReBillModels_Income[index1].sname.toString() == 'null') ? '${_TransReBillModels_Income[index1].remark}' : '${_TransReBillModels_Income[index1].sname}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  '${_TransReBillModels_Income[index1].type}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  //'ttt',
                                                                                                  (TransReBillModels_Income[index1].length == null || TransReBillModels_Income.isEmpty) ? '' : '${nFormat2.format(double.parse(TransReBillModels_Income[index1].length.toString()))}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Income[index1].total_dis == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!) - double.parse(_TransReBillModels_Income[index1].total_dis!))}',
                                                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: (((_TransReBillModels_Income[index1].total_dis == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!) - double.parse(_TransReBillModels_Income[index1].total_dis!))}') == '0.00') ? Colors.red : ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Income[index1].total_bill == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}',
                                                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: (((_TransReBillModels_Income[index1].total_bill == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}') == '0.00') ? Colors.red : ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Income[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_dis!))}',
                                                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: (((_TransReBillModels_Income[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_dis!))}') == '0.00') ? Colors.red : ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    onTap: (_TransReBillModels_Income[index1].slip.toString() == null || _TransReBillModels_Income[index1].slip == null || _TransReBillModels_Income[index1].slip.toString() == 'null')
                                                                                                        ? null
                                                                                                        : () async {
                                                                                                            String Url = await '${MyConstant().domain}/files/$foder/slip/${_TransReBillModels_Income[index1].slip}';
                                                                                                            showDialog(
                                                                                                              context: context,
                                                                                                              builder: (context) => AlertDialog(
                                                                                                                  title: Center(
                                                                                                                    child: Column(
                                                                                                                      children: [
                                                                                                                        Text(
                                                                                                                          _TransReBillModels_Income[index1].docno == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].refno}',
                                                                                                                          maxLines: 1,
                                                                                                                          textAlign: TextAlign.start,
                                                                                                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                                                        ),
                                                                                                                        Text(
                                                                                                                          '${_TransReBillModels_Income[index1].slip}',
                                                                                                                          textAlign: TextAlign.center,
                                                                                                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  content: Stack(
                                                                                                                    alignment: Alignment.center,
                                                                                                                    children: <Widget>[Image.network('$Url')],
                                                                                                                  ),
                                                                                                                  actions: <Widget>[
                                                                                                                    Column(
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
                                                                                                                        Row(
                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                          children: [
                                                                                                                            Padding(
                                                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                                                              child: Container(
                                                                                                                                width: 100,
                                                                                                                                decoration: const BoxDecoration(
                                                                                                                                  color: Colors.black,
                                                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                                                ),
                                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                                child: TextButton(
                                                                                                                                  onPressed: () => Navigator.pop(context, 'OK'),
                                                                                                                                  child: const Text(
                                                                                                                                    'ปิด',
                                                                                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ]),
                                                                                                            );
                                                                                                          },
                                                                                                    child: Container(
                                                                                                      // width: 100,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: (_TransReBillModels_Income[index1].slip.toString() == null || _TransReBillModels_Income[index1].slip == null || _TransReBillModels_Income[index1].slip.toString() == 'null') ? Colors.grey[300] : Colors.orange[300],
                                                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                      ),
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: const Center(
                                                                                                        child: Text(
                                                                                                          'เรียกดู',
                                                                                                          style: TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        show_more = index1;
                                                                                                      });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      width: 100,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.green[300],
                                                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                      ),
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: const Center(
                                                                                                        child: Text(
                                                                                                          'ดูเพิ่มเติม',
                                                                                                          style: TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
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
                                                                                if (show_more == index1)
                                                                                  SizedBox(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Stack(
                                                                                          children: [
                                                                                            Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(4.0),
                                                                                              child: const Row(
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'ลำดับ',
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'วันที่',
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'รายการ',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'Vat%',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'หน่วย',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'VAT',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'ราคาก่อน Vat',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'ราคารวม Vat',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Positioned(
                                                                                                top: 0,
                                                                                                right: 2,
                                                                                                child: InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      show_more = null;
                                                                                                    });
                                                                                                  },
                                                                                                  child: const Icon(
                                                                                                    Icons.cancel,
                                                                                                    color: Colors.red,
                                                                                                  ),
                                                                                                ))
                                                                                          ],
                                                                                        ),
                                                                                        for (int index2 = 0; index2 < TransReBillModels_Income[index1].length; index2++)
                                                                                          Container(
                                                                                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.green[100]!.withOpacity(0.5),
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
                                                                                                        '${index1 + 1}.${index2 + 1}',
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Income[index1][index2].date}',
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Income[index1][index2].expname}',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Income[index1][index2].nvat}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Income[index1][index2].vtype}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        (TransReBillModels_Income[index1][index2].vat == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].vat!))}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // Expanded(
                                                                                                    //   flex: 1,
                                                                                                    //   child: Text(
                                                                                                    //     (TransReBillModels_Income[index1][index2].ramt.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].ramt!))}',
                                                                                                    //     textAlign: TextAlign.right,
                                                                                                    //     style: const TextStyle(
                                                                                                    //       color: ReportScreen_Color.Colors_Text2_,
                                                                                                    //       // fontWeight:
                                                                                                    //       //     FontWeight.bold,
                                                                                                    //       fontFamily: Font_.Fonts_T,
                                                                                                    //     ),
                                                                                                    //   ),
                                                                                                    // ),
                                                                                                    // Expanded(
                                                                                                    //   flex: 1,
                                                                                                    //   child: Text(
                                                                                                    //     (TransReBillModels_Income[index1][index2].ramtd.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].ramtd!))}',
                                                                                                    //     textAlign: TextAlign.right,
                                                                                                    //     style: const TextStyle(
                                                                                                    //       color: ReportScreen_Color.Colors_Text2_,
                                                                                                    //       // fontWeight:
                                                                                                    //       //     FontWeight.bold,
                                                                                                    //       fontFamily: Font_.Fonts_T,
                                                                                                    //     ),
                                                                                                    //   ),
                                                                                                    // ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        (TransReBillModels_Income[index1][index2].amt == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].amt!))}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        (TransReBillModels_Income[index1][index2].total == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].total!))}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  height: 10,
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    )),
                                                                  ],
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          actions: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 20, 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  StreamBuilder(
                                                      stream: Stream.periodic(
                                                          const Duration(
                                                              seconds: 0)),
                                                      builder:
                                                          (context, snapshot) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 20, 4),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SizedBox(
                                                                height: 120,
                                                                width: (Responsive
                                                                        .isDesktop(
                                                                            context))
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.9
                                                                    : (_TransReBillModels.length ==
                                                                            0)
                                                                        ? MediaQuery.of(context)
                                                                            .size
                                                                            .width
                                                                        : 800,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[600],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(0),
                                                                            bottomRight: Radius.circular(0)),
                                                                      ),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวม',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวมส่วนลด',
                                                                                //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                                //  '${_TransReBillModels[index1].ramtd}',
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวมราคารวม',
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวมหักส่วนลด',
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
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
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(0),
                                                                            topRight: Radius.circular(0),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels_Income.length == 0)
                                                                                    ? '0.00'
                                                                                    : '${nFormat.format(double.parse((_TransReBillModels_Income.fold(
                                                                                          0.0,
                                                                                          (previousValue, element) => previousValue + (element.total_bill != null ? double.parse(element.total_bill!) : 0),
                                                                                        ) - _TransReBillModels_Income.fold(
                                                                                          0.0,
                                                                                          (previousValue, element) => previousValue + (element.total_dis != null ? double.parse(element.total_dis!) : double.parse(element.total_bill!)),
                                                                                        )).toString()))}',

                                                                                // '${nFormat.format(double.parse('$Sum_dis_'))}',

                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels_Income.length == 0)
                                                                                    ? '0.00'
                                                                                    : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
                                                                                        0.0,
                                                                                        (previousValue, element) => previousValue + (element.total_bill != null ? double.parse(element.total_bill!) : 0),
                                                                                      ).toString()))}',
                                                                                // '${nFormat.format(double.parse('$Sum_Total_'))}',
                                                                                // '$Sum_Total_',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels_Income.length == 0)
                                                                                    ? '0.00'
                                                                                    : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
                                                                                        0.0,
                                                                                        (previousValue, element) => previousValue + (element.total_dis != null ? double.parse(element.total_dis!) : double.parse(element.total_bill!)),
                                                                                      ).toString()))}',
                                                                                // '${nFormat.format(double.parse('$Sum_total_dis'))}',
                                                                                // '$Sum_Total_',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
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
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 1),
                                            const Divider(),
                                            const SizedBox(height: 1),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 8, 4),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (_TransReBillModels_Income
                                                            .length !=
                                                        0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: const Center(
                                                              child: Text(
                                                                'Export file',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              Value_Report =
                                                                  'รายงานรายรับ';
                                                              Pre_and_Dow =
                                                                  'Download';
                                                            });
                                                            // Navigator.pop(context);
                                                            _showMyDialog_SAVE();
                                                          },
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
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
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Center(
                                                            child: Text(
                                                              'ปิด',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          setState(() {
                                                            Value_Chang_Zone_Income =
                                                                null;
                                                            Mon_Income = null;
                                                            YE_Income = null;
                                                          });

                                                          red_Trans_billIncome();
                                                          red_Trans_billMovemen();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_Chang_Zone_Income != null &&
                                            Mon_Income != null &&
                                            YE_Income != null &&
                                            _TransReBillModels_Income.length ==
                                                0)
                                        ? 'รายงานรายรับ (ไม่พบข้อมูล ✖️)'
                                        : (Value_Chang_Zone_Income != null &&
                                                Mon_Income != null &&
                                                YE_Income != null &&
                                                _TransReBillModels_Income
                                                        .length !=
                                                    0)
                                            ? 'รายงานรายรับ ✔️'
                                            : 'รายงานรายรับ',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'เรียกดู',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text1_,
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
                                  ), //TransReBillModels_Bankmovemen
                                  onTap:
                                      // (_TransReBillModels_Bankmovemen.isEmpty)
                                      //     ? null
                                      //     : (TransReBillModels_Bankmovemen[
                                      //                     _TransReBillModels_Bankmovemen
                                      //                             .length -
                                      //                         1]
                                      //                 .length ==
                                      //             0)
                                      //         ? null
                                      //         :
                                      () {
                                    Insert_log.Insert_logs('รายงาน',
                                        'กดดูรายงานการเคลื่อนไหวธนาคาร ( )');
                                    // List show_more = [];
                                    int? show_more;

                                    // double Sum_Ramt_ = 0.0;
                                    // double Sum_Ramtd_ = 0.0;
                                    // double Sum_Amt_ = 0.0;
                                    // double Sum_Total_ = 0.0;
                                    // double Sum_dis_ = 0.0;

                                    // setState(() {
                                    //   Sum_total_dis = 0.00;
                                    // });

                                    // for (int indexsum1 = 0;
                                    //     indexsum1 <
                                    //         _TransReBillModels_Bankmovemen.length;
                                    //     indexsum1++) {
                                    //   Sum_Ramt_ = Sum_Ramt_ +
                                    //       double.parse(
                                    //           (_TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .ramt ==
                                    //                   null)
                                    //               ? '0.00'
                                    //               : _TransReBillModels_Bankmovemen[
                                    //                       indexsum1]
                                    //                   .ramt!);

                                    //   Sum_Ramtd_ = Sum_Ramtd_ +
                                    //       double.parse(
                                    //           (_TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .ramtd ==
                                    //                   null)
                                    //               ? '0.00'
                                    //               : _TransReBillModels_Bankmovemen[
                                    //                       indexsum1]
                                    //                   .ramtd!);

                                    //   Sum_Amt_ = Sum_Amt_ +
                                    //       double.parse(
                                    //           (_TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .amt ==
                                    //                   null)
                                    //               ? '0.00'
                                    //               : _TransReBillModels_Bankmovemen[
                                    //                       indexsum1]
                                    //                   .amt!);

                                    //   Sum_Total_ = Sum_Total_ +
                                    //       double.parse(
                                    //           (_TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .total_bill ==
                                    //                   null)
                                    //               ? '0.00'
                                    //               : _TransReBillModels_Bankmovemen[
                                    //                       indexsum1]
                                    //                   .total_bill!);

                                    //   Sum_dis_ = (_TransReBillModels_Bankmovemen[
                                    //                   indexsum1]
                                    //               .total_dis ==
                                    //           null)
                                    //       ? Sum_dis_ + 0.00
                                    //       : Sum_dis_ +
                                    //           (double.parse(
                                    //                   _TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .total_bill!) -
                                    //               double.parse(
                                    //                   _TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .total_dis!));

                                    //   Sum_total_dis =
                                    //       (_TransReBillModels_Bankmovemen[indexsum1]
                                    //                   .total_dis ==
                                    //               null)
                                    //           ? Sum_total_dis +
                                    //               double.parse(
                                    //                   _TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .total_bill!)
                                    //           : Sum_total_dis +
                                    //               double.parse(
                                    //                   _TransReBillModels_Bankmovemen[
                                    //                           indexsum1]
                                    //                       .total_dis!);
                                    // }

                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                (Value_Chang_Zone_Income ==
                                                        null)
                                                    ? 'รายงานการเคลื่อนไหวธนาคาร (กรุณาเลือกโซน)'
                                                    : 'รายงานการเคลื่อนไหวธนาคาร (โซน : $Value_Chang_Zone_Income) ',
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              )),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        (Mon_Income == null &&
                                                                YE_Income ==
                                                                    null)
                                                            ? 'เดือน : ? (?) '
                                                            : (Mon_Income ==
                                                                    null)
                                                                ? 'เดือน : ? ($YE_Income) '
                                                                : (YE_Income ==
                                                                        null)
                                                                    ? 'เดือน : $Mon_Income (?) '
                                                                    : 'เดือน : $Mon_Income ($YE_Income) ',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          fontSize: 14,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'ทั้งหมด: ${_TransReBillModels_Bankmovemen.length}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
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
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return ScrollConfiguration(
                                                  behavior: ScrollConfiguration
                                                          .of(context)
                                                      .copyWith(dragDevices: {
                                                    PointerDeviceKind.touch,
                                                    PointerDeviceKind.mouse,
                                                  }),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          // color: Colors.grey[50],
                                                          width: (Responsive
                                                                  .isDesktop(
                                                                      context))
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.9
                                                              : (_TransReBillModels_Bankmovemen
                                                                          .length ==
                                                                      0)
                                                                  ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width
                                                                  : 1200,
                                                          // height:
                                                          //     MediaQuery.of(context)
                                                          //             .size
                                                          //             .height *
                                                          //         0.3,
                                                          child: (_TransReBillModels_Bankmovemen
                                                                      .length ==
                                                                  0)
                                                              ? const Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        'ไม่พบข้อมูล',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  children: <Widget>[
                                                                    // for (int index1 = 0;
                                                                    //     index1 <
                                                                    //         _TransReBillModels
                                                                    //             .length;
                                                                    //     index1++)
                                                                    Expanded(
                                                                        // height: (Responsive.isDesktop(context))
                                                                        //     ? MediaQuery.of(context).size.width * 0.255
                                                                        //     : MediaQuery.of(context).size.height * 0.45,
                                                                        child: ListView
                                                                            .builder(
                                                                      itemCount:
                                                                          _TransReBillModels_Bankmovemen
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index1) {
                                                                        return ListTile(
                                                                          title:
                                                                              SizedBox(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        decoration: const BoxDecoration(
                                                                                          color: AppbackgroundColor.TiTile_Colors,
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                        ),
                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                        child: Text(
                                                                                          //            '${_TransReBillModels_Income[index1].docno}',
                                                                                          _TransReBillModels_Bankmovemen[index1].docno == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Bankmovemen[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels_Bankmovemen[index1].refno}',
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontFamily: FontWeight_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      // Expanded(
                                                                                      //   child: Text(
                                                                                      //     (_TransReBillModels_Income[index1].sname == null || _TransReBillModels_Income[index1].sname == Null) ? '${_TransReBillModels_Income[index1].remark1}' : '${_TransReBillModels_Income[index1].sname}',
                                                                                      //     textAlign: TextAlign.end,
                                                                                      //     style: const TextStyle(
                                                                                      //       color: ReportScreen_Color.Colors_Text1_,
                                                                                      //       fontWeight: FontWeight.bold,
                                                                                      //       fontFamily: FontWeight_.Fonts_T,
                                                                                      //     ),
                                                                                      //   ),
                                                                                      // )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if (show_more != index1)
                                                                                  SizedBox(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                          ),
                                                                                          // padding: const EdgeInsets.all(4.0),
                                                                                          child: const Row(
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                width: 20,
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'โซน',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'รหัสพื้นที่',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              // Expanded(
                                                                                              //   flex: 1,
                                                                                              //   child: Text(
                                                                                              //     'ชื่อร้านค้า',
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
                                                                                                  'วันที่',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'ชื่อร้านค้า',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'รูปแบบชำระ',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
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

                                                                                              // Expanded(
                                                                                              //   flex: 1,
                                                                                              //   child: Text(
                                                                                              //     'รายการทั้งหมด',
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
                                                                                                  'ธนาคาร',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'เลขบช.',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'ส่วนลด',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'ราคารวม',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'หักส่วนลด',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  'Slip',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  '...',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.grey[200],
                                                                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                          // padding: const EdgeInsets.all(4.0),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              const SizedBox(
                                                                                                width: 20,
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Bankmovemen[index1].zn == null) ? '${_TransReBillModels_Bankmovemen[index1].znn}' : '${_TransReBillModels_Bankmovemen[index1].zn}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  _TransReBillModels_Bankmovemen[index1].ln == null ? ' ${_TransReBillModels_Bankmovemen[index1].room_number}' : ' ${_TransReBillModels_Bankmovemen[index1].ln}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              // Expanded(
                                                                                              //   flex: 1,
                                                                                              //   child: Text(
                                                                                              //     (_TransReBillModels[index1].sname == null) ? '' : '${_TransReBillModels[index1].sname}',
                                                                                              //     // '${TransReBillModels[index1].length}',
                                                                                              //     textAlign: TextAlign.center,
                                                                                              //     style: const TextStyle(
                                                                                              //       color: ReportScreen_Color.Colors_Text1_,
                                                                                              //       // fontWeight: FontWeight.bold,
                                                                                              //       fontFamily: Font_.Fonts_T,
                                                                                              //     ),
                                                                                              //   ),
                                                                                              // ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  '${_TransReBillModels_Bankmovemen[index1].daterec}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Bankmovemen[index1].sname == null) ? '${_TransReBillModels_Bankmovemen[index1].remark1}' : '${_TransReBillModels_Bankmovemen[index1].sname}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  '${_TransReBillModels_Bankmovemen[index1].type}',
                                                                                                  // '${TransReBillModels[index1].length}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),

                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  // '${_TransReBillModels_Income[index1].ramt}',
                                                                                                  (_TransReBillModels_Bankmovemen[index1].bank == null) ? '' : '${_TransReBillModels_Bankmovemen[index1].bank!}',
                                                                                                  // '${_TransReBillModels[index1].ramt}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  // '${_TransReBillModels_Income[index1].ramtd}',
                                                                                                  (_TransReBillModels_Bankmovemen[index1].bno == null) ? '' : '${_TransReBillModels_Bankmovemen[index1].bno!}',
                                                                                                  //'${nFormat.format(double.parse(_TransReBillModels_Income[index1].ramtd!))}',
                                                                                                  //  '${_TransReBillModels[index1].ramtd}',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Bankmovemen[index1].total_dis == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_bill!) - double.parse(_TransReBillModels_Bankmovemen[index1].total_dis!))}',
                                                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Bankmovemen[index1].total_bill == null) ? '' : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_bill!))}',
                                                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Text(
                                                                                                  (_TransReBillModels_Bankmovemen[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_dis!))}',
                                                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: const TextStyle(
                                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                                    // fontWeight: FontWeight.bold,
                                                                                                    fontFamily: Font_.Fonts_T,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    onTap: () async {
                                                                                                      String Url = await '${MyConstant().domain}/files/$foder/slip/${_TransReBillModels_Bankmovemen[index1].slip}';
                                                                                                      showDialog(
                                                                                                        context: context,
                                                                                                        builder: (context) => AlertDialog(
                                                                                                            title: Center(
                                                                                                              child: Column(
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    _TransReBillModels_Bankmovemen[index1].docno == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Bankmovemen[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels_Bankmovemen[index1].refno}',
                                                                                                                    maxLines: 1,
                                                                                                                    textAlign: TextAlign.start,
                                                                                                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    '${_TransReBillModels_Bankmovemen[index1].slip}',
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            content: Stack(
                                                                                                              alignment: Alignment.center,
                                                                                                              children: <Widget>[Image.network('$Url')],
                                                                                                            ),
                                                                                                            actions: <Widget>[
                                                                                                              Column(
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
                                                                                                                  Row(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                    children: [
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                                        child: Container(
                                                                                                                          width: 100,
                                                                                                                          decoration: const BoxDecoration(
                                                                                                                            color: Colors.black,
                                                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                                          ),
                                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                                          child: TextButton(
                                                                                                                            onPressed: () => Navigator.pop(context, 'OK'),
                                                                                                                            child: const Text(
                                                                                                                              'ปิด',
                                                                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ]),
                                                                                                      );
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      // width: 100,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.orange[300],
                                                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                      ),
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: const Center(
                                                                                                        child: Text(
                                                                                                          'เรียกดู',
                                                                                                          style: TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        show_more = index1;
                                                                                                      });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      // width: 100,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.green[300],
                                                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                      ),
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: const Center(
                                                                                                        child: Text(
                                                                                                          'ดูเพิ่มเติม',
                                                                                                          style: TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
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
                                                                                if (show_more == index1)
                                                                                  SizedBox(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Stack(
                                                                                          children: [
                                                                                            Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                              ),
                                                                                              padding: const EdgeInsets.all(4.0),
                                                                                              child: const Row(
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'ลำดับ',
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'วันที่',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'รายการ',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'Vat%',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'หน่วย',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'VAT',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'ราคาก่อน Vat',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      'ราคารวม Vat',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Positioned(
                                                                                                top: 0,
                                                                                                right: 2,
                                                                                                child: InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      show_more = null;
                                                                                                    });
                                                                                                  },
                                                                                                  child: const Icon(
                                                                                                    Icons.cancel,
                                                                                                    color: Colors.red,
                                                                                                  ),
                                                                                                ))
                                                                                          ],
                                                                                        ),
                                                                                        for (int index2 = 0; index2 < TransReBillModels_Bankmovemen[index1].length; index2++)
                                                                                          Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.green[100]!.withOpacity(0.5),
                                                                                              border: Border(
                                                                                                bottom: BorderSide(
                                                                                                  color: Colors.black12,
                                                                                                  width: 1,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                            // padding: const EdgeInsets.all(4.0),
                                                                                            child: Column(
                                                                                              children: [
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${index1 + 1}.${index2 + 1}',
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Bankmovemen[index1][index2].date}',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Bankmovemen[index1][index2].expname}',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Bankmovemen[index1][index2].nvat}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        '${TransReBillModels_Bankmovemen[index1][index2].vtype}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        (TransReBillModels_Bankmovemen[index1][index2].vat == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].vat!))}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        (TransReBillModels_Bankmovemen[index1][index2].amt == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].amt!))}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        (TransReBillModels_Bankmovemen[index1][index2].total == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].total!))}',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: const TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight:
                                                                                                          //     FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  height: 10,
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    )),
                                                                  ],
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          actions: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 20, 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  StreamBuilder(
                                                      stream: Stream.periodic(
                                                          const Duration(
                                                              seconds: 0)),
                                                      builder:
                                                          (context, snapshot) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 20, 4),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SizedBox(
                                                                height: 120,
                                                                width: (Responsive
                                                                        .isDesktop(
                                                                            context))
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.9
                                                                    : (_TransReBillModels.length ==
                                                                            0)
                                                                        ? MediaQuery.of(context)
                                                                            .size
                                                                            .width
                                                                        : 800,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[600],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(0),
                                                                            bottomRight: Radius.circular(0)),
                                                                      ),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวม',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวมส่วนลด',
                                                                                //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                                //  '${_TransReBillModels[index1].ramtd}',
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวมราคารวม',
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวมหักส่วนลด',
                                                                                textAlign: TextAlign.right,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
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
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(0),
                                                                            topRight: Radius.circular(0),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                '',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels_Bankmovemen.length == 0)
                                                                                    ? '0.00'
                                                                                    : '${nFormat.format(double.parse((_TransReBillModels_Bankmovemen.fold(
                                                                                          0.0,
                                                                                          (previousValue, element) => previousValue + (element.total_bill != null ? double.parse(element.total_bill!) : 0),
                                                                                        ) - _TransReBillModels_Bankmovemen.fold(
                                                                                          0.0,
                                                                                          (previousValue, element) => previousValue + (element.total_dis != null ? double.parse(element.total_dis!) : double.parse(element.total_bill!)),
                                                                                        )).toString()))}',
                                                                                // '${nFormat.format(double.parse('$Sum_dis_'))}',

                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels_Bankmovemen.length == 0)
                                                                                    ? '0.00'
                                                                                    : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen.fold(
                                                                                        0.0,
                                                                                        (previousValue, element) => previousValue + (element.total_bill != null ? double.parse(element.total_bill!) : 0),
                                                                                      ).toString()))}',

                                                                                // '${nFormat.format(double.parse('$Sum_Total_'))}',
                                                                                // '$Sum_Total_',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels_Income.length == 0)
                                                                                    ? '0.00'
                                                                                    : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen.fold(
                                                                                        0.0,
                                                                                        (previousValue, element) => previousValue + (element.total_dis != null ? double.parse(element.total_dis!) : double.parse(element.total_bill!)),
                                                                                      ).toString()))}',
                                                                                // '${nFormat.format(double.parse('$Sum_total_dis'))}',
                                                                                // '$Sum_Total_',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                ' ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
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
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 1),
                                            const Divider(),
                                            const SizedBox(height: 1),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 8, 4),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (_TransReBillModels_Bankmovemen
                                                            .length !=
                                                        0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: const Center(
                                                              child: Text(
                                                                'Export file',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            setState(() {
                                                              Value_Report =
                                                                  'รายงานการเคลื่อนไหวธนาคาร';
                                                              Pre_and_Dow =
                                                                  'Download';
                                                            });
                                                            // Navigator.pop(context);
                                                            _showMyDialog_SAVE();
                                                          },
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
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
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Center(
                                                            child: Text(
                                                              'ปิด',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          setState(() {
                                                            Value_Chang_Zone_Income =
                                                                null;
                                                            Mon_Income = null;
                                                            YE_Income = null;
                                                          });

                                                          red_Trans_billIncome();
                                                          red_Trans_billMovemen();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_Chang_Zone_Income != null &&
                                            Mon_Income != null &&
                                            YE_Income != null &&
                                            _TransReBillModels_Bankmovemen
                                                    .length ==
                                                0)
                                        ? 'รายงานการเคลื่อนไหวธนาคาร (ไม่พบข้อมูล ✖️)'
                                        : (Value_Chang_Zone_Income != null &&
                                                Mon_Income != null &&
                                                YE_Income != null &&
                                                _TransReBillModels_Bankmovemen
                                                        .length !=
                                                    0)
                                            ? 'รายงานการเคลื่อนไหวธนาคาร ✔️'
                                            : 'รายงานการเคลื่อนไหวธนาคาร',
                                    style: TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

///////--------------------------------------------------------------------------------->(รายงานประจำวัน)
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
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'วันที่ :',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _select_Date_Daily(context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: AppbackgroundColor
                                                    .Sub_Abg_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              width: 120,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  (Value_selectDate_Daily ==
                                                          null)
                                                      ? 'เลือก'
                                                      : '$Value_selectDate_Daily',
                                                  style: const TextStyle(
                                                    color: ReportScreen_Color
                                                        .Colors_Text2_,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'โซน :',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
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
                                              fillColor: Colors.white
                                                  .withOpacity(0.05),
                                              filled: false,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 231, 227, 227),
                                                ),
                                              ),
                                            ),
                                            isExpanded: false,
                                            value: Value_Chang_Zone_Daily,
                                            // hint: Text(
                                            //   Value_Chang_Zone_Daily == null
                                            //       ? 'เลือก'
                                            //       : '$Value_Chang_Zone_Daily',
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
                                            buttonWidth: 250,
                                            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              // color: Colors
                                              //     .amber,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                            items: zoneModels_report
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: '${item.zn}',
                                                      child: Text(
                                                        '${item.zn}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),

                                            onChanged: (value) async {
                                              // Find the index of the selected item in the zoneModels_report list
                                              int selectedIndex =
                                                  zoneModels_report.indexWhere(
                                                      (item) =>
                                                          item.zn == value);

                                              setState(() {
                                                Value_Chang_Zone_Daily = value!;
                                                Value_Chang_Zone_Ser_Daily =
                                                    zoneModels_report[
                                                            selectedIndex]
                                                        .ser!;
                                              });
                                              print(
                                                  'Selected Index: $Value_Chang_Zone_Daily  //${Value_Chang_Zone_Ser_Daily}');
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            if (Value_selectDate_Daily !=
                                                    null &&
                                                Value_Chang_Zone_Daily !=
                                                    null) {
                                              red_Trans_bill();
                                            }
                                            Dia_log();
                                          },
                                          child: Container(
                                              width: 100,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.green[700],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10)),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'ค้นหา',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // if (Value_selectDate != null &&
                                //     _TransReBillModels.length != 0)
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[600],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'เรียกดู',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text1_,
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
                                  onTap:
                                      // (_TransReBillModels.isEmpty ||
                                      //         Value_selectDate_Daily == null)
                                      //     ? null
                                      //     : (TransReBillModels[
                                      //                 _TransReBillModels.length - 1]
                                      //             .isEmpty)
                                      //         ? null
                                      //         :
                                      () async {
                                    // List show_more = [];
                                    int? show_more;

                                    // double Sum_Ramt_ = 0.0;
                                    // double Sum_Ramtd_ = 0.0;
                                    // double Sum_Amt_ = 0.0;
                                    // double Sum_Total_ = 0.0;
                                    // double Sum_total_dis_ = 0.0;

                                    // for (int indexsum1 = 0;
                                    //     indexsum1 <
                                    //         _TransReBillModels.length;
                                    //     indexsum1++) {
                                    //   Sum_Ramt_ = Sum_Ramt_ +
                                    //       double.parse(
                                    //           _TransReBillModels[
                                    //                   indexsum1]
                                    //               .ramt!);

                                    //   Sum_Ramtd_ = Sum_Ramtd_ +
                                    //       double.parse(
                                    //           _TransReBillModels[
                                    //                   indexsum1]
                                    //               .ramtd!);

                                    //   Sum_Amt_ = Sum_Amt_ +
                                    //       double.parse(
                                    //           _TransReBillModels[
                                    //                   indexsum1]
                                    //               .amt!);
                                    //   Sum_Total_ = Sum_Total_ +
                                    //       double.parse(
                                    //           (_TransReBillModels[
                                    //                   indexsum1]
                                    //               .total_bill!));

                                    //   Sum_total_dis_ =
                                    //       (_TransReBillModels[indexsum1]
                                    //                   .total_dis ==
                                    //               null)
                                    //           ? Sum_total_dis_ +
                                    //               double.parse(
                                    //                   _TransReBillModels[
                                    //                           indexsum1]
                                    //                       .total_bill!)
                                    //           : Sum_total_dis_ +
                                    //               double.parse(
                                    //                   _TransReBillModels[
                                    //                           indexsum1]
                                    //                       .total_dis!);

                                    //   print(
                                    //       '${indexsum1 + 1} : ${_TransReBillModels[indexsum1].total_bill}');
                                    // }

                                    Insert_log.Insert_logs(
                                        'รายงาน', 'กดดูรายงานประจำวัน');

                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                (Value_Chang_Zone_Daily == null)
                                                    ? 'รายงานประจำวัน ** กรุณาเลือกโซน!!!'
                                                    : 'รายงานประจำวัน (โซน :${Value_Chang_Zone_Daily})',
                                                style: const TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              )),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        (Value_selectDate_Daily ==
                                                                null)
                                                            ? 'วันที่: ?'
                                                            : 'วันที่: $Value_selectDate_Daily',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          fontSize: 14,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'ทั้งหมด: ${_TransReBillModels.length}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 1),
                                              const Divider(),
                                              const SizedBox(height: 1),
                                            ],
                                          ),
                                          content: Center(
                                            child: StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 0)),
                                                builder: (context, snapshot) {
                                                  return ScrollConfiguration(
                                                    behavior:
                                                        ScrollConfiguration.of(
                                                                context)
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
                                                        children: [
                                                          Container(
                                                            // color: Colors.grey[50],
                                                            width: (Responsive
                                                                    .isDesktop(
                                                                        context))
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.9
                                                                : (_TransReBillModels
                                                                            .length ==
                                                                        0)
                                                                    ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width
                                                                    : 1200,
                                                            // height:
                                                            //     MediaQuery.of(context)
                                                            //             .size
                                                            //             .height *
                                                            //         0.3,
                                                            child: (_TransReBillModels
                                                                        .length ==
                                                                    0)
                                                                ? const Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          'ไม่พบข้อมูล ',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    children: <Widget>[
                                                                      // for (int index1 = 0;
                                                                      //     index1 <
                                                                      //         _TransReBillModels
                                                                      //             .length;
                                                                      //     index1++)
                                                                      Expanded(
                                                                          // height: MediaQuery.of(context).size.height * 0.45,
                                                                          child:
                                                                              ListView.builder(
                                                                        itemCount:
                                                                            _TransReBillModels.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index1) {
                                                                          return ListTile(
                                                                            title:
                                                                                SizedBox(
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: const BoxDecoration(
                                                                                            color: AppbackgroundColor.TiTile_Colors,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Text(
                                                                                            _TransReBillModels[index1].doctax == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].doctax}',
                                                                                            style: const TextStyle(
                                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  if (show_more != index1)
                                                                                    SizedBox(
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                            ),
                                                                                            // padding: const EdgeInsets.all(4.0),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                const SizedBox(
                                                                                                  width: 20,
                                                                                                ),

                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'โซน',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'รหัสพื้นที่',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                // Expanded(
                                                                                                //   flex: 1,
                                                                                                //   child: Text(
                                                                                                //     'วันที่',
                                                                                                //     textAlign: TextAlign.center,
                                                                                                //     style: TextStyle(
                                                                                                //       color: ReportScreen_Color.Colors_Text1_,
                                                                                                //       fontWeight: FontWeight.bold,
                                                                                                //       fontFamily: FontWeight_.Fonts_T,
                                                                                                //     ),
                                                                                                //   ),
                                                                                                // ),
                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'ผู้เช่า',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'ชื่อร้านค้า',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),

                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'ขนาดพื้นที่ (ตร.ม.)',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
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

                                                                                                // Expanded(
                                                                                                //   flex: 1,
                                                                                                //   child: Text(
                                                                                                //     'รวม70%',
                                                                                                //     textAlign: TextAlign.right,
                                                                                                //     style: TextStyle(
                                                                                                //       color: ReportScreen_Color.Colors_Text1_,
                                                                                                //       fontWeight: FontWeight.bold,
                                                                                                //       fontFamily: FontWeight_.Fonts_T,
                                                                                                //     ),
                                                                                                //   ),
                                                                                                // ),
                                                                                                //   Expanded(
                                                                                                //   flex: 1,
                                                                                                //   child: Text(
                                                                                                //     'รวม30%',
                                                                                                //     textAlign: TextAlign.right,
                                                                                                //     style: TextStyle(
                                                                                                //       color: ReportScreen_Color.Colors_Text1_,
                                                                                                //       fontWeight: FontWeight.bold,
                                                                                                //       fontFamily: FontWeight_.Fonts_T,
                                                                                                //     ),
                                                                                                //   ),
                                                                                                // ),
                                                                                                for (int index_exp = 0; index_exp < expModels.length; index_exp++)
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      '${expModels[index_exp].expname}',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: const TextStyle(
                                                                                                        color: ReportScreen_Color.Colors_Text1_,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: FontWeight_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),

                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'ราคารวม',
                                                                                                    textAlign: TextAlign.right,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    'หักส่วนลด',
                                                                                                    textAlign: TextAlign.right,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                const Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    '...',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.grey[200],
                                                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                            ),
                                                                                            // padding: const EdgeInsets.all(4.0),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                const SizedBox(
                                                                                                  width: 20,
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    (_TransReBillModels[index1].znn == null)
                                                                                                        ? '-'
                                                                                                        : ((_TransReBillModels[index1].znn.toString() == ''))
                                                                                                            ? '${_TransReBillModels[index1].zn}'
                                                                                                            : '${_TransReBillModels[index1].znn}',
                                                                                                    // '${TransReBillModels[index1].length}',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: const TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    (_TransReBillModels[index1].ln == null) ? '${_TransReBillModels[index1].room_number}' : '${_TransReBillModels[index1].ln}',
                                                                                                    // '${TransReBillModels[index1].length}',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: const TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    (_TransReBillModels[index1].cname == null) ? '${_TransReBillModels[index1].remark}' : '${_TransReBillModels[index1].cname}',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: const TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      //fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    (_TransReBillModels[index1].sname == null) ? '${_TransReBillModels[index1].remark}' : '${_TransReBillModels[index1].sname}',
                                                                                                    // '${TransReBillModels[index1].length}',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: const TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    (_TransReBillModels[index1].area == null) ? '1.00' : '${_TransReBillModels[index1].area}',
                                                                                                    // '${TransReBillModels[index1].length}',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: ReportScreen_Color.Colors_Text1_,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                for (int index_exp = 0; index_exp < expModels.length; index_exp++)
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text(
                                                                                                      '${nFormat.format(double.parse('${TransReBillModels[index1].fold(
                                                                                                            0.0,
                                                                                                            (previousValue, element) => previousValue + (element.expser.toString() == expModels[index_exp].ser.toString() && element.total.toString() != '' && element.total != null && element.docno! == _TransReBillModels[index1].docno! ? double.parse(element.total!) : 0),
                                                                                                          ).toString()}'))}',
                                                                                                      textAlign: TextAlign.right,
                                                                                                      style: TextStyle(
                                                                                                        color: (double.parse('${TransReBillModels[index1].fold(
                                                                                                                      0.0,
                                                                                                                      (previousValue, element) => previousValue + (element.expser.toString() == expModels[index_exp].ser.toString() && element.total.toString() != '' && element.total != null && element.docno! == _TransReBillModels[index1].docno! ? double.parse(element.total!) : 0),
                                                                                                                    ).toString()}') ==
                                                                                                                0.00)
                                                                                                            ? Colors.red
                                                                                                            : ReportScreen_Color.Colors_Text1_,
                                                                                                        // fontWeight: FontWeight.bold,
                                                                                                        fontFamily: Font_.Fonts_T,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}',
                                                                                                    // '${_TransReBillModels[index1].total_bill}',
                                                                                                    textAlign: TextAlign.right,
                                                                                                    style: TextStyle(
                                                                                                      color: (double.parse(_TransReBillModels[index1].total_bill!) == 0.00) ? Colors.red : ReportScreen_Color.Colors_Text1_,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Text(
                                                                                                    (_TransReBillModels[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels[index1].total_dis!))}',
                                                                                                    // '${_TransReBillModels[index1].total_bill}',
                                                                                                    textAlign: TextAlign.right,
                                                                                                    style: TextStyle(
                                                                                                      color: (((_TransReBillModels[index1].total_dis == null) ? double.parse(_TransReBillModels[index1].total_bill!) : double.parse(_TransReBillModels[index1].total_dis!)) == 0.00) ? Colors.red : ReportScreen_Color.Colors_Text1_,
                                                                                                      // fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          show_more = index1;
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        width: 100,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: Colors.green[300],
                                                                                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                        ),
                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                        child: const Center(
                                                                                                          child: Text(
                                                                                                            'ดูเพิ่มเติม',
                                                                                                            style: TextStyle(
                                                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                                                              // fontWeight: FontWeight.bold,
                                                                                                              fontFamily: Font_.Fonts_T,
                                                                                                            ),
                                                                                                          ),
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
                                                                                  if (show_more == index1)
                                                                                    SizedBox(
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Stack(
                                                                                            children: [
                                                                                              Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                                ),
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: const Row(
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        'ลำดับ',
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),

                                                                                                    // Expanded(
                                                                                                    //   flex: 1,
                                                                                                    //   child: Text(
                                                                                                    //     'กำหนดชำระ',
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
                                                                                                        'รายการ',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        'วันที่',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        'Vat%',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        'หน่วย',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        'VAT',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // Expanded(
                                                                                                    //   flex: 1,
                                                                                                    //   child: Text(
                                                                                                    //     '70 %',
                                                                                                    //     textAlign: TextAlign.right,
                                                                                                    //     style: TextStyle(
                                                                                                    //       color: ReportScreen_Color.Colors_Text1_,
                                                                                                    //       fontWeight: FontWeight.bold,
                                                                                                    //       fontFamily: FontWeight_.Fonts_T,
                                                                                                    //     ),
                                                                                                    //   ),
                                                                                                    // ),
                                                                                                    // Expanded(
                                                                                                    //   flex: 1,
                                                                                                    //   child: Text(
                                                                                                    //     '30 %',
                                                                                                    //     textAlign: TextAlign.right,
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
                                                                                                        'ราคาก่อน Vat',
                                                                                                        textAlign: TextAlign.right,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        'ราคารวม Vat',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          color: ReportScreen_Color.Colors_Text1_,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Positioned(
                                                                                                  top: 0,
                                                                                                  right: 2,
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        show_more = null;
                                                                                                      });
                                                                                                    },
                                                                                                    child: const Icon(
                                                                                                      Icons.cancel,
                                                                                                      color: Colors.red,
                                                                                                    ),
                                                                                                  ))
                                                                                            ],
                                                                                          ),
                                                                                          for (int index2 = 0; index2 < TransReBillModels[index1].length; index2++)
                                                                                            Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.green[100]!.withOpacity(0.5),
                                                                                                border: Border(
                                                                                                  bottom: BorderSide(
                                                                                                    color: Colors.black12,
                                                                                                    width: 1,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                              // padding: const EdgeInsets.all(4.0),
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Row(
                                                                                                    children: [
                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${index1 + 1}.${index2 + 1}',
                                                                                                          style: const TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text2_,
                                                                                                            // fontWeight:
                                                                                                            //     FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      // Expanded(
                                                                                                      //   flex: 1,
                                                                                                      //   child: Text(
                                                                                                      //     '${TransReBillModels[index1][index2].date}',
                                                                                                      //     style: const TextStyle(
                                                                                                      //       color: ReportScreen_Color.Colors_Text2_,
                                                                                                      //       // fontWeight:
                                                                                                      //       //     FontWeight.bold,
                                                                                                      //       fontFamily: Font_.Fonts_T,
                                                                                                      //     ),
                                                                                                      //   ),
                                                                                                      // ),
                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].expname}',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: const TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text2_,
                                                                                                            // fontWeight:
                                                                                                            //     FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].date}',
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: const TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text2_,
                                                                                                            // fontWeight:
                                                                                                            //     FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),

                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].nvat}',
                                                                                                          // '${TransReBillModels[index1][index2].total_sumnvat}',
                                                                                                          textAlign: TextAlign.right,
                                                                                                          style: TextStyle(
                                                                                                            color: (double.parse(TransReBillModels[index1][index2].nvat!) == 0.00) ? Colors.red : ReportScreen_Color.Colors_Text2_,
                                                                                                            // fontWeight:
                                                                                                            //     FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].vtype}',
                                                                                                          textAlign: TextAlign.right,
                                                                                                          style: const TextStyle(
                                                                                                            color: ReportScreen_Color.Colors_Text2_,
                                                                                                            // fontWeight:
                                                                                                            //     FontWeight.bold,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].vat}',
                                                                                                          // '${nFormat.format(double.parse(TransReBillModels[index1][index2].total_sumvat!))}',
                                                                                                          textAlign: TextAlign.right,
                                                                                                          style: TextStyle(
                                                                                                            color: (double.parse(TransReBillModels[index1][index2].vat!) == 0.00 || double.parse(TransReBillModels[index1][index2].vat!) == 0.0000) ? Colors.red : ReportScreen_Color.Colors_Text2_,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),

                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].amt}',
                                                                                                          //  '${nFormat.format(double.parse(TransReBillModels[index1][index2].total_sumamt!))}',
                                                                                                          textAlign: TextAlign.right,
                                                                                                          style: TextStyle(
                                                                                                            color: (double.parse(TransReBillModels[index1][index2].amt!) == 0.00 || double.parse(TransReBillModels[index1][index2].amt!) == 0.0000) ? Colors.red : ReportScreen_Color.Colors_Text2_,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        flex: 1,
                                                                                                        child: Text(
                                                                                                          '${TransReBillModels[index1][index2].total}',
                                                                                                          // '${nFormat.format(double.parse(TransReBillModels[index1][index2].total_sum!))}',
                                                                                                          textAlign: TextAlign.right,
                                                                                                          style: TextStyle(
                                                                                                            color: (double.parse(TransReBillModels[index1][index2].total!) == 0.00) ? Colors.red : ReportScreen_Color.Colors_Text2_,
                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      // Expanded(
                                                                                                      //   flex: 1,
                                                                                                      //   child: Text(
                                                                                                      //     (TransReBillModels[index1][index2].sname == null) ? '' : '**${TransReBillModels[index1][index2].sname!}',
                                                                                                      //     style: const TextStyle(
                                                                                                      //       color: ReportScreen_Color.Colors_Text2_,
                                                                                                      //       // fontWeight:
                                                                                                      //       //     FontWeight.bold,
                                                                                                      //       fontFamily: Font_.Fonts_T,
                                                                                                      //     ),
                                                                                                      //   ),
                                                                                                      // ),
                                                                                                    ],
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    height: 10,
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      )),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          actions: <Widget>[
                                            StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 0)),
                                                builder: (context, snapshot) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 20, 4),
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
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 120,
                                                              width: (Responsive
                                                                      .isDesktop(
                                                                          context))
                                                                  ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9
                                                                  : (_TransReBillModels
                                                                              .length ==
                                                                          0)
                                                                      ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width
                                                                      : 800,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              0),
                                                                          bottomRight:
                                                                              Radius.circular(0)),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวม',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          for (int index_exp = 0;
                                                                              index_exp < expModels.length;
                                                                              index_exp++)
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รวม${expModels[index_exp].expname}',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวม',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมส่วนลด',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              ' ',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
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
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              0),
                                                                          topRight: Radius.circular(
                                                                              0),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          for (int index_exp = 0;
                                                                              index_exp < expModels.length;
                                                                              index_exp++)
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                (_TransReBillModels.length == 0) ? '0.00' : '${nFormat.format(calculateTotalValue_Daily_Cm(index_exp)!)}',
                                                                                textAlign: TextAlign.right,
                                                                                style: const TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              (_TransReBillModels.length == 0)
                                                                                  ? '0.00'
                                                                                  : '${nFormat.format(double.parse('${_TransReBillModels.fold(
                                                                                      0.0,
                                                                                      (previousValue, element) => previousValue + (element.total_bill != null && element.total_bill.toString() != '' ? double.parse(element.total_bill!) : 0),
                                                                                    ).toString()}'))}',
                                                                              // '${nFormat.format(double.parse('${Sum_Total_}'))}',
                                                                              // '$Sum_Total_',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              //  (_TransReBillModels[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels[index1].total_dis!))}',
                                                                              (_TransReBillModels.length == 0)
                                                                                  ? '0.00'
                                                                                  : '${nFormat.format(double.parse('${_TransReBillModels.fold(
                                                                                      0.0,
                                                                                      (previousValue, element) => previousValue + (element.total_dis == null ? double.parse(element.total_bill!) : double.parse(element.total_dis!)),
                                                                                    ).toString()}'))}',

                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              ' ',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 8, 4),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (_TransReBillModels
                                                            .length !=
                                                        0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: const Center(
                                                              child: Text(
                                                                'Export file',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            if (_TransReBillModels
                                                                    .length ==
                                                                0) {
                                                            } else {
                                                              setState(() {
                                                                show_more =
                                                                    null;
                                                                Value_Report =
                                                                    'รายงานประจำวัน';
                                                                Pre_and_Dow =
                                                                    'Download';
                                                              });
                                                              // Navigator.of(
                                                              //         context)
                                                              //     .pop();
                                                              _showMyDialog_SAVE();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
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
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Center(
                                                            child: Text(
                                                              'ปิด',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          setState(() {
                                                            show_more = null;
                                                            Value_selectDate_Daily =
                                                                null;

                                                            Value_selectDate_Daily =
                                                                null;
                                                            Value_Chang_Zone_Daily =
                                                                null;
                                                          });

                                                          red_Trans_bill();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_selectDate_Daily != null &&
                                            Value_Chang_Zone_Daily != null &&
                                            _TransReBillModels.length == 0)
                                        ? 'รายงาน ประจำวัน (ไม่พบข้อมูล ✖️)'
                                        : (Value_selectDate_Daily != null &&
                                                Value_Chang_Zone_Daily !=
                                                    null &&
                                                _TransReBillModels.length != 0)
                                            ? 'รายงาน ประจำวัน (ไม่พบข้อมูล ✔️)'
                                            : 'รายงาน ประจำวัน',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

//////////////////////////////////----------------------------------------->(รายงานแยกตามโซน)

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
                                    value: Value_Chang_Zone_,
                                    // hint: Text(
                                    //   Value_Chang_Zone_ == null
                                    //       ? 'เลือก'
                                    //       : '$Value_Chang_Zone_',
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
                                    buttonWidth: 250,
                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      // color: Colors
                                      //     .amber,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    items: zoneModels_report
                                        .map((item) => DropdownMenuItem<String>(
                                              value: '${item.zn}',
                                              child: Text(
                                                '${item.zn}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ))
                                        .toList(),

                                    onChanged: (value) async {
                                      // Find the index of the selected item in the zoneModels_report list
                                      int selectedIndex =
                                          zoneModels_report.indexWhere(
                                              (item) => item.zn == value);

                                      setState(() {
                                        Value_Chang_Zone_ = value!;
                                        Value_Chang_Zone_Ser_ =
                                            zoneModels_report[selectedIndex]
                                                .ser!;
                                      });
                                      print(
                                          'Selected Index: $Value_Chang_Zone_  //${Value_Chang_Zone_Ser_}');

                                      // print('Selected Value: $value');
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (Value_Chang_Zone_Ser_ != null) {
                                      read_GC_tenant();
                                    }
                                    Dia_log();
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
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[600],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'เรียกดู',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text1_,
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
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Column(
                                            children: [
                                              const Center(
                                                  child: Text(
                                                'รายงาน รายชื่อผู้เช่าแยกตามโซน',
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              )),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      (Value_Chang_Zone_ ==
                                                              null)
                                                          ? 'โซน: ?'
                                                          : 'โซน: $Value_Chang_Zone_',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                        color:
                                                            ReportScreen_Color
                                                                .Colors_Text1_,
                                                        fontSize: 14,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'ทั้งหมด: ${teNantModels.length}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              ReportScreen_Color
                                                                  .Colors_Text1_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 1),
                                              const Divider(),
                                              const SizedBox(height: 1),
                                            ],
                                          ),
                                          content: Center(
                                            child: StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 0)),
                                                builder: (context, snapshot) {
                                                  return ScrollConfiguration(
                                                    behavior:
                                                        ScrollConfiguration.of(
                                                                context)
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
                                                        children: [
                                                          Container(
                                                            // color: Colors.grey[50],
                                                            width: (Responsive
                                                                    .isDesktop(
                                                                        context))
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.9
                                                                : 800,

                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppbackgroundColor
                                                                              .TiTile_Colors
                                                                          .withOpacity(
                                                                              0.7),
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              0),
                                                                          topRight: Radius.circular(
                                                                              0),
                                                                          bottomLeft: Radius.circular(
                                                                              0),
                                                                          bottomRight:
                                                                              Radius.circular(0)),
                                                                    ),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child:
                                                                        const Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'ลำดับ',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // Expanded(
                                                                        //   flex: 2,
                                                                        //   child: Text(
                                                                        //     'เลขที่สัญญา/เสนอราคา',
                                                                        //     textAlign:
                                                                        //         TextAlign
                                                                        //             .start,
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
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Text(
                                                                            'ชื่อ-สกุล',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'ประเภท',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'เลขแผง',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'พื้นที่',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'ค่าเช่า',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'โม่',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'ถัง',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'เช่าที่',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'ไฟ',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            'รวม',
                                                                            textAlign:
                                                                                TextAlign.right,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: FontWeight_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child: (teNantModels.length ==
                                                                            0)
                                                                        ? const Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Center(
                                                                                child: Text(
                                                                                  'ไม่พบข้อมูล',
                                                                                  style: TextStyle(
                                                                                    color: ReportScreen_Color.Colors_Text1_,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: FontWeight_.Fonts_T,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : ListView
                                                                            .builder(
                                                                            itemCount:
                                                                                teNantModels.length,
                                                                            itemBuilder:
                                                                                (BuildContext context, int index) {
                                                                              return ListTile(
                                                                                title: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                    border: Border(
                                                                                      bottom: BorderSide(
                                                                                        color: Colors.black12,
                                                                                        width: 1,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        width: 20,
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          '${index + 1}',
                                                                                          textAlign: TextAlign.start,
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                      // Expanded(
                                                                                      //   flex: 2,
                                                                                      //   child: Text(
                                                                                      //     teNantModels[index].docno ==
                                                                                      //             null
                                                                                      //         ? teNantModels[index].cid == null
                                                                                      //             ? ''
                                                                                      //             : '${teNantModels[index].cid}'
                                                                                      //         : '${teNantModels[index].docno}',
                                                                                      //     textAlign:
                                                                                      //         TextAlign
                                                                                      //             .start,
                                                                                      //     style:
                                                                                      //         const TextStyle(
                                                                                      //       color: ReportScreen_Color
                                                                                      //           .Colors_Text1_,
                                                                                      //       // fontWeight: FontWeight.bold,
                                                                                      //       fontFamily:
                                                                                      //           Font_.Fonts_T,
                                                                                      //     ),
                                                                                      //   ),
                                                                                      // ),
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          teNantModels[index].cname == null
                                                                                              ? teNantModels[index].cname_q == null
                                                                                                  ? ''
                                                                                                  : '${teNantModels[index].cname_q}'
                                                                                              : '${teNantModels[index].cname}',
                                                                                          textAlign: TextAlign.start,
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          '${teNantModels[index].stype}',

                                                                                          //'คูณ ${zoneModels_report[index1].b_1}',

                                                                                          textAlign: TextAlign.start,
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          teNantModels[index].ln_c == null
                                                                                              ? teNantModels[index].ln_q == null
                                                                                                  ? ''
                                                                                                  : '${teNantModels[index].ln_q}'
                                                                                              : '${teNantModels[index].ln_c}',
                                                                                          textAlign: TextAlign.start,
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          teNantModels[index].area_c == null
                                                                                              ? teNantModels[index].area_q == null
                                                                                                  ? '0.00'
                                                                                                  : '${teNantModels[index].area_q}'
                                                                                              : '${teNantModels[index].area_c}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          (teNantModels[index].amt_expser1 == null) ? '0.0' : '${nFormat.format(double.parse('${teNantModels[index].amt_expser1}'))}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            color: (teNantModels[index].amt_expser1 == null) ? Colors.red[300] : ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          (teNantModels[index].amt_expser9 == null) ? '0.00' : '${nFormat.format(double.parse('${teNantModels[index].amt_expser9}'))}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            color: (teNantModels[index].amt_expser9 == null) ? Colors.red[300] : ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          (teNantModels[index].amt_expser10 == null) ? '0.00' : '${nFormat.format(double.parse('${teNantModels[index].amt_expser10}'))}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            color: (teNantModels[index].amt_expser10 == null) ? Colors.red[300] : ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          (teNantModels[index].amt_expser11 == null) ? '0.00' : '${nFormat.format(double.parse('${teNantModels[index].amt_expser11}'))}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            color: (teNantModels[index].amt_expser11 == null) ? Colors.red[300] : ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          (teNantModels[index].amt_expser12 == null) ? '0.00' : '${nFormat.format(double.parse('${teNantModels[index].amt_expser12}'))}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            color: (teNantModels[index].amt_expser12 == null) ? Colors.red[300] : ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          '${nFormat.format(double.parse((teNantModels[index].amt_expser1 == null) ? '0' : '${teNantModels[index].amt_expser1}') + double.parse((teNantModels[index].amt_expser9 == null) ? '0' : '${teNantModels[index].amt_expser9}') + double.parse((teNantModels[index].amt_expser10 == null) ? '0' : '${teNantModels[index].amt_expser10}') + double.parse((teNantModels[index].amt_expser11 == null) ? '0' : '${teNantModels[index].amt_expser11}') + double.parse((teNantModels[index].amt_expser12 == null) ? '0' : '${teNantModels[index].amt_expser12}'))}',
                                                                                          // '${double.parse((teNantModels[index].amt_expser1 == null) ? '0' : '${teNantModels[index].amt_expser1}') + double.parse((teNantModels[index].amt_expser9 == null) ? '0' : '${teNantModels[index].amt_expser9}') + double.parse((teNantModels[index].amt_expser10 == null) ? '0' : '${teNantModels[index].amt_expser10}') + double.parse((teNantModels[index].amt_expser11 == null) ? '0' : '${teNantModels[index].amt_expser11}') + double.parse((teNantModels[index].amt_expser12 == null) ? '0' : '${teNantModels[index].amt_expser12}')}',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            color: (nFormat.format(double.parse((teNantModels[index].amt_expser1 == null) ? '0' : '${teNantModels[index].amt_expser1}') + double.parse((teNantModels[index].amt_expser9 == null) ? '0' : '${teNantModels[index].amt_expser9}') + double.parse((teNantModels[index].amt_expser10 == null) ? '0' : '${teNantModels[index].amt_expser10}') + double.parse((teNantModels[index].amt_expser11 == null) ? '0' : '${teNantModels[index].amt_expser11}') + double.parse((teNantModels[index].amt_expser12 == null) ? '0' : '${teNantModels[index].amt_expser12}')).toString() == '0.00') ? Colors.red[300] : ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          )),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          actions: <Widget>[
                                            StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 0)),
                                                builder: (context, snapshot) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 20, 4),
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
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 120,
                                                              width: (Responsive
                                                                      .isDesktop(
                                                                          context))
                                                                  ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9
                                                                  : (_TransReBillModels
                                                                              .length ==
                                                                          0)
                                                                      ? MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width
                                                                      : 800,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomLeft: Radius.circular(
                                                                              0),
                                                                          bottomRight:
                                                                              Radius.circular(0)),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวม',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมพื้นที่',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมค่าเช่า',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมโม่',
                                                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                              //  '${_TransReBillModels[index1].ramtd}',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมถัง',
                                                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                              //  '${_TransReBillModels[index1].ramtd}',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมเช่าพื้นที่',
                                                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                              //  '${_TransReBillModels[index1].ramtd}',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวมค่าไฟ',
                                                                              //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                              //  '${_TransReBillModels[index1].ramtd}',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              'รวม',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
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
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                      borderRadius: const BorderRadius
                                                                              .only(
                                                                          topLeft: Radius.circular(
                                                                              0),
                                                                          topRight: Radius.circular(
                                                                              0),
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              // '${nFormat.format(double.parse('${teNantModels.length}'))}',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                    0.0, // Initial value for the sum (0.0 for double)
                                                                                    (previousValue, element) => previousValue + (element.area_c == null ? (element.area_q == null ? 0.0 : double.parse(element.area_q!)) : double.parse(element.area_c!)),
                                                                                  ).toString()}'))}',
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight:
                                                                                //     FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                    0.0,
                                                                                    (previousValue, element) => previousValue + (element.amt_expser1 != null && element.amt_expser1.toString() != '' ? double.parse(element.amt_expser1!) : 0),
                                                                                  ).toString()}'))}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                    0.0,
                                                                                    (previousValue, element) => previousValue + (element.amt_expser9 != null && element.amt_expser9.toString() != '' ? double.parse(element.amt_expser9!) : 0),
                                                                                  ).toString()}'))}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                    0.0,
                                                                                    (previousValue, element) => previousValue + (element.amt_expser10 != null && element.amt_expser10.toString() != '' ? double.parse(element.amt_expser10!) : 0),
                                                                                  ).toString()}'))}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                    0.0,
                                                                                    (previousValue, element) => previousValue + (element.amt_expser11 != null && element.amt_expser11.toString() != '' ? double.parse(element.amt_expser11!) : 0),
                                                                                  ).toString()}'))}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                //fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                    0.0,
                                                                                    (previousValue, element) => previousValue + (element.amt_expser12 != null && element.amt_expser12.toString() != '' ? double.parse(element.amt_expser12!) : 0),
                                                                                  ).toString()}'))}',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Text(
                                                                              '${nFormat.format(double.parse('${teNantModels.fold(
                                                                                0.0, // Initial value for the sum (0.0 for double)
                                                                                (previousValue, element) => previousValue + ((element.amt_expser1 != null && element.amt_expser1.toString() != '') ? double.parse(element.amt_expser1!) : 0) + ((element.amt_expser9 != null && element.amt_expser9.toString() != '') ? double.parse(element.amt_expser9!) : 0) + ((element.amt_expser10 != null && element.amt_expser10.toString() != '') ? double.parse(element.amt_expser10!) : 0) + ((element.amt_expser11 != null && element.amt_expser11.toString() != '') ? double.parse(element.amt_expser11!) : 0) + ((element.amt_expser12 != null && element.amt_expser12.toString() != '') ? double.parse(element.amt_expser12!) : 0),
                                                                              )}'))}',
                                                                              // '${teNantModels.fold(
                                                                              //   0.0, // Initial value for the sum (0.0 for double)
                                                                              //   (previousValue, element) =>
                                                                              //       previousValue +
                                                                              //       ((element.amt_expser1 != null && element.amt_expser1.toString() != '') ? double.parse(element.amt_expser1!) : 0) +
                                                                              //       ((element.amt_expser9 != null && element.amt_expser9.toString() != '') ? double.parse(element.amt_expser9!) : 0) +
                                                                              //       ((element.amt_expser10 != null && element.amt_expser10.toString() != '') ? double.parse(element.amt_expser10!) : 0) +
                                                                              //       ((element.amt_expser11 != null && element.amt_expser11.toString() != '') ? double.parse(element.amt_expser11!) : 0) +
                                                                              //       ((element.amt_expser12 != null && element.amt_expser12.toString() != '') ? double.parse(element.amt_expser12!) : 0),
                                                                              // )}',
                                                                              // '$Sum_Total_',
                                                                              textAlign: TextAlign.right,
                                                                              style: const TextStyle(
                                                                                color: ReportScreen_Color.Colors_Text1_,
                                                                                // fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          // const Expanded(
                                                                          //   flex: 1,
                                                                          //   child:
                                                                          //       Text(
                                                                          //     ' ',
                                                                          //     textAlign:
                                                                          //         TextAlign.center,
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 8, 4),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (teNantModels.length !=
                                                        0)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          child: Container(
                                                            width: 100,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: const Center(
                                                              child: Text(
                                                                'Export file',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            if (teNantModels
                                                                    .length ==
                                                                0) {
                                                            } else {
                                                              setState(() {
                                                                Value_Report =
                                                                    'รายงานรายชื่อผู้เช่าแยกตามโซน';
                                                                Pre_and_Dow =
                                                                    'Download';
                                                              });
                                                              _showMyDialog_SAVE();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.black,
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
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Center(
                                                            child: Text(
                                                              'ปิด',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          setState(() {
                                                            Value_Chang_Zone_Ser_ =
                                                                null;
                                                            Value_Chang_Zone_ =
                                                                null;
                                                          });
                                                          read_GC_tenant();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_Chang_Zone_ != null &&
                                            teNantModels.length == 0)
                                        ? 'รายงาน รายชื่อผู้เช่าแยกตามโซน (ไม่พบข้อมูล ✖️)'
                                        : (Value_Chang_Zone_ != null &&
                                                teNantModels.length != 0)
                                            ? 'รายงาน รายชื่อผู้เช่าแยกตามโซน (ไม่พบข้อมูล ✔️)'
                                            : 'รายงาน รายชื่อผู้เช่าแยกตามโซน',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                )
                                // const Padding(
                                //   padding: EdgeInsets.all(8.0),
                                //   child: Text(
                                //     'รายงาน รายชื่อผู้เช่าแยกตามโซน',
                                //     style: TextStyle(
                                //       color: ReportScreen_Color.Colors_Text2_,
                                //       // fontWeight: FontWeight.bold,
                                //       fontFamily: Font_.Fonts_T,
                                //     ),
                                //   ),
                                // ),
                              ])),
                          const SizedBox(
                            height: 20.0,
                          ),
//////////////////////////////////----------------------------------------->(รายงานผู้เช่า)
                          // const SizedBox(
                          //   height: 5.0,
                          // ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: MediaQuery.of(context).size.width / 2,
                          //       height: 4.0,
                          //       child: Divider(
                          //         color: Colors.grey[300],
                          //         height: 4.0,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 5.0,
                          // ),
                          // Row(
                          //   children: [
                          //     const Padding(
                          //       padding: EdgeInsets.all(8.0),
                          //       child: Text(
                          //         'เดือน :',
                          //         style: TextStyle(
                          //           color: ReportScreen_Color.Colors_Text2_,
                          //           // fontWeight: FontWeight.bold,
                          //           fontFamily: Font_.Fonts_T,
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Container(
                          //         decoration: const BoxDecoration(
                          //           color: AppbackgroundColor.Sub_Abg_Colors,
                          //           borderRadius: BorderRadius.only(
                          //               topLeft: Radius.circular(10),
                          //               topRight: Radius.circular(10),
                          //               bottomLeft: Radius.circular(10),
                          //               bottomRight: Radius.circular(10)),
                          //           // border: Border.all(color: Colors.grey, width: 1),
                          //         ),
                          //         width: 120,
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: DropdownButtonFormField2(
                          //           alignment: Alignment.center,
                          //           focusColor: Colors.white,
                          //           autofocus: false,
                          //           decoration: InputDecoration(
                          //             enabled: true,
                          //             hoverColor: Colors.brown,
                          //             prefixIconColor: Colors.blue,
                          //             fillColor: Colors.white.withOpacity(0.05),
                          //             filled: false,
                          //             isDense: true,
                          //             contentPadding: EdgeInsets.zero,
                          //             border: OutlineInputBorder(
                          //               borderSide:
                          //                   const BorderSide(color: Colors.red),
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             focusedBorder: const OutlineInputBorder(
                          //               borderRadius: BorderRadius.only(
                          //                 topRight: Radius.circular(10),
                          //                 topLeft: Radius.circular(10),
                          //                 bottomRight: Radius.circular(10),
                          //                 bottomLeft: Radius.circular(10),
                          //               ),
                          //               borderSide: BorderSide(
                          //                 width: 1,
                          //                 color: Color.fromARGB(255, 231, 227, 227),
                          //               ),
                          //             ),
                          //           ),
                          //           isExpanded: false,
                          //           hint: Text(
                          //             Mon_ == null ? 'เลือก' : '$Mon_',
                          //             maxLines: 2,
                          //             textAlign: TextAlign.center,
                          //             style: const TextStyle(
                          //               overflow: TextOverflow.ellipsis,
                          //               fontSize: 14,
                          //               color: Colors.grey,
                          //             ),
                          //           ),
                          //           icon: const Icon(
                          //             Icons.arrow_drop_down,
                          //             color: Colors.black,
                          //           ),
                          //           style: const TextStyle(
                          //             color: Colors.grey,
                          //           ),
                          //           iconSize: 20,
                          //           buttonHeight: 40,
                          //           buttonWidth: 200,
                          //           // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                          //           dropdownDecoration: BoxDecoration(
                          //             // color: Colors
                          //             //     .amber,
                          //             borderRadius: BorderRadius.circular(10),
                          //             border:
                          //                 Border.all(color: Colors.white, width: 1),
                          //           ),
                          //           items: Mont_Th.map(
                          //               (item) => DropdownMenuItem<String>(
                          //                     value: '${item}',
                          //                     child: Text(
                          //                       '${item}',
                          //                       textAlign: TextAlign.center,
                          //                       style: const TextStyle(
                          //                         overflow: TextOverflow.ellipsis,
                          //                         fontSize: 14,
                          //                         color: Colors.grey,
                          //                       ),
                          //                     ),
                          //                   )).toList(),

                          //           onChanged: (value) async {
                          //             setState(() {
                          //               Mon_ = value;
                          //             });
                          //             if (YE_ == null) {
                          //             } else {
                          //               GC_coutumer();
                          //             }
                          //             // read_GC_rentalAll();
                          //           },
                          //         ),
                          //       ),
                          //     ),
                          //     const Padding(
                          //       padding: EdgeInsets.all(8.0),
                          //       child: Text(
                          //         'ปี :',
                          //         style: TextStyle(
                          //           color: ReportScreen_Color.Colors_Text2_,
                          //           // fontWeight: FontWeight.bold,
                          //           fontFamily: Font_.Fonts_T,
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Container(
                          //         decoration: const BoxDecoration(
                          //           color: AppbackgroundColor.Sub_Abg_Colors,
                          //           borderRadius: BorderRadius.only(
                          //               topLeft: Radius.circular(10),
                          //               topRight: Radius.circular(10),
                          //               bottomLeft: Radius.circular(10),
                          //               bottomRight: Radius.circular(10)),
                          //           // border: Border.all(color: Colors.grey, width: 1),
                          //         ),
                          //         width: 120,
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: DropdownButtonFormField2(
                          //           alignment: Alignment.center,
                          //           focusColor: Colors.white,
                          //           autofocus: false,
                          //           decoration: InputDecoration(
                          //             floatingLabelAlignment:
                          //                 FloatingLabelAlignment.center,
                          //             enabled: true,
                          //             hoverColor: Colors.brown,
                          //             prefixIconColor: Colors.blue,
                          //             fillColor: Colors.white.withOpacity(0.05),
                          //             filled: false,
                          //             isDense: true,
                          //             contentPadding: EdgeInsets.zero,
                          //             border: OutlineInputBorder(
                          //               borderSide:
                          //                   const BorderSide(color: Colors.red),
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             focusedBorder: const OutlineInputBorder(
                          //               borderRadius: BorderRadius.only(
                          //                 topRight: Radius.circular(10),
                          //                 topLeft: Radius.circular(10),
                          //                 bottomRight: Radius.circular(10),
                          //                 bottomLeft: Radius.circular(10),
                          //               ),
                          //               borderSide: BorderSide(
                          //                 width: 1,
                          //                 color: Color.fromARGB(255, 231, 227, 227),
                          //               ),
                          //             ),
                          //           ),
                          //           isExpanded: false,
                          //           hint: Text(
                          //             YE_ == null ? 'เลือก' : '$YE_',
                          //             maxLines: 2,
                          //             textAlign: TextAlign.center,
                          //             style: const TextStyle(
                          //               overflow: TextOverflow.ellipsis,
                          //               fontSize: 14,
                          //               color: Colors.grey,
                          //             ),
                          //           ),
                          //           icon: const Icon(
                          //             Icons.arrow_drop_down,
                          //             color: Colors.black,
                          //           ),
                          //           style: const TextStyle(
                          //             color: Colors.grey,
                          //           ),
                          //           iconSize: 20,
                          //           buttonHeight: 40,
                          //           buttonWidth: 200,
                          //           // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                          //           dropdownDecoration: BoxDecoration(
                          //             // color: Colors
                          //             //     .amber,
                          //             borderRadius: BorderRadius.circular(10),
                          //             border:
                          //                 Border.all(color: Colors.white, width: 1),
                          //           ),
                          //           items:
                          //               YE_Th.map((item) => DropdownMenuItem<String>(
                          //                     value: '${item}',
                          //                     child: Text(
                          //                       '${item}',
                          //                       textAlign: TextAlign.center,
                          //                       style: const TextStyle(
                          //                         overflow: TextOverflow.ellipsis,
                          //                         fontSize: 14,
                          //                         color: Colors.grey,
                          //                       ),
                          //                     ),
                          //                   )).toList(),

                          //           onChanged: (value) async {
                          //             setState(() {
                          //               YE_ = value;
                          //             });
                          //             if (Mon_ == null) {
                          //             } else {
                          //               GC_coutumer();
                          //             }

                          //             // read_GC_rentalAll();
                          //           },
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     children: [
                          //       // if (Value_selectDate != null &&
                          //       //     _TransReBillModels.length != 0)
                          //       InkWell(
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             color: Colors.yellow[600],
                          //             borderRadius: const BorderRadius.only(
                          //                 topLeft: Radius.circular(10),
                          //                 topRight: Radius.circular(10),
                          //                 bottomLeft: Radius.circular(10),
                          //                 bottomRight: Radius.circular(10)),
                          //             border:
                          //                 Border.all(color: Colors.grey, width: 1),
                          //           ),
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: const Center(
                          //             child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text(
                          //                   'เรียกดู',
                          //                   style: TextStyle(
                          //                     color: ReportScreen_Color.Colors_Text1_,
                          //                     fontWeight: FontWeight.bold,
                          //                     fontFamily: FontWeight_.Fonts_T,
                          //                   ),
                          //                 ),
                          //                 Icon(
                          //                   Icons.navigate_next,
                          //                   color: Colors.grey,
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         onTap: (YE_ == null ||
                          //                 Mon_ == null ||
                          //                 teNantModels.isEmpty ||
                          //                 coutumer_total_sum_CM[
                          //                         teNantModels.length - 1]
                          //                     .isEmpty)
                          //             ? null
                          //             : () async {
                          //                 Insert_log.Insert_logs(
                          //                     'รายงาน', 'กดดูรายงานผู้เช่า');
                          //                 int? show_more;
                          //                 showDialog<void>(
                          //                   context: context,
                          //                   barrierDismissible:
                          //                       false, // user must tap button!
                          //                   builder: (BuildContext context) {
                          //                     return AlertDialog(
                          //                       shape: const RoundedRectangleBorder(
                          //                           borderRadius: BorderRadius.all(
                          //                               Radius.circular(20.0))),
                          //                       title: Column(
                          //                         children: [
                          //                           const Center(
                          //                               child: Text(
                          //                             'รายงานผู้เช่า',
                          //                             style: TextStyle(
                          //                               color: ReportScreen_Color
                          //                                   .Colors_Text1_,
                          //                               fontWeight: FontWeight.bold,
                          //                               fontFamily:
                          //                                   FontWeight_.Fonts_T,
                          //                             ),
                          //                           )),
                          //                           Row(
                          //                             children: [
                          //                               Expanded(
                          //                                   flex: 1,
                          //                                   child: Text(
                          //                                     (YE_ == null ||
                          //                                             Mon_ == null)
                          //                                         ? 'เดือน : ? ( ปี : ? )'
                          //                                         : 'เดือน : $Mon_ ( ปี : $YE_ )',
                          //                                     textAlign:
                          //                                         TextAlign.start,
                          //                                     style: const TextStyle(
                          //                                       color:
                          //                                           ReportScreen_Color
                          //                                               .Colors_Text1_,
                          //                                       fontSize: 14,
                          //                                       // fontWeight: FontWeight.bold,
                          //                                       fontFamily:
                          //                                           FontWeight_
                          //                                               .Fonts_T,
                          //                                     ),
                          //                                   )),
                          //                               Expanded(
                          //                                   flex: 1,
                          //                                   child: Text(
                          //                                     'ทั้งหมด: ${teNantModels.length}',
                          //                                     textAlign:
                          //                                         TextAlign.end,
                          //                                     style: const TextStyle(
                          //                                       fontSize: 14,
                          //                                       color:
                          //                                           ReportScreen_Color
                          //                                               .Colors_Text1_,
                          //                                       // fontWeight: FontWeight.bold,
                          //                                       fontFamily:
                          //                                           FontWeight_
                          //                                               .Fonts_T,
                          //                                     ),
                          //                                   )),
                          //                             ],
                          //                           ),
                          //                           const SizedBox(height: 1),
                          //                           const Divider(),
                          //                           const SizedBox(height: 1),
                          //                         ],
                          //                       ),
                          //                       content: StreamBuilder(
                          //                           stream: Stream.periodic(
                          //                               const Duration(seconds: 0)),
                          //                           builder: (context, snapshot) {
                          //                             return ScrollConfiguration(
                          //                               behavior: ScrollConfiguration
                          //                                       .of(context)
                          //                                   .copyWith(dragDevices: {
                          //                                 PointerDeviceKind.touch,
                          //                                 PointerDeviceKind.mouse,
                          //                               }),
                          //                               child: SingleChildScrollView(
                          //                                 scrollDirection:
                          //                                     Axis.horizontal,
                          //                                 child: Row(
                          //                                   children: [
                          //                                     Container(
                          //                                       // color: Colors.grey[50],
                          //                                       width: (Responsive
                          //                                               .isDesktop(
                          //                                                   context))
                          //                                           ? MediaQuery.of(
                          //                                                       context)
                          //                                                   .size
                          //                                                   .width *
                          //                                               0.9
                          //                                           : (teNantModels
                          //                                                       .length ==
                          //                                                   0)
                          //                                               ? MediaQuery.of(
                          //                                                       context)
                          //                                                   .size
                          //                                                   .width
                          //                                               : 800,
                          //                                       // height:
                          //                                       //     MediaQuery.of(context)
                          //                                       //             .size
                          //                                       //             .height *
                          //                                       //         0.3,
                          //                                       child: Column(
                          //                                         children: <Widget>[
                          //                                           // for (int index1 = 0;
                          //                                           //     index1 <
                          //                                           //         _TransReBillModels
                          //                                           //             .length;
                          //                                           //     index1++)
                          //                                           Container(
                          //                                               height: MediaQuery.of(
                          //                                                           context)
                          //                                                       .size
                          //                                                       .height *
                          //                                                   0.58,
                          //                                               child: ListView
                          //                                                   .builder(
                          //                                                 itemCount:
                          //                                                     teNantModels
                          //                                                         .length,
                          //                                                 itemBuilder:
                          //                                                     (BuildContext
                          //                                                             context,
                          //                                                         int index) {
                          //                                                   return ListTile(
                          //                                                     title:
                          //                                                         SizedBox(
                          //                                                       child:
                          //                                                           Column(
                          //                                                         children: [
                          //                                                           Container(
                          //                                                             child: Row(
                          //                                                               mainAxisAlignment: MainAxisAlignment.start,
                          //                                                               children: [
                          //                                                                 Container(
                          //                                                                   decoration: const BoxDecoration(
                          //                                                                     color: AppbackgroundColor.TiTile_Colors,
                          //                                                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                          //                                                                   ),
                          //                                                                   padding: const EdgeInsets.all(4.0),
                          //                                                                   child: Text(
                          //                                                                     teNantModels[index].cname == null
                          //                                                                         ? teNantModels[index].cname_q == null
                          //                                                                             ? ''
                          //                                                                             : '${index + 1}.${teNantModels[index].cname_q}'
                          //                                                                         : '${index + 1}.${teNantModels[index].cname}',
                          //                                                                     style: const TextStyle(
                          //                                                                       color: ReportScreen_Color.Colors_Text1_,
                          //                                                                       fontWeight: FontWeight.bold,
                          //                                                                       fontFamily: FontWeight_.Fonts_T,
                          //                                                                     ),
                          //                                                                   ),
                          //                                                                 ),
                          //                                                               ],
                          //                                                             ),
                          //                                                           ),
                          //                                                           if (show_more != index)
                          //                                                             SizedBox(
                          //                                                               child: Column(
                          //                                                                 children: [
                          //                                                                   Container(
                          //                                                                     decoration: BoxDecoration(
                          //                                                                       color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                          //                                                                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                          //                                                                     ),
                          //                                                                     // padding: const EdgeInsets.all(4.0),
                          //                                                                     child: const Row(
                          //                                                                       children: [
                          //                                                                         SizedBox(
                          //                                                                           width: 5,
                          //                                                                         ),
                          //                                                                         // Expanded(
                          //                                                                         //   flex: 1,
                          //                                                                         //   child: Text(
                          //                                                                         //     'ลำดับ',
                          //                                                                         //     //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                         //     //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                         //     textAlign: TextAlign.center,
                          //                                                                         //     style: const TextStyle(
                          //                                                                         //       color: ReportScreen_Color.Colors_Text1_,
                          //                                                                         //       fontWeight: FontWeight.bold,
                          //                                                                         //       fontFamily: FontWeight_.Fonts_T,
                          //                                                                         //     ),
                          //                                                                         //   ),
                          //                                                                         // ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'เลขสัญญา',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'โซน',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),

                          //                                                                         Expanded(
                          //                                                                           child: Text(
                          //                                                                             'รหัสพื้นที่',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'ขนาดพื้นที่(ต.ร.ม.)',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'ค่าเช่ารายวัน',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'โม่',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'ถัง',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'เช่าพื้นที่',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'ค่าไฟ',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),

                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             'รวม',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             '...',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: FontWeight_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                       ],
                          //                                                                     ),
                          //                                                                   ),
                          //                                                                   Container(
                          //                                                                     decoration: BoxDecoration(
                          //                                                                       color: Colors.grey[200],
                          //                                                                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                          //                                                                     ),
                          //                                                                     padding: const EdgeInsets.all(8.0),
                          //                                                                     child: Row(
                          //                                                                       children: [
                          //                                                                         const SizedBox(
                          //                                                                           width: 5,
                          //                                                                         ),
                          //                                                                         // Expanded(
                          //                                                                         //   flex: 1,
                          //                                                                         //   child: Text(
                          //                                                                         //     '${index + 1}',
                          //                                                                         //     //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                         //     //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                         //     textAlign: TextAlign.center,
                          //                                                                         //     style: const TextStyle(
                          //                                                                         //       color: ReportScreen_Color.Colors_Text1_,
                          //                                                                         //       // fontWeight: FontWeight.bold,
                          //                                                                         //       fontFamily: Font_.Fonts_T,
                          //                                                                         //     ),
                          //                                                                         //   ),
                          //                                                                         // ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             '${teNantModels[index].cid}',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             '${teNantModels[index].zn}',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             teNantModels[index].ln_c == null
                          //                                                                                 ? teNantModels[index].ln_q == null
                          //                                                                                     ? ''
                          //                                                                                     : '${teNantModels[index].ln_q}'
                          //                                                                                 : '${teNantModels[index].ln_c}',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.center,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             teNantModels[index].area_c == null
                          //                                                                                 ? teNantModels[index].area_q == null
                          //                                                                                     ? ''
                          //                                                                                     : '${teNantModels[index].area_q}'
                          //                                                                                 : '${teNantModels[index].area_c}',
                          //                                                                             //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                          //                                                                             //  '${_TransReBillModels[index1].ramtd}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             '${teNantModels[index].rent}',
                          //                                                                             // '${_TransReBillModels[index1].total_bill}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         //                                                                                             late List<List<dynamic>> coutumer_rent_CM;
                          //                                                                         // late List<List<dynamic>> coutumer_tank_CM;
                          //                                                                         // late List<List<dynamic>> coutumer_electricity_CM;
                          //                                                                         // late List<List<dynamic>> coutumer_MOMO_CM;
                          //                                                                         // late List<List<dynamic>> coutumer_rent_area_CM;
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             (coutumer_MOMO_CM[index].isEmpty) ? '0.00' : '${nFormat.format(double.parse(coutumer_MOMO_CM[index][0]!))}',
                          //                                                                             // '${ coutumer_MOMO_CM[index]}',
                          //                                                                             // '0.00',
                          //                                                                             // '${_TransReBillModels[index1].total_bill}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             (coutumer_tank_CM[index].isEmpty) ? '0.00' : '${nFormat.format(double.parse(coutumer_tank_CM[index][0]!))}',
                          //                                                                             // '${_TransReBillModels[index1].total_bill}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             (coutumer_rent_area_CM[index].isEmpty) ? '0.00' : '${nFormat.format(double.parse(coutumer_rent_area_CM[index][0]!))}',
                          //                                                                             // '${_TransReBillModels[index1].total_bill}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             (coutumer_electricity_CM[index].isEmpty) ? '0.00' : '${nFormat.format(double.parse(coutumer_electricity_CM[index][0]!))}',
                          //                                                                             // '${_TransReBillModels[index1].total_bill}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),

                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Text(
                          //                                                                             (coutumer_total_sum_CM[index].isEmpty) ? '${nFormat.format(double.parse(teNantModels[index].rent!) + 0.00)}' : '${nFormat.format(double.parse(teNantModels[index].rent!) + double.parse(coutumer_total_sum_CM[index][0]!))}',
                          //                                                                             // '${_TransReBillModels[index1].total_bill}',
                          //                                                                             textAlign: TextAlign.right,
                          //                                                                             style: const TextStyle(
                          //                                                                               color: ReportScreen_Color.Colors_Text1_,
                          //                                                                               // fontWeight: FontWeight.bold,
                          //                                                                               fontFamily: Font_.Fonts_T,
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                         Expanded(
                          //                                                                           flex: 1,
                          //                                                                           child: Padding(
                          //                                                                             padding: const EdgeInsets.all(8.0),
                          //                                                                             child: Row(
                          //                                                                               mainAxisAlignment: MainAxisAlignment.center,
                          //                                                                               children: [
                          //                                                                                 InkWell(
                          //                                                                                   onTap: () {
                          //                                                                                     setState(() {
                          //                                                                                       show_more = index;
                          //                                                                                     });
                          //                                                                                   },
                          //                                                                                   child: Container(
                          //                                                                                     width: 100,
                          //                                                                                     decoration: BoxDecoration(
                          //                                                                                       color: Colors.green[300],
                          //                                                                                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          //                                                                                     ),
                          //                                                                                     padding: const EdgeInsets.all(4.0),
                          //                                                                                     child: const Center(
                          //                                                                                       child: Text(
                          //                                                                                         'ดูเพิ่มเติม',
                          //                                                                                         style: TextStyle(
                          //                                                                                           color: ReportScreen_Color.Colors_Text1_,
                          //                                                                                           // fontWeight: FontWeight.bold,
                          //                                                                                           fontFamily: Font_.Fonts_T,
                          //                                                                                         ),
                          //                                                                                       ),
                          //                                                                                     ),
                          //                                                                                   ),
                          //                                                                                 ),
                          //                                                                               ],
                          //                                                                             ),
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                       ],
                          //                                                                     ),
                          //                                                                   ),
                          //                                                                 ],
                          //                                                               ),
                          //                                                             ),
                          //                                                           if (show_more == index)
                          //                                                             SizedBox(
                          //                                                               child: Column(
                          //                                                                 children: [
                          //                                                                   Stack(
                          //                                                                     children: [
                          //                                                                       Container(
                          //                                                                         decoration: BoxDecoration(
                          //                                                                           color: AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                          //                                                                           borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                          //                                                                         ),
                          //                                                                         padding: const EdgeInsets.all(4.0),
                          //                                                                         child: Row(
                          //                                                                           children: [
                          //                                                                             for (int indax2 = 0; indax2 < 31; indax2++)
                          //                                                                               Expanded(
                          //                                                                                 flex: 1,
                          //                                                                                 child: Text(
                          //                                                                                   '${indax2 + 1}',
                          //                                                                                   textAlign: TextAlign.center,
                          //                                                                                   style: const TextStyle(
                          //                                                                                     color: ReportScreen_Color.Colors_Text1_,
                          //                                                                                     fontWeight: FontWeight.bold,
                          //                                                                                     fontFamily: FontWeight_.Fonts_T,
                          //                                                                                   ),
                          //                                                                                 ),
                          //                                                                               ),
                          //                                                                           ],
                          //                                                                         ),
                          //                                                                       ),
                          //                                                                       Positioned(
                          //                                                                           top: 0,
                          //                                                                           right: 2,
                          //                                                                           child: InkWell(
                          //                                                                             onTap: () {
                          //                                                                               setState(() {
                          //                                                                                 show_more = null;
                          //                                                                               });
                          //                                                                             },
                          //                                                                             child: const Icon(
                          //                                                                               Icons.cancel,
                          //                                                                               color: Colors.red,
                          //                                                                             ),
                          //                                                                           ))
                          //                                                                     ],
                          //                                                                   ),
                          //                                                                   (custo_TransReBillHistoryModels[index].length == 0)
                          //                                                                       ? Container(
                          //                                                                           decoration: BoxDecoration(
                          //                                                                             color: Colors.grey[200],
                          //                                                                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                          //                                                                           ),
                          //                                                                           padding: const EdgeInsets.all(3.0),
                          //                                                                           child: Row(
                          //                                                                             children: [
                          //                                                                               for (int indax2 = 1; indax2 < 32; indax2++)

                          //                                                                                 // for (int indax3 = 0; indax3 < custo_TransReBillHistoryModels[index].length; indax2++)
                          //                                                                                 Expanded(
                          //                                                                                   flex: 1,
                          //                                                                                   child: Container(
                          //                                                                                     decoration: BoxDecoration(
                          //                                                                                       color: (indax2 % 2 == 0) ? Colors.grey[200] : AppbackgroundColor.Sub_Abg_Colors,

                          //                                                                                       borderRadius: const BorderRadius.only(
                          //                                                                                         topLeft: Radius.circular(0),
                          //                                                                                         topRight: Radius.circular(0),
                          //                                                                                         bottomLeft: Radius.circular(0),
                          //                                                                                         bottomRight: Radius.circular(0),
                          //                                                                                       ),
                          //                                                                                       // border: Border.all(color: Colors.grey, width: 1),
                          //                                                                                     ),
                          //                                                                                     padding: const EdgeInsets.all(8.0),
                          //                                                                                     child: const Text(
                          //                                                                                       '❌',
                          //                                                                                       textAlign: TextAlign.center,
                          //                                                                                       style: TextStyle(
                          //                                                                                         color: Colors.red,
                          //                                                                                         fontFamily: Font_.Fonts_T,
                          //                                                                                       ),
                          //                                                                                     ),
                          //                                                                                   ),
                          //                                                                                 ),
                          //                                                                             ],
                          //                                                                           ),
                          //                                                                         )
                          //                                                                       : Container(
                          //                                                                           decoration: BoxDecoration(
                          //                                                                             color: Colors.grey[200],
                          //                                                                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                          //                                                                           ),
                          //                                                                           padding: const EdgeInsets.all(3.0),
                          //                                                                           child: Row(
                          //                                                                             children: [
                          //                                                                               for (int indax2 = 1; indax2 < 32; indax2++)
                          //                                                                                 Expanded(
                          //                                                                                   flex: 1,
                          //                                                                                   child: Container(
                          //                                                                                     decoration: BoxDecoration(
                          //                                                                                       color: (indax2 % 2 == 0) ? Colors.grey[200] : AppbackgroundColor.Sub_Abg_Colors,
                          //                                                                                       borderRadius: const BorderRadius.only(
                          //                                                                                         topLeft: Radius.circular(0),
                          //                                                                                         topRight: Radius.circular(0),
                          //                                                                                         bottomLeft: Radius.circular(0),
                          //                                                                                         bottomRight: Radius.circular(0),
                          //                                                                                       ),
                          //                                                                                       // border: Border.all(color: Colors.grey, width: 1),
                          //                                                                                     ),
                          //                                                                                     padding: const EdgeInsets.all(8.0),
                          //                                                                                     child: Text(
                          //                                                                                       (custo_TransReBillHistoryModels[index].isEmpty || custo_TransReBillHistoryModels[index].length == 0 || custo_TransReBillHistoryModels[index] == null)
                          //                                                                                           ? '❌'
                          //                                                                                           : (custo_TransReBillHistoryModels[index].any((item) => int.parse('${DateTime.parse(item.dateacc!).day}') == indax2))
                          //                                                                                               ? '✔️'
                          //                                                                                               : '❌',
                          //                                                                                       textAlign: TextAlign.center,
                          //                                                                                       style: TextStyle(
                          //                                                                                         color: (custo_TransReBillHistoryModels[index].isEmpty || custo_TransReBillHistoryModels[index].length == 0 || !custo_TransReBillHistoryModels[index].any((item) => int.parse('${DateTime.parse(item.dateacc!).day}') == indax2)) ? Colors.red : Colors.green,
                          //                                                                                         fontFamily: Font_.Fonts_T,
                          //                                                                                       ),
                          //                                                                                     ),
                          //                                                                                   ),
                          //                                                                                 ),
                          //                                                                             ],
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                 ],
                          //                                                               ),
                          //                                                             )
                          //                                                         ],
                          //                                                       ),
                          //                                                     ),
                          //                                                   );
                          //                                                 },
                          //                                               )),
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               ),
                          //                             );
                          //                           }),
                          //                       actions: <Widget>[
                          //                         const SizedBox(height: 1),
                          //                         const Divider(),
                          //                         const SizedBox(height: 1),
                          //                         Padding(
                          //                           padding:
                          //                               const EdgeInsets.fromLTRB(
                          //                                   8, 4, 8, 4),
                          //                           child: SingleChildScrollView(
                          //                             scrollDirection:
                          //                                 Axis.horizontal,
                          //                             child: Row(
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment.end,
                          //                               children: [
                          //                                 if (teNantModels.length !=
                          //                                     0)
                          //                                   Padding(
                          //                                     padding:
                          //                                         const EdgeInsets
                          //                                             .all(8.0),
                          //                                     child: InkWell(
                          //                                       child: Container(
                          //                                         width: 100,
                          //                                         decoration:
                          //                                             const BoxDecoration(
                          //                                           color:
                          //                                               Colors.blue,
                          //                                           borderRadius: BorderRadius.only(
                          //                                               topLeft: Radius
                          //                                                   .circular(
                          //                                                       10),
                          //                                               topRight: Radius
                          //                                                   .circular(
                          //                                                       10),
                          //                                               bottomLeft: Radius
                          //                                                   .circular(
                          //                                                       10),
                          //                                               bottomRight: Radius
                          //                                                   .circular(
                          //                                                       10)),
                          //                                         ),
                          //                                         padding:
                          //                                             const EdgeInsets
                          //                                                 .all(8.0),
                          //                                         child: const Center(
                          //                                           child: Text(
                          //                                             'Export file',
                          //                                             style:
                          //                                                 TextStyle(
                          //                                               color: Colors
                          //                                                   .white,
                          //                                               fontWeight:
                          //                                                   FontWeight
                          //                                                       .bold,
                          //                                               fontFamily: Font_
                          //                                                   .Fonts_T,
                          //                                             ),
                          //                                           ),
                          //                                         ),
                          //                                       ),
                          //                                       onTap: () {
                          //                                         if (teNantModels
                          //                                                 .length ==
                          //                                             0) {
                          //                                         } else {
                          //                                           setState(() {
                          //                                             show_more =
                          //                                                 null;
                          //                                             Value_Report =
                          //                                                 'รายงานผู้เช่า';
                          //                                             Pre_and_Dow =
                          //                                                 'Download';
                          //                                           });
                          //                                           // Navigator.of(
                          //                                           //         context)
                          //                                           //     .pop();
                          //                                           _showMyDialog_SAVE();
                          //                                         }
                          //                                       },
                          //                                     ),
                          //                                   ),
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets.all(
                          //                                           8.0),
                          //                                   child: InkWell(
                          //                                     child: Container(
                          //                                       width: 100,
                          //                                       decoration:
                          //                                           const BoxDecoration(
                          //                                         color: Colors.black,
                          //                                         borderRadius: BorderRadius.only(
                          //                                             topLeft: Radius
                          //                                                 .circular(
                          //                                                     10),
                          //                                             topRight: Radius
                          //                                                 .circular(
                          //                                                     10),
                          //                                             bottomLeft: Radius
                          //                                                 .circular(
                          //                                                     10),
                          //                                             bottomRight: Radius
                          //                                                 .circular(
                          //                                                     10)),
                          //                                       ),
                          //                                       padding:
                          //                                           const EdgeInsets
                          //                                               .all(8.0),
                          //                                       child: const Center(
                          //                                         child: Text(
                          //                                           'ปิด',
                          //                                           style: TextStyle(
                          //                                             color: Colors
                          //                                                 .white,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .bold,
                          //                                             fontFamily: Font_
                          //                                                 .Fonts_T,
                          //                                           ),
                          //                                         ),
                          //                                       ),
                          //                                     ),
                          //                                     onTap: () {
                          //                                       Navigator.of(context)
                          //                                           .pop();
                          //                                     },
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     );
                          //                   },
                          //                 );
                          //               },
                          //       ),
                          //       // const Padding(
                          //       //   padding: EdgeInsets.all(8.0),
                          //       //   child: Text(
                          //       //     'รายชื่อผู้เช่าประจำปี',
                          //       //     style: TextStyle(
                          //       //       color: ReportScreen_Color.Colors_Text2_,
                          //       //       // fontWeight: FontWeight.bold,
                          //       //       fontFamily: Font_.Fonts_T,
                          //       //     ),
                          //       //   ),
                          //       // ),
                          //       (YE_ == null || Mon_ == null || teNantModels.isEmpty)
                          //           ? Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Text(
                          //                 (YE_ != null &&
                          //                         teNantModels.isEmpty &&
                          //                         Mon_ != null)
                          //                     ? 'รายงานผู้เช่า (ไม่พบข้อมูล ✖️)'
                          //                     : 'รายงานผู้เช่า',
                          //                 style: const TextStyle(
                          //                   color: ReportScreen_Color.Colors_Text2_,
                          //                   // fontWeight: FontWeight.bold,
                          //                   fontFamily: Font_.Fonts_T,
                          //                 ),
                          //               ),
                          //             )
                          //           : (coutumer_total_sum_CM[teNantModels.length - 1]
                          //                   .isEmpty)
                          //               ? SizedBox(
                          //                   // height: 20,
                          //                   child: Row(
                          //                   children: [
                          //                     Container(
                          //                         padding: const EdgeInsets.all(4.0),
                          //                         child:
                          //                             const CircularProgressIndicator()),
                          //                     const Padding(
                          //                       padding: EdgeInsets.all(8.0),
                          //                       child: Text(
                          //                         'กำลังโหลดรายงานผู้เช่า...',
                          //                         style: TextStyle(
                          //                           color: ReportScreen_Color
                          //                               .Colors_Text2_,
                          //                           // fontWeight: FontWeight.bold,
                          //                           fontFamily: Font_.Fonts_T,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ))
                          //               : const Padding(
                          //                   padding: EdgeInsets.all(8.0),
                          //                   child: Text(
                          //                     'รายงานผู้เช่า ✔️',
                          //                     style: TextStyle(
                          //                       color:
                          //                           ReportScreen_Color.Colors_Text2_,
                          //                       // fontWeight: FontWeight.bold,
                          //                       fontFamily: Font_.Fonts_T,
                          //                     ),
                          //                   ),
                          //                 ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget BodyHome_Web() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 270,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.TiTile_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.map,
                            // Icons.next_plan,
                            color: ReportScreen_Color.Colors_Text1_,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 2, 8),
                            child: Text(
                              'พื้นที่ให้เช่า',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                            child: AutoSizeText(
                              '( พื้นที่เช่าทั้งหมด ${areaModels.length})',
                              minFontSize: 8,
                              maxFontSize: 15,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'ใกล้หมดสัญญา',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      '( ภายใน 3 เดือน )',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                  areaModels1.isEmpty
                                      ? SizedBox(
                                          // height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(
                                                        milliseconds: 50),
                                                    (i) => i),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData)
                                                    return const Text('');
                                                  double elapsed = double.parse(
                                                          (snapshot.data ==
                                                                  null)
                                                              ? '0.00'
                                                              : snapshot.data
                                                                  .toString()) *
                                                      0.05;
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: (elapsed > 2.00)
                                                        ? const Text(
                                                            'ไม่พบข้อมูล',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12.0),
                                                          )
                                                        : Column(
                                                            children: [
                                                              Container(
                                                                  // height: 20,
                                                                  child:
                                                                      const CircularProgressIndicator()),
                                                              // Text(
                                                              //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                              //   style: const TextStyle(
                                                              //       color: PeopleChaoScreen_Color
                                                              //           .Colors_Text2_,
                                                              //       fontFamily:
                                                              //           Font_
                                                              //               .Fonts_T,
                                                              //       fontSize:
                                                              //           12.0),
                                                              // ),
                                                            ],
                                                          ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  '${areaModels1.length}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Text(
                                                  'พื้นที่',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ]),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'ว่าง',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      '( ให้เช่า )',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                  areaModels2.isEmpty
                                      ? SizedBox(
                                          // height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              StreamBuilder(
                                                stream: Stream.periodic(
                                                    const Duration(
                                                        milliseconds: 50),
                                                    (i) => i),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData)
                                                    return const Text('');
                                                  double elapsed = double.parse(
                                                          (snapshot.data ==
                                                                  null)
                                                              ? '0.00'
                                                              : snapshot.data
                                                                  .toString()) *
                                                      0.05;
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: (elapsed > 2.00)
                                                        ? const Text(
                                                            'ไม่พบข้อมูล',
                                                            style: TextStyle(
                                                                color: PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                fontSize: 12.0),
                                                          )
                                                        : Column(
                                                            children: [
                                                              Container(
                                                                  // height: 20,
                                                                  child:
                                                                      const CircularProgressIndicator()),
                                                              // Text(
                                                              //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                              //   style: const TextStyle(
                                                              //       color: PeopleChaoScreen_Color
                                                              //           .Colors_Text2_,
                                                              //       fontFamily:
                                                              //           Font_
                                                              //               .Fonts_T,
                                                              //       fontSize:
                                                              //           12.0),
                                                              // ),
                                                            ],
                                                          ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  '${areaModels2.length}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Text(
                                                  'พื้นที่',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 270,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.TiTile_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(
                          height: 35,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
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
                                padding: const EdgeInsets.all(4.0),
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
                                  padding: const EdgeInsets.all(4.0),
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
                                    hint: Text(
                                      overview_Ser_Zone_ == '0'
                                          ? 'ทั้งหมด'
                                          : '',
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
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: 'ทั้งหมด',
                                        child: Text(
                                          'ทั้งหมด',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      for (int index = 0;
                                          index < zoneModels_report.length;
                                          index++)
                                        DropdownMenuItem<String>(
                                          value:
                                              '${zoneModels_report[index].zn}',
                                          child: Text(
                                            '${zoneModels_report[index].zn}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                    ],

                                    onChanged: (value) async {
                                      int selectedIndex = (value! == 'ทั้งหมด')
                                          ? 0
                                          : zoneModels_report.indexWhere(
                                              (item) => item.zn == value);

                                      setState(() {
                                        // Value_Chang_Zone_Income = value!;
                                        overview_Ser_Zone_ = (value! ==
                                                'ทั้งหมด')
                                            ? '0'
                                            : '${zoneModels_report[selectedIndex].ser}';
                                      });
                                      print(
                                          'Selected Index: $value  //${overview_Ser_Zone_}');
                                      red_Sum_billIncome();
                                      // if (Value_Chang_Zone_Income != null) {
                                      //   red_Trans_billIncome();
                                      //   red_Trans_billMovemen();
                                      // }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            // Icons.next_plan,
                            color: ReportScreen_Color.Colors_Text1_,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'ภาพรวมการเงิน',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
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
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: InkWell(
                                  onTap: () {
                                    _select_financial_StartDate(context);
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
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      width: 120,
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          (SDatex_total1_ == null)
                                              ? 'เลือก'
                                              : '$SDatex_total1_',
                                          style: const TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              const Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Text(
                                  'ถึง',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: InkWell(
                                  onTap: () {
                                    _select_financial_LtartDate(context);
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
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      width: 120,
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          (LDatex_total1_ == null)
                                              ? 'เลือก'
                                              : '$LDatex_total1_',
                                          style: const TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          'รวมรายรับ',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          '( ชำระแล้ว หักส่วนลด)',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        // height: 50,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        (total1_ == null)
                                                            ? '0.00'
                                                            : '${nFormat.format(total1_)}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Text(
                                                        'บาท',
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ]))),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      'รวมรายรับ',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      '( ชำระแล้ว ไม่หักส่วนลด)',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    // height: 50,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    (total2_ == null)
                                                        ? '0.00'
                                                        : '${nFormat.format(total2_)}',
                                                    // '${nFormat.format(double.parse(total1_.toString()))}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'บาท',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget BodyHome_mobile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 550,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.TiTile_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  const Icon(
                    Icons.map,
                    // Icons.next_plan,
                    color: ReportScreen_Color.Colors_Text1_,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 2, 8),
                    child: Text(
                      'พื้นที่ให้เช่า',
                      style: TextStyle(
                        color: ReportScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                    child: AutoSizeText(
                      '( พื้นที่เช่าทั้งหมด ${areaModels.length})',
                      minFontSize: 8,
                      maxFontSize: 15,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'ใกล้หมดสัญญา',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '( ภายใน 3 เดือน )',
                              style: TextStyle(
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                          areaModels1.isEmpty
                              ? SizedBox(
                                  // height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(milliseconds: 50),
                                            (i) => i),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return const Text('');
                                          double elapsed = double.parse(
                                                  (snapshot.data == null)
                                                      ? '0.00'
                                                      : snapshot.data
                                                          .toString()) *
                                              0.05;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (elapsed > 2.00)
                                                ? const Text(
                                                    'ไม่พบข้อมูล',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                        fontSize: 12.0),
                                                  )
                                                : Column(
                                                    children: [
                                                      Container(
                                                          // height: 20,
                                                          child:
                                                              const CircularProgressIndicator()),
                                                      // Text(
                                                      //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                      //   style: const TextStyle(
                                                      //       color: PeopleChaoScreen_Color
                                                      //           .Colors_Text2_,
                                                      //       fontFamily:
                                                      //           Font_.Fonts_T,
                                                      //       fontSize: 12.0),
                                                      // ),
                                                    ],
                                                  ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          '${areaModels1.length}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          'พื้นที่',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'ว่าง',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '( ให้เช่า )',
                              style: TextStyle(
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                          areaModels2.isEmpty
                              ? SizedBox(
                                  // height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(milliseconds: 50),
                                            (i) => i),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return const Text('');
                                          double elapsed = double.parse(
                                                  (snapshot.data == null)
                                                      ? '0.00'
                                                      : snapshot.data
                                                          .toString()) *
                                              0.05;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (elapsed > 2.00)
                                                ? const Text(
                                                    'ไม่พบข้อมูล',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                        fontSize: 12.0),
                                                  )
                                                : Column(
                                                    children: [
                                                      Container(
                                                          // height: 20,
                                                          child:
                                                              const CircularProgressIndicator()),
                                                      // Text(
                                                      //   'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                      //   style: const TextStyle(
                                                      //       color: PeopleChaoScreen_Color
                                                      //           .Colors_Text2_,
                                                      //       fontFamily:
                                                      //           Font_.Fonts_T,
                                                      //       fontSize: 12.0),
                                                      // ),
                                                    ],
                                                  ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          '${areaModels2.length}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          'พื้นที่',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Icon(
                    Icons.monetization_on_rounded,
                    // Icons.next_plan,
                    color: ReportScreen_Color.Colors_Text1_,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'ภาพรวมการเงิน',
                      style: TextStyle(
                        color: ReportScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
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
                        padding: const EdgeInsets.all(4.0),
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
                          width: 240,
                          padding: const EdgeInsets.all(4.0),
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
                              overview_Ser_Zone_ == '0' ? 'ทั้งหมด' : '',
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
                            items: [
                              DropdownMenuItem<String>(
                                value: 'ทั้งหมด',
                                child: Text(
                                  'ทั้งหมด',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              for (int index = 0;
                                  index < zoneModels_report.length;
                                  index++)
                                DropdownMenuItem<String>(
                                  value: '${zoneModels_report[index].zn}',
                                  child: Text(
                                    '${zoneModels_report[index].zn}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                            ],

                            onChanged: (value) async {
                              int selectedIndex = (value! == 'ทั้งหมด')
                                  ? 0
                                  : zoneModels_report
                                      .indexWhere((item) => item.zn == value);

                              setState(() {
                                // Value_Chang_Zone_Income = value!;
                                overview_Ser_Zone_ = (value! == 'ทั้งหมด')
                                    ? '0'
                                    : '${zoneModels_report[selectedIndex].ser}';
                              });
                              print(
                                  'Selected Index: $value  //${overview_Ser_Zone_}');
                              red_Sum_billIncome();
                              // if (Value_Chang_Zone_Income != null) {
                              //   red_Trans_billIncome();
                              //   red_Trans_billMovemen();
                              // }
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
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
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: InkWell(
                              onTap: () {
                                _select_financial_StartDate(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  width: 120,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      (SDatex_total1_ == null)
                                          ? 'เลือก'
                                          : '$SDatex_total1_',
                                      style: const TextStyle(
                                        color: ReportScreen_Color.Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Text(
                              'ถึง',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: InkWell(
                              onTap: () {
                                _select_financial_LtartDate(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  width: 120,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      (LDatex_total1_ == null)
                                          ? 'เลือก'
                                          : '$LDatex_total1_',
                                      style: const TextStyle(
                                        color: ReportScreen_Color.Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 170,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'รวมรายรับ',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '(ชำระแล้ว หักส่วนลด)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            (total1_ == null)
                                                ? '0.00'
                                                : '${nFormat.format(double.parse(total1_.toString()))}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            'บาท',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 170,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'รวมรายรับ',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '(ทั้งหมด ไม่หักส่วนลด)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            (total2_ == null)
                                                ? '0.00'
                                                : '${nFormat.format(total2_)}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            'บาท',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

///////////----------------------------------------->
class PreviewReportScreen extends StatelessWidget {
  final pw.Document doc;
  final Status_;
  PreviewReportScreen({super.key, required this.doc, this.Status_});

  static const customSwatch = MaterialColor(
    0xFF8DB95A,
    <int, Color>{
      50: Color(0xFFC2FD7F),
      100: Color(0xFFB6EE77),
      200: Color(0xFFB2E875),
      300: Color(0xFFACDF71),
      400: Color(0xFFA7DA6E),
      500: Color(0xFFA1D16A),
      600: Color(0xFF94BF62),
      700: Color(0xFF90B961),
      800: Color(0xFF85AB5A),
      900: Color(0xFF7A9B54),
    },
  );
  String day_ =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  String Tim_ =
      '${DateTime.now().hour}.${DateTime.now().minute}.${DateTime.now().second}';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 141, 185, 90),
          leading: IconButton(
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              String? _route = preferences.getString('route');
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AdminScafScreen(route: _route));
              Navigator.pushAndRemoveUntil(
                  context, materialPageRoute, (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "${Status_}",
            style: const TextStyle(
                color: Colors.white, fontFamily: FontWeight_.Fonts_T),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: false,
          allowPrinting: true, canChangePageFormat: false,
          canChangeOrientation: false, canDebug: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "${Status_}[$day_].pdf",
        ),
      ),
    );
  }
}

// เฉพาะของ user: กาดประตูเชียงใหม่

// สิ่งที่ต้องเพิ่ม:
// (เดี๋ยวพี่ทำไฟล์ตัวอย่างรายงานไปให้)
// 1. รายงานสรุปรายวัน /
// 2. สรุปรายรับรายวันแยกตาม user
// 3. รายงานประจำสัปดาห์ (ทุก 5 วัน)
// 4. รายงานประจำเดือน (ทุกเดือน)
// 5. รายงานสรุปผู้เช่า (รายเดือน) /

// คำถามจากลูกค้า:
// 1. สามารถปริ๊นเป็น QR Code ไปติดหน้าแผงร้านค้าได้มั้ย > ตอนจะเดินเก็บค่าแผง ให้ใช้ระบบสแกน QR  พอสแกนแล้วเด้งไปที่หน้า รับชำระ ของ
