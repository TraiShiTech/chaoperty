import 'dart:async';
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
import '../Model/GetZone_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Model/Get_tran_meter_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Excel_maintenance_Report.dart';

class ReportScreen4 extends StatefulWidget {
  const ReportScreen4({super.key});

  @override
  State<ReportScreen4> createState() => _ReportScreen4State();
}

class _ReportScreen4State extends State<ReportScreen4> {
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

  ///------------------------>
  int? Await_Status_Report1,
      Await_Status_Report2,
      Await_Status_Report3,
      Await_Status_Report4,
      Await_Status_Report5,
      Await_Status_Report6;
  List<MaintenanceModel> maintenanceModels = [];
  List<MaintenanceModel> _maintenanceModels = <MaintenanceModel>[];
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<TransMeterModel> transMeterModels = [];

  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  String? Mon_maintenance_Mon;
  String? YE_maintenance_Mon;
  String? renTal_user, renTal_name;
  String? zone_ser_maintenance,
      zone_name_maintenance,
      Status_maintenance_,
      Status_maintenance_ser;
 String? Status_Meter_ser , Status_Meter, zone_name_Meter, zone_ser_Meter;


  List maintenance_Status = [
    'ทั้งหมด',
    'รอดำเนินการ',
    'เสร็จสิ้น',
  ];

