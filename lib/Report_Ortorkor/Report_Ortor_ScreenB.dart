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
import '../Model/GetExp_Model.dart';
import '../Model/GetInvoiceRe_Model.dart';
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
import '../Style/colors.dart';
import 'Excel_IncomeOrtor_Report.dart';
import 'Excel_invoiceOrtor_Report.dart';

class Report_Ortor_ScreenB extends StatefulWidget {
  const Report_Ortor_ScreenB({super.key});

  @override
  State<Report_Ortor_ScreenB> createState() => _Report_Ortor_ScreenBState();
}

class _Report_Ortor_ScreenBState extends State<Report_Ortor_ScreenB> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("###0.00", "en_US");
  DateTime datex = DateTime.now();
  int? show_more;
  //-------------------------------------->
  String _verticalGroupValue_PassW = "EXCEL";
  String _ReportValue_type = "ปกติ";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
  String? Type_search;

  ///------------------------>
  int? Await_Status_Report1,
      Await_Status_Report2,
      Await_Status_Report3,
      Await_Status_Report4,
      Await_Status_Report5,
      Await_Status_Report6;
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<InvoiceReModel> InvoiceModels = [];
  List<InvoiceReModel> _InvoiceModels = <InvoiceReModel>[];
  List<TransReBillModel> TransReBillModels_ = [];
  List<TransReBillHistoryModel> TranHisBillModels = [];
  List<PayMentModel> payMentModels = [];
  List<ExpModel> expModels = [];
  List<String> YE_Th = [];
  List<String> Mont_Th = [];

  ///////////--------------------------------------------->
  String? renTal_user, renTal_name, zone_ser, zone_name;
  DateTime now = DateTime.now();
  String? rtname, type, typex, renname, bill_name, bill_addr, bill_tax;
  String? bill_tel, bill_email, expbill, expbill_name, bill_default;
  String? bill_tser, foder;
  String? name_slip, name_slip_ser, bills_name_;
  String? base64_Slip, fileName_Slip;
////////--------------------------------------------->>

  List<RenTalModel> renTalModels = [];
  int Ser_BodySta1 = 0;
  int Ser_BodySta2 = 0;
  int Ser_BodySta3 = 0;
  int Ser_BodySta4 = 0;

  ///------>
  String? zone_ser_Invoice_Daily, zone_name_Invoice_Daily;
  String? zone_ser_Invoice_Mon, zone_name_Invoice_Mon;
  String? YE_Invoice_Mon, Mon_Invoice_Mon;
  var Value_InvoiceDate_Daily;

  ///------>
  String? zone_ser_BillAwatCheck_Daily, zone_name_BillAwatCheck_Daily;
  String? zone_ser_BillAwatCheck_Mon, zone_name_BillAwatCheck_Mon;
  String? YE_BillAwatCheck_Mon, Mon_BillAwatCheck_Mon;
  var Value_BillAwatCheck_Daily;

  ///------------------------>
  String? ser_Zonex, Value_stasus, Status_pe;
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
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_rental();
    read_GC_zone();
    read_GC_Exp();
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
    } catch (e) {
      // print('Error-Dis(read_GC_rental) : ${e}');
    }
    // print('name>>>>>  $renname');
  }

