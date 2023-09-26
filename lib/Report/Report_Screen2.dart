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
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Excel_BankDaily_Report.dart';
import 'Excel_Bankmovemen_Report.dart';
import 'Excel_Daily_Report.dart';
import 'Excel_Income_Report.dart';
import 'Report_Mini/MIni_Ex_BankDaily_Re.dart';
import 'Report_Mini/MIni_Ex_Bankmovemen_Re.dart';
import 'Report_Mini/MIni_Ex_Daily_Re.dart';
import 'Report_Mini/MIni_Ex_Income_Re.dart';

class ReportScreen2 extends StatefulWidget {
  const ReportScreen2({super.key});

  @override
  State<ReportScreen2> createState() => _ReportScreen2State();
}

class _ReportScreen2State extends State<ReportScreen2> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  List<PayMentModel> payMentModels = [];
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<RenTalModel> renTalModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<TransReBillModel> _TransReBillModels_Income = [];
  List<TransReBillModel> _TransReBillDailyBank = [];
  List<TransReBillModel> _TransReBillModels_Bankmovemen = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Income = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Bankmovemen = [];
  late List<List<dynamic>> TransReBillDailyBank;
  late List<List<dynamic>> TransReBillModels_Income;
  late List<List<dynamic>> TransReBillModels_Bankmovemen;
  late List<List<dynamic>> TransReBillModels;
  String? numinvoice;
  String? YE_Income;
  String? Mon_Income;
  String? renTal_user, renTal_name;
  String? base64_Slip, fileName_Slip;
  String? bills_name_;
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
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;
  var Value_selectDate_Daily;
  var Value_Chang_Zone_Daily;
  var Value_Chang_Zone_Ser_Daily;
  var Value_Chang_Zone_Income;
  var Value_Chang_Zone_Ser_Income;
  //-------------------------------------->
  String _verticalGroupValue_PassW = "EXCEL";
  String _ReportValue_type = "ปกติ";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();

  ///------------------------>
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
    checkPreferance();
    read_GC_zone();
    read_GC_PayMentModel();
    TransReBillModels_Income = [];
    TransReBillModels_Bankmovemen = [];
    TransReBillModels = [];
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

///////------------------------------------------------------------------>
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

  //////-------------------------------------------------------------->
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

        // for (int index = 0; index < 1; index++) {
        //   if (renTalModels[0].imglogo!.trim() == '') {
        //     // newValuePDFimg.add(
        //     //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
        //   } else {
        //     newValuePDFimg.add(
        //         '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
        //   }
        // }
      } else {}
    } catch (e) {}
    print('name>>>>>  $renname');
  }

  ////////------------------------------------------------->
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

///////////--------------------------------------------->(รายงานรายรับ)
  Future<Null> red_Trans_billIncome() async {
    int imd = 0;
    if (_TransReBillModels_Income.length != 0) {
      setState(() {
        _TransReBillModels_Income.clear();
        TransReBillModels_Income = [];
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
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
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

          print('imd ${imd + 1}');
        }

        print('result ${_TransReBillModels_Income.length}');
        // setState(() {
        //   TransReBillModels =
        //       List.generate(_TransReBillModels.length, (_) => []);
        // });
        TransReBillModels_Income =
            List.generate(_TransReBillModels_Income.length, (_) => []);
        red_Trans_selectIncome();
        // for (int index = 0; index < _TransReBillModels.length; index++) {
        //   red_Trans_select(index);
        // }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานรายรับ)
  Future<Null> red_Trans_selectIncome() async {
    for (int index = 0; index < _TransReBillModels_Income.length; index++) {
      if (_TransReBillHistoryModels_Income.length != 0) {
        setState(() {
          _TransReBillHistoryModels_Income.clear();

          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          // sum_disamt = 0;
          // sum_disp = 0;
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
            // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
            // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
            var numinvoiceent = _TransReBillHistoryModels_Incomes.docno;
            setState(() {
              sum_pvat = sum_pvat + sum_pvatx;
              sum_vat = sum_vat + sum_vatx;
              sum_wht = sum_wht + sum_whtx;
              sum_amt = sum_amt + sum_amtx;
              // sum_disamt = sum_disamtx;
              // sum_disp = sum_dispx;
              numinvoice = _TransReBillHistoryModels_Incomes.docno;
              _TransReBillHistoryModels_Income.add(
                  _TransReBillHistoryModels_Incomes);
              TransReBillModels_Income[index]
                  .add(_TransReBillHistoryModels_Incomes);
            });
          }
          // PDf_AdddataList_bill_Income();
        }
        // setState(() {
        //   red_Invoice();
        // });
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
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

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
          if (_TransReBillModels_Bankmovemens.total_dis != null) {
            setState(() {
              _TransReBillModels_Bankmovemen.add(
                  _TransReBillModels_Bankmovemens);

              // _TransBillModels.add(_TransBillModel);
            });
          }
        }

        print('result ${_TransReBillModels_Bankmovemen.length}');
        // setState(() {
        //   TransReBillModels =
        //       List.generate(_TransReBillModels.length, (_) => []);
        // });
        TransReBillModels_Bankmovemen =
            List.generate(_TransReBillModels_Bankmovemen.length, (_) => []);
        red_Trans_selectMovemen();
        // for (int index = 0; index < _TransReBillModels.length; index++) {
        //   red_Trans_select(index);
        // }
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

          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          // sum_disamt = 0;
          // sum_disp = 0;
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
          '${MyConstant().domain}/GC_bill_pay_history_MovemenReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
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
            // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
            // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
            var numinvoiceent = _TransReBillHistoryModels_Bankmovemens.docno;
            setState(() {
              sum_pvat = sum_pvat + sum_pvatx;
              sum_vat = sum_vat + sum_vatx;
              sum_wht = sum_wht + sum_whtx;
              sum_amt = sum_amt + sum_amtx;
              // sum_disamt = sum_disamtx;
              // sum_disp = sum_dispx;
              numinvoice = _TransReBillHistoryModels_Bankmovemens.docno;
              _TransReBillHistoryModels_Bankmovemen.add(
                  _TransReBillHistoryModels_Bankmovemens);
              TransReBillModels_Bankmovemen[index]
                  .add(_TransReBillHistoryModels_Bankmovemens);
            });
          }
          // PDf_AdddataList_bill_Income();
        }
        // setState(() {
        //   red_Invoice();
        // });
      } catch (e) {}
    }
  }

///////////--------------------------------------------->(รายงานประจำวัน)
  Future<Null> red_Trans_bill() async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
        TransReBillModels = [];
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren'; GC_bill_pay_BC_DailyReport_All
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
          if (transReBillModel.total_dis != null) {
            setState(() {
              _TransReBillModels.add(transReBillModel);

              // _TransBillModels.add(_TransBillModel);
            });
          }
        }

        print('result ${_TransReBillModels.length}');
        // setState(() {
        //   TransReBillModels =
        //       List.generate(_TransReBillModels.length, (_) => []);
        // });
        TransReBillModels = List.generate(_TransReBillModels.length, (_) => []);
        red_Trans_select();
        // for (int index = 0; index < _TransReBillModels.length; index++) {
        //   red_Trans_select(index);
        // }
      }
    } catch (e) {}
  }