  List Meter_Status = [   'ไฟฟ้า',
    'น้ำ',
 
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_zone();
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

  //////////--------------------------------------------->
  Future<Null> red_Trans_c_maintenance() async {
    if (maintenanceModels.length != 0) {
      setState(() {
        maintenanceModels.clear();
        _maintenanceModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (zone_ser_maintenance == '0')
        ? '${MyConstant().domain}/GC_maintenance_Report.php?isAdd=true&ren=$ren&serzone=0&monx=$Mon_maintenance_Mon&yex=$YE_maintenance_Mon'
        : '${MyConstant().domain}/GC_maintenance_mst_Zone_Report.php?isAdd=true&ren=$ren&serZone=$zone_ser_maintenance&monx=$Mon_maintenance_Mon&yex=$YE_maintenance_Mon';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(map);
          if (Status_maintenance_ser == '0') {
            setState(() {
              maintenanceModels.add(maintenanceModel);
            });
          } else {
            if (Status_maintenance_ser.toString() ==
                maintenanceModel.mst.toString()) {
              setState(() {
                maintenanceModels.add(maintenanceModel);
              });
            } else {}
          }
        }
      }
      setState(() {
        _maintenanceModels = maintenanceModels;
      });
    } catch (e) {}
  }

///////-------------------------------------------------------------->
  ///
  // Future<Null> red_Trans_bill() async {
  //   if (transMeterModels.length != 0) {
  //     setState(() {
  //       transMeterModels.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');

  //   String url = (zone_ser.toString() == 'null')
  //       ? (Ser_BodySta1 == 0)
  //           ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=0&serzone=0'
  //           : (Ser_BodySta1 == 1)
  //               ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=1&serzone=0'
  //               : '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=2&serzone=0'
  //       : (Ser_BodySta1 == 0)
  //           ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=0&serzone=$zone_ser'
  //           : (Ser_BodySta1 == 1)
  //               ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=1&serzone=$zone_ser'
  //               : '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=2&serzone=$zone_ser';
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print('result $ciddoc');
  //     if (result.toString() != 'null') {
  //       for (var map in result) {
  //         TransMeterModel transMeterModel = TransMeterModel.fromJson(map);
  //         setState(() {
  //           transMeterModels.add(transMeterModel);

  //           // _TransBillModels.add(_TransBillModel);
  //         });
  //       }
  //     }
  //     setState(() {
  //       _transMeterModels = transMeterModels;
  //     });
  //   } catch (e) {}
  // }

  ///
  ///----------------------------------------------------------->

  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext builderContext) {
          Timer(Duration(seconds: 3), () {
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

  ///----------------------------------------------------------->
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
                            value: Mon_maintenance_Mon,
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
                                    '${item}',
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
                              Mon_maintenance_Mon = value;

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
                            value: YE_maintenance_Mon,
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
                              YE_maintenance_Mon = value;

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
                          'สถานะ :',
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
                          width: 140,
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            value: Status_maintenance_,

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
                            buttonWidth: 240,
                            // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              // color: Colors
                              //     .amber,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            items: maintenance_Status
                                .map((item) => DropdownMenuItem<String>(
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
                                    ))
                                .toList(),

                            onChanged: (value) async {
                              int selectedIndex = maintenance_Status
                                  .indexWhere((item) => item == value);
                              setState(() {
                                Status_maintenance_ = value!;
                                Status_maintenance_ser = '${selectedIndex}';
                              });
                              print(Status_maintenance_ser);
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
                            value: zone_name_maintenance,
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
                                zone_name_maintenance = value!;
                                zone_ser_maintenance =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              print(
                                  'Selected Index: $zone_name_maintenance  //${zone_ser_maintenance}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (zone_name_maintenance != null &&
                                Status_maintenance_ != null &&
                                Mon_maintenance_Mon != null &&
                                YE_maintenance_Mon != null) {
                              setState(() {
                                Await_Status_Report1 = 0;
                              });
                              Dia_log();
                            }
                            red_Trans_c_maintenance();
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
                          Insert_log.Insert_logs(
                              'รายงาน', 'กดดูรายงานการแจ้งซ่อม');
                          RE_maintenance_Widget();
                        }),
                    (maintenanceModels.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Status_maintenance_ != null &&
                                      maintenanceModels.isEmpty &&
                                      zone_name_maintenance != null &&
                                      Await_Status_Report1 != null)
                                  ? 'รายงานรายงานการแจ้งซ่อม (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานรายงานการแจ้งซ่อม',
                              style: const TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'รายงานรายงานการแจ้งซ่อม ✔️',
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
            ])));
  }

  ///////////////////////////----------------------------------------------->(รายงานรายงานการแจ้งซ่อม)
  RE_maintenance_Widget() {
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
                // (Status_maintenance_ == null)
                //     ? 'สถานะ: กรุณาเลือก'
                //     : 'สถานะ: ${Status_maintenance_}',
                (zone_name_maintenance == null)
                    ? 'รายงานรายงานการแจ้งซ่อม (กรุณาเลือกโซน)'
                    : 'รายงานรายงานการแจ้งซ่อม (โซน : $zone_name_maintenance) ',
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
                        (Mon_maintenance_Mon == null ||
                                YE_maintenance_Mon == null)
                            ? 'เดือน: กรุณาเลือก'
                            : 'เดือน: ${Mon_maintenance_Mon}(${YE_maintenance_Mon})',
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
                        'ทั้งหมด: ${maintenanceModels.length}',
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
                              : (maintenanceModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (maintenanceModels.length == 0)
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
                                      decoration: const BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'โซน',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'รหัสพื้นที่',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ร้านค้า',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'วันที่แจ้งซ่อม',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'รายละเอียด',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'วันที่ดำเนินการ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'คำอธิบาย',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'สถานะ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
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
                                      itemCount: maintenanceModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                          color: (show_more == index)
                                              ? tappedIndex_Color
                                                  .tappedIndex_Colors
                                                  .withOpacity(0.5)
                                              : AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                          child: Container(
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
                                            child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  show_more = index;
                                                });
                                              },
                                              title: Row(children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${maintenanceModels[index].zn}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${maintenanceModels[index].lncode}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${maintenanceModels[index].sname}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    (maintenanceModels[index]
                                                                .mdate ==
                                                            null)
                                                        ? ''
                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${maintenanceModels[index].mdate}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${maintenanceModels[index].mdate}'))}') + 543}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${maintenanceModels[index].mdescr}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    (maintenanceModels[index]
                                                                .rdate ==
                                                            null)
                                                        ? ''
                                                        : '${DateFormat('dd-MM').format(DateTime.parse('${maintenanceModels[index].rdate}'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${maintenanceModels[index].rdate}'))}') + 543}',
                                                    // '${maintenanceModels[index].rdate}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    ' ${maintenanceModels[index].rdescr}',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    maintenanceModels[index]
                                                                .mst ==
                                                            '0'
                                                        ? ' '
                                                        : maintenanceModels[
                                                                        index]
                                                                    .mst ==
                                                                '1'
                                                            ? 'รอดำเนินการ'
                                                            : 'เสร็จสิ้น',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            CustomerScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
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
                    if (maintenanceModels.length != 0)
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
                              Value_Report = 'รายงานรายงานการแจ้งซ่อม';
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
                            maintenanceModels.clear();
                            _maintenanceModels.clear();
                            Mon_maintenance_Mon = null;
                            YE_maintenance_Mon = null;
                            Await_Status_Report1 = null;
                            Status_maintenance_ser = null;
                            Status_maintenance_ = null;
                            zone_name_maintenance = null;
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
    setState(() {
      NameFile_ = '';
      NameFile_ = FormNameFile_text.text;
    });

    if (_verticalGroupValue_NameFile == 'กำหนดเอง') {
    } else {
      if (_verticalGroupValue_PassW == 'PDF') {
        Navigator.of(context).pop();
      } else {
        if (Value_Report == 'รายงานรายงานการแจ้งซ่อม') {
          Excgen_MaintenanceReport.exportExcel_maintenanceReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              maintenanceModels,
              Mon_maintenance_Mon,
              YE_maintenance_Mon,
              Status_maintenance_,
              zone_name_maintenance);
        } else if (Value_Report == 'รายงานประวัติการใช้งานรายเดือน') {}
        Navigator.of(context).pop();
      }
    }
  }

  ///------------------------------------------------->
}
