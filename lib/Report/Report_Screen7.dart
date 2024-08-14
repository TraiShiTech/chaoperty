import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
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
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetCustomer_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTranBill_model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Responsive/responsive.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'Excel_ChaoArea_Report.dart';
import 'Excel_Cust_Report.dart';
import 'Excel_History_debt_Edit_Report.dart';
import 'Excel_maintenance_Report.dart';

class ReportScreen7 extends StatefulWidget {
  const ReportScreen7({super.key});

  @override
  State<ReportScreen7> createState() => _ReportScreen7State();
}

class _ReportScreen7State extends State<ReportScreen7> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
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
  List<TypeModel> typeModels = [];
  List<AreaModel> areaModels = [];
  List<AreaModel> _areaModels = <AreaModel>[];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  // late List<List<QuotxSelectModel>> quotxSelectModels;
  late List<List<TransBillModel>> _TransBillModels;

  List<TransBillModel> TransBillModels_Select = [];
  List<String> YE_Th = [];
  List<String> Mont_Th = [];

  String? Mon_maintenance_Mon;
  String? YE_maintenance_Mon;

  String? Mon_History_debt_Mon;
  String? YE_History_debt_Mon;
  String? zone_ser_History_debt,
      zone_name_History_debt,
      Value_Chang_Zone_People_History_debt,
      Value_Chang_Zone_People_Ser_History_debt,
      Status_pe_History_debt,
      Status_pe_ser_History_debt;
  String? renTal_user, renTal_name;

  String? zone_ser_maintenance,
      zone_name_maintenance,
      Status_maintenance_,
      Status_maintenance_ser;

  String? Status_Type_cus, Status_Type_cus_ser;
  String? Status_pe, Status_pe_ser, Status_Area_ser, Status_Area;

  String? Value_Chang_Zone_Area, Value_Chang_Zone_Area_Ser;
  List<CustomerModel> customerModels = [];
  List<CustomerModel> _customerModels = <CustomerModel>[];

  ///------------------------>
  List Status_Area_ = [
    'ทั้งหมด',
    'ใกล้หมดสัญญา',
    'เสนอราคา',
    'ว่าง',
    'เช่าอยู่',
  ];
  List maintenance_Status = [
    'ทั้งหมด',
    'รอดำเนินการ',
    'เสร็จสิ้น',
  ];
  List Status = [
    'ปัจจุบัน',
    'หมดสัญญา',
    'ผู้สนใจ',
  ];

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
    read_GC_zone();
    read_GC_type();
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

  //////////------------------------------------------------------->(รายงาน ข้อมูลพื้นที่เช่า)
  // Future<Null> read_GC_area() async {
  //   if (areaModels.length != 0) {
  //     setState(() {
  //       areaModels.clear();
  //     });
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var ren = preferences.getString('renTalSer');
  //   var zone = Value_Chang_Zone_Area_Ser;

  //   print('zone >>>>>> $zone');

  //   String url = (zone == '0')
  //       ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
  //       : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         AreaModel areaModel = AreaModel.fromJson(map);

  //         setState(() {
  //           areaModels.add(areaModel);
  //         });
  //       }
  //     } else {}

  //     print('zoneModels >>. ${zoneModels.length}');
  //   } catch (e) {}
  // }

  Future<Null> read_GC_areaSelect() async {
    if (areaModels.length != 0) {
      areaModels.clear();
      _areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = Value_Chang_Zone_Area_Ser;

    // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $Status_Area_ser');

    if (Status_Area_ser == '1') {
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
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    } else if (Status_Area_ser == '2') {
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

              // print('difference == $difference');

              if (difference < 30 && difference > 0) {
                setState(() {
                  areaModels.add(areaModel);
                });
              }
            }
          }
        } else {}
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    } else if (Status_Area_ser == '3') {
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
            if (areaModel.quantity == '2' || areaModel.quantity == '3') {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    } else if (Status_Area_ser == '4') {
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
            if (areaModel.quantity == null) {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    } else if (Status_Area_ser == '5') {
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
            if (int.parse(areaModel.quantity!) == 1) {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    } else if (Status_Area_ser == '6') {
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
            if (areaModel.quantity != '1') {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    } else if (Status_Area_ser == '7') {
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
            if (areaModel.quantity == '1' || areaModel.quantity == null) {
              setState(() {
                areaModels.add(areaModel);
              });
            }
          }
        } else {}
        setState(() {
          _areaModels = areaModels;
        });
      } catch (e) {}
    }
    setState(() {
      Await_Status_Report1 = 1;
    });
  }

  _searchBar_ChoArea() {
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
                areaModels = _areaModels.where((areaModel) {
                  var notTitle = areaModel.cname.toString().toLowerCase();
                  var notTitle2 = areaModel.docno.toString().toLowerCase();
                  var notTitle3 = areaModel.lncode.toString().toLowerCase();
                  var notTitle4 = areaModel.zn.toString().toLowerCase();
                  var notTitle5 = areaModel.ln_q.toString().toLowerCase();
                  var notTitle6 = areaModel.cid.toString().toLowerCase();
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
    setState(() {
      Await_Status_Report2 = 1;
    });
  }

  _searchBar_c_maintenance() {
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
              // print(text);_teNantModels

              // print(customerModels.map((e) => e.docno));
              // print(_customerModels.map((e) => e.docno));

              setState(() {
                maintenanceModels =
                    _maintenanceModels.where((maintenanceModel) {
                  var notTitle = maintenanceModel.zn.toString().toLowerCase();
                  var notTitle2 = maintenanceModel.ln.toString().toLowerCase();
                  var notTitle3 =
                      maintenanceModel.lncode.toString().toLowerCase();
                  var notTitle4 =
                      maintenanceModel.sname.toString().toLowerCase();
                  var notTitle5 =
                      maintenanceModel.mdate.toString().toLowerCase();
                  var notTitle6 =
                      maintenanceModel.rdescr.toString().toLowerCase();
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
      // print(result);
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
    setState(() {
      Await_Status_Report3 = 1;
    });
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

////////////----------------------------------------------------->(รายงาน ข้อมูลผู้เช่า)

  Future<Null> read_GC_tenantSelect() async {
    if (teNantModels.isNotEmpty) {
      setState(() {
        teNantModels.clear();
        _teNantModels.clear();
        _TransBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = Value_Chang_Zone_People_Ser_History_debt;

    // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $Status_pe_ser_History_debt');

    if (Status_pe_ser_History_debt == '1') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_tenantAll_History_debt.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_tenant_History_debt.php?isAdd=true&ren=$ren&zone=$zone';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            if (teNantModel.quantity == '1') {
              var daterx = teNantModel.ldate == null
                  ? teNantModel.ldate_q
                  : teNantModel.ldate;

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

                // print('difference == $difference');

                var daterx_now = DateTime.now();

                var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

                final now = DateTime.now();
                final earlier = daterx_ldate.subtract(const Duration(days: 0));
                var daterx_A = now.isAfter(earlier);
                // print(now.isAfter(earlier)); // true
                // print(now.isBefore(earlier)); // true

                if (daterx_A != true) {
                  setState(() {
                    teNantModels.add(teNantModel);
                  });
                }
              }
            }
          }
        } else {}

        setState(() {
          _teNantModels = teNantModels;
        });
      } catch (e) {}
    } else if (Status_pe_ser_History_debt == '2') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_tenantAll_History_debt.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_tenant_History_debt.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            var daterx = teNantModel.ldate == null
                ? teNantModel.ldate_q
                : teNantModel.ldate;

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

              // print('difference == $difference');

              var daterx_now = DateTime.now();

              var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

              final now = DateTime.now();
              final earlier = daterx_ldate.subtract(const Duration(days: 0));
              var daterx_A = now.isAfter(earlier);
              // print(now.isAfter(earlier)); // true
              // print(now.isBefore(earlier)); // true

              if (daterx_A == true) {
                setState(() {
                  if (teNantModel.quantity == '1') {
                    teNantModels.add(teNantModel);
                  }
                });
              }
            }
          }
        } else {}
        setState(() {
          _teNantModels = teNantModels;
        });
      } catch (e) {}
    } else if (Status_pe_ser_History_debt == '3') {
      String url = (zone == '0')
          ? '${MyConstant().domain}/GC_tenantAll_History_debt.php?isAdd=true&ren=$ren&zone=$zone'
          : '${MyConstant().domain}/GC_tenant_History_debt.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            if (teNantModel.quantity == '2' || teNantModel.quantity == '3') {
              setState(() {
                teNantModels.add(teNantModel);
              });
            }
          }
        } else {}
        setState(() {
          _teNantModels = teNantModels;
        });
      } catch (e) {}
    }

    // quotxSelectModels = List.generate(teNantModels.length, (_) => []);

    _TransBillModels = List.generate(teNantModels.length, (_) => []);
    red_report();
  }

  //////////----------------------------------------->(รายละเอียดค่าบริการ)
  Future<Null> red_report() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    for (int index = 0; index < teNantModels.length; index++) {
      var ciddoc = teNantModels[index].docno == null
          ? teNantModels[index].cid == null
              ? ''
              : '${teNantModels[index].cid}'
          : '${teNantModels[index].docno}';
      var qutser = teNantModels[index].quantity;
      String url =
          '${MyConstant().domain}/GC_tran_bill_History_debt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
      // String url =
      //     '${MyConstant().domain}/GC_quot_conx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        // print(result);
        if (result != null) {
          for (var map in result) {
            TransBillModel _TransBillModel = TransBillModel.fromJson(map);
            setState(() {
              _TransBillModels[index].add(_TransBillModel);
            });
          }
        } else {}
        // quotxSelectModels[index].sort((a, b) => a.expser!.compareTo(b.expser!));
      } catch (e) {}
    }
    setState(() {
      Await_Status_Report4 = 1;
    });
  }

  Future<Null> red_report_Select(index) async {
    setState(() {
      TransBillModels_Select.clear();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = teNantModels[index].docno == null
        ? teNantModels[index].cid == null
            ? ''
            : '${teNantModels[index].cid}'
        : '${teNantModels[index].docno}';
    var qutser = teNantModels[index].quantity;
    String url =
        '${MyConstant().domain}/GC_tran_bill_History_debt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser}';
    // String url =
    //     '${MyConstant().domain}/GC_quot_conx.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TransBillModel _TransBillModel = TransBillModel.fromJson(map);
          setState(() {
            TransBillModels_Select.add(_TransBillModel);
          });
        }
      } else {}
      // quotxSelectModels[index].sort((a, b) => a.expser!.compareTo(b.expser!));
    } catch (e) {}
  }

  _searchBar_tenantSelect() {
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
              // print(text);_teNantModels

              // print(customerModels.map((e) => e.docno));
              // print(_customerModels.map((e) => e.docno));

              setState(() {
                teNantModels = _teNantModels.where((teNantModel) {
                  var notTitle = teNantModel.cid.toString().toLowerCase();
                  var notTitle2 = teNantModel.cname.toString().toLowerCase();
                  var notTitle3 = teNantModel.cname_q.toString().toLowerCase();
                  var notTitle4 = teNantModel.sname.toString().toLowerCase();
                  var notTitle5 = teNantModel.ln_c.toString().toLowerCase();
                  var notTitle6 = teNantModel.area_c.toString().toLowerCase();
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

////------------------------------------------------------------------->
  Dia_log() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Timer(Duration(milliseconds: 3600), () {
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'สถานะ :',
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
                              // print(selectedIndex);
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
                              // print(
                              //     'Selected Index: $Value_Chang_Zone_Area  //${Value_Chang_Zone_Area_Ser}');
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
                        ),
                        onTap: (Value_Chang_Zone_Area_Ser == null ||
                                Status_Area == null ||
                                areaModels.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานข้อมูลพื้นที่เช่า');
                                RE_ChoArea_Widget();
                              }),
                    (areaModels.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                (Value_Chang_Zone_Area_Ser != null &&
                                        areaModels.isEmpty &&
                                        Status_Area != null &&
                                        Await_Status_Report1 != null)
                                    ? 'รายงาน ข้อมูลพื้นที่เช่า (ไม่พบข้อมูล ✖️)'
                                    : 'รายงาน ข้อมูลพื้นที่เช่า',
                                ReportScreen_Color.Colors_Text2_,
                                TextAlign.center,
                                FontWeight.w500,
                                Font_.Fonts_T,
                                16,
                                1),
                          )
                        : Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                'รายงาน ข้อมูลพื้นที่เช่า ✔️',
                                ReportScreen_Color.Colors_Text2_,
                                TextAlign.center,
                                FontWeight.w500,
                                Font_.Fonts_T,
                                16,
                                1),
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'เดือน :',
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'ปี :',
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'สถานะ :',
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
                              // print(Status_maintenance_ser);
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
                              // print(
                              //     'Selected Index: $zone_name_maintenance  //${zone_ser_maintenance}');
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
                                Await_Status_Report2 = 0;
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
                        ),
                        onTap: (Status_maintenance_ == null ||
                                zone_name_maintenance == null ||
                                maintenanceModels.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานการแจ้งซ่อม');
                                RE_maintenance_Widget();
                              }),
                    (maintenanceModels.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                (Status_maintenance_ != null &&
                                        maintenanceModels.isEmpty &&
                                        zone_name_maintenance != null &&
                                        Await_Status_Report2 != null)
                                    ? 'รายงานรายงานการแจ้งซ่อม (ไม่พบข้อมูล ✖️)'
                                    : 'รายงานรายงานการแจ้งซ่อม',
                                ReportScreen_Color.Colors_Text2_,
                                TextAlign.center,
                                FontWeight.w500,
                                Font_.Fonts_T,
                                16,
                                1),
                          )
                        : Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Translate.TranslateAndSetText(
                                'รายงานรายงานการแจ้งซ่อม ✔️',
                                ReportScreen_Color.Colors_Text2_,
                                TextAlign.center,
                                FontWeight.w500,
                                Font_.Fonts_T,
                                16,
                                1),
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Translate.TranslateAndSetText(
                            'ประเภท :',
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
                                      child: Translate.TranslateAndSetText(
                                          '${item.type}',
                                          Colors.grey,
                                          TextAlign.center,
                                          FontWeight.w500,
                                          Font_.Fonts_T,
                                          16,
                                          1),
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
                              // print(Status_Type_cus_ser);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              Await_Status_Report3 = 0;
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
                      ),
                      onTap: (customerModels.isEmpty)
                          ? null
                          : () {
                              Insert_log.Insert_logs(
                                  'รายงาน', 'กดดูรายงานทะเบียนลูกค้า');
                              RE_Custo_Widget();
                            },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Translate.TranslateAndSetText(
                          (customerModels.isNotEmpty)
                              ? 'รายงานทะเบียนลูกค้า ✔️'
                              : 'รายงานทะเบียนลูกค้า',
                          ReportScreen_Color.Colors_Text1_,
                          TextAlign.center,
                          FontWeight.w500,
                          Font_.Fonts_T,
                          16,
                          1),
                    ),
                  ],
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
                            'ผู้เช่า :',
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
                          width: 150,
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            value: Status_pe_History_debt,

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
                            // hint: StreamBuilder(
                            //     stream: Stream.periodic(const Duration(seconds: 1)),
                            //     builder: (context, snapshot) {
                            //       return Text(
                            //         Status_pe == null ? 'เลือก' : '$Status_pe',
                            //         maxLines: 2,
                            //         textAlign: TextAlign.center,
                            //         style: const TextStyle(
                            //           overflow: TextOverflow.ellipsis,
                            //           fontSize: 14,
                            //           color: Colors.grey,
                            //         ),
                            //       );
                            //     }),
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
                            items:
                                Status.map((item) => DropdownMenuItem<String>(
                                      value: '${item}',
                                      child: Translate.TranslateAndSetText(
                                          '${item}',
                                          Colors.grey,
                                          TextAlign.center,
                                          FontWeight.w500,
                                          Font_.Fonts_T,
                                          16,
                                          1),
                                    )).toList(),

                            onChanged: (value) async {
                              int selectedIndex =
                                  Status.indexWhere((item) => item == value);
                              setState(() {
                                Status_pe_History_debt = Status[selectedIndex]!;
                                Status_pe_ser_History_debt =
                                    '${selectedIndex + 1}';
                              });
                              // print(selectedIndex);
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
                            value: Value_Chang_Zone_People_History_debt,
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
                                Value_Chang_Zone_People_History_debt = value!;
                                Value_Chang_Zone_People_Ser_History_debt =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              // print(
                              //     'Selected Index: $Value_Chang_Zone_People_History_debt  //${Value_Chang_Zone_People_Ser_History_debt}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Status_pe_History_debt != null &&
                                Value_Chang_Zone_People_History_debt != null) {
                              setState(() {
                                Await_Status_Report4 = 0;
                              });
                              Dia_log();
                              read_GC_tenantSelect();
                            }

                            // read_GC_tenant();
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
                child: ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                          ),
                          onTap: (teNantModels.isEmpty)
                              ? null
                              : () {
                                  Insert_log.Insert_logs('รายงาน',
                                      'กดดูประวัติการเปลี่ยนแปลงตั้งหนี้');
                                  RE_History_of_debt_Edit_Widget()();
                                },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Translate.TranslateAndSetText(
                              (teNantModels.isNotEmpty)
                                  ? 'รายงานประวัติการเปลี่ยนแปลงตั้งหนี้ ✔️'
                                  : 'รายงานประวัติการเปลี่ยนแปลงตั้งหนี้',
                              ReportScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.w500,
                              Font_.Fonts_T,
                              16,
                              1),
                        ),
                      ],
                    ),
                  ),
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
              Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: _searchBar_ChoArea()),
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
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Row(
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
              Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: _searchBar_c_maintenance()),
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

