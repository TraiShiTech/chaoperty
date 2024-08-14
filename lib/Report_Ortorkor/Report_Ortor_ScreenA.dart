import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
import '../Report/Excel_BankDaily_Report.dart';
import '../Report/Excel_Bankmovemen_Report.dart';
import '../Report/Excel_Daily_Report.dart';
import '../Report/Excel_Income_Report.dart';
import '../Report/Report_Mini/MIni_Ex_BankDaily_Re.dart';
import '../Report/Report_Mini/MIni_Ex_Bankmovemen_Re.dart';
import '../Report/Report_Mini/MIni_Ex_Daily_Re.dart';
import '../Report/Report_Mini/MIni_Ex_Income_Re.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'Excel_IncomeOrtor_Report.dart';

class Report_Ortor_ScreenA extends StatefulWidget {
  const Report_Ortor_ScreenA({super.key});

  @override
  State<Report_Ortor_ScreenA> createState() => _Report_Ortor_ScreenAState();
}

class _Report_Ortor_ScreenAState extends State<Report_Ortor_ScreenA> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  int? Await_Status_Report1,
      Await_Status_Report2,
      Await_Status_Report3,
      Await_Status_Report4,
      Await_Status_Report5,
      Await_Status_Report6;
  List<PayMentModel> payMentModels = [];
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<RenTalModel> renTalModels = [];
  String? zone_ser_Invoice_Mon, zone_name_Mon;
  ///////////--------------------------------------------->
  String? Type_search;
  ///////////--------------------------------------------->
  List<TransReBillModel> TransReBillModels = [];
  List<TransReBillHistoryModel> TranHisBillModels = [];
  List<TransReBillModel> TransReBillBank = [];
  List<TransReBillHistoryModel> TransHisBillBank = [];
  ///////////--------------------------------------------->
  // List<TransReBillModel> TransReBillModels_Daily = [];
  // List<TransReBillHistoryModel> TranHisBillModels_Daily = [];
  // List<TransReBillModel> TransReBillBank_Daily = [];
  // List<TransReBillHistoryModel> TransHisBillBank_Daily = []; จะมีการอัพเดตระบบ เวลา 14.00  2023-11-23
  ///////////--------------------------------------------->
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  String? zone_ser_Trans_Daily, zone_name_Trans_Daily;
  String? zone_ser_Trans_Mon;
  String? zone_name_Trans_Mon;

  String? YE_Trans_Mon, Mon_Trans_Mon;
  var Value_TransDate_Daily;

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
  ///////////--------------------------------------------->
  String _verticalGroupValue_PassW = "EXCEL";
  String _ReportValue_type = "ปกติ";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();

  ///////////--------------------------------------------->
  String? renTal_user, renTal_name, zone_ser, zone_name;
  DateTime now = DateTime.now();
  String? rtname, type, typex, renname, bill_name, bill_addr, bill_tax;
  String? bill_tel, bill_email, expbill, expbill_name, bill_default;
  String? bill_tser, foder;
  String? name_slip, name_slip_ser, bills_name_;
  String? base64_Slip, fileName_Slip;
////////--------------------------------------------->

  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_rental();
    read_GC_zone();
    read_GC_PayMentModel();
  }

///////------------------------------------------------------------------>
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

///////------------------------------------------------------------------>
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

  ///////////--------------------------------------------->
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

  ///////////--------------------------------------------->
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
      } else {}
    } catch (e) {}
    // print('name>>>>>  $renname');
  }

///////////--------------------------------------------->(รายงานรายรับ)
  Future<Null> red_Trans_billIncome() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    if (TransReBillModels.length != 0) {
      setState(() {
        TransReBillModels.clear();
      });
    }
    setState(() {
      if (Type_search == 'Mon') {
        Await_Status_Report1 = 0;
      } else {
        Await_Status_Report2 = 0;
      }
    });
    var serzone_s = (Type_search.toString() == 'Mon')
        ? (zone_ser_Trans_Mon == null)
            ? 0
            : zone_ser_Trans_Mon
        : (zone_ser_Trans_Daily == null)
            ? 0
            : zone_ser_Trans_Daily;

    ///-------->debt
    String url_Mon = (serzone_s.toString() == '0')
        ? '${MyConstant().domain}/GC_bill_pay_BCOrtor_IncomeReport_All.php?isAdd=true&ren=$ren&mont_h=$Mon_Trans_Mon&yea_r=$YE_Trans_Mon&serzone=$serzone_s'
        : '${MyConstant().domain}/GC_bill_pay_BCOrtor_IncomeReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Trans_Mon&yea_r=$YE_Trans_Mon&serzone=$serzone_s';

    // String url_Daily = (zone_ser_Trans_Daily.toString() == '0')
    //     ? '${MyConstant().domain}/GC_bill_pay_BCOrtor_DailyReport_All.php?isAdd=true&ren=$ren&date=$Value_TransDate_Daily&serzone=$zone_ser_Trans_Daily'
    //     : '${MyConstant().domain}/GC_bill_pay_BCOrtor_DailyReport.php?isAdd=true&ren=$ren&date=$Value_TransDate_Daily&serzone=$zone_ser_Trans_Daily';

    ///-------->
    try {
      var response = await http.get(Uri.parse(url_Mon));
      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel _TransReBillModels_Incomes =
              TransReBillModel.fromJson(map);
          setState(() {
            TransReBillModels.add(_TransReBillModels_Incomes);
          });
        }
        // print('result ${TransReBillModels.length}');
      }
      Future.delayed(Duration(milliseconds: 700), () async {
        setState(() {
          if (Type_search == 'Mon') {
            Await_Status_Report1 = null;
          } else {
            Await_Status_Report2 = null;
          }
        });
      });
    } catch (e) {}
  }