///////////--------------------------------------------->(รายงานประจำวัน)
  Future<Null> red_Trans_select() async {
    for (int index = 0; index < _TransReBillModels.length; index++) {
      if (_TransReBillHistoryModels.length != 0) {
        setState(() {
          _TransReBillHistoryModels.clear();

          sum_pvat = 0;
          sum_vat = 0;
          sum_wht = 0;
          sum_amt = 0;
          // sum_disamt = 0;
          // sum_disp = 0;
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
          '${MyConstant().domain}/GC_bill_pay_history_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
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
              TransReBillModels[index].add(_TransReBillHistoryModel);
            });
          }
        }
        // setState(() {
        //   red_Invoice();
        // });
      } catch (e) {}
    }
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
          if (transReBillModel.total_dis != null) {
            setState(() {
              _TransReBillDailyBank.add(transReBillModel);
            });
          }
        }

        print('result ${_TransReBillDailyBank.length}');

        TransReBillDailyBank =
            List.generate(_TransReBillDailyBank.length, (_) => []);
        red_TransDailyBank_select();
      }
    } catch (e) {}
  }

  ///////////--------------------------------------------->(รายงานการเคลื่อนไหวธนาคารประจำวัน)
  Future<Null> red_TransDailyBank_select() async {
    for (int index = 0; index < _TransReBillDailyBank.length; index++) {
      if (TransReBillDailyBank[index].length != 0) {
        TransReBillDailyBank[index].clear();
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      var ren = preferences.getString('renTalSer');
      var user = preferences.getString('ser');
      var ciddoc = _TransReBillDailyBank[index].ser;
      var qutser = _TransReBillDailyBank[index].ser_in;
      var docnoin = _TransReBillDailyBank[index].docno;
      String url =
          '${MyConstant().domain}/GC_bill_pay_historyBank_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result.toString() != 'null') {
          for (var map in result) {
            TransReBillHistoryModel _TransReBillHistoryModel =
                TransReBillHistoryModel.fromJson(map);

            setState(() {
              TransReBillDailyBank[index].add(_TransReBillHistoryModel);
            });
          }
        }
      } catch (e) {}
    }
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

  ///////////--------------------------------------------->
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
                            value: Mon_Income,
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
                                    // '${item}',
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
                            value: YE_Income,
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
                              YE_Income = value;

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
                            value: Value_Chang_Zone_Income,
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

                            onChanged: (value) async {
                              int selectedIndex = zoneModels_report
                                  .indexWhere((item) => item.zn == value);

                              setState(() {
                                Value_Chang_Zone_Income = value!;
                                Value_Chang_Zone_Ser_Income =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              print(
                                  'Selected Index: $Value_Chang_Zone_Income  //${Value_Chang_Zone_Ser_Income}');

                              // if (Value_Chang_Zone_Income !=
                              //     null) {
                              //   red_Trans_billIncome();
                              //   red_Trans_billMovemen();   2114.56   95205.86   93091.30
                              // }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_Chang_Zone_Income != null) {
                              // Dia_log();
                              red_Trans_billIncome();
                              red_Trans_billMovemen();
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
                      ),
                    ],
                  ),
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
                        onTap: () async {
                          Insert_log.Insert_logs('รายงาน',
                              'กดดูรายงานรายรับ (เฉพาะรายการที่มีส่วนลด)');
                          RE_Income_Widget();

                          // RE_People_Cancel_Widget();
                        }),
                    (TransReBillModels_Income.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Value_Chang_Zone_Income != null &&
                                      Mon_Income != null &&
                                      YE_Income != null &&
                                      TransReBillModels_Income.isEmpty)
                                  ? 'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด) (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด)',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (Value_Chang_Zone_Income != null &&
                                Mon_Income != null &&
                                YE_Income != null &&
                                TransReBillModels_Income[
                                        _TransReBillModels_Income.length - 1]
                                    .isEmpty)
                            ? SizedBox(
                                // height: 20,
                                child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const CircularProgressIndicator()),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'กำลังโหลดรายงานรายรับ (เฉพาะรายการที่มีส่วนลด)...',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            : Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงานรายรับ (เฉพาะรายการที่มีส่วนลด) ✔️',
                                  style: TextStyle(
                                    color: ReportScreen_Color.Colors_Text2_,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                              )
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
                        onTap: () async {
                          Insert_log.Insert_logs('รายงาน',
                              'กดดูรายงานการเคลื่อนไหวธนาคาร (เฉพาะรายการที่มีส่วนลด)');
                          RE_IncomeBank_Widget();

                          // RE_People_Cancel_Widget();
                        }),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'รายงานการเคลื่อนไหวธนาคาร (เฉพาะรายการที่มีส่วนลด)',
                    //     style: TextStyle(
                    //       color: ReportScreen_Color.Colors_Text2_,
                    //       // fontWeight: FontWeight.bold,
                    //       fontFamily: Font_.Fonts_T,
                    //     ),
                    //   ),
                    // )
                    (TransReBillModels_Bankmovemen.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Value_Chang_Zone_Income != null &&
                                      Mon_Income != null &&
                                      YE_Income != null &&
                                      TransReBillModels_Bankmovemen.isEmpty)
                                  ? 'รายงานการเคลื่อนไหวธนาคาร (เฉพาะรายการที่มีส่วนลด) (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานการเคลื่อนไหวธนาคาร (เฉพาะรายการที่มีส่วนลด)',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (Value_Chang_Zone_Income != null &&
                                Mon_Income != null &&
                                YE_Income != null &&
                                TransReBillModels_Bankmovemen[
                                        _TransReBillModels_Bankmovemen.length -
                                            1]
                                    .isEmpty)
                            ? SizedBox(
                                // height: 20,
                                child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const CircularProgressIndicator()),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'กำลังโหลดรายงานการเคลื่อนไหวธนาคาร (เฉพาะรายการที่มีส่วนลด)...',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงานการเคลื่อนไหวธนาคาร(เฉพาะรายการที่มีส่วนลด) ✔️',
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
                            _select_Date_Daily(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: 120,
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  (Value_selectDate_Daily == null)
                                      ? 'เลือก'
                                      : '$Value_selectDate_Daily',
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
                            value: Value_Chang_Zone_Daily,
                            // hint: Text(
                            //   Value_Chang_Zone_Daily ==
                            //           null
                            //       ? 'เลือก'
                            //       : '$Value_Chang_Zone_Daily',
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
                            buttonWidth: 250,
                            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              // color: Colors
                              //     .amber,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 1),
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

                            onChanged: (value) async {
                              // Find the index of the selected item in the zoneModels_report list
                              int selectedIndex = zoneModels_report
                                  .indexWhere((item) => item.zn == value);

                              setState(() {
                                Value_Chang_Zone_Daily = value!;
                                Value_Chang_Zone_Ser_Daily =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              print(
                                  'Selected Index: $Value_Chang_Zone_Daily  //${Value_Chang_Zone_Ser_Daily}');

                              // if (Value_selectDate_Daily !=
                              //     null) {
                              //   red_Trans_bill();
                              //   red_Trans_billDailyBank();
                              // }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_selectDate_Daily != null) {
                              // Dia_log();
                              red_Trans_bill();
                              red_Trans_billDailyBank();
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
                      ),
                    ],
                  ),
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
                        onTap: () async {
                          Insert_log.Insert_logs('รายงาน',
                              'กดดูรายงานประจำวัน (เฉพาะรายการที่มีส่วนลด)');
                          RE_IncomeDaly_Widget();

                          // RE_People_Cancel_Widget();
                        }),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'รายงานประจำวัน (เฉพาะรายการที่มีส่วนลด)',
                    //     style: TextStyle(
                    //       color: ReportScreen_Color.Colors_Text2_,
                    //       // fontWeight: FontWeight.bold,
                    //       fontFamily: Font_.Fonts_T,
                    //     ),
                    //   ),
                    // )
                    (_TransReBillModels.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Value_selectDate_Daily != null &&
                                      TransReBillModels.isEmpty)
                                  ? 'รายงานประจำวัน (เฉพาะรายการที่มีส่วนลด) (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานประจำวัน (เฉพาะรายการที่มีส่วนลด)',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (TransReBillModels[_TransReBillModels.length - 1]
                                .isEmpty)
                            ? SizedBox(
                                // height: 20,
                                child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const CircularProgressIndicator()),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'กำลังโหลดรายงานประจำวัน (เฉพาะรายการที่มีส่วนลด)...',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงานประจำวัน (เฉพาะรายการที่มีส่วนลด)✔️',
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
                        onTap: () async {
                          Insert_log.Insert_logs('รายงาน',
                              'กดดูรายงานการเคลื่อนไหวธนาคารประจำวัน (เฉพาะรายการที่มีส่วนลด)');
                          RE_IncomeDalyBank_Widget();

                          // RE_People_Cancel_Widget();
                        }),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'รายงานการเคลื่อนไหวธนาคารประจำวัน (เฉพาะรายการที่มีส่วนลด)',
                    //     style: TextStyle(
                    //       color: ReportScreen_Color.Colors_Text2_,
                    //       // fontWeight: FontWeight.bold,
                    //       fontFamily: Font_.Fonts_T,
                    //     ),
                    //   ),
                    // )

                    (_TransReBillDailyBank.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Value_selectDate_Daily != null &&
                                      _TransReBillDailyBank.isEmpty)
                                  ? 'รายงานการเคลื่อนไหวธนาคารประจำวัน (เฉพาะรายการที่มีส่วนลด) (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานการเคลื่อนไหวธนาคารประจำวัน (เฉพาะรายการที่มีส่วนลด)',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (TransReBillDailyBank[
                                    _TransReBillDailyBank.length - 1]
                                .isEmpty)
                            ? SizedBox(
                                // height: 20,
                                child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const CircularProgressIndicator()),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'กำลังโหลดรายงานการเคลื่อนไหวธนาคารประจำวัน (เฉพาะรายการที่มีส่วนลด)...',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text2_,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: Font_.Fonts_T,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'รายงานการเคลื่อนไหวธนาคารประจำวัน (เฉพาะรายการที่มีส่วนลด)✔️',
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
            ])));
  }