///////////////////////////----------------------------------------------->(รายงานประวัติการเปลี่ยนแปลงตั้งหนี้)
  RE_History_of_debt_Edit_Widget() {
    int? ser_index;
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
                (Value_Chang_Zone_People_History_debt == null)
                    ? 'รายงานประวัติการเปลี่ยนแปลงตั้งหนี้ (กรุณาเลือกโซน)'
                    : 'รายงานประวัติการเปลี่ยนแปลงตั้งหนี้ (โซน : $Value_Chang_Zone_People_History_debt) ',
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
                        'ผู้เช่า: ${Status_pe_History_debt}',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _searchBar_tenantSelect(),
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
                              : (teNantModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
                          // height:
                          //     MediaQuery.of(context)
                          //             .size
                          //             .height *
                          //         0.3,
                          child: (teNantModels.length == 0)
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
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'เลขที่สัญญา/เสนอราคา',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'ชื่อผู้ติดต่อ',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'ชื่อร้านค้า',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'โซนพื้นที่',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'รหัสพื้นที่',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'ขนาดพื้นที่(ต.ร.ม.)',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'ระยะเวลาการเช่า',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'วันเริ่มสัญญา',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'วันสิ้นสุดสัญญา',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: const Text(
                                              'สถานะ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '...',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return (ser_index != index)
                                            ? ListTile(
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Tooltip(
                                                          richMessage: TextSpan(
                                                            text: teNantModels[
                                                                            index]
                                                                        .docno ==
                                                                    null
                                                                ? teNantModels[index]
                                                                            .cid ==
                                                                        null
                                                                    ? ''
                                                                    : '${teNantModels[index].cid}'
                                                                : '${teNantModels[index].docno}',
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                .grey[200],
                                                          ),
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 25,
                                                            maxLines: 1,
                                                            teNantModels[index]
                                                                        .docno ==
                                                                    null
                                                                ? teNantModels[index]
                                                                            .cid ==
                                                                        null
                                                                    ? ''
                                                                    : '${teNantModels[index].cid}'
                                                                : '${teNantModels[index].docno}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          teNantModels[index]
                                                                      .cname ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .cname_q ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].cname_q}'
                                                              : '${teNantModels[index].cname}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Tooltip(
                                                          richMessage: TextSpan(
                                                            text: teNantModels[
                                                                            index]
                                                                        .sname ==
                                                                    null
                                                                ? teNantModels[index]
                                                                            .sname_q ==
                                                                        null
                                                                    ? ''
                                                                    : '${teNantModels[index].sname_q}'
                                                                : '${teNantModels[index].sname}',
                                                            style:
                                                                const TextStyle(
                                                              color: HomeScreen_Color
                                                                  .Colors_Text1_,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors
                                                                .grey[200],
                                                          ),
                                                          child: AutoSizeText(
                                                            minFontSize: 10,
                                                            maxFontSize: 25,
                                                            maxLines: 1,
                                                            teNantModels[index]
                                                                        .sname ==
                                                                    null
                                                                ? teNantModels[index]
                                                                            .sname_q ==
                                                                        null
                                                                    ? ''
                                                                    : '${teNantModels[index].sname_q}'
                                                                : '${teNantModels[index].sname}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '${teNantModels[index].zn}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Tooltip(
                                                        richMessage: TextSpan(
                                                          text: teNantModels[
                                                                          index]
                                                                      .ln_c ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .ln_q ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].ln_q}'
                                                              : '${teNantModels[index].ln_c}',
                                                          style:
                                                              const TextStyle(
                                                            color: HomeScreen_Color
                                                                .Colors_Text1_,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T,
                                                            //fontSize: 10.0
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color:
                                                              Colors.grey[200],
                                                        ),
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          teNantModels[index]
                                                                      .ln_c ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .ln_q ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].ln_q}'
                                                              : '${teNantModels[index].ln_c}',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        teNantModels[index]
                                                                    .area_c ==
                                                                null
                                                            ? teNantModels[index]
                                                                        .area_q ==
                                                                    null
                                                                ? ''
                                                                : '${teNantModels[index].area_q}'
                                                            : '${teNantModels[index].area_c}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        teNantModels[index]
                                                                    .period ==
                                                                null
                                                            ? teNantModels[index]
                                                                        .period_q ==
                                                                    null
                                                                ? ''
                                                                : '${teNantModels[index].period_q}  ${teNantModels[index].rtname_q!.substring(3)}'
                                                            : '${teNantModels[index].period}  ${teNantModels[index].rtname!.substring(3)}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          teNantModels[index]
                                                                      .sdate_q ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .sdate ==
                                                                      null
                                                                  ? ''
                                                                  : DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(DateTime
                                                                          .parse(
                                                                              '${teNantModels[index].sdate} 00:00:00'))
                                                                      .toString()
                                                              : DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .parse(
                                                                          '${teNantModels[index].sdate_q} 00:00:00'))
                                                                  .toString(),
                                                          textAlign:
                                                              TextAlign.end,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 25,
                                                          maxLines: 1,
                                                          teNantModels[index]
                                                                      .ldate_q ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .ldate ==
                                                                      null
                                                                  ? ''
                                                                  : DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(DateTime
                                                                          .parse(
                                                                              '${teNantModels[index].ldate} 00:00:00'))
                                                                      .toString()
                                                              : DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .parse(
                                                                          '${teNantModels[index].ldate_q} 00:00:00'))
                                                                  .toString(),
                                                          textAlign:
                                                              TextAlign.end,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        teNantModels[index]
                                                                    .quantity ==
                                                                '1'
                                                            ? datex.isAfter(DateTime.parse(
                                                                            '${teNantModels[index].ldate} 00:00:00.000')
                                                                        .subtract(const Duration(
                                                                            days:
                                                                                0))) ==
                                                                    true
                                                                ? 'หมดสัญญา'
                                                                : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(
                                                                            days:
                                                                                30))) ==
                                                                        true
                                                                    ? 'ใกล้หมดสัญญา'
                                                                    : 'เช่าอยู่'
                                                            : teNantModels[index]
                                                                        .quantity ==
                                                                    '2'
                                                                ? 'เสนอราคา'
                                                                : teNantModels[index]
                                                                            .quantity ==
                                                                        '3'
                                                                    ? 'เสนอราคา(มัดจำ)'
                                                                    : 'ว่าง',
                                                        textAlign:
                                                            TextAlign.end,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: teNantModels[
                                                                            index]
                                                                        .quantity ==
                                                                    '1'
                                                                ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                        true
                                                                    ? Colors.red
                                                                    : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                            true
                                                                        ? Colors
                                                                            .orange
                                                                            .shade900
                                                                        : Colors
                                                                            .black
                                                                : teNantModels[index]
                                                                            .quantity ==
                                                                        '2'
                                                                    ? Colors
                                                                        .blue
                                                                    : teNantModels[index]
                                                                                .quantity ==
                                                                            '3'
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .green,
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft:
                                                                      Radius.circular(
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
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Center(
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                'เพิ่มเติม',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style:
                                                                    TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            setState(() {
                                                              ser_index = index;
                                                            });
                                                            red_report_Select(
                                                                index);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              )
                                            : Container(
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.green[100],
                                                          border: const Border(
                                                            bottom: BorderSide(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Row(children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text: teNantModels[index]
                                                                              .docno ==
                                                                          null
                                                                      ? teNantModels[index].cid ==
                                                                              null
                                                                          ? ''
                                                                          : '${teNantModels[index].cid}'
                                                                      : '${teNantModels[index].docno}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  teNantModels[index]
                                                                              .docno ==
                                                                          null
                                                                      ? teNantModels[index].cid ==
                                                                              null
                                                                          ? ''
                                                                          : '${teNantModels[index].cid}'
                                                                      : '${teNantModels[index].docno}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .cname ==
                                                                        null
                                                                    ? teNantModels[index].cname_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].cname_q}'
                                                                    : '${teNantModels[index].cname}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text: teNantModels[index]
                                                                              .sname ==
                                                                          null
                                                                      ? teNantModels[index].sname_q ==
                                                                              null
                                                                          ? ''
                                                                          : '${teNantModels[index].sname_q}'
                                                                      : '${teNantModels[index].sname}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  teNantModels[index]
                                                                              .sname ==
                                                                          null
                                                                      ? teNantModels[index].sname_q ==
                                                                              null
                                                                          ? ''
                                                                          : '${teNantModels[index].sname_q}'
                                                                      : '${teNantModels[index].sname}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              '${teNantModels[index].zn}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Tooltip(
                                                              richMessage:
                                                                  TextSpan(
                                                                text: teNantModels[index]
                                                                            .ln_c ==
                                                                        null
                                                                    ? teNantModels[index].ln_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].ln_q}'
                                                                    : '${teNantModels[index].ln_c}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: HomeScreen_Color
                                                                      .Colors_Text1_,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      FontWeight_
                                                                          .Fonts_T,
                                                                  //fontSize: 10.0
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .grey[200],
                                                              ),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .ln_c ==
                                                                        null
                                                                    ? teNantModels[index].ln_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].ln_q}'
                                                                    : '${teNantModels[index].ln_c}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
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
                                                              teNantModels[index]
                                                                          .area_c ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .area_q ==
                                                                          null
                                                                      ? ''
                                                                      : '${teNantModels[index].area_q}'
                                                                  : '${teNantModels[index].area_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 25,
                                                              maxLines: 1,
                                                              teNantModels[index]
                                                                          .period ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .period_q ==
                                                                          null
                                                                      ? ''
                                                                      : '${teNantModels[index].period_q}  ${teNantModels[index].rtname_q!.substring(3)}'
                                                                  : '${teNantModels[index].period}  ${teNantModels[index].rtname!.substring(3)}',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .sdate_q ==
                                                                        null
                                                                    ? teNantModels[index].sdate ==
                                                                            null
                                                                        ? ''
                                                                        : DateFormat('dd-MM-yyyy')
                                                                            .format(DateTime.parse(
                                                                                '${teNantModels[index].sdate} 00:00:00'))
                                                                            .toString()
                                                                    : DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            DateTime.parse('${teNantModels[index].sdate_q} 00:00:00'))
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                teNantModels[index]
                                                                            .ldate_q ==
                                                                        null
                                                                    ? teNantModels[index].ldate ==
                                                                            null
                                                                        ? ''
                                                                        : DateFormat('dd-MM-yyyy')
                                                                            .format(DateTime.parse(
                                                                                '${teNantModels[index].ldate} 00:00:00'))
                                                                            .toString()
                                                                    : DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(
                                                                            DateTime.parse('${teNantModels[index].ldate_q} 00:00:00'))
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
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
                                                              teNantModels[index]
                                                                          .quantity ==
                                                                      '1'
                                                                  ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(
                                                                              days:
                                                                                  0))) ==
                                                                          true
                                                                      ? 'หมดสัญญา'
                                                                      : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                              true
                                                                          ? 'ใกล้หมดสัญญา'
                                                                          : 'เช่าอยู่'
                                                                  : teNantModels[index]
                                                                              .quantity ==
                                                                          '2'
                                                                      ? 'เสนอราคา'
                                                                      : teNantModels[index].quantity ==
                                                                              '3'
                                                                          ? 'เสนอราคา(มัดจำ)'
                                                                          : 'ว่าง',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: teNantModels[index]
                                                                              .quantity ==
                                                                          '1'
                                                                      ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 30))) ==
                                                                                  true
                                                                              ? Colors
                                                                                  .orange.shade900
                                                                              : Colors
                                                                                  .black
                                                                      : teNantModels[index].quantity ==
                                                                              '2'
                                                                          ? Colors
                                                                              .blue
                                                                          : teNantModels[index].quantity ==
                                                                                  '3'
                                                                              ? Colors
                                                                                  .blue
                                                                              : Colors
                                                                                  .green,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius: const BorderRadius
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
                                                                            Radius.circular(10)),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Center(
                                                                    child:
                                                                        AutoSizeText(
                                                                      minFontSize:
                                                                          10,
                                                                      maxFontSize:
                                                                          25,
                                                                      maxLines:
                                                                          1,
                                                                      'X',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style:
                                                                          TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            Font_.Fonts_T,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    ser_index =
                                                                        null;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.green[100],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight:
                                                                    Radius
                                                                        .circular(
                                                                            8),
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
                                                              2.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'เลขตั้งหนี้',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'กำหนดชำระ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'รายการ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'VAT',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'VAT %',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'WHT %',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.0),
                                                              child: Text(
                                                                'ยอด',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: TextStyle(
                                                                    color: PeopleChaoScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T
                                                                    //fontSize: 10.0
                                                                    //fontSize: 10.0
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (TransBillModels_Select
                                                            .length ==
                                                        0)
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .green[50],
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
                                                          child: ListTile(
                                                              title: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    'ไม่พบข้อมูล',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ]))),
                                                    for (int index2 = 0;
                                                        index2 <
                                                            TransBillModels_Select
                                                                .length;
                                                        index2++)
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.green[50],
                                                          border: const Border(
                                                            bottom: BorderSide(
                                                              color: Colors
                                                                  .black12,
                                                              width: 1,
                                                            ),
                                                          ),
                                                        ),
                                                        child: ListTile(
                                                            title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text:
                                                                      '${TransBillModels_Select[index2].docno} ',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${TransBillModels_Select[index2].docno}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text:
                                                                      '${DateFormat('dd-MM').format(DateTime.parse('${TransBillModels_Select[index2].date} 00:00:00'))}-${DateTime.parse('${TransBillModels_Select[index2].date} 00:00:00').year + 543}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${DateFormat('dd-MM').format(DateTime.parse('${TransBillModels_Select[index2].date} 00:00:00'))}-${DateTime.parse('${TransBillModels_Select[index2].date} 00:00:00').year + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text: '',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child: (Responsive
                                                                        .isDesktop(
                                                                            context))
                                                                    ? AutoSizeText(
                                                                        minFontSize:
                                                                            10,
                                                                        maxFontSize:
                                                                            25,
                                                                        maxLines:
                                                                            2,
                                                                        TransBillModels_Select[index2].descr ==
                                                                                null
                                                                            ? '${TransBillModels_Select[index2].expname}'
                                                                            : '${TransBillModels_Select[index2].descr}',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: const TextStyle(
                                                                            color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                            //fontWeight: FontWeight.bold,
                                                                            fontFamily: Font_.Fonts_T),
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              AutoSizeText(
                                                                                minFontSize: 6,
                                                                                maxFontSize: 12,
                                                                                maxLines: 2,
                                                                                '${DateFormat('dd-MM').format(DateTime.parse('${TransBillModels_Select[index2].date} 00:00:00'))}-${DateTime.parse('${TransBillModels_Select[index2].date} 00:00:00').year + 543}',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(
                                                                                    color: Colors.grey.shade500,
                                                                                    //fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              AutoSizeText(
                                                                                minFontSize: 10,
                                                                                maxFontSize: 25,
                                                                                maxLines: 2,
                                                                                TransBillModels_Select[index2].descr == null ? '${TransBillModels_Select[index2].expname}' : '${TransBillModels_Select[index2].descr}',
                                                                                textAlign: TextAlign.start,
                                                                                style: const TextStyle(
                                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                    //fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text:
                                                                      '${TransBillModels_Select[index2].vtype}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${TransBillModels_Select[index2].vtype}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text:
                                                                      '${TransBillModels_Select[index2].nvat}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${TransBillModels_Select[index2].nvat}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text:
                                                                      '${TransBillModels_Select[index2].nwht}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${TransBillModels_Select[index2].nwht}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Tooltip(
                                                                richMessage:
                                                                    TextSpan(
                                                                  text:
                                                                      '${TransBillModels_Select[index2].total}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: HomeScreen_Color
                                                                        .Colors_Text1_,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        FontWeight_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${TransBillModels_Select[index2].total}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                      )
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
                              Value_Report =
                                  'รายงานประวัติการเปลี่ยนแปลงตั้งหนี้';
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
                          //Excel_History_debt_Edit_Report
                          setState(() {
                            Value_Chang_Zone_People_Ser_History_debt = null;

                            Value_Chang_Zone_People_History_debt = null;
                            Status_pe = null;
                            Await_Status_Report1 = null;
                            teNantModels.clear();
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
        } else if (Value_Report == 'รายงานรายงานการแจ้งซ่อม') {
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
        } else if (Value_Report == 'รายงานทะเบียนลูกค้า') {
          Excgen_CustReport.exportExcel_CustReport(
              context, renTal_name, customerModels, Status_Type_cus);
        } else if (Value_Report == 'รายงานประวัติการเปลี่ยนแปลงตั้งหนี้') {
          Excgen_History_debt_Edit_Report_Report
              .exportExcel_History_debt_Edit_Report_Report(
                  context,
                  NameFile_,
                  _verticalGroupValue_NameFile,
                  Value_Chang_Zone_People_Ser_History_debt,
                  Value_Chang_Zone_People_History_debt,
                  teNantModels,
                  _TransBillModels);
        }
        Navigator.of(context).pop();
      }
    }
  }

  ///------------------------------------------------->
}
