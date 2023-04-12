import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fine_bar_chart/fine_bar_chart.dart';
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
  List<AreaModel> areaModels = [];
  List<AreaModel> areaModels1 = [];
  List<AreaModel> areaModels2 = [];
  List<AreaModel> areaModels3 = [];
  List<CustomerModel> customerModels = [];
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<SCReportTotalModel> sCReportTotalModels = [];
  List<SCReportTotalModel> sCReportTotalModels2 = [];
  //////////////////////----------------------------------
  String? renTal_user, renTal_name, zone_ser, zone_name, total1_, total2_;
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
  // late List<List<TransReBillModel>> TransReBillModels;
  late List<List<dynamic>> TransReBillModels;

  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_customer();
    read_GC_area1();
    read_GC_area2();
    red_SCReport_Total1();
    red_SCReport_Total2();
    // red_Trans_bill();
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }

  Future<Null> red_SCReport_Total1() async {
    if (sCReportTotalModels.length != 0) {
      setState(() {
        sCReportTotalModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url =
        '${MyConstant().domain}/GC_SCReport_total1.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          SCReportTotalModel sCReportTotalModel =
              SCReportTotalModel.fromJson(map);

          setState(() {
            total1_ = sCReportTotalModel.total.toString();
            sCReportTotalModels.add(sCReportTotalModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }

        print('red_SCReport_Total1 ${sCReportTotalModels.length}');
      }
    } catch (e) {}
  }

  Future<Null> red_SCReport_Total2() async {
    if (sCReportTotalModels2.length != 0) {
      setState(() {
        sCReportTotalModels2.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    String url =
        '${MyConstant().domain}/GC_SCReport_total2.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          SCReportTotalModel sCReportTotalModel =
              SCReportTotalModel.fromJson(map);
          setState(() {
            total2_ = sCReportTotalModel.total.toString();
            sCReportTotalModels2.add(sCReportTotalModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }

        print('red_SCReport_Total1 ${sCReportTotalModels.length}');
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill() async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
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
          '${MyConstant().domain}/GC_bill_pay_history.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc&docnoin=$docnoin';
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

  Future<Null> read_customer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String? serzone = preferences.getString('zoneSer');
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz>>>>>>>>>>>>>>>>>>>>>>>>> $serzone');
    String url =
        '${MyConstant().domain}/GC_custo_home.php?isAdd=true&ren=$ren&ser_zone$serzone';

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
      print(customerModels.map((e) => e.scname));
    } catch (e) {}
  }

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

  ///////---------------------------------------------------->showMyDialog_SAVE
  String _verticalGroupValue_PassW = "PDF";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
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

////////////------------------------------------------------------>
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
      locale: const Locale('th', 'TH'),
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
          Value_selectDate = "${formatter.format(result)}";
        });
        red_Trans_bill();
      }
    });
  }

  Future<Null> _select_StartDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่เริ่มต้น', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
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
        });
        red_Trans_bill();
      }
    });
  }

  Future<Null> _select_EndDate(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      locale: const Locale('th', 'TH'),
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
        red_Trans_bill();
      }
    });
  }

