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
import '../Model/GetArea_Model.dart';
import '../Model/GetC_Syslog.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Excel_ChaoArea_Report.dart';
import 'Excel_Cust_Report.dart';
import 'Excel_SystemLog_Report.dart';

class ReportScreen3 extends StatefulWidget {
  const ReportScreen3({super.key});

  @override
  State<ReportScreen3> createState() => _ReportScreen3State();
}

class _ReportScreen3State extends State<ReportScreen3> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int? Await_Status_Report1,
      Await_Status_Report2,
      Await_Status_Report3,
      Await_Status_Report4,
      Await_Status_Report5,
      Await_Status_Report6;
  int? show_more;
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<AreaModel> areaModels = [];
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<SyslogModel> syslogModel_Mon = [];
  List<SyslogModel> syslogModel = [];
  List<SyslogModel> _syslogModel = <SyslogModel>[];
  String? renTal_user,
      renTal_name,
      Status_pe,
      Status_pe_ser,
      Status_Area,
      Status_Area_ser,
      Status_Type_cus,
      Status_Type_cus_ser;
  var Value_selectDate_syslog;
  String? Value_Chang_Zone_Area, Value_Chang_Zone_Area_Ser;
  String? Value_Chang_Menu_LogSytem_Mon, Value_Chang_Menu_LogSytem_Ser_Mon;
  String? Value_Chang_Menu_LogSytem, Value_Chang_Menu_LogSytem_Ser;
  String? YE_syslog_Mon;
  String? Mon_syslog_Mon;
  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];
  List<TypeModel> typeModels = [];
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_type();
  }

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
  List Status_Area_ = [
    'ทั้งหมด',
    'ใกล้หมดสัญญา',
    'เสนอราคา',
    'ว่าง',
    'เช่าอยู่',
  ];
  List Status_syslog = [
    'ทั้งหมด',
    'พื้นที่เช่า',
    'ผู้เช่า',
    'บัญชี',
    'จัดการ',
    'รายงาน',
    'ทะเบียน',
    'ตั้งค่า'
  ];
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

  //////////------------------------------------------------------->(รายงาน ข้อมูลพื้นที่เช่า)
  Future<Null> read_GC_area() async {
    if (areaModels.length != 0) {
      setState(() {
        areaModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = Value_Chang_Zone_Area_Ser;

    print('zone >>>>>> $zone');

    String url = (zone == '0')
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
        : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

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
        }
      } else {}

      print('zoneModels >>. ${zoneModels.length}');
    } catch (e) {}
  }

  Future<Null> read_GC_areaSelect() async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = Value_Chang_Zone_Area_Ser;

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $Status_Area_ser');

    if (Status_Area_ser == '1') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';
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
        } else {}
      } catch (e) {}
    } else if (Status_Area_ser == '2') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            var daterx = areaModel.ldate;

            if (daterx != null) {
              int daysBetween(DateTime from, DateTime to) {
                from = DateTime(from.year, from.month, from.day);
                to = DateTime(to.year, to.month, to.day);
                return (to.difference(from).inHours / 24).round();
              }

              var birthday = DateTime.parse('$daterx 00:00:00.000')
                  .add(const Duration(days: -30));
              var date2 = DateTime.now();
              var difference = daysBetween(birthday, date2);

              print('difference == $difference');

              if (difference < 30 && difference > 0) {
                setState(() {
                  areaModels.add(areaModel);
                });
              }
            }
          }
        } else {}
      } catch (e) {}
    } else if (Status_Area_ser == '3') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            if (areaModel.quantity == '2' || areaModel.quantity == '3') {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
      } catch (e) {}
    } else if (Status_Area_ser == '4') {
      String url = (zone == '0')
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
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
      } catch (e) {}
    } else if (Status_Area_ser == '5') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            if (int.parse(areaModel.quantity!) == 1) {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
      } catch (e) {}
    } else if (Status_Area_ser == '6') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            if (areaModel.quantity != '1') {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
      } catch (e) {}
    } else if (Status_Area_ser == '7') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            AreaModel areaModel = AreaModel.fromJson(map);
            if (areaModel.quantity == '1' || areaModel.quantity == null) {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
      } catch (e) {}
    }
    setState(() {
      Await_Status_Report4 = 1;
    });
  }

  ///----------------------------------------------------------->(รายงาน ประวัติการใช้งาน เดือน)
  Future<Null> red_Syslog_Mon() async {
    if (syslogModel_Mon.length != 0) {
      setState(() {
        syslogModel_Mon.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ser_user = preferences.getString('ser');

    String Status_ = '${Value_Chang_Menu_LogSytem_Mon}';

    String url =
        '${MyConstant().domain}/GC_Syslog_Report_Mon.php?isAdd=true&ren=$ren&datex_=$Value_selectDate_syslog&status=$Status_&monx=$Mon_syslog_Mon&yex=$YE_syslog_Mon';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          SyslogModel syslogModels = SyslogModel.fromJson(map);
          setState(() {
            syslogModel_Mon.add(syslogModels);
          });
        }

        print('00000000>>>>>>>>>>>>>>>>> ${syslogModel_Mon.length}');
      } else {}
    } catch (e) {}
    setState(() {
      Await_Status_Report5 = 1;
    });
  }

  ///----------------------------------------------------------->(รายงาน ประวัติการใช้งาน)
  Future<Null> red_Syslog() async {
    if (syslogModel.length != 0) {
      setState(() {
        syslogModel.clear();
        _syslogModel.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var ser_user = preferences.getString('ser');

    String Status_ = '${Value_Chang_Menu_LogSytem}';

    String url =
        '${MyConstant().domain}/GC_Syslog_Report.php?isAdd=true&ren=$ren&datex_=$Value_selectDate_syslog&status=$Status_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          SyslogModel syslogModels = SyslogModel.fromJson(map);
          setState(() {
            syslogModel.add(syslogModels);
            _syslogModel = syslogModel;
          });
        }

        print('00000000>>>>>>>>>>>>>>>>> ${syslogModel.length}');
      } else {}
    } catch (e) {}
    setState(() {
      Await_Status_Report6 = 1;
    });
  }

  ///----------------------------------------------------------->(วันที่ ประวัติการใช้งาน)
  Future<Null> _select_Date_syslog(BuildContext context) async {
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
          Value_selectDate_syslog = "${formatter.format(result)}";
        });

        // red_Trans_bill_Groptype_daly();
      }
    });
  }