///////////--------------------------------------------->()

  Future<Null> red_Trans_selectIncomeAll() async {
    Dia_log();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    setState(() {
      TranHisBillModels.clear();
      TransHisBillBank.clear();
    });
    var serzone_s = (Type_search.toString() == 'Mon')
        ? (zone_ser_Trans_Mon == null)
            ? 0
            : zone_ser_Trans_Mon
        : (zone_ser_Trans_Daily == null)
            ? 0
            : zone_ser_Trans_Daily;
    print('serzone_s');
    print(serzone_s);
    String url =
        // (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร' ||
        //         Value_Report == 'รายงานการเคลื่อนไหวธนาคารประจำวัน')
        //     ? '${MyConstant().domain}/GC_bill_pay_historyselectBankAllReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Trans_Mon&yea_r=$YE_Trans_Mon&serzone=$serzone_s&datex=$Value_TransDate_Daily&Typesearch=$Type_search'
        //     :
        '${MyConstant().domain}/GC_bill_payOrtor_historyselectAllReport.php?isAdd=true&ren=$ren&mont_h=$Mon_Trans_Mon&yea_r=$YE_Trans_Mon&serzone=$serzone_s&datex=$Value_TransDate_Daily&Typesearch=$Type_search';
    // print(
    //     'Value_Report //TransHisBillBank/// ${Value_Report}** $serzone_s  /// $Type_search');

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel TranHisBillModels_Mons =
              TransReBillHistoryModel.fromJson(map);
          setState(() {
            (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร' ||
                    Value_Report == 'รายงานการเคลื่อนไหวธนาคารประจำวัน')
                ? TransHisBillBank.add(TranHisBillModels_Mons)
                : TranHisBillModels.add(TranHisBillModels_Mons);
          });
        }
        // print(
        //     'red_Trans_selectIncomeAll //TransHisBillBank/// ${TransHisBillBank.length}** $serzone_s  /// $Type_search');
        // print(
        //     'red_Trans_selectIncomeAll//TranHisBillModels /// ${TranHisBillModels.length} ** $serzone_s /// $Type_search');
      }
    } catch (e) {}
  }

