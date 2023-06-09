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
import '../Model/GetCustomer_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_SCReportTotal_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PDF/pdf_Quotation.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/colors.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<TransReBillModel> _TransReBillModels_Income = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Income = [];
  List<TransReBillModel> _TransReBillModels_Bankmovemen = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels_Bankmovemen = [];
  late List<List<dynamic>> TransReBillModels_Income;
  late List<List<dynamic>> TransReBillModels_Bankmovemen;
  late List<List<dynamic>> TransReBillModels;
  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  //////////////////////----------------------------------
  String? renTal_user, renTal_name, zone_ser, zone_name;
  DateTime now = DateTime.now();
  String? SDatex_total1_;
  String? LDatex_total1_;
  double total1_ = 0.00;
  double total2_ = 0.00;
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
    read_GC_area2();
    red_Sum_billIncome();
    read_GC_zone();
    select_coutumer();
    // red_Trans_billIncome();
    // red_Trans_bill();
    TransReBillModels_Income = [];
    TransReBillModels_Bankmovemen = [];
    TransReBillModels = [];
  }

  Future<Null> select_coutumer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
        _customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url = '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          CustomerModel customerModel = CustomerModel.fromJson(map);
          setState(() {
            customerModels.add(customerModel);
          });
        }
      }
      setState(() {
        _customerModels = customerModels;
      });
    } catch (e) {}
  }

  _searchBar_cust() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 0)),
        builder: (context, snapshot) {
          return TextField(
            autofocus: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              // fontSize: 22.0,
              color: TextHome_Color.TextHome_Colors,
            ),
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.white,
              hintText: ' Search...',
              hintStyle: const TextStyle(
                  color: CustomerScreen_Color.Colors_Text2_,
                  // fontWeight: FontWeight.bold,
                  fontFamily: Font_.Fonts_T),
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
              text = text.toLowerCase();
              // print(text);

              // print(customerModels.map((e) => e.docno));
              // print(_customerModels.map((e) => e.docno));

              setState(() {
                customerModels = _customerModels.where((customerModel) {
                  var notTitle = customerModel.cname.toString().toLowerCase();
                  var notTitle2 = customerModel.custno.toString().toLowerCase();
                  var notTitle3 = customerModel.scname.toString().toLowerCase();
                  var notTitle4 = customerModel.tax.toString().toLowerCase();
                  var notTitle5 = customerModel.tel.toString().toLowerCase();
                  var notTitle6 = customerModel.custno.toString().toLowerCase();
                  return notTitle.contains(text) ||
                      notTitle2.contains(text) ||
                      notTitle3.contains(text) ||
                      notTitle4.contains(text) ||
                      notTitle5.contains(text) ||
                      notTitle6.contains(text);
                }).toList();
              });
            },
          );
        });
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
      TransReBillModels_Income.clear();
      TransReBillModels_Bankmovemen.clear();
      TransReBillModels.clear();
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
            // newValuePDFimg.add(
            //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
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
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';

    String url =
        '${MyConstant().domain}/GC_SCReport_total1.php?isAdd=true&ren=$ren&sdate=$SDatex_total1_&ldate=$LDatex_total1_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModels_Incomes =
              TransReBillModel.fromJson(map);
          setState(() {
            total1_ = (_TransReBillModels_Incomes.amt == null ||
                    _TransReBillModels_Incomes.amt.toString() == '')
                ? total1_ + 0.00
                : total1_ + double.parse(_TransReBillModels_Incomes.amt!);

            // _TransReBillModels_Income.add(_TransReBillModels_Incomes);
          });
          print(_TransReBillModels_Incomes.amt);
        }
      }
    } catch (e) {}
  }
/////////////////----------------------------------->(รวมรายรับ ทั้งหมด)

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
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_IncomeReport.php?isAdd=true&ren=$ren&sdate=$Value_selectDate1&ldate=$Value_selectDate2';
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

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_BankmovemenReport.php?isAdd=true&ren=$ren&sdate=$Value_selectDate1&ldate=$Value_selectDate2';
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

            // _TransBillModels.add(_TransBillModel);
          });
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
///////////////------------------------------------------------------------->
  // void PDf_AdddataList_bill_Income() async {
  //   if (datalist001_Incom.length > 0) {
  //     setState(() {
  //       datalist001_Incom = [];
  //     });
  //   }
  //   for (int index1 = 0; index1 < _TransReBillModels_Income.length; index1++) {
  //     for (int index2 = 0;
  //         index2 < TransReBillModels_Income[index1].length;
  //         index2++) {
  //       //   _TransReBillModels_Income[index1].docno == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels_Income[index1].refno}',
  //       Map<String, dynamic> newHeader = {
  //         'index': '${(index2 + 1)}',
  //         'docno': _TransReBillModels_Income[index1].docno == ''
  //             ? '${_TransReBillModels_Income[index1].docno}'
  //             : '${_TransReBillModels_Income[index1].refno}',
  //         'date': '${TransReBillModels_Income[index1][index2].date}',
  //         'type': '${TransReBillModels_Income[index1][index2].type}',
  //         'expname': '${TransReBillModels_Income[index1][index2].expname}',
  //         'nvat': '${TransReBillModels_Income[index1][index2].nvat}',
  //         'vtype': '${TransReBillModels_Income[index1][index2].vtype}',
  //         'vat':
  //             '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].vat!))}',
  //         'ramt': (TransReBillModels_Income[index1][index2].ramt.toString() ==
  //                 'null')
  //             ? '-'
  //             : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].ramt!))}',
  //         'ramtd': (TransReBillModels_Income[index1][index2].ramtd.toString() ==
  //                 'null')
  //             ? '-'
  //             : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].ramtd!))}',
  //         'amt':
  //             '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].amt!))}',
  //         'total':
  //             '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].total!))}',
  //         'sname': (TransReBillModels_Income[index1][index2].sname == null)
  //             ? '${TransReBillModels_Income[index1][index2].remark}'
  //             : '${TransReBillModels_Income[index1][index2].sname}'
  //       };
  //       datalist001_Incom.add(newHeader);
  //     }
  //   }
  // }

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
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_DailyReport.php?isAdd=true&ren=$ren&date=$Value_selectDate';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            _TransReBillModels.add(transReBillModel);

            // _TransBillModels.add(_TransBillModel);
          });
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

  Future<Null> _select_Date(BuildContext context) async {
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
        TransReBillModels = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_selectDate = "${formatter.format(result)}";
        });
        red_Trans_bill();
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
        if (Value_Report == 'ภาษี') {
          _displayPdf_();
        } else if (Value_Report == 'รายงานรายรับ') {
          _displayPdf_();
        } else if (Value_Report == 'รายงานรายจ่าย') {
          _displayPdf_();
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          _displayPdf_();
        } else if (Value_Report == 'รายงานประจำวัน') {
          _displayPdf_();
        }

        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'ภาษี') {
          Excgen_TaxReport.exportExcel_TaxReport(
              context, NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานรายรับ') {
          Excgen_IncomeReport.exportExcel_IncomeReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              Value_Report,
              _TransReBillModels_Income,
              TransReBillModels_Income,
              bill_name,
              Value_selectDate1,
              Value_selectDate2,
              zoneModels_report);
        } else if (Value_Report == 'รายงานรายจ่าย') {
          Excgen_ExpenseReport.exportExcel_ExpenseReport(
              context, NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          Excgen_BankmovemenReport.exportExcel_BankmovemenReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              Value_Report,
              _TransReBillModels_Bankmovemen,
              TransReBillModels_Bankmovemen,
              bill_name,
              Value_selectDate1,
              Value_selectDate2,
              zoneModels_report);
        } else if (Value_Report == 'รายงานประจำวัน') {
          Excgen_DailyReport.exportExcel_DailyReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              Value_Report,
              _TransReBillModels,
              TransReBillModels,
              bill_name,
              Value_selectDate,
              zoneModels_report);
        }

        Navigator.of(context).pop();
      }
    }
  }

///////////-------------------------------------------------------------->(PDF)
  void _displayPdf_() async {
    var bill_addr = ' ${renTalModels[0].bill_addr}';
    var bill_email = ' ${renTalModels[0].bill_email}';
    var bill_tel = ' ${renTalModels[0].bill_tel}';
    var bill_tax = ' ${renTalModels[0].bill_tax}';
    var bill_name = ' ${renTalModels[0].bill_name}';
//_TransReBillModels_Income,TransReBillModels_Income
    //    'index': '${(index2 + 1)}',
    // 'docno': _TransReBillModels_Income[index1].docno == ''
    //     ? '${_TransReBillModels_Income[index1].docno}'
    //     : '${_TransReBillModels_Income[index1].refno}',
    // 'date': '${TransReBillModels_Income[index1][index2].date}',
    // 'type': '${TransReBillModels_Income[index1][index2].type}',
    // 'expname': '${TransReBillModels_Income[index1][index2].expname}',
    // 'nvat': '${TransReBillModels_Income[index1][index2].nvat}',
    // 'vtype': '${TransReBillModels_Income[index1][index2].vtype}',
    // 'vat':
    //     '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].vat!))}',
    // 'ramt': (TransReBillModels_Income[index1][index2].ramt.toString() ==
    //         'null')
    //     ? '-'
    //     : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].ramt!))}',
    // 'ramtd': (TransReBillModels_Income[index1][index2].ramtd.toString() ==
    //         'null')
    //     ? '-'
    //     : '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].ramtd!))}',
    // 'amt':
    //     '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].amt!))}',
    // 'total':
    //     '${nFormat.format(double.parse(TransReBillModels_Income[index1][index2].total!))}',
    // 'sname': (TransReBillModels_Income[index1][index2].sname == null)
    //     ? '${TransReBillModels_Income[index1][index2].remark}'
    //     : '${TransReBillModels_Income[index1][index2].sname}'
    if (Value_Report == 'รายงานรายรับ') {
      // _displayPdf_IncomeReport();
      Pdfgen_IncomeReport.displayPdf_IncomeReport(
          context,
          renTal_name,
          Value_Report,
          Pre_and_Dow,
          _verticalGroupValue_NameFile,
          NameFile_,
          _TransReBillModels_Income,
          TransReBillModels_Income,
          datalist001_Incom,
          bill_addr,
          bill_email,
          bill_tel,
          bill_tax,
          bill_name,
          newValuePDFimg,
          Value_selectDate1,
          Value_selectDate2);
///////////------------------------------>
    } else if (Value_Report == 'รายงานรายจ่าย') {
      // _displayPdf_ExpenseReport();
      Pdfgen_ExpenseReport.displayPdf_ExpenseReport(context, renTal_name,
          Value_Report, Pre_and_Dow, _verticalGroupValue_NameFile, NameFile_);
///////////------------------------------------------>
    } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
      // _displayPdf_BankmovementReport();
      Pdfgen_BankmovementReport.displayPdf_BankmovementReport(
          context,
          renTal_name,
          Value_Report,
          Pre_and_Dow,
          _verticalGroupValue_NameFile,
          NameFile_);
///////////--------------------------------------->
    } else if (Value_Report == 'รายงานภาษี') {
///////////----------------------------------------->
    } else {
      // _displayPdf_DailyReport();
      Pdfgen_DailyReport.displayPdf_DailyReport(
          context,
          renTal_name,
          Value_Report,
          Pre_and_Dow,
          _verticalGroupValue_NameFile,
          NameFile_,
          _TransReBillModels,
          TransReBillModels,
          bill_addr,
          bill_email,
          bill_tel,
          bill_tax,
          bill_name,
          newValuePDFimg,
          Value_selectDate);
    }
  }