////////////------------------------------------------------>
  Future<Null> select_coutumer() async {
    if (customerModels.isNotEmpty) {
      setState(() {
        customerModels.clear();
        _customerModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ren = preferences.getString('renTalSer');
    String url = (Status_Type_cus_ser == '0')
        ? '${MyConstant().domain}/GC_custo_se.php?isAdd=true&ren=$ren'
        : '${MyConstant().domain}/GC_custo_se_Zone.php?isAdd=true&ren=$ren&ser_s=$Status_Type_cus_ser';

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

////////--------------------------------------------------------------->
  Future<Null> read_GC_type() async {
    if (typeModels.isNotEmpty) {
      typeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['type'] = 'ทั้งหมด';
      map['st'] = '0';
      map['data_update'] = '0';

      TypeModel typeModelx = TypeModel.fromJson(map);
      setState(() {
        typeModels.add(typeModelx);
      });
      if (result != null) {
        for (var map in result) {
          TypeModel typeModel = TypeModel.fromJson(map);
          setState(() {
            typeModels.add(typeModel);
          });
        }
        // setState(() {
        //   for (var i = 0; i < typeModels.length; i++) {
        //     _verticalGroupValue = typeModels[i].type!;
        //   }
        // });
      } else {}
    } catch (e) {}
  }

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
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            value: Status_Area,

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
                            items: Status_Area_.map(
                                (item) => DropdownMenuItem<String>(
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
                              int selectedIndex = Status_Area_.indexWhere(
                                  (item) => item == value);
                              setState(() {
                                Status_Area = Status_Area_[selectedIndex]!;
                                Status_Area_ser = '${selectedIndex + 1}';
                              });
                              print(selectedIndex);
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
                            value: Value_Chang_Zone_Area,
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
                                Value_Chang_Zone_Area = value!;
                                Value_Chang_Zone_Area_Ser =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              print(
                                  'Selected Index: $Value_Chang_Zone_Area  //${Value_Chang_Zone_Area_Ser}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_Chang_Zone_Area_Ser != null &&
                                Status_Area != null) {
                              setState(() {
                                Await_Status_Report1 = 0;
                              });
                              Dia_log();
                            }
                            read_GC_areaSelect();
                            // read_GC_area();
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
                              'รายงาน', 'กดดูรายงานข้อมูลพื้นที่เช่า');
                          RE_ChoArea_Widget();
                        }),
                    (areaModels.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Value_Chang_Zone_Area_Ser != null &&
                                      areaModels.isEmpty &&
                                      Status_Area != null &&
                                      Await_Status_Report1 != null)
                                  ? 'รายงาน ข้อมูลพื้นที่เช่า (ไม่พบข้อมูล ✖️)'
                                  : 'รายงาน ข้อมูลพื้นที่เช่า',
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
                              'รายงาน ข้อมูลพื้นที่เช่า ✔️',
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
                            value: Mon_syslog_Mon,
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
                              Mon_syslog_Mon = value;

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
                            value: YE_syslog_Mon,
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
                              YE_syslog_Mon = value;

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
                          'เมนู :',
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
                            value: Value_Chang_Menu_LogSytem_Mon,
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
                            items: Status_syslog.map(
                                (item) => DropdownMenuItem<String>(
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
                              int selectedIndex = Status_syslog.indexWhere(
                                  (item) => item == value);

                              setState(() {
                                Value_Chang_Menu_LogSytem_Mon = value!;
                                Value_Chang_Menu_LogSytem_Ser_Mon =
                                    selectedIndex.toString();
                              });
                              print(
                                  'Selected Index: $Value_Chang_Menu_LogSytem_Mon  //${Value_Chang_Menu_LogSytem_Ser_Mon}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Mon_syslog_Mon != null &&
                                YE_syslog_Mon != null &&
                                Value_Chang_Menu_LogSytem_Mon != null) {
                              setState(() {
                                Await_Status_Report2 = 0;
                              });
                              Dia_log();
                            }
                            red_Syslog_Mon();
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
                              'รายงาน', 'กดดูรายงานประวัติการใช้งานรายเดือน');
                          RE_SytemLog_Mon_Widget();
                        }),
                    (syslogModel_Mon.isEmpty || Await_Status_Report2 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Mon_syslog_Mon != null &&
                                      YE_syslog_Mon != null &&
                                      Value_Chang_Menu_LogSytem_Mon != null &&
                                      Await_Status_Report2 != null)
                                  ? 'รายงานประวัติการใช้งานรายเดือน (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานประวัติการใช้งานรายเดือน',
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
                              'รายงานประวัติการใช้งานรายเดือน ✔️',
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
                            _select_Date_syslog(context);
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
                                  (Value_selectDate_syslog == null)
                                      ? 'เลือก'
                                      : '$Value_selectDate_syslog',
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
                          'เมนู :',
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
                            value: Value_Chang_Menu_LogSytem,
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
                            items: Status_syslog.map(
                                (item) => DropdownMenuItem<String>(
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
                              int selectedIndex = Status_syslog.indexWhere(
                                  (item) => item == value);

                              setState(() {
                                Value_Chang_Menu_LogSytem = value!;
                                Value_Chang_Menu_LogSytem_Ser =
                                    selectedIndex.toString();
                              });
                              print(
                                  'Selected Index: $Value_Chang_Menu_LogSytem  //${Value_Chang_Menu_LogSytem_Ser}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_selectDate_syslog != null &&
                                Value_Chang_Menu_LogSytem_Ser != null) {
                              setState(() {
                                Await_Status_Report3 = 0;
                              });
                              Dia_log();
                            }
                            red_Syslog();
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
                              'รายงาน', 'กดดูรายงานประวัติการใช้งานรายวัน');
                          RE_SytemLog_Widget();
                        }),
                    (syslogModel.isEmpty || Await_Status_Report3 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Value_selectDate_syslog != null &&
                                      Value_Chang_Menu_LogSytem_Ser != null &&
                                      syslogModel.isEmpty &&
                                      Await_Status_Report3 != null)
                                  ? 'รายงานประวัติการใช้งานรายวัน (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานประวัติการใช้งานรายวัน',
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
                              'รายงานประวัติการใช้งานรายวัน ✔️',
                              style: TextStyle(
                                color: ReportScreen_Color.Colors_Text2_,
                                // fontWeight: FontWeight.bold,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          )
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
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'ประเภท :',
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
                      width: 170,
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField2(
                        value: Status_Type_cus,

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
                        buttonWidth: 270,
                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          // color: Colors
                          //     .amber,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        items: typeModels
                            .map((item) => DropdownMenuItem<String>(
                                  value: '${item.type}',
                                  child: Text(
                                    '${item.type}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ))
                            .toList(),

                        onChanged: (value) async {
                          int selectedIndex = typeModels
                              .indexWhere((item) => item.type == value);
                          setState(() {
                            Status_Type_cus = value;
                            Status_Type_cus_ser =
                                '${typeModels[selectedIndex].ser}';
                          });
                          print(Status_Type_cus_ser);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          Await_Status_Report4 = 0;
                        });
                        Dia_log();
                        select_coutumer();
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
                      onTap: () {
                        Insert_log.Insert_logs(
                            'รายงาน', 'กดดูรายงานทะเบียนลูกค้า');
                        RE_Custo_Widget();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (customerModels.isNotEmpty)
                            ? 'รายงานทะเบียนลูกค้า ✔️'
                            : 'รายงานทะเบียนลูกค้า',
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
              SizedBox(
                height: 40,
              ),
            ])));
  }

  ///////////////////////////----------------------------------------------->(รายงานข้อมูลพื้นที่เช่า)
  RE_ChoArea_Widget() {
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
                (Value_Chang_Zone_Area == null)
                    ? 'รายงานข้อมูลพื้นที่เช่า (กรุณาเลือกโซน)'
                    : 'รายงานข้อมูลพื้นที่เช่า (โซน : $Value_Chang_Zone_Area) ',
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
                        'สถานะ: ${Status_Area}',
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
                        'ทั้งหมด: ${areaModels.length}',
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
                              : (areaModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (areaModels.length == 0)
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
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'โซนพื้นที่',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ชื้อพื้นที่',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ขนาดพื้นที่(ต.ร.ม.)',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ค่าเช่าต่องวด',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'เลขที่ใบสัญญา',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'เลขที่ใบเสนอราคา',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'วันสิ้นสุดสัญญา',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'สถานะ',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    ),
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
                                      itemCount: areaModels.length,
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
                                              setState(() {
                                                show_more = index;
                                              });
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
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '${areaModels[index].zn}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          fontFamily:
                                                              Font_.Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      areaModels[index].ln_c ==
                                                              null
                                                          ? areaModels[index]
                                                                      .ln_q ==
                                                                  null
                                                              ? '${areaModels[index].lncode}'
                                                              : '${areaModels[index].ln_q}'
                                                          : '${areaModels[index].ln_c}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                          fontFamily:
                                                              Font_.Fonts_T
                                                          //fontSize: 10.0
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    areaModels[index].area_c ==
                                                            null
                                                        ? areaModels[index]
                                                                    .ln_q ==
                                                                null
                                                            ? nFormat.format(
                                                                double.parse(
                                                                    areaModels[index]
                                                                        .area!))
                                                            : nFormat.format(
                                                                double.parse(
                                                                    areaModels[index]
                                                                        .area_q!))
                                                        : nFormat.format(
                                                            double.parse(
                                                                areaModels[index]
                                                                    .area_c!)),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    areaModels[index].total ==
                                                            null
                                                        ? areaModels[index]
                                                                    .total_q ==
                                                                null
                                                            ? nFormat.format(
                                                                double.parse(
                                                                    areaModels[index]
                                                                        .rent!))
                                                            : nFormat.format(
                                                                double.parse(
                                                                    areaModels[index]
                                                                        .total_q!))
                                                        : nFormat.format(
                                                            double.parse(
                                                                areaModels[index]
                                                                    .total!)),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T
                                                        //fontSize: 10.0
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        areaModels[index].cid ==
                                                                null
                                                            ? ''
                                                            : '${areaModels[index].cid}',
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.end,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        areaModels[index]
                                                                    .docno ==
                                                                null
                                                            ? ''
                                                            : '${areaModels[index].docno}',
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.end,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: areaModels[
                                                                            index]
                                                                        .docno !=
                                                                    null
                                                                ? Colors.blue
                                                                : PeopleChaoScreen_Color
                                                                    .Colors_Text2_,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      areaModels[index].ldate ==
                                                              null
                                                          ? areaModels[index]
                                                                      .ldate_q ==
                                                                  null
                                                              ? ''
                                                              : DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .parse(
                                                                          '${areaModels[index].ldate_q} 00:00:00'))
                                                                  .toString()
                                                          : DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(DateTime
                                                                  .parse(
                                                                      '${areaModels[index].ldate} 00:00:00'))
                                                              .toString(),
                                                      maxLines: 1,
                                                      textAlign: TextAlign.end,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: areaModels[
                                                                          index]
                                                                      .quantity ==
                                                                  '1'
                                                              ? datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                      true
                                                                  ? Colors.red
                                                                  : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                          true
                                                                      ? Colors
                                                                          .orange
                                                                          .shade900
                                                                      : Colors
                                                                          .black
                                                              : areaModels[index]
                                                                          .quantity ==
                                                                      '2'
                                                                  ? Colors.blue
                                                                  : areaModels[index]
                                                                              .quantity ==
                                                                          '3'
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .green,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    areaModels[index].quantity ==
                                                            '1'
                                                        ? datex.isAfter(DateTime.parse(
                                                                        '${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000')
                                                                    .subtract(const Duration(
                                                                        days:
                                                                            0))) ==
                                                                true
                                                            ? 'หมดสัญญา'
                                                            : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(
                                                                        const Duration(
                                                                            days:
                                                                                30))) ==
                                                                    true
                                                                ? 'ใกล้หมดสัญญา'
                                                                : 'เช่าอยู่'
                                                        : areaModels[index]
                                                                    .quantity ==
                                                                '2'
                                                            ? 'เสนอราคา'
                                                            : areaModels[index]
                                                                        .quantity ==
                                                                    '3'
                                                                ? 'เสนอราคา(มัดจำ)'
                                                                : 'ว่าง',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        color: areaModels[index]
                                                                    .quantity ==
                                                                '1'
                                                            ? datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(
                                                                        const Duration(
                                                                            days:
                                                                                0))) ==
                                                                    true
                                                                ? Colors.red
                                                                : datex.isAfter(DateTime.parse('${areaModels[index].ldate == null ? DateFormat('yyyy-MM-dd').format(datex) : areaModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                        true
                                                                    ? Colors
                                                                        .orange
                                                                        .shade900
                                                                    : Colors
                                                                        .black
                                                            : areaModels[index]
                                                                        .quantity ==
                                                                    '2'
                                                                ? Colors.blue
                                                                : areaModels[index]
                                                                            .quantity ==
                                                                        '3'
                                                                    ? Colors.blue
                                                                    : Colors.green,
                                                        fontFamily: Font_.Fonts_T
                                                        //fontSize: 10.0
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
                    if (areaModels.length != 0)
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
                              Value_Report = 'รายงานข้อมูลพื้นที่เช่า';
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
                            areaModels.clear();

                            Value_Chang_Zone_Area = null;
                            Value_Chang_Zone_Area_Ser = null;
                            Await_Status_Report1 = null;
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

///////////////////////////----------------------------------------------->(รายงานประวัติการใช้งานรายเดือน)
  RE_SytemLog_Mon_Widget() {
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
                (Value_Chang_Menu_LogSytem_Mon == null)
                    ? 'รายงานประวัติการใช้งานรายเดือน (กรุณาเลือกเมนู)'
                    : 'รายงานประวัติการใช้งานรายเดือน (เมนู : $Value_Chang_Menu_LogSytem_Mon) ',
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
                        'เดือน: $Mon_syslog_Mon (${YE_syslog_Mon})',
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
                        'ทั้งหมด: ${syslogModel_Mon.length}',
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
                              : (syslogModel_Mon.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (syslogModel_Mon.length == 0)
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
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     child: const Center(
                                          //       child: Text(
                                          //         'atype',
                                          //         style: TextStyle(
                                          //             color: CustomerScreen_Color
                                          //                 .Colors_Text1_,
                                          //             fontWeight: FontWeight.bold,
                                          //             fontFamily:
                                          //                 FontWeight_.Fonts_T),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'วันที่',
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
                                              'เวลา',
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
                                              'ไอพี(ip)',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     child: const Center(
                                          //       child: Text(
                                          //         'uid',
                                          //         style: TextStyle(
                                          //             color: CustomerScreen_Color
                                          //                 .Colors_Text1_,
                                          //             fontWeight: FontWeight.bold,
                                          //             fontFamily:
                                          //                 FontWeight_.Fonts_T),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ผู้ใช้',
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
                                              'เมนู',
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
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        // height: (Responsive.isDesktop(context))
                                        //     ? MediaQuery.of(context).size.width * 0.255
                                        //     : MediaQuery.of(context).size.height * 0.45,
                                        child: ListView.builder(
                                      itemCount: syslogModel_Mon.length,
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
                                              setState(() {
                                                show_more = index;
                                              });
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(children: [
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Container(
                                                //     child: Center(
                                                //       child: Text(
                                                //         '${syslogModel[index].atype}',
                                                //         style: const TextStyle(
                                                //             color:
                                                //                 CustomerScreen_Color
                                                //                     .Colors_Text2_,
                                                //             // fontWeight: FontWeight.bold,
                                                //             fontFamily:
                                                //                 Font_.Fonts_T),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${syslogModel_Mon[index].datex}',
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
                                                    '${syslogModel_Mon[index].timex}',
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
                                                    '${syslogModel_Mon[index].ip}',
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
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Container(
                                                //     child: Center(
                                                //       child: Text(
                                                //         '${syslogModel[index].uid}',
                                                //         style: const TextStyle(
                                                //             color:
                                                //                 CustomerScreen_Color
                                                //                     .Colors_Text2_,
                                                //             // fontWeight: FontWeight.bold,
                                                //             fontFamily:
                                                //                 Font_.Fonts_T),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${syslogModel_Mon[index].username}',
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
                                                    '${syslogModel_Mon[index].frm}',
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
                                                    '${syslogModel_Mon[index].fdo}',
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
                    if (syslogModel_Mon.length != 0)
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
                              Value_Report = 'รายงานประวัติการใช้งานรายเดือน';
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
                            syslogModel_Mon.clear();
                            // Value_selectDate_syslog_Mon = null;
                            YE_syslog_Mon = null;
                            Mon_syslog_Mon = null;
                            Value_Chang_Menu_LogSytem_Mon = null;
                            Value_Chang_Menu_LogSytem_Ser_Mon = null;
                            Await_Status_Report5 = null;
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

///////////////////////////----------------------------------------------->(รายงานประวัติการใช้งานรายวัน)
  RE_SytemLog_Widget() {
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
                (Value_Chang_Menu_LogSytem == null)
                    ? 'รายงานประวัติการใช้งานรายวัน (กรุณาเลือกเมนู)'
                    : 'รายงานประวัติการใช้งานรายวัน (เมนู : $Value_Chang_Menu_LogSytem) ',
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
                        'วันที่: ${Value_selectDate_syslog}',
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
                        'ทั้งหมด: ${syslogModel.length}',
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
                              : (syslogModel.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (syslogModel.length == 0)
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
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     child: const Center(
                                          //       child: Text(
                                          //         'atype',
                                          //         style: TextStyle(
                                          //             color: CustomerScreen_Color
                                          //                 .Colors_Text1_,
                                          //             fontWeight: FontWeight.bold,
                                          //             fontFamily:
                                          //                 FontWeight_.Fonts_T),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'วันที่',
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
                                              'เวลา',
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
                                              'ไอพี(ip)',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: CustomerScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     child: const Center(
                                          //       child: Text(
                                          //         'uid',
                                          //         style: TextStyle(
                                          //             color: CustomerScreen_Color
                                          //                 .Colors_Text1_,
                                          //             fontWeight: FontWeight.bold,
                                          //             fontFamily:
                                          //                 FontWeight_.Fonts_T),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'ผู้ใช้',
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
                                              'เมนู',
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
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        // height: (Responsive.isDesktop(context))
                                        //     ? MediaQuery.of(context).size.width * 0.255
                                        //     : MediaQuery.of(context).size.height * 0.45,
                                        child: ListView.builder(
                                      itemCount: syslogModel.length,
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
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Container(
                                                //     child: Center(
                                                //       child: Text(
                                                //         '${syslogModel[index].atype}',
                                                //         style: const TextStyle(
                                                //             color:
                                                //                 CustomerScreen_Color
                                                //                     .Colors_Text2_,
                                                //             // fontWeight: FontWeight.bold,
                                                //             fontFamily:
                                                //                 Font_.Fonts_T),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '${syslogModel[index].datex}',
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
                                                    '${syslogModel[index].timex}',
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
                                                    '${syslogModel[index].ip}',
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
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: Container(
                                                //     child: Center(
                                                //       child: Text(
                                                //         '${syslogModel[index].uid}',
                                                //         style: const TextStyle(
                                                //             color:
                                                //                 CustomerScreen_Color
                                                //                     .Colors_Text2_,
                                                //             // fontWeight: FontWeight.bold,
                                                //             fontFamily:
                                                //                 Font_.Fonts_T),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${syslogModel[index].username}',
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
                                                    '${syslogModel[index].frm}',
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
                                                    '${syslogModel[index].fdo}',
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
                    if (syslogModel.length != 0)
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
                              Value_Report = 'รายงานประวัติการใช้งานรายวัน';
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
                            syslogModel.clear();
                            Value_selectDate_syslog = null;
                            Value_Chang_Menu_LogSytem = null;
                            Value_Chang_Menu_LogSytem_Ser = null;
                            Await_Status_Report6 = null;
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

///////////////////////////----------------------------------------------->(รายงานทะเบียนลูกค้า)
  RE_Custo_Widget() {
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
                  (Status_Type_cus == null)
                      ? 'รายงานทะเบียนลูกค้า (กรุณาเลือกประเภท)'
                      : 'รายงานทะเบียนลูกค้า ($Status_Type_cus)',
                  style: TextStyle(
                    color: ReportScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                )),
                const SizedBox(height: 1),
                const Divider(),
                const SizedBox(height: 1),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _searchBar_cust(),
                      ),
                    ],
                  ),
                ),
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
                                : (customerModels.length == 0)
                                    ? MediaQuery.of(context).size.width
                                    : 800,
                            // height:
                            //     MediaQuery.of(context)
                            //             .size
                            //             .height *
                            //         0.3,
                            child: (customerModels.length == 0)
                                ? const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'ไม่พบข้อมูล',
                                          style: TextStyle(
                                            color: ReportScreen_Color
                                                .Colors_Text1_,
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
                                          color: AppbackgroundColor
                                              .TiTile_Colors.withOpacity(0.7),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
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
                                                '...',
                                                textAlign: TextAlign.start,
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
                                                'รหัสสมาชิก',
                                                textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Text(
                                                'ชื่อร้าน',
                                                textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Text(
                                                'ชื่อผู้เช่า/บริษัท',
                                                textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Text(
                                                'เบอร์ติดต่อ',
                                                textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Text(
                                                'อีเมล',
                                                textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Text(
                                                'Tax',
                                                textAlign: TextAlign.start,
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
                                              flex: 2,
                                              child: Text(
                                                'ประเภท',
                                                textAlign: TextAlign.start,
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
                                      Expanded(
                                          // height: MediaQuery.of(context).size.height *
                                          //     0.45,
                                          child: ListView.builder(
                                        itemCount: customerModels.length,
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                                          textAlign:
                                                              TextAlign.start,
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
                                                          (customerModels[index]
                                                                          .custno ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .custno ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].custno}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                                                        flex: 2,
                                                        child: Text(
                                                          (customerModels[index]
                                                                          .scname ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .scname ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].scname}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                                                        flex: 2,
                                                        child: Text(
                                                          (customerModels[index]
                                                                          .cname ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .cname ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].cname}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                                                        flex: 2,
                                                        child: Text(
                                                          (customerModels[index]
                                                                          .tel ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .tel ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].tel}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                                                        flex: 2,
                                                        child: Text(
                                                          (customerModels[index]
                                                                          .email ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .email ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].email}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                                                        flex: 2,
                                                        child: Text(
                                                          (customerModels[index]
                                                                          .tax ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .tax ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].tax}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                                                        flex: 2,
                                                        child: Text(
                                                          (customerModels[index]
                                                                          .type ==
                                                                      null ||
                                                                  customerModels[
                                                                              index]
                                                                          .type ==
                                                                      '')
                                                              ? '-'
                                                              : '${customerModels[index].type}',
                                                          // '${TransReBillModels[index1].length}',
                                                          textAlign:
                                                              TextAlign.start,
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
                  padding: const EdgeInsets.fromLTRB(8, 0, 20, 4),
                  child: Column(
                    children: [
                      const SizedBox(height: 1),
                      const Divider(),
                      const SizedBox(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (customerModels.length != 0)
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
                                                bottomRight:
                                                    Radius.circular(10)),
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
                                            Value_Report =
                                                'รายงานทะเบียนลูกค้า';
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
                                      onTap: () {
                                        setState(() {
                                          Status_Type_cus = null;
                                          customerModels.clear();
                                          _customerModels.clear();
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
                      ),
                    ],
                  ))
            ]);
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
        if (Value_Report == 'รายงานข้อมูลพื้นที่เช่า') {
          Excgen_ChaoAreaReport.exportExcel_ChaoAreaReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              areaModels,
              Value_Chang_Zone_Area,
              Status_Area);
        } else if (Value_Report == 'รายงานประวัติการใช้งานรายเดือน') {
          Excgen_SystemLogReport.exportExcel_SystemLogReport(
              '0',
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              Value_Chang_Menu_LogSytem_Mon,
              '$Mon_syslog_Mon ($YE_syslog_Mon)',
              syslogModel_Mon);
        } else if (Value_Report == 'รายงานประวัติการใช้งานรายวัน') {
          Excgen_SystemLogReport.exportExcel_SystemLogReport(
              '1',
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              Value_Chang_Menu_LogSytem,
              Value_selectDate_syslog,
              syslogModel);
        } else if (Value_Report == 'รายงานทะเบียนลูกค้า') {
          Excgen_CustReport.exportExcel_CustReport(
              context, renTal_name, customerModels, Status_Type_cus);
        }
        Navigator.of(context).pop();
      }
    }
  }

  ///------------------------------------------------->
}