///////////------------------------------------------------------->
  RE_Income_Widget() {
    int? show_more;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Center(
                  child: Text(
                (Value_Chang_Zone_Income == null)
                    ? 'รายงานรายรับ เฉพาะรายการที่มีส่วนลด (กรุณาเลือกโซน)'
                    : 'รายงานรายรับ เฉพาะรายการที่มีส่วนลด (โซน : $Value_Chang_Zone_Income)',
                style: const TextStyle(
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
                        (Mon_Income == null && YE_Income == null)
                            ? 'เดือน : ? (?) '
                            : (Mon_Income == null)
                                ? 'เดือน : ? ($YE_Income) '
                                : (YE_Income == null)
                                    ? 'เดือน : $Mon_Income (?) '
                                    : 'เดือน : $Mon_Income ($YE_Income) ',
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
                        'ทั้งหมด: ${_TransReBillModels_Income.length}',
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
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.grey[50],
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.9
                              : (_TransReBillModels_Income.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 800,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (_TransReBillModels_Income.length == 0)
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'ไม่พบข้อมูล ณ วันที่เลือก',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
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
                                        child: ListView.builder(
                                      itemCount:
                                          _TransReBillModels_Income.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        return ListTile(
                                          title: SizedBox(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          //'${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].docno}',
                                                          _TransReBillModels_Income[
                                                                          index1]
                                                                      .docno ==
                                                                  ''
                                                              ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].refno}'
                                                              : '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].docno}',
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                    .TiTile_Colors
                                                                .withOpacity(
                                                                    0.7),
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ชื่อร้านค้า',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รูปแบบชำระ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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

                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ราคารวม',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'หักส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Slip',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  (_TransReBillModels_Income[index1]
                                                                              .zn ==
                                                                          null)
                                                                      ? '${_TransReBillModels_Income[index1].znn}'
                                                                      : '${_TransReBillModels_Income[index1].zn}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Income[index1]
                                                                              .ln ==
                                                                          null)
                                                                      ? '${_TransReBillModels_Income[index1].room_number}'
                                                                      : '${_TransReBillModels_Income[index1].ln}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  // '${_TransReBillModels_Income[index1].daterec}',
                                                                  (_TransReBillModels_Income[index1]
                                                                              .daterec ==
                                                                          null)
                                                                      ? ''
                                                                      : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels_Income[index1].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillModels_Income[index1].daterec}'))}') + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Income[index1]
                                                                                  .sname ==
                                                                              null ||
                                                                          _TransReBillModels_Income[index1].sname.toString() ==
                                                                              '' ||
                                                                          _TransReBillModels_Income[index1].sname.toString() ==
                                                                              'null')
                                                                      ? '${_TransReBillModels_Income[index1].remark}'
                                                                      : '${_TransReBillModels_Income[index1].sname}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${_TransReBillModels_Income[index1].type}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  //'ttt',
                                                                  (TransReBillModels_Income[index1].length ==
                                                                              null ||
                                                                          TransReBillModels_Income
                                                                              .isEmpty)
                                                                      ? ''
                                                                      : '${nFormat2.format(double.parse(TransReBillModels_Income[index1].length.toString()))}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Income[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '0.00'
                                                                      : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!) - double.parse(_TransReBillModels_Income[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Income[index1]
                                                                              .total_bill ==
                                                                          null)
                                                                      ? ''
                                                                      : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Income[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}'
                                                                      : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: (_TransReBillModels_Income[index1].slip.toString() == null ||
                                                                            _TransReBillModels_Income[index1].slip ==
                                                                                null ||
                                                                            _TransReBillModels_Income[index1].slip.toString() ==
                                                                                'null')
                                                                        ? null
                                                                        : () async {
                                                                            String
                                                                                Url =
                                                                                await '${MyConstant().domain}/files/$foder/slip/${_TransReBillModels_Income[index1].slip}';
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                  title: Center(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Text(
                                                                                          _TransReBillModels_Income[index1].docno == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].refno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].docno}',
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
                                                                                    children: <Widget>[
                                                                                      Image.network('$Url')
                                                                                    ],
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
                                                                    child:
                                                                        Container(
                                                                      // width: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: (_TransReBillModels_Income[index1].slip.toString() == null ||
                                                                                _TransReBillModels_Income[index1].slip == null ||
                                                                                _TransReBillModels_Income[index1].slip.toString() == 'null')
                                                                            ? Colors.grey[300]
                                                                            : Colors.orange[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'เรียกดู',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        show_more =
                                                                            index1;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .green[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'ดูเพิ่มเติม',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.7),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: const Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ลำดับ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'วันที่',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AccountScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'กำหนดชำระ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รายการ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'Vat%',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'หน่วย',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'VAT',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
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
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ราคารวม Vat',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
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
                                                            Positioned(
                                                                top: 0,
                                                                right: 2,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      show_more =
                                                                          null;
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                        for (int index2 = 0;
                                                            index2 <
                                                                TransReBillModels_Income[
                                                                        index1]
                                                                    .length;
                                                            index2++)
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .green[100]!
                                                                  .withOpacity(
                                                                      0.5),
                                                              border:
                                                                  const Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 5, 0),
                                                            // padding: const EdgeInsets.all(4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${index1 + 1}.${index2 + 1}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        //  '${TransReBillModels_Income[index1][index2].date}',

                                                                        (TransReBillModels_Income[index1][index2].daterec ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels_Income[index1][index2].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels_Income[index1][index2].daterec}'))}') + 543}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        //  '${TransReBillModels_Income[index1][index2].date}',

                                                                        (TransReBillModels_Income[index1][index2].date ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels_Income[index1][index2].date}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels_Income[index1][index2].date}'))}') + 543}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels_Income[index1][index2].expname}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels_Income[index1][index2].nvat}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels_Income[index1][index2].vtype}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels_Income[index1][index2].vat ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].vat!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
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
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels_Income[index1][index2].amt ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].amt!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels_Income[index1][index2].total ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].total!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 120,
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : (_TransReBillModels.length == 0)
                                      ? MediaQuery.of(context).size.width
                                      : 900,
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมส่วนลด',
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
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมราคารวม',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมหักส่วนลด',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_Income
                                                          .length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse((_TransReBillModels_Income.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_bill !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_bill!)
                                                                : 0),
                                                      ) - _TransReBillModels_Income.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_dis !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_dis!)
                                                                : double.parse(
                                                                    element
                                                                        .total_bill!)),
                                                      )).toString()))}',
                                              // '${nFormat.format(double.parse('$Sum_dis_'))}',

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
                                              (_TransReBillModels_Income
                                                          .length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_bill !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_bill!)
                                                              : 0),
                                                    ).toString()))}',
                                              // '$Sum_Total_',
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
                                              (_TransReBillModels_Income
                                                          .length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillModels_Income.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_dis !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_dis!)
                                                              : double.parse(element
                                                                  .total_bill!)),
                                                    ).toString()))}',
                                              // '$Sum_Total_',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_TransReBillModels_Income.length != 0)
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
                            setState(() {
                              Value_Report = 'รายงานรายรับ';
                              Pre_and_Dow = 'Download';
                            });
                            // Navigator.pop(context);
                            _showMyDialog_SAVE();
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
                            Value_Chang_Zone_Income = null;
                            Mon_Income = null;
                            YE_Income = null;
                          });
                          setState(() {
                            _TransReBillModels_Income.clear();
                            TransReBillModels_Income = [];
                            _TransReBillModels_Bankmovemen.clear();
                            TransReBillModels_Bankmovemen = [];
                          });
                          // check_clear();
                          Navigator.of(context).pop();
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
  }