//////////------------------------------------>(โหลดเอกสารในโปรเจกต)

  // Future<void> Dload_Document() async {
  //   // Get the file path
  //   var filePath = 'downloadFile/ใบเสนอราคาdownloadFile.pdf';
  //   // Open the file
  //   var bytes = await rootBundle.load(filePath);
  //   // Create a new anchor element
  //   var anchor = AnchorElement(
  //       href: Url.createObjectUrlFromBlob(
  //           Blob([bytes.buffer.asUint8List()], 'application/pdf')))
  //     ..setAttribute("download", "ใบเสนอราคาdownloadFile.pdf")
  //     ..style.display = "none";
  //   // Add the anchor element to the body
  //   document.body!.append(anchor);
  //   // Click the anchor element to start the download
  //   anchor.click();
  //   // Remove the anchor element from the body
  //   anchor.remove();
  // }

//////////////////////////////////----------------------------------------->

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
            Padding(
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
                            'รายงาน',
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
                              _select_StartDate(context);
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
                                    (Value_selectDate1 == null)
                                        ? 'เลือก'
                                        : '$Value_selectDate1',
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
                            'ถึง',
                            style: TextStyle(
                              color: ReportScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _select_EndDate(context);
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
                                    (Value_selectDate2 == null)
                                        ? 'เลือก'
                                        : '$Value_selectDate2',
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
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
                            onTap: (_TransReBillModels_Income.isEmpty)
                                ? null
                                : (TransReBillModels_Income[
                                            _TransReBillModels_Income.length -
                                                1]
                                        .isEmpty)
                                    ? null
                                    : () async {
                                        Insert_log.Insert_logs(
                                            'รายงาน', 'กดดูรายงานรายรับ');
                                        // List show_more = [];
                                        int? show_more;

                                        double Sum_Ramt_ = 0.0;
                                        double Sum_Ramtd_ = 0.0;
                                        double Sum_Amt_ = 0.0;
                                        double Sum_Total_ = 0.0;
                                        double Sum_dis_ = 0.0;

                                        setState(() {
                                          Sum_total_dis = 0.00;
                                        });

                                        for (int indexsum1 = 0;
                                            indexsum1 <
                                                _TransReBillModels_Income
                                                    .length;
                                            indexsum1++) {
                                          Sum_Ramt_ = Sum_Ramt_ +
                                              double.parse(
                                                  (_TransReBillModels_Income[
                                                                  indexsum1]
                                                              .ramt ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Income[
                                                              indexsum1]
                                                          .ramt!);

                                          Sum_Ramtd_ = Sum_Ramtd_ +
                                              double.parse(
                                                  (_TransReBillModels_Income[
                                                                  indexsum1]
                                                              .ramtd ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Income[
                                                              indexsum1]
                                                          .ramtd!);

                                          Sum_Amt_ = Sum_Amt_ +
                                              double.parse(
                                                  (_TransReBillModels_Income[
                                                                  indexsum1]
                                                              .amt ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Income[
                                                              indexsum1]
                                                          .amt!);

                                          Sum_Total_ = Sum_Total_ +
                                              double.parse(
                                                  (_TransReBillModels_Income[
                                                                  indexsum1]
                                                              .total_bill ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Income[
                                                              indexsum1]
                                                          .total_bill!);

                                          Sum_dis_ = (_TransReBillModels_Income[
                                                          indexsum1]
                                                      .total_dis ==
                                                  null)
                                              ? Sum_dis_ + 0.00
                                              : Sum_dis_ +
                                                  (double.parse(
                                                          _TransReBillModels_Income[
                                                                  indexsum1]
                                                              .total_bill!) -
                                                      double.parse(
                                                          _TransReBillModels_Income[
                                                                  indexsum1]
                                                              .total_dis!));

                                          Sum_total_dis = (_TransReBillModels_Income[
                                                          indexsum1]
                                                      .total_dis ==
                                                  null)
                                              ? Sum_total_dis +
                                                  double.parse(
                                                      _TransReBillModels_Income[
                                                              indexsum1]
                                                          .total_bill!)
                                              : Sum_total_dis +
                                                  double.parse(
                                                      _TransReBillModels_Income[
                                                              indexsum1]
                                                          .total_dis!);

                                          // for (int indexsum2 = 0;
                                          //     indexsum2 <
                                          //         TransReBillModels[indexsum1].length;
                                          //     indexsum2++) {
                                          //   Sum_Ramt_ = Sum_Ramt_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .ramt!);
                                          //   Sum_Ramtd_ = Sum_Ramtd_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .ramtd!);
                                          //   Sum_Amt_ = Sum_Amt_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .amt!);
                                          //   Sum_Total_ = Sum_Total_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .total!);
                                          // }
                                        }

                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Column(
                                                children: [
                                                  const Center(
                                                      child: Text(
                                                    'รายงานรายรับ',
                                                    style: TextStyle(
                                                      color: ReportScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  )),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            (Value_selectDate1 ==
                                                                        null &&
                                                                    Value_selectDate2 ==
                                                                        null)
                                                                ? 'วันที่: ? ถึง ?'
                                                                : (Value_selectDate1 ==
                                                                        null)
                                                                    ? 'วันที่: ? ถึง $Value_selectDate2'
                                                                    : (Value_selectDate2 ==
                                                                            null)
                                                                        ? 'วันที่: $Value_selectDate1 ถึง ?'
                                                                        : 'วันที่: $Value_selectDate1 ถึง $Value_selectDate2',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: ReportScreen_Color
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color: ReportScreen_Color
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
                                                      const Duration(
                                                          seconds: 0)),
                                                  builder: (context, snapshot) {
                                                    return ScrollConfiguration(
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
                                                                            'ไม่พบข้อมูล ณ วันที่เลือก',
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
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
                                                                            child:
                                                                                ListView.builder(
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
                                                                                                  // Expanded(
                                                                                                  //   flex: 1,
                                                                                                  //   child: Text(
                                                                                                  //     // '${_TransReBillModels_Income[index1].ramt}',
                                                                                                  //     (_TransReBillModels_Income[index1].ramt == null) ? '' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].ramt!))}',
                                                                                                  //     // '${_TransReBillModels[index1].ramt}',
                                                                                                  //     textAlign: TextAlign.right,
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
                                                                                                  //     // '${_TransReBillModels_Income[index1].ramtd}',
                                                                                                  //     (_TransReBillModels_Income[index1].ramtd == null) ? '' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].ramtd!))}',
                                                                                                  //     //'${nFormat.format(double.parse(_TransReBillModels_Income[index1].ramtd!))}',
                                                                                                  //     //  '${_TransReBillModels[index1].ramtd}',
                                                                                                  //     textAlign: TextAlign.right,
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
                                                                                                      (_TransReBillModels_Income[index1].total_dis == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!) - double.parse(_TransReBillModels_Income[index1].total_dis!))}',
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
                                                                                                      (_TransReBillModels_Income[index1].total_bill == null) ? '' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}',
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
                                                                                                      (_TransReBillModels_Income[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels_Income[index1].total_dis!))}',
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
                                                                                            for (int index2 = 0; index2 < TransReBillModels_Income[index1].length; index2++)
                                                                                              Container(
                                                                                                color: Colors.green[100]!.withOpacity(0.5),
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 20, 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      8,
                                                                      0,
                                                                      20,
                                                                      4),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  // SizedBox(
                                                                  //   height: 120,
                                                                  //   width: 240,
                                                                  //   child:
                                                                  //       Column(
                                                                  //     children: [
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           Expanded(
                                                                  //               child: Container(
                                                                  //             decoration: const BoxDecoration(
                                                                  //               color: AppbackgroundColor.TiTile_Colors,
                                                                  //               borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                  //             ),
                                                                  //             child: const Center(
                                                                  //               child: Text(
                                                                  //                 'รวม',
                                                                  //                 maxLines: 1,
                                                                  //                 textAlign: TextAlign.start,
                                                                  //                 style: TextStyle(
                                                                  //                   color: ReportScreen_Color.Colors_Text1_,
                                                                  //                   fontWeight: FontWeight.bold,
                                                                  //                   fontFamily: FontWeight_.Fonts_T,
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ))
                                                                  //         ],
                                                                  //       ),
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           Expanded(
                                                                  //             flex: 1,
                                                                  //             child: Container(
                                                                  //                 decoration: BoxDecoration(
                                                                  //                   color: Colors.grey[300],
                                                                  //                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                  //                 ),
                                                                  //                 child: Padding(
                                                                  //                   padding: const EdgeInsets.all(4.0),
                                                                  //                   child: const Text(
                                                                  //                     'รวม',
                                                                  //                     maxLines: 1,
                                                                  //                     textAlign: TextAlign.start,
                                                                  //                     style: TextStyle(
                                                                  //                       color: ReportScreen_Color.Colors_Text1_,
                                                                  //                       fontWeight: FontWeight.bold,
                                                                  //                       fontFamily: FontWeight_.Fonts_T,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 )),
                                                                  //           ),
                                                                  //           Expanded(
                                                                  //             flex: 1,
                                                                  //             child: Container(
                                                                  //                 color: Colors.grey[200],
                                                                  //                 child: Padding(
                                                                  //                   padding: const EdgeInsets.all(4.0),
                                                                  //                   child: Text(
                                                                  //                     (Sum_Total_ == null) ? '0.00' : '${nFormat.format(Sum_Total_)}',
                                                                  //                     maxLines: 1,
                                                                  //                     textAlign: TextAlign.end,
                                                                  //                     style: const TextStyle(
                                                                  //                       color: ReportScreen_Color.Colors_Text2_,
                                                                  //                       fontWeight: FontWeight.bold,
                                                                  //                       fontFamily: Font_.Fonts_T,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 )),
                                                                  //           ),
                                                                  //         ],
                                                                  //       ),
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           Expanded(
                                                                  //             flex: 1,
                                                                  //             child: Container(
                                                                  //                 decoration: BoxDecoration(
                                                                  //                   color: Colors.grey[300],
                                                                  //                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                  //                 ),
                                                                  //                 child: Padding(
                                                                  //                   padding: const EdgeInsets.all(4.0),
                                                                  //                   child: const Text(
                                                                  //                     'รวมส่วนลด',
                                                                  //                     maxLines: 1,
                                                                  //                     textAlign: TextAlign.start,
                                                                  //                     style: TextStyle(
                                                                  //                       color: ReportScreen_Color.Colors_Text1_,
                                                                  //                       fontWeight: FontWeight.bold,
                                                                  //                       fontFamily: FontWeight_.Fonts_T,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 )),
                                                                  //           ),
                                                                  //           Expanded(
                                                                  //             flex: 1,
                                                                  //             child: Container(
                                                                  //                 color: Colors.grey[200],
                                                                  //                 child: Padding(
                                                                  //                   padding: const EdgeInsets.all(4.0),
                                                                  //                   child: Text(
                                                                  //                     '${nFormat.format(Sum_total_dis)}',
                                                                  //                     maxLines: 1,
                                                                  //                     textAlign: TextAlign.end,
                                                                  //                     style: const TextStyle(
                                                                  //                       color: ReportScreen_Color.Colors_Text2_,
                                                                  //                       fontWeight: FontWeight.bold,
                                                                  //                       fontFamily: Font_.Fonts_T,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 )),
                                                                  //           ),
                                                                  //         ],
                                                                  //       ),
                                                                  //     ],
                                                                  //   ),
                                                                  // )

                                                                  SizedBox(
                                                                    height: 120,
                                                                    width: (Responsive.isDesktop(
                                                                            context))
                                                                        ? MediaQuery.of(context).size.width *
                                                                            0.9
                                                                        : (_TransReBillModels.length ==
                                                                                0)
                                                                            ? MediaQuery.of(context).size.width
                                                                            : 800,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[600],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
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
                                                                            color:
                                                                                Colors.grey[300],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
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
                                                                                    '${nFormat.format(double.parse('$Sum_dis_'))}',
                                                                                    // '${_TransReBillModels[0].all_sum_expser12}',
                                                                                    //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                                    //  '${_TransReBillModels[index1].ramtd}',
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
                                                                                    '${nFormat.format(double.parse('$Sum_Total_'))}',
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
                                                                                    '${nFormat.format(double.parse('$Sum_total_dis'))}',
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
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius: BorderRadius.only(
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
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'Export file',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          Font_
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
                                                        // if (_TransReBillModels_Income
                                                        //         .length !=
                                                        //     0)
                                                        //   Padding(
                                                        //     padding:
                                                        //         const EdgeInsets.all(8.0),
                                                        //     child: InkWell(
                                                        //       child: Container(
                                                        //         width: 100,
                                                        //         decoration:
                                                        //             const BoxDecoration(
                                                        //           color: Colors.green,
                                                        //           borderRadius:
                                                        //               BorderRadius.only(
                                                        //                   topLeft: Radius
                                                        //                       .circular(
                                                        //                           10),
                                                        //                   topRight: Radius
                                                        //                       .circular(
                                                        //                           10),
                                                        //                   bottomLeft: Radius
                                                        //                       .circular(
                                                        //                           10),
                                                        //                   bottomRight: Radius
                                                        //                       .circular(
                                                        //                           10)),
                                                        //         ),
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //                 8.0),
                                                        //         child: const Center(
                                                        //           child: Text(
                                                        //             'Print',
                                                        //             style: TextStyle(
                                                        //               color: Colors.white,
                                                        //               fontWeight:
                                                        //                   FontWeight.bold,
                                                        //               fontFamily:
                                                        //                   Font_.Fonts_T,
                                                        //             ),
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //       onTap: () async {
                                                        //         setState(() {
                                                        //           Value_Report =
                                                        //               'รายงานรายรับ';
                                                        //           Pre_and_Dow = 'Preview';
                                                        //         });
                                                        //         Navigator.pop(context);

                                                        //         _displayPdf_();
                                                        //       },
                                                        //     ),
                                                        //   ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
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
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'ปิด',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              check_clear();
                                                              Navigator.of(
                                                                      context)
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
                          (_TransReBillModels_Income.isEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_selectDate2 != null &&
                                            _TransReBillModels_Income.isEmpty)
                                        ? 'รายงานรายรับ (ไม่พบข้อมูล ✖️)'
                                        : 'รายงานรายรับ',
                                    // 'รายงานรายรับ',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                )
                              : (TransReBillModels_Income[
                                          _TransReBillModels_Income.length - 1]
                                      .isEmpty)
                                  ? SizedBox(
                                      // height: 20,
                                      child: Row(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(4.0),
                                            child:
                                                const CircularProgressIndicator()),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'กำลังโหลดรายงานรายรับ...',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text2_,
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
                                        'รายงานรายรับ ✔️',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
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
                    //           child: Center(
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: const [
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
                    //         onTap: () async {
                    //           Insert_log.Insert_logs(
                    //               'รายงาน', 'กดดูรายงานรายจ่าย');
                    //           showDialog<void>(
                    //             context: context,
                    //             barrierDismissible:
                    //                 false, // user must tap button!
                    //             builder: (BuildContext context) {
                    //               return AlertDialog(
                    //                 shape: const RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.all(
                    //                         Radius.circular(20.0))),
                    //                 title: Column(
                    //                   children: [
                    //                     const Center(
                    //                         child: Text(
                    //                       'รายงานรายจ่าย',
                    //                       style: TextStyle(
                    //                         color: ReportScreen_Color
                    //                             .Colors_Text1_,
                    //                         fontWeight: FontWeight.bold,
                    //                         fontFamily: FontWeight_.Fonts_T,
                    //                       ),
                    //                     )),
                    //                     Row(
                    //                       children: [
                    //                         Expanded(
                    //                             flex: 1,
                    //                             child: Text(
                    //                               'วันที่: $Value_selectDate1 ถึง  $Value_selectDate2',
                    //                               textAlign: TextAlign.start,
                    //                               style: const TextStyle(
                    //                                 color: ReportScreen_Color
                    //                                     .Colors_Text1_,
                    //                                 fontSize: 14,
                    //                                 // fontWeight: FontWeight.bold,
                    //                                 fontFamily:
                    //                                     FontWeight_.Fonts_T,
                    //                               ),
                    //                             )),
                    //                         const Expanded(
                    //                             flex: 1,
                    //                             child: Text(
                    //                               'ทั้งหมด: ',
                    //                               textAlign: TextAlign.end,
                    //                               style: TextStyle(
                    //                                 fontSize: 14,
                    //                                 color: ReportScreen_Color
                    //                                     .Colors_Text1_,
                    //                                 // fontWeight: FontWeight.bold,
                    //                                 fontFamily:
                    //                                     FontWeight_.Fonts_T,
                    //                               ),
                    //                             )),
                    //                       ],
                    //                     ),
                    //                     const SizedBox(height: 1),
                    //                     const Divider(),
                    //                     const SizedBox(height: 1),
                    //                   ],
                    //                 ),
                    //                 content: ScrollConfiguration(
                    //                   behavior: ScrollConfiguration.of(context)
                    //                       .copyWith(dragDevices: {
                    //                     PointerDeviceKind.touch,
                    //                     PointerDeviceKind.mouse,
                    //                   }),
                    //                   child: SingleChildScrollView(
                    //                     scrollDirection: Axis.horizontal,
                    //                     child: Row(
                    //                       children: [
                    //                         Container(
                    //                           color: Colors.grey[50],
                    //                           width: (Responsive.isDesktop(
                    //                                   context))
                    //                               ? MediaQuery.of(context)
                    //                                       .size
                    //                                       .width *
                    //                                   0.9
                    //                               : 800,
                    //                           child: Column(
                    //                             children: <Widget>[
                    //                               Container(
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: AppbackgroundColor
                    //                                       .TiTile_Colors,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(5),
                    //                                           topRight: Radius
                    //                                               .circular(5),
                    //                                           bottomLeft: Radius
                    //                                               .circular(0),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         4.0),
                    //                                 child: Row(
                    //                                   children: const [
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'ลำดับ',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 3,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'รายการ',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'xxxxx',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'xxxxx',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                               Container(
                    //                                   width: (Responsive
                    //                                           .isDesktop(
                    //                                               context))
                    //                                       ? MediaQuery.of(
                    //                                                   context)
                    //                                               .size
                    //                                               .width *
                    //                                           0.9
                    //                                       : 800,
                    //                                   height:
                    //                                       MediaQuery.of(context)
                    //                                               .size
                    //                                               .height *
                    //                                           0.3,
                    //                                   child: ListView.builder(
                    //                                     itemCount: 5,
                    //                                     itemBuilder:
                    //                                         (BuildContext
                    //                                                 context,
                    //                                             int index) {
                    //                                       return ListTile(
                    //                                         title: Row(
                    //                                           children: [
                    //                                             Expanded(
                    //                                               flex: 1,
                    //                                               child:
                    //                                                   Container(
                    //                                                 child: Center(
                    //                                                     child: Text(
                    //                                                   '${index + 1}',
                    //                                                   maxLines:
                    //                                                       1,
                    //                                                   style:
                    //                                                       const TextStyle(
                    //                                                     color: ReportScreen_Color
                    //                                                         .Colors_Text1_,
                    //                                                     fontWeight:
                    //                                                         FontWeight.bold,
                    //                                                     fontFamily:
                    //                                                         FontWeight_.Fonts_T,
                    //                                                   ),
                    //                                                 )),
                    //                                               ),
                    //                                             ),
                    //                                             Expanded(
                    //                                               flex: 3,
                    //                                               child:
                    //                                                   Container(
                    //                                                 child: const Center(
                    //                                                     child: Text(
                    //                                                   'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                    //                                                   maxLines:
                    //                                                       1,
                    //                                                   style:
                    //                                                       TextStyle(
                    //                                                     color: ReportScreen_Color
                    //                                                         .Colors_Text1_,
                    //                                                     fontWeight:
                    //                                                         FontWeight.bold,
                    //                                                     fontFamily:
                    //                                                         FontWeight_.Fonts_T,
                    //                                                   ),
                    //                                                 )),
                    //                                               ),
                    //                                             ),
                    //                                             Expanded(
                    //                                               flex: 1,
                    //                                               child:
                    //                                                   Container(
                    //                                                 child: const Center(
                    //                                                     child: Text(
                    //                                                   '300000',
                    //                                                   maxLines:
                    //                                                       1,
                    //                                                   style:
                    //                                                       TextStyle(
                    //                                                     color: ReportScreen_Color
                    //                                                         .Colors_Text1_,
                    //                                                     fontWeight:
                    //                                                         FontWeight.bold,
                    //                                                     fontFamily:
                    //                                                         FontWeight_.Fonts_T,
                    //                                                   ),
                    //                                                 )),
                    //                                               ),
                    //                                             ),
                    //                                             Expanded(
                    //                                               flex: 1,
                    //                                               child:
                    //                                                   Container(
                    //                                                 child: const Center(
                    //                                                     child: Text(
                    //                                                   '400000',
                    //                                                   maxLines:
                    //                                                       1,
                    //                                                   style:
                    //                                                       TextStyle(
                    //                                                     color: ReportScreen_Color
                    //                                                         .Colors_Text1_,
                    //                                                     fontWeight:
                    //                                                         FontWeight.bold,
                    //                                                     fontFamily:
                    //                                                         FontWeight_.Fonts_T,
                    //                                                   ),
                    //                                                 )),
                    //                                               ),
                    //                                             ),
                    //                                           ],
                    //                                         ),
                    //                                       );
                    //                                     },
                    //                                   )),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 actions: <Widget>[
                    //                   Padding(
                    //                     padding: const EdgeInsets.fromLTRB(
                    //                         8, 0, 20, 4),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.end,
                    //                       children: [
                    //                         SizedBox(
                    //                           height: 120,
                    //                           width: 240,
                    //                           child: Column(
                    //                             children: [
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                       child: Container(
                    //                                     decoration:
                    //                                         const BoxDecoration(
                    //                                       color:
                    //                                           AppbackgroundColor
                    //                                               .TiTile_Colors,
                    //                                       borderRadius: BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(5),
                    //                                           topRight: Radius
                    //                                               .circular(5),
                    //                                           bottomLeft: Radius
                    //                                               .circular(0),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                     ),
                    //                                     child: const Center(
                    //                                       child: Text(
                    //                                         'รวม',
                    //                                         maxLines: 1,
                    //                                         textAlign:
                    //                                             TextAlign.start,
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ))
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           color: Colors
                    //                                               .grey[300],
                    //                                           borderRadius: const BorderRadius
                    //                                                   .only(
                    //                                               topLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               topRight: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomRight: Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                         ),
                    //                                         child: const Text(
                    //                                           'รวม 70%',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign
                    //                                                   .start,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text1_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily:
                    //                                                 FontWeight_
                    //                                                     .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         color: Colors
                    //                                             .grey[200],
                    //                                         child: const Text(
                    //                                           'xxxxx',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign.end,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text2_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily: Font_
                    //                                                 .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           color: Colors
                    //                                               .grey[300],
                    //                                           borderRadius: const BorderRadius
                    //                                                   .only(
                    //                                               topLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               topRight: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomRight: Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                         ),
                    //                                         child: const Text(
                    //                                           'รวม 30%',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign
                    //                                                   .start,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text1_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily:
                    //                                                 FontWeight_
                    //                                                     .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         color: Colors
                    //                                             .grey[200],
                    //                                         child: const Text(
                    //                                           'xxxxx',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign.end,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text2_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily: Font_
                    //                                                 .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               // Row(
                    //                               //   children: [
                    //                               //     Expanded(
                    //                               //       flex: 1,
                    //                               //       child: Container(
                    //                               //           decoration:
                    //                               //               BoxDecoration(
                    //                               //             color: Colors
                    //                               //                 .grey[300],
                    //                               //             borderRadius: const BorderRadius
                    //                               //                     .only(
                    //                               //                 topLeft: Radius
                    //                               //                     .circular(
                    //                               //                         0),
                    //                               //                 topRight: Radius
                    //                               //                     .circular(
                    //                               //                         0),
                    //                               //                 bottomLeft: Radius
                    //                               //                     .circular(
                    //                               //                         0),
                    //                               //                 bottomRight: Radius
                    //                               //                     .circular(
                    //                               //                         0)),
                    //                               //           ),
                    //                               //           child: const Text(
                    //                               //             'รวมราคาก่อน Vat',
                    //                               //             maxLines: 1,
                    //                               //             textAlign:
                    //                               //                 TextAlign
                    //                               //                     .start,
                    //                               //             style: TextStyle(
                    //                               //               color: ReportScreen_Color
                    //                               //                   .Colors_Text1_,
                    //                               //               fontWeight:
                    //                               //                   FontWeight
                    //                               //                       .bold,
                    //                               //               fontFamily:
                    //                               //                   FontWeight_
                    //                               //                       .Fonts_T,
                    //                               //             ),
                    //                               //           )),
                    //                               //     ),
                    //                               //     Expanded(
                    //                               //       flex: 1,
                    //                               //       child: Container(
                    //                               //           color: Colors
                    //                               //               .grey[200],
                    //                               //           child: const Text(
                    //                               //             'xxxxxx',
                    //                               //             maxLines: 1,
                    //                               //             textAlign:
                    //                               //                 TextAlign.end,
                    //                               //             style: TextStyle(
                    //                               //               color: ReportScreen_Color
                    //                               //                   .Colors_Text2_,
                    //                               //               fontWeight:
                    //                               //                   FontWeight
                    //                               //                       .bold,
                    //                               //               fontFamily: Font_
                    //                               //                   .Fonts_T,
                    //                               //             ),
                    //                               //           )),
                    //                               //     ),
                    //                               //   ],
                    //                               // ),
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           color: Colors
                    //                                               .grey[300],
                    //                                           borderRadius: const BorderRadius
                    //                                                   .only(
                    //                                               topLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               topRight: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomRight: Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                         ),
                    //                                         child: const Text(
                    //                                           'รวม',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign
                    //                                                   .start,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text1_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily:
                    //                                                 FontWeight_
                    //                                                     .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         color: Colors
                    //                                             .grey[200],
                    //                                         child: const Text(
                    //                                           'xxxxxxx',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign.end,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text2_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily: Font_
                    //                                                 .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 1),
                    //                   const Divider(),
                    //                   const SizedBox(height: 1),
                    //                   Padding(
                    //                     padding: const EdgeInsets.fromLTRB(
                    //                         8, 4, 8, 4),
                    //                     child: SingleChildScrollView(
                    //                       scrollDirection: Axis.horizontal,
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.end,
                    //                         children: [
                    //                           Padding(
                    //                             padding:
                    //                                 const EdgeInsets.all(8.0),
                    //                             child: InkWell(
                    //                               child: Container(
                    //                                 width: 100,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: Colors.blue,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(10),
                    //                                           topRight: Radius
                    //                                               .circular(10),
                    //                                           bottomLeft: Radius
                    //                                               .circular(10),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       10)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: const Center(
                    //                                   child: Text(
                    //                                     'Export file',
                    //                                     style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       fontFamily:
                    //                                           Font_.Fonts_T,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               onTap: () async {
                    //                                 setState(() {
                    //                                   Value_Report =
                    //                                       'รายงานรายจ่าย';
                    //                                   Pre_and_Dow = 'Download';
                    //                                 });
                    //                                 Navigator.pop(context);
                    //                                 _showMyDialog_SAVE();
                    //                               },
                    //                             ),
                    //                           ),
                    //                           // Padding(
                    //                           //   padding:
                    //                           //       const EdgeInsets.all(8.0),
                    //                           //   child: InkWell(
                    //                           //     child: Container(
                    //                           //       width: 100,
                    //                           //       decoration:
                    //                           //           const BoxDecoration(
                    //                           //         color: Colors.green,
                    //                           //         borderRadius:
                    //                           //             BorderRadius.only(
                    //                           //                 topLeft: Radius
                    //                           //                     .circular(10),
                    //                           //                 topRight: Radius
                    //                           //                     .circular(10),
                    //                           //                 bottomLeft: Radius
                    //                           //                     .circular(10),
                    //                           //                 bottomRight:
                    //                           //                     Radius
                    //                           //                         .circular(
                    //                           //                             10)),
                    //                           //       ),
                    //                           //       padding:
                    //                           //           const EdgeInsets.all(
                    //                           //               8.0),
                    //                           //       child: const Center(
                    //                           //         child: Text(
                    //                           //           'Print',
                    //                           //           style: TextStyle(
                    //                           //             color: Colors.white,
                    //                           //             fontWeight:
                    //                           //                 FontWeight.bold,
                    //                           //             fontFamily:
                    //                           //                 Font_.Fonts_T,
                    //                           //           ),
                    //                           //         ),
                    //                           //       ),
                    //                           //     ),
                    //                           //     onTap: () async {
                    //                           //       setState(() {
                    //                           //         Value_Report =
                    //                           //             'รายงานรายจ่าย';
                    //                           //         Pre_and_Dow = 'Preview';
                    //                           //       });
                    //                           //       Navigator.pop(context);

                    //                           //       _displayPdf_();
                    //                           //     },
                    //                           //   ),
                    //                           // ),
                    //                           Padding(
                    //                             padding:
                    //                                 const EdgeInsets.all(8.0),
                    //                             child: InkWell(
                    //                               child: Container(
                    //                                 width: 100,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: Colors.black,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(10),
                    //                                           topRight: Radius
                    //                                               .circular(10),
                    //                                           bottomLeft: Radius
                    //                                               .circular(10),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       10)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: const Center(
                    //                                   child: Text(
                    //                                     'ปิด',
                    //                                     style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       fontFamily:
                    //                                           Font_.Fonts_T,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               onTap: () {
                    //                                 Navigator.of(context).pop();
                    //                               },
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               );
                    //             },
                    //           );
                    //         },
                    //       ),
                    //       const Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: Text(
                    //           'รายงานรายจ่าย',
                    //           style: TextStyle(
                    //             color: ReportScreen_Color.Colors_Text2_,
                    //             // fontWeight: FontWeight.bold,
                    //             fontFamily: Font_.Fonts_T,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
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
                            ), //TransReBillModels_Bankmovemen
                            onTap: (_TransReBillModels_Bankmovemen.isEmpty)
                                ? null
                                : (TransReBillModels_Bankmovemen[
                                                _TransReBillModels_Bankmovemen
                                                        .length -
                                                    1]
                                            .length ==
                                        0)
                                    ? null
                                    : () async {
                                        Insert_log.Insert_logs('รายงาน',
                                            'กดดูรายงานการเคลื่อนไหวธนาคาร');
                                        // List show_more = [];
                                        int? show_more;

                                        double Sum_Ramt_ = 0.0;
                                        double Sum_Ramtd_ = 0.0;
                                        double Sum_Amt_ = 0.0;
                                        double Sum_Total_ = 0.0;
                                        double Sum_dis_ = 0.0;

                                        setState(() {
                                          Sum_total_dis = 0.00;
                                        });

                                        for (int indexsum1 = 0;
                                            indexsum1 <
                                                _TransReBillModels_Bankmovemen
                                                    .length;
                                            indexsum1++) {
                                          Sum_Ramt_ = Sum_Ramt_ +
                                              double.parse(
                                                  (_TransReBillModels_Bankmovemen[
                                                                  indexsum1]
                                                              .ramt ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Bankmovemen[
                                                              indexsum1]
                                                          .ramt!);

                                          Sum_Ramtd_ = Sum_Ramtd_ +
                                              double.parse(
                                                  (_TransReBillModels_Bankmovemen[
                                                                  indexsum1]
                                                              .ramtd ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Bankmovemen[
                                                              indexsum1]
                                                          .ramtd!);

                                          Sum_Amt_ = Sum_Amt_ +
                                              double.parse(
                                                  (_TransReBillModels_Bankmovemen[
                                                                  indexsum1]
                                                              .amt ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Bankmovemen[
                                                              indexsum1]
                                                          .amt!);

                                          Sum_Total_ = Sum_Total_ +
                                              double.parse(
                                                  (_TransReBillModels_Bankmovemen[
                                                                  indexsum1]
                                                              .total_bill ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels_Bankmovemen[
                                                              indexsum1]
                                                          .total_bill!);

                                          Sum_dis_ = (_TransReBillModels_Bankmovemen[
                                                          indexsum1]
                                                      .total_dis ==
                                                  null)
                                              ? Sum_dis_ + 0.00
                                              : Sum_dis_ +
                                                  (double.parse(
                                                          _TransReBillModels_Bankmovemen[
                                                                  indexsum1]
                                                              .total_bill!) -
                                                      double.parse(
                                                          _TransReBillModels_Bankmovemen[
                                                                  indexsum1]
                                                              .total_dis!));

                                          Sum_total_dis = (_TransReBillModels_Bankmovemen[
                                                          indexsum1]
                                                      .total_dis ==
                                                  null)
                                              ? Sum_total_dis +
                                                  double.parse(
                                                      _TransReBillModels_Bankmovemen[
                                                              indexsum1]
                                                          .total_bill!)
                                              : Sum_total_dis +
                                                  double.parse(
                                                      _TransReBillModels_Bankmovemen[
                                                              indexsum1]
                                                          .total_dis!);
                                          // for (int indexsum2 = 0;
                                          //     indexsum2 <
                                          //         TransReBillModels[indexsum1].length;
                                          //     indexsum2++) {
                                          //   Sum_Ramt_ = Sum_Ramt_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .ramt!);
                                          //   Sum_Ramtd_ = Sum_Ramtd_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .ramtd!);
                                          //   Sum_Amt_ = Sum_Amt_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .amt!);
                                          //   Sum_Total_ = Sum_Total_ +
                                          //       double.parse(TransReBillModels[indexsum1]
                                          //               [indexsum2]
                                          //           .total!);
                                          // }
                                        }

                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Column(
                                                children: [
                                                  const Center(
                                                      child: Text(
                                                    'รายงานการเคลื่อนไหวธนาคาร',
                                                    style: TextStyle(
                                                      color: ReportScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  )),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            (Value_selectDate1 ==
                                                                        null &&
                                                                    Value_selectDate2 ==
                                                                        null)
                                                                ? 'วันที่: ? ถึง ?'
                                                                : (Value_selectDate1 ==
                                                                        null)
                                                                    ? 'วันที่: ? ถึง $Value_selectDate2'
                                                                    : (Value_selectDate2 ==
                                                                            null)
                                                                        ? 'วันที่: $Value_selectDate1 ถึง ?'
                                                                        : 'วันที่: $Value_selectDate1 ถึง $Value_selectDate2',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: ReportScreen_Color
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color: ReportScreen_Color
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
                                                      const Duration(
                                                          seconds: 0)),
                                                  builder: (context, snapshot) {
                                                    return ScrollConfiguration(
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
                                                                            'ไม่พบข้อมูล ณ วันที่เลือก',
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
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
                                                                            child:
                                                                                ListView.builder(
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
                                                                                            for (int index2 = 0; index2 < TransReBillModels_Bankmovemen[index1].length; index2++)
                                                                                              Container(
                                                                                                color: Colors.green[100]!.withOpacity(0.5),
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 20, 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      StreamBuilder(
                                                          stream:
                                                              Stream.periodic(
                                                                  const Duration(
                                                                      seconds:
                                                                          0)),
                                                          builder: (context,
                                                              snapshot) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      8,
                                                                      0,
                                                                      20,
                                                                      4),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  // SizedBox(
                                                                  //   height: 120,
                                                                  //   width: (Responsive.isDesktop(
                                                                  //           context))
                                                                  //       ? 240
                                                                  //       : 230,
                                                                  //   child:
                                                                  //       Column(
                                                                  //     children: [
                                                                  //       Row(
                                                                  //         children: [
                                                                  //           Expanded(
                                                                  //               child: Container(
                                                                  //             decoration: const BoxDecoration(
                                                                  //               color: AppbackgroundColor.TiTile_Colors,
                                                                  //               borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                  //             ),
                                                                  //             child: const Center(
                                                                  //               child: Text(
                                                                  //                 'รวม',
                                                                  //                 maxLines: 1,
                                                                  //                 textAlign: TextAlign.start,
                                                                  //                 style: TextStyle(
                                                                  //                   color: ReportScreen_Color.Colors_Text1_,
                                                                  //                   fontWeight: FontWeight.bold,
                                                                  //                   fontFamily: FontWeight_.Fonts_T,
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ))
                                                                  //         ],
                                                                  //       ),

                                                                  //       Row(
                                                                  //         children: [
                                                                  //           Expanded(
                                                                  //             flex: 1,
                                                                  //             child: Container(
                                                                  //                 decoration: BoxDecoration(
                                                                  //                   color: Colors.grey[300],
                                                                  //                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                  //                 ),
                                                                  //                 child: const Padding(
                                                                  //                   padding: EdgeInsets.all(8.0),
                                                                  //                   child: Text(
                                                                  //                     'รวม',
                                                                  //                     maxLines: 1,
                                                                  //                     textAlign: TextAlign.start,
                                                                  //                     style: TextStyle(
                                                                  //                       color: ReportScreen_Color.Colors_Text1_,
                                                                  //                       fontWeight: FontWeight.bold,
                                                                  //                       fontFamily: FontWeight_.Fonts_T,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 )),
                                                                  //           ),
                                                                  //           Expanded(
                                                                  //             flex: 2,
                                                                  //             child: Container(
                                                                  //                 color: Colors.grey[200],
                                                                  //                 child: Padding(
                                                                  //                   padding: const EdgeInsets.all(8.0),
                                                                  //                   child: Text(
                                                                  //                     (Sum_Total_ == null) ? '0.00' : '${nFormat.format(Sum_Total_)}',
                                                                  //                     maxLines: 2,
                                                                  //                     textAlign: TextAlign.end,
                                                                  //                     style: const TextStyle(
                                                                  //                       color: ReportScreen_Color.Colors_Text2_,
                                                                  //                       fontWeight: FontWeight.bold,
                                                                  //                       fontFamily: Font_.Fonts_T,
                                                                  //                     ),
                                                                  //                   ),
                                                                  //                 )),
                                                                  //           ),
                                                                  //         ],
                                                                  //       ),
                                                                  //     ],
                                                                  //   ),
                                                                  // )

                                                                  SizedBox(
                                                                    height: 120,
                                                                    width: (Responsive.isDesktop(
                                                                            context))
                                                                        ? MediaQuery.of(context).size.width *
                                                                            0.9
                                                                        : (_TransReBillModels.length ==
                                                                                0)
                                                                            ? MediaQuery.of(context).size.width
                                                                            : 800,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey[600],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
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
                                                                            color:
                                                                                Colors.grey[300],
                                                                            borderRadius: const BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
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
                                                                                    '${nFormat.format(double.parse('$Sum_dis_'))}',
                                                                                    // '${_TransReBillModels[0].all_sum_expser12}',
                                                                                    //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                                    //  '${_TransReBillModels[index1].ramtd}',
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
                                                                                    '${nFormat.format(double.parse('$Sum_Total_'))}',
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
                                                                                    '${nFormat.format(double.parse('$Sum_total_dis'))}',
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
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius: BorderRadius.only(
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
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'Export file',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          Font_
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
                                                        // if (_TransReBillModels_Bankmovemen
                                                        //         .length !=
                                                        //     0)
                                                        //   Padding(
                                                        //     padding:
                                                        //         const EdgeInsets.all(8.0),
                                                        //     child: InkWell(
                                                        //       child: Container(
                                                        //         width: 100,
                                                        //         decoration:
                                                        //             const BoxDecoration(
                                                        //           color: Colors.green,
                                                        //           borderRadius:
                                                        //               BorderRadius.only(
                                                        //                   topLeft: Radius
                                                        //                       .circular(
                                                        //                           10),
                                                        //                   topRight: Radius
                                                        //                       .circular(
                                                        //                           10),
                                                        //                   bottomLeft: Radius
                                                        //                       .circular(
                                                        //                           10),
                                                        //                   bottomRight: Radius
                                                        //                       .circular(
                                                        //                           10)),
                                                        //         ),
                                                        //         padding:
                                                        //             const EdgeInsets.all(
                                                        //                 8.0),
                                                        //         child: const Center(
                                                        //           child: Text(
                                                        //             'Print',
                                                        //             style: TextStyle(
                                                        //               color: Colors.white,
                                                        //               fontWeight:
                                                        //                   FontWeight.bold,
                                                        //               fontFamily:
                                                        //                   Font_.Fonts_T,
                                                        //             ),
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //       onTap: () async {
                                                        //         setState(() {
                                                        //           Value_Report =
                                                        //               'รายงานการเคลื่อนไหวธนาคาร';
                                                        //           Pre_and_Dow = 'Preview';
                                                        //         });
                                                        //         Navigator.pop(context);

                                                        //         _displayPdf_();
                                                        //       },
                                                        //     ),
                                                        //   ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
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
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'ปิด',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              check_clear();
                                                              Navigator.of(
                                                                      context)
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
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Text(
                          //     'รายงานการเคลื่อนไหวธนาคาร',
                          //     style: TextStyle(
                          //       color: ReportScreen_Color.Colors_Text2_,
                          //       // fontWeight: FontWeight.bold,
                          //       fontFamily: Font_.Fonts_T,
                          //     ),
                          //   ),
                          // ),
                          (_TransReBillModels_Bankmovemen.isEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_selectDate2 != null &&
                                            _TransReBillModels_Bankmovemen
                                                .isEmpty)
                                        ? 'รายงานการเคลื่อนไหวธนาคาร (ไม่พบข้อมูล ✖️)'
                                        : 'รายงานการเคลื่อนไหวธนาคาร',
                                    //  'รายงานการเคลื่อนไหวธนาคาร',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                )
                              : (TransReBillModels_Bankmovemen[
                                          _TransReBillModels_Bankmovemen
                                                  .length -
                                              1]
                                      .isEmpty)
                                  ? SizedBox(
                                      // height: 20,
                                      child: Row(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(4.0),
                                            child:
                                                const CircularProgressIndicator()),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'กำลังโหลดรายงานการเคลื่อนไหวธนาคาร...',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text2_,
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
                                        'รายงานการเคลื่อนไหวธนาคาร ✔️',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
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
                    //           child: Center(
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: const [
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
                    //         onTap: () {
                    //           Insert_log.Insert_logs(
                    //               'รายงาน', 'กดดูรายงานภาษี');
                    //           showDialog<void>(
                    //             context: context,
                    //             barrierDismissible:
                    //                 false, // user must tap button!
                    //             builder: (BuildContext context) {
                    //               return AlertDialog(
                    //                 shape: const RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.all(
                    //                         Radius.circular(20.0))),
                    //                 title: Column(
                    //                   children: [
                    //                     const Center(
                    //                         child: Text(
                    //                       'รายงานภาษี',
                    //                       style: TextStyle(
                    //                         color: ReportScreen_Color
                    //                             .Colors_Text1_,
                    //                         fontWeight: FontWeight.bold,
                    //                         fontFamily: FontWeight_.Fonts_T,
                    //                       ),
                    //                     )),
                    //                     Row(
                    //                       children: [
                    //                         Expanded(
                    //                             flex: 1,
                    //                             child: Text(
                    //                               'วันที่: $Value_selectDate1 ถึง  $Value_selectDate2',
                    //                               textAlign: TextAlign.start,
                    //                               style: const TextStyle(
                    //                                 color: ReportScreen_Color
                    //                                     .Colors_Text1_,
                    //                                 fontSize: 14,
                    //                                 // fontWeight: FontWeight.bold,
                    //                                 fontFamily:
                    //                                     FontWeight_.Fonts_T,
                    //                               ),
                    //                             )),
                    //                         const Expanded(
                    //                             flex: 1,
                    //                             child: Text(
                    //                               'ทั้งหมด: ',
                    //                               textAlign: TextAlign.end,
                    //                               style: TextStyle(
                    //                                 fontSize: 14,
                    //                                 color: ReportScreen_Color
                    //                                     .Colors_Text1_,
                    //                                 // fontWeight: FontWeight.bold,
                    //                                 fontFamily:
                    //                                     FontWeight_.Fonts_T,
                    //                               ),
                    //                             )),
                    //                       ],
                    //                     ),
                    //                     const SizedBox(height: 1),
                    //                     const Divider(),
                    //                     const SizedBox(height: 1),
                    //                   ],
                    //                 ),
                    //                 content: ScrollConfiguration(
                    //                   behavior: ScrollConfiguration.of(context)
                    //                       .copyWith(dragDevices: {
                    //                     PointerDeviceKind.touch,
                    //                     PointerDeviceKind.mouse,
                    //                   }),
                    //                   child: SingleChildScrollView(
                    //                     scrollDirection: Axis.horizontal,
                    //                     child: Row(
                    //                       children: [
                    //                         Container(
                    //                           color: Colors.grey[50],
                    //                           width: (Responsive.isDesktop(
                    //                                   context))
                    //                               ? MediaQuery.of(context)
                    //                                       .size
                    //                                       .width *
                    //                                   0.9
                    //                               : 800,
                    //                           // height:
                    //                           //     MediaQuery.of(context).size.height *
                    //                           //         0.3,
                    //                           child: Column(
                    //                             children: <Widget>[
                    //                               Container(
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: AppbackgroundColor
                    //                                       .TiTile_Colors,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(5),
                    //                                           topRight: Radius
                    //                                               .circular(5),
                    //                                           bottomLeft: Radius
                    //                                               .circular(0),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         4.0),
                    //                                 child: Row(
                    //                                   children: const [
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'ลำดับ',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 3,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'รายการ',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'วันที่',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'XXXX',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 1,
                    //                                       child: Center(
                    //                                           child: Text(
                    //                                         'XXX',
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       )),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                               Container(
                    //                                 width: (Responsive
                    //                                         .isDesktop(context))
                    //                                     ? MediaQuery.of(context)
                    //                                             .size
                    //                                             .width *
                    //                                         0.9
                    //                                     : 800,
                    //                                 height:
                    //                                     MediaQuery.of(context)
                    //                                             .size
                    //                                             .height *
                    //                                         0.3,
                    //                                 child: ListView.builder(
                    //                                   itemCount: 5,
                    //                                   itemBuilder:
                    //                                       (BuildContext context,
                    //                                           int index) {
                    //                                     return ListTile(
                    //                                       title: Row(
                    //                                         children: [
                    //                                           Expanded(
                    //                                             flex: 1,
                    //                                             child: Center(
                    //                                                 child: Text(
                    //                                               '${index + 1}',
                    //                                               style:
                    //                                                   const TextStyle(
                    //                                                 color: ReportScreen_Color
                    //                                                     .Colors_Text1_,
                    //                                                 fontWeight:
                    //                                                     FontWeight
                    //                                                         .bold,
                    //                                                 fontFamily:
                    //                                                     FontWeight_
                    //                                                         .Fonts_T,
                    //                                               ),
                    //                                             )),
                    //                                           ),
                    //                                           const Expanded(
                    //                                             flex: 2,
                    //                                             child: Center(
                    //                                                 child: Text(
                    //                                               'XXX',
                    //                                               style:
                    //                                                   TextStyle(
                    //                                                 color: ReportScreen_Color
                    //                                                     .Colors_Text1_,
                    //                                                 fontWeight:
                    //                                                     FontWeight
                    //                                                         .bold,
                    //                                                 fontFamily:
                    //                                                     FontWeight_
                    //                                                         .Fonts_T,
                    //                                               ),
                    //                                             )),
                    //                                           ),
                    //                                           const Expanded(
                    //                                             flex: 1,
                    //                                             child: Center(
                    //                                                 child: Text(
                    //                                               'XXX',
                    //                                               style:
                    //                                                   TextStyle(
                    //                                                 color: ReportScreen_Color
                    //                                                     .Colors_Text1_,
                    //                                                 fontWeight:
                    //                                                     FontWeight
                    //                                                         .bold,
                    //                                                 fontFamily:
                    //                                                     FontWeight_
                    //                                                         .Fonts_T,
                    //                                               ),
                    //                                             )),
                    //                                           ),
                    //                                           const Expanded(
                    //                                             flex: 1,
                    //                                             child: Center(
                    //                                                 child: Text(
                    //                                               'XXX',
                    //                                               style:
                    //                                                   TextStyle(
                    //                                                 color: ReportScreen_Color
                    //                                                     .Colors_Text1_,
                    //                                                 fontWeight:
                    //                                                     FontWeight
                    //                                                         .bold,
                    //                                                 fontFamily:
                    //                                                     FontWeight_
                    //                                                         .Fonts_T,
                    //                                               ),
                    //                                             )),
                    //                                           ),
                    //                                           const Expanded(
                    //                                             flex: 1,
                    //                                             child: Center(
                    //                                                 child: Text(
                    //                                               'XXXX',
                    //                                               style:
                    //                                                   TextStyle(
                    //                                                 color: ReportScreen_Color
                    //                                                     .Colors_Text1_,
                    //                                                 fontWeight:
                    //                                                     FontWeight
                    //                                                         .bold,
                    //                                                 fontFamily:
                    //                                                     FontWeight_
                    //                                                         .Fonts_T,
                    //                                               ),
                    //                                             )),
                    //                                           ),
                    //                                         ],
                    //                                       ),
                    //                                     );
                    //                                   },
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 actions: <Widget>[
                    //                   Padding(
                    //                     padding: const EdgeInsets.fromLTRB(
                    //                         8, 0, 20, 4),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.end,
                    //                       children: [
                    //                         SizedBox(
                    //                           height: 120,
                    //                           width: 240,
                    //                           child: Column(
                    //                             children: [
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                       child: Container(
                    //                                     decoration:
                    //                                         const BoxDecoration(
                    //                                       color:
                    //                                           AppbackgroundColor
                    //                                               .TiTile_Colors,
                    //                                       borderRadius: BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(5),
                    //                                           topRight: Radius
                    //                                               .circular(5),
                    //                                           bottomLeft: Radius
                    //                                               .circular(0),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                     ),
                    //                                     child: const Center(
                    //                                       child: Text(
                    //                                         'รวม',
                    //                                         maxLines: 1,
                    //                                         textAlign:
                    //                                             TextAlign.start,
                    //                                         style: TextStyle(
                    //                                           color: ReportScreen_Color
                    //                                               .Colors_Text1_,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .bold,
                    //                                           fontFamily:
                    //                                               FontWeight_
                    //                                                   .Fonts_T,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ))
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           color: Colors
                    //                                               .grey[300],
                    //                                           borderRadius: const BorderRadius
                    //                                                   .only(
                    //                                               topLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               topRight: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomRight: Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                         ),
                    //                                         child: const Text(
                    //                                           'รวม 70%',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign
                    //                                                   .start,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text1_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily:
                    //                                                 FontWeight_
                    //                                                     .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         color: Colors
                    //                                             .grey[200],
                    //                                         child: const Text(
                    //                                           'xxxxx',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign.end,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text2_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily: Font_
                    //                                                 .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           color: Colors
                    //                                               .grey[300],
                    //                                           borderRadius: const BorderRadius
                    //                                                   .only(
                    //                                               topLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               topRight: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomRight: Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                         ),
                    //                                         child: const Text(
                    //                                           'รวม 30%',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign
                    //                                                   .start,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text1_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily:
                    //                                                 FontWeight_
                    //                                                     .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         color: Colors
                    //                                             .grey[200],
                    //                                         child: const Text(
                    //                                           'xxxxx',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign.end,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text2_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily: Font_
                    //                                                 .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               // Row(
                    //                               //   children: [
                    //                               //     Expanded(
                    //                               //       flex: 1,
                    //                               //       child: Container(
                    //                               //           decoration:
                    //                               //               BoxDecoration(
                    //                               //             color: Colors
                    //                               //                 .grey[300],
                    //                               //             borderRadius: const BorderRadius
                    //                               //                     .only(
                    //                               //                 topLeft: Radius
                    //                               //                     .circular(
                    //                               //                         0),
                    //                               //                 topRight: Radius
                    //                               //                     .circular(
                    //                               //                         0),
                    //                               //                 bottomLeft: Radius
                    //                               //                     .circular(
                    //                               //                         0),
                    //                               //                 bottomRight: Radius
                    //                               //                     .circular(
                    //                               //                         0)),
                    //                               //           ),
                    //                               //           child: const Text(
                    //                               //             'รวมราคาก่อน Vat',
                    //                               //             maxLines: 1,
                    //                               //             textAlign:
                    //                               //                 TextAlign
                    //                               //                     .start,
                    //                               //             style: TextStyle(
                    //                               //               color: ReportScreen_Color
                    //                               //                   .Colors_Text1_,
                    //                               //               fontWeight:
                    //                               //                   FontWeight
                    //                               //                       .bold,
                    //                               //               fontFamily:
                    //                               //                   FontWeight_
                    //                               //                       .Fonts_T,
                    //                               //             ),
                    //                               //           )),
                    //                               //     ),
                    //                               //     Expanded(
                    //                               //       flex: 1,
                    //                               //       child: Container(
                    //                               //           color: Colors
                    //                               //               .grey[200],
                    //                               //           child: const Text(
                    //                               //             'xxxxxx',
                    //                               //             maxLines: 1,
                    //                               //             textAlign:
                    //                               //                 TextAlign.end,
                    //                               //             style: TextStyle(
                    //                               //               color: ReportScreen_Color
                    //                               //                   .Colors_Text2_,
                    //                               //               fontWeight:
                    //                               //                   FontWeight
                    //                               //                       .bold,
                    //                               //               fontFamily: Font_
                    //                               //                   .Fonts_T,
                    //                               //             ),
                    //                               //           )),
                    //                               //     ),
                    //                               //   ],
                    //                               // ),
                    //                               Row(
                    //                                 children: [
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           color: Colors
                    //                                               .grey[300],
                    //                                           borderRadius: const BorderRadius
                    //                                                   .only(
                    //                                               topLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               topRight: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomLeft: Radius
                    //                                                   .circular(
                    //                                                       0),
                    //                                               bottomRight: Radius
                    //                                                   .circular(
                    //                                                       0)),
                    //                                         ),
                    //                                         child: const Text(
                    //                                           'รวม',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign
                    //                                                   .start,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text1_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily:
                    //                                                 FontWeight_
                    //                                                     .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                   Expanded(
                    //                                     flex: 1,
                    //                                     child: Container(
                    //                                         color: Colors
                    //                                             .grey[200],
                    //                                         child: const Text(
                    //                                           'xxxxxxx',
                    //                                           maxLines: 1,
                    //                                           textAlign:
                    //                                               TextAlign.end,
                    //                                           style: TextStyle(
                    //                                             color: ReportScreen_Color
                    //                                                 .Colors_Text2_,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             fontFamily: Font_
                    //                                                 .Fonts_T,
                    //                                           ),
                    //                                         )),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 1),
                    //                   const Divider(),
                    //                   const SizedBox(height: 1),
                    //                   Padding(
                    //                     padding: const EdgeInsets.fromLTRB(
                    //                         8, 4, 8, 4),
                    //                     child: SingleChildScrollView(
                    //                       scrollDirection: Axis.horizontal,
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.end,
                    //                         children: [
                    //                           Padding(
                    //                             padding:
                    //                                 const EdgeInsets.all(8.0),
                    //                             child: InkWell(
                    //                               child: Container(
                    //                                 width: 100,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: Colors.blue,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(10),
                    //                                           topRight: Radius
                    //                                               .circular(10),
                    //                                           bottomLeft: Radius
                    //                                               .circular(10),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       10)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: const Center(
                    //                                   child: Text(
                    //                                     'Export file',
                    //                                     style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       fontFamily:
                    //                                           Font_.Fonts_T,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               onTap: () async {
                    //                                 setState(() {
                    //                                   Value_Report =
                    //                                       'รายงานภาษี';
                    //                                   Pre_and_Dow = 'Download';
                    //                                 });
                    //                                 Navigator.pop(context);
                    //                                 _showMyDialog_SAVE();
                    //                               },
                    //                             ),
                    //                           ),
                    //                           Padding(
                    //                             padding:
                    //                                 const EdgeInsets.all(8.0),
                    //                             child: InkWell(
                    //                               child: Container(
                    //                                 width: 100,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: Colors.green,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(10),
                    //                                           topRight: Radius
                    //                                               .circular(10),
                    //                                           bottomLeft: Radius
                    //                                               .circular(10),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       10)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: const Center(
                    //                                   child: Text(
                    //                                     'Print',
                    //                                     style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       fontFamily:
                    //                                           Font_.Fonts_T,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               onTap: () async {
                    //                                 setState(() {
                    //                                   Value_Report =
                    //                                       'รายงานภาษี';
                    //                                   Pre_and_Dow = 'Preview';
                    //                                 });
                    //                                 Navigator.pop(context);
                    //                                 _displayPdf_();
                    //                               },
                    //                             ),
                    //                           ),
                    //                           Padding(
                    //                             padding:
                    //                                 const EdgeInsets.all(8.0),
                    //                             child: InkWell(
                    //                               child: Container(
                    //                                 width: 100,
                    //                                 decoration:
                    //                                     const BoxDecoration(
                    //                                   color: Colors.black,
                    //                                   borderRadius:
                    //                                       BorderRadius.only(
                    //                                           topLeft: Radius
                    //                                               .circular(10),
                    //                                           topRight: Radius
                    //                                               .circular(10),
                    //                                           bottomLeft: Radius
                    //                                               .circular(10),
                    //                                           bottomRight:
                    //                                               Radius
                    //                                                   .circular(
                    //                                                       10)),
                    //                                 ),
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: const Center(
                    //                                   child: Text(
                    //                                     'ปิด',
                    //                                     style: TextStyle(
                    //                                       color: Colors.white,
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       fontFamily:
                    //                                           Font_.Fonts_T,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               onTap: () {
                    //                                 Navigator.of(context).pop();
                    //                               },
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               );
                    //             },
                    //           );
                    //         },
                    //       ),
                    //       const Padding(
                    //         padding: EdgeInsets.all(8.0),
                    //         child: Text(
                    //           'รายงานภาษี',
                    //           style: TextStyle(
                    //             color: ReportScreen_Color.Colors_Text2_,
                    //             // fontWeight: FontWeight.bold,
                    //             fontFamily: Font_.Fonts_T,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                              _select_Date(context);
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
                                    (Value_selectDate == null)
                                        ? 'เลือก'
                                        : '$Value_selectDate',
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
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
                            onTap: (_TransReBillModels.isEmpty)
                                ? null
                                : (TransReBillModels[
                                            _TransReBillModels.length - 1]
                                        .isEmpty)
                                    ? null
                                    : () async {
                                        // List show_more = [];
                                        int? show_more;

                                        double Sum_Ramt_ = 0.0;
                                        double Sum_Ramtd_ = 0.0;
                                        double Sum_Amt_ = 0.0;
                                        double Sum_Total_ = 0.0;
                                        double Sum_dis_ = 0.0;

                                        for (int indexsum1 = 0;
                                            indexsum1 <
                                                _TransReBillModels.length;
                                            indexsum1++) {
                                          Sum_Ramt_ = Sum_Ramt_ +
                                              double.parse(
                                                  (_TransReBillModels[indexsum1]
                                                              .ramt ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels[
                                                              indexsum1]
                                                          .ramt!);

                                          Sum_Ramtd_ = Sum_Ramtd_ +
                                              double.parse(
                                                  (_TransReBillModels[indexsum1]
                                                              .ramtd ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels[
                                                              indexsum1]
                                                          .ramtd!);

                                          Sum_Amt_ = Sum_Amt_ +
                                              double.parse(
                                                  (_TransReBillModels[indexsum1]
                                                              .amt ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels[
                                                              indexsum1]
                                                          .amt!);

                                          Sum_Total_ = Sum_Total_ +
                                              double.parse(
                                                  (_TransReBillModels[indexsum1]
                                                              .total_bill ==
                                                          null)
                                                      ? '0.00'
                                                      : _TransReBillModels[
                                                              indexsum1]
                                                          .total_bill!);

                                          Sum_dis_ = (_TransReBillModels[
                                                          indexsum1]
                                                      .total_dis ==
                                                  null)
                                              ? Sum_dis_ + 0.00
                                              : Sum_dis_ +
                                                  (double.parse(
                                                          _TransReBillModels[
                                                                  indexsum1]
                                                              .total_bill!) -
                                                      double.parse(
                                                          _TransReBillModels[
                                                                  indexsum1]
                                                              .total_dis!));

                                          Sum_total_dis =
                                              (_TransReBillModels[indexsum1]
                                                          .total_dis ==
                                                      null)
                                                  ? Sum_total_dis +
                                                      double.parse(
                                                          _TransReBillModels[
                                                                  indexsum1]
                                                              .total_bill!)
                                                  : Sum_total_dis +
                                                      double.parse(
                                                          _TransReBillModels[
                                                                  indexsum1]
                                                              .total_dis!);
                                        }
                                        Insert_log.Insert_logs(
                                            'รายงาน', 'กดดูรายงานประจำวัน');

                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              title: Column(
                                                children: [
                                                  const Center(
                                                      child: Text(
                                                    'รายงานประจำวัน',
                                                    style: TextStyle(
                                                      color: ReportScreen_Color
                                                          .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T,
                                                    ),
                                                  )),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            (Value_selectDate ==
                                                                    null)
                                                                ? 'วันที่: ?'
                                                                : 'วันที่: $Value_selectDate',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: ReportScreen_Color
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color: ReportScreen_Color
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
                                                      const Duration(
                                                          seconds: 0)),
                                                  builder: (context, snapshot) {
                                                    return ScrollConfiguration(
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
                                                                      : 800,
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
                                                                            'ไม่พบข้อมูล ณ วันที่เลือก',
                                                                            style:
                                                                                TextStyle(
                                                                              color: ReportScreen_Color.Colors_Text1_,
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
                                                                            child:
                                                                                ListView.builder(
                                                                          itemCount:
                                                                              _TransReBillModels.length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index1) {
                                                                            return ListTile(
                                                                              title: SizedBox(
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
                                                                                              //   _TransReBillModels[index1].doctax == '' ? '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].doctax}',
                                                                                              _TransReBillModels[index1].docno != null ? '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].docno}' : '${index1 + 1}. เลขที่: ${_TransReBillModels[index1].doctax}',
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
                                                                                                      (_TransReBillModels[index1].zn == null) ? '${_TransReBillModels[index1].znn}' : '${_TransReBillModels[index1].zn}',
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
                                                                                                      '${_TransReBillModels[index1].daterec}',
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
                                                                                                      //  (_TransReBillModels[index1].sname != null) ? '${_TransReBillModels[index1].sname}' : '${_TransReBillModels[index1].cname}',
                                                                                                      (_TransReBillModels[index1].sname == null)
                                                                                                          ? '${_TransReBillModels[index1].remark}'
                                                                                                          : (_TransReBillModels[index1].sname != null)
                                                                                                              ? '${_TransReBillModels[index1].sname}'
                                                                                                              : '${_TransReBillModels[index1].cname}',
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
                                                                                                      '${_TransReBillModels[index1].type}',
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
                                                                                                      (TransReBillModels[index1].length == null) ? '0.00' : '${nFormat2.format(double.parse(TransReBillModels[index1].length.toString()))}',
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
                                                                                                      (_TransReBillModels[index1].total_dis == null) ? '0.00' : '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!) - double.parse(_TransReBillModels[index1].total_dis!))}',
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
                                                                                                      (_TransReBillModels[index1].total_bill == null) ? '' : '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}',
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
                                                                                                      (_TransReBillModels[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels[index1].total_dis!))}',
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
                                                                                                        onTap: (_TransReBillModels[index1].slip.toString() == null || _TransReBillModels[index1].slip == null || _TransReBillModels[index1].slip.toString() == 'null')
                                                                                                            ? null
                                                                                                            : () async {
                                                                                                                String Url = await '${MyConstant().domain}/files/$foder/slip/${_TransReBillModels[index1].slip}';
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
                                                                                                            color: (_TransReBillModels[index1].slip.toString() == null || _TransReBillModels[index1].slip == null || _TransReBillModels[index1].slip.toString() == 'null') ? Colors.grey[300] : Colors.orange[300],
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
                                                                                                          'กำหนดชำระ',
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
                                                                                                color: Colors.green[100]!.withOpacity(0.5), padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                                                                                                            '${TransReBillModels[index1][index2].date}',
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
                                                                                                            '${TransReBillModels[index1][index2].nvat}',
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
                                                                                                            (TransReBillModels[index1][index2].vat == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].vat!))}',
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
                                                                                                          child: Text(
                                                                                                            (TransReBillModels[index1][index2].amt == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].amt!))}',
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
                                                                                                            (TransReBillModels[index1][index2].total == null) ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].total!))}',
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
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius: BorderRadius.only(
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
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    'Export file',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          Font_
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
                                                        // if (_TransReBillModels
                                                        //         .length !=
                                                        //     0)
                                                        //   Padding(
                                                        //     padding:
                                                        //         const EdgeInsets
                                                        //             .all(8.0),
                                                        //     child: InkWell(
                                                        //       child: Container(
                                                        //         width: 100,
                                                        //         decoration:
                                                        //             const BoxDecoration(
                                                        //           color: Colors
                                                        //               .green,
                                                        //           borderRadius: BorderRadius.only(
                                                        //               topLeft:
                                                        //                   Radius.circular(
                                                        //                       10),
                                                        //               topRight:
                                                        //                   Radius.circular(
                                                        //                       10),
                                                        //               bottomLeft:
                                                        //                   Radius.circular(
                                                        //                       10),
                                                        //               bottomRight:
                                                        //                   Radius.circular(
                                                        //                       10)),
                                                        //         ),
                                                        //         padding:
                                                        //             const EdgeInsets
                                                        //                     .all(
                                                        //                 8.0),
                                                        //         child:
                                                        //             const Center(
                                                        //           child: Text(
                                                        //             'Print',
                                                        //             style:
                                                        //                 TextStyle(
                                                        //               color: Colors
                                                        //                   .white,
                                                        //               fontWeight:
                                                        //                   FontWeight
                                                        //                       .bold,
                                                        //               fontFamily:
                                                        //                   Font_
                                                        //                       .Fonts_T,
                                                        //             ),
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //       onTap: () async {
                                                        //         if (_TransReBillModels
                                                        //                 .length ==
                                                        //             0) {
                                                        //         } else {
                                                        //           setState(() {
                                                        //             show_more =
                                                        //                 null;
                                                        //             Value_Report =
                                                        //                 'รายงานประจำวัน';
                                                        //             Pre_and_Dow =
                                                        //                 'Preview';
                                                        //           });
                                                        //           // Navigator.pop(context);
                                                        //           _displayPdf_();
                                                        //         }
                                                        //       },
                                                        //     ),
                                                        //   ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            child: Container(
                                                              width: 100,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
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
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  'ปิด',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                show_more =
                                                                    null;
                                                              });
                                                              check_clear();
                                                              Navigator.of(
                                                                      context)
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
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Text(
                          //     'รายงานประจำวัน',
                          //     style: TextStyle(
                          //       color: ReportScreen_Color.Colors_Text2_,
                          //       // fontWeight: FontWeight.bold,
                          //       fontFamily: Font_.Fonts_T,
                          //     ),
                          //   ),
                          // ),
                          (_TransReBillModels.isEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (Value_selectDate != null &&
                                            TransReBillModels.isEmpty)
                                        ? 'รายงานประจำวัน (ไม่พบข้อมูล ✖️)'
                                        : 'รายงานประจำวัน',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                )
                              : (TransReBillModels[
                                          _TransReBillModels.length - 1]
                                      .isEmpty)
                                  ? SizedBox(
                                      // height: 20,
                                      child: Row(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(4.0),
                                            child:
                                                const CircularProgressIndicator()),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'กำลังโหลดรายงานประจำวัน...',
                                            style: TextStyle(
                                              color: ReportScreen_Color
                                                  .Colors_Text2_,
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
                                        'รายงานประจำวัน ✔️',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ), ///////--------------------------------------------------------------------------------->(รายงานทะเบียนลูกค้า)
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
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
                            onTap: (customerModels.isEmpty)
                                ? null
                                : () {
                                    int? show_more;
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
                                                  'รายงานทะเบียนลูกค้า',
                                                  style: TextStyle(
                                                    color: ReportScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                )),
                                                const SizedBox(height: 1),
                                                const Divider(),
                                                const SizedBox(height: 1),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  // padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            _searchBar_cust(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            content: StreamBuilder(
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
                                                                : (customerModels
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
                                                            child: (customerModels
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
                                                                          'ไม่พบข้อมูล ณ วันที่เลือก',
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
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppbackgroundColor.TiTile_Colors.withOpacity(0.7),
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(0),
                                                                              bottomRight: Radius.circular(0)),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            const Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 20,
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
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                'รหัสสมาชิก',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                'ชื่อร้าน',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                'ชื่อผู้เช่า/บริษัท',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                'เบอร์ติดต่อ',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                'อีเมล',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                'Tax',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ReportScreen_Color.Colors_Text1_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                'ประเภท',
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
                                                                      Expanded(
                                                                          // height: MediaQuery.of(context).size.height *
                                                                          //     0.45,
                                                                          child:
                                                                              ListView.builder(
                                                                        itemCount:
                                                                            customerModels.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return Material(
                                                                            color: (show_more == index)
                                                                                ? tappedIndex_Color.tappedIndex_Colors.withOpacity(0.5)
                                                                                : AppbackgroundColor.Sub_Abg_Colors,
                                                                            child:
                                                                                Container(
                                                                              child: ListTile(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      show_more = index;
                                                                                    });
                                                                                  },
                                                                                  title: Row(
                                                                                    children: [
                                                                                      const SizedBox(
                                                                                        width: 20,
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Text(
                                                                                          '${index + 1}',
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
                                                                                          (customerModels[index].custno == null || customerModels[index].custno == '') ? '-' : '${customerModels[index].custno}',
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
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (customerModels[index].scname == null || customerModels[index].scname == '') ? '-' : '${customerModels[index].scname}',
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
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (customerModels[index].cname == null || customerModels[index].cname == '') ? '-' : '${customerModels[index].cname}',
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
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (customerModels[index].tel == null || customerModels[index].tel == '') ? '-' : '${customerModels[index].tel}',
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
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (customerModels[index].email == null || customerModels[index].email == '') ? '-' : '${customerModels[index].email}',
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
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (customerModels[index].tax == null || customerModels[index].tax == '') ? '-' : '${customerModels[index].tax}',
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
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          (customerModels[index].type == null || customerModels[index].type == '') ? '-' : '${customerModels[index].type}',
                                                                                          // '${TransReBillModels[index1].length}',
                                                                                          textAlign: TextAlign.center,
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text1_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )),
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
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 1),
                                                      const Divider(),
                                                      const SizedBox(height: 1),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    8, 4, 8, 4),
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  if (customerModels
                                                                          .length !=
                                                                      0)
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          InkWell(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.blue,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Text(
                                                                              'Export file',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          Excgen_CustReport.exportExcel_CustReport(
                                                                              context,
                                                                              renTal_name,
                                                                              customerModels);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        InkWell(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            100,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                        ),
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'ปิด',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        // check_clear();
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
                                                      ),
                                                    ],
                                                  ))
                                            ]);
                                      },
                                    );
                                  },
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              (customerModels.isNotEmpty)
                                  ? 'รายงานทะเบียนลูกค้า ✔️'
                                  : 'รายงานทะเบียนลูกค้า',
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
                    height: 250,
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
                    height: 250,
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
                                          '( ชำระแล้ว)',
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
                                      '( ทั้งหมด)',
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
                                                    (total1_ == null)
                                                        ? '0.00'
                                                        : '0.00',
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
            height: 500,
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
                            color: AppbackgroundColor.Sub_Abg_Colors,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 1),
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
                            border: Border.all(color: Colors.grey, width: 1),
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
                              '( ชำระแล้ว)',
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
                              '( ทั้งหมด)',
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            (total1_ == null) ? '0.00' : '0.00',
                                            // '${nFormat.format(double.parse(total1_.toString()))}',
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