////////////------------------------------------------------------>
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
                        // if (_verticalGroupValue_NameFile == 'กำหนดเอง')
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: TextFormField(
                        //       //keyboardType: TextInputType.none,
                        //       controller: FormNameFile_text,
                        //       validator: (value) {
                        //         if (value == null ||
                        //             value.isEmpty ||
                        //             value.length < 13) {
                        //           return 'กรุณาใส่ข้อมูล ';
                        //         }
                        //         return null;
                        //       },
                        //       // maxLength: 13,
                        //       cursorColor: Colors.green,
                        //       decoration: InputDecoration(
                        //           fillColor:
                        //               const Color.fromARGB(255, 209, 255, 205)
                        //                   .withOpacity(0.3),
                        //           filled: true,
                        //           labelText: 'ชื่อไฟล์',
                        //           labelStyle: const TextStyle(
                        //             color: ReportScreen_Color.Colors_Text2_,
                        //             // fontWeight: FontWeight.bold,
                        //             fontFamily: Font_.Fonts_T,
                        //           )),
                        //       inputFormatters: <TextInputFormatter>[
                        //         FilteringTextInputFormatter(
                        //             RegExp("[@.!#%&'*+=?^`{|}~-]"),
                        //             allow: false),
                        //         FilteringTextInputFormatter.deny(
                        //             RegExp("[' ']")),
                        //       ],
                        //     ),
                        //   ),
                        // if (FormNameFile_text.text.isEmpty &&
                        //     _verticalGroupValue_NameFile == 'กำหนดเอง')
                        //   const Text(
                        //     'กรุณาใส่ข้อมูล',
                        //     style: TextStyle(
                        //       color: Colors.red, fontSize: 10,
                        //       // fontWeight: FontWeight.bold,
                        //       fontFamily: Font_.Fonts_T,
                        //       // fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // const Text(
                        //   'ชื่อไฟล์ :',
                        //   style: TextStyle(
                        //     color: ReportScreen_Color.Colors_Text2_,
                        //     // fontWeight: FontWeight.bold,
                        //     fontFamily: Font_.Fonts_T,

                        //     // fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.3),
                        //     borderRadius: const BorderRadius.only(
                        //       topLeft: Radius.circular(15),
                        //       topRight: Radius.circular(15),
                        //       bottomLeft: Radius.circular(15),
                        //       bottomRight: Radius.circular(15),
                        //     ),
                        //     border: Border.all(color: Colors.grey, width: 1),
                        //   ),
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: RadioGroup<String>.builder(
                        //     direction: Axis.horizontal,
                        //     groupValue: _verticalGroupValue_NameFile,
                        //     horizontalAlignment: MainAxisAlignment.spaceAround,
                        //     onChanged: (value) async {
                        //       setState(() {
                        //         _verticalGroupValue_NameFile = 'กำหนดเอง';

                        //         FormNameFile_text.clear();
                        //       });
                        //       setState(() {
                        //         _verticalGroupValue_NameFile = value ?? '';
                        //       });
                        //     },
                        //     items: const <String>[
                        //       "จากระบบ",
                        //       "กำหนดเอง",
                        //     ],
                        //     textStyle: const TextStyle(
                        //       fontSize: 15,
                        //       color: ReportScreen_Color.Colors_Text2_,
                        //       // fontWeight: FontWeight.bold,
                        //       fontFamily: Font_.Fonts_T,
                        //     ),
                        //     itemBuilder: (item) => RadioButtonBuilder(
                        //       item,
                        //     ),
                        //   ),
                        // ),
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
                              "PDF",
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
                                bottomRight: Radius.circular(10)),
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
                                      : const AssetImage(
                                          'images/excel_icon.gif'),
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
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  void InkWell_onTap(context) async {
    setState(() {
      NameFile_ = '';
      NameFile_ = FormNameFile_text.text;
    });

    if (_verticalGroupValue_NameFile == 'กำหนดเอง') {
      if (FormNameFile_text.text.isNotEmpty) {
        if (_verticalGroupValue_PassW == 'PDF') {
          if (Value_Report == 'ภาษี') {
          } else if (Value_Report == 'รายงานรายรับ') {
          } else if (Value_Report == 'รายงานรายจ่าย') {
          } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          } else if (Value_Report == 'รายงานประจำวัน') {
            Pdfgen_DailyReport.displayPdf_DailyReport(
                context,
                renTal_name,
                Value_Report,
                Pre_and_Dow,
                _verticalGroupValue_NameFile,
                NameFile_,
                _TransReBillModels,
                TransReBillModels);
          }

          Navigator.of(context).pop();
        } else {
          if (Value_Report == 'รายงานประจำวัน') {
            _exportExcel_DailyReport(NameFile_, _verticalGroupValue_NameFile,
                Value_Report, _TransReBillModels, TransReBillModels);
          } else if (Value_Report == 'รายงานรายรับ') {
            _exportExcel_IncomeReport(
                NameFile_, _verticalGroupValue_NameFile, Value_Report);
          } else if (Value_Report == 'รายงานรายจ่าย') {
            _exportExcel_ExpenseReport(
                NameFile_, _verticalGroupValue_NameFile, Value_Report);
          } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
            _exportExcel_BankmovemenReport(
                NameFile_, _verticalGroupValue_NameFile, Value_Report);
          } else {
            _exportExcel_DailyReport(NameFile_, _verticalGroupValue_NameFile,
                Value_Report, _TransReBillModels, TransReBillModels);
          }

          Navigator.of(context).pop();
        }
      }
    } else {
      if (_verticalGroupValue_PassW == 'PDF') {
        if (Value_Report == 'ภาษี') {
        } else if (Value_Report == 'รายงานรายรับ') {
        } else if (Value_Report == 'รายงานรายจ่าย') {
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
        } else if (Value_Report == 'รายงานประจำวัน') {
          Pdfgen_DailyReport.displayPdf_DailyReport(
              context,
              renTal_name,
              Value_Report,
              Pre_and_Dow,
              _verticalGroupValue_NameFile,
              NameFile_,
              _TransReBillModels,
              TransReBillModels);
        }

        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'ภาษี') {
          // _exportPDF();
          // Pdfgen_Quotation.exportPDF_Quotation();
          _exportExcel_DailyReport(NameFile_, _verticalGroupValue_NameFile,
              Value_Report, _TransReBillModels, TransReBillModels);
        } else if (Value_Report == 'รายงานรายรับ') {
          _exportExcel_IncomeReport(
              NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานรายจ่าย') {
          _exportExcel_ExpenseReport(
              NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
          _exportExcel_BankmovemenReport(
              NameFile_, _verticalGroupValue_NameFile, Value_Report);
        } else if (Value_Report == 'รายงานประจำวัน') {
          _exportExcel_DailyReport(NameFile_, _verticalGroupValue_NameFile,
              Value_Report, _TransReBillModels, TransReBillModels);
        }

        Navigator.of(context).pop();
      }
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

  //////////////////////////////////------------------------->(รายงานประจำวัน)
  void _exportExcel_DailyReport(NameFile_, _verticalGroupValue_NameFile,
      Value_Report, _TransReBillModels, TransReBillModels) async {
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

//     //Adding a picture
//     final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
//     final Uint8List image = bytes_image.buffer
//         .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
// // Adding an image.
//     sheet.pictures.addStream(1, 1, image);
//     final x.Picture picture = sheet.pictures[0];

// // Re-size an image
//     picture.height = 200;
//     picture.width = 200;

// // rotate an image.
//     picture.rotation = 100;

// // Flip an image.
//     picture.horizontalFlip = true;
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    sheet.getRangeByName('K1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานประจำวัน');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('K2').setText(
        'ณ วันที่: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('K2').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('K3').cellStyle = globalStyle2;

    sheet.getRangeByName('A3').columnWidth = 18;
    sheet.getRangeByName('B3').columnWidth = 18;
    sheet.getRangeByName('C3').columnWidth = 18;
    sheet.getRangeByName('D3').columnWidth = 18;
    sheet.getRangeByName('E3').columnWidth = 18;
    sheet.getRangeByName('F3').columnWidth = 18;
    sheet.getRangeByName('G3').columnWidth = 18;
    sheet.getRangeByName('H3').columnWidth = 18;
    sheet.getRangeByName('I3').columnWidth = 18;
    sheet.getRangeByName('J3').columnWidth = 18;
    sheet.getRangeByName('K3').columnWidth = 18;

    sheet.getRangeByName('A3').setText('เลขที่ใบเสร็จ');
    sheet.getRangeByName('B3').setText('ลำดับ');
    sheet.getRangeByName('C3').setText('กำหนดชำระ');
    sheet.getRangeByName('D3').setText('รายการ');
    sheet.getRangeByName('E3').setText('Vat%');
    sheet.getRangeByName('F3').setText('หน่วย');
    sheet.getRangeByName('G3').setText('VAT');
    sheet.getRangeByName('H3').setText('70%');
    sheet.getRangeByName('I3').setText('30%');
    sheet.getRangeByName('J3').setText('ราคาก่อน Vat');
    sheet.getRangeByName('K3').setText('ราคาราม Vat');

    int indextotol = 0;
    for (var i1 = 0; i1 < _TransReBillModels.length; i1++) {
      if (_TransReBillModels[i1].doctax == '') {
        print(_TransReBillModels[i1].docno);
      } else {
        print(_TransReBillModels[i1].doctax);
      }
      for (var i2 = 0; i2 < TransReBillModels[i1].length; i2++) {
        // if (i1 == 0) {
        //   indextotol = indextotol + 0;
        // } else {
        //   indextotol = indextotol + 1;
        // }
        indextotol = indextotol + 1;
        print('${TransReBillModels[i1][i2].expname}');
        print('${indextotol}');

        sheet.getRangeByName('A${indextotol + 4 - 1}').setText(
            TransReBillModels[i1][i2].doctax == ''
                ? ' ${TransReBillModels[i1][i2].docno}'
                : '${TransReBillModels[i1][i2].doctax}');

        sheet.getRangeByName('B${indextotol + 4 - 1}').setText('${i2 + 1}');

        sheet
            .getRangeByName('C${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].date}');

        sheet
            .getRangeByName('D${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].expname}');

        sheet
            .getRangeByName('E${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].nvat}');

        sheet
            .getRangeByName('F${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].vtype}');

        sheet
            .getRangeByName('G${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].vat}');
        sheet
            .getRangeByName('H${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].ramt}');
        sheet
            .getRangeByName('I${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].ramtd}');
        sheet
            .getRangeByName('J${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].amt}');
        sheet
            .getRangeByName('K${indextotol + 4 - 1}')
            .setText('${TransReBillModels[i1][i2].total}');
      }
      print('-------------------------');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานประจำวัน(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }

  //////////////////////////////////------------------------->(รายงานรายรับ)
  void _exportExcel_IncomeReport(
      NameFile_, _verticalGroupValue_NameFile, Value_Report) async {
    // PinCode_, NameFile_, _verticalGroupValue_NameFile
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานรายรับ');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').setText(
        'ณ วันที่: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').setText('ลำดับ');
    sheet.getRangeByName('B3').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('C3').setText('ชื่อร้านค้า');
    sheet.getRangeByName('D3').setText('โซนพื้นที่');
    sheet.getRangeByName('E3').setText('รหัสพื้นที่');
    sheet.getRangeByName('F3').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('G3').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('H3').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('I3').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('J3').setText('สถานะ');
    final double width = 15;

    for (var index = 0; index < 10; index++) {
      print('customerAndAreaModels[i].ser ////-----> ${index}');
      sheet.getRangeByName('A${index + 4}').setText('$index');
      sheet.getRangeByName('B${index + 4}').setText('$index');
      sheet.getRangeByName('C${index + 4}').setText('$index');
      sheet.getRangeByName('D${index + 4}').setText('$index');
      sheet.getRangeByName('E${index + 4}').setText('$index');
      sheet.getRangeByName('F${index + 4}').setText('$index');
      sheet.getRangeByName('G${index + 4}').setText('');
      sheet.getRangeByName('H${index + 4}').setText('');
      sheet.getRangeByName('I${index + 4}').setText('');
      sheet.getRangeByName('J${index + 4}').setText('');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานรายรับ(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }

  //////////////////////////////////------------------------->(รายงานรายจ่าย)
  void _exportExcel_ExpenseReport(
      NameFile_, _verticalGroupValue_NameFile, Value_Report) async {
    // PinCode_, NameFile_, _verticalGroupValue_NameFile
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานรายจ่าย');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').setText(
        'ณ วันที่: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').setText('ลำดับ');
    sheet.getRangeByName('B3').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('C3').setText('ชื่อร้านค้า');
    sheet.getRangeByName('D3').setText('โซนพื้นที่');
    sheet.getRangeByName('E3').setText('รหัสพื้นที่');
    sheet.getRangeByName('F3').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('G3').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('H3').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('I3').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('J3').setText('สถานะ');
    final double width = 15;

    for (var i = 0; i < 10; i++) {
      print('customerAndAreaModels[i].ser ////-----> ${i}');
      sheet.getRangeByName('A${i + 4}').setText('$i');
      sheet.getRangeByName('B${i + 4}').setText('$i');
      sheet.getRangeByName('C${i + 4}').setText('$i');
      sheet.getRangeByName('D${i + 4}').setText('$i');
      sheet.getRangeByName('E${i + 4}').setText('$i');
      sheet.getRangeByName('F${i + 4}').setText('$i');
      sheet.getRangeByName('G${i + 4}').setText('');
      sheet.getRangeByName('H${i + 4}').setText('');
      sheet.getRangeByName('I${i + 4}').setText('');
      sheet.getRangeByName('J${i + 4}').setText('');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานรายจ่าย(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }

  //////////////////////////////////------------------------->(รายงานการเคลื่อนไหวธนาคาร)
  void _exportExcel_BankmovemenReport(
      NameFile_, _verticalGroupValue_NameFile, Value_Report) async {
    // PinCode_, NameFile_, _verticalGroupValue_NameFile
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานการเคลื่อนไหวธนาคาร');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password
    // if (PinCode_ != '') sheet.protect("$PinCode_", options);
    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').setText(
        'ณ วันที่: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').setText('ลำดับ');
    sheet.getRangeByName('B3').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('C3').setText('ชื่อร้านค้า');
    sheet.getRangeByName('D3').setText('โซนพื้นที่');
    sheet.getRangeByName('E3').setText('รหัสพื้นที่');
    sheet.getRangeByName('F3').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('G3').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('H3').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('I3').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('J3').setText('สถานะ');
    final double width = 15;

    for (var i = 0; i < 10; i++) {
      print('customerAndAreaModels[i].ser ////-----> ${i}');
      sheet.getRangeByName('A${i + 4}').setText('$i');
      sheet.getRangeByName('B${i + 4}').setText('$i');
      sheet.getRangeByName('C${i + 4}').setText('$i');
      sheet.getRangeByName('D${i + 4}').setText('$i');
      sheet.getRangeByName('E${i + 4}').setText('$i');
      sheet.getRangeByName('F${i + 4}').setText('$i');
      sheet.getRangeByName('G${i + 4}').setText('');
      sheet.getRangeByName('H${i + 4}').setText('');
      sheet.getRangeByName('I${i + 4}').setText('');
      sheet.getRangeByName('J${i + 4}').setText('');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานการเคลื่อนไหวธนาคาร(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }

  //////////////////////////////////------------------------->(รายงานภาษี)
  void _exportExcel_TaxReport(
      NameFile_, _verticalGroupValue_NameFile, Value_Report) async {
    // PinCode_, NameFile_, _verticalGroupValue_NameFile
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 90, 192, 59);
    x.Style globalStyle2 = workbook.styles.add('style2');
    globalStyle2.backColorRgb = const Color.fromARGB(255, 147, 223, 124);
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').cellStyle = globalStyle;
    sheet.getRangeByName('C1').cellStyle = globalStyle;
    sheet.getRangeByName('D1').cellStyle = globalStyle;
    sheet.getRangeByName('E1').cellStyle = globalStyle;
    sheet.getRangeByName('F1').cellStyle = globalStyle;
    sheet.getRangeByName('G1').cellStyle = globalStyle;
    sheet.getRangeByName('H1').cellStyle = globalStyle;
    sheet.getRangeByName('I1').cellStyle = globalStyle;
    sheet.getRangeByName('J1').cellStyle = globalStyle;
    final x.Range range = sheet.getRangeByName('E1');
    range.setText('รายงานภาษี');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle2;
    sheet.getRangeByName('B2').cellStyle = globalStyle2;
    sheet.getRangeByName('C2').cellStyle = globalStyle2;
    sheet.getRangeByName('D2').cellStyle = globalStyle2;
    sheet.getRangeByName('E2').cellStyle = globalStyle2;
    sheet.getRangeByName('F2').cellStyle = globalStyle2;
    sheet.getRangeByName('G2').cellStyle = globalStyle2;
    sheet.getRangeByName('H2').cellStyle = globalStyle2;
    sheet.getRangeByName('I2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').cellStyle = globalStyle2;
    sheet.getRangeByName('J2').setText(
        'ณ วันที่: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');

    sheet.getRangeByName('A3').cellStyle = globalStyle2;
    sheet.getRangeByName('B3').cellStyle = globalStyle2;
    sheet.getRangeByName('C3').cellStyle = globalStyle2;
    sheet.getRangeByName('D3').cellStyle = globalStyle2;
    sheet.getRangeByName('E3').cellStyle = globalStyle2;
    sheet.getRangeByName('F3').cellStyle = globalStyle2;
    sheet.getRangeByName('G3').cellStyle = globalStyle2;
    sheet.getRangeByName('H3').cellStyle = globalStyle2;
    sheet.getRangeByName('I3').cellStyle = globalStyle2;
    sheet.getRangeByName('J3').cellStyle = globalStyle2;
    sheet.getRangeByName('A3').setText('ลำดับ');
    sheet.getRangeByName('B3').setText('ชื่อผู้ติดต่อ');
    sheet.getRangeByName('C3').setText('ชื่อร้านค้า');
    sheet.getRangeByName('D3').setText('โซนพื้นที่');
    sheet.getRangeByName('E3').setText('รหัสพื้นที่');
    sheet.getRangeByName('F3').setText('ขนาดพื้นที่(ต.ร.ม.)');
    sheet.getRangeByName('G3').setText('ระยะเวลาการเช่า');
    sheet.getRangeByName('H3').setText('วันเริ่มสัญญา');
    sheet.getRangeByName('I3').setText('วันสิ้นสุดสัญญา');
    sheet.getRangeByName('J3').setText('สถานะ');
    final double width = 15;

    for (var i = 0; i < 10; i++) {
      print('customerAndAreaModels[i].ser ////-----> ${i}');
      sheet.getRangeByName('A${i + 4}').setText('รายงานภาษี$i');
      sheet.getRangeByName('B${i + 4}').setText('รายงานภาษี$i');
      sheet.getRangeByName('C${i + 4}').setText('รายงานภาษี$i');
      sheet.getRangeByName('D${i + 4}').setText('รายงานภาษี$i');
      sheet.getRangeByName('E${i + 4}').setText('รายงานภาษี$i');
      sheet.getRangeByName('F${i + 4}').setText('รายงานภาษี$i');
      sheet.getRangeByName('G${i + 4}').setText('');
      sheet.getRangeByName('H${i + 4}').setText('');
      sheet.getRangeByName('I${i + 4}').setText('');
      sheet.getRangeByName('J${i + 4}').setText('');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;

    if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
      String path = await FileSaver.instance.saveFile(
          "รายงานภาษี(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
          data,
          "xlsx",
          mimeType: type);
      log(path);
    } else {
      String path = await FileSaver.instance
          .saveFile("$NameFile_", data, "xlsx", mimeType: type);
      log(path);
    }
  }

  //////////////////////////////////----------------------------------------->
  List<Color> barColors = [
    Colors.red,
    const Color.fromARGB(255, 118, 209, 121),
    Colors.purple,
    Colors.blue,
    Colors.orange,
    Colors.black,
  ];
//////////////////////////////////----------------------------------------->
  ///
  Widget build(BuildContext context) {
    /////////-------------------------->(ใกล้หมดสัญญา)
    double chart_1 = (double.parse(areaModels1.length.toString()) /
            double.parse(areaModels.length.toString())) *
        (100);
    /////////-------------------------->(ว่าง)
    double chart_2 = (double.parse(areaModels2.length.toString()) /
            double.parse(areaModels.length.toString())) *
        (100);
    /////////-------------------------->(เช่าอยู่)
    double chart_3 = (double.parse(areaModels.length.toString()) != 0)
        ? (double.parse(areaModels3.length.toString()) /
                double.parse(areaModels.length.toString())) *
            (100)
        : 0.0;
    /////////-------------------------->(รอทำสัญญา)
    double chart_4 = (double.parse(areaModels.length.toString()) != 0)
        ? (double.parse(customerModels.length.toString()) /
                double.parse(areaModels.length.toString())) *
            (100)
        : 0.0;
    /////////-------------------------->(ค้างชำระ)
    double chart_5 = 2.5;

    //////////---------------------------------->
    List<double> barValue = [
      // double.parse(areaModels.length.toString()),
      (chart_1.toString() == 'NaN') ? 0 : chart_1,
      (chart_2.toString() == 'NaN') ? 0 : chart_2,
      (chart_3.toString() == 'NaN') ? 0 : chart_3,
      (chart_4.toString() == 'NaN') ? 0 : chart_4,
      (chart_5.toString() == 'NaN') ? 0 : chart_5,
    ];

    List<String> bottomBarName = [
      // "พื้นที่ทั้งหมด(${areaModels.length})",
      "ใกล้หมดสัญญา(${areaModels1.length})",
      "ว่าง(${areaModels2.length})",
      "เช่าอยู่(${areaModels3.length})",
      "รอทำสัญญา(${customerModels.length})",

      "ค้างชำระ(${0})"
    ];
    //////////---------------------------------->
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
                      children: const [
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
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: const [
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
            (!Responsive.isDesktop(context))
                ? BodyHome_mobile(barValue, bottomBarName)
                : BodyHome_Web(barValue, bottomBarName),
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
                    Row(
                      children: const [
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
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                              Insert_log.Insert_logs(
                                  'รายงาน', 'กดดูรายงานรายรับ');
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
                                          'รายงานรายรับ',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        )),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'วันที่: $Value_selectDate1 ถึง  $Value_selectDate2',
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
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ทั้งหมด: ',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
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
                                    content: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                      }),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.grey[50],
                                              width: (Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9
                                                  : 800,
                                              // height:
                                              //     MediaQuery.of(context).size.height *
                                              //         0.4,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
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
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'ลำดับ',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Center(
                                                              child: Text(
                                                            'รายการ',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'xxxxx',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'xxxxx',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: (Responsive
                                                            .isDesktop(context))
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9
                                                        : 800,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    child: ListView.builder(
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                          title: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    '${index + 1}',
                                                                    maxLines: 1,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: ReportScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T,
                                                                    ),
                                                                  )),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                                                                    maxLines: 1,
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
                                                                  )),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    '300000',
                                                                    maxLines: 1,
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
                                                                  )),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    '400000',
                                                                    maxLines: 1,
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
                                                                  )),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 20, 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 120,
                                              width: 240,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(
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
                                                        child: const Center(
                                                          child: Text(
                                                            'รวม',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
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
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 70%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 30%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคาก่อน Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคารวม Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      const Divider(),
                                      const SizedBox(height: 1),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 8, 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
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
                                                    setState(() {
                                                      Value_Report =
                                                          'รายงานรายรับ';
                                                      Pre_and_Dow = 'Download';
                                                    });
                                                    _showMyDialog_SAVE();
                                                    Navigator.pop(context);
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
                                                      color: Colors.green,
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
                                                        'Print',
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
                                                      Value_Report =
                                                          'รายงานรายรับ';
                                                      Pre_and_Dow = 'Preview';
                                                    });
                                                    Navigator.pop(context);

                                                    _displayPdf_();
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
                                                  onTap: () {
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
                          // InkWell(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.yellow[600],
                          //       borderRadius: const BorderRadius.only(
                          //           topLeft: Radius.circular(10),
                          //           topRight: Radius.circular(10),
                          //           bottomLeft: Radius.circular(10),
                          //           bottomRight: Radius.circular(10)),
                          //       border:
                          //           Border.all(color: Colors.grey, width: 1),
                          //     ),
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: PopupMenuButton(
                          //       child: Center(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: const [
                          //             Text(
                          //               'เรียกดู',
                          //               style: TextStyle(
                          //                 color:
                          //                     ReportScreen_Color.Colors_Text1_,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontFamily: FontWeight_.Fonts_T,
                          //               ),
                          //             ),
                          //             Icon(
                          //               Icons.navigate_next,
                          //               color: Colors.grey,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //       itemBuilder: (BuildContext context) =>
                          //           (Value_selectDate1 == null ||
                          //                   Value_selectDate2 == null)
                          //               ? [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'กรุณาระบุวันที่ เริ่มต้น-สิ้นสุด ก่อน!',
                          //                                     style: TextStyle(
                          //                                         color: Colors
                          //                                             .red,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ]
                          //               : [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานรายรับ';
                          //                             Pre_and_Dow = 'Preview';
                          //                           });
                          //                           Navigator.pop(context);

                          //                           _displayPdf_();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Preview & Print',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานรายรับ';
                          //                             Pre_and_Dow = 'Download';
                          //                           });
                          //                           _showMyDialog_SAVE();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Download',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ],
                          //     ),
                          //   ),
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงานรายรับ',
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                              Insert_log.Insert_logs(
                                  'รายงาน', 'กดดูรายงานรายจ่าย');
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
                                          'รายงานรายจ่าย',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        )),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'วันที่: $Value_selectDate1 ถึง  $Value_selectDate2',
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
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ทั้งหมด: ',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
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
                                    content: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                      }),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.grey[50],
                                              width: (Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9
                                                  : 800,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
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
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'ลำดับ',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Center(
                                                              child: Text(
                                                            'รายการ',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'xxxxx',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'xxxxx',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      width: (Responsive
                                                              .isDesktop(
                                                                  context))
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9
                                                          : 800,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      child: ListView.builder(
                                                        itemCount: 5,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return ListTile(
                                                            title: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: Center(
                                                                        child: Text(
                                                                      '${index + 1}',
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child:
                                                                      Container(
                                                                    child: const Center(
                                                                        child: Text(
                                                                      'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: const Center(
                                                                        child: Text(
                                                                      '300000',
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: const Center(
                                                                        child: Text(
                                                                      '400000',
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ],
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
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 20, 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 120,
                                              width: 240,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(
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
                                                        child: const Center(
                                                          child: Text(
                                                            'รวม',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
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
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 70%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 30%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคาก่อน Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคารวม Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      const Divider(),
                                      const SizedBox(height: 1),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 8, 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
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
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      Value_Report =
                                                          'รายงานรายจ่าย';
                                                      Pre_and_Dow = 'Download';
                                                    });
                                                    _showMyDialog_SAVE();
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
                                                      color: Colors.green,
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
                                                        'Print',
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
                                                      Value_Report =
                                                          'รายงานรายจ่าย';
                                                      Pre_and_Dow = 'Preview';
                                                    });
                                                    Navigator.pop(context);
                                                    _displayPdf_();
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
                                                  onTap: () {
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
                          // InkWell(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.yellow[600],
                          //       borderRadius: const BorderRadius.only(
                          //           topLeft: Radius.circular(10),
                          //           topRight: Radius.circular(10),
                          //           bottomLeft: Radius.circular(10),
                          //           bottomRight: Radius.circular(10)),
                          //       border:
                          //           Border.all(color: Colors.grey, width: 1),
                          //     ),
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: PopupMenuButton(
                          //       child: Center(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: const [
                          //             Text(
                          //               'เรียกดู',
                          //               style: TextStyle(
                          //                 color:
                          //                     ReportScreen_Color.Colors_Text1_,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontFamily: FontWeight_.Fonts_T,
                          //               ),
                          //             ),
                          //             Icon(
                          //               Icons.navigate_next,
                          //               color: Colors.grey,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //       itemBuilder: (BuildContext context) =>
                          //           (Value_selectDate1 == null ||
                          //                   Value_selectDate2 == null)
                          //               ? [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'กรุณาระบุวันที่ เริ่มต้น-สิ้นสุด ก่อน!',
                          //                                     style: TextStyle(
                          //                                         color: Colors
                          //                                             .red,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ]
                          //               : [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานรายจ่าย';
                          //                             Pre_and_Dow = 'Preview';
                          //                           });
                          //                           Navigator.pop(context);
                          //                           _displayPdf_();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Preview & Print',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานรายจ่าย';
                          //                             Pre_and_Dow = 'Download';
                          //                           });
                          //                           _showMyDialog_SAVE();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Download',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ],
                          //     ),
                          //   ),
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงานรายจ่าย',
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                              Insert_log.Insert_logs(
                                  'รายงาน', 'กดดูรายงานการเคลื่อนไหวธนาคาร');
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
                                          'รายงานการเคลื่อนไหวธนาคาร',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        )),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'วันที่: $Value_selectDate1 ถึง  $Value_selectDate2',
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
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ทั้งหมด: ',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
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
                                    content: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                      }),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.grey[50],
                                              width: (Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9
                                                  : 1100,
                                              // height:
                                              //     MediaQuery.of(context).size.height *
                                              //         0.3,
                                              child: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppbackgroundColor
                                                                .TiTile_Colors,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: const [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'ลำดับ',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Center(
                                                                child: Text(
                                                              'รายการ',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'เลขบัญชี',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'ชื่อบัญชี',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'จำนวนเงิน',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'เลขประจำตัวประชาชน',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'อ้างอิง',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                                child: Text(
                                                              'เบอร์ติดต่อ',
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                        width: (Responsive
                                                                .isDesktop(
                                                                    context))
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9
                                                            : 1100,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        child: ListView.builder(
                                                          itemCount: 5,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return ListTile(
                                                              title: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      '${index + 1}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 2,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Center(
                                                                        child: Text(
                                                                      'XXX',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ReportScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T,
                                                                      ),
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 20, 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 120,
                                              width: 240,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(
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
                                                        child: const Center(
                                                          child: Text(
                                                            'รวม',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
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
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 70%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 30%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคาก่อน Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคารวม Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      const Divider(),
                                      const SizedBox(height: 1),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 8, 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
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
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      Value_Report =
                                                          'รายงานรายจ่าย';
                                                      Pre_and_Dow = 'Download';
                                                    });
                                                    _showMyDialog_SAVE();
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
                                                      color: Colors.green,
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
                                                        'Print',
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
                                                      Value_Report =
                                                          'รายงานรายจ่าย';
                                                      Pre_and_Dow = 'Preview';
                                                    });
                                                    Navigator.pop(context);
                                                    _displayPdf_();
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
                                                  onTap: () {
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
                          // InkWell(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.yellow[600],
                          //       borderRadius: const BorderRadius.only(
                          //           topLeft: Radius.circular(10),
                          //           topRight: Radius.circular(10),
                          //           bottomLeft: Radius.circular(10),
                          //           bottomRight: Radius.circular(10)),
                          //       border:
                          //           Border.all(color: Colors.grey, width: 1),
                          //     ),
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: PopupMenuButton(
                          //       child: Center(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: const [
                          //             Text(
                          //               'เรียกดู',
                          //               style: TextStyle(
                          //                 color:
                          //                     ReportScreen_Color.Colors_Text1_,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontFamily: FontWeight_.Fonts_T,
                          //               ),
                          //             ),
                          //             Icon(
                          //               Icons.navigate_next,
                          //               color: Colors.grey,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //       itemBuilder: (BuildContext context) =>
                          //           (Value_selectDate1 == null ||
                          //                   Value_selectDate2 == null)
                          //               ? [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'กรุณาระบุวันที่ เริ่มต้น-สิ้นสุด ก่อน!',
                          //                                     style: TextStyle(
                          //                                         color: Colors
                          //                                             .red,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ]
                          //               : [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานการเคลื่อนไหวธนาคาร';
                          //                             Pre_and_Dow = 'Preview';
                          //                           });
                          //                           Navigator.pop(context);
                          //                           _displayPdf_();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Preview & Print',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานการเคลื่อนไหวธนาคาร';
                          //                             Pre_and_Dow = 'Download';
                          //                           });
                          //                           _showMyDialog_SAVE();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Download',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ],
                          //     ),
                          //   ),
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงานการเคลื่อนไหวธนาคาร',
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                              Insert_log.Insert_logs(
                                  'รายงาน', 'กดดูรายงานภาษี');
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
                                          'รายงานภาษี',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        )),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'วันที่: $Value_selectDate1 ถึง  $Value_selectDate2',
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
                                            const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ทั้งหมด: ',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
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
                                    content: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                      }),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.grey[50],
                                              width: (Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9
                                                  : 800,
                                              // height:
                                              //     MediaQuery.of(context).size.height *
                                              //         0.3,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppbackgroundColor
                                                          .TiTile_Colors,
                                                      borderRadius:
                                                          BorderRadius.only(
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
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: const [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'ลำดับ',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Center(
                                                              child: Text(
                                                            'รายการ',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'วันที่',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'XXXX',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                              child: Text(
                                                            'XXX',
                                                            style: TextStyle(
                                                              color: ReportScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: (Responsive
                                                            .isDesktop(context))
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9
                                                        : 800,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    child: ListView.builder(
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                          title: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                  '${index + 1}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: ReportScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                  ),
                                                                )),
                                                              ),
                                                              const Expanded(
                                                                flex: 2,
                                                                child: Center(
                                                                    child: Text(
                                                                  'XXX',
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
                                                                )),
                                                              ),
                                                              const Expanded(
                                                                flex: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                  'XXX',
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
                                                                )),
                                                              ),
                                                              const Expanded(
                                                                flex: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                  'XXX',
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
                                                                )),
                                                              ),
                                                              const Expanded(
                                                                flex: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                  'XXXX',
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
                                                                )),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 20, 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 120,
                                              width: 240,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(
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
                                                        child: const Center(
                                                          child: Text(
                                                            'รวม',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
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
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 70%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 30%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคาก่อน Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคารวม Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Text(
                                                              'xxxxxxx',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      const Divider(),
                                      const SizedBox(height: 1),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 8, 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
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
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      Value_Report =
                                                          'รายงานภาษี';
                                                      Pre_and_Dow = 'Download';
                                                    });
                                                    _showMyDialog_SAVE();
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
                                                      color: Colors.green,
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
                                                        'Print',
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
                                                      Value_Report =
                                                          'รายงานภาษี';
                                                      Pre_and_Dow = 'Preview';
                                                    });
                                                    Navigator.pop(context);
                                                    _displayPdf_();
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
                                                  onTap: () {
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

                          // InkWell(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.yellow[600],
                          //       borderRadius: const BorderRadius.only(
                          //           topLeft: Radius.circular(10),
                          //           topRight: Radius.circular(10),
                          //           bottomLeft: Radius.circular(10),
                          //           bottomRight: Radius.circular(10)),
                          //       border:
                          //           Border.all(color: Colors.grey, width: 1),
                          //     ),
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: PopupMenuButton(
                          //       child: Center(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: const [
                          //             Text(
                          //               'เรียกดู',
                          //               style: TextStyle(
                          //                 color:
                          //                     ReportScreen_Color.Colors_Text1_,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontFamily: FontWeight_.Fonts_T,
                          //               ),
                          //             ),
                          //             Icon(
                          //               Icons.navigate_next,
                          //               color: Colors.grey,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //       itemBuilder: (BuildContext context) =>
                          //           (Value_selectDate1 == null ||
                          //                   Value_selectDate2 == null)
                          //               ? [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'กรุณาระบุวันที่ เริ่มต้น-สิ้นสุด ก่อน!',
                          //                                     style: TextStyle(
                          //                                         color: Colors
                          //                                             .red,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ]
                          //               : [
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานภาษี';
                          //                             Pre_and_Dow = 'Preview';
                          //                           });
                          //                           Navigator.pop(context);
                          //                           _displayPdf_();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Preview & Print',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                   PopupMenuItem(
                          //                     child: InkWell(
                          //                         onTap: () async {
                          //                           Navigator.pop(context);
                          //                           setState(() {
                          //                             Value_Report =
                          //                                 'รายงานภาษี';
                          //                             Pre_and_Dow = 'Download';
                          //                           });
                          //                           _showMyDialog_SAVE();
                          //                         },
                          //                         child: Container(
                          //                             padding:
                          //                                 const EdgeInsets.all(
                          //                                     10),
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                     .size
                          //                                     .width,
                          //                             child: Row(
                          //                               children: const [
                          //                                 Expanded(
                          //                                   child: Text(
                          //                                     'Download',
                          //                                     style: TextStyle(
                          //                                         color: PeopleChaoScreen_Color
                          //                                             .Colors_Text2_,
                          //                                         // fontWeight:
                          //                                         //     FontWeight
                          //                                         //         .bold,
                          //                                         fontFamily: Font_
                          //                                             .Fonts_T),
                          //                                   ),
                          //                                 )
                          //                               ],
                          //                             ))),
                          //                   ),
                          //                 ],
                          //     ),
                          //   ),
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงานภาษี',
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
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'เรียกดู',
                                      style: TextStyle(
                                        color: ReportScreen_Color.Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.navigate_next,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () async {
                              double Sum_Ramt_ = 0.0;
                              double Sum_Ramtd_ = 0.0;
                              double Sum_Amt_ = 0.0;
                              double Sum_Total_ = 0.0;
                              for (int indexsum1 = 0;
                                  indexsum1 < _TransReBillModels.length;
                                  indexsum1++) {
                                for (int indexsum2 = 0;
                                    indexsum2 <
                                        TransReBillModels[indexsum1].length;
                                    indexsum2++) {
                                  Sum_Ramt_ = Sum_Ramt_ +
                                      double.parse(TransReBillModels[indexsum1]
                                              [indexsum2]
                                          .ramt!);
                                  Sum_Ramtd_ = Sum_Ramtd_ +
                                      double.parse(TransReBillModels[indexsum1]
                                              [indexsum2]
                                          .ramtd!);
                                  Sum_Amt_ = Sum_Amt_ +
                                      double.parse(TransReBillModels[indexsum1]
                                              [indexsum2]
                                          .amt!);
                                  Sum_Total_ = Sum_Total_ +
                                      double.parse(TransReBillModels[indexsum1]
                                              [indexsum2]
                                          .total!);
                                }
                              }
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
                                        const Center(
                                            child: Text(
                                          'รายงานประจำวัน',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        )),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'ประจำวันที่: $Value_selectDate',
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
                                    content: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
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
                                              width: (Responsive.isDesktop(
                                                      context))
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9
                                                  : (_TransReBillModels
                                                              .length ==
                                                          0)
                                                      ? MediaQuery.of(context)
                                                          .size
                                                          .width
                                                      : 800,
                                              // height:
                                              //     MediaQuery.of(context)
                                              //             .size
                                              //             .height *
                                              //         0.3,
                                              child:
                                                  (_TransReBillModels.length ==
                                                          0)
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Center(
                                                              child: Text(
                                                                'ไม่พบข้อมูล ณ วันที่เลือก',
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
                                                        )
                                                      : Column(
                                                          children: <Widget>[
                                                            // for (int index1 = 0;
                                                            //     index1 <
                                                            //         _TransReBillModels
                                                            //             .length;
                                                            //     index1++)
                                                            Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.45,
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
                                                                                    decoration: const BoxDecoration(
                                                                                      color: AppbackgroundColor.TiTile_Colors,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Text(
                                                                                      _TransReBillModels[index1].doctax == '' ? '${index1 + 1}. เลขที่ใบเสร็จ: ${_TransReBillModels[index1].docno}' : '${index1 + 1}. เลขที่ใบเสร็จ: ${_TransReBillModels[index1].doctax}',
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
                                                                            SizedBox(
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    decoration: const BoxDecoration(
                                                                                      color: AppbackgroundColor.TiTile_Colors,
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                                    ),
                                                                                    // padding: const EdgeInsets.all(4.0),
                                                                                    child: Row(
                                                                                      children: const [
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
                                                                                            '70 %',
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
                                                                                            '30 %',
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
                                                                                  for (int index2 = 0; index2 < TransReBillModels[index1].length; index2++)
                                                                                    Container(
                                                                                      color: Colors.grey[200],
                                                                                      // padding: const EdgeInsets.all(4.0),
                                                                                      child: Row(
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
                                                                                              '${nFormat.format(double.parse(TransReBillModels[index1][index2].vat!))}',
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
                                                                                              (TransReBillModels[index1][index2].ramt.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramt!))}',
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
                                                                                              (TransReBillModels[index1][index2].ramtd.toString() == 'null') ? '-' : '${nFormat.format(double.parse(TransReBillModels[index1][index2].ramtd!))}',
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
                                                                                              '${nFormat.format(double.parse(TransReBillModels[index1][index2].amt!))}',
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
                                                                                              '${nFormat.format(double.parse(TransReBillModels[index1][index2].total!))}',
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
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 20, 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 120,
                                              width: 240,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(
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
                                                        child: const Center(
                                                          child: Text(
                                                            'รวม',
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
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
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 70%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: Text(
                                                              '${nFormat.format(Sum_Ramt_)}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวม 30%',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: Text(
                                                              '${nFormat.format(Sum_Ramtd_)}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคาก่อน Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: Text(
                                                              '${nFormat.format(Sum_Amt_)}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
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
                                                                          0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0)),
                                                            ),
                                                            child: const Text(
                                                              'รวมราคารวม Vat',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text1_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: Text(
                                                              '${nFormat.format(Sum_Total_)}',
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                color: ReportScreen_Color
                                                                    .Colors_Text2_,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      const Divider(),
                                      const SizedBox(height: 1),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 8, 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
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
                                                    // Navigator.of(context)
                                                    //     .pop();
                                                    if (_TransReBillModels
                                                            .length ==
                                                        0) {
                                                    } else {
                                                      setState(() {
                                                        Value_Report =
                                                            'รายงานประจำวัน';
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
                                                      color: Colors.green,
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
                                                        'Print',
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
                                                    if (_TransReBillModels
                                                            .length ==
                                                        0) {
                                                    } else {
                                                      setState(() {
                                                        Value_Report =
                                                            'รายงานประจำวัน';
                                                        Pre_and_Dow = 'Preview';
                                                      });
                                                      // Navigator.pop(context);
                                                      _displayPdf_();
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
                                                  onTap: () {
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
                          // if (Value_selectDate == null ||
                          //     _TransReBillModels.length == 0)
                          //   InkWell(
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //         color: Colors.yellow[600],
                          //         borderRadius: const BorderRadius.only(
                          //             topLeft: Radius.circular(10),
                          //             topRight: Radius.circular(10),
                          //             bottomLeft: Radius.circular(10),
                          //             bottomRight: Radius.circular(10)),
                          //         border:
                          //             Border.all(color: Colors.grey, width: 1),
                          //       ),
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: PopupMenuButton(
                          //           child: Center(
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: const [
                          //                 Text(
                          //                   'เรียกดู',
                          //                   style: TextStyle(
                          //                     color: ReportScreen_Color
                          //                         .Colors_Text1_,
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
                          //           itemBuilder: (BuildContext context) => [
                          //                 PopupMenuItem(
                          //                   child: InkWell(
                          //                       onTap: () async {
                          //                         Navigator.pop(context);
                          //                       },
                          //                       child: Container(
                          //                           padding:
                          //                               const EdgeInsets.all(
                          //                                   10),
                          //                           width:
                          //                               MediaQuery.of(context)
                          //                                   .size
                          //                                   .width,
                          //                           child: Row(
                          //                             children: [
                          //                               Expanded(
                          //                                 child: Text(
                          //                                   (Value_selectDate !=
                          //                                               null &&
                          //                                           _TransReBillModels
                          //                                                   .length ==
                          //                                               0)
                          //                                       ? 'ไม่มีรายการ ณ วันที่เลือก'
                          //                                       : 'กรุณาระบุวันที่ ก่อน!',
                          //                                   style: const TextStyle(
                          //                                       color:
                          //                                           Colors.red,
                          //                                       fontFamily: Font_
                          //                                           .Fonts_T),
                          //                                 ),
                          //                               )
                          //                             ],
                          //                           ))),
                          //                 ),
                          //               ]),
                          //     ),
                          //   ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงานประจำวัน',
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

  Widget BodyHome_Web(barValue, bottomBarName) {
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
                    height: 260,
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
                              '( พื้นที่ทั้งหมด ${areaModels.length})',
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
                                height: 180,
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
                                                          snapshot.data
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
                                height: 180,
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
                                                          snapshot.data
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
                    height: 260,
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
                        children: const [
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
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 180,
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
                                  sCReportTotalModels.isEmpty
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
                                                          snapshot.data
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
                                                  '${nFormat.format(double.parse(total1_.toString()))}',
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
                                                  'บาท',
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
                                height: 180,
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
                                  sCReportTotalModels2.isEmpty
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
                                                          snapshot.data
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
                                                  '${nFormat.format(double.parse(total2_.toString()))}',
                                                  // '${sCReportTotalModels[0].total}',
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
                                                  'บาท',
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
            ],
          ),
        ),
        // Stack(
        //   children: [
        //     FineBarChart(
        //         barWidth: 30,
        //         barHeight: 150,
        //         backgroundColors: Colors.white,
        //         isBottomNameDisable: false,
        //         isValueDisable: false,
        //         textStyle: const TextStyle(
        //           fontSize: 14,
        //           color: Colors.black,
        //         ),
        //         barBackgroundColors: Colors.grey.withOpacity(0.3),
        //         barValue: barValue,
        //         barColors: barColors,
        //         barBottomName: bottomBarName),
        //     Positioned(
        //       top: 10,
        //       left: 10,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           children: [
        //             const Text(
        //               'ร้อยละ%',
        //               style: TextStyle(
        //                 color: ReportScreen_Color.Colors_Text1_,
        //                 fontWeight: FontWeight.bold,
        //                 fontFamily: FontWeight_.Fonts_T,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }

  Widget BodyHome_mobile(barValue, bottomBarName) {
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
                      '( พื้นที่ทั้งหมด ${areaModels.length})',
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
                        height: 180,
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
                                                  snapshot.data.toString()) *
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
                                            fontSize: 20,
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
                        height: 180,
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
                                                  snapshot.data.toString()) *
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
                                            fontSize: 20,
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
              Row(
                children: const [
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 180,
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
                          sCReportTotalModels.isEmpty
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
                                                  snapshot.data.toString()) *
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
                                          '${nFormat.format(double.parse(total1_.toString()))}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
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
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 180,
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
                          sCReportTotalModels2.isEmpty
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
                                                  snapshot.data.toString()) *
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
                                          '${nFormat.format(double.parse(total2_.toString()))}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 20,
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
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        // Stack(
        //   children: [
        //     FineBarChart(
        //         barWidth: 30,
        //         barHeight: 150,
        //         backgroundColors: Colors.white,
        //         isBottomNameDisable: false,
        //         isValueDisable: false,
        //         textStyle: const TextStyle(
        //           fontSize: 14,
        //           color: Colors.black,
        //         ),
        //         barBackgroundColors: Colors.grey.withOpacity(0.3),
        //         barValue: barValue,
        //         barColors: barColors,
        //         barBottomName: bottomBarName),
        //     Positioned(
        //       top: 10,
        //       left: 10,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           children: const [
        //             Text(
        //               'ร้อยละ%',
        //               style: TextStyle(
        //                 color: ReportScreen_Color.Colors_Text1_,
        //                 fontWeight: FontWeight.bold,
        //                 fontFamily: FontWeight_.Fonts_T,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  void _displayPdf_() async {
    if (Value_Report == 'รายงานรายรับ') {
      _displayPdf_IncomeReport();
    } else if (Value_Report == 'รายงานรายจ่าย') {
      _displayPdf_ExpenseReport();
    } else if (Value_Report == 'รายงานการเคลื่อนไหวธนาคาร') {
      _displayPdf_BankmovementReport();
    } else if (Value_Report == 'รายงานภาษี') {
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
          TransReBillModels);
    }
  }

/////////////////////////////////////-------------------->(รายงานรายรับ)
  void _displayPdf_IncomeReport() async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    final tableHeaders = [
      'ลำดับ',
      'หมวด',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 1',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 2',
      // 'ต.ค.',
      // 'พ.ย.',
      // 'ธ.ค.',
      // 'ผลรวมไตรมาส 3',
      // 'ต.ค.',
      // 'พ.ย.',
      // 'ธ.ค.',
      // 'ผลรวมไตรมาส 4',
      // 'รวม',
    ];
    final tableHeaders2 = [
      'ลำดับ',
      'หมวด',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 3',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 4',
    ];
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    final tableData1 = [
      for (int i = 0; i < 5; i++)
        [
          '${i + 1}',
          'สามารถนํารายรับจากรายงานเงินสดรับ-จ่าย',
          '300000',
          '400000',
          '500000',
          '600000',
          '700000',
          '800000',
          '900000',
          '1000000',
        ],
    ];

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
                // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                //   marginAll: 20
                PdfPageFormat.a4.height,
                PdfPageFormat.a4.width,
                marginAll: 20),
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Image(
                          pw.MemoryImage(iconImage),
                          height: 70,
                          width: 70,
                        ),
                        pw.Text('${renTal_name}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    ),
                    pw.Text('${Value_Report}',
                        style: pw.TextStyle(
                          fontSize: 20.0,
                          font: ttf,
                          color: PdfColors.grey900,
                          fontWeight: pw.FontWeight.bold,
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    pw.Column(
                      children: [
                        pw.Text('วันที่ : ${day_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                        pw.Text('เวลา : ${Tim_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('ไตรมาสที่ 1 และ 2',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                        font: ttf,
                        color: PdfColors.grey900,
                        fontWeight: pw.FontWeight.bold,
                      )
                      // style: pw.TextStyle(fontSize: 30),
                      ),
                ),
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('ไตรมาสที่ 3 และ 4',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                        font: ttf,
                        color: PdfColors.grey900,
                        fontWeight: pw.FontWeight.bold,
                      )
                      // style: pw.TextStyle(fontSize: 30),
                      ),
                ),
                pw.Table.fromTextArray(
                  headers: tableHeaders2,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount} ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    );
    ////////////---------------------------------------------->
    final List<int> bytes = await doc.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    if (Pre_and_Dow == 'Download') {
      ////////////---------------------------------------------->
      if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
        final dir = await FileSaver.instance.saveFile(
            "${Value_Report}(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
            data,
            "pdf",
            mimeType: type);
      } else {
        final dir = await FileSaver.instance
            .saveFile("${NameFile_}", data, "pdf", mimeType: type);
        setState(() {
          _formKey.currentState!.reset();
          FormNameFile_text.clear();
          FormNameFile_text.text = '';
          _verticalGroupValue_NameFile = 'จากระบบ';
        });
      }
      ////////////---------------------------------------------->
    } else {
      // open Preview Screen
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreviewReportScreen(doc: doc, Status_: '${Value_Report}'),
          ));
    }
    ////////////---------------------------------------------->
  }

/////////////////////////////////////-------------------->(รายงานรายจ่าย)
  void _displayPdf_ExpenseReport() async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    final tableHeaders = [
      'ลำดับ',
      'หมวด',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 1',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 2',
      // 'ต.ค.',
      // 'พ.ย.',
      // 'ธ.ค.',
      // 'ผลรวมไตรมาส 3',
      // 'ต.ค.',
      // 'พ.ย.',
      // 'ธ.ค.',
      // 'ผลรวมไตรมาส 4',
      // 'รวม',
    ];
    final tableHeaders2 = [
      'ลำดับ',
      'หมวด',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 3',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.',
      'ผลรวมไตรมาส 4',
    ];
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    final tableData1 = [
      for (int i = 0; i < 5; i++)
        [
          '${i + 1}',
          'สามารถนํารายรับจากรายงานเงินสดรับ-จ่าย',
          '300000',
          '400000',
          '500000',
          '600000',
          '700000',
          '800000',
          '900000',
          '1000000',
        ],
    ];

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
                // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                //   marginAll: 20
                PdfPageFormat.a4.height,
                PdfPageFormat.a4.width,
                marginAll: 20),
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Image(
                          pw.MemoryImage(iconImage),
                          height: 70,
                          width: 70,
                        ),
                        pw.Text('${renTal_name}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    ),
                    pw.Text('${Value_Report}',
                        style: pw.TextStyle(
                          fontSize: 20.0,
                          font: ttf,
                          color: PdfColors.grey900,
                          fontWeight: pw.FontWeight.bold,
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    pw.Column(
                      children: [
                        pw.Text('วันที่ : ${day_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                        pw.Text('เวลา : ${Tim_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('ไตรมาสที่ 1 และ 2',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                        font: ttf,
                        color: PdfColors.grey900,
                        fontWeight: pw.FontWeight.bold,
                      )
                      // style: pw.TextStyle(fontSize: 30),
                      ),
                ),
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('ไตรมาสที่ 3 และ 4',
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 12.0,
                        font: ttf,
                        color: PdfColors.grey900,
                        fontWeight: pw.FontWeight.bold,
                      )
                      // style: pw.TextStyle(fontSize: 30),
                      ),
                ),
                pw.Table.fromTextArray(
                  headers: tableHeaders2,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount} ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    );
    ////////////---------------------------------------------->
    final List<int> bytes = await doc.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    if (Pre_and_Dow == 'Download') {
      ////////////---------------------------------------------->
      if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
        final dir = await FileSaver.instance.saveFile(
            "${Value_Report}(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
            data,
            "pdf",
            mimeType: type);
      } else {
        final dir = await FileSaver.instance
            .saveFile("${NameFile_}", data, "pdf", mimeType: type);
        setState(() {
          _formKey.currentState!.reset();
          FormNameFile_text.clear();
          FormNameFile_text.text = '';
          _verticalGroupValue_NameFile = 'จากระบบ';
        });
      }
      ////////////---------------------------------------------->
    } else {
      // open Preview Screen
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreviewReportScreen(doc: doc, Status_: '${Value_Report}'),
          ));
    }
    ////////////---------------------------------------------->
  }

/////////////////////////////////////-------------------->(รายงานการเคลื่อนไหวธนาคาร)
  void _displayPdf_BankmovementReport() async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    final tableHeaders = [
      'ลำดับ',
      'รายการ',
      'เลขบัญชี',
      'ชื่อบัญชี',
      'จำนวนเงิน',
      'เลขประจำตัวประชาชน',
      'อ้างอิง',
      'เบอร์ติดต่อ',
    ];

    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    final tableData = [
      for (int i = 0; i < 5; i++)
        [
          '${i + 1}',
          'สามารถนํารายรับจากรายงานเงินสดรับ-จ่าย',
          '300000',
          '400000',
          '500000',
          '600000',
          '700000',
          '800000',
        ],
    ];

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
                // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                //   marginAll: 20
                PdfPageFormat.a4.height,
                PdfPageFormat.a4.width,
                marginAll: 20),
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Image(
                          pw.MemoryImage(iconImage),
                          height: 70,
                          width: 70,
                        ),
                        pw.Text('${renTal_name}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    ),
                    pw.Text('${Value_Report}',
                        style: pw.TextStyle(
                          fontSize: 20.0,
                          font: ttf,
                          color: PdfColors.grey900,
                          fontWeight: pw.FontWeight.bold,
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    pw.Column(
                      children: [
                        pw.Text('วันที่ : ${day_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                        pw.Text('เวลา : ${Tim_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  data: tableData,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellDecoration:
                      (int rowIndex, dynamic record, int columnIndex) {
                    return pw.BoxDecoration(
                      color: (rowIndex % 2 == 0)
                          ? PdfColors.grey100
                          : PdfColors.white,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.grey300),
                      ),
                    );
                  },
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount} ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    );
    ////////////---------------------------------------------->
    final List<int> bytes = await doc.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    if (Pre_and_Dow == 'Download') {
      ////////////---------------------------------------------->
      if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
        final dir = await FileSaver.instance.saveFile(
            "${Value_Report}(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
            data,
            "pdf",
            mimeType: type);
      } else {
        final dir = await FileSaver.instance
            .saveFile("${NameFile_}", data, "pdf", mimeType: type);
        setState(() {
          _formKey.currentState!.reset();
          FormNameFile_text.clear();
          FormNameFile_text.text = '';
          _verticalGroupValue_NameFile = 'จากระบบ';
        });
      }
      ////////////---------------------------------------------->
    } else {
      // open Preview Screen
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreviewReportScreen(doc: doc, Status_: '${Value_Report}'),
          ));
    }
    ////////////---------------------------------------------->
  }

/////////////////////////////////////-------------------->(รายงานประจำวัน PDF)
  void _displayPdf_DailyReport() async {
    //final font = await rootBundle.load("fonts/Saysettha-OT.ttf");
    final font = await rootBundle.load("fonts/LINESeedSansTH_Rg.ttf");
    final ttf = pw.Font.ttf(font.buffer.asByteData());
    final doc = pw.Document();

    final tableHeaders = [
      'ลำดับ',
      'ชื่อผู้ติดต่อ',
      'ชื่อร้านค้า',
      'โซนพื้นที่',
      'รหัสพื้นที่',
      'ขนาดพื้นที่(ต.ร.ม.)',
      'ระยะเวลาการเช่า',
      'วันเริ่มสัญญา',
      'วันสิ้นสุดสัญญา',
      'สถานะ',
    ];
    final iconImage =
        (await rootBundle.load('images/LOGO.png')).buffer.asUint8List();
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

    final tableData1 = [
      for (int i = 0; i < 10; i++)
        [
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '10',
        ],
    ];

    doc.addPage(
      pw.MultiPage(
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(
                // PdfPageFormat.a4.width, PdfPageFormat.a4.height,
                //   marginAll: 20
                PdfPageFormat.a4.height,
                PdfPageFormat.a4.width,
                marginAll: 20),
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Image(
                          pw.MemoryImage(iconImage),
                          height: 70,
                          width: 70,
                        ),
                        pw.Text('${renTal_name}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    ),
                    pw.Text('${Value_Report}',
                        style: pw.TextStyle(
                          fontSize: 20.0,
                          font: ttf,
                          color: PdfColors.grey900,
                          fontWeight: pw.FontWeight.bold,
                        )
                        // style: pw.TextStyle(fontSize: 30),
                        ),
                    pw.Column(
                      children: [
                        pw.Text('วันที่ : ${day_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                        pw.Text('เวลา : ${Tim_}',
                            style: pw.TextStyle(
                                fontSize: 10.0,
                                font: ttf,
                                color: PdfColors.grey900)
                            // style: pw.TextStyle(fontSize: 30),
                            ),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  data: tableData1,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontSize: 10.0,
                      fontWeight: pw.FontWeight.bold,
                      font: ttf,
                      color: PdfColors.green900),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.green900),
                    ),
                  ),
                  cellStyle: pw.TextStyle(
                      fontSize: 10.0, font: ttf, color: PdfColors.grey900),
                  cellHeight: 25.0,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                    11: pw.Alignment.centerRight,
                  },
                ),
              ],
            ),
          ];
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                '{fname_}',
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount} ',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 10,
                  font: ttf,
                  color: PdfColors.grey800,
                  // fontWeight: pw.FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    );
    ////////////---------------------------------------------->
    final List<int> bytes = await doc.save();
    final Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.PDF;
    ////////////---------------------------------------------->
    if (Pre_and_Dow == 'Download') {
      ////////////---------------------------------------------->
      if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
        final dir = await FileSaver.instance.saveFile(
            "${Value_Report}(ณ วันที่${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day})",
            data,
            "pdf",
            mimeType: type);
      } else {
        final dir = await FileSaver.instance
            .saveFile("${NameFile_}", data, "pdf", mimeType: type);
        setState(() {
          _formKey.currentState!.reset();
          FormNameFile_text.clear();
          FormNameFile_text.text = '';
          _verticalGroupValue_NameFile = 'จากระบบ';
        });
      }
      ////////////---------------------------------------------->
    } else {
      // open Preview Screen
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreviewReportScreen(doc: doc, Status_: '${Value_Report}'),
          ));
    }
    ////////////---------------------------------------------->
  }
}

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
