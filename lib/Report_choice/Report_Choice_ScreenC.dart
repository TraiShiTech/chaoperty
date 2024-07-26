import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetPakan_Contractx_Choice_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNantRenew_Choice_Model.dart';
import '../Model/GetTeNant_Choice_Model.dart';
import '../Model/GetTrans_BillPay_Choice_Model.dart';
import '../Model/GetTrans_Kon_Choice_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Excel_Area_serviceFeeShort_Report.dart';
import 'Excel_BillPayFutureMonRent_Report_Choice.dart';
import 'Excel_PeopleTenant_Report_Choice.dart';
import 'Excel_SalesTaxFull_Report_Choice.dart';
import 'Excel_SalesTaxShortReport_Choice.dart';
import 'Excel_TeNantNew_Report_Choice.dart';

class Report_Choice_ScreenC extends StatefulWidget {
  const Report_Choice_ScreenC({super.key});

  @override
  State<Report_Choice_ScreenC> createState() => _Report_Choice_ScreenCState();
}

class _Report_Choice_ScreenCState extends State<Report_Choice_ScreenC> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var nFormat2 = NumberFormat("#,##0", "en_US");
  DateTime datex = DateTime.now();
  int? Await_Status_Report1,
      Await_Status_Report2,
      Await_Status_Report3,
      Await_Status_Report4;
  int Ser_BodySta1 = 0;
  int Ser_BodySta2 = 0;
  int Ser_BodySta3 = 0;
  int Ser_BodySta4 = 0;
//-------------------------------------->
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
  String? rtname, type, typex, renname, bill_name, bill_addr, bill_tax;
  String? bill_tel, bill_email, expbill, expbill_name, bill_default;
  String? bill_tser, foder;
  /////////////////---------------------------->
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<PayMentModel> payMentModels = [];
  List<RenTalModel> renTalModels = [];
  List<String> YE_Th = [];
  List<String> Mont_Th = [];

  ///////////////-------------------------------------->
  List<ContractxPakanChoiceModel> contractxPakan = [];
  List<ContractxPakanChoiceModel> _contractxPakan =
      <ContractxPakanChoiceModel>[];

  ///////////////-------------------------------------->
  List<TransBillPayChoiceModel> billpay_Mon = [];
  List<TransBillPayChoiceModel> _billpay_Mon = <TransBillPayChoiceModel>[];
  ///////////////-------------------------------------->
  List<TeNantChoiceModel> teNantModels = [];
  List<TeNantChoiceModel> _teNantModels = <TeNantChoiceModel>[];
  ///////////////-------------------------------------->
  List<TeNantChoiceModel> teNantModels_New = [];
  List<TeNantChoiceModel> _teNantModels_New = <TeNantChoiceModel>[];
  ///////////////-------------------------------------->
  String? Value_Chang_Zone_billpayMon, Value_Chang_Zone_billpayMon_Ser;
  String? Value_Chang_Zone_People_TeNant, Value_Chang_Zone_Ser_People_TeNant;
  String? Value_Chang_Zone_People_TeNantNew,
      Value_Chang_Zone_Ser_People_TeNantNew;
  ///////////////-------------------------------------->

  String? Mon_billpay_Mon, YE_billpay_Mon;
  String? Mon_PeopleTeNant_Mon, YE_PeopleTeNant_Mon;
  String? Mon_PeopleTeNantNew_Mon, YE_PeopleTeNantNew_Mon;
  ///////////////-------------------------------------->
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
  ///////////////-------------------------------------->
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_rental();
    read_GC_zone();
    // read_GC_Exp();
    // read_GC_PayMentModel();
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
            // if (bill_defaultx == 'P') {
            //   bills_name_ = 'บิลธรรมดา';
            // } else {
            //   bills_name_ = 'ใบกำกับภาษี';
            // }
          });
        }
      } else {}
    } catch (e) {
      // print('Error-Dis(read_GC_rental) : ${e}');
    }
    // print('name>>>>>  $renname');
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

