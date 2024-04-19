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
import '../Report/Report_Screen1.dart';
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
import 'Report_cm_ScreenB.dart';

class Report_cm_ScreenA extends StatefulWidget {
  const Report_cm_ScreenA({super.key});

  @override
  State<Report_cm_ScreenA> createState() => _Report_cm_ScreenAState();
}

class _Report_cm_ScreenAState extends State<Report_cm_ScreenA> {
  ///////---------------------------------------------------->
  DateTime datex = DateTime.now();
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  ///////---------------------------------------------------->
  String _verticalGroupValue_PassW = "EXCEL";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
  /////////////////---------------------------->
  String? numinvoice;
  String? renTal_user, renTal_name, zone_ser, zone_name;
  String? rtname, type, typex, renname, bill_name;
  String? bill_addr, bill_tax, bill_tel, bill_email;
  String? bills_name_, expbill, expbill_name, bill_default, bill_tser, foder;
  /////////////////---------------------------->
  var Value_selectDate_Daily;
  var Value_Chang_Zone_Daily;
  var Value_Chang_Zone_Ser_Daily;
  var Value_Chang_Zone_Income;
  var Value_Chang_Zone_Ser_Income;
  var Value_Chang_Zone_;
  var Value_Chang_Zone_Ser_;
  var Value_selectDate_daly_cus;
  /////////////////---------------------------->
  List newValuePDFimg = [];
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<ZoneModel> zoneModels_report = [];
  List<ExpModel> expModels = [];
  List<TransReBillModelRECM> _TransReBillModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<RenTalModel> renTalModels = [];
  List<PayMentModel> payMentModels = [];
  /////////////////---------------------------->
  late List<List<dynamic>> TransReBillModels_Income;
  late List<List<dynamic>> TransReBillModels_Bankmovemen;
  late List<List<dynamic>> TransReBillModels;
  late List<List<dynamic>> TransReBillModels_cus;
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
  /////////////////---------------------------->
  @override
  void initState() {
    super.initState();

    read_GC_Exp();
    read_GC_zone();
    read_GC_PayMentModel();
    checkPreferance();
    read_GC_rental();

    TransReBillModels_Income = [];
    TransReBillModels_Bankmovemen = [];
    TransReBillModels = [];
    TransReBillModels_cus = [];
  }

////////////----------------------------->
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

////////////----------------------------->
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

  ////////////----------------------------->
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

  ////////////----------------------------->
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

  ////////////----------------------------->
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
    // print('name>>>>>  $renname');
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

        // print('result ${_TransReBillModels.length}');

        TransReBillModels = List.generate(_TransReBillModels.length, (_) => []);

