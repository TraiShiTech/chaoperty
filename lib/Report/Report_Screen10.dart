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
import '../Model/GetC_Quot_Select_Model.dart';
import '../Model/GetExp_Model.dart';
import '../Model/GetPakan_Contractx_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTrans_Kon_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_TenantAll_billpay_Model.dart';
import '../Model/Get_TransReteNantModels.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'Excel_GetPakan_Report.dart';
import 'Excel_PayPakan_Report.dart';
import 'Excel_PeopleChoAllbill_Report.dart';

class ReportScreen10 extends StatefulWidget {
  const ReportScreen10({super.key});

  @override
  State<ReportScreen10> createState() => _ReportScreen10State();
}

class _ReportScreen10State extends State<ReportScreen10> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int? Await_Status_Report1,
      Await_Status_Report2,
      Await_Status_Report3,
      Await_Status_Report4;
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
  DateTime now = DateTime.now();
  String? rtname, type, typex, renname, bill_name, bill_addr, bill_tax;
  String? bill_tel, bill_email, expbill, expbill_name, bill_default;
  String? bill_tser, foder;
  String? name_slip, name_slip_ser, bills_name_;
  String? base64_Slip, fileName_Slip;

  ///------------------------>
  String? Status_pe, Status_pe_ser, YE_Transte_People;
  String? Value_Chang_Zone_People, Value_Chang_Zone_People_Ser;
  String? Value_Chang_Zone_Pakan, Value_Chang_Zone_Pakan_Ser;
  ////////--------------------------------------------->
  List<String> YE_Th = [];
  List<String> Mont_Th = [];
  List<ZoneModel> zoneModels = [];
  List<ZoneModel> zoneModels_report = [];
  List<ExpModel> expModels = [];
  List<PayMentModel> payMentModels = [];
  List<RenTalModel> renTalModels = [];
  ////////--------------------------------------------->

  List<TenantAllbillPayModel> teNantModels = [];
  List<TenantAllbillPayModel> _teNantModels = <TenantAllbillPayModel>[];
  List<TransteNantModels> transteNantModels = [];
  List<TransteNantModels> transteNantModels_Select = [];
  List<ContractxPakanModel> contractxPakanModels = [];
  List<ContractxPakanModel> _contractxPakanModels = <ContractxPakanModel>[];

  List<TransKonModel> transKonModels = [];
  List<TransKonModel> _transKonModels = <TransKonModel>[];
///////----------------------------------->
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
  List<String> monthsAbbreviationInThai = [
    'ม.ค.', // มกราคม (January)
    'ก.พ.', // กุมภาพันธ์ (February)
    'มี.ค.', // มีนาคม (March)
    'เม.ย.', // เมษายน (April)
    'พ.ค.', // พฤษภาคม (May)
    'มิ.ย.', // มิถุนายน (June)
    'ก.ค.', // กรกฎาคม (July)
    'ส.ค.', // สิงหาคม (August)
    'ก.ย.', // กันยายน (September)
    'ต.ค.', // ตุลาคม (October)
    'พ.ย.', // พฤศจิกายน (November)
    'ธ.ค.', // ธันวาคม (December)
  ];

  @override
  void initState() {
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

    print('ren >>>>>> $ren');

    String url =
        '${MyConstant().domain}/GC_Bank_Paytype.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
            // if (bill_defaultx == 'P') {
            //   bills_name_ = 'บิลธรรมดา';
            // } else {
            //   bills_name_ = 'ใบกำกับภาษี';
            // }
          });
        }
      } else {}
    } catch (e) {
      print('Error-Dis(read_GC_rental) : ${e}');
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
        title: const Text(
          '📢ขออภัย !!!! ',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontFamily: Font_.Fonts_T,
          ),
        ),
        content: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/pngegg.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
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
      print(result);
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