////////-------------------------------------------------------->
  Future<Null> TransBill_PayMon() async {
    if (billpay_Mon.isNotEmpty) {
      billpay_Mon.clear();
      _billpay_Mon.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = (Value_Chang_Zone_billpayMon_Ser == null)
        ? '0'
        : Value_Chang_Zone_billpayMon_Ser;
    String url =
        '${MyConstant().domain}/GC_billpay_Report_Choice.php?isAdd=true&ren=$ren&zser=$zone&month_s=$Mon_billpay_Mon&year_s=$YE_billpay_Mon';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TransBillPayChoiceModel billpay_Mons =
              TransBillPayChoiceModel.fromJson(map);

          setState(() {
            billpay_Mon.add(billpay_Mons);
          });
        }
        setState(() {
          _billpay_Mon = billpay_Mon;
        });
      } else {}
    } catch (e) {}
    // print('TransBill_PayTaxShort : ${salesTax_short.length}');
    setState(() {
      Await_Status_Report1 = 1;
    });
  }

  ////////-------------------------------------------------------->(รายงานประวัติผู้เช่า)
  Future<Null> People_tenant() async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
      _teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = (Value_Chang_Zone_Ser_People_TeNant == null)
        ? '0'
        : Value_Chang_Zone_Ser_People_TeNant;
    String url =
        '${MyConstant().domain}/GC_People_Tenant_AllReport_Choice.php?isAdd=true&ren=$ren&zser=$zone&month_s=$Mon_PeopleTeNant_Mon&year_s=$YE_PeopleTeNant_Mon';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantChoiceModel teNantModelss = TeNantChoiceModel.fromJson(map);

          setState(() {
            teNantModels.add(teNantModelss);
          });
        }
        setState(() {
          _teNantModels = teNantModels;
        });
      } else {}
    } catch (e) {}
    // print('People_tenant : ${teNantModels.length}');
    setState(() {
      Await_Status_Report2 = 1;
    });
  }

  ////////-------------------------------------------------------->(รายงานผู้เช่ารายใหม่)
  Future<Null> People_tenant_New() async {
    if (teNantModels_New.isNotEmpty) {
      teNantModels_New.clear();
      _teNantModels_New.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = (Value_Chang_Zone_Ser_People_TeNantNew == null)
        ? '0'
        : Value_Chang_Zone_Ser_People_TeNantNew;
    String url =
        '${MyConstant().domain}/GC_People_TenantNew_AllReport_Choice.php?isAdd=true&ren=$ren&zser=$zone&month_s=$Mon_PeopleTeNantNew_Mon&year_s=$YE_PeopleTeNantNew_Mon';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantChoiceModel teNantModelss = TeNantChoiceModel.fromJson(map);

          setState(() {
            teNantModels_New.add(teNantModelss);
          });
        }
        setState(() {
          _teNantModels_New = teNantModels_New;
        });
      } else {}
    } catch (e) {}
    // print('People_tenant : ${teNantModels.length}');
    setState(() {
      Await_Status_Report3 = 1;
    });
  }