//////-------------------------------------------------------------------------->
  RE_IncomeBank_Widget() {
    int? show_more;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Center(
                  child: Text(
                (Value_Chang_Zone_Income == null)
                    ? 'รายงานการเคลื่อนไหวธนาคาร เฉพาะรายการที่มีส่วนลด (กรุณาเลือกโซน)'
                    : 'รายงานการเคลื่อนไหวธนาคาร เฉพาะรายการที่มีส่วนลด (โซน : $Value_Chang_Zone_Income) ',
                style: const TextStyle(
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
                        (Mon_Income == null && YE_Income == null)
                            ? 'เดือน : ? (?) '
                            : (Mon_Income == null)
                                ? 'เดือน : ? ($YE_Income) '
                                : (YE_Income == null)
                                    ? 'เดือน : $Mon_Income (?) '
                                    : 'เดือน : $Mon_Income ($YE_Income) ',
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
                        'ทั้งหมด: ${_TransReBillModels_Bankmovemen.length}',
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
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.grey[50],
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.9
                              : (_TransReBillModels_Bankmovemen.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (_TransReBillModels_Bankmovemen.length == 0)
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'ไม่พบข้อมูล ณ วันที่เลือก',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
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
                                        child: ListView.builder(
                                      itemCount:
                                          _TransReBillModels_Bankmovemen.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        return ListTile(
                                          title: SizedBox(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          //            '${_TransReBillModels_Income[index1].docno}',
                                                          _TransReBillModels_Bankmovemen[
                                                                          index1]
                                                                      .docno !=
                                                                  ''
                                                              ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Bankmovemen[index1].docno}'
                                                              : '${index1 + 1}. เลขที่: ${_TransReBillModels_Bankmovemen[index1].refno}',
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                    .TiTile_Colors
                                                                .withOpacity(
                                                                    0.7),
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ชื่อร้านค้า',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รูปแบบชำระ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'เลขบช.',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ราคารวม',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'หักส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Slip',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  5, 0, 5, 0),
                                                          // padding: const EdgeInsets.all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .zn ==
                                                                          null)
                                                                      ? '${_TransReBillModels_Bankmovemen[index1].znn}'
                                                                      : '${_TransReBillModels_Bankmovemen[index1].zn}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  _TransReBillModels_Bankmovemen[index1]
                                                                              .ln ==
                                                                          null
                                                                      ? ' ${_TransReBillModels_Bankmovemen[index1].room_number}'
                                                                      : ' ${_TransReBillModels_Bankmovemen[index1].ln}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
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
                                                                  // '${_TransReBillModels_Bankmovemen[index1].daterec}',
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .daterec ==
                                                                          null)
                                                                      ? ''
                                                                      : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels_Bankmovemen[index1].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillModels_Bankmovemen[index1].daterec}'))}') + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .sname ==
                                                                          null)
                                                                      ? '${_TransReBillModels_Bankmovemen[index1].remark1}'
                                                                      : '${_TransReBillModels_Bankmovemen[index1].sname}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${_TransReBillModels_Bankmovemen[index1].type}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     '${_TransReBillModels[index1].bank}',
                                                              //     // '${TransReBillModels[index1].length}',
                                                              //     textAlign: TextAlign.center,
                                                              //     style: const TextStyle(
                                                              //       color: ReportScreen_Color.Colors_Text1_,
                                                              //       // fontWeight: FontWeight.bold,
                                                              //       fontFamily: Font_.Fonts_T,
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     //'ttt',
                                                              //     (TransReBillModels_Bankmovemen[index1].length == null) ? '' : '${nFormat2.format(double.parse(TransReBillModels_Bankmovemen[index1].length.toString()))}',
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
                                                                  // '${_TransReBillModels_Income[index1].ramt}',
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .bank ==
                                                                          null)
                                                                      ? ''
                                                                      : '${_TransReBillModels_Bankmovemen[index1].bank!}',
                                                                  // '${_TransReBillModels[index1].ramt}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  // '${_TransReBillModels_Income[index1].ramtd}',
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .bno ==
                                                                          null)
                                                                      ? ''
                                                                      : '${_TransReBillModels_Bankmovemen[index1].bno!}',
                                                                  //'${nFormat.format(double.parse(_TransReBillModels_Income[index1].ramtd!))}',
                                                                  //  '${_TransReBillModels[index1].ramtd}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '0.00'
                                                                      : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_bill!) - double.parse(_TransReBillModels_Bankmovemen[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .total_bill ==
                                                                          null)
                                                                      ? ''
                                                                      : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_bill!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels_Bankmovemen[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_bill!))}'
                                                                      : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      String
                                                                          Url =
                                                                          await '${MyConstant().domain}/files/$foder/slip/${_TransReBillModels_Bankmovemen[index1].slip}';
                                                                      showDialog(
                                                                        context:
                                                                            context,
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
                                                                              children: <Widget>[
                                                                                Image.network('$Url')
                                                                              ],
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
                                                                    child:
                                                                        Container(
                                                                      // width: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .orange[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'เรียกดู',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        show_more =
                                                                            index1;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      // width: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .green[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'ดูเพิ่มเติม',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.7),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: const Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ลำดับ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'วันที่',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AccountScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'กำหนดชำระ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รายการ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'Vat%',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'หน่วย',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'VAT',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
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
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ราคารวม Vat',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
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
                                                            Positioned(
                                                                top: 0,
                                                                right: 2,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      show_more =
                                                                          null;
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                        for (int index2 = 0;
                                                            index2 <
                                                                TransReBillModels_Bankmovemen[
                                                                        index1]
                                                                    .length;
                                                            index2++)
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .green[100]!
                                                                  .withOpacity(
                                                                      0.5),
                                                              border:
                                                                  const Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 5, 0),
                                                            // padding: const EdgeInsets.all(4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${index1 + 1}.${index2 + 1}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        // '${TransReBillModels_Bankmovemen[index1][index2].date}',
                                                                        (TransReBillModels_Bankmovemen[index1][index2].daterec ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels_Bankmovemen[index1][index2].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels_Bankmovemen[index1][index2].daterec}'))}') + 543}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        // '${TransReBillModels_Bankmovemen[index1][index2].date}',
                                                                        (TransReBillModels_Bankmovemen[index1][index2].date ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels_Bankmovemen[index1][index2].date}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels_Bankmovemen[index1][index2].date}'))}') + 543}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels_Bankmovemen[index1][index2].expname}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels_Bankmovemen[index1][index2].nvat}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels_Bankmovemen[index1][index2].vtype}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels_Bankmovemen[index1][index2].vat ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].vat!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // Expanded(
                                                                    //   flex: 1,
                                                                    //   child: Text(
                                                                    //     (TransReBillModels_Bankmovemen[index1][index2].ramt.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].ramt!))}',
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
                                                                    //     (TransReBillModels_Bankmovemen[index1][index2].ramtd.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].ramtd!))}',
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
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels_Bankmovemen[index1][index2].amt ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].amt!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels_Bankmovemen[index1][index2].total ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels_Bankmovemen[index1][index2].total!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 120,
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : (_TransReBillModels.length == 0)
                                      ? MediaQuery.of(context).size.width
                                      : 900,
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมส่วนลด',
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
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมราคารวม',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมหักส่วนลด',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels_Bankmovemen
                                                          .length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse((_TransReBillModels_Bankmovemen.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_bill !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_bill!)
                                                                : 0),
                                                      ) - _TransReBillModels_Bankmovemen.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_dis !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_dis!)
                                                                : double.parse(
                                                                    element
                                                                        .total_bill!)),
                                                      )).toString()))}',
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
                                              (_TransReBillModels_Bankmovemen
                                                          .length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_bill !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_bill!)
                                                              : double.parse(
                                                                  '0')),
                                                    ).toString()))}',
                                              // '$Sum_Total_',
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
                                              (_TransReBillModels_Bankmovemen
                                                          .length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillModels_Bankmovemen.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_dis !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_dis!)
                                                              : double.parse(element
                                                                  .total_bill!)),
                                                    ).toString()))}',
                                              // '${nFormat.format(double.parse('$Sum_total_dis'))}',
                                              // '$Sum_Total_',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_TransReBillModels_Bankmovemen.length != 0)
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
                          onTap: () async {
                            setState(() {
                              Value_Report = 'รายงานการเคลื่อนไหวธนาคาร';
                              Pre_and_Dow = 'Download';
                            });
                            // Navigator.pop(context);
                            _showMyDialog_SAVE();
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
                        onTap: () {
                          setState(() {
                            Value_Chang_Zone_Income = null;
                            Mon_Income = null;
                            YE_Income = null;
                          });
                          setState(() {
                            _TransReBillModels_Income.clear();
                            TransReBillModels_Income = [];
                            _TransReBillModels_Bankmovemen.clear();
                            TransReBillModels_Bankmovemen = [];
                          });
                          Navigator.of(context).pop();
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
  }

//////-------------------------------------------------------------------------->
  RE_IncomeDaly_Widget() {
    int? show_more;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Center(
                  child: Text(
                (Value_Chang_Zone_Daily == null)
                    ? 'รายงานประจำวัน เฉพาะรายการที่มีส่วนลด (** กรุณาเลือกโซน!!!)'
                    : 'รายงานประจำวัน เฉพาะรายการที่มีส่วนลด (โซน :${Value_Chang_Zone_Daily})',
                style: const TextStyle(
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
                        (Value_selectDate_Daily == null)
                            ? 'วันที่: ?'
                            : 'วันที่: $Value_selectDate_Daily',
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
                        'ทั้งหมด: ${_TransReBillModels.length}',
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
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.grey[50],
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.9
                              : (_TransReBillModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 800,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (_TransReBillModels.length == 0)
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'ไม่พบข้อมูล',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
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
                                        child: ListView.builder(
                                      itemCount: _TransReBillModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        return ListTile(
                                          title: SizedBox(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          //   _TransReBillModels[index1].doctax == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].doctax}',
                                                          _TransReBillModels[
                                                                          index1]
                                                                      .docno !=
                                                                  null
                                                              ? '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].docno}'
                                                              : '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].doctax}',
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
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
                                                if (show_more != index1)
                                                  SizedBox(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                    .TiTile_Colors
                                                                .withOpacity(
                                                                    0.7),
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'วันที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ชื่อร้านค้า',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รูปแบบชำระ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ราคารวม',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'หักส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Slip',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  (_TransReBillModels[index1]
                                                                              .zn ==
                                                                          null)
                                                                      ? '${_TransReBillModels[index1].znn}'
                                                                      : '${_TransReBillModels[index1].zn}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels[index1]
                                                                              .ln ==
                                                                          null)
                                                                      ? '${_TransReBillModels[index1].room_number}'
                                                                      : '${_TransReBillModels[index1].ln}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  //'${_TransReBillModels[index1].daterec}',
                                                                  (_TransReBillModels[index1]
                                                                              .daterec ==
                                                                          null)
                                                                      ? ''
                                                                      : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index1].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillModels[index1].daterec}'))}') + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  //  (_TransReBillModels[index1].sname != null) ? '${_TransReBillModels[index1].sname}' : '${_TransReBillModels[index1].cname}',
                                                                  (_TransReBillModels[index1]
                                                                              .sname ==
                                                                          null)
                                                                      ? '${_TransReBillModels[index1].remark}'
                                                                      : (_TransReBillModels[index1].sname !=
                                                                              null)
                                                                          ? '${_TransReBillModels[index1].sname}'
                                                                          : '${_TransReBillModels[index1].cname}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${_TransReBillModels[index1].type}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     '${_TransReBillModels[index1].bank}',
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
                                                                  (TransReBillModels[index1]
                                                                              .length ==
                                                                          null)
                                                                      ? '0.00'
                                                                      : '${nFormat2.format(double.parse(TransReBillModels[index1].length.toString()))}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '0.00'
                                                                      : '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!) - double.parse(_TransReBillModels[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels[index1]
                                                                              .total_bill ==
                                                                          null)
                                                                      ? ''
                                                                      : '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillModels[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}'
                                                                      : '${nFormat.format(double.parse(_TransReBillModels[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: (_TransReBillModels[index1].slip.toString() == null ||
                                                                            _TransReBillModels[index1].slip ==
                                                                                null ||
                                                                            _TransReBillModels[index1].slip.toString() ==
                                                                                'null')
                                                                        ? null
                                                                        : () async {
                                                                            String
                                                                                Url =
                                                                                await '${MyConstant().domain}/files/$foder/slip/${_TransReBillModels[index1].slip}';
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                  title: Center(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Text(
                                                                                          _TransReBillModels[index1].docno != null ? '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].doctax}',
                                                                                          maxLines: 1,
                                                                                          textAlign: TextAlign.start,
                                                                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                        ),
                                                                                        Text(
                                                                                          '${_TransReBillModels[index1].slip}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  content: Stack(
                                                                                    alignment: Alignment.center,
                                                                                    children: <Widget>[
                                                                                      Image.network('$Url')
                                                                                    ],
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
                                                                    child:
                                                                        Container(
                                                                      // width: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: (_TransReBillModels[index1].slip.toString() == null ||
                                                                                _TransReBillModels[index1].slip == null ||
                                                                                _TransReBillModels[index1].slip.toString() == 'null')
                                                                            ? Colors.grey[300]
                                                                            : Colors.orange[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'เรียกดู',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        show_more =
                                                                            index1;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .green[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'ดูเพิ่มเติม',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.7),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: const Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ลำดับ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'วันที่',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'กำหนดชำระ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รายการ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'Vat%',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'หน่วย',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'VAT',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
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
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ราคารวม Vat',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
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
                                                            Positioned(
                                                                top: 0,
                                                                right: 2,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      show_more =
                                                                          null;
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                        for (int index2 = 0;
                                                            index2 <
                                                                TransReBillModels[
                                                                        index1]
                                                                    .length;
                                                            index2++)
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .green[100]!
                                                                  .withOpacity(
                                                                      0.5),
                                                              border:
                                                                  const Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            // padding: const EdgeInsets.all(4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${index1 + 1}.${index2 + 1}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels[index1][index2].daterec ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels[index1][index2].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels[index1][index2].daterec}'))}') + 543}',
                                                                        // '${TransReBillModels[index1][index2].date}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels[index1][index2].date ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels[index1][index2].date}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillModels[index1][index2].date}'))}') + 543}',
                                                                        // '${TransReBillModels[index1][index2].date}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels[index1][index2].expname}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels[index1][index2].nvat}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillModels[index1][index2].vtype}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels[index1][index2].vat ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels[index1][index2].vat!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // Expanded(
                                                                    //   flex: 1,
                                                                    //   child: Text(
                                                                    //     (TransReBillModels[index1][index2].ramt.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramt!))}',
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
                                                                    //     (TransReBillModels[index1][index2].ramtd.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramtd!))}',
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
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels[index1][index2].amt ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels[index1][index2].amt!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillModels[index1][index2].total ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillModels[index1][index2].total!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 120,
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : (_TransReBillModels.length == 0)
                                      ? MediaQuery.of(context).size.width
                                      : 800,
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมส่วนลด',
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
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมราคารวม',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมหักส่วนลด',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillModels.length == 0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse((_TransReBillModels.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_bill !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_bill!)
                                                                : 0),
                                                      ) - _TransReBillModels.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_dis !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_dis!)
                                                                : double.parse(
                                                                    element
                                                                        .total_bill!)),
                                                      )).toString()))}',
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
                                              (_TransReBillModels.length == 0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillModels.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_bill !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_bill!)
                                                              : double.parse(
                                                                  '0')),
                                                    ).toString()))}',
                                              // '$Sum_Total_',
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
                                              (_TransReBillModels.length == 0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillModels.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_dis !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_dis!)
                                                              : double.parse(element
                                                                  .total_bill!)),
                                                    ).toString()))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_TransReBillModels.length != 0)
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
                            if (_TransReBillModels.length == 0) {
                            } else {
                              setState(() {
                                show_more = null;
                                Value_Report = 'รายงานประจำวัน';
                                Pre_and_Dow = 'Download';
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
                        onTap: () {
                          setState(() {
                            Value_Chang_Zone_Daily = null;
                            show_more = null;
                          });
                          setState(() {
                            _TransReBillModels.clear();
                            TransReBillModels = [];
                            _TransReBillHistoryModels.clear();
                            _TransReBillDailyBank.clear();
                            TransReBillDailyBank = [];
                          });
                          // check_clear();
                          Navigator.of(context).pop();
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
  }

//////-------------------------------------------------------------------------->
  RE_IncomeDalyBank_Widget() {
    int? show_more;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Center(
                  child: Text(
                (Value_Chang_Zone_Daily == null)
                    ? 'รายงานการเคลื่อนไหวธนาคารประจำวัน เฉพาะรายการที่มีส่วนลด (** กรุณาเลือกโซน!!!)'
                    : 'รายงานการเคลื่อนไหวธนาคารประจำวัน เฉพาะรายการที่มีส่วนลด (โซน :${Value_Chang_Zone_Daily})',
                style: const TextStyle(
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
                        (Value_selectDate_Daily == null)
                            ? 'วันที่: ?'
                            : 'วันที่: $Value_selectDate_Daily',
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
                        'ทั้งหมด: ${_TransReBillDailyBank.length}',
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
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.grey[50],
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.9
                              : (_TransReBillDailyBank.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 800,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (_TransReBillDailyBank.length == 0)
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'ไม่พบข้อมูล',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
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
                                        child: ListView.builder(
                                      itemCount: _TransReBillDailyBank.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        return ListTile(
                                          title: SizedBox(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .TiTile_Colors,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          _TransReBillDailyBank[
                                                                          index1]
                                                                      .docno !=
                                                                  null
                                                              ? '${index1 + 1}. เลขที่: ${_TransReBillDailyBank[index1].docno}'
                                                              : '${index1 + 1}. เลขที่: ${_TransReBillDailyBank[index1].doctax}',
                                                          style:
                                                              const TextStyle(
                                                            color: ReportScreen_Color
                                                                .Colors_Text1_,
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
                                                if (show_more != index1)
                                                  SizedBox(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppbackgroundColor
                                                                    .TiTile_Colors
                                                                .withOpacity(
                                                                    0.7),
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'วันที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ชื่อร้านค้า',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รูปแบบชำระ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ธนาคาร',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'เลขบช.',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ราคารวม',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'หักส่วนลด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Slip',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
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
                                                                  (_TransReBillDailyBank[index1]
                                                                              .zn ==
                                                                          null)
                                                                      ? '${_TransReBillDailyBank[index1].znn}'
                                                                      : '${_TransReBillDailyBank[index1].zn}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillDailyBank[index1]
                                                                              .ln ==
                                                                          null)
                                                                      ? '${_TransReBillDailyBank[index1].room_number}'
                                                                      : '${_TransReBillDailyBank[index1].ln}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  // '${_TransReBillDailyBank[index1].daterec}',
                                                                  (_TransReBillDailyBank[index1]
                                                                              .daterec ==
                                                                          null)
                                                                      ? ''
                                                                      : '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillDailyBank[index1].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${_TransReBillDailyBank[index1].daterec}'))}') + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  //  (_TransReBillModels[index1].sname != null) ? '${_TransReBillModels[index1].sname}' : '${_TransReBillModels[index1].cname}',
                                                                  (_TransReBillDailyBank[index1]
                                                                              .sname ==
                                                                          null)
                                                                      ? '${_TransReBillDailyBank[index1].remark}'
                                                                      : (_TransReBillDailyBank[index1].sname !=
                                                                              null)
                                                                          ? '${_TransReBillDailyBank[index1].sname}'
                                                                          : '${_TransReBillDailyBank[index1].cname}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${_TransReBillDailyBank[index1].type}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${_TransReBillDailyBank[index1].bank}',
                                                                  // '${TransReBillModels[index1].length}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${_TransReBillDailyBank[index1].bno}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillDailyBank[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '0.00'
                                                                      : '${nFormat.format(double.parse(_TransReBillDailyBank[index1].total_bill!) - double.parse(_TransReBillDailyBank[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillDailyBank[index1]
                                                                              .total_bill ==
                                                                          null)
                                                                      ? ''
                                                                      : '${nFormat.format(double.parse(_TransReBillDailyBank[index1].total_bill!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  (_TransReBillDailyBank[index1]
                                                                              .total_dis ==
                                                                          null)
                                                                      ? '${nFormat.format(double.parse(_TransReBillDailyBank[index1].total_bill!))}'
                                                                      : '${nFormat.format(double.parse(_TransReBillDailyBank[index1].total_dis!))}',
                                                                  // '${_TransReBillModels[index1].total_bill}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    // fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: (_TransReBillDailyBank[index1].slip.toString() == null ||
                                                                            _TransReBillDailyBank[index1].slip ==
                                                                                null ||
                                                                            _TransReBillDailyBank[index1].slip.toString() ==
                                                                                'null')
                                                                        ? null
                                                                        : () async {
                                                                            String
                                                                                Url =
                                                                                await '${MyConstant().domain}/files/$foder/slip/${_TransReBillDailyBank[index1].slip}';
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                  title: Center(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Text(
                                                                                          _TransReBillDailyBank[index1].docno != null ? '${index1 + 1}. เลขที่: ${_TransReBillDailyBank[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillDailyBank[index1].doctax}',
                                                                                          maxLines: 1,
                                                                                          textAlign: TextAlign.start,
                                                                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                        ),
                                                                                        Text(
                                                                                          '${_TransReBillDailyBank[index1].slip}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T, fontSize: 12.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  content: Stack(
                                                                                    alignment: Alignment.center,
                                                                                    children: <Widget>[
                                                                                      Image.network('$Url')
                                                                                    ],
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
                                                                    child:
                                                                        Container(
                                                                      // width: 100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: (_TransReBillDailyBank[index1].slip.toString() == null ||
                                                                                _TransReBillDailyBank[index1].slip == null ||
                                                                                _TransReBillDailyBank[index1].slip.toString() == 'null')
                                                                            ? Colors.grey[300]
                                                                            : Colors.orange[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'เรียกดู',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        show_more =
                                                                            index1;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .green[300],
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          'ดูเพิ่มเติม',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ReportScreen_Color.Colors_Text1_,
                                                                            // fontWeight: FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppbackgroundColor
                                                                        .TiTile_Colors
                                                                    .withOpacity(
                                                                        0.7),
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: const Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ลำดับ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'วันที่',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'กำหนดชำระ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รายการ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'Vat%',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'หน่วย',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'VAT',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
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
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'ราคารวม Vat',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
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
                                                            Positioned(
                                                                top: 0,
                                                                right: 2,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      show_more =
                                                                          null;
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .cancel,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                        for (int index2 = 0;
                                                            index2 <
                                                                TransReBillDailyBank[
                                                                        index1]
                                                                    .length;
                                                            index2++)
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .green[100]!
                                                                  .withOpacity(
                                                                      0.5),
                                                              border:
                                                                  const Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            // padding: const EdgeInsets.all(4.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${index1 + 1}.${index2 + 1}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        //'${TransReBillDailyBank[index1][index2].date}',
                                                                        (TransReBillDailyBank[index1][index2].daterec ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillDailyBank[index1][index2].daterec}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillDailyBank[index1][index2].daterec}'))}') + 543}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        //'${TransReBillDailyBank[index1][index2].date}',
                                                                        (TransReBillDailyBank[index1][index2].date ==
                                                                                null)
                                                                            ? ''
                                                                            : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillDailyBank[index1][index2].date}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${TransReBillDailyBank[index1][index2].date}'))}') + 543}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillDailyBank[index1][index2].expname}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillDailyBank[index1][index2].nvat}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        '${TransReBillDailyBank[index1][index2].vtype}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillDailyBank[index1][index2].vat ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillDailyBank[index1][index2].vat!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // Expanded(
                                                                    //   flex: 1,
                                                                    //   child: Text(
                                                                    //     (TransReBillModels[index1][index2].ramt.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramt!))}',
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
                                                                    //     (TransReBillModels[index1][index2].ramtd.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramtd!))}',
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
                                                                      child:
                                                                          Text(
                                                                        (TransReBillDailyBank[index1][index2].amt ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillDailyBank[index1][index2].amt!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (TransReBillDailyBank[index1][index2].total ==
                                                                                null)
                                                                            ? '-'
                                                                            : '${nFormat.format(double.parse(TransReBillDailyBank[index1][index2].total!))}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text2_,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 120,
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : (_TransReBillDailyBank.length == 0)
                                      ? MediaQuery.of(context).size.width
                                      : 800,
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมส่วนลด',
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
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมราคารวม',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รวมหักส่วนลด',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
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
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (_TransReBillDailyBank.length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse((_TransReBillDailyBank.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_bill !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_bill!)
                                                                : 0),
                                                      ) - _TransReBillDailyBank.fold(
                                                        0.0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element.total_dis !=
                                                                    null
                                                                ? double.parse(
                                                                    element
                                                                        .total_dis!)
                                                                : double.parse(
                                                                    element
                                                                        .total_bill!)),
                                                      )).toString()))}',
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
                                              (_TransReBillDailyBank.length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillDailyBank.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_bill !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_bill!)
                                                              : double.parse(
                                                                  '0')),
                                                    ).toString()))}',
                                              // '$Sum_Total_',
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
                                              (_TransReBillDailyBank.length ==
                                                      0)
                                                  ? '0.00'
                                                  : '${nFormat.format(double.parse(_TransReBillDailyBank.fold(
                                                      0.0,
                                                      (previousValue,
                                                              element) =>
                                                          previousValue +
                                                          (element.total_dis !=
                                                                  null
                                                              ? double.parse(
                                                                  element
                                                                      .total_dis!)
                                                              : double.parse(element
                                                                  .total_bill!)),
                                                    ).toString()))}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          if (Responsive.isDesktop(context))
                                            const Expanded(
                                              flex: 2,
                                              child: Text(
                                                ' ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_TransReBillDailyBank.length != 0)
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
                            if (_TransReBillDailyBank.length == 0) {
                            } else {
                              setState(() {
                                show_more = null;
                                Value_Report =
                                    'รายงานการเคลื่อนไหวธนาคารประจำวัน';
                                Pre_and_Dow = 'Download';
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
                        onTap: () {
                          setState(() {
                            show_more = null;
                          });
                          setState(() {
                            Value_Chang_Zone_Daily = null;
                            _TransReBillModels.clear();
                            TransReBillModels = [];
                            _TransReBillHistoryModels.clear();
                            _TransReBillDailyBank.clear();
                            TransReBillDailyBank = [];
                          });
                          // check_clear();
                          Navigator.of(context).pop();
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
                  height: 80,
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
                              onTap: () => Navigator.pop(context, 'OK'),
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
                      const Text(
                        'รูปแบบ :',
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
                          groupValue: _ReportValue_type,
                          horizontalAlignment: MainAxisAlignment.spaceAround,
                          onChanged: (value) {
                            // setState(() {
                            //   FormNameFile_text.clear();
                            // });
                            setState(() {
                              _ReportValue_type = value ?? '';
                            });
                          },
                          items: const <String>[
                            "ปกติ",
                            "ย่อ",
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
        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'รายงานรายรับ') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_IncomeReport.exportExcel_IncomeReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillModels_Income,
                  TransReBillModels_Income,
                  renTal_name,
                  zoneModels_report,
                  Value_Chang_Zone_Income,
                  Mon_Income,
                  YE_Income)
              : Mini_Ex_IncomeReport.mini_exportExcel_IncomeReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillModels_Income,
                  TransReBillModels_Income,
                  renTal_name,
                  zoneModels_report,
                  Value_Chang_Zone_Income,
                  Mon_Income,
                  YE_Income);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_BankmovemenReport.exportExcel_BankmovemenReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillModels_Bankmovemen,
                  TransReBillModels_Bankmovemen,
                  renTal_name,
                  zoneModels_report,
                  Value_Chang_Zone_Income,
                  Mon_Income,
                  YE_Income,
                  payMentModels)
              : Mini_Ex_BankmovemenReport.mini_exportExcel_BankmovemenReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillModels_Bankmovemen,
                  TransReBillModels_Bankmovemen,
                  renTal_name,
                  zoneModels_report,
                  Value_Chang_Zone_Income,
                  Mon_Income,
                  YE_Income,
                  payMentModels);
        } else if (Value_Report == 'รายงานประจำวัน') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_DailyReport.exportExcel_DailyReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillModels,
                  TransReBillModels,
                  bill_name,
                  zoneModels_report,
                  Value_selectDate_Daily,
                  Value_Chang_Zone_Daily)
              : Mini_Ex_DailyReport.mini_exportExcel_DailyReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillModels,
                  TransReBillModels,
                  bill_name,
                  zoneModels_report,
                  Value_selectDate_Daily,
                  Value_Chang_Zone_Daily);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคารประจำวัน') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_BankDailyReport.exportExcel_BankDailyReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillDailyBank,
                  TransReBillDailyBank,
                  renTal_name,
                  zoneModels_report,
                  Value_selectDate_Daily,
                  Value_Chang_Zone_Daily,
                  payMentModels)
              : Mini_Ex_BankdailyReport.mini_exportExcel_BankdailyReport(
                  '2',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  _TransReBillDailyBank,
                  TransReBillDailyBank,
                  renTal_name,
                  zoneModels_report,
                  Value_selectDate_Daily,
                  Value_Chang_Zone_Daily,
                  payMentModels);
        }

        Navigator.of(context).pop();
      }
    }
  }
}