////////////------------------------------------------> ////GC_tenantAll_bill_pay_Report
  /////GC_tenantAll_billpaySelect_Report
  ///
  Future<Null> read_tenantAll_billpay() async {
    if (teNantModels.isNotEmpty) {
      setState(() {
        teNantModels.clear();
        _teNantModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = (Value_Chang_Zone_People_Ser == null)
        ? '0'
        : Value_Chang_Zone_People_Ser;

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $Status_pe_ser');

    String url = (zone == '0')
        ? '${MyConstant().domain}/GC_tenantAllbill_Report.php?isAdd=true&ren=$ren&zone=$zone&quan_tity=$Status_pe_ser'
        : '${MyConstant().domain}/GC_tenantAllbill_Report.php?isAdd=true&ren=$ren&zone=$zone&quan_tity=$Status_pe_ser';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TenantAllbillPayModel teNantModel =
              TenantAllbillPayModel.fromJson(map);
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

            print('difference == $difference');

            var daterx_now = DateTime.now();

            var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

            final now = DateTime.now();
            final earlier = daterx_ldate.subtract(const Duration(days: 0));
            var daterx_A = now.isAfter(earlier);
            print(now.isAfter(earlier)); // true
            print(now.isBefore(earlier)); // true

            if (daterx_A != true) {
              setState(() {
                teNantModels.add(teNantModel);
              });
            }
          }
        }
        print('teNantModels.length');
        print(teNantModels.length);
        setState(() {
          _teNantModels = teNantModels;
        });
      } else {}
    } catch (e) {}
  }

  ////////--------------------------------------------------------------->
  Future<Null> tenant_billpay_Select() async {
    if (transteNantModels_Select.isNotEmpty) {
      transteNantModels_Select.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = (Value_Chang_Zone_People_Ser == null)
        ? '0'
        : Value_Chang_Zone_People_Ser;
    String url =
        '${MyConstant().domain}/GC_tenantAll_billpaySelect_Report.php?isAdd=true&ren=$ren&zone=$zone&yea_r=$YE_Transte_People';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TransteNantModels transteNantModels_Selects =
              TransteNantModels.fromJson(map);

          setState(() {
            transteNantModels_Select.add(transteNantModels_Selects);
          });
        }
      } else {}
    } catch (e) {}

    setState(() {
      Await_Status_Report1 = 1;
    });
  }

  ////////-------------------------------------------------------->(รับเงินประกัน)
  Future<Null> tenant_Pakan() async {
    if (contractxPakanModels.isNotEmpty) {
      contractxPakanModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone =
        (Value_Chang_Zone_Pakan_Ser == null) ? '0' : Value_Chang_Zone_Pakan_Ser;
    String url =
        '${MyConstant().domain}/GC_PakanReport.php?isAdd=true&ren=$ren&zser=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          ContractxPakanModel contractxPakanModelss =
              ContractxPakanModel.fromJson(map);

          setState(() {
            contractxPakanModels.add(contractxPakanModelss);
          });
        }
        setState(() {
          _contractxPakanModels = contractxPakanModels;
        });
      } else {}
    } catch (e) {}
    print('tenant_Pakan : ${contractxPakanModels.length}');
    setState(() {
      Await_Status_Report2 = 1;
    });
  }