///////////////-------------------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(const Duration(milliseconds: 3600), () {
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
                    'พิเศษ : Choice Ministore - บริษัท ชอยส์ มินิสโตร์ จำกัด ',
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
                      // Container(
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     color: Colors.teal[200],
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(0),
                      //         topRight: Radius.circular(10),
                      //         bottomLeft: Radius.circular(0),
                      //         bottomRight: Radius.circular(10)),
                      //     border: Border.all(color: Colors.grey, width: 1),
                      //   ),
                      //   padding: EdgeInsets.all(4.0),
                      //   child: Text(
                      //     '1. ) ',
                      //     style: TextStyle(
                      //       color: ReportScreen_Color.Colors_Text2_,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: FontWeight_.Fonts_T,
                      //     ),
                      //   ),
                      // ),
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
                            value: (Mon_billpay_Mon == null)
                                ? null
                                : Mon_billpay_Mon,
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
                              Mon_billpay_Mon = value;
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
                            value: (YE_billpay_Mon == null)
                                ? null
                                : YE_billpay_Mon,
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
                              YE_billpay_Mon = value;

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
                            value: Value_Chang_Zone_billpayMon,
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
                                Value_Chang_Zone_billpayMon = value!;
                                Value_Chang_Zone_billpayMon_Ser =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $Value_Chang_Zone_Pakan  //${Value_Chang_Zone_Pakan_Ser}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_Chang_Zone_billpayMon != null) {
                              setState(() {
                                Await_Status_Report1 = 0;
                              });
                              Dia_log();
                            }

                            TransBill_PayMon();
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
                    InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 1), //
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
                        onTap: (Value_Chang_Zone_billpayMon == null ||
                                billpay_Mon.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs('รายงาน',
                                    'กดดูรายงานค่าบริการ-รับล่วงหน้าประจำเดือน ');
                                RE_billpay_future_Widget();
                              }),
                    (billpay_Mon.isEmpty || Await_Status_Report1 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (billpay_Mon.isEmpty &&
                                      Value_Chang_Zone_billpayMon != null &&
                                      Await_Status_Report1 != null)
                                  ? 'รายงานค่าบริการ-รับล่วงหน้าประจำเดือน  (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานค่าบริการ-รับล่วงหน้าประจำเดือน ',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (Await_Status_Report1 == 0)
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
                                      'กำลังโหลดรายงานค่าบริการ-รับล่วงหน้าประจำเดือน...',
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
                                  'กำลังโหลดรายงานค่าบริการ-รับล่วงหน้าประจำเดือน  ✔️',
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
                      // Container(
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     color: Colors.teal[200],
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(0),
                      //         topRight: Radius.circular(10),
                      //         bottomLeft: Radius.circular(0),
                      //         bottomRight: Radius.circular(10)),
                      //     border: Border.all(color: Colors.grey, width: 1),
                      //   ),
                      //   padding: EdgeInsets.all(4.0),
                      //   child: Text(
                      //     '1. ) ',
                      //     style: TextStyle(
                      //       color: ReportScreen_Color.Colors_Text2_,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: FontWeight_.Fonts_T,
                      //     ),
                      //   ),
                      // ),
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
                            value: (Mon_PeopleTeNant_Mon == null)
                                ? null
                                : Mon_PeopleTeNant_Mon,
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
                              Mon_PeopleTeNant_Mon = value;
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
                            value: (YE_PeopleTeNant_Mon == null)
                                ? null
                                : YE_PeopleTeNant_Mon,
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
                              YE_PeopleTeNant_Mon = value;

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
                            value: Value_Chang_Zone_People_TeNant,
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
                                Value_Chang_Zone_People_TeNant = value!;
                                Value_Chang_Zone_Ser_People_TeNant =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $Value_Chang_Zone_Pakan  //${Value_Chang_Zone_Pakan_Ser}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_Chang_Zone_Ser_People_TeNant != null) {
                              setState(() {
                                Await_Status_Report2 = 0;
                              });
                              Dia_log();
                            }

                            People_tenant();
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
                    InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 1), //
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
                        onTap: (Value_Chang_Zone_People_TeNant == null ||
                                teNantModels.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานประวัติผู้เช่า');
                                RE_TeNant_Widget();
                              }),
                    (teNantModels.isEmpty || Await_Status_Report2 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (teNantModels.isEmpty &&
                                      Value_Chang_Zone_People_TeNant != null &&
                                      Await_Status_Report2 != null)
                                  ? 'รายงานประวัติผู้เช่า (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานประวัติผู้เช่า',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (Await_Status_Report2 == 0)
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
                                      'กำลังโหลดรายงานประวัติผู้เช่า...',
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
                                  'รายงานประวัติผู้เช่า ✔️',
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
                      // Container(
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     color: Colors.teal[200],
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(0),
                      //         topRight: Radius.circular(10),
                      //         bottomLeft: Radius.circular(0),
                      //         bottomRight: Radius.circular(10)),
                      //     border: Border.all(color: Colors.grey, width: 1),
                      //   ),
                      //   padding: EdgeInsets.all(4.0),
                      //   child: Text(
                      //     '1. ) ',
                      //     style: TextStyle(
                      //       color: ReportScreen_Color.Colors_Text2_,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: FontWeight_.Fonts_T,
                      //     ),
                      //   ),
                      // ),
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
                            value: (Mon_PeopleTeNantNew_Mon == null)
                                ? null
                                : Mon_PeopleTeNantNew_Mon,
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
                              Mon_PeopleTeNantNew_Mon = value;
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
                            value: (YE_PeopleTeNantNew_Mon == null)
                                ? null
                                : YE_PeopleTeNantNew_Mon,
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
                              YE_PeopleTeNantNew_Mon = value;

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
                            value: Value_Chang_Zone_People_TeNantNew,
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
                                Value_Chang_Zone_People_TeNantNew = value!;
                                Value_Chang_Zone_Ser_People_TeNantNew =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $Value_Chang_Zone_Pakan  //${Value_Chang_Zone_Pakan_Ser}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_Chang_Zone_Ser_People_TeNantNew != null) {
                              setState(() {
                                Await_Status_Report3 = 0;
                              });
                              Dia_log();
                            }

                            People_tenant_New();
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
                    InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 1), //
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
                        onTap: (Value_Chang_Zone_People_TeNantNew == null ||
                                teNantModels_New.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานผู้เช่ารายใหม่');
                                RE_TeNant_New_Widget();
                              }),
                    (teNantModels_New.isEmpty || Await_Status_Report3 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (teNantModels_New.isEmpty &&
                                      Value_Chang_Zone_People_TeNantNew !=
                                          null &&
                                      Await_Status_Report3 != null)
                                  ? 'รายงานผู้เช่ารายใหม่ (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานผู้เช่ารายใหม่',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : (Await_Status_Report3 == 0)
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
                                      'กำลังโหลดรายงานผู้เช่ารายใหม่...',
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
                                  'รายงานผู้เช่ารายใหม่ ✔️',
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
            ])));
  }

  ///////////////////////////----------------------------------------------->(รายงานค่าบริการรับล่วงหน้า )
  RE_billpay_future_Widget() {
    int? ser_index;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, //
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
                      (Value_Chang_Zone_billpayMon == null)
                          ? 'รายงานค่าบริการรับล่วงหน้า ประจำเดือน   (กรุณาเลือกโซน)'
                          : 'รายงานค่าบริการรับล่วงหน้า ประจำเดือน    (โซน : $Value_Chang_Zone_billpayMon)',
                      style: const TextStyle(
                        color: ReportScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    )),
                    Row(
                      children: [
                        // Expanded(
                        //     flex: 1,
                        //     child: Text(
                        //       'ผู้เช่า: ${Status_pe}',
                        //       textAlign: TextAlign.start,
                        //       style: const TextStyle(
                        //         fontSize: 14,
                        //         color: ReportScreen_Color.Colors_Text1_,
                        //         // fontWeight: FontWeight.bold,
                        //         fontFamily: FontWeight_.Fonts_T,
                        //       ),
                        //     )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'ทั้งหมด: ${billpay_Mon.length}',
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
                          // Expanded(
                          //   child: _searchBar_GetbackPakan(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
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
                              : (billpay_Mon.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1100,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child:
                              // (teNantModels.length == 0)
                              //     ? const Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Center(
                              //             child: Text(
                              //               'ไม่พบข้อมูล ณ วันที่เลือก',
                              //               style: TextStyle(
                              //                 color:
                              //                     ReportScreen_Color.Colors_Text1_,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontFamily: FontWeight_.Fonts_T,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     :
                              Column(
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: const Text(
                                        'ลำดับที่',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'วันที่',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขใบกำกับภาษี',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'รายชื่อลูกค้า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'สาขา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'เลขประจำตัวผู้เสียภาษี',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ค่าเช่า',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ค่าเช่า-ภาษีมูลค่าเพิ่ม',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ค่าบริการพื้นที่',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ค่าบริการพื้นที่-ภาษีมูลค่าเพิ่ม',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        ' จำนวนเงินรวม ',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
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
                                itemCount: billpay_Mon.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
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
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${index + 1}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${billpay_Mon[index].daterec}',
                                              // '${transKonModels[index].pdate}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (billpay_Mon[index].doctax ==
                                                      null)
                                                  ? '${billpay_Mon[index].docno}'
                                                  : '${billpay_Mon[index].doctax}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${billpay_Mon[index].cname}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${billpay_Mon[index].ln}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${billpay_Mon[index].tax}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (billpay_Mon[index].rent_amt ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${billpay_Mon[index].rent_amt}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (billpay_Mon[index].rent_vat ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${billpay_Mon[index].rent_vat}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (billpay_Mon[index].service_amt ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${billpay_Mon[index].service_amt}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (billpay_Mon[index].service_vat ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${billpay_Mon[index].service_vat}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (billpay_Mon[index].rent_total ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                              '${billpay_Mon[index].rent_total}') +
                                                          double.parse(
                                                              '${billpay_Mon[index].service_total}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
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
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (billpay_Mon.length != 0)
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
                              Value_Report = 'รายงานค่าบริการรับล่วงหน้า';
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
                            Value_Chang_Zone_billpayMon = null;
                            Value_Chang_Zone_billpayMon_Ser = null;

                            Await_Status_Report1 = null;

                            billpay_Mon.clear();
                            _billpay_Mon.clear();
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

  ///////////////////////////----------------------------------------------->(รายงานประวัติผู้เช่า)
  RE_TeNant_Widget() {
    int? ser_index;
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
                      (Value_Chang_Zone_People_TeNant == null)
                          ? 'รายงานประวัติผู้เช่า  (กรุณาเลือกโซน)'
                          : 'รายงานประวัติผู้เช่า  (โซน : $Value_Chang_Zone_People_TeNant)',
                      style: const TextStyle(
                        color: ReportScreen_Color.Colors_Text1_,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontWeight_.Fonts_T,
                      ),
                    )),
                    Row(
                      children: [
                        // Expanded(
                        //     flex: 1,
                        //     child: Text(
                        //       'ผู้เช่า: ${Status_pe}',
                        //       textAlign: TextAlign.start,
                        //       style: const TextStyle(
                        //         fontSize: 14,
                        //         color: ReportScreen_Color.Colors_Text1_,
                        //         // fontWeight: FontWeight.bold,
                        //         fontFamily: FontWeight_.Fonts_T,
                        //       ),
                        //     )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'ทั้งหมด: ${teNantModels.length}',
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Expanded(
                          //   child: _searchBar_GetbackPakan(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
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
                              ? MediaQuery.of(context).size.width * 1.5
                              : (teNantModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1400,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child:
                              // (teNantModels.length == 0)
                              //     ? const Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Center(
                              //             child: Text(
                              //               'ไม่พบข้อมูล ณ วันที่เลือก',
                              //               style: TextStyle(
                              //                 color:
                              //                     ReportScreen_Color.Colors_Text1_,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontFamily: FontWeight_.Fonts_T,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     :
                              Column(
                            children: <Widget>[
                              Container(
                                // width: 1050,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: const Text(
                                        'ลำดับที่',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ชื่อ-สกุล ผู้เช่า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขบปช.',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'รหัสสาขา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ชื่อสาขา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขที่สัญญา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขสัญญาเก่า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขที่สัญญาประกัน',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขล็อค',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'วันที่เริ่มเช่า',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'วันที่สิ้นสุดสัญญา',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ประเภทสินค้า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'น้ำ + ไฟ',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าเช่า',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าบริการ',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เงินประกัน',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'วันที่ยกเลิก',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ผู้ดูแล',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
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
                                itemCount: teNantModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Container(
                                      decoration: const BoxDecoration(
                                        // color: Colors.green[100]!
                                        //     .withOpacity(0.5),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${index + 1}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${teNantModels[index].cname}',
                                              // '${transKonModels[index].pdate}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 2,
                                              '${teNantModels[index].tax}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 2,
                                              (teNantModels[index].zser != null)
                                                  ? '${teNantModels[index].zser}'
                                                  : '${teNantModels[index].zser1}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text: (teNantModels[index].zn !=
                                                        null)
                                                    ? '${teNantModels[index].zn}'
                                                    : '${teNantModels[index].zn1}',
                                                style: const TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[200],
                                              ),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 2,
                                                (teNantModels[index].zn != null)
                                                    ? '${teNantModels[index].zn}'
                                                    : '${teNantModels[index].zn1}',
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text: (teNantModels[index]
                                                            .cid ==
                                                        null)
                                                    ? ''
                                                    : '${teNantModels[index].cid}',
                                                style: const TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[200],
                                              ),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 1,
                                                (teNantModels[index].cid ==
                                                        null)
                                                    ? ''
                                                    : '${teNantModels[index].cid}',
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text: (teNantModels[index]
                                                            .fid ==
                                                        null)
                                                    ? ''
                                                    : '${teNantModels[index].fid}',
                                                style: const TextStyle(
                                                  color: HomeScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[200],
                                              ),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 1,
                                                (teNantModels[index].fid ==
                                                        null)
                                                    ? ''
                                                    : '${teNantModels[index].fid}',
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text2_,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (teNantModels[index].docno ==
                                                      null)
                                                  ? ''
                                                  : '${teNantModels[index].docno}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${teNantModels[index].ln}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${teNantModels[index].sdate}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${teNantModels[index].ldate}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${teNantModels[index].stype}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${(teNantModels[index].water_electri == null) ? '' : teNantModels[index].water_electri.toString()}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              // '${teNantModels[index].rent_total}',
                                              (teNantModels[index].rent_total ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels[index].rent_total}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (teNantModels[index]
                                                          .service_total ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels[index].service_total}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (teNantModels[index]
                                                          .service_total ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels[index].pakan_vat}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              (teNantModels[index]
                                                          .cc_date
                                                          .toString() ==
                                                      '0000-00-00')
                                                  ? ''
                                                  : '${teNantModels[index].cc_date}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              maxLines: 1,
                                              '${teNantModels[index].user}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
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
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (teNantModels.length != 0)
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
                              Value_Report = 'รายงานประวัติผู้เช่า';
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
                            Value_Chang_Zone_People_TeNant = null;
                            Value_Chang_Zone_Ser_People_TeNant = null;

                            Await_Status_Report2 = null;

                            teNantModels.clear();
                            _teNantModels.clear();
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

  ///////////////////////////----------------------------------------------->(รายงานผู้เช่ารายใหม่)
  RE_TeNant_New_Widget() {
    int? ser_index;
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
                      (Value_Chang_Zone_People_TeNantNew == null)
                          ? 'รายงานผู้เช่ารายใหม่  (กรุณาเลือกโซน)'
                          : 'รายงานผู้เช่ารายใหม่  (โซน : $Value_Chang_Zone_People_TeNantNew)',
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
                              'เดือน: ${monthsInThai[int.parse(Mon_PeopleTeNantNew_Mon.toString()) - 1]} ${YE_PeopleTeNantNew_Mon}',
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
                              'ทั้งหมด: ${teNantModels_New.length}',
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Expanded(
                          //   child: _searchBar_GetbackPakan(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          content: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
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
                              ? MediaQuery.of(context).size.width * 2
                              : (teNantModels_New.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1400,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child:
                              // (teNantModels.length == 0)
                              //     ? const Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Center(
                              //             child: Text(
                              //               'ไม่พบข้อมูล ณ วันที่เลือก',
                              //               style: TextStyle(
                              //                 color:
                              //                     ReportScreen_Color.Colors_Text1_,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontFamily: FontWeight_.Fonts_T,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     :
                              Column(
                            children: <Widget>[
                              Container(
                                // width: 1050,
                                decoration: BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                // padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: const Text(
                                        'ลำดับที่',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขที่สัญญา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      child: const Text(
                                        'เลขบัญชีVAN',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'รหัสสาขา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ชื่อสาขา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขล็อค',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ชื่อ-สกุล ผู้เช่า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'วันที่เริ่มเช่า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'วันที่สิ้นสุดสัญญา',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ระยะเวลา',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ประเภทสินค้า',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'น้ำ + ไฟ',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าเช่า',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'VAT7% ค่าเช่า',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าเช่ารวมVAT',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าบริการ',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'VAT7% ค่าบริการ',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าบริการรวมVAT',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เงินประกัน',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เงินประกันรวมVAT',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ค่าอุปกรณ์รวมvat',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'รวมทั้งสิ้น',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'วันที่ใบเสร็จเงินประกัน',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'เลขที่ใบเสร็จเงินประกัน',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
                                            ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'ผู้ดูแล',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            fontSize: 14.0
                                            //fontSize: 10.0
                                            //fontSize: 10.0
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
                                itemCount: teNantModels_New.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Container(
                                      decoration: const BoxDecoration(
                                        // color: Colors.green[100]!
                                        //     .withOpacity(0.5),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black12,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 50,
                                            child: Text(
                                              '${index + 1}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].cid}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            child: const Text(
                                              '',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index].zser !=
                                                      null)
                                                  ? '${teNantModels_New[index].zser}'
                                                  : '${teNantModels_New[index].zser1}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index].zn !=
                                                      null)
                                                  ? '${teNantModels_New[index].zn}'
                                                  : '${teNantModels_New[index].zn1}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].ln}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index].cname ==
                                                      null)
                                                  ? ''
                                                  : '${teNantModels_New[index].cname}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index].sdate ==
                                                      null)
                                                  ? ''
                                                  : '${teNantModels_New[index].sdate}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index].ldate ==
                                                      null)
                                                  ? ''
                                                  : '${teNantModels_New[index].ldate}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].nday}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].stype}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].water_electri}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].rent_pvat}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].rent_vat}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index]
                                                          .rent_total ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels_New[index].rent_total}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index]
                                                          .service_pvat ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels_New[index].service_pvat}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              maxLines: 1,
                                              (teNantModels_New[index]
                                                          .service_vat ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels_New[index].service_vat}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (teNantModels_New[index]
                                                          .service_total ==
                                                      null)
                                                  ? '0.00'
                                                  : nFormat
                                                      .format(double.parse(
                                                          '${teNantModels_New[index].service_total}'))
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].pvat_pakan}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].total_pakan}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].equip_total}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '0.00',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].pakan_daterec}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].pakan_doc}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${teNantModels_New[index].user}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
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
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (teNantModels_New.length != 0)
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
                              Value_Report = 'รายงานผู้เช่ารายใหม่';
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
                            Value_Chang_Zone_People_TeNantNew = null;
                            Value_Chang_Zone_Ser_People_TeNantNew = null;

                            Await_Status_Report3 = null;

                            teNantModels_New.clear();
                            _teNantModels_New.clear();
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

  ////////////------------------------------------------------------>(Export file )
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

  ////////////------------------------------------------>  Excel_BillPayMonRent_Report_Choice
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
        if (Value_Report == 'รายงานค่าบริการรับล่วงหน้า') {
          Excgen_SalesTax_FutureReport_Choice
              .exportExcel_SalesTax_FutureReport_Choice(
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  renTal_name,
                  Value_Chang_Zone_billpayMon,
                  billpay_Mon,
                  monthsInThai[int.parse(Mon_billpay_Mon.toString()) - 1],
                  YE_billpay_Mon);
        } else if (Value_Report == 'รายงานประวัติผู้เช่า') {
          Excgen_PeopleTenantReport_Choice
              .exportExcel_PeopleTenantReport_Choice(
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  renTal_name,
                  Value_Chang_Zone_People_TeNant,
                  teNantModels,
                  monthsInThai[int.parse(Mon_PeopleTeNant_Mon.toString()) - 1],
                  YE_PeopleTeNant_Mon);
        } else if (Value_Report == 'รายงานผู้เช่ารายใหม่') {
          Excgen_TeNantNewReport_Choice.exportExcel_TeNantNewReport_Choice(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              Value_Chang_Zone_People_TeNantNew,
              teNantModels_New,
              monthsInThai[int.parse(Mon_PeopleTeNantNew_Mon.toString()) - 1],
              YE_PeopleTeNantNew_Mon);
        }
      }
      Navigator.of(context).pop();
    }
  }
}
