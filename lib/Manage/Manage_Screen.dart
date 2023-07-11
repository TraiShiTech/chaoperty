// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/Home/Home_Screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Account_Screen.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetContractx_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Model/Get_tran_meter_model.dart';
import '../Model/Getexp_sz_model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Report/Report_Screen.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int Status_ = 1;
  int Ser_BodySta1 = 0;
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  List<TransMeterModel> transMeterModels = [];
  List<MaintenanceModel> maintenanceModels = [];
  List<MaintenanceModel> _maintenanceModels = <MaintenanceModel>[];
  List<TransMeterModel> _transMeterModels = <TransMeterModel>[];
  List<TeNantModel> teNantModels = [];
  List<ExpSZModel> expSZModels = [];
  List<ZoneModel> zoneModels = [];
  final FormMeter_text = TextEditingController();
  final Formbecause_ = TextEditingController();
  String? typezonesName, typevalue;
  ///////---------------------------------------------------->
  List<String> _selecteSerbool = [];
  List _selecteSer = [];
  List<AreaModel> areaModels = [];
  int indexdelog = 0;
  String? serarea,
      lncodearea,
      lnarea,
      Value_D_start,
      snamearea,
      custnoarea,
      zone_ser,
      zone_name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_zone();
    red_Trans_bill();
    red_Trans_c_maintenance();
    red_exp_sz();
    read_GC_areaSelect();
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      zone_ser = preferences.getString('zonePSer');
      zone_name = preferences.getString('zonesPName');
    });
  }

  var Value_selectDate;
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

  Future<Null> read_GC_areaSelect() async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    String url =
        '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          AreaModel areaModel = AreaModel.fromJson(map);
          setState(() {
            areaModels.add(areaModel);
          });
        }
      }
    } catch (e) {}
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
        });
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_bill() async {
    if (transMeterModels.length != 0) {
      setState(() {
        transMeterModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (zone_ser.toString() == 'null')
        ? (Ser_BodySta1 == 0)
            ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=0&serzone=0'
            : (Ser_BodySta1 == 1)
                ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=1&serzone=0'
                : '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=2&serzone=0'
        : (Ser_BodySta1 == 0)
            ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=0&serzone=$zone_ser'
            : (Ser_BodySta1 == 1)
                ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=1&serzone=$zone_ser'
                : '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=2&serzone=$zone_ser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransMeterModel transMeterModel = TransMeterModel.fromJson(map);
          setState(() {
            transMeterModels.add(transMeterModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }
      }
      setState(() {
        _transMeterModels = transMeterModels;
      });
    } catch (e) {}
  }

  Future<Null> red_Trans_bill_exp(int expser) async {
    if (transMeterModels.length != 0) {
      setState(() {
        transMeterModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url = expser == 0
        ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren'
        : '${MyConstant().domain}/GC_expser.php?isAdd=true&ren=$ren&expser=$expser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransMeterModel transMeterModel = TransMeterModel.fromJson(map);
          setState(() {
            transMeterModels.add(transMeterModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_exp_sz() async {
    if (expSZModels.length != 0) {
      setState(() {
        expSZModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url = '${MyConstant().domain}/GC_exp_sz.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        Map<String, dynamic> map = Map();
        map['ser'] = '0';
        map['user'] = '0';
        map['etype'] = '0';
        map['exptser'] = '0';
        map['expname'] = 'ทั้งหมด';
        map['st'] = '0';
        map['unit'] = '0';
        map['sdate'] = '0';
        map['vat'] = '0';
        map['wht'] = '0';
        map['cal'] = '0';
        map['pri'] = '0';
        map['rser'] = '0';
        map['fine'] = '0';
        map['fine_unit'] = '0';
        map['fine_late'] = '0';
        map['fine_cal'] = '0';
        map['fine_pri'] = '0';
        map['data_update'] = '0';

        ExpSZModel expSZModel = ExpSZModel.fromJson(map);

        setState(() {
          expSZModels.add(expSZModel);
        });

        for (var map in result) {
          ExpSZModel expSZModel = ExpSZModel.fromJson(map);
          setState(() {
            expSZModels.add(expSZModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_c_maintenance() async {
    if (maintenanceModels.length != 0) {
      setState(() {
        maintenanceModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = (zone_ser.toString() == 'null')
        ? '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren&serzone=0'
        : '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren&serzone=$zone_ser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(map);
          setState(() {
            maintenanceModels.add(maintenanceModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }
      }
      setState(() {
        _maintenanceModels = maintenanceModels;
      });
    } catch (e) {}
  }

  Future<Null> red_Trans_c_maintenance_exp(int expser) async {
    if (maintenanceModels.length != 0) {
      setState(() {
        maintenanceModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url = expser == 0
        ? '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren'
        : '${MyConstant().domain}/GC_maintenance_mst.php?isAdd=true&ren=$ren&expser=$expser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(map);
          setState(() {
            maintenanceModels.add(maintenanceModel);

            // _TransBillModels.add(_TransBillModel);
          });
        }
      }
    } catch (e) {}
  }

  List Area_ = [
    'คอมมูนิตี้มอลล์',
    'ออฟฟิศให้เช่า',
    'ตลาดนัด',
    'อื่นๆ',
  ];
  List buttonview_ = [
    'ข้อมูลการเช่า',
    'มิเตอร์น้ำไฟฟ้า',
    'ตั้งหนี้/วางบิล',
    'รับชำระ',
    'ประวัติบิล',
  ];
  List Status = [
    'มิเตอร์น้ำไฟฟ้า',
    'แจ้งซ่อมบำรุง',
    'ควบคุมค่าใช้จ่าย',
  ];
  _setState(index) {
    setState(() {
      tappedIndex_ = index.toString();
    });
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: ManageScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(
            color: ManageScreen_Color.Colors_Text2_, fontFamily: Font_.Fonts_T),
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
        print(text);
        text = text.toLowerCase();

        // setState(() {
        //   transMeterModels = _transMeterModels.where((transMeterModels) {
        //     var notTitle = transMeterModels.ln.toString().toLowerCase();
        //     var notTitle2 = transMeterModels.sname.toString().toLowerCase();
        //     var notTitle3 = transMeterModels.num_meter.toString().toLowerCase();
        //     return notTitle.contains(text) ||
        //         notTitle2.contains(text) ||
        //         notTitle3.contains(text);
        //   }).toList();
        // });

        if (Status_ == 1) {
          setState(() {
            transMeterModels = _transMeterModels.where((transMeterModels) {
              var notTitle = transMeterModels.ln.toString().toLowerCase();
              var notTitle2 = transMeterModels.sname.toString().toLowerCase();
              var notTitle3 =
                  transMeterModels.num_meter.toString().toLowerCase();
              return notTitle.contains(text) ||
                  notTitle2.contains(text) ||
                  notTitle3.contains(text);
            }).toList();
          });
        } else if (Status_ == 2) {
          setState(() {
            maintenanceModels = _maintenanceModels.where((maintenanceModelss) {
              var notTitle = maintenanceModelss.lncode.toString().toLowerCase();
              var notTitle2 = maintenanceModelss.sname.toString().toLowerCase();

              return notTitle.contains(text) || notTitle2.contains(text);
            }).toList();
          });
        }
      },
    );
  }

  List Year_ = [
    'ทั้งหมด',
    'รอดำเนินการ',
    'เสร็จสิ้น',
  ];

  // Future<Null> read_GC_zone() async {
  //   if (zoneModels.length != 0) {
  //     zoneModels.clear();
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var ren = preferences.getString('renTalSer');

  //   String url = '${MyConstant().domain}/GC_zone.php?isAdd=true&ren=$ren';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     Map<String, dynamic> map = Map();
  //     map['ser'] = '0';
  //     map['rser'] = '0';
  //     map['zn'] = 'ทั้งหมด';
  //     map['qty'] = '0';
  //     map['img'] = '0';
  //     map['data_update'] = '0';

  //     ZoneModel zoneModelx = ZoneModel.fromJson(map);

  //     setState(() {
  //       zoneModels.add(zoneModelx);
  //     });

  //     for (var map in result) {
  //       ZoneModel zoneModel = ZoneModel.fromJson(map);
  //       setState(() {
  //         zoneModels.add(zoneModel);
  //       });
  //     }
  //   } catch (e) {}
  // }

  ///----------------->
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveUp2() {
    _scrollController2.animateTo(_scrollController2.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown2() {
    _scrollController2.animateTo(_scrollController2.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  final Form_note = TextEditingController();

  ///----------------->
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppbackgroundColor.Abg_Colors,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
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
                          'จัดการ ',
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
                          ' > >',
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.TiTile_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  // border: Border.all(color: Colors.white, width: 1),
                ),
                // padding: const EdgeInsets.all(8.0),
                child: ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    dragStartBehavior: DragStartBehavior.start,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'โซนพื้นที่เช่า:',
                            style: TextStyle(
                              color: ManageScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                            width: 150,
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              isExpanded: true,
                              hint: Text(
                                zone_name == null ? 'ทั้งหมด' : '$zone_name',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                              iconSize: 30,
                              buttonHeight: 40,
                              // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              items: zoneModels
                                  .map((item) => DropdownMenuItem<String>(
                                        value: '${item.ser},${item.zn}',
                                        child: Text(
                                          item.zn!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ))
                                  .toList(),

                              onChanged: (value) async {
                                var zones = value!.indexOf(',');
                                var zoneSer = value.substring(0, zones);
                                var zonesName = value.substring(zones + 1);
                                print('mmmmm ${zoneSer.toString()} $zonesName');

                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setString(
                                    'zonePSer', zoneSer.toString());
                                preferences.setString(
                                    'zonesPName', zonesName.toString());
                                checkPreferance();
                                red_Trans_bill();
                                red_Trans_c_maintenance();
                              },
                              // onSaved: (value) {
                              //   // selectedValue = value.toString();
                              // },
                            ),
                          ),
                        ),
                        if (Status_ != 3)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'ค้นหา:',
                              style: TextStyle(
                                color: ManageScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        if (Status_ != 3)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              height: 35,
                              child: _searchBar(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              const Text(
                                'สถานะ : ',
                                style: TextStyle(
                                  color: ManageScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
                              ),
                              for (int i = 0; i < Status.length; i++)
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          Status_ = 0;
                                          Status_ = i + 1;
                                          tappedIndex_ = '';
                                          typezonesName = null;
                                          typevalue = null;
                                          // red_Trans_c_maintenance_exp(0);
                                          // red_Trans_bill_exp(0);
                                        });
                                        print(Status_);
                                        red_Trans_bill_exp(0);
                                        red_Trans_c_maintenance_exp(0);
                                        checkPreferance();
                                        red_Trans_bill();
                                        red_Trans_c_maintenance();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: (i + 1 == 1)
                                              ? Colors.green
                                              : (i + 1 == 2)
                                                  ? Colors.indigo[400]
                                                  : Colors.orange,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          border: (Status_ == i + 1)
                                              ? Border.all(
                                                  color: Colors.white, width: 1)
                                              : null,
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            Status[i],
                                            style: TextStyle(
                                              color: (Status_ == i + 1)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                            ])),
                      ),
                    ),
                    // if (Status_ == 1)
                    if (Status_ != 3)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  }),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (Status_ == 1)
                                          Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.brown[400],
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
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Center(
                                                        child: Text(
                                                          'ทั้งหมด',
                                                          style: TextStyle(
                                                            // fontSize: 15,
                                                            color:
                                                                (Ser_BodySta1 ==
                                                                        0)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors.grey[
                                                                        800],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        Ser_BodySta1 = 0;
                                                      });
                                                      red_Trans_bill();
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
                                                        color: Colors.red,
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
                                                                  10),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Center(
                                                        child: Text(
                                                          'ไฟฟ้า',
                                                          style: TextStyle(
                                                            // fontSize: 15,
                                                            color:
                                                                (Ser_BodySta1 ==
                                                                        1)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors.grey[
                                                                        800],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        Ser_BodySta1 = 1;
                                                      });
                                                      red_Trans_bill();
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
                                                        color: Colors.blue,
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
                                                                  10),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Center(
                                                        child: Text(
                                                          'น้ำ',
                                                          style: TextStyle(
                                                            // fontSize: 15,
                                                            color:
                                                                (Ser_BodySta1 ==
                                                                        2)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors.grey[
                                                                        800],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        Ser_BodySta1 = 2;
                                                      });
                                                      red_Trans_bill();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (Responsive.isDesktop(context))
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.45,
                                          ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  (Status_ == 1)
                                                      ? 'ประเภทรายการ'
                                                      : 'สถานะ',
                                                  style: const TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                              StreamBuilder(
                                                  stream: Stream.periodic(
                                                      const Duration(
                                                          seconds: 0)),
                                                  builder: (context, snapshot) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppbackgroundColor
                                                                  .Sub_Abg_Colors,
                                                          borderRadius: const BorderRadius
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
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                        width: 120,
                                                        child: (Status_ == 1)
                                                            ? DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton2(
                                                                  itemHighlightColor:
                                                                      Colors
                                                                          .white,
                                                                  isExpanded:
                                                                      true,
                                                                  hint: Text(
                                                                    typezonesName ==
                                                                            null
                                                                        ? 'ทั้งหมด'
                                                                        : typezonesName!,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text1_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  iconSize: 30,
                                                                  buttonHeight:
                                                                      30,
                                                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                  dropdownDecoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  items: expSZModels
                                                                      .map((item) => DropdownMenuItem<String>(
                                                                            value:
                                                                                '${item.ser},${item.expname}',
                                                                            child:
                                                                                Text(
                                                                              item.expname.toString(),
                                                                              style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: ManageScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T,
                                                                              ),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                  // value: selectedValue,
                                                                  onChanged:
                                                                      (value) async {
                                                                    if (Status_ ==
                                                                        1) {
                                                                      var zones =
                                                                          value!
                                                                              .indexOf(',');
                                                                      var zoneSer =
                                                                          value.substring(
                                                                              0,
                                                                              zones);
                                                                      var zonesName =
                                                                          value.substring(zones +
                                                                              1);
                                                                      print(
                                                                          'mmmmm ${zoneSer.toString()} $zonesName');

                                                                      setState(
                                                                          () {
                                                                        typezonesName =
                                                                            zonesName;
                                                                        red_Trans_bill_exp(
                                                                            int.parse(zoneSer));
                                                                      });
                                                                    } else {}
                                                                  },
                                                                  // onSaved: (value) {
                                                                  //   // selectedValue = value.toString();
                                                                  // },
                                                                ),
                                                              )
                                                            : DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton2(
                                                                  itemHighlightColor:
                                                                      Colors
                                                                          .white,
                                                                  isExpanded:
                                                                      true,
                                                                  hint: Text(
                                                                    typevalue ==
                                                                            null
                                                                        ? 'ทั้งหมด'
                                                                        : typevalue
                                                                            .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  iconSize: 30,
                                                                  buttonHeight:
                                                                      30,
                                                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                  dropdownDecoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  items: Year_.map((item2) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            item2,
                                                                        child:
                                                                            Text(
                                                                          item2,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                ManageScreen_Color.Colors_Text1_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                FontWeight_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      )).toList(),
                                                                  // value: selectedValue,
                                                                  onChanged:
                                                                      (value) async {
                                                                    var expser = value ==
                                                                            'ทั้งหมด'
                                                                        ? 0
                                                                        : value ==
                                                                                'รอดำเนินการ'
                                                                            ? 1
                                                                            : 2;

                                                                    setState(
                                                                        () {
                                                                      typevalue =
                                                                          value;
                                                                      red_Trans_c_maintenance_exp(
                                                                          expser);
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                      ),
                                                    );
                                                  }),
                                              Status_ == 1
                                                  ? InkWell(
                                                      child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.green,
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
                                                            // border: Border.all(
                                                            //     color: Colors.grey, width: 1),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                  'SAVE',
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T,
                                                                      fontSize: 15.0),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      onTap: () {
                                                        setState(() {
                                                          red_Trans_bill();
                                                        });
                                                      },
                                                    )
                                                  : InkWell(
                                                      child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.blue,
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
                                                            // border: Border.all(
                                                            //     color: Colors.grey, width: 1),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                  'แจ้งซ่อมบำรุง',
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      // fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T,
                                                                      fontSize: 15.0),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      onTap: () {
                                                        setState(() {
                                                          indexdelog = 1;
                                                        });
                                                      },
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // (!Responsive.isDesktop(context))
            //     ? BodyHome_mobile()
            //     :
            BodyHome_Web()
          ],
        ),
      ),
    );
  }

  Future<String?> delog() {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: const Center(
            child: Text(
          'แจ้งซ่อมบำรุง',
          style: TextStyle(
            color: PeopleChaoScreen_Color.Colors_Text1_,
            // fontWeight: FontWeight.bold,
            fontFamily: FontWeight_.Fonts_T,
            fontWeight: FontWeight.bold,
          ),
        )),
        content: SingleChildScrollView(
          child: ListBody(children: <Widget>[]),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'บันทึก',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(
                        color: Colors.white,
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
      ),
    );
  }

  Widget BodyHome_Web() {
    return Column(
      children: [
        (Status_ == 1)
            ? Status1_Web()
            : (Status_ == 2)
                ? indexdelog == 0
                    ? Status2_Web()
                    : Status2_1Web()
                : Status3_Web()
      ],
    );
  }

  Widget Status1_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(
              //     color: Colors.grey, width: 1),
            ),
            height: MediaQuery.of(context).size.height / 1.4,
            // width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
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
                        Container(
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.85
                              : 1000,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'ผู้เช่า',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                            // fontSize: 12.0
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Expanded(
                                  //   flex: 2,
                                  //   child: Container(
                                  //     height: 30,
                                  //     color: Colors.red,
                                  //     child: Center(
                                  //       child: Text(
                                  //         'มิเตอร์ไฟ',
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //           color: ManageScreen_Color.Colors_Text1_,
                                  //           fontWeight: FontWeight.bold,
                                  //           fontFamily: FontWeight_.Fonts_T,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: Container(
                                  //     height: 30,
                                  //     color: Colors.blue,
                                  //     child: Center(
                                  //       child: Text(
                                  //         'เลขมิเตอร์น้ำ',
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //           color: ManageScreen_Color.Colors_Text1_,
                                  //           fontWeight: FontWeight.bold,
                                  //           fontFamily: FontWeight_.Fonts_T,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 30,
                                      color: Colors.orange,
                                      child: const Center(
                                        child: Text(
                                          'หน่วยที่ใช้',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: Text(
                                  //     '',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       // fontWeight: FontWeight.bold,
                                  //       //fontSize: 10.0
                                  //     ),
                                  //   ),
                                  // ),

                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'จำนวนเงิน',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: const Center(
                                          child: Text(
                                            'รหัสพื้นที่',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: const Center(
                                          child: Text(
                                            'เลขที่สัญญา',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: const Center(
                                          child: Text(
                                            'ชื่อร้านค้า',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: const Center(
                                          child: Text(
                                            'รายการ',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: const Center(
                                          child: Text(
                                            'หมายเลขเครื่อง',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: const Center(
                                          child: Text(
                                            'เลขมิเตอร์เดือนก่อน',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.orange[300],
                                        child: const Center(
                                          child: Text(
                                            'เลขมิเตอร์เดือนนี้',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.orange[300],
                                        child: const Center(
                                          child: Text(
                                            'หน่วยที่ใช้',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: const Center(
                                          child: Text(
                                            'ราคาต่อหน่วย',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: const Center(
                                          child: Text(
                                            'Vat (%)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: const Center(
                                          child: Text(
                                            'Vat (บาท)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: const Center(
                                          child: Text(
                                            'ก่อน Vat (บาท)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: const Center(
                                          child: Text(
                                            'รวม Vat',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.8,
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                child: ListView.builder(
                                  controller: _scrollController1,
                                  itemCount: transMeterModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Material(
                                      color: tappedIndex_ == index.toString()
                                          ? tappedIndex_Color.tappedIndex_Colors
                                          : AppbackgroundColor.Sub_Abg_Colors,
                                      child: Container(
                                        // color: tappedIndex_ == index.toString()
                                        //     ? tappedIndex_Color
                                        //         .tappedIndex_Colors
                                        //         .withOpacity(0.5)
                                        //     : null,
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              tappedIndex_ = index.toString();
                                            });
                                          },
                                          contentPadding:
                                              const EdgeInsets.all(4.0),
                                          title: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${transMeterModels[index].ln}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 2,
                                                child: Text(
                                                  '${transMeterModels[index].refno}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 2,
                                                child: Text(
                                                  '${transMeterModels[index].sname}',
                                                  textAlign: TextAlign.center,
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
                                                  '${transMeterModels[index].expname} ${transMeterModels[index].date}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 3,
                                                child: Text(
                                                  '${transMeterModels[index].num_meter}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 3,
                                                child: Text(
                                                  '${nFormat.format(double.parse(transMeterModels[index].ovalue!))}',
                                                  // '${transMeterModels[index].ovalue}',
                                                  textAlign: TextAlign.right,
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: TextFormField(
                                                    textAlign: TextAlign.right,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    // controller: FormMeter_text,
                                                    // validator: (value) {
                                                    //   if (value == null ||
                                                    //       value.isEmpty ||
                                                    //       value.length < 13) {
                                                    //     return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                    //   }
                                                    //   // if (int.parse(value.toString()) < 13) {
                                                    //   //   return '< 13';
                                                    //   // }
                                                    //   return null;
                                                    // },
                                                    // maxLength: 13,
                                                    initialValue:
                                                        transMeterModels[index]
                                                            .nvalue,
                                                    onChanged: (valuem) async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? ren =
                                                          preferences.getString(
                                                              'renTalSer');
                                                      String? ser_user =
                                                          preferences
                                                              .getString('ser');

                                                      var qser_in =
                                                          transMeterModels[
                                                                  index]
                                                              .ser_in;

                                                      var tran_ser =
                                                          transMeterModels[
                                                                  index]
                                                              .ser;
                                                      var ovalue =
                                                          transMeterModels[
                                                                  index]
                                                              .ovalue; // ก่อน
                                                      var nvalue =
                                                          transMeterModels[
                                                                  index]
                                                              .nvalue; // หลัง
                                                      // _celvat; //vat
                                                      // _cqty_vat; // หน่วย
                                                      // var qser_inn =
                                                      //     transMeterModels[
                                                      //             index + 1]
                                                      //         .ser_in;

                                                      var tran_expser =
                                                          transMeterModels[
                                                                  index]
                                                              .expser;
                                                      var _celvat =
                                                          transMeterModels[
                                                                  index]
                                                              .nvat;
                                                      var _cser =
                                                          transMeterModels[
                                                                  index]
                                                              .ser;
                                                      var _cqty_vat =
                                                          transMeterModels[
                                                                  index]
                                                              .c_qty;

                                                      print(
                                                          'ovalue>>>. $ovalue  ---- nvalue>>>>>> $nvalue');
                                                      // var value =
                                                      //     FormMeter_text.text;
                                                      var value = valuem;
                                                      String url =
                                                          '${MyConstant().domain}/UPC_Invoice_n.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_expser=$tran_expser';

                                                      try {
                                                        var response =
                                                            await http.get(
                                                                Uri.parse(url));

                                                        var result =
                                                            json.decode(
                                                                response.body);
                                                        print(result);

                                                        if (result.toString() !=
                                                            'null') {
                                                          setState(() {
                                                            // red_Trans_bill();
                                                            FormMeter_text
                                                                .clear();
                                                          });
                                                          // Navigator.pop(
                                                          //     context, 'OK');
                                                        }
                                                      } catch (e) {}
                                                    },
                                                    onFieldSubmitted: (value) {
                                                      Insert_log.Insert_logs(
                                                          'จัดการ',
                                                          'มิเตอร์น้ำไฟฟ้า>>แก้ไขเลขมิเตอร์เดือนนี้(${transMeterModels[index].ln},${transMeterModels[index].expname})');
                                                      setState(() {
                                                        red_Trans_bill();
                                                        // FormMeter_text.clear();
                                                      });
                                                    },
                                                    cursorColor: Colors.green,
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white
                                                            .withOpacity(0.3),
                                                        filled: true,
                                                        // prefixIcon: const Icon(
                                                        //     Icons
                                                        //         .electrical_services,
                                                        //     color: Colors.red),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        labelText: 'เลขมิเตอร์',
                                                        labelStyle:
                                                            const TextStyle(
                                                          color:
                                                              ManageScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                        )),
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      // for below version 2 use this
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp(r'[0-9]')),
                                                      // for version 2 and greater youcan also use this
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                  ),
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.center,
                                                //   children: [
                                                //     Text(
                                                //       '${transMeterModels[index].nvalue}',
                                                //       textAlign: TextAlign.center,
                                                //       style: const TextStyle(
                                                //         color: ManageScreen_Color
                                                //             .Colors_Text2_,
                                                //         // fontWeight: FontWeight.bold,
                                                //         fontFamily: Font_.Fonts_T,
                                                //         //fontSize: 10.0
                                                //       ),
                                                //     ),
                                                //     InkWell(
                                                //       onTap: () {
                                                //         showDialog<String>(
                                                //           barrierDismissible:
                                                //               false,
                                                //           context: context,
                                                //           builder: (BuildContext
                                                //                   context) =>
                                                //               AlertDialog(
                                                //             shape: const RoundedRectangleBorder(
                                                //                 borderRadius: BorderRadius
                                                //                     .all(Radius
                                                //                         .circular(
                                                //                             20.0))),
                                                //             title: Center(
                                                //                 child: Text(
                                                //               'มิเตอร์ไฟเดือนก่อน ${transMeterModels[index].ovalue}',
                                                //               style:
                                                //                   const TextStyle(
                                                //                 color: ManageScreen_Color
                                                //                     .Colors_Text1_,
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .bold,
                                                //                 fontFamily:
                                                //                     FontWeight_
                                                //                         .Fonts_T,
                                                //               ),
                                                //             )),
                                                //             content:
                                                //                 SingleChildScrollView(
                                                //                     child: Column(
                                                //                         children: [
                                                //                   Padding(
                                                //                     padding:
                                                //                         const EdgeInsets
                                                //                                 .all(
                                                //                             8.0),
                                                //                     child:
                                                //                         TextFormField(
                                                //                       keyboardType:
                                                //                           TextInputType
                                                //                               .number,
                                                //                       controller:
                                                //                           FormMeter_text,
                                                //                       // validator: (value) {
                                                //                       //   if (value == null ||
                                                //                       //       value.isEmpty ||
                                                //                       //       value.length < 13) {
                                                //                       //     return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                //                       //   }
                                                //                       //   // if (int.parse(value.toString()) < 13) {
                                                //                       //   //   return '< 13';
                                                //                       //   // }
                                                //                       //   return null;
                                                //                       // },
                                                //                       // maxLength: 13,
                                                //                       cursorColor:
                                                //                           Colors
                                                //                               .green,
                                                //                       decoration: InputDecoration(
                                                //                           fillColor: Colors.white.withOpacity(0.3),
                                                //                           filled: true,
                                                //                           prefixIcon: const Icon(Icons.electrical_services, color: Colors.red),
                                                //                           // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                //                           focusedBorder: const OutlineInputBorder(
                                                //                             borderRadius:
                                                //                                 BorderRadius.only(
                                                //                               topRight:
                                                //                                   Radius.circular(15),
                                                //                               topLeft:
                                                //                                   Radius.circular(15),
                                                //                               bottomRight:
                                                //                                   Radius.circular(15),
                                                //                               bottomLeft:
                                                //                                   Radius.circular(15),
                                                //                             ),
                                                //                             borderSide:
                                                //                                 BorderSide(
                                                //                               width:
                                                //                                   1,
                                                //                               color:
                                                //                                   Colors.black,
                                                //                             ),
                                                //                           ),
                                                //                           enabledBorder: const OutlineInputBorder(
                                                //                             borderRadius:
                                                //                                 BorderRadius.only(
                                                //                               topRight:
                                                //                                   Radius.circular(15),
                                                //                               topLeft:
                                                //                                   Radius.circular(15),
                                                //                               bottomRight:
                                                //                                   Radius.circular(15),
                                                //                               bottomLeft:
                                                //                                   Radius.circular(15),
                                                //                             ),
                                                //                             borderSide:
                                                //                                 BorderSide(
                                                //                               width:
                                                //                                   1,
                                                //                               color:
                                                //                                   Colors.grey,
                                                //                             ),
                                                //                           ),
                                                //                           labelText: 'เลขมิเตอร์ไฟ',
                                                //                           labelStyle: const TextStyle(
                                                //                             color:
                                                //                                 ManageScreen_Color.Colors_Text2_,
                                                //                             // fontWeight:
                                                //                             //     FontWeight.bold,
                                                //                             fontFamily:
                                                //                                 Font_.Fonts_T,
                                                //                           )),
                                                //                       inputFormatters: <
                                                //                           TextInputFormatter>[
                                                //                         // for below version 2 use this
                                                //                         FilteringTextInputFormatter
                                                //                             .allow(
                                                //                                 RegExp(r'[0-9]')),
                                                //                         // for version 2 and greater youcan also use this
                                                //                         FilteringTextInputFormatter
                                                //                             .digitsOnly
                                                //                       ],
                                                //                     ),
                                                //                   ),
                                                //                 ])),
                                                //             actions: <Widget>[
                                                //               Row(
                                                //                 children: [
                                                //                   Padding(
                                                //                     padding:
                                                //                         const EdgeInsets
                                                //                                 .all(
                                                //                             8.0),
                                                //                     child: Row(
                                                //                       mainAxisAlignment:
                                                //                           MainAxisAlignment
                                                //                               .center,
                                                //                       children: [
                                                //                         Padding(
                                                //                           padding:
                                                //                               const EdgeInsets.all(8.0),
                                                //                           child:
                                                //                               Container(
                                                //                             width:
                                                //                                 100,
                                                //                             decoration:
                                                //                                 const BoxDecoration(
                                                //                               color:
                                                //                                   Colors.green,
                                                //                               borderRadius: BorderRadius.only(
                                                //                                   topLeft: Radius.circular(10),
                                                //                                   topRight: Radius.circular(10),
                                                //                                   bottomLeft: Radius.circular(10),
                                                //                                   bottomRight: Radius.circular(10)),
                                                //                             ),
                                                //                             padding:
                                                //                                 const EdgeInsets.all(8.0),
                                                //                             child:
                                                //                                 TextButton(
                                                //                               onPressed:
                                                //                                   () async {
                                                //                                 SharedPreferences preferences = await SharedPreferences.getInstance();
                                                //                                 String? ren = preferences.getString('renTalSer');
                                                //                                 String? ser_user = preferences.getString('ser');

                                                //                                 var qser_in = transMeterModels[index].ser_in;

                                                //                                 var tran_ser = transMeterModels[index].ser;
                                                //                                 var ovalue = transMeterModels[index].ovalue; // ก่อน
                                                //                                 var nvalue = transMeterModels[index].nvalue; // หลัง
                                                //                                 // _celvat; //vat
                                                //                                 // _cqty_vat; // หน่วย

                                                //                                 var _celvat = transMeterModels[index].nvat;
                                                //                                 var _cser = transMeterModels[index].ser;
                                                //                                 var _cqty_vat = transMeterModels[index].c_qty;

                                                //                                 print('ovalue>>>. $ovalue  ---- nvalue>>>>>> $nvalue');
                                                //                                 var value = FormMeter_text.text;
                                                //                                 String url = '${MyConstant().domain}/UPC_Invoice.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser';

                                                //                                 try {
                                                //                                   var response = await http.get(Uri.parse(url));

                                                //                                   var result = json.decode(response.body);
                                                //                                   print(result);
                                                //                                   if (result.toString() != 'null') {
                                                //                                     setState(() {
                                                //                                       red_Trans_bill();
                                                //                                       FormMeter_text.clear();
                                                //                                     });
                                                //                                     Navigator.pop(context, 'OK');
                                                //                                   }
                                                //                                 } catch (e) {}
                                                //                                 // Navigator.pop(
                                                //                                 //       context,
                                                //                                 //       'OK');
                                                //                               },
                                                //                               child:
                                                //                                   const Text(
                                                //                                 'บันทึก',
                                                //                                 style: TextStyle(
                                                //                                   color: Colors.white,
                                                //                                   fontWeight: FontWeight.bold,
                                                //                                   fontFamily: FontWeight_.Fonts_T,
                                                //                                 ),
                                                //                               ),
                                                //                             ),
                                                //                           ),
                                                //                         ),
                                                //                       ],
                                                //                     ),
                                                //                   ),
                                                //                   Padding(
                                                //                     padding:
                                                //                         const EdgeInsets
                                                //                                 .all(
                                                //                             8.0),
                                                //                     child: Row(
                                                //                       mainAxisAlignment:
                                                //                           MainAxisAlignment
                                                //                               .center,
                                                //                       children: [
                                                //                         Padding(
                                                //                           padding:
                                                //                               const EdgeInsets.all(8.0),
                                                //                           child:
                                                //                               Container(
                                                //                             width:
                                                //                                 100,
                                                //                             decoration:
                                                //                                 const BoxDecoration(
                                                //                               color:
                                                //                                   Colors.red,
                                                //                               borderRadius: BorderRadius.only(
                                                //                                   topLeft: Radius.circular(10),
                                                //                                   topRight: Radius.circular(10),
                                                //                                   bottomLeft: Radius.circular(10),
                                                //                                   bottomRight: Radius.circular(10)),
                                                //                             ),
                                                //                             padding:
                                                //                                 const EdgeInsets.all(8.0),
                                                //                             child:
                                                //                                 TextButton(
                                                //                               onPressed:
                                                //                                   () {
                                                //                                 setState(() {
                                                //                                   FormMeter_text.clear();
                                                //                                 });
                                                //                                 Navigator.pop(context, 'OK');
                                                //                               },
                                                //                               child:
                                                //                                   const Text(
                                                //                                 'ยกเลิก',
                                                //                                 style: TextStyle(
                                                //                                   color: Colors.white,
                                                //                                   fontWeight: FontWeight.bold,
                                                //                                   fontFamily: FontWeight_.Fonts_T,
                                                //                                 ),
                                                //                               ),
                                                //                             ),
                                                //                           ),
                                                //                         ),
                                                //                       ],
                                                //                     ),
                                                //                   ),
                                                //                 ],
                                                //               ),
                                                //             ],
                                                //           ),
                                                //         );
                                                //       },
                                                //       child: const Icon(
                                                //         Icons.edit,
                                                //         color: Colors.black,
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${nFormat.format(double.parse(transMeterModels[index].qty!))}',
                                                  //'${transMeterModels[index].qty}',
                                                  textAlign: TextAlign.right,
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
                                                  '${nFormat.format(double.parse(transMeterModels[index].pri!))}',
                                                  //  '${transMeterModels[index].pri}',
                                                  textAlign: TextAlign.right,
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
                                                  '${nFormat.format(double.parse(transMeterModels[index].nvat!))}',
                                                  // '${transMeterModels[index].nvat} %',
                                                  textAlign: TextAlign.right,
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
                                                  '${nFormat.format(double.parse(transMeterModels[index].c_vat!))}',
                                                  //'${transMeterModels[index].c_vat}',
                                                  textAlign: TextAlign.right,
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
                                                  // '${transMeterModels[index].c_pvat}',
                                                  '${nFormat.format(double.parse(transMeterModels[index].c_pvat!))}',
                                                  textAlign: TextAlign.right,
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
                                                  '${nFormat.format(double.parse(transMeterModels[index].c_amt!))}',
                                                  //'${transMeterModels[index].c_amt}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    color: ManageScreen_Color
                                                        .Colors_Text2_,
                                                    // fontWeight:
                                                    //     FontWeight.bold,
                                                    fontFamily: Font_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    _scrollController1.animateTo(
                                      0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeOut,
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        // color: AppbackgroundColor
                                        //     .TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Top',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: FontWeight_.Fonts_T),
                                      )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_scrollController1.hasClients) {
                                    final position = _scrollController1
                                        .position.maxScrollExtent;
                                    _scrollController1.animateTo(
                                      position,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      // color: AppbackgroundColor
                                      //     .TiTile_Colors,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(3.0),
                                    child: const Text(
                                      'Down',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: FontWeight_.Fonts_T),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: _moveUp1,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    // color: AppbackgroundColor
                                    //     .TiTile_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(3.0),
                                  child: const Text(
                                    'Scroll',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
                              InkWell(
                                onTap: _moveDown1,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Status2_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(
              //     color: Colors.grey, width: 1),
            ),
            height: MediaQuery.of(context).size.height / 1.4,
            // width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
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
                        Container(
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.85
                              : 1000,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'ผู้เช่า',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 30,
                                      color: Colors.red,
                                      child: const Center(
                                        child: Text(
                                          '-',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'ข้อมูลการแจ้งซ่อม',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ManageScreen_Color
                                                .Colors_Text1_,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontWeight_.Fonts_T,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.TiTile_Colors,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'รหัสพื้นที่',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'ชื่อร้านค้า',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.red[300],
                                        child: const Center(
                                          child: Text(
                                            'วันที่แจ้งซ่อม',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.blue[300],
                                        child: const Center(
                                          child: Text(
                                            'รายละเอียด',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.blue[300],
                                        child: const Center(
                                          child: Text(
                                            'สถานะ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.blue[300],
                                        child: const Center(
                                          child: Text(
                                            '-',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ManageScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.8,
                                decoration: const BoxDecoration(
                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  // border: Border.all(
                                  //     color: Colors.grey, width: 1),
                                ),
                                child: ListView.builder(
                                  controller: _scrollController2,
                                  itemCount: maintenanceModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Material(
                                      color: tappedIndex_ == index.toString()
                                          ? tappedIndex_Color.tappedIndex_Colors
                                          : AppbackgroundColor.Sub_Abg_Colors,
                                      child: Container(
                                        // color: tappedIndex_ == index.toString()
                                        //     ? tappedIndex_Color
                                        //         .tappedIndex_Colors
                                        //         .withOpacity(0.5)
                                        //     : null,
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              tappedIndex_ = index.toString();
                                            });
                                          },
                                          contentPadding:
                                              const EdgeInsets.all(8.0),
                                          title: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${maintenanceModels[index].lncode}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 1,
                                                child: Text(
                                                  '${maintenanceModels[index].sname}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 1,
                                                child: Text(
                                                  '${DateFormat('dd-MM').format((DateTime.parse('${maintenanceModels[index].mdate} 00:00:00')))}-${DateTime.parse('${maintenanceModels[index].mdate} 00:00:00').year + 543}',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
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
                                                flex: 3,
                                                child: Text(
                                                  '${maintenanceModels[index].mdescr}',
                                                  textAlign: TextAlign.center,
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
                                                flex: 1,
                                                child: Text(
                                                  maintenanceModels[index]
                                                              .mst ==
                                                          '0'
                                                      ? ' '
                                                      : maintenanceModels[index]
                                                                  .mst ==
                                                              '1'
                                                          ? 'รอดำเนินการ'
                                                          : 'เสร็จสิ้น',
                                                  textAlign: TextAlign.center,
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
                                                flex: 1,
                                                child: InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: maintenanceModels[
                                                                      index]
                                                                  .mst ==
                                                              '2'
                                                          ? Colors.green
                                                          : Colors.grey[100],
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
                                                      // border: Border.all(
                                                      //     color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Text(
                                                      'เรียกดู',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            ManageScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    if (maintenanceModels[index]
                                                            .mst
                                                            .toString() ==
                                                        '2')
                                                      showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false, // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0))),
                                                              title: Text(
                                                                '${maintenanceModels[index].sname}( ${maintenanceModels[index].lncode})',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  color: ManageScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Center(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'วันที่ดำเนินการ : ${maintenanceModels[index].rdate}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ManageScreen_Color.Colors_Text2_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'คำอธิบาย : ${maintenanceModels[index].rdescr}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                ManageScreen_Color.Colors_Text2_,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily:
                                                                                Font_.Fonts_T,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.redAccent,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                red_Trans_c_maintenance();
                                                                                Navigator.pop(context, 'OK');
                                                                              },
                                                                              child: const Text(
                                                                                'ปิด',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          });

                                                    ////////////////////-------------------------------------------------------------->
                                                    if (maintenanceModels[index]
                                                            .mst
                                                            .toString() ==
                                                        '1')
                                                      showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false, // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0))),
                                                              title: Text(
                                                                '${maintenanceModels[index].sname}( ${maintenanceModels[index].lncode})',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  color: ManageScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: [
                                                                        //_select_Date
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'วันที่แก้ไข:',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              color: ManageScreen_Color.Colors_Text2_,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        StreamBuilder(
                                                                            stream:
                                                                                Stream.periodic(const Duration(seconds: 0)),
                                                                            builder: (context, snapshot) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    _select_Date(context);
                                                                                  },
                                                                                  child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: AppbackgroundColor.Sub_Abg_Colors,
                                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        border: Border.all(color: Colors.grey, width: 1),
                                                                                      ),
                                                                                      width: 120,
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          (Value_selectDate == null) ? 'เลือก' : '$Value_selectDate',
                                                                                          style: const TextStyle(
                                                                                            color: ReportScreen_Color.Colors_Text2_,
                                                                                            // fontWeight: FontWeight.bold,
                                                                                            fontFamily: Font_.Fonts_T,
                                                                                          ),
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        controller:
                                                                            Formbecause_,
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return 'ใส่ข้อมูลให้ครบถ้วน ';
                                                                          }
                                                                          // if (int.parse(value.toString()) < 13) {
                                                                          //   return '< 13';
                                                                          // }
                                                                          return null;
                                                                        },
                                                                        // maxLength: 13,
                                                                        cursorColor:
                                                                            Colors.green,
                                                                        decoration: InputDecoration(
                                                                            fillColor: Colors.white.withOpacity(0.3),
                                                                            filled: true,
                                                                            // prefixIcon: const Icon(Icons.water,
                                                                            //     color: Colors.blue),
                                                                            // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                            focusedBorder: const OutlineInputBorder(
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(15),
                                                                                topLeft: Radius.circular(15),
                                                                                bottomRight: Radius.circular(15),
                                                                                bottomLeft: Radius.circular(15),
                                                                              ),
                                                                              borderSide: BorderSide(
                                                                                width: 1,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            enabledBorder: const OutlineInputBorder(
                                                                              borderRadius: BorderRadius.only(
                                                                                topRight: Radius.circular(15),
                                                                                topLeft: Radius.circular(15),
                                                                                bottomRight: Radius.circular(15),
                                                                                bottomLeft: Radius.circular(15),
                                                                              ),
                                                                              borderSide: BorderSide(
                                                                                width: 1,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                            labelText: 'คำอธิบาย',
                                                                            labelStyle: const TextStyle(
                                                                              color: ManageScreen_Color.Colors_Text2_,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T,
                                                                            )),
                                                                        // inputFormatters: <TextInputFormatter>[
                                                                        //   // for below version 2 use this
                                                                        //   FilteringTextInputFormatter.allow(
                                                                        //       RegExp(r'[0-9]')),
                                                                        //   // for version 2 and greater youcan also use this
                                                                        //   FilteringTextInputFormatter.digitsOnly
                                                                        // ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          5.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.green,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () async {
                                                                                String Ser_ = maintenanceModels[index].ser.toString();

                                                                                String because_ = Formbecause_.text.toString();

                                                                                print(
                                                                                  '$Ser_ //// $because_ //$Value_selectDate',
                                                                                );
                                                                                if (Value_selectDate == null && because_ == '') {
                                                                                  showDialog<String>(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) => AlertDialog(
                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                      title: const Center(
                                                                                          child: Text(
                                                                                        'กรุณากรอกคำอธิบายและวันที่ !!',
                                                                                        style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                      )),
                                                                                      actions: <Widget>[
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 100,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Colors.redAccent,
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
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                } else {
                                                                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                                                                  var ren = preferences.getString('renTalSer');
                                                                                  String url = '${MyConstant().domain}/UpC_Sta_maintenance.php?isAdd=true&ren=$ren&Ser=$Ser_&because=$because_&datex=$Value_selectDate';
                                                                                  try {
                                                                                    var response = await http.get(Uri.parse(url));
                                                                                    var result = json.decode(response.body);
                                                                                    print('-------->>>> $result');
                                                                                    if (result.toString() == 'true') {
                                                                                      setState(() {
                                                                                        Formbecause_.clear();
                                                                                        Value_selectDate = null;
                                                                                      });
                                                                                    }
                                                                                    red_Trans_c_maintenance();
                                                                                    Navigator.pop(context, 'OK');
                                                                                  } catch (e) {}
                                                                                }
                                                                              },
                                                                              child: const Text(
                                                                                'ยืนยัน',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                100,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Colors.redAccent,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  Value_selectDate = null;
                                                                                });
                                                                                red_Trans_c_maintenance();
                                                                                Navigator.pop(context, 'OK');
                                                                              },
                                                                              child: const Text(
                                                                                'ปิด',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    _scrollController2.animateTo(
                                      0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeOut,
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        // color: AppbackgroundColor
                                        //     .TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(8)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(3.0),
                                      child: const Text(
                                        'Top',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10.0,
                                            fontFamily: FontWeight_.Fonts_T),
                                      )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_scrollController2.hasClients) {
                                    final position = _scrollController2
                                        .position.maxScrollExtent;
                                    _scrollController2.animateTo(
                                      position,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      // color: AppbackgroundColor
                                      //     .TiTile_Colors,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(3.0),
                                    child: const Text(
                                      'Down',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.0,
                                          fontFamily: FontWeight_.Fonts_T),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: _moveUp2,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    // color: AppbackgroundColor
                                    //     .TiTile_Colors,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(3.0),
                                  child: const Text(
                                    'Scroll',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
                              InkWell(
                                onTap: _moveDown2,
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Status2_1Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(
              //     color: Colors.grey, width: 1),
            ),
            height: MediaQuery.of(context).size.height * 0.7,
            // width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // height: 30,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                          // border: Border.all(
                          //     color: Colors.grey, width: 1),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            'แจ้งซ่อมบำรุง',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppbackgroundColor.Sub_Abg_Colors,

                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    // border: Border.all(
                    //     color: Colors.grey, width: 1),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: AutoSizeText(
                          minFontSize: 10,
                          maxFontSize: 15,
                          maxLines: 3,
                          'พื้นที่',
                          style: const TextStyle(
                              color: PeopleChaoScreen_Color.Colors_Text1_,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontWeight_.Fonts_T),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            // border: Border.all(
                            //     color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 3,
                                lncodearea == null
                                    ? 'เลือกพื้นที่'
                                    : '$lncodearea',
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                            onTap: () {
                              showDialog<String>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: const Center(
                                      child: Text(
                                    'เลือกพื้นที่',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  )),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: ListView.builder(
                                                  itemCount: areaModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            serarea =
                                                                areaModels[
                                                                        index]
                                                                    .ser;
                                                            lncodearea =
                                                                areaModels[
                                                                        index]
                                                                    .lncode;
                                                            lnarea = areaModels[
                                                                    index]
                                                                .ln;
                                                            snamearea =
                                                                areaModels[
                                                                        index]
                                                                    .sname;
                                                            custnoarea =
                                                                areaModels[
                                                                        index]
                                                                    .custno;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        title: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                '${areaModels[index].lncode}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                  color: ManageScreen_Color
                                                                      .Colors_Text2_,
                                                                  // fontWeight:
                                                                  //     FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.center,
                                          //     children: [
                                          //       Container(
                                          //         width: 100,
                                          //         decoration:
                                          //             const BoxDecoration(
                                          //           color: Colors.green,
                                          //           borderRadius:
                                          //               BorderRadius.only(
                                          //                   topLeft:
                                          //                       Radius.circular(
                                          //                           10),
                                          //                   topRight:
                                          //                       Radius.circular(
                                          //                           10),
                                          //                   bottomLeft:
                                          //                       Radius.circular(
                                          //                           10),
                                          //                   bottomRight:
                                          //                       Radius.circular(
                                          //                           10)),
                                          //         ),
                                          //         padding:
                                          //             const EdgeInsets.all(8.0),
                                          //         child: TextButton(
                                          //           onPressed: () {
                                          //             setState(() {});
                                          //             Navigator.pop(
                                          //                 context, 'OK');
                                          //           },
                                          //           child: const Text(
                                          //             'บันทึก',
                                          //             style: TextStyle(
                                          //               color: Colors.white,
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               fontFamily:
                                          //                   FontWeight_.Fonts_T,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          Container(
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'ยกเลิก',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            // border: Border.all(
                            //     color: Colors.grey, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                color: ManageScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          child: const Center(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ManageScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          child: const Center(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ManageScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          child: const Center(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ManageScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          child: const Center(
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ManageScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    color: AppbackgroundColor.Sub_Abg_Colors,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    // border: Border.all(
                    //     color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 3,
                                'วันที่แจ้งซ่อม',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // color: Colors.green,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      DateTime? newDate = await showDatePicker(
                                        locale: const Locale('th', 'TH'),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1000, 1, 01),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 50)),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: AppBarColors
                                                    .ABar_Colors, // header background color
                                                onPrimary: Colors
                                                    .white, // header text color
                                                onSurface: Colors
                                                    .black, // body text color
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors
                                                      .black, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );

                                      if (newDate == null) {
                                        return;
                                      } else {
                                        print('$newDate');

                                        String start = DateFormat('yyyy-MM-dd')
                                            .format(newDate);

                                        print('$start');
                                        setState(() {
                                          Value_D_start = start;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(15.0),
                                      child: AutoSizeText(
                                        Value_D_start == null
                                            ? 'เลือกวันที่'
                                            : '$Value_D_start',
                                        minFontSize: 9,
                                        maxFontSize: 16,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: Font_.Fonts_T),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                minFontSize: 10,
                                maxFontSize: 15,
                                maxLines: 3,
                                'รายละเอียด',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text1_,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontWeight_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                // keyboardType: TextInputType.name,
                                controller: Form_note,
                                // onChanged: (value) =>
                                //     _Form_nameshop = value.trim(),
                                //initialValue: _Form_nameshop,
                                onFieldSubmitted: (value) async {},
                                maxLines: 9,
                                // maxLength: 13,
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                    fillColor: Colors.white.withOpacity(0.3),
                                    filled: true,
                                    // prefixIcon:
                                    //     const Icon(Icons.person, color: Colors.black),
                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // labelText: 'ระบุชื่อร้านค้า',
                                    labelStyle: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.Sub_Abg_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6)),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),

                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'ยกเลิก',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    indexdelog = 0;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6)),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),

                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'บันทึก',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T),
                                  ),
                                ),
                                onTap: () async {
                                  var aser = serarea;

                                  var d_start = Value_D_start;
                                  var note_aser = Form_note.text;
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  String? ren =
                                      preferences.getString('renTalSer');
                                  String? ser_user =
                                      preferences.getString('ser');
                                  String url =
                                      '${MyConstant().domain}/In_c_maintenance.php?isAdd=true&ren=$ren&ser_user=$ser_user&aser=$aser&d_start=$d_start';

                                  try {
                                    var response =
                                        await http.post(Uri.parse(url), body: {
                                      'aser': aser.toString(),
                                      'd_start': d_start.toString(),
                                      'note_aser': note_aser.toString(),
                                      'snamearea': snamearea.toString(),
                                      'custnoarea': custnoarea.toString(),
                                    }).then((value) async {
                                      print('11111111......>>${value.body}');
                                      if (value.body.toString() == 'true') {
                                        setState(() {
                                          serarea = null;
                                          lncodearea = null;
                                          lnarea = null;
                                          Value_D_start = null;
                                          snamearea = null;
                                          custnoarea = null;
                                          Form_note.clear();
                                          indexdelog = 0;
                                          red_Trans_c_maintenance();
                                        });
                                      }
                                    });

                                    // var response =
                                    //     await http.get(Uri.parse(url));

                                    // var result = json.decode(response.body);
                                    // print(result);
                                    // if (result.toString() == 'true') {
                                    //   setState(() {
                                    //     serarea = null;
                                    //     lncodearea = null;
                                    //     lnarea = null;
                                    //     Value_D_start = null;
                                    //     snamearea = null;
                                    //     custnoarea = null;
                                    //     Form_note.clear();
                                    //     indexdelog = 0;
                                    //     red_Trans_c_maintenance();
                                    //   });
                                    // } else {}
                                  } catch (e) {}
                                },
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Status3_Web() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Coming Soon',
          style: TextStyle(
            color: ManageScreen_Color.Colors_Text1_,
            fontWeight: FontWeight.bold,
            fontFamily: FontWeight_.Fonts_T,
            //fontSize: 10.0
          ),
        ),
      ),
    );
  }

//   Widget BodyHome_mobile() {
//     return Column(
//       children: [
//         (Status_ == 1)
//             ? Status1_mobile(context, _scrollController1, _moveUp1, _moveDown1,
//                 tappedIndex_, _setState)
//             : (Status_ == 2)
//                 ? Status2_Web()
//                 : Status3_Web()
//       ],
//     );
//   }
// }

// Widget Status1_mobile(context, _scrollController1, _moveUp1, _moveDown1,
//     tappedIndex_, _setState) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             color: AppbackgroundColor.Sub_Abg_Colors,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10)),
//             // border: Border.all(
//             //     color: Colors.grey, width: 1),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 ScrollConfiguration(
//                   behavior:
//                       ScrollConfiguration.of(context).copyWith(dragDevices: {
//                     PointerDeviceKind.touch,
//                     PointerDeviceKind.mouse,
//                   }),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     dragStartBehavior: DragStartBehavior.start,
//                     child: Container(
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 1100,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 1100,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 10,
//                                         child: Container(
//                                           height: 30,
//                                           decoration: const BoxDecoration(
//                                             color: Colors.green,
//                                             borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(10),
//                                                 topRight: Radius.circular(0),
//                                                 bottomLeft: Radius.circular(0),
//                                                 bottomRight:
//                                                     Radius.circular(0)),
//                                             // border: Border.all(
//                                             //     color: Colors.grey, width: 1),
//                                           ),
//                                           child: const Center(
//                                             child: Text(
//                                               'ผู้เช่า',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 30,
//                                           color: Colors.red,
//                                           child: const Center(
//                                             child: Text(
//                                               'มิเตอร์ไฟ',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 30,
//                                           color: Colors.blue,
//                                           child: const Center(
//                                             child: Text(
//                                               'เลขมิเตอร์น้ำ',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 4,
//                                         child: Container(
//                                           height: 30,
//                                           color: Colors.orange,
//                                           child: const Center(
//                                             child: Text(
//                                               'หน่วยที่ใช้',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       // Expanded(
//                                       //   flex: 2,
//                                       //   child: Text(
//                                       //     '',
//                                       //     textAlign: TextAlign.center,
//                                       //     style: TextStyle(
//                                       //       color: Colors.black,
//                                       //       // fontWeight: FontWeight.bold,
//                                       //       //fontSize: 10.0
//                                       //     ),
//                                       //   ),
//                                       // ),

//                                       Expanded(
//                                         flex: 6,
//                                         child: Container(
//                                           height: 30,
//                                           decoration: const BoxDecoration(
//                                             color: Colors.deepPurple,
//                                             borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(0),
//                                                 topRight: Radius.circular(10),
//                                                 bottomLeft: Radius.circular(0),
//                                                 bottomRight:
//                                                     Radius.circular(0)),
//                                             // border: Border.all(
//                                             //     color: Colors.grey, width: 1),
//                                           ),
//                                           child: const Center(
//                                             child: Text(
//                                               'จำนวนเงิน',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 1100,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.lightGreen[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'รหัสพื้นที่',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.lightGreen[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'ชื่อร้านค้า',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 3,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.lightGreen[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'มิเตอร์ไฟเดือนก่อน',
//                                               textAlign: TextAlign.center,
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 3,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.lightGreen[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'มิเตอร์น้ำเดือนก่อน',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.red[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'เลขมิเตอร์เดือนนี้',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.blue[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'เลขมิเตอร์เดือนนี้',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.orange[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'ไฟฟ้าหน่วย',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.orange[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'น้ำหน่วย',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.deepPurple[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'ค่าไฟ(บาท)',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.deepPurple[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'ค่าน้ำ(บาท)',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           height: 50,
//                                           color: Colors.deepPurple[300],
//                                           child: const Center(
//                                             child: Text(
//                                               'รวม',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ManageScreen_Color
//                                                     .Colors_Text2_,
//                                                 // fontWeight: FontWeight.bold,
//                                                 fontFamily: Font_.Fonts_T,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 1100,
//                                   height:
//                                       MediaQuery.of(context).size.height / 1.7,
//                                   decoration: const BoxDecoration(
//                                     color: AppbackgroundColor.Sub_Abg_Colors,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(0),
//                                       topRight: Radius.circular(0),
//                                       bottomLeft: Radius.circular(0),
//                                       bottomRight: Radius.circular(0),
//                                     ),
//                                     // border: Border.all(
//                                     //     color: Colors.grey, width: 1),
//                                   ),
//                                   child: ListView.builder(
//                                     controller: _scrollController1,
//                                     // itemExtent: 50,
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: 50,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return Container(
//                                         color: tappedIndex_ == index.toString()
//                                             ? tappedIndex_Color
//                                                 .tappedIndex_Colors
//                                                 .withOpacity(0.5)
//                                             : null,
//                                         child: ListTile(
//                                           onTap: () {
//                                             _setState(index);
//                                           },
//                                           contentPadding:
//                                               const EdgeInsets.all(8.0),
//                                           title: Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   'SHOP${100 + index + 1}',
//                                                   textAlign: TextAlign.center,
//                                                   style: const TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   'ชื่อร้านค้า',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 3,
//                                                 child: Text(
//                                                   'Mini Big C ${index + 1}',
//                                                   textAlign: TextAlign.center,
//                                                   maxLines: 1,
//                                                   style: const TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 3,
//                                                 child: Text(
//                                                   '${200 + index + 1}',
//                                                   textAlign: TextAlign.center,
//                                                   style: const TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       'กรอก${index + 1}',
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: const TextStyle(
//                                                         color:
//                                                             ManageScreen_Color
//                                                                 .Colors_Text2_,
//                                                         // fontWeight: FontWeight.bold,
//                                                         fontFamily:
//                                                             Font_.Fonts_T,
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         showDialog<String>(
//                                                           barrierDismissible:
//                                                               false,
//                                                           context: context,
//                                                           builder: (BuildContext
//                                                                   context) =>
//                                                               AlertDialog(
//                                                             shape: const RoundedRectangleBorder(
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             20.0))),
//                                                             title: Center(
//                                                                 child: Text(
//                                                               'มิเตอร์ไฟ${index + 1}',
//                                                               style:
//                                                                   const TextStyle(
//                                                                 color: ManageScreen_Color
//                                                                     .Colors_Text1_,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 fontFamily:
//                                                                     FontWeight_
//                                                                         .Fonts_T,
//                                                               ),
//                                                             )),
//                                                             content:
//                                                                 SingleChildScrollView(
//                                                                     child: Column(
//                                                                         children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child:
//                                                                         TextFormField(
//                                                                       keyboardType:
//                                                                           TextInputType
//                                                                               .number,
//                                                                       // controller:
//                                                                       //     Form1_text,
//                                                                       validator:
//                                                                           (value) {
//                                                                         if (value ==
//                                                                                 null ||
//                                                                             value
//                                                                                 .isEmpty ||
//                                                                             value.length <
//                                                                                 13) {
//                                                                           return 'ใส่ข้อมูลให้ครบถ้วน ';
//                                                                         }
//                                                                         // if (int.parse(value.toString()) < 13) {
//                                                                         //   return '< 13';
//                                                                         // }
//                                                                         return null;
//                                                                       },
//                                                                       // maxLength: 13,
//                                                                       cursorColor:
//                                                                           Colors
//                                                                               .green,
//                                                                       decoration: InputDecoration(
//                                                                           fillColor: Colors.white.withOpacity(0.3),
//                                                                           filled: true,
//                                                                           prefixIcon: const Icon(Icons.electrical_services, color: Colors.red),
//                                                                           // suffixIcon: Icon(Icons.clear, color: Colors.black),
//                                                                           focusedBorder: const OutlineInputBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.only(
//                                                                               topRight: Radius.circular(15),
//                                                                               topLeft: Radius.circular(15),
//                                                                               bottomRight: Radius.circular(15),
//                                                                               bottomLeft: Radius.circular(15),
//                                                                             ),
//                                                                             borderSide:
//                                                                                 BorderSide(
//                                                                               width: 1,
//                                                                               color: Colors.black,
//                                                                             ),
//                                                                           ),
//                                                                           enabledBorder: const OutlineInputBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.only(
//                                                                               topRight: Radius.circular(15),
//                                                                               topLeft: Radius.circular(15),
//                                                                               bottomRight: Radius.circular(15),
//                                                                               bottomLeft: Radius.circular(15),
//                                                                             ),
//                                                                             borderSide:
//                                                                                 BorderSide(
//                                                                               width: 1,
//                                                                               color: Colors.grey,
//                                                                             ),
//                                                                           ),
//                                                                           labelText: 'เลขมิเตอร์ไฟ',
//                                                                           labelStyle: const TextStyle(
//                                                                             color:
//                                                                                 ManageScreen_Color.Colors_Text2_,
//                                                                             // fontWeight:
//                                                                             //     FontWeight.bold,
//                                                                             fontFamily:
//                                                                                 Font_.Fonts_T,
//                                                                           )),
//                                                                       inputFormatters: <
//                                                                           TextInputFormatter>[
//                                                                         // for below version 2 use this
//                                                                         FilteringTextInputFormatter.allow(
//                                                                             RegExp(r'[0-9]')),
//                                                                         // for version 2 and greater youcan also use this
//                                                                         FilteringTextInputFormatter
//                                                                             .digitsOnly
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ])),
//                                                             actions: <Widget>[
//                                                               Row(
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding:
//                                                                               const EdgeInsets.all(8.0),
//                                                                           child:
//                                                                               Container(
//                                                                             width:
//                                                                                 100,
//                                                                             decoration:
//                                                                                 const BoxDecoration(
//                                                                               color: Colors.green,
//                                                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                                                                             ),
//                                                                             padding:
//                                                                                 const EdgeInsets.all(8.0),
//                                                                             child:
//                                                                                 TextButton(
//                                                                               onPressed: () => Navigator.pop(context, 'OK'),
//                                                                               child: const Text(
//                                                                                 'บันทึก',
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontFamily: FontWeight_.Fonts_T,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding:
//                                                                               const EdgeInsets.all(8.0),
//                                                                           child:
//                                                                               Container(
//                                                                             width:
//                                                                                 100,
//                                                                             decoration:
//                                                                                 const BoxDecoration(
//                                                                               color: Colors.red,
//                                                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                                                                             ),
//                                                                             padding:
//                                                                                 const EdgeInsets.all(8.0),
//                                                                             child:
//                                                                                 TextButton(
//                                                                               onPressed: () => Navigator.pop(context, 'OK'),
//                                                                               child: const Text(
//                                                                                 'ยกเลิก',
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontFamily: FontWeight_.Fonts_T,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         );
//                                                       },
//                                                       child: const Icon(
//                                                         Icons.edit,
//                                                         color: Colors.white,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                       'กรอก${index + 1}',
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: const TextStyle(
//                                                         color:
//                                                             ManageScreen_Color
//                                                                 .Colors_Text1_,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontFamily:
//                                                             FontWeight_.Fonts_T,
//                                                       ),
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         showDialog<String>(
//                                                           barrierDismissible:
//                                                               false,
//                                                           context: context,
//                                                           builder: (BuildContext
//                                                                   context) =>
//                                                               AlertDialog(
//                                                             shape: const RoundedRectangleBorder(
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             20.0))),
//                                                             title: Center(
//                                                                 child: Text(
//                                                               'มิเตอร์น้ำ${index + 1}',
//                                                               style:
//                                                                   const TextStyle(
//                                                                 color: ManageScreen_Color
//                                                                     .Colors_Text1_,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 fontFamily:
//                                                                     FontWeight_
//                                                                         .Fonts_T,
//                                                               ),
//                                                             )),
//                                                             content:
//                                                                 SingleChildScrollView(
//                                                                     child: Column(
//                                                                         children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child:
//                                                                         TextFormField(
//                                                                       keyboardType:
//                                                                           TextInputType
//                                                                               .number,
//                                                                       // controller:
//                                                                       //     Form1_text,
//                                                                       validator:
//                                                                           (value) {
//                                                                         if (value ==
//                                                                                 null ||
//                                                                             value
//                                                                                 .isEmpty ||
//                                                                             value.length <
//                                                                                 13) {
//                                                                           return 'ใส่ข้อมูลให้ครบถ้วน ';
//                                                                         }
//                                                                         // if (int.parse(value.toString()) < 13) {
//                                                                         //   return '< 13';
//                                                                         // }
//                                                                         return null;
//                                                                       },
//                                                                       // maxLength: 13,
//                                                                       cursorColor:
//                                                                           Colors
//                                                                               .green,
//                                                                       decoration: InputDecoration(
//                                                                           fillColor: Colors.white.withOpacity(0.3),
//                                                                           filled: true,
//                                                                           prefixIcon: const Icon(Icons.water, color: Colors.blue),
//                                                                           // suffixIcon: Icon(Icons.clear, color: Colors.black),
//                                                                           focusedBorder: const OutlineInputBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.only(
//                                                                               topRight: Radius.circular(15),
//                                                                               topLeft: Radius.circular(15),
//                                                                               bottomRight: Radius.circular(15),
//                                                                               bottomLeft: Radius.circular(15),
//                                                                             ),
//                                                                             borderSide:
//                                                                                 BorderSide(
//                                                                               width: 1,
//                                                                               color: Colors.black,
//                                                                             ),
//                                                                           ),
//                                                                           enabledBorder: const OutlineInputBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.only(
//                                                                               topRight: Radius.circular(15),
//                                                                               topLeft: Radius.circular(15),
//                                                                               bottomRight: Radius.circular(15),
//                                                                               bottomLeft: Radius.circular(15),
//                                                                             ),
//                                                                             borderSide:
//                                                                                 BorderSide(
//                                                                               width: 1,
//                                                                               color: Colors.grey,
//                                                                             ),
//                                                                           ),
//                                                                           labelText: 'เลขมิเตอร์น้ำ',
//                                                                           labelStyle: const TextStyle(
//                                                                             color:
//                                                                                 ManageScreen_Color.Colors_Text2_,
//                                                                             // fontWeight:
//                                                                             //     FontWeight.bold,
//                                                                             fontFamily:
//                                                                                 Font_.Fonts_T,
//                                                                           )),
//                                                                       inputFormatters: <
//                                                                           TextInputFormatter>[
//                                                                         // for below version 2 use this
//                                                                         FilteringTextInputFormatter.allow(
//                                                                             RegExp(r'[0-9]')),
//                                                                         // for version 2 and greater youcan also use this
//                                                                         FilteringTextInputFormatter
//                                                                             .digitsOnly
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ])),
//                                                             actions: <Widget>[
//                                                               Row(
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding:
//                                                                               const EdgeInsets.all(8.0),
//                                                                           child:
//                                                                               Container(
//                                                                             width:
//                                                                                 100,
//                                                                             decoration:
//                                                                                 const BoxDecoration(
//                                                                               color: Colors.green,
//                                                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                                                                             ),
//                                                                             padding:
//                                                                                 const EdgeInsets.all(8.0),
//                                                                             child:
//                                                                                 TextButton(
//                                                                               onPressed: () => Navigator.pop(context, 'OK'),
//                                                                               child: const Text(
//                                                                                 'บันทึก',
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontFamily: FontWeight_.Fonts_T,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                         const EdgeInsets.all(
//                                                                             8.0),
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding:
//                                                                               const EdgeInsets.all(8.0),
//                                                                           child:
//                                                                               Container(
//                                                                             width:
//                                                                                 100,
//                                                                             decoration:
//                                                                                 const BoxDecoration(
//                                                                               color: Colors.red,
//                                                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                                                                             ),
//                                                                             padding:
//                                                                                 const EdgeInsets.all(8.0),
//                                                                             child:
//                                                                                 TextButton(
//                                                                               onPressed: () => Navigator.pop(context, 'OK'),
//                                                                               child: const Text(
//                                                                                 'ยกเลิก',
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontFamily: FontWeight_.Fonts_T,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         );
//                                                       },
//                                                       child: const Icon(
//                                                         Icons.edit,
//                                                         color: Colors.white,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   '-',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   '-',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   '-',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   '-',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const Expanded(
//                                                 flex: 2,
//                                                 child: Text(
//                                                   '-',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: ManageScreen_Color
//                                                         .Colors_Text2_,
//                                                     // fontWeight: FontWeight.bold,
//                                                     fontFamily: Font_.Fonts_T,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: const BoxDecoration(
//                       color: AppbackgroundColor.Sub_Abg_Colors,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(0),
//                           topRight: Radius.circular(0),
//                           bottomLeft: Radius.circular(10),
//                           bottomRight: Radius.circular(10)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     _scrollController1.animateTo(
//                                       0,
//                                       duration: const Duration(seconds: 1),
//                                       curve: Curves.easeOut,
//                                     );
//                                   },
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                         // color: AppbackgroundColor
//                                         //     .TiTile_Colors,
//                                         borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(6),
//                                             topRight: Radius.circular(6),
//                                             bottomLeft: Radius.circular(6),
//                                             bottomRight: Radius.circular(8)),
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                       ),
//                                       padding: const EdgeInsets.all(3.0),
//                                       child: const Text(
//                                         'Top',
//                                         style: TextStyle(
//                                           color:
//                                               ManageScreen_Color.Colors_Text1_,
//                                           fontSize: 10.0,
//                                           fontFamily: FontWeight_.Fonts_T,
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (_scrollController1.hasClients) {
//                                     final position = _scrollController1
//                                         .position.maxScrollExtent;
//                                     _scrollController1.animateTo(
//                                       position,
//                                       duration: const Duration(seconds: 1),
//                                       curve: Curves.easeOut,
//                                     );
//                                   }
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       // color: AppbackgroundColor
//                                       //     .TiTile_Colors,
//                                       borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(6),
//                                           topRight: Radius.circular(6),
//                                           bottomLeft: Radius.circular(6),
//                                           bottomRight: Radius.circular(6)),
//                                       border: Border.all(
//                                           color: Colors.grey, width: 1),
//                                     ),
//                                     padding: const EdgeInsets.all(3.0),
//                                     child: const Text(
//                                       'Down',
//                                       style: TextStyle(
//                                         color: ManageScreen_Color.Colors_Text1_,
//                                         fontSize: 10.0,
//                                         fontFamily: FontWeight_.Fonts_T,
//                                       ),
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Row(
//                             children: [
//                               InkWell(
//                                 onTap: _moveUp1,
//                                 child: const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Icon(
//                                         Icons.arrow_upward,
//                                         color: Colors.grey,
//                                       ),
//                                     )),
//                               ),
//                               Container(
//                                   decoration: BoxDecoration(
//                                     // color: AppbackgroundColor
//                                     //     .TiTile_Colors,
//                                     borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(6),
//                                         topRight: Radius.circular(6),
//                                         bottomLeft: Radius.circular(6),
//                                         bottomRight: Radius.circular(6)),
//                                     border: Border.all(
//                                         color: Colors.grey, width: 1),
//                                   ),
//                                   padding: const EdgeInsets.all(3.0),
//                                   child: const Text(
//                                     'Scroll',
//                                     style: TextStyle(
//                                       color: ManageScreen_Color.Colors_Text1_,
//                                       fontSize: 10.0,
//                                       fontFamily: FontWeight_.Fonts_T,
//                                     ),
//                                   )),
//                               InkWell(
//                                 onTap: _moveDown1,
//                                 child: const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Align(
//                                       alignment: Alignment.centerRight,
//                                       child: Icon(
//                                         Icons.arrow_downward,
//                                         color: Colors.grey,
//                                       ),
//                                     )),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         )
//       ],
//     ),
//   );
}