////////////------------------------------------------>(คืนเงินประกัน)
  Future<Null> red_Trans_Kon() async {
    if (transKonModels.isNotEmpty) {
      setState(() {
        transKonModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var zone =
        (Value_Chang_Zone_Pakan_Ser == null) ? '0' : Value_Chang_Zone_Pakan_Ser;
    String url =
        '${MyConstant().domain}/GC_tran_Kon_pakanReport.php?isAdd=true&ren=$ren&zser_zone=$zone';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransKonModel transKonModel = TransKonModel.fromJson(map);
          var sum_amtx = double.parse(transKonModel.total!);
          setState(() {
            // sum_Kon = sum_Kon + sum_amtx;
            // bot = 1;
            transKonModels.add(transKonModel);
          });
        }
      }
    } catch (e) {}
    setState(() {
      _transKonModels = transKonModels;
    });
    if (transKonModels.length != 0) {
      // read_his_list();
    }
    print('red_Trans_Kon : ${transKonModels.length}');
    setState(() {
      Await_Status_Report3 = 1;
    });
  }

  ////////////------------------------------------------>
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

  _searchBar_Pakan() {
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
                contractxPakanModels =
                    _contractxPakanModels.where((contractxPakanModel) {
                  var notTitle =
                      contractxPakanModel.cid.toString().toLowerCase();
                  var notTitle2 =
                      contractxPakanModel.cname.toString().toLowerCase();
                  var notTitle3 =
                      contractxPakanModel.zn.toString().toLowerCase();

                  var notTitle4 =
                      contractxPakanModel.sname.toString().toLowerCase();
                  var notTitle5 =
                      contractxPakanModel.unit.toString().toLowerCase();
                  var notTitle6 =
                      contractxPakanModel.expname.toString().toLowerCase();
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

  _searchBar_GetbackPakan() {
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
                transKonModels = _transKonModels.where((transKonModel) {
                  var notTitle = transKonModel.cid.toString().toLowerCase();
                  var notTitle2 = transKonModel.cname.toString().toLowerCase();
                  var notTitle3 = transKonModel.zn.toString().toLowerCase();

                  var notTitle4 = transKonModel.pdate.toString().toLowerCase();
                  var notTitle5 = transKonModel.type.toString().toLowerCase();
                  var notTitle6 = transKonModel.docno.toString().toLowerCase();
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

  ////////////------------------------------------------>
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
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
                          'ผู้เช่า :',
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
                            value: Status_pe,

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
                              int selectedIndex =
                                  Status.indexWhere((item) => item == value);
                              setState(() {
                                Status_pe = Status[selectedIndex]!;
                                Status_pe_ser = '${selectedIndex + 1}';
                              });
                              print(Status_pe_ser);
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
                            value: Value_Chang_Zone_People,
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
                                Value_Chang_Zone_People = value!;
                                Value_Chang_Zone_People_Ser =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              print(
                                  'Selected Index: $Value_Chang_Zone_People  //${Value_Chang_Zone_People_Ser}');
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
                            value: (YE_Transte_People == null)
                                ? null
                                : YE_Transte_People,

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
                                YE_Transte_People = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Status_pe != null &&
                                Value_Chang_Zone_People != null) {
                              setState(() {
                                Await_Status_Report1 = 0;
                              });
                              Dia_log();
                            }

                            read_tenantAll_billpay();
                            tenant_billpay_Select();
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
                        onTap: (Status_pe == null ||
                                Value_Chang_Zone_People == null ||
                                YE_Transte_People == null ||
                                teNantModels.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานรายรับตามผู้เช่า');
                                RE_People_Widget();
                              }),
                    (teNantModels.isEmpty || Await_Status_Report1 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (Status_pe != null &&
                                      teNantModels.isEmpty &&
                                      Value_Chang_Zone_People != null &&
                                      YE_Transte_People != null &&
                                      Await_Status_Report1 != null)
                                  ? 'รายงานรายรับตามผู้เช่า (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานรายรับตามผู้เช่า',
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
                                      'กำลังโหลดรายงานรายรับตามผู้เช่า...',
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
                                  'รายงานรายรับตามผู้เช่า ✔️',
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
                            value: Value_Chang_Zone_Pakan,
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
                                Value_Chang_Zone_Pakan = value!;
                                Value_Chang_Zone_Pakan_Ser =
                                    zoneModels_report[selectedIndex].ser!;
                              });
                              print(
                                  'Selected Index: $Value_Chang_Zone_Pakan  //${Value_Chang_Zone_Pakan_Ser}');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            if (Value_Chang_Zone_Pakan != null) {
                              setState(() {
                                Await_Status_Report2 = 0;
                                Await_Status_Report3 = 0;
                              });
                              Dia_log();
                            }

                            tenant_Pakan();
                            red_Trans_Kon();
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
                        onTap: (Value_Chang_Zone_Pakan == null ||
                                contractxPakanModels.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานรับเงินประกันผู้เช่า');
                                RE_Pakan_Widget();
                              }),
                    (contractxPakanModels.isEmpty ||
                            Await_Status_Report2 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (contractxPakanModels.isEmpty &&
                                      Value_Chang_Zone_Pakan != null &&
                                      Await_Status_Report2 != null)
                                  ? 'รายงานรับเงินประกันผู้เช่า (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานรับเงินประกันผู้เช่า',
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
                                      'กำลังโหลดรายงานรับเงินประกันผู้เช่า...',
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
                                  'รายงานรับเงินประกันผู้เช่า ✔️',
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
                        onTap: (Value_Chang_Zone_Pakan == null ||
                                transKonModels.isEmpty)
                            ? null
                            : () async {
                                Insert_log.Insert_logs(
                                    'รายงาน', 'กดดูรายงานคืนเงินประกันผู้เช่า');
                                RE_Getback_Pakan_Widget();
                              }),
                    (transKonModels.isEmpty || Await_Status_Report3 == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (transKonModels.isEmpty &&
                                      Value_Chang_Zone_Pakan != null &&
                                      Await_Status_Report3 != null)
                                  ? 'รายงานคืนเงินประกันผู้เช่า (ไม่พบข้อมูล ✖️)'
                                  : 'รายงานคืนเงินประกันผู้เช่า',
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
                                      'กำลังโหลดรายงานคืนเงินประกันผู้เช่า...',
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
                                  'รายงานคืนเงินประกันผู้เช่า ✔️',
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

///////////////-------------------------------->
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

  ///////////////////////////----------------------------------------------->(รายงานผู้เช่า)
  RE_People_Widget() {
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
                      (Value_Chang_Zone_People == null)
                          ? 'รายงานรายรับตามผู้เช่า $YE_Transte_People (กรุณาเลือกโซน)'
                          : 'รายงานรายรับตามผู้เช่า $YE_Transte_People (โซน : $Value_Chang_Zone_People)',
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
                              'ผู้เช่า: ${Status_pe}',
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
                              ? MediaQuery.of(context).size.width + 350
                              : (teNantModels.length == 0)
                                  ? MediaQuery.of(context).size.width + 350
                                  : 1200,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
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
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ชื่อผู้ติดต่อ',
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
                                        'เบอร์ติดต่อ',
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
                                        'ชื่อร้านค้า',
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
                                        'โซนพื้นที่',
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
                                        'รหัสพื้นที่',
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
                                    for (int index = 0; index < 12; index++)
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Text(
                                              '${monthsAbbreviationInThai[index]}',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: ReportScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  fontSize: 14.0),
                                            ),
                                            Text(
                                              '(ล่าสุด)',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: Font_.Fonts_T,
                                                  fontSize: 14.0),
                                            ),
                                          ],
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
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Tooltip(
                                                richMessage: TextSpan(
                                                  text: teNantModels[index]
                                                              .docno ==
                                                          null
                                                      ? teNantModels[index]
                                                                  .cid ==
                                                              null
                                                          ? ''
                                                          : '${teNantModels[index].cid}'
                                                      : '${teNantModels[index].docno}',
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
                                                  teNantModels[index].docno ==
                                                          null
                                                      ? teNantModels[index]
                                                                  .cid ==
                                                              null
                                                          ? ''
                                                          : '${teNantModels[index].cid}'
                                                      : '${teNantModels[index].docno}',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 1,
                                                teNantModels[index].cname ==
                                                        null
                                                    ? teNantModels[index]
                                                                .cname_q ==
                                                            null
                                                        ? ''
                                                        : '${teNantModels[index].cname_q}'
                                                    : '${teNantModels[index].cname}',
                                                textAlign: TextAlign.start,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 1,
                                                '${teNantModels[index].tel}',
                                                textAlign: TextAlign.start,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Tooltip(
                                                richMessage: TextSpan(
                                                  text: teNantModels[index]
                                                              .sname ==
                                                          null
                                                      ? teNantModels[index]
                                                                  .sname_q ==
                                                              null
                                                          ? ''
                                                          : '${teNantModels[index].sname_q}'
                                                      : '${teNantModels[index].sname}',
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
                                                  teNantModels[index].sname ==
                                                          null
                                                      ? teNantModels[index]
                                                                  .sname_q ==
                                                              null
                                                          ? ''
                                                          : '${teNantModels[index].sname_q}'
                                                      : '${teNantModels[index].sname}',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
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
                                              textAlign: TextAlign.start,
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
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text: teNantModels[index]
                                                            .ln_c ==
                                                        null
                                                    ? teNantModels[index]
                                                                .ln_q ==
                                                            null
                                                        ? ''
                                                        : '${teNantModels[index].ln_q}'
                                                    : '${teNantModels[index].ln_c}',
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
                                                teNantModels[index].ln_c == null
                                                    ? teNantModels[index]
                                                                .ln_q ==
                                                            null
                                                        ? ''
                                                        : '${teNantModels[index].ln_q}'
                                                    : '${teNantModels[index].ln_c}',
                                                textAlign: TextAlign.start,
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
                                              nFormat
                                                  .format(double.parse(
                                                      '${teNantModels[index].total_contractx}'))
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
                                          // for (int index = 0;
                                          //     index < 12;
                                          //     index++)
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m1 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m1)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m1}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m1 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m1)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m1).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m2 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m2)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m2}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m2 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m2)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m2).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m3 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m3)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m3}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m3 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m3)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m3).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m4 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m4)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m4}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m4 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m4)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m4).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m5 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m5)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m5}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m5 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m5)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m5).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m6 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m6)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m6}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m6 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m6)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m6).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m7 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m7)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m7}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m7 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m7)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m7).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m8 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m8)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m8}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m8 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m8)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m8).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m9 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m9)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m9}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m9 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m9)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m9).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m10 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m10)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m10}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m10 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m10)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m10).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m11 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m11)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m11}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m11 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m11)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m11).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_date_m12 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_date_m12)
                                                          .isEmpty
                                                      ? '-'
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => DateFormat('d MMM', 'th_TH').format(DateTime.parse('${model.l_date_m12}'))).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                                Text(
                                                  transteNantModels_Select
                                                          .where((model) =>
                                                              model.cid ==
                                                                  '${teNantModels[index].cid}' &&
                                                              model.l_docno_m12 !=
                                                                  null)
                                                          .map((model) =>
                                                              model.l_docno_m12)
                                                          .isEmpty
                                                      ? ''
                                                      : '${transteNantModels_Select.where((model) => model.cid == '${teNantModels[index].cid}').map((model) => model.l_docno_m12).join(',')}',
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: Font_.Fonts_T,
                                                      fontSize: 12.0),
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
                              Value_Report = 'รายงานรายรับตามผู้เช่า';
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
                            formKey.currentState?.reset();
                            Value_Chang_Zone_People_Ser = null;
                            Value_Chang_Zone_People = null;
                            Status_pe = null;
                            Await_Status_Report1 = null;
                            YE_Transte_People = null;
                            teNantModels.clear();
                            _teNantModels.clear();
                            transteNantModels.clear();
                            transteNantModels_Select.clear();
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

  ///////////////////////////----------------------------------------------->(รายงานรับเงินประกันผู้เช่า)
  RE_Pakan_Widget() {
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
                      (Value_Chang_Zone_Pakan == null)
                          ? 'รายงานรับเงินประกันผู้เช่า  (กรุณาเลือกโซน)'
                          : 'รายงานรับเงินประกันผู้เช่า  (โซน : $Value_Chang_Zone_Pakan)',
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
                              'ทั้งหมด: ${contractxPakanModels.length}',
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
                            child: _searchBar_Pakan(),
                          ),
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
                              ? MediaQuery.of(context).size.width * 0.925
                              : (contractxPakanModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'โซน',
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
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ชื่อผู้ติดต่อ',
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
                                        'ชื่อร้านค้า',
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
                                        'รายการ',
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
                                        'ประเภท',
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
                                        'ยอดสุทธิ',
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
                                itemCount: contractxPakanModels.length,
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
                                          Expanded(
                                            flex: 1,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text:
                                                    '${contractxPakanModels[index].zn}',
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
                                                '${contractxPakanModels[index].zn}',
                                                textAlign: TextAlign.start,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Tooltip(
                                                richMessage: TextSpan(
                                                  text:
                                                      '${contractxPakanModels[index].cid}',
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
                                                  '${contractxPakanModels[index].cid}',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 1,
                                                '${contractxPakanModels[index].cname}',
                                                textAlign: TextAlign.start,
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Tooltip(
                                                richMessage: TextSpan(
                                                  text:
                                                      '${contractxPakanModels[index].sname}',
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
                                                  '${contractxPakanModels[index].sname}',
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      //fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 25,
                                                maxLines: 1,
                                                '${contractxPakanModels[index].expname}',
                                                textAlign: TextAlign.start,
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
                                              '${contractxPakanModels[index].unit}',
                                              textAlign: TextAlign.start,
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
                                              nFormat
                                                  .format(double.parse(
                                                      '${contractxPakanModels[index].total}'))
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
                    if (contractxPakanModels.length != 0)
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
                              Value_Report = 'รายงานรับเงินประกันผู้เช่า';
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
                            Value_Chang_Zone_Pakan_Ser = null;
                            Value_Chang_Zone_Pakan = null;

                            Await_Status_Report2 = null;

                            contractxPakanModels.clear();
                            _contractxPakanModels.clear();
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

  ///////////////////////////----------------------------------------------->(รายงาน คืนเงินประกันผู้เช่า)
  RE_Getback_Pakan_Widget() {
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
                      (Value_Chang_Zone_Pakan == null)
                          ? 'รายงานคืนเงินประกันผู้เช่า  (กรุณาเลือกโซน)'
                          : 'รายงานคืนเงินประกันผู้เช่า  (โซน : $Value_Chang_Zone_Pakan)',
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
                              'ทั้งหมด: ${transKonModels.length}',
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
                            child: _searchBar_GetbackPakan(),
                          ),
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
                              ? MediaQuery.of(context).size.width * 0.925
                              : (transKonModels.length == 0)
                                  ? MediaQuery.of(context).size.width
                                  : 1200,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'โซน',
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
                                    Expanded(
                                      flex: 1,
                                      child: const Text(
                                        'ชื่อร้านค้า',
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
                                        'เลขที่ใบเสร็จ',
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
                                        'รูปแบบชำระ',
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
                                        'ยอดคืนสุทธิ',
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
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: const Text(
                                    //     'Slip',
                                    //     textAlign: TextAlign.right,
                                    //     style: TextStyle(
                                    //         color: PeopleChaoScreen_Color
                                    //             .Colors_Text1_,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontFamily: FontWeight_.Fonts_T,
                                    //         fontSize: 14.0
                                    //         //fontSize: 10.0
                                    //         //fontSize: 10.0
                                    //         ),
                                    //   ),
                                    // ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: const Text(
                                    //     '...',
                                    //     textAlign: TextAlign.right,
                                    //     style: TextStyle(
                                    //         color: PeopleChaoScreen_Color
                                    //             .Colors_Text1_,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontFamily: FontWeight_.Fonts_T,
                                    //         fontSize: 14.0
                                    //         //fontSize: 10.0
                                    //         //fontSize: 10.0
                                    //         ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  // height: (Responsive.isDesktop(context))
                                  //     ? MediaQuery.of(context).size.width * 0.255
                                  //     : MediaQuery.of(context).size.height * 0.45,
                                  child: ListView.builder(
                                itemCount: transKonModels.length,
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
                                          Expanded(
                                            flex: 1,
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text:
                                                    '${transKonModels[index].zn}',
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
                                                '${transKonModels[index].zn}',
                                                textAlign: TextAlign.start,
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
                                                text:
                                                    '${transKonModels[index].cid}',
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
                                                '${transKonModels[index].cid}',
                                                textAlign: TextAlign.start,
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
                                                text:
                                                    '${transKonModels[index].cname}',
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
                                                '${transKonModels[index].cname}',
                                                textAlign: TextAlign.start,
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
                                                text:
                                                    '${transKonModels[index].docno}',
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
                                                '${transKonModels[index].docno}',
                                                textAlign: TextAlign.start,
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
                                              '${DateFormat('dd-MM').format(DateTime.parse('${transKonModels[index].pdate} 00:00:00'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${transKonModels[index].pdate} 00:00:00'))}') + 543}',
                                              // '${transKonModels[index].pdate}',
                                              textAlign: TextAlign.start,
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
                                            child: Tooltip(
                                              richMessage: TextSpan(
                                                text:
                                                    '${transKonModels[index].type}',
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
                                                '${transKonModels[index].type}',
                                                textAlign: TextAlign.start,
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
                                              nFormat
                                                  .format(double.parse(
                                                      '${transKonModels[index].total}'))
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text2_,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: AutoSizeText(
                                          //     minFontSize: 10,
                                          //     maxFontSize: 25,
                                          //     maxLines: 1,
                                          //     '',
                                          //     // '${transKonModels[index].slip}',
                                          //     textAlign: TextAlign.start,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     style: const TextStyle(
                                          //         color: PeopleChaoScreen_Color
                                          //             .Colors_Text2_,
                                          //         //fontWeight: FontWeight.bold,
                                          //         fontFamily: Font_.Fonts_T),
                                          //   ),
                                          // ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: AutoSizeText(
                                          //     minFontSize: 10,
                                          //     maxFontSize: 25,
                                          //     maxLines: 1,
                                          //     '...',
                                          //     textAlign: TextAlign.right,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     style: const TextStyle(
                                          //         color: PeopleChaoScreen_Color
                                          //             .Colors_Text2_,
                                          //         //fontWeight: FontWeight.bold,
                                          //         fontFamily: Font_.Fonts_T),
                                          //   ),
                                          // ),
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
                    if (transKonModels.length != 0)
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
                              Value_Report = 'รายงานคืนเงินประกันผู้เช่า';
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
                            Value_Chang_Zone_Pakan_Ser = null;
                            Value_Chang_Zone_Pakan = null;

                            Await_Status_Report2 = null;

                            transKonModels.clear();
                            _transKonModels.clear();
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

  ////////////------------------------------------------------------>(Export file 2)
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
        if (Value_Report == 'รายงานรับเงินประกันผู้เช่า') {
          Excgen_GetPakanReport.exportExcel_GetPakanReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              Value_Chang_Zone_Pakan,
              contractxPakanModels);
        } else if (Value_Report == 'รายงานคืนเงินประกันผู้เช่า') {
          Excgen_PayPakanReport.exportExcel_PayPakanReport(
              context,
              NameFile_,
              _verticalGroupValue_NameFile,
              renTal_name,
              Value_Chang_Zone_Pakan,
              transKonModels);
        }
      }
      Navigator.of(context).pop();
    }
  }
}



///​กรรมกรข่าว X ​ทีมพากย์พันธมิตร