////////--------------------------------------------------------------->
  System_New_Update() async {
    // String accept_ = showst_update_!;
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(
          '📢ขออภัย !!!! ',
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
                    'ขออภัย ขณะนี้ฟังก์ชั่นก์ รายงานหน้า 9 อยู่ในช่วงทดสอบ... !!!!!! ',
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

  ////////--------------------------------------------------------------->
  Future<Null> read_GC_Exp() async {
    if (expModels.isNotEmpty) {
      expModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_exp_Report.php?isAdd=true&ren=$ren';

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

////////--------------------------------------------------------------->
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

////////--------------------------------------------------------------->

  Future<Null> red_InvoiceMon_bill() async {
    String Serdata =
        (zone_ser_Invoice_Mon.toString() == '0' || zone_ser_Invoice_Mon == null)
            ? 'All'
            : 'Allzone';
    setState(() {
      InvoiceModels.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (Serdata.toString() == 'All')
        ? '${MyConstant().domain}/GC_bill_invoiceMon_historyReport.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone_ser_Invoice_Mon&_monts=$Mon_Invoice_Mon&yex=$YE_Invoice_Mon'
        : '${MyConstant().domain}/GC_bill_invoiceMon_historyReport.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone_ser_Invoice_Mon&_monts=$Mon_Invoice_Mon&yex=$YE_Invoice_Mon';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        setState(() {
          Await_Status_Report1 = 1;
        });
        for (var map in result) {
          InvoiceReModel transMeterModel = InvoiceReModel.fromJson(map);
          setState(() {
            InvoiceModels.add(transMeterModel);
          });
        }
      }

      Future.delayed(Duration(milliseconds: 700), () async {
        setState(() {
          _InvoiceModels = InvoiceModels;
          Await_Status_Report1 = null;
        });
      });
    } catch (e) {
      print(e);
    }
  }

//////////---------------------------------------->Value_teNantDate_Daily
  Future<Null> red_InvoiceDaily_bill() async {
    String Serdata =
        (zone_ser_Invoice_Mon.toString() == '0' || zone_ser_Invoice_Mon == null)
            ? 'All'
            : 'Allzone';

    setState(() {
      InvoiceModels.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (Serdata.toString() == 'All')
        ? '${MyConstant().domain}/GC_bill_invoiceDaily_historyReport.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone_ser_Invoice_Daily&dates=$Value_InvoiceDate_Daily'
        : '${MyConstant().domain}/GC_bill_invoiceDaily_historyReport.php?isAdd=true&ren=$ren&Serdata=$Serdata&serzone=$zone_ser_Invoice_Daily&dates=$Value_InvoiceDate_Daily';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        setState(() {
          Await_Status_Report2 = 1;
        });
        for (var map in result) {
          InvoiceReModel transMeterModel = InvoiceReModel.fromJson(map);
          setState(() {
            InvoiceModels.add(transMeterModel);
          });
        }
      }

      Future.delayed(Duration(milliseconds: 700), () async {
        setState(() {
          _InvoiceModels = InvoiceModels;
          Await_Status_Report2 = null;
        });
      });
    } catch (e) {}
  }

  ////////////----------------------->
  Future<Null> red_Trans_selectIncome(ciddoc, docnoin, index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    setState(() {
      TranHisBillModels.clear();
    });
    String url =
        '${MyConstant().domain}/GC_bill_pay_history_DailyReport.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel TranHisBillModels_Mons =
              TransReBillHistoryModel.fromJson(map);
          setState(() {
            TranHisBillModels.add(TranHisBillModels_Mons);
          });
        }
      }
    } catch (e) {
      // print('Error-Dis(red_Trans_selectIncome) : ${e}');
    }
  }

/////////////------------------------------------>
  Future<Null> red_Trans_selectIncomeAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    setState(() {
      TranHisBillModels.clear();
    });
    var ser_Zone = (Type_search == 'Mon')
        ? zone_ser_BillAwatCheck_Mon
        : zone_ser_BillAwatCheck_Daily;

    String url =
        '${MyConstant().domain}/GC_bill_pay_historyselect_VerifiAllDisReport.php?isAdd=true&ren=$ren&mont_h=$Mon_BillAwatCheck_Mon&yea_r=$YE_BillAwatCheck_Mon&serzone=$ser_Zone&datex=$Value_BillAwatCheck_Daily&Typesearch=$Type_search';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillHistoryModel TranHisBillModels_Mons =
              TransReBillHistoryModel.fromJson(map);
          setState(() {
            TranHisBillModels.add(TranHisBillModels_Mons);
          });
        }
      }
    } catch (e) {
      // print('Error-Dis(red_Trans_selectIncomeAll) : ${e}');
    }
  }

  ////////////-----------------------(วันที่รายงานประจำวัน)
  Future<Null> _select_Date_Daily(BuildContext context) async {
    setState(() {
      zone_ser_Invoice_Mon = null;
      zone_name_Invoice_Mon = null;
      YE_Invoice_Mon = null;
      Mon_Invoice_Mon = null;
      Ser_BodySta1 = 0;
      Ser_BodySta2 = 0;
    });
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
          Value_InvoiceDate_Daily = "${formatter.format(result)}";
        });
        // if (Value_Chang_Zone_Daily != null) {
        //   red_Trans_bill();
        //   red_Trans_billDailyBank();
        // }

        // red_Trans_bill_Groptype_daly();
      }
    });
  }

///////--------------------------------------------------->
  ///
  Future<Null> red_Trans_bill_Mon() async {
    setState(() {
      TransReBillModels_.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_Verifi_ReportMon.php?isAdd=true&ren=$ren&mont_h=$Mon_BillAwatCheck_Mon&yea_r=$YE_BillAwatCheck_Mon&serzone=$zone_ser_BillAwatCheck_Mon';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            TransReBillModels_.add(transReBillModel);
          });
        }
        Future.delayed(Duration(milliseconds: 800), () async {
          setState(() {
            Await_Status_Report3 = null;
          });
          // print('red_Trans_bill_Mon : ${TransReBillModels_.length}');
        });
      }
    } catch (e) {}
  }

///////--------------------------------------------------->
  ///
  Future<Null> red_Trans_bill_Daily() async {
    setState(() {
      TransReBillModels_.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_bill_pay_BC_Verifi_ReportDaily.php?isAdd=true&ren=$ren&date=$Value_BillAwatCheck_Daily&serzone=$zone_ser_BillAwatCheck_Daily';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          setState(() {
            TransReBillModels_.add(transReBillModel);
          });
        }
        Future.delayed(Duration(milliseconds: 800), () async {
          setState(() {
            Await_Status_Report4 = null;
          });
          // print('red_Trans_bill_Daily : ${TransReBillModels_.length}');
        });
      }
    } catch (e) {}
  }

  ////////////-----------------------(วันที่รายงานประจำวัน)
  Future<Null> _select_Date_DailyBillAwatCheck(BuildContext context) async {
    setState(() {
      zone_ser_BillAwatCheck_Mon = null;
      zone_name_BillAwatCheck_Mon = null;
      YE_BillAwatCheck_Mon = null;
      Mon_BillAwatCheck_Mon = null;
      Ser_BodySta3 = 0;
      Ser_BodySta4 = 0;
    });
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
        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_BillAwatCheck_Daily = "${formatter.format(result)}";
        });
      }
    });
  }
  //////////------------------>