// 4 +4+4 = 5
//10+6+4
/////////////------------------------------------> 50
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

        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          Value_TransDate_Daily = "${formatter.format(result)}";
        });
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.lime[200],

                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'พิเศษ : เครือ องค์การตลาด กระทรวงมหาดไทย ',
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'เดือนที่ครบกำหนดชำระ :',
                            ReportScreen_Color.Colors_Text2_,
                            TextAlign.center,
                            FontWeight.w500,
                            Font_.Fonts_T,
                            16,
                            1),
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
                            value:
                                (Mon_Trans_Mon == null) ? null : Mon_Trans_Mon,

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
                                  child: Translate.TranslateAndSetText(
                                      '${monthsInThai[item - 1]}',
                                      ReportScreen_Color.Colors_Text2_,
                                      TextAlign.center,
                                      FontWeight.w500,
                                      Font_.Fonts_T,
                                      16,
                                      1),
                                )
                            ],

                            onChanged: (value) async {
                              setState(() {
                                Value_TransDate_Daily = null;
                              });
                              Mon_Trans_Mon = value.toString();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'ปีที่ที่ครบกำหนดชำระ :',
                            ReportScreen_Color.Colors_Text2_,
                            TextAlign.center,
                            FontWeight.w500,
                            Font_.Fonts_T,
                            16,
                            1),
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
                            value: (YE_Trans_Mon == null) ? null : YE_Trans_Mon,

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
                                    // '${int.parse(item) + 543}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )).toList(),

                            onChanged: (value) async {
                              setState(() {
                                Value_TransDate_Daily = null;
                              });
                              YE_Trans_Mon = value.toString();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'โซน :',
                            ReportScreen_Color.Colors_Text2_,
                            TextAlign.center,
                            FontWeight.w500,
                            Font_.Fonts_T,
                            16,
                            1),
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
                            value: (Type_search != 'Mon')
                                ? null
                                : zone_name_Trans_Mon,
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
                                zone_name_Trans_Mon = value!;
                                zone_ser_Trans_Mon =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $zone_ser_Trans_Mon  //${zone_name_Trans_Mon}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Mon_Trans_Mon != null &&
                                YE_Trans_Mon != null &&
                                zone_ser_Trans_Mon != null) {
                              setState(() {
                                Type_search = 'Mon';
                              });
                              Dia_log();
                              red_Trans_billIncome();
                              // red_Trans_billMovemen();
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
                                child: Translate.TranslateAndSetText(
                                    'ค้นหา',
                                    Colors.white,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: (TransReBillModels.length == 0 ||
                                Type_search != 'Mon')
                            ? null
                            : () async {
                                // Insert_log.Insert_logs('รายงาน', 'กดดูรายงานรายรับ');
                                TransIncome_Widget();
                              },
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
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Translate.TranslateAndSetText(
                                    'เรียกดู',
                                    ReportScreen_Color.Colors_Text1_,
                                    TextAlign.center,
                                    FontWeight.w500,
                                    Font_.Fonts_T,
                                    16,
                                    1),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        )),
                    (Type_search != 'Mon')
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                'รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิล [Exclusive-A-Ortor]',
                                ReportScreen_Color.Colors_Text1_,
                                TextAlign.center,
                                FontWeight.w500,
                                Font_.Fonts_T,
                                16,
                                1),
                          )
                        : (TransReBillModels.isEmpty)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Translate.TranslateAndSetText(
                                    (TransReBillModels.isEmpty &&
                                            Mon_Trans_Mon != null &&
                                            YE_Trans_Mon != null &&
                                            zone_name_Trans_Mon != null)
                                        ? 'รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิล [Exclusive-A-Ortor] (ไม่พบข้อมูล ✖️)'
                                        : 'รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิล [Exclusive-A-Ortor]',
                                    ReportScreen_Color.Colors_Text1_,
                                    TextAlign.center,
                                    FontWeight.w500,
                                    Font_.Fonts_T,
                                    16,
                                    1),
                              )
                            : (TransReBillModels.length != 0 &&
                                    Type_search == 'Mon' &&
                                    Await_Status_Report1 == 0)
                                ? SizedBox(
                                    // height: 20,
                                    child: Row(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(4.0),
                                          child:
                                              const CircularProgressIndicator()),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Translate.TranslateAndSetText(
                                            'กำลังโหลดรายงานตั้งหนี้-ใบแจ้งหนี้/วางบิล [Exclusive-A-Ortor]...',
                                            ReportScreen_Color.Colors_Text1_,
                                            TextAlign.center,
                                            FontWeight.w500,
                                            Font_.Fonts_T,
                                            16,
                                            1),
                                      ),
                                    ],
                                  ))
                                : Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Translate.TranslateAndSetText(
                                        'รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิล [Exclusive-A-Ortor] ✔️',
                                        ReportScreen_Color.Colors_Text1_,
                                        TextAlign.center,
                                        FontWeight.w500,
                                        Font_.Fonts_T,
                                        16,
                                        1),
                                  ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lime[200],

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          // border: Border.all(color: Colors.grey, width: 1),
                        ),
                        padding: EdgeInsets.all(4.0),
                        child: Translate.TranslateAndSetText(
                            'พิเศษ',
                            Colors.red,
                            TextAlign.center,
                            FontWeight.w500,
                            Font_.Fonts_T,
                            16,
                            1),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }

////////////------------------------------------------------->
  TransIncome_Widget() {
    // Insert_log.Insert_logs('รายงาน', 'กดดูรายงานรายรับ');
    int? show_more;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 0)),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Center(
                        child: Text(
                      (zone_name_Trans_Mon == null)
                          ? 'Exclusive-A-รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิลOrtor  (กรุณาเลือกโซน)'
                          : 'Exclusive-A-รายงานตั้งหนี้-ใบแจ้งหนี้/วางบิลOrtor  (โซน : $zone_name_Trans_Mon)',
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
                              (Mon_Trans_Mon == null && YE_Trans_Mon == null)
                                  ? 'เดือน : ? (?) '
                                  : (Mon_Trans_Mon == null)
                                      ? 'เดือน : ? ($YE_Trans_Mon) '
                                      : (Mon_Trans_Mon == null)
                                          ? 'เดือน : $Mon_Trans_Mon (?) '
                                          : 'เดือน : $Mon_Trans_Mon ($YE_Trans_Mon) ',
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
                              'ทั้งหมด: ${nFormat2.format(double.parse('${TransReBillModels.length}'))}',
                              // 'ทั้งหมด: ${TransReBillModels.length}',
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
                );
              }),
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
                              ? MediaQuery.of(context).size.width * 0.93
                              : (TransReBillModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 800,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (TransReBillModels.length == 0)
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors
                                            .withOpacity(0.7),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'โซน',
                                              textAlign: TextAlign.start,
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
                                              'รหัสพื้นที่',
                                              textAlign: TextAlign.start,
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
                                              'วันที่ของเอกสาร',
                                              textAlign: TextAlign.start,
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
                                              'วันที่ครบกำหนด',
                                              textAlign: TextAlign.start,
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
                                              'เลขที่รับชำระ',
                                              textAlign: TextAlign.start,
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
                                              'เลขที่วางบิล',
                                              textAlign: TextAlign.start,
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
                                              'รหัสลูกหนี้',
                                              textAlign: TextAlign.start,
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
                                              'ชื่อร้านค้า',
                                              textAlign: TextAlign.start,
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
                                              'ชื่อผู้ติดต่อ',
                                              textAlign: TextAlign.start,
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
                                              'รายการทั้งหมด',
                                              textAlign: TextAlign.end,
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
                                          //     'ยอดสุทธิ',
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
                                        ],
                                      ),
                                    ),
                                    // for (int index1 = 0;
                                    //     index1 <
                                    //         _TransReBillModels
                                    //             .length;
                                    //     index1++)
                                    Expanded(
                                        // height: MediaQuery.of(context).size.height *
                                        //     0.45,
                                        child: ListView.builder(
                                      itemCount: TransReBillModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        return ListTile(
                                          title: Container(
                                            decoration: BoxDecoration(
                                              border: const Border(
                                                bottom: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${TransReBillModels[index1].zn}',
                                                    textAlign: TextAlign.start,
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
                                                    '${TransReBillModels[index1].ln}',
                                                    textAlign: TextAlign.start,
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
                                                    (TransReBillModels[index1]
                                                                .daterec ==
                                                            null)
                                                        ? ''
                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels[index1].daterec}'))}-${DateTime.parse('${TransReBillModels[index1].daterec}').year + 543}',
                                                    textAlign: TextAlign.start,
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
                                                    (TransReBillModels[index1]
                                                                .inv_end_date ==
                                                            null)
                                                        ? ''
                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${TransReBillModels[index1].inv_end_date}'))}-${DateTime.parse('${TransReBillModels[index1].inv_end_date}').year + 543}',
                                                    textAlign: TextAlign.start,
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
                                                    (TransReBillModels[index1]
                                                                .docno !=
                                                            null)
                                                        ? (TransReBillModels[
                                                                            index1]
                                                                        .doctax ==
                                                                    null ||
                                                                TransReBillModels[
                                                                            index1]
                                                                        .doctax
                                                                        .toString()
                                                                        .trim() ==
                                                                    '')
                                                            ? '${TransReBillModels[index1].docno}'
                                                            : '${TransReBillModels[index1].doctax}'
                                                        : 'รอชำระ',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: (TransReBillModels[
                                                                      index1]
                                                                  .docno ==
                                                              null)
                                                          ? Colors.orange[600]
                                                          : ReportScreen_Color
                                                              .Colors_Text1_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${TransReBillModels[index1].inv}',
                                                    textAlign: TextAlign.start,
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
                                                    '${TransReBillModels[index1].cid}',
                                                    textAlign: TextAlign.start,
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
                                                    '${TransReBillModels[index1].sname}',
                                                    textAlign: TextAlign.start,
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
                                                    '${TransReBillModels[index1].cname}',
                                                    textAlign: TextAlign.start,
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
                                                    (double.parse(TransReBillModels[
                                                                    index1]
                                                                .sum_items!) >
                                                            0)
                                                        ? '${double.parse(TransReBillModels[index1].sum_items!) + 1}'
                                                        : '${TransReBillModels[index1].sum_items}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ReportScreen_Color
                                                          .Colors_Text1_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Text(
                                                //     '${TransReBillModels[index1].sum_items}',
                                                //     textAlign:
                                                //         TextAlign
                                                //             .end,
                                                //     style:
                                                //         const TextStyle(
                                                //       color: ReportScreen_Color
                                                //           .Colors_Text1_,
                                                //       // fontWeight: FontWeight.bold,
                                                //       fontFamily: Font_
                                                //           .Fonts_T,
                                                //     ),
                                                //   ),
                                                // ),
                                                //   Expanded(
                                                //     flex: 1,
                                                //     child: Text(
                                                //  '${TransReBillModels[index1].sum_items}',
                                                //       textAlign:
                                                //           TextAlign
                                                //               .right,
                                                //       style:
                                                //           TextStyle(
                                                //         color: ReportScreen_Color
                                                //             .Colors_Text1_,
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .bold,
                                                //         fontFamily:
                                                //             FontWeight_
                                                //                 .Fonts_T,
                                                //       ),
                                                //     ),
                                                //   ),
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
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (TransReBillModels.length != 0)
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
                              Value_Report = (Type_search.toString() == 'Mon')
                                  ? 'รายงานรายรับ'
                                  : 'รายงานรายรับประจำวัน';
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
                            zone_ser_Trans_Mon = null;
                            zone_name_Trans_Mon = null;
                            Mon_Trans_Mon = null;
                            YE_Trans_Mon = null;
                          });
                          setState(() {
                            TransReBillModels.clear();
                            TranHisBillModels.clear();
                            TransReBillBank.clear();
                            TransHisBillBank.clear();
                          });
                          setState(() {
                            Value_TransDate_Daily = null;
                            Type_search = null;
                            zone_name_Trans_Daily = null;
                            zone_ser_Trans_Daily = null;
                            zone_name_Trans_Mon = null;
                            zone_ser_Trans_Mon = null;
                            Mon_Trans_Mon = null;
                            YE_Trans_Mon = null;
                            zone_name_Mon = null;
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

////////////------------------------------------------------->

  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(milliseconds: 4600), () {
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

/////////////---------------------------------------->
  slip_Widget(Url) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text(
                            'ปิด',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T),
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
  }
///////////------------------------------------------------------->

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
                            // "ย่อ",
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
    await red_Trans_selectIncomeAll();

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
              ? Excgen_Income_OrtorReport.exportExcel_Income_OrtorReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillModels,
                  TranHisBillModels,
                  renTal_user,
                  renTal_name,
                  zoneModels_report,
                  zone_name_Trans_Mon,
                  Mon_Trans_Mon,
                  YE_Trans_Mon)
              : Mini_Ex_IncomeReport.mini_exportExcel_IncomeReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillModels,
                  TranHisBillModels,
                  renTal_name,
                  zoneModels_report,
                  zone_name_Trans_Mon,
                  Mon_Trans_Mon,
                  YE_Trans_Mon);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_BankmovemenReport.exportExcel_BankmovemenReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillBank,
                  TransHisBillBank,
                  renTal_name,
                  zoneModels_report,
                  zone_name_Trans_Mon,
                  Mon_Trans_Mon,
                  YE_Trans_Mon,
                  payMentModels)
              : Mini_Ex_BankmovemenReport.mini_exportExcel_BankmovemenReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillBank,
                  TransHisBillBank,
                  renTal_name,
                  zoneModels_report,
                  zone_name_Trans_Mon,
                  Mon_Trans_Mon,
                  YE_Trans_Mon,
                  payMentModels);
        } else if (Value_Report == 'รายงานรายรับประจำวัน') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_DailyReport.exportExcel_DailyReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillModels,
                  TranHisBillModels,
                  renTal_name,
                  zoneModels_report,
                  Value_TransDate_Daily,
                  zone_name_Trans_Daily)
              : Mini_Ex_DailyReport.mini_exportExcel_DailyReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillModels,
                  TranHisBillModels,
                  renTal_name,
                  zoneModels_report,
                  Value_TransDate_Daily,
                  zone_name_Trans_Daily);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคารประจำวัน') {
          (_ReportValue_type == "ปกติ")
              ? Excgen_BankDailyReport.exportExcel_BankDailyReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillBank,
                  TransHisBillBank,
                  renTal_name,
                  zoneModels_report,
                  Value_TransDate_Daily,
                  zone_name_Trans_Daily,
                  payMentModels)
              : Mini_Ex_BankdailyReport.mini_exportExcel_BankdailyReport(
                  '1',
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Report,
                  TransReBillBank,
                  TransHisBillBank,
                  renTal_name,
                  zoneModels_report,
                  Value_TransDate_Daily,
                  zone_name_Trans_Daily,
                  payMentModels);
        }

        Navigator.of(context).pop();
      }
    }
  }
}