        red_Trans_select();
      }
    } catch (e) {}
  }
  ///////////--------------------------------------------->

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
        // print(result);
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

  ///////////--------------------------------------------->
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

    // print('zone>>>>>>zone>>>>>$Value_Chang_Zone_Ser_');

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
            child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
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
                                      color: Color.fromARGB(255, 231, 227, 227),
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
                                  borderRadius: BorderRadius.circular(10),
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

                                onChanged: (value) async {
                                  // Find the index of the selected item in the zoneModels_report list
                                  int selectedIndex = zoneModels_report
                                      .indexWhere((item) => item.zn == value);

                                  setState(() {
                                    Value_Chang_Zone_Daily = value!;
                                    Value_Chang_Zone_Ser_Daily =
                                        zoneModels_report[selectedIndex].ser!;
                                  });
                                  // print(
                                  //     'Selected Index: $Value_Chang_Zone_Daily  //${Value_Chang_Zone_Ser_Daily}');
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                if (Value_selectDate_Daily != null &&
                                    Value_Chang_Zone_Daily != null) {
                                  red_Trans_bill();
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
                    ),
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
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
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
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ทั้งหมด: ${_TransReBillModels.length}',
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                                ScrollConfiguration.of(context)
                                                    .copyWith(dragDevices: {
                                              PointerDeviceKind.touch,
                                              PointerDeviceKind.mouse,
                                            }),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    // color: Colors.grey[50],
                                                    width: (Responsive
                                                            .isDesktop(context))
                                                        ? MediaQuery.of(context)
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
                                                    child:
                                                        (_TransReBillModels
                                                                    .length ==
                                                                0)
                                                            ? const Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Center(
                                                                    child: Text(
                                                                      'ไม่พบข้อมูล ',
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
                                                                      child: ListView
                                                                          .builder(
                                                                    itemCount:
                                                                        _TransReBillModels
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
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
                                                                                      decoration:  BoxDecoration(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 20, 4),
                                            child: ScrollConfiguration(
                                              behavior: ScrollConfiguration.of(
                                                      context)
                                                  .copyWith(dragDevices: {
                                                PointerDeviceKind.touch,
                                                PointerDeviceKind.mouse,
                                              }),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                                  .grey[600],
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รวม',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  for (int index_exp =
                                                                          0;
                                                                      index_exp <
                                                                          expModels
                                                                              .length;
                                                                      index_exp++)
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        'รวม${expModels[index_exp].expname}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text1_,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              FontWeight_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รวม',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      'รวมส่วนลด',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      ' ',
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
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  for (int index_exp =
                                                                          0;
                                                                      index_exp <
                                                                          expModels
                                                                              .length;
                                                                      index_exp++)
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        (_TransReBillModels.length ==
                                                                                0)
                                                                            ? '0.00'
                                                                            : '${nFormat.format(calculateTotalValue_Daily_Cm(index_exp)!)}',
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              ReportScreen_Color.Colors_Text1_,
                                                                          // fontWeight: FontWeight.bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      (_TransReBillModels.length ==
                                                                              0)
                                                                          ? '0.00'
                                                                          : '${nFormat.format(double.parse('${_TransReBillModels.fold(
                                                                              0.0,
                                                                              (previousValue, element) => previousValue + (element.total_bill != null && element.total_bill.toString() != '' ? double.parse(element.total_bill!) : 0),
                                                                            ).toString()}'))}',
                                                                      // '${nFormat.format(double.parse('${Sum_Total_}'))}',
                                                                      // '$Sum_Total_',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      //  (_TransReBillModels[index1].total_dis == null) ? '${nFormat.format(double.parse(_TransReBillModels[index1].total_bill!))}' : '${nFormat.format(double.parse(_TransReBillModels[index1].total_dis!))}',
                                                                      (_TransReBillModels.length ==
                                                                              0)
                                                                          ? '0.00'
                                                                          : '${nFormat.format(double.parse('${_TransReBillModels.fold(
                                                                              0.0,
                                                                              (previousValue, element) => previousValue + (element.total_dis == null ? double.parse(element.total_bill!) : double.parse(element.total_dis!)),
                                                                            ).toString()}'))}',

                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      ' ',
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
                                          const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (_TransReBillModels.length != 0)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Center(
                                                      child: Text(
                                                        'Export file',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
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
                                                        show_more = null;
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
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                child: Container(
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                    child: Text(
                                                      'ปิด',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
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
                                        Value_Chang_Zone_Daily != null &&
                                        _TransReBillModels.length != 0)
                                    ? 'รายงาน ประจำวัน (พบข้อมูล ✔️)'
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
                                Value_Chang_Zone_ = value!;
                                Value_Chang_Zone_Ser_ =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $Value_Chang_Zone_  //${Value_Chang_Zone_Ser_}');

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
                                          color:
                                              ReportScreen_Color.Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T,
                                        ),
                                      )),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (Value_Chang_Zone_ == null)
                                                  ? 'โซน: ?'
                                                  : 'โซน: $Value_Chang_Zone_',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: ReportScreen_Color
                                                    .Colors_Text1_,
                                                fontSize: 14,
                                                // fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                'ทั้งหมด: ${teNantModels.length}',
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  // fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                                ScrollConfiguration.of(context)
                                                    .copyWith(dragDevices: {
                                              PointerDeviceKind.touch,
                                              PointerDeviceKind.mouse,
                                            }),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    // color: Colors.grey[50],
                                                    width: (Responsive
                                                            .isDesktop(context))
                                                        ? MediaQuery.of(context)
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
                                                                  .all(8.0),
                                                          child: Container(
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
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: const Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'ลำดับ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
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
                                                                  flex: 2,
                                                                  child: Text(
                                                                    'ชื่อ-สกุล',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
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
                                                                    'ประเภท',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
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
                                                                    'เลขแผง',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
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
                                                                    'พื้นที่',
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
                                                                    'ค่าเช่า',
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
                                                                    'โม่',
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
                                                                    'ถัง',
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
                                                                    'เช่าที่',
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
                                                                    'ไฟ',
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
                                                                    'รวม',
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: (teNantModels
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
                                                                : ListView
                                                                    .builder(
                                                                    itemCount:
                                                                        teNantModels
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return ListTile(
                                                                        title:
                                                                            Container(
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            border:
                                                                                Border(
                                                                              bottom: BorderSide(
                                                                                color: Colors.black12,
                                                                                width: 1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              4),
                                                                          child:
                                                                              Row(
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
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 20, 4),
                                            child: ScrollConfiguration(
                                              behavior: ScrollConfiguration.of(
                                                      context)
                                                  .copyWith(dragDevices: {
                                                PointerDeviceKind.touch,
                                                PointerDeviceKind.mouse,
                                              }),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                                  .grey[600],
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                      '',
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
                                                                      'รวม',
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
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                      'รวมพื้นที่',
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
                                                                      'รวมค่าเช่า',
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
                                                                      'รวมโม่',
                                                                      //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                      //  '${_TransReBillModels[index1].ramtd}',
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
                                                                      'รวมถัง',
                                                                      //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                      //  '${_TransReBillModels[index1].ramtd}',
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
                                                                      'รวมเช่าพื้นที่',
                                                                      //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                      //  '${_TransReBillModels[index1].ramtd}',
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
                                                                      'รวมค่าไฟ',
                                                                      //'${nFormat.format(double.parse(_TransReBillModels[index1].ramtd!))}',
                                                                      //  '${_TransReBillModels[index1].ramtd}',
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
                                                                      'รวม',
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
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
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
                                                                      // '${nFormat.format(double.parse('${teNantModels.length}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        // fontWeight:
                                                                        //     FontWeight.bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '',
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
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                            0.0, // Initial value for the sum (0.0 for double)
                                                                            (previousValue, element) =>
                                                                                previousValue +
                                                                                (element.area_c == null ? (element.area_q == null ? 0.0 : double.parse(element.area_q!)) : double.parse(element.area_c!)),
                                                                          ).toString()}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        // fontWeight:
                                                                        //     FontWeight.bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                            0.0,
                                                                            (previousValue, element) =>
                                                                                previousValue +
                                                                                (element.amt_expser1 != null && element.amt_expser1.toString() != '' ? double.parse(element.amt_expser1!) : 0),
                                                                          ).toString()}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                            0.0,
                                                                            (previousValue, element) =>
                                                                                previousValue +
                                                                                (element.amt_expser9 != null && element.amt_expser9.toString() != '' ? double.parse(element.amt_expser9!) : 0),
                                                                          ).toString()}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                            0.0,
                                                                            (previousValue, element) =>
                                                                                previousValue +
                                                                                (element.amt_expser10 != null && element.amt_expser10.toString() != '' ? double.parse(element.amt_expser10!) : 0),
                                                                          ).toString()}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                            0.0,
                                                                            (previousValue, element) =>
                                                                                previousValue +
                                                                                (element.amt_expser11 != null && element.amt_expser11.toString() != '' ? double.parse(element.amt_expser11!) : 0),
                                                                          ).toString()}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                            0.0,
                                                                            (previousValue, element) =>
                                                                                previousValue +
                                                                                (element.amt_expser12 != null && element.amt_expser12.toString() != '' ? double.parse(element.amt_expser12!) : 0),
                                                                          ).toString()}'))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      '${nFormat.format(double.parse('${teNantModels.fold(
                                                                        0.0, // Initial value for the sum (0.0 for double)
                                                                        (previousValue,
                                                                                element) =>
                                                                            previousValue +
                                                                            ((element.amt_expser1 != null && element.amt_expser1.toString() != '')
                                                                                ? double.parse(element.amt_expser1!)
                                                                                : 0) +
                                                                            ((element.amt_expser9 != null && element.amt_expser9.toString() != '') ? double.parse(element.amt_expser9!) : 0) +
                                                                            ((element.amt_expser10 != null && element.amt_expser10.toString() != '') ? double.parse(element.amt_expser10!) : 0) +
                                                                            ((element.amt_expser11 != null && element.amt_expser11.toString() != '') ? double.parse(element.amt_expser11!) : 0) +
                                                                            ((element.amt_expser12 != null && element.amt_expser12.toString() != '') ? double.parse(element.amt_expser12!) : 0),
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
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
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
                                          const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (teNantModels.length != 0)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    width: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Center(
                                                      child: Text(
                                                        'Export file',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    if (teNantModels.length ==
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
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                child: Container(
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
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
                                                      const EdgeInsets.all(8.0),
                                                  child: const Center(
                                                    child: Text(
                                                      'ปิด',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  setState(() {
                                                    Value_Chang_Zone_Ser_ =
                                                        null;
                                                    Value_Chang_Zone_ = null;
                                                  });
                                                  read_GC_tenant();
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
                                    ? 'รายงาน รายชื่อผู้เช่าแยกตามโซน (พบข้อมูล ✔️)'
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
                ])));
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
                                // setState_();
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
        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'รายงานประจำวัน') {
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
        }

        Navigator.of(context).pop();
      }
    }
  }

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
  }
}