/////////////---------------------------------------->
  slip_Widget(Url, doc_) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text(
                  '${doc_}',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontWeight_.Fonts_T,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
            SizedBox(
              width: 300,
              child: Image.network('$Url'),
            )
          ])),
          actions: <Widget>[
            SizedBox(
              // width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '*** วิธีตรวจสอบ "สลิป" เบื้องต้น',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T),
                  ),
                  Text(
                    '1. สังเกตความละเอียดของ ตัวเลข หรือ ตัวหนังสือ',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: Font_.Fonts_T),
                  ),
                  Text(
                    '2. เปิดแอปฯ ธนาคารขึ้นมา สแกน QR CODE บนสลิปโอนเงิน',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: Font_.Fonts_T),
                  ),
                  Text(
                    '3. ใช้  Mobile Banking เช็ก ยอดเงิน วัน-เวลาที่โอน ตรงกับในสลิปที่ได้มาหรือไม่',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: Font_.Fonts_T),
                  ),
                  Text(
                    '4. ควรตรวจสอบสลิปทันทีที่ได้รับมา เพราะ QR code บนสลิปของบางธนาคารจะมีอายุจำกัด ตั้งเเต่ 7 วัน ถึง 60 วัน ',
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: Font_.Fonts_T),
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
            ),
          ]),
    );
  }
///////////------------------------------------------------------->

////////////------------------------------------------>
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              // color: Colors.lime[200],
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'เดือนที่ครบกำหนดชำระ :',
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
                            value: (Mon_Invoice_Mon == null)
                                ? null
                                : Mon_Invoice_Mon,
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
                              setState(() {
                                zone_ser_Invoice_Daily = null;
                                zone_name_Invoice_Daily = null;
                                Value_InvoiceDate_Daily = null;
                                Ser_BodySta1 = 0;
                                Ser_BodySta2 = 0;
                              });
                              Mon_Invoice_Mon = value.toString();
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'ปีที่ครบกำหนดชำระ :',
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
                            value: (Ser_BodySta1 != 1) ? null : YE_Invoice_Mon,
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
                                zone_ser_Invoice_Daily = null;
                                zone_name_Invoice_Daily = null;
                                Value_InvoiceDate_Daily = null;
                                Ser_BodySta1 = 0;
                                Ser_BodySta2 = 0;
                              });
                              YE_Invoice_Mon = value.toString();

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
                            value: (Ser_BodySta1 != 1)
                                ? null
                                : zone_name_Invoice_Mon,
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
                              setState(() {
                                zone_ser_Invoice_Daily = null;
                                zone_name_Invoice_Daily = null;
                                Value_InvoiceDate_Daily = null;
                                Ser_BodySta1 = 0;
                                Ser_BodySta2 = 0;
                              });
                              int selectedIndex = zoneModels_report
                                  .indexWhere((item) => item.zn == value);

                              setState(() {
                                zone_name_Invoice_Mon = value!;
                                zone_ser_Invoice_Mon =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $zone_ser_Invoice_Mon  //${zone_name_Invoice_Mon}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              Ser_BodySta1 = 1;
                            });

                            if (Mon_Invoice_Mon != null &&
                                YE_Invoice_Mon != null &&
                                zone_name_Invoice_Mon != null &&
                                Ser_BodySta1 == 1) {
                              setState(() {
                                Await_Status_Report2 = 0;
                              });
                              Dia_log();
                              red_InvoiceMon_bill();
                            }

                            // red_Trans_c_maintenance();
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: (Ser_BodySta1 != 1)
                              ? null
                              : () async {
                                  // Insert_log.Insert_logs(
                                  //     'รายงาน', 'กดดูรายงานการแจ้งซ่อม');
                                  Invoice_Widget();
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
                          )),
                      (Ser_BodySta1 != 1)
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'รายงานข้อมูลใบแจ้งหนี้/วางบิล [Exclusive-B-Ortor] ',
                                style: TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            )
                          : (InvoiceModels.isEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (InvoiceModels.isEmpty &&
                                            zone_name_Invoice_Mon != null &&
                                            Await_Status_Report2 != null)
                                        ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิล [Exclusive-B-Ortor]  (ไม่พบข้อมูล ✖️)'
                                        : 'รายงานข้อมูลใบแจ้งหนี้/วางบิล [Exclusive-B-Ortor] ',
                                    style: const TextStyle(
                                      color: ReportScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    ),
                                  ),
                                )
                              : (InvoiceModels.length != 0 &&
                                      Await_Status_Report1 != null &&
                                      Ser_BodySta1 == 1)
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
                                            'กำลังโหลดรายงานข้อมูลใบแจ้งหนี้/วางบิล [Exclusive-B-Ortor] ...',
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
                                        'รายงานข้อมูลใบแจ้งหนี้/วางบิล [Exclusive-B-Ortor] ✔️',
                                        style: TextStyle(
                                          color:
                                              ReportScreen_Color.Colors_Text2_,
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: Font_.Fonts_T,
                                        ),
                                      ),
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
                          child: const Text(
                            'พิเศษ',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontFamily: Font_.Fonts_T,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              // const SizedBox(   AND c_contract.zser = '$Serzone'
              //   height: 5.0,
              // ),
              // ScrollConfiguration(
              //   behavior:
              //       ScrollConfiguration.of(context).copyWith(dragDevices: {
              //     PointerDeviceKind.touch,
              //     PointerDeviceKind.mouse,
              //   }),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         const Padding(
              //           padding: EdgeInsets.all(8.0),
              //           child: Text(
              //             'วันที่ที่ครบกำหนดชำระ :',
              //             style: TextStyle(
              //               color: ReportScreen_Color.Colors_Text2_,
              //               // fontWeight: FontWeight.bold,
              //               fontFamily: Font_.Fonts_T,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: InkWell(
              //             onTap: () {
              //               _select_Date_Daily(context);
              //             },
              //             child: Container(
              //                 decoration: BoxDecoration(
              //                   color: AppbackgroundColor.Sub_Abg_Colors,
              //                   borderRadius: const BorderRadius.only(
              //                       topLeft: Radius.circular(10),
              //                       topRight: Radius.circular(10),
              //                       bottomLeft: Radius.circular(10),
              //                       bottomRight: Radius.circular(10)),
              //                   border:
              //                       Border.all(color: Colors.grey, width: 1),
              //                 ),
              //                 width: 120,
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Center(
              //                   child: Text(
              //                     (Value_InvoiceDate_Daily == null)
              //                         ? 'เลือก'
              //                         : '$Value_InvoiceDate_Daily',
              //                     style: const TextStyle(
              //                       color: ReportScreen_Color.Colors_Text2_,
              //                       // fontWeight: FontWeight.bold,
              //                       fontFamily: Font_.Fonts_T,
              //                     ),
              //                   ),
              //                 )),
              //           ),
              //         ),
              //         const Padding(
              //           padding: EdgeInsets.all(8.0),
              //           child: Text(
              //             'โซน :',
              //             style: TextStyle(
              //               color: ReportScreen_Color.Colors_Text2_,
              //               // fontWeight: FontWeight.bold,
              //               fontFamily: Font_.Fonts_T,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Container(
              //             decoration: const BoxDecoration(
              //               color: AppbackgroundColor.Sub_Abg_Colors,
              //               borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(10),
              //                   topRight: Radius.circular(10),
              //                   bottomLeft: Radius.circular(10),
              //                   bottomRight: Radius.circular(10)),
              //               // border: Border.all(color: Colors.grey, width: 1),
              //             ),
              //             width: 260,
              //             padding: const EdgeInsets.all(8.0),
              //             child: DropdownButtonFormField2(
              //               value: zone_name_Invoice_Daily,
              //               alignment: Alignment.center,
              //               focusColor: Colors.white,
              //               autofocus: false,
              //               decoration: InputDecoration(
              //                 enabled: true,
              //                 hoverColor: Colors.brown,
              //                 prefixIconColor: Colors.blue,
              //                 fillColor: Colors.white.withOpacity(0.05),
              //                 filled: false,
              //                 isDense: true,
              //                 contentPadding: EdgeInsets.zero,
              //                 border: OutlineInputBorder(
              //                   borderSide: const BorderSide(color: Colors.red),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 focusedBorder: const OutlineInputBorder(
              //                   borderRadius: BorderRadius.only(
              //                     topRight: Radius.circular(10),
              //                     topLeft: Radius.circular(10),
              //                     bottomRight: Radius.circular(10),
              //                     bottomLeft: Radius.circular(10),
              //                   ),
              //                   borderSide: BorderSide(
              //                     width: 1,
              //                     color: Color.fromARGB(255, 231, 227, 227),
              //                   ),
              //                 ),
              //               ),
              //               isExpanded: false,

              //               icon: const Icon(
              //                 Icons.arrow_drop_down,
              //                 color: Colors.black,
              //               ),
              //               style: const TextStyle(
              //                 color: Colors.grey,
              //               ),
              //               iconSize: 20,
              //               buttonHeight: 40,
              //               buttonWidth: 250,
              //               // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              //               dropdownDecoration: BoxDecoration(
              //                 // color: Colors
              //                 //     .amber,
              //                 borderRadius: BorderRadius.circular(10),
              //                 border: Border.all(color: Colors.white, width: 1),
              //               ),
              //               items: zoneModels_report
              //                   .map((item) => DropdownMenuItem<String>(
              //                         value: '${item.zn}',
              //                         child: Text(
              //                           '${item.zn}',
              //                           textAlign: TextAlign.center,
              //                           style: const TextStyle(
              //                             overflow: TextOverflow.ellipsis,
              //                             fontSize: 14,
              //                             color: Colors.grey,
              //                           ),
              //                         ),
              //                       ))
              //                   .toList(),

              //               onChanged: (value) async {
              //                 int selectedIndex = zoneModels_report
              //                     .indexWhere((item) => item.zn == value);

              //                 setState(() {
              //                   zone_name_Invoice_Daily = value.toString();
              //                   zone_ser_Invoice_Daily =
              //                       zoneModels_report[selectedIndex].ser!;
              //                 });
              //                 print(
              //                     'Selected Index: $zone_name_Invoice_Daily  //${zone_ser_Invoice_Daily}');
              //               },
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: InkWell(
              //             onTap: () async {
              //               setState(() {
              //                 Ser_BodySta2 = 1;
              //               });
              //               if (Ser_BodySta2 == 1 &&
              //                   zone_ser_Invoice_Daily != null &&
              //                   Value_InvoiceDate_Daily != null) {
              //                 Dia_log();
              //                 // red_InvoiceDaily_bill();
              //               }
              //             },
              //             child: Container(
              //                 width: 100,
              //                 padding: const EdgeInsets.all(8.0),
              //                 decoration: BoxDecoration(
              //                   color: Colors.green[700],
              //                   borderRadius: const BorderRadius.only(
              //                       topLeft: Radius.circular(10),
              //                       topRight: Radius.circular(10),
              //                       bottomLeft: Radius.circular(10),
              //                       bottomRight: Radius.circular(10)),
              //                 ),
              //                 child: Center(
              //                   child: Text(
              //                     'ค้นหา',
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold,
              //                       fontFamily: FontWeight_.Fonts_T,
              //                     ),
              //                   ),
              //                 )),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         InkWell(
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 color: Colors.yellow[600],
              //                 borderRadius: const BorderRadius.only(
              //                     topLeft: Radius.circular(10),
              //                     topRight: Radius.circular(10),
              //                     bottomLeft: Radius.circular(10),
              //                     bottomRight: Radius.circular(10)),
              //                 border: Border.all(color: Colors.grey, width: 1),
              //               ),
              //               padding: const EdgeInsets.all(8.0),
              //               child: const Center(
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text(
              //                       'เรียกดู',
              //                       style: TextStyle(
              //                         color: ReportScreen_Color.Colors_Text1_,
              //                         fontWeight: FontWeight.bold,
              //                         fontFamily: FontWeight_.Fonts_T,
              //                       ),
              //                     ),
              //                     Icon(
              //                       Icons.navigate_next,
              //                       color: Colors.grey,
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             onTap: (Ser_BodySta2 == 1)
              //                 ? () async {
              //                     Invoice_Widget();
              //                     // Insert_log.Insert_logs(
              //                     //     'รายงาน', 'กดดูรายงานการแจ้งซ่อม');
              //                     // RE_maintenance_Widget();
              //                   }
              //                 : null),
              //         (Ser_BodySta2 != 1)
              //             ? Padding(
              //                 padding: EdgeInsets.all(8.0),
              //                 child: Text(
              //                   'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน [Exclusive-B-Ortor]',
              //                   style: TextStyle(
              //                     color: ReportScreen_Color.Colors_Text2_,
              //                     // fontWeight: FontWeight.bold,
              //                     fontFamily: Font_.Fonts_T,
              //                   ),
              //                 ),
              //               )
              //             : (InvoiceModels.isEmpty)
              //                 ? Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       (InvoiceModels.isEmpty &&
              //                               Value_InvoiceDate_Daily != null &&
              //                               Ser_BodySta2 == 1)
              //                           ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน [Exclusive-B-Ortor] (ไม่พบข้อมูล ✖️)'
              //                           : 'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน [Exclusive-B-Ortor]',
              //                       style: const TextStyle(
              //                         color: ReportScreen_Color.Colors_Text2_,
              //                         // fontWeight: FontWeight.bold,
              //                         fontFamily: Font_.Fonts_T,
              //                       ),
              //                     ),
              //                   )
              //                 : (Await_Status_Report2 != null &&
              //                         Ser_BodySta2 == 1)
              //                     ? SizedBox(
              //                         // height: 20,
              //                         child: Row(
              //                         children: [
              //                           Container(
              //                               padding: const EdgeInsets.all(4.0),
              //                               child:
              //                                   const CircularProgressIndicator()),
              //                           const Padding(
              //                             padding: EdgeInsets.all(8.0),
              //                             child: Text(
              //                               'กำลังโหลดรายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน [Exclusive-B-Ortor]...',
              //                               style: TextStyle(
              //                                 color: ReportScreen_Color
              //                                     .Colors_Text2_,
              //                                 // fontWeight: FontWeight.bold,
              //                                 fontFamily: Font_.Fonts_T,
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ))
              //                     : (InvoiceModels.length != 0 &&
              //                             Await_Status_Report2 == 1 &&
              //                             Ser_BodySta2 == 1)
              //                         ? SizedBox(
              //                             // height: 20,
              //                             child: Row(
              //                             children: [
              //                               Container(
              //                                   padding:
              //                                       const EdgeInsets.all(4.0),
              //                                   child:
              //                                       const CircularProgressIndicator()),
              //                               const Padding(
              //                                 padding: EdgeInsets.all(8.0),
              //                                 child: Text(
              //                                   'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน [Exclusive-B-Ortor]...',
              //                                   style: TextStyle(
              //                                     color: ReportScreen_Color
              //                                         .Colors_Text2_,
              //                                     // fontWeight: FontWeight.bold,
              //                                     fontFamily: Font_.Fonts_T,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ))
              //                         : const Padding(
              //                             padding: EdgeInsets.all(8.0),
              //                             child: Text(
              //                               'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน [Exclusive-B-Ortor] ✔️',
              //                               style: TextStyle(
              //                                 color: ReportScreen_Color
              //                                     .Colors_Text2_,
              //                                 // fontWeight: FontWeight.bold,
              //                                 fontFamily: Font_.Fonts_T,
              //                               ),
              //                             ),
              //                           ),
              //         Padding(
              //           padding: EdgeInsets.all(4.0),
              //           child: Container(
              //             decoration: BoxDecoration(
              //               color: Colors.lime[200],

              //               borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(10),
              //                   topRight: Radius.circular(10),
              //                   bottomLeft: Radius.circular(10),
              //                   bottomRight: Radius.circular(10)),
              //               // border: Border.all(color: Colors.grey, width: 1),
              //             ),
              //             padding: EdgeInsets.all(4.0),
              //             child: Text(
              //               'พิเศษ',
              //               style: TextStyle(
              //                 color: Colors.red,
              //                 fontWeight: FontWeight.bold,
              //                 fontFamily: Font_.Fonts_T,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ])));
  }

///////////////-------------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(milliseconds: 4000), () {
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

  ///////////////////////////----------------------------------------------->(รายงานInvoice)
  Invoice_Widget() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              //Mon_transMeter_Mon  YE_transMeter_Mon
              Center(
                  child: (Ser_BodySta1 == 1)
                      ? Text(
                          (zone_name_Invoice_Mon == null)
                              ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายเดือน (กรุณาเลือกโซน)'
                              : 'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายเดือน (โซน : $zone_name_Invoice_Mon) ',
                          style: const TextStyle(
                            color: ReportScreen_Color.Colors_Text1_,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontWeight_.Fonts_T,
                          ),
                        )
                      : Text(
                          (zone_name_Invoice_Daily == null)
                              ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน (กรุณาเลือกโซน)'
                              : 'รายงานข้อมูลใบแจ้งหนี้/วางบิลรายวัน (โซน : $zone_name_Invoice_Daily) ',
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
                        (Mon_Invoice_Mon == null && YE_Invoice_Mon == null)
                            ? 'เดือน : ? (?) '
                            : (Mon_Invoice_Mon == null)
                                ? 'เดือน : ? ($YE_Invoice_Mon) '
                                : (YE_Invoice_Mon == null)
                                    ? 'เดือน : $Mon_Invoice_Mon (?) '
                                    : 'เดือน : $Mon_Invoice_Mon ($YE_Invoice_Mon) ',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ReportScreen_Color.Colors_Text1_,
                          // fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        'ทั้งหมด: ${InvoiceModels.length}',
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
              Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Expanded(child: _searchBar_ChoArea()),
                  ],
                ),
              ),
            ],
          ),
          content: StreamBuilder(
              stream:
                  Stream<void>.periodic(const Duration(seconds: 3), (i) => i)
                      .take(3),
              // stream: Stream.periodic(const Duration(seconds: 1)),
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
                              ? (MediaQuery.of(context).size.width) +
                                  (expModels.length * 350)
                              : (InvoiceModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200 + (expModels.length * 350),
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (InvoiceModels.length == 0)
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
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'บริษัท',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'เลขที่รับชำระ',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'เลขที่ใบแจ้งหนี้',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'สถานะ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'วันที่ออกใบแจ้งหนี้',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'วันที่ครบกำหนด',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ชื่อลูกค้า',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'รอบการเช่า',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'โซน',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ล็อค',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          for (int index = 0;
                                              index < expModels.length;
                                              index++)
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        2, 0, 2, 0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        color: Colors
                                                            .deepPurple[200]!
                                                            .withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Text(
                                                          'QTY',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        color: Colors
                                                            .deepPurple[300]!
                                                            .withOpacity(0.6),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Text(
                                                          '${expModels[index].expname}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ภาษีมูลค่าเพิ่ม',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ภาษีหัก ณ ที่จ่าย',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ส่วนลด',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ยอดรวม',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ยอดสุทธิ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ยอดรับชำระ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'หมายเหตุ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: ManageScreen_Color
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
                                        // height: (Responsive.isDesktop(context))
                                        //     ? MediaQuery.of(context).size.width * 0.255
                                        //     : MediaQuery.of(context).size.height * 0.45,
                                        child: ListView.builder(
                                      itemCount: InvoiceModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                          color: (show_more == index)
                                              ? tappedIndex_Color
                                                  .tappedIndex_Colors
                                                  .withOpacity(0.5)
                                              : AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                          child: ListTile(
                                            onTap: () {
                                              // setState(() {
                                              //   show_more = index;
                                              // });
                                            },
                                            title: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.green[100]!
                                                //     .withOpacity(0.5),
                                                border: const Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black12,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Row(children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    '${renTal_name}',
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                    .docno ==
                                                                null ||
                                                            InvoiceModels[index]
                                                                    .docno
                                                                    .toString() ==
                                                                '')
                                                        ? 'รอชำระ'
                                                        : '${InvoiceModels[index].docno}',
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: (InvoiceModels[
                                                                          index]
                                                                      .docno ==
                                                                  null ||
                                                              InvoiceModels[
                                                                          index]
                                                                      .docno
                                                                      .toString() ==
                                                                  '')
                                                          ? Colors.orange[600]
                                                          : ManageScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    '${InvoiceModels[index].inv}',
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '-',
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      //fontSize: 10.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                    .date ==
                                                                null ||
                                                            InvoiceModels[index]
                                                                    .daterec
                                                                    .toString() ==
                                                                '')
                                                        ? '${InvoiceModels[index].daterec}'
                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].daterec}'))}-${DateTime.parse('${InvoiceModels[index].daterec}').year + 543}',
                                                    //'${DateFormat('dd-MM-yyyy').format(DateTime.parse('${InvoiceModels[index].daterec}'))}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      // fontSize: 12.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                    .date ==
                                                                null ||
                                                            InvoiceModels[index]
                                                                    .date
                                                                    .toString() ==
                                                                '')
                                                        ? '${InvoiceModels[index].date}'
                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${InvoiceModels[index].date}'))}-${DateTime.parse('${InvoiceModels[index].date}').year + 543}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      // fontSize: 12.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${InvoiceModels[index].scname}',
                                                    // '${transMeterModels[index].ovalue}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      //fontSize: 12.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                    .date ==
                                                                null ||
                                                            InvoiceModels[index]
                                                                    .date
                                                                    .toString() ==
                                                                '')
                                                        ? '${InvoiceModels[index].date}'
                                                        : '${DateFormat('MMM', 'th_TH').format(DateTime.parse('${InvoiceModels[index].date}'))} ${DateTime.parse('${InvoiceModels[index].date}').year + 543}',
                                                    // '${transMeterModels[index].nvalue}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                      // fontSize: 12.0
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${InvoiceModels[index].zn}',
                                                    //'${transMeterModels[index].qty}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${InvoiceModels[index].ln}',
                                                    //'${transMeterModels[index].qty}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                for (int index2 = 0;
                                                    index2 < expModels.length;
                                                    index2++)
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(1, 0, 1, 0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            right: BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                            // left: BorderSide(
                                                            //     color: Colors
                                                            //         .grey),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  FutureBuilder<
                                                                      String>(
                                                                future: read_QtyGCExpSer(
                                                                    index,
                                                                    expModels[
                                                                            index2]
                                                                        .ser),
                                                                initialData:
                                                                    '0', // Set an initial value as a string
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  } else if (snapshot
                                                                      .hasError) {
                                                                    return Text(
                                                                        'Error: ${snapshot.error}');
                                                                  } else {
                                                                    return Text(
                                                                      snapshot.data ??
                                                                          '', // Display the result or an empty string if null
                                                                      // maxLines: 1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  FutureBuilder<
                                                                      String>(
                                                                future: read_SumGCExpSer(
                                                                    index,
                                                                    expModels[
                                                                            index2]
                                                                        .ser),
                                                                initialData:
                                                                    '0', // Set an initial value as a string
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  } else if (snapshot
                                                                      .hasError) {
                                                                    return Text(
                                                                        'Error: ${snapshot.error}');
                                                                  } else {
                                                                    return Text(
                                                                      snapshot.data ??
                                                                          '', // Display the result or an empty string if null
                                                                      // maxLines: 1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                .total_vat ==
                                                            null)
                                                        ? '${InvoiceModels[index].total_vat}'
                                                        : '${nFormat.format(double.parse(InvoiceModels[index].total_vat.toString()))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                  // FutureBuilder<String>(
                                                  //   future:
                                                  //       read_SumGCExpWht(index),
                                                  //   initialData:
                                                  //       '0', // Set an initial value as a string
                                                  //   builder: (BuildContext
                                                  //           context,
                                                  //       AsyncSnapshot<String>
                                                  //           snapshot) {
                                                  //     if (snapshot
                                                  //             .connectionState ==
                                                  //         ConnectionState
                                                  //             .waiting) {
                                                  //       return Row(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .center,
                                                  //         children: [
                                                  //           SizedBox(
                                                  //             height: 50,
                                                  //             child:
                                                  //                 CircularProgressIndicator(),
                                                  //           ),
                                                  //         ],
                                                  //       );
                                                  //     } else if (snapshot
                                                  //         .hasError) {
                                                  //       return Text(
                                                  //           'Error: ${snapshot.error}');
                                                  //     } else {
                                                  //       return Text(
                                                  //         snapshot.data ??
                                                  //             '', // Display the result or an empty string if null
                                                  //         // maxLines: 1,
                                                  //         textAlign:
                                                  //             TextAlign.end,
                                                  //         style:
                                                  //             const TextStyle(
                                                  //           color: PeopleChaoScreen_Color
                                                  //               .Colors_Text2_,
                                                  //           fontFamily:
                                                  //               Font_.Fonts_T,
                                                  //         ),
                                                  //       );
                                                  //     }
                                                  //   },
                                                  // ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                .total_wht ==
                                                            null)
                                                        ? '${InvoiceModels[index].total_wht}'
                                                        : '${nFormat.format(double.parse(InvoiceModels[index].total_wht.toString()))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                  // FutureBuilder<String>(
                                                  //   future: read_SumGCExpNWht(
                                                  //       index),
                                                  //   initialData:
                                                  //       '0', // Set an initial value as a string
                                                  //   builder: (BuildContext
                                                  //           context,
                                                  //       AsyncSnapshot<String>
                                                  //           snapshot) {
                                                  //     if (snapshot
                                                  //             .connectionState ==
                                                  //         ConnectionState
                                                  //             .waiting) {
                                                  //       return Row(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .center,
                                                  //         children: [
                                                  //           SizedBox(
                                                  //             height: 20,
                                                  //             child:
                                                  //                 CircularProgressIndicator(),
                                                  //           ),
                                                  //         ],
                                                  //       );
                                                  //     } else if (snapshot
                                                  //         .hasError) {
                                                  //       return Text(
                                                  //           'Error: ${snapshot.error}');
                                                  //     } else {
                                                  //       return Text(
                                                  //         snapshot.data ??
                                                  //             '', // Display the result or an empty string if null
                                                  //         // maxLines: 1,
                                                  //         textAlign:
                                                  //             TextAlign.end,
                                                  //         style:
                                                  //             const TextStyle(
                                                  //           color: PeopleChaoScreen_Color
                                                  //               .Colors_Text2_,
                                                  //           fontFamily:
                                                  //               Font_.Fonts_T,
                                                  //         ),
                                                  //       );
                                                  //     }
                                                  //   },
                                                  // ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${InvoiceModels[index].amt_dis}',
                                                    // '${nFormat.format(double.parse(InvoiceModels[index].total_bill.toString()) - double.parse(InvoiceModels[index].total_dis.toString()))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                .total_bill ==
                                                            null)
                                                        ? '${InvoiceModels[index].total_bill}'
                                                        : '${nFormat.format(double.parse(InvoiceModels[index].total_bill.toString()))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                .total_dis ==
                                                            null)
                                                        ? '${InvoiceModels[index].total_dis}'
                                                        : '${nFormat.format(double.parse(InvoiceModels[index].total_dis.toString()))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (InvoiceModels[index]
                                                                    .docno ==
                                                                null ||
                                                            InvoiceModels[index]
                                                                    .docno
                                                                    .toString() ==
                                                                '')
                                                        ? 'รอชำระ'
                                                        : '${nFormat.format(double.parse(InvoiceModels[index].paytotal_dis.toString()))}',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      color: (InvoiceModels[
                                                                          index]
                                                                      .docno ==
                                                                  null ||
                                                              InvoiceModels[
                                                                          index]
                                                                      .docno
                                                                      .toString() ==
                                                                  '')
                                                          ? Colors.orange[600]
                                                          : ManageScreen_Color
                                                              .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${InvoiceModels[index].remark}',
                                                    //'${transMeterModels[index].c_amt}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      color: ManageScreen_Color
                                                          .Colors_Text2_,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontFamily: Font_.Fonts_T,
                                                    ),
                                                  ),
                                                ),
                                              ]),
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
                    if (InvoiceModels.length != 0)
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
                              Value_Report = (Ser_BodySta1 == 1)
                                  ? 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายเดือน'
                                  : 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายวัน';
                              Pre_and_Dow = 'Download';
                            });
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
                            InvoiceModels.clear();
                            Ser_BodySta1 = 0;
                            Ser_BodySta2 = 0;
                            YE_Invoice_Mon = null;
                            Mon_Invoice_Mon = null;
                            zone_ser_Invoice_Daily = null;
                            zone_name_Invoice_Daily = null;
                            zone_ser_Invoice_Mon = null;
                            zone_name_Invoice_Mon = null;
                            Value_InvoiceDate_Daily = null;
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

  Future<String> read_SumGCExpWht(int index) async {
    String textdata = '${InvoiceModels[index].exp_array}';

    // String textdata2 = await textdata.substring(1, textdata.length - 1);

    try {
      List<dynamic> dataList = json.decode(textdata);

      double sumWhtExp = dataList
          .whereType<Map<String, dynamic>>()
          .map((element) => double.parse(element['wht_exp'].toString()))
          .fold(0, (prev, wht) => prev + wht);
      return '${nFormat.format(double.parse(sumWhtExp.toString()))}';
    } catch (e) {
      return '$e';
    }
  }

  Future<String> read_SumGCExpNWht(int index) async {
    String textdata = '${InvoiceModels[index].exp_array}';

    // String textdata2 = await textdata.substring(1, textdata.length - 1);

    try {
      List<dynamic> dataList = json.decode(textdata);

      double sumNWhtExp = dataList
          .whereType<Map<String, dynamic>>()
          .map((element) => double.parse(element['nwht_exp'].toString()))
          .fold(0, (prev, wht) => prev + wht);
      return '${nFormat.format(double.parse(sumNWhtExp.toString()))}';
    } catch (e) {
      return '$e';
    }
  }

  Future<String> read_SumGCExpSer(int index, serexp) async {
    String textdata = '${InvoiceModels[index].exp_array}';

    // String textdata2 = await textdata.substring(1, textdata.length - 1);

    try {
      List<dynamic> dataList = json.decode(textdata);

      double amt = dataList
          .whereType<Map<String, dynamic>>()
          .where((element) => element['ser_exp'].toString() == '$serexp')
          .map((element) => double.parse(element['amt_exp'].toString()))
          .fold(0, (prev, wht) => prev + wht);
      return '${nFormat.format(double.parse(amt.toString()))}';
    } catch (e) {
      return '$e';
    }
  }

  Future<String> read_QtyGCExpSer(int index, serexp) async {
    String textdata = '${InvoiceModels[index].exp_array}';

    // String textdata2 = await textdata.substring(1, textdata.length - 1);

    try {
      List<dynamic> dataList = json.decode(textdata);

      double qty = dataList
          .whereType<Map<String, dynamic>>()
          .where((element) => element['ser_exp'].toString() == '$serexp')
          .map((element) => double.parse(element['qty_exp'].toString()))
          .fold(0, (prev, wht) => prev + wht);
      return '${nFormat.format(double.parse(qty.toString()))}';
    } catch (e) {
      return '$e';
    }
  }

//  Widget someWidget = await _json(index);

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

  ////////////------------------------------------------------------>(Export file 2)
  Future<void> _showMyDialog_SAVE2() async {
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
    await red_Trans_selectIncomeAll();
    await Dia_log();
    setState(() {
      NameFile_ = '';
      NameFile_ = FormNameFile_text.text;
    });

    if (_verticalGroupValue_NameFile == 'กำหนดเอง') {
    } else {
      if (_verticalGroupValue_PassW == 'PDF') {
        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายเดือน' ||
            Value_Report == 'รายงานข้อมูลใบแจ้งหนี้/วางบิล รายวัน') {
          Excgen_InvoiceOrtorkorReport.exportExcel_invoiceOrtorkorReport(
              context,
              NameFile_,
              Ser_BodySta1,
              _verticalGroupValue_NameFile,
              Value_Report,
              InvoiceModels,
              _InvoiceModels,
              expModels,
              renTal_name,
              zone_name_Invoice_Mon,
              zone_name_Invoice_Daily,
              YE_Invoice_Mon,
              Mon_Invoice_Mon,
              Value_InvoiceDate_Daily);
        }
        Navigator.of(context).pop();
      }
    }
  }
}
