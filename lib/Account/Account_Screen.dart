import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_sheet/side_sheet.dart';

import 'package:http/http.dart' as http;
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../Home/Home_Screen.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Manage/Manage_Screen.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetTrans_Model.dart';
import '../Model/GetType_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../PDF/pdf_AC_his_statusbill.dart';
import '../PDF/pdf_AC_historybill.dart';
import '../PDF/pdf_BillingNote_IV.dart';
import '../PDF/pdf_Receipt.dart';
import '../PeopleChao/Pays_.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Report/Report_Screen.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/colors.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:pdf/widgets.dart' as pw;

import 'lockpay.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  int Status_ = 1;
  String tappedIndex_ = '';
  List<ZoneModel> zoneModels = [];

  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<TransReBillModel> _TransReBillModels = [];
  Set<int> _selectedIndexes = Set();
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      fname_,
      pdate;
  var Value_selectDate;
  List<RenTalModel> renTalModels = [];
  List<TypeModel> typeModels = [];
  List<AreaModel> areaModels = [];
  List<PayMentModel> _PayMentModels = [];
  final Formbecause_ = TextEditingController();
  List Area_ = [
    'คอมมูนิตี้มอลล์',
    'ออฟฟิศให้เช่า',
    'ตลาดนัด',
    'อื่นๆ',
  ];
  List buttonview_ = [
    'ข้อมูลการเช่า',
    'ตั้งหนี้/วางบิล',
    'รับชำระ',
    'ลดหนี้',
    'ประวัติบิล',
  ];
  List Status = [
    'ภาพรวม',
    'ค้างชำระ',
    'ประวัติบิล',
    'ล็อกเสียบ ',
  ];
  String? teNantcid, teNantsname, teNantnamenew;
  String? rtname,
      type,
      typex,
      renname,
      bill_name,
      bill_addr,
      bill_tax,
      bill_tel,
      bill_email,
      expbill,
      expbill_name,
      bill_default,
      bill_tser,
      foder,
      bills_name_,
      numinvoice;
  String? Form_nameshop,
      Form_typeshop,
      Form_bussshop,
      Form_bussscontact,
      Form_address,
      Form_tel,
      Form_email,
      Form_tax,
      rental_count_text,
      Form_area,
      Form_ln,
      Form_sdate,
      Form_ldate,
      Form_period,
      Form_rtname,
      Form_docno,
      Form_zn,
      Form_aser,
      Form_qty,
      discount_;

  final sum_disamtx = TextEditingController();
  final sum_dispx = TextEditingController();
  final Form_payment1 = TextEditingController();
  final Form_payment2 = TextEditingController();
  final Form_time = TextEditingController();
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0;

  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_tenant1();
    red_Trans_bill();
    read_GC_rental();
    read_GC_type();
    read_GC_areaSelect();
    red_payMent();
  }

  Future<Null> red_payMent() async {
    if (_PayMentModels.length != 0) {
      setState(() {
        _PayMentModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren}';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        Map<String, dynamic> map = Map();
        map['ser'] = '0';
        map['datex'] = '';
        map['timex'] = '';
        map['ptser'] = '';
        map['ptname'] = 'เลือก';
        map['bser'] = '';
        map['bank'] = '';
        map['bno'] = '';
        map['bname'] = '';
        map['bsaka'] = '';
        map['btser'] = '';
        map['btype'] = '';
        map['st'] = '1';
        map['rser'] = '';
        map['accode'] = '';
        map['co'] = '';
        map['data_update'] = '';

        PayMentModel _PayMentModel = PayMentModel.fromJson(map);

        setState(() {
          _PayMentModels.add(_PayMentModel);
        });

        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);
          setState(() {
            _PayMentModels.add(_PayMentModel);
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> read_GC_areaSelect() async {
    if (areaModels.length != 0) {
      areaModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

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
          if (areaModel.quantity != '1' && areaModel.quantity != '3') {
            setState(() {
              areaModels.add(areaModel);
            });
          }
        }
      } else {
        setState(() {
          if (areaModels.isEmpty) {
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
  }

  Future<Null> read_GC_type() async {
    if (typeModels.isNotEmpty) {
      typeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
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
      print(result);
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
    print('name>>>>>  $renname');
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

    String url =
        '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
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
      }
    } catch (e) {}
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
    });
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

  Future<Null> read_GC_tenant1() async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_tenantAll_setring1.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll_setring1.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_tenant_setring1.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            if (teNantModel.cid != '') {
              var daterx = teNantModel.ldate;
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

              // setState(() {
              //   teNantModels.add(teNantModel);
              // });
            }
            // teNantModels.add(teNantModel);
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

        zone_ser = preferences.getString('zonePSer');
        zone_name = preferences.getString('zonesPName');
      });
    } catch (e) {}
  }

  Future<Null> read_GC_tenant() async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    String url = zone == null
        ? '${MyConstant().domain}/GC_tenantAll_setring.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll_setring.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_tenant_setring.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            if (teNantModel.cid != '') {
              var daterx = teNantModel.ldate;
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

              // setState(() {
              //   teNantModels.add(teNantModel);
              // });
            }
            // teNantModels.add(teNantModel);
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

        zone_ser = preferences.getString('zonePSer');
        zone_name = preferences.getString('zonesPName');
      });
    } catch (e) {}
  }

  _searchBar() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: PeopleChaoScreen_Color.Colors_Text2_,
          fontFamily: Font_.Fonts_T),
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.white,
        hintText: ' Search...',
        hintStyle: const TextStyle(
            color: PeopleChaoScreen_Color.Colors_Text2_,
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
        print(text);
        text = text.toLowerCase();
        setState(() {
          teNantModels = _teNantModels.where((teNantModels) {
            var notTitle = teNantModels.lncode.toString().toLowerCase();
            var notTitle2 = teNantModels.cid.toString().toLowerCase();
            var notTitle3 = teNantModels.docno.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text);
          }).toList();
        });
      },
    );
  }

  ///----------------->
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();
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

  _moveUp3() {
    _scrollController3.animateTo(_scrollController3.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown3() {
    _scrollController3.animateTo(_scrollController3.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
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
        print("${result!.year}/${result.month}/${result.day}");
        setState(() {
          Value_selectDate = "${result.day}-${result.month}-${result.year}";
        });
      }
    });
  }

  ///----------------->
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        'บัญชี ',
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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: AppbackgroundColor.TiTile_Colors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      // border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'โซนพื้นที่เช่า:',
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
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
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
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
                                  print(
                                      'mmmmm ${zoneSer.toString()} $zonesName');

                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString(
                                      'zonePSer', zoneSer.toString());
                                  preferences.setString(
                                      'zonesPName', zonesName.toString());

                                  preferences.setString(
                                      'zoneSer', zoneSer.toString());
                                  preferences.setString(
                                      'zonesName', zonesName.toString());
                                  setState(() {
                                    read_GC_tenant();
                                    read_GC_areaSelect();
                                  });
                                },
                                // onSaved: (value) {
                                //   // selectedValue = value.toString();
                                // },
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'ค้นหา:',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T),
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
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     height: 50,
                //     color: Colors.blue,
                //   ),
                // ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          //   child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       decoration: const BoxDecoration(
          //         color: AppbackgroundColor.TiTile_Colors,
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(10),
          //             topRight: Radius.circular(10),
          //             bottomLeft: Radius.circular(0),
          //             bottomRight: Radius.circular(0)),
          //         // border: Border.all(color: Colors.white, width: 1),
          //       ),
          //       // padding: const EdgeInsets.all(8.0),
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          //           child: Container(
          //               width: (!Responsive.isDesktop(context))
          //                   ? MediaQuery.of(context).size.width
          //                   : MediaQuery.of(context).size.width * 0.825,
          //               decoration: const BoxDecoration(
          //                 color: AppbackgroundColor.TiTile_Colors,
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(10),
          //                     topRight: Radius.circular(10),
          //                     bottomLeft: Radius.circular(0),
          //                     bottomRight: Radius.circular(0)),
          //                 // border: Border.all(color: Colors.white, width: 1),
          //               ),
          //               // padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 children: [
          //                   Expanded(
          //                       flex: 1,
          //                       child: Row(
          //                         children: [
          //                           const Expanded(
          //                             flex: 2,
          //                             child: Padding(
          //                               padding: EdgeInsets.all(8.0),
          //                               child: Text(
          //                                 'โซนพื้นที่เช่า:',
          //                                 style: TextStyle(
          //                                     color: PeopleChaoScreen_Color
          //                                         .Colors_Text1_,
          //                                     fontWeight: FontWeight.bold,
          //                                     fontFamily: FontWeight_.Fonts_T),
          //                               ),
          //                             ),
          //                           ),
          //                           Expanded(
          //                             flex: 3,
          //                             child: Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Container(
          //                                 decoration: BoxDecoration(
          //                                   color: AppbackgroundColor
          //                                       .Sub_Abg_Colors,
          //                                   borderRadius: const BorderRadius
          //                                           .only(
          //                                       topLeft: Radius.circular(10),
          //                                       topRight: Radius.circular(10),
          //                                       bottomLeft: Radius.circular(10),
          //                                       bottomRight:
          //                                           Radius.circular(10)),
          //                                   border: Border.all(
          //                                       color: Colors.grey, width: 1),
          //                                 ),
          //                                 // width: 150,
          //                                 child: DropdownButtonFormField2(
          //                                   decoration: InputDecoration(
          //                                     isDense: true,
          //                                     contentPadding: EdgeInsets.zero,
          //                                     border: OutlineInputBorder(
          //                                       borderRadius:
          //                                           BorderRadius.circular(10),
          //                                     ),
          //                                   ),
          //                                   isExpanded: true,
          //                                   hint: Text(
          //                                     zone_name == null
          //                                         ? 'ทั้งหมด'
          //                                         : '$zone_name',
          //                                     maxLines: 1,
          //                                     style: const TextStyle(
          //                                         fontSize: 14,
          //                                         color: PeopleChaoScreen_Color
          //                                             .Colors_Text2_,
          //                                         fontFamily: Font_.Fonts_T),
          //                                   ),
          //                                   icon: const Icon(
          //                                     Icons.arrow_drop_down,
          //                                     color: Colors.black,
          //                                   ),
          //                                   style: const TextStyle(
          //                                       color: PeopleChaoScreen_Color
          //                                           .Colors_Text2_,
          //                                       fontFamily: Font_.Fonts_T),
          //                                   iconSize: 30,
          //                                   buttonHeight: 40,
          //                                   // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          //                                   dropdownDecoration: BoxDecoration(
          //                                     borderRadius:
          //                                         BorderRadius.circular(10),
          //                                   ),
          //                                   items: zoneModels
          //                                       .map((item) =>
          //                                           DropdownMenuItem<String>(
          //                                             value:
          //                                                 '${item.ser},${item.zn}',
          //                                             child: Text(
          //                                               item.zn!,
          //                                               style: const TextStyle(
          //                                                   fontSize: 14,
          //                                                   color: PeopleChaoScreen_Color
          //                                                       .Colors_Text2_,
          //                                                   fontFamily:
          //                                                       Font_.Fonts_T),
          //                                             ),
          //                                           ))
          //                                       .toList(),

          //                                   onChanged: (value) async {
          //                                     var zones = value!.indexOf(',');
          //                                     var zoneSer =
          //                                         value.substring(0, zones);
          //                                     var zonesName =
          //                                         value.substring(zones + 1);
          //                                     print(
          //                                         'mmmmm ${zoneSer.toString()} $zonesName');

          //                                     SharedPreferences preferences =
          //                                         await SharedPreferences
          //                                             .getInstance();
          //                                     preferences.setString('zonePSer',
          //                                         zoneSer.toString());
          //                                     preferences.setString(
          //                                         'zonesPName',
          //                                         zonesName.toString());

          //                                     setState(() {
          //                                       read_GC_tenant();
          //                                     });
          //                                   },
          //                                   // onSaved: (value) {
          //                                   //   // selectedValue = value.toString();
          //                                   // },
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       )),
          //                   Expanded(
          //                       flex: 2,
          //                       child: Row(
          //                         children: [
          //                           const Expanded(
          //                             flex: 1,
          //                             child: Padding(
          //                               padding: EdgeInsets.all(8.0),
          //                               child: Text(
          //                                 'ค้นหา:',
          //                                 textAlign: TextAlign.end,
          //                                 style: TextStyle(
          //                                     color: PeopleChaoScreen_Color
          //                                         .Colors_Text1_,
          //                                     fontWeight: FontWeight.bold,
          //                                     fontFamily: FontWeight_.Fonts_T),
          //                               ),
          //                             ),
          //                           ),
          //                           Expanded(
          //                             flex: 4,
          //                             child: Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Container(
          //                                 decoration: BoxDecoration(
          //                                   color: AppbackgroundColor
          //                                       .Sub_Abg_Colors,
          //                                   borderRadius: const BorderRadius
          //                                           .only(
          //                                       topLeft: Radius.circular(10),
          //                                       topRight: Radius.circular(10),
          //                                       bottomLeft: Radius.circular(10),
          //                                       bottomRight:
          //                                           Radius.circular(10)),
          //                                   border: Border.all(
          //                                       color: Colors.grey, width: 1),
          //                                 ),
          //                                 // width: 120,
          //                                 height: 35,
          //                                 child: _searchBar(),
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       )),
          //                   Expanded(
          //                       flex: 2,
          //                       child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.end,
          //                         // children: [
          //                         //   Padding(
          //                         //     padding: const EdgeInsets.all(8.0),
          //                         //     child: InkWell(
          //                         //       child: Container(
          //                         //           // padding: EdgeInsets.all(8.0),
          //                         //           child: CircleAvatar(
          //                         //         backgroundColor: Colors.yellow[700],
          //                         //         radius: 20,
          //                         //         child: PopupMenuButton(
          //                         //           child: Text(
          //                         //             '+',
          //                         //             style: TextStyle(
          //                         //                 fontSize: 25,
          //                         //                 color: Colors.white,
          //                         //                 fontWeight: FontWeight.bold,
          //                         //                 fontFamily:
          //                         //                     FontWeight_.Fonts_T),
          //                         //           ),
          //                         //           itemBuilder:
          //                         //               (BuildContext context) => [
          //                         //             PopupMenuItem(
          //                         //               child: InkWell(
          //                         //                   onTap: () async {
          //                         //                     Navigator.pop(context);
          //                         //                     // setState(() {
          //                         //                     //   ReturnBodyPeople =
          //                         //                     //       'PeopleChaoScreen3';
          //                         //                     // });
          //                         //                   },
          //                         //                   child: Container(
          //                         //                       padding:
          //                         //                           EdgeInsets.all(10),
          //                         //                       width: MediaQuery.of(
          //                         //                               context)
          //                         //                           .size
          //                         //                           .width,
          //                         //                       child: Row(
          //                         //                         children: [
          //                         //                           Expanded(
          //                         //                             child: Text(
          //                         //                               'ค้างชำระ',
          //                         //                               style: TextStyle(
          //                         //                                   color: PeopleChaoScreen_Color
          //                         //                                       .Colors_Text1_,
          //                         //                                   fontWeight:
          //                         //                                       FontWeight
          //                         //                                           .bold,
          //                         //                                   fontFamily:
          //                         //                                       FontWeight_
          //                         //                                           .Fonts_T),
          //                         //                             ),
          //                         //                           )
          //                         //                         ],
          //                         //                       ))),
          //                         //             ),
          //                         //             PopupMenuItem(
          //                         //               child: InkWell(
          //                         //                   onTap: () async {
          //                         //                     Navigator.pop(context);
          //                         //                     // setState(() {
          //                         //                     //   ReturnBodyPeople =
          //                         //                     //       'PeopleChaoScreen4';
          //                         //                     // });
          //                         //                   },
          //                         //                   child: Container(
          //                         //                       padding:
          //                         //                           EdgeInsets.all(10),
          //                         //                       width: MediaQuery.of(
          //                         //                               context)
          //                         //                           .size
          //                         //                           .width,
          //                         //                       child: Row(
          //                         //                         children: [
          //                         //                           Expanded(
          //                         //                             child: Text(
          //                         //                               'ประวัติบิล',
          //                         //                               style: TextStyle(
          //                         //                                   color: PeopleChaoScreen_Color
          //                         //                                       .Colors_Text1_,
          //                         //                                   fontWeight:
          //                         //                                       FontWeight
          //                         //                                           .bold,
          //                         //                                   fontFamily:
          //                         //                                       FontWeight_
          //                         //                                           .Fonts_T),
          //                         //                             ),
          //                         //                           )
          //                         //                         ],
          //                         //                       ))),
          //                         //             ),
          //                         //           ],
          //                         //         ),
          //                         //       )),
          //                         //     ),
          //                         //   ),
          //                         // ],
          //                       )),
          //                   const SizedBox(
          //                     width: 20,
          //                   ),
          //                 ],
          //               )),
          //         ),
          //       )),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                // border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            const Text(
                              'สถานะ : ',
                              style: TextStyle(
                                color: AccountScreen_Color.Colors_Text1_,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
                            ),
                            for (int i = 0; i < Status.length; i++)
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        Status_ = i + 1;
                                        tappedIndex_ = '';
                                      });
                                      checkPreferance();
                                      read_GC_zone();
                                      if (Status_ == 1) {
                                        read_GC_tenant1();
                                      } else {
                                        read_GC_tenant();
                                      }

                                      red_Trans_bill();
                                      read_GC_rental();
                                      read_GC_type();
                                      read_GC_areaSelect();
                                      red_payMent();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: (i + 1 == 1)
                                            ? Colors.green
                                            : (i + 1 == 2)
                                                ? Colors.red
                                                : (i + 1 == 3)
                                                    ? Colors.brown[400]
                                                    : Colors.blue,
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
                  if (Status_.toString() == '1')
                    InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber[400],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6)),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.print, color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'พิมพ์ใบวางบิล',
                                  style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text2_,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: Font_.Fonts_T,
                                      fontSize: 10.0),
                                ),
                              ),
                            ],
                          )),
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => StreamBuilder(
                              stream:
                                  Stream.periodic(const Duration(seconds: 0)),
                              builder: (context, snapshot) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  title: const Center(
                                      child: Text(
                                    'พิมพ์ใบวางบิล',
                                    style: TextStyle(
                                      color: AccountScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T,
                                      //fontSize: 10.0
                                    ),
                                  )),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text(
                                                'เลือกเดือน',
                                                style: TextStyle(
                                                  color: AccountScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                  //fontSize: 10.0
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  child: Container(
                                                    width: 100,
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.grey,
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
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    child: Text(
                                                      (Value_selectDate == null)
                                                          ? 'เลือก'
                                                          : '$Value_selectDate',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            FontWeight_.Fonts_T,
                                                        //fontSize: 10.0
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _select_Date(context);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // width:
                                          //     MediaQuery.of(context).size.width *
                                          //         0.5,
                                          child: ScrollConfiguration(
                                            behavior: AppScrollBehavior(),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: (Responsive
                                                            .isDesktop(context))
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5
                                                        : 800,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          // width:
                                                          //     MediaQuery.of(context).size.width *
                                                          //         0.5,
                                                          height: 50,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0)),
                                                            // border: Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: const [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'เลือกทั้งหมด',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AccountScreen_Color
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
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'รหัสพื้นที่',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AccountScreen_Color
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
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'ชื่อร้านค้า',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AccountScreen_Color
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
                                                              ),
                                                              // Expanded(
                                                              //   flex: 1,
                                                              //   child: Text(
                                                              //     'กำหนดชำระ',
                                                              //     textAlign:
                                                              //         TextAlign
                                                              //             .center,
                                                              //     style:
                                                              //         TextStyle(
                                                              //       color: AccountScreen_Color
                                                              //           .Colors_Text1_,
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .bold,
                                                              //       fontFamily:
                                                              //           FontWeight_
                                                              //               .Fonts_T,
                                                              //       //fontSize: 10.0
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'เลขที่ใยวางบิล',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AccountScreen_Color
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
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          // width:
                                                          //     MediaQuery.of(context).size.width *
                                                          //         0.5,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                          child:
                                                              ListView.builder(
                                                                  controller:
                                                                      _scrollController1,
                                                                  // itemExtent: 50,
                                                                  physics:
                                                                      const AlwaysScrollableScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      teNantModels
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    final isSelected =
                                                                        _selectedIndexes
                                                                            .contains(index);
                                                                    return Container(
                                                                      color: tappedIndex_ ==
                                                                              index
                                                                                  .toString()
                                                                          ? tappedIndex_Color
                                                                              .tappedIndex_Colors
                                                                              .withOpacity(0.5)
                                                                          : null,
                                                                      child: ListTile(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              tappedIndex_ = index.toString();
                                                                            });
                                                                            setState(() {
                                                                              if (isSelected) {
                                                                                _selectedIndexes.remove(index);
                                                                              } else {
                                                                                _selectedIndexes.add(index);
                                                                              }
                                                                            });
                                                                          },
                                                                          title: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(flex: 1, child: Icon(isSelected ? Icons.check_box : Icons.square)),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    '${teNantModels[index].ln_c}',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(
                                                                                      color: AccountScreen_Color.Colors_Text2_,
                                                                                      // fontWeight:
                                                                                      //     FontWeight
                                                                                      //         .bold,
                                                                                      fontFamily: Font_.Fonts_T,
                                                                                      //fontSize: 10.0
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    '${teNantModels[index].sname}',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(
                                                                                      color: AccountScreen_Color.Colors_Text2_,
                                                                                      // fontWeight:
                                                                                      //     FontWeight
                                                                                      //         .bold,
                                                                                      fontFamily: Font_.Fonts_T,

                                                                                      //fontSize: 10.0
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // const Expanded(
                                                                              //   flex:
                                                                              //       1,
                                                                              //   child:
                                                                              //       Padding(
                                                                              //     padding:
                                                                              //         EdgeInsets.all(8.0),
                                                                              //     child:
                                                                              //         Text(
                                                                              //       'XX-xx-xxxx',
                                                                              //       textAlign: TextAlign.start,
                                                                              //       style: TextStyle(
                                                                              //         color: AccountScreen_Color.Colors_Text2_,
                                                                              //         // fontWeight:
                                                                              //         //     FontWeight
                                                                              //         //         .bold,
                                                                              //         fontFamily: Font_.Fonts_T,

                                                                              //         //fontSize: 10.0
                                                                              //       ),
                                                                              //     ),
                                                                              //   ),
                                                                              // ),
                                                                              const Expanded(
                                                                                flex: 1,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    'INV000XX',
                                                                                    textAlign: TextAlign.end,
                                                                                    style: TextStyle(
                                                                                      color: AccountScreen_Color.Colors_Text2_,
                                                                                      // fontWeight:
                                                                                      //     FontWeight
                                                                                      //         .bold,
                                                                                      fontFamily: Font_.Fonts_T,

                                                                                      //fontSize: 10.0
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                // border: Border.all(
                                                //     color: Colors.grey, width: 1),
                                              ),
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(Icons.print,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'พิมพ์',
                                                      style: TextStyle(
                                                          color:
                                                              AccountScreen_Color
                                                                  .Colors_Text2_,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T,
                                                          fontSize: 15.0),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          onTap: () {
                                            Navigator.pop(context, 'OK');
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          // (!Responsive.isDesktop(context)) ? BodyHome_mobile() :
          BodyHome_Web()
        ],
      ),
    );
  }

  Widget BodyHome_Web() {
    return (Status_ == 1)
        ? BodyStatus2_Web()
        : (Status_ == 2)
            ? BodyStatus1_Web()
            : (Status_ == 3)
                ? BodyStatus3_Web()
                : BodyStatus4_Web();
  }

  Widget BodyStatus1_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
              width: (Responsive.isDesktop(context))
                  ? MediaQuery.of(context).size.width * 0.85
                  : 1200,
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
                      dragStartBehavior: DragStartBehavior.start,
                      child: Row(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.85
                                      : 1200,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Padding(
                                      //     padding: EdgeInsets.all(8.0),
                                      //     child: Text(
                                      //       '...',
                                      //       textAlign: TextAlign.center,
                                      //       style: TextStyle(
                                      //         color: AccountScreen_Color
                                      //             .Colors_Text1_,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontFamily: FontWeight_.Fonts_T,
                                      //         //fontSize: 10.0
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'เลขที่สัญญา',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'เลขที่ตั้งหนี้',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'เลขที่วางบิล',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'รหัสพื้นที่',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'ชื่อร้าน',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'ผู้เช่า',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'รายการค้างชำระ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'กำหนดชำระ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
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
                                            'ค้างชำระ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AccountScreen_Color
                                                  .Colors_Text1_,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontWeight_.Fonts_T,
                                              //fontSize: 10.0
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    width: (Responsive.isDesktop(context))
                                        ? MediaQuery.of(context).size.width *
                                            0.85
                                        : 1200,
                                    decoration: const BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                      // border: Border.all(color: Colors.grey, width: 1),
                                    ),
                                    child: teNantModels.isEmpty
                                        ? SizedBox(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const CircularProgressIndicator(),
                                                StreamBuilder(
                                                  stream: Stream.periodic(
                                                      const Duration(
                                                          milliseconds: 25),
                                                      (i) => i),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData)
                                                      return const Text('');
                                                    double elapsed =
                                                        double.parse(snapshot
                                                                .data
                                                                .toString()) *
                                                            0.05;
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: (elapsed > 8.00)
                                                          ? const Text(
                                                              'ไม่พบข้อมูล',
                                                              style: TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  ),
                                                            )
                                                          : Text(
                                                              'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                              // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                              style: const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  fontFamily:
                                                                      Font_
                                                                          .Fonts_T
                                                                  //fontSize: 10.0
                                                                  ),
                                                            ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            controller: _scrollController1,
                                            // itemExtent: 50,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: teNantModels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                color: tappedIndex_ ==
                                                        index.toString()
                                                    ? tappedIndex_Color
                                                        .tappedIndex_Colors
                                                        .withOpacity(0.5)
                                                    : null,
                                                child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        tappedIndex_ =
                                                            index.toString();
                                                      });
                                                      if (teNantModels[index]
                                                              .invoice !=
                                                          null) {
                                                        in_Trans_select(index);
                                                      } else {
                                                        in_Trans_select(index);
                                                      }

                                                      dialog_pay(index);
                                                    },
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Expanded(
                                                        //   flex: 1,
                                                        //   child: Row(
                                                        //     mainAxisAlignment:
                                                        //         MainAxisAlignment
                                                        //             .center,
                                                        //     children: [
                                                        //       Container(
                                                        //         decoration:
                                                        //             const BoxDecoration(
                                                        //           // color:
                                                        //           //     Colors.grey,
                                                        //           borderRadius: BorderRadius.only(
                                                        //               topLeft:
                                                        //                   Radius.circular(
                                                        //                       10),
                                                        //               topRight:
                                                        //                   Radius.circular(
                                                        //                       10),
                                                        //               bottomLeft:
                                                        //                   Radius.circular(
                                                        //                       10),
                                                        //               bottomRight:
                                                        //                   Radius.circular(
                                                        //                       10)),
                                                        //           // border: Border.all(color: Colors.grey, width: 1),
                                                        //         ),
                                                        //         padding:
                                                        //             const EdgeInsets
                                                        //                     .all(
                                                        //                 8.0),
                                                        //         child:
                                                        //             PopupMenuButton(
                                                        //           child: Center(
                                                        //               child:
                                                        //                   Row(
                                                        //             mainAxisAlignment:
                                                        //                 MainAxisAlignment
                                                        //                     .center,
                                                        //             children: const [
                                                        //               Text(
                                                        //                 'เรียกดู',
                                                        //                 style:
                                                        //                     TextStyle(
                                                        //                   color:
                                                        //                       AccountScreen_Color.Colors_Text2_,
                                                        //                   // fontWeight:
                                                        //                   //     FontWeight
                                                        //                   //         .bold,
                                                        //                   fontFamily:
                                                        //                       Font_.Fonts_T,

                                                        //                   //fontSize: 10.0
                                                        //                 ),
                                                        //               ),
                                                        //               Icon(
                                                        //                 Icons
                                                        //                     .navigate_next,
                                                        //                 color: AccountScreen_Color
                                                        //                     .Colors_Text2_,
                                                        //               )
                                                        //             ],
                                                        //           )),
                                                        //           itemBuilder:
                                                        //               (context) {
                                                        //             return List.generate(
                                                        //                 buttonview_
                                                        //                     .length,
                                                        //                 (index) {
                                                        //               return PopupMenuItem(
                                                        //                 child:
                                                        //                     Text(
                                                        //                   buttonview_[
                                                        //                       index],
                                                        //                   style:
                                                        //                       const TextStyle(
                                                        //                     color:
                                                        //                         Colors.black,

                                                        //                     //fontSize: 10.0
                                                        //                   ),
                                                        //                 ),
                                                        //               );
                                                        //             });
                                                        //           },
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${teNantModels[index].cid}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${teNantModels[index].docno}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            teNantModels[index]
                                                                        .invoice ==
                                                                    null
                                                                ? ''
                                                                : '${teNantModels[index].invoice}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
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
                                                            child: Text(
                                                              '${teNantModels[index].ln_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                color: AccountScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight
                                                                //         .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                                //fontSize: 10.0
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
                                                            child: Text(
                                                              '${teNantModels[index].sname}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  const TextStyle(
                                                                color: AccountScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight
                                                                //         .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,

                                                                //fontSize: 10.0
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${teNantModels[index].cname}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,

                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${teNantModels[index].expname}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,

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
                                                            child: Text(
                                                              '${DateFormat('dd-MM').format(DateTime.parse('${teNantModels[index].date} 00:00:00'))}-${DateTime.parse('${teNantModels[index].date} 00:00:00').year + 543}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color: AccountScreen_Color
                                                                    .Colors_Text2_,
                                                                // fontWeight:
                                                                //     FontWeight
                                                                //         .bold,
                                                                fontFamily: Font_
                                                                    .Fonts_T,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // Expanded(
                                                        //   flex: 1,
                                                        //   child: Text(
                                                        //     '${DateFormat('dd-MM').format(DateTime.parse('${teNantModels[index].ldate} 00:00:00'))}-${DateTime.parse('${teNantModels[index].ldate} 00:00:00').year + 543}',
                                                        //     textAlign: TextAlign
                                                        //         .center,
                                                        //     style:
                                                        //         const TextStyle(
                                                        //       color: AccountScreen_Color
                                                        //           .Colors_Text2_,
                                                        //       // fontWeight:
                                                        //       //     FontWeight
                                                        //       //         .bold,
                                                        //       fontFamily:
                                                        //           Font_.Fonts_T,
                                                        //       //fontSize: 10.0
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            '${teNantModels[index].total}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight
                                                              //         .bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                              //fontSize: 10.0
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            })),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              width: (Responsive.isDesktop(context))
                  ? MediaQuery.of(context).size.width * 0.85
                  : MediaQuery.of(context).size.width,
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(3.0),
                                child: const Text(
                                  'Top',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                    fontFamily: FontWeight_.Fonts_T,
                                  ),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_scrollController1.hasClients) {
                              final position =
                                  _scrollController1.position.maxScrollExtent;
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              padding: const EdgeInsets.all(3.0),
                              child: const Text(
                                'Down',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                  fontFamily: FontWeight_.Fonts_T,
                                ),
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
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(3.0),
                            child: const Text(
                              'Scroll',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0,
                                fontFamily: FontWeight_.Fonts_T,
                              ),
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
    );
  }

  Future<Null> in_Trans_select(index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = teNantModels[index].cid;
    var qutser = teNantModels[index].sname;

    var tser = teNantModels[index].ser_tran;
    var tdocno = teNantModels[index].docno;

    print('object $tdocno');
    String url =
        '${MyConstant().domain}/In_tran_select.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&qutser=$qutser&tser=$tser&tdocno=$tdocno&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        setState(() {
          red_Trans_select2(index);
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  List<TransModel> _TransModels = [];

  Future<Null> red_Trans_select2(int index) async {
    if (_TransModels.length != 0) {
      setState(() {
        _TransModels.clear();
        sum_pvat = 0;
        sum_vat = 0;
        sum_wht = 0;
        sum_amt = 0;
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var ciddoc = teNantModels[index].cid;
    var qutser = teNantModels[index].sname;

    String url =
        '${MyConstant().domain}/GC_tran_select.php?isAdd=true&ren=$ren&user=$user&ciddoc=$ciddoc';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          TransModel _TransModel = TransModel.fromJson(map);

          var sum_pvatx = double.parse(_TransModel.pvat!);
          var sum_vatx = double.parse(_TransModel.vat!);
          var sum_whtx = double.parse(_TransModel.wht!);
          var sum_amtx = double.parse(_TransModel.total!);
          setState(() {
            sum_pvat = sum_pvat + sum_pvatx;
            sum_vat = sum_vat + sum_vatx;
            sum_wht = sum_wht + sum_whtx;
            sum_amt = sum_amt + sum_amtx;
            _TransModels.add(_TransModel);
          });
        }
      }

      setState(() {
        Form_payment1.text =
            (sum_amt - sum_disamt).toStringAsFixed(2).toString();
      });
    } catch (e) {}
  }

  Future<String?> dialog_pay(int index) {
    setState(() {
      sum_disamtx.text = '0.00';
      // red_Trans_select2(index);
    });

    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
            child: Text(
          'เลขที่สัญญา ${teNantModels[index].cid} : ${teNantModels[index].sname}',
          style: TextStyle(
            color: PeopleChaoScreen_Color.Colors_Text1_,
            // fontWeight: FontWeight.bold,
            fontFamily: FontWeight_.Fonts_T,
            fontWeight: FontWeight.bold,
          ),
        )),
        content: Container(
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width
                : 600,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 0)),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.6
                                      : 600,
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.orange[100],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                              // border: Border.all(
                                              //     color: Colors.grey, width: 1),
                                            ),
                                            // padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: Text(
                                                'รายละเอียดบิล',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            // padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'ลำดับ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'กำหนดชำระ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'รายการ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'จำนวน',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'หน่วย',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'VAT(฿)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'WHT(฿)',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 50,
                                            color: Colors.brown[200],
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child: AutoSizeText(
                                                minFontSize: 10,
                                                maxFontSize: 15,
                                                maxLines: 1,
                                                'ยอดสุทธิ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        PeopleChaoScreen_Color
                                                            .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T
                                                    //fontSize: 10.0
                                                    //fontSize: 10.0
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 290,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                        // border: Border.all(
                                        //     color: Colors.grey, width: 1),
                                      ),
                                      child: ListView.builder(
                                        controller: _scrollController2,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _TransModels.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${index + 1}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransModels[index].date} 00:00:00'))}', //${_TransModels[index].date}
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransModels[index].name}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransModels[index].tqty}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransModels[index].unit_con}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransModels[index].vat}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${nFormat.format(double.parse(_TransModels[index].wht!))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${nFormat.format(double.parse(_TransModels[index].pvat!))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                // Expanded(
                                                //     flex: 1,
                                                //     child: IconButton(
                                                //         onPressed: () {
                                                //           de_Trans_select(index);
                                                //         },
                                                //         icon: const Icon(
                                                //             Icons.remove_circle))),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.52
                                            : 600,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.Sub_Abg_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                color: Colors.grey.shade300,
                                                // height: 100,
                                                width: 300,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'รวม(บาท)',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_pvat)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ภาษีมูลค่าเพิ่ม(vat)',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_vat)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'หัก ณ ที่จ่าย',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_wht)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ยอดรวม',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          children: [
                                                            const AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              'ส่วนลด',
                                                              style: TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              width: 60,
                                                              height: 20,
                                                              child:
                                                                  TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                controller:
                                                                    sum_dispx,
                                                                onChanged:
                                                                    (value) async {
                                                                  var valuenum =
                                                                      double.parse(
                                                                          value);
                                                                  var sum =
                                                                      ((sum_amt *
                                                                              valuenum) /
                                                                          100);

                                                                  setState(() {
                                                                    discount_ =
                                                                        '${valuenum.toString()}';
                                                                    sum_dis =
                                                                        sum;
                                                                    sum_disamt =
                                                                        sum;
                                                                    sum_disamtx
                                                                            .text =
                                                                        sum.toString();
                                                                    Form_payment1
                                                                        .text = (sum_amt -
                                                                            sum_disamt)
                                                                        .toStringAsFixed(
                                                                            2)
                                                                        .toString();
                                                                  });

                                                                  print(
                                                                      'sum_dis $sum_dis   /////// ${valuenum.toString()}');
                                                                },
                                                                cursorColor:
                                                                    Colors
                                                                        .black,
                                                                decoration: InputDecoration(
                                                                    fillColor: Colors.white.withOpacity(0.3),
                                                                    filled: true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder: const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        bottomRight:
                                                                            Radius.circular(5),
                                                                        bottomLeft:
                                                                            Radius.circular(5),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(5),
                                                                        topLeft:
                                                                            Radius.circular(5),
                                                                        bottomRight:
                                                                            Radius.circular(5),
                                                                        bottomLeft:
                                                                            Radius.circular(5),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    // labelText: 'ระบุชื่อร้านค้า',
                                                                    labelStyle: const TextStyle(
                                                                        color: Colors.black54,
                                                                        fontSize: 8,

                                                                        //fontWeight: FontWeight.bold,
                                                                        fontFamily: Font_.Fonts_T)),
                                                                inputFormatters: <
                                                                    TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          r'[0-9 .]')),
                                                                  // FilteringTextInputFormatter.digitsOnly
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const AutoSizeText(
                                                              minFontSize: 10,
                                                              maxFontSize: 15,
                                                              '%',
                                                              style: TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            showCursor: true,
                                                            //add this line
                                                            readOnly: false,

                                                            // initialValue: sum_disamt.text,
                                                            textAlign:
                                                                TextAlign.end,
                                                            controller:
                                                                sum_disamtx,
                                                            onChanged:
                                                                (value) async {
                                                              print(
                                                                  '>>>>>$value<<<<<<${sum_disamtx.text}<<<< ${value.isEmpty}<<<');
                                                              var valuenum =
                                                                  double.parse(
                                                                      value);

                                                              setState(() {
                                                                sum_dis =
                                                                    valuenum;
                                                                sum_disamt =
                                                                    valuenum;

                                                                // sum_disamt.text =
                                                                //     nFormat.format(sum_disamt);
                                                                sum_dispx
                                                                    .clear();
                                                                Form_payment1
                                                                    .text = (sum_amt -
                                                                        sum_disamt)
                                                                    .toStringAsFixed(
                                                                        2)
                                                                    .toString();
                                                              });

                                                              print(
                                                                  'sum_dis $sum_dis');
                                                            },
                                                            cursorColor:
                                                                Colors.black,
                                                            decoration: InputDecoration(
                                                                fillColor: Colors.white.withOpacity(0.3),
                                                                filled: true,
                                                                // prefixIcon:
                                                                //     const Icon(Icons.person, color: Colors.black),
                                                                // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                focusedBorder: const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                enabledBorder: const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    // width: 1,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                // labelText: 'ระบุชื่อร้านค้า',
                                                                labelStyle: const TextStyle(
                                                                    color: Colors.black54,
                                                                    fontSize: 8,

                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T)),
                                                            inputFormatters: <
                                                                TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9 .]')),
                                                              // FilteringTextInputFormatter.digitsOnly
                                                            ],
                                                          ),
                                                        ),
                                                        // AutoSizeText(
                                                        //   minFontSize: 10,
                                                        //   maxFontSize: 15,
                                                        //   textAlign: TextAlign.end,
                                                        //   '${nFormat.format(0.00)}',
                                                        //   style: TextStyle(
                                                        //       color: PeopleChaoScreen_Color
                                                        //           .Colors_Text2_,
                                                        //       //fontWeight: FontWeight.bold,
                                                        //       fontFamily: Font_.Fonts_T),
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ยอดชำระ',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt - double.parse(sum_disamtx.text))}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ])),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              'รายละเอียดบิล',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontWeight_.Fonts_T
                                  //fontSize: 10.0
                                  //fontSize: 10.0
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                })),
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
                            setState(() {});
                            Navigator.pop(context, 'OK');
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
                      setState(() {});
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

  Widget BodyStatus2_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width * 0.85
                : 1200,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              children: [
                Container(
                    width: (Responsive.isDesktop(context))
                        ? MediaQuery.of(context).size.width * 0.85
                        : 1200,
                    child: Column(
                      children: [
                        ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          }),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            dragStartBehavior: DragStartBehavior.start,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85
                                            : 1200,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลขที่สัญญา',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  'รหัสพื้นที่',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ชื่อร้านค้า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ผู้เช่า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ระยะเวลาเช่า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  'วันเริ่มสัญญา',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ค้างชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
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
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width: (Responsive.isDesktop(context))
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85
                                              : 1200,
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: teNantModels.isEmpty
                                              ? SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CircularProgressIndicator(),
                                                      StreamBuilder(
                                                        stream: Stream.periodic(
                                                            const Duration(
                                                                milliseconds:
                                                                    25),
                                                            (i) => i),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot.hasData)
                                                            return const Text(
                                                                '');
                                                          double elapsed = double
                                                                  .parse(snapshot
                                                                      .data
                                                                      .toString()) *
                                                              0.05;
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: (elapsed >
                                                                    8.00)
                                                                ? const Text(
                                                                    'ไม่พบข้อมูล',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  )
                                                                : Text(
                                                                    'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                    // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : ListView.builder(
                                                  controller:
                                                      _scrollController2,
                                                  // itemExtent: 50,
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      teNantModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      color: tappedIndex_ ==
                                                              index.toString()
                                                          ? tappedIndex_Color
                                                              .tappedIndex_Colors
                                                              .withOpacity(0.5)
                                                          : null,
                                                      child: ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              tappedIndex_ = index
                                                                  .toString();

                                                              if (teNantcid !=
                                                                  null) {
                                                                teNantcid =
                                                                    null;
                                                              } else {
                                                                teNantcid =
                                                                    teNantModels[
                                                                            index]
                                                                        .cid;
                                                                teNantsname =
                                                                    teNantModels[
                                                                            index]
                                                                        .sname;
                                                                teNantnamenew =
                                                                    teNantModels[
                                                                            index]
                                                                        .cname;
                                                              }
                                                            });

                                                            setState(() {
                                                              Form_nameshop =
                                                                  teNantModels[
                                                                          index]
                                                                      .sname
                                                                      .toString();
                                                              Form_typeshop =
                                                                  teNantModels[
                                                                          index]
                                                                      .stype
                                                                      .toString();
                                                              Form_bussshop =
                                                                  teNantModels[
                                                                          index]
                                                                      .cname
                                                                      .toString();
                                                              Form_bussscontact =
                                                                  teNantModels[
                                                                          index]
                                                                      .attn
                                                                      .toString();
                                                              Form_address =
                                                                  teNantModels[
                                                                          index]
                                                                      .addr
                                                                      .toString();
                                                              Form_tel =
                                                                  teNantModels[
                                                                          index]
                                                                      .tel
                                                                      .toString();
                                                              Form_email =
                                                                  teNantModels[
                                                                          index]
                                                                      .email
                                                                      .toString();
                                                              Form_tax = teNantModels[
                                                                              index]
                                                                          .tax ==
                                                                      null
                                                                  ? "-"
                                                                  : teNantModels[
                                                                          index]
                                                                      .tax
                                                                      .toString();
                                                              Form_area =
                                                                  teNantModels[
                                                                          index]
                                                                      .area
                                                                      .toString();
                                                              Form_ln =
                                                                  teNantModels[
                                                                          index]
                                                                      .area_c
                                                                      .toString();

                                                              Form_sdate = DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .parse(
                                                                          '${teNantModels[index].sdate} 00:00:00'))
                                                                  .toString();
                                                              Form_ldate = DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .parse(
                                                                          '${teNantModels[index].ldate} 00:00:00'))
                                                                  .toString();
                                                              Form_period =
                                                                  teNantModels[
                                                                          index]
                                                                      .period
                                                                      .toString();
                                                              Form_rtname =
                                                                  teNantModels[
                                                                          index]
                                                                      .rtname
                                                                      .toString();
                                                              Form_docno =
                                                                  teNantModels[
                                                                          index]
                                                                      .docno
                                                                      .toString();
                                                              Form_zn =
                                                                  teNantModels[
                                                                          index]
                                                                      .zn
                                                                      .toString();
                                                              Form_aser =
                                                                  teNantModels[
                                                                          index]
                                                                      .aser
                                                                      .toString();
                                                              Form_qty =
                                                                  teNantModels[
                                                                          index]
                                                                      .qty
                                                                      .toString();
                                                            });
                                                          },
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${teNantModels[index].cid}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: AccountScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${teNantModels[index].ln_c}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: AccountScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${teNantModels[index].sname}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: AccountScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                      //fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${teNantModels[index].cname}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${teNantModels[index].period} / ${teNantModels[index].rtname}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${DateFormat('dd-MM').format(DateTime.parse('${teNantModels[index].sdate} 00:00:00'))}-${DateTime.parse('${teNantModels[index].sdate} 00:00:00').year + 543}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: AccountScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  '${DateFormat('dd-MM').format(DateTime.parse('${teNantModels[index].ldate} 00:00:00'))}-${DateTime.parse('${teNantModels[index].ldate} 00:00:00').year + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  teNantModels[index]
                                                                              .count_bill ==
                                                                          null
                                                                      ? '0 รายการ'
                                                                      : '${teNantModels[index].count_bill} รายการ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
                                                                    //fontSize: 10.0
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    );
                                                  })),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.85
                                : MediaQuery.of(context).size.width,
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
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                // color: AppbackgroundColor
                                                //     .TiTile_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(8)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                'Top',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T,
                                                ),
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
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              // color: AppbackgroundColor
                                              //     .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Down',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontFamily: FontWeight_.Fonts_T,
                                              ),
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Scroll',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontFamily: FontWeight_.Fonts_T,
                                            ),
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
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ทำรายการรับชำระ',
                  style: TextStyle(
                    color: AccountScreen_Color.Colors_Text1_,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontWeight_.Fonts_T,
                  ),
                ),
              ),
            ),
          ),
          teNantcid == null
              ? const SizedBox()
              : Pays(
                  Get_Value_cid: teNantcid,
                  Get_Value_NameShop_index: teNantsname,
                  namenew: teNantnamenew,
                  Screen_name: 'ACSceen',
                  Form_bussshop: '${Form_bussshop}',
                  Form_address: '${Form_address}',
                  Form_tax: '${Form_tax}'),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  //////////////////////////////////------------------------->(รายงานประวัติบิล)
  void _exportExcel_() async {
    String day_ =
        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

    String Tim_ =
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    final x.Workbook workbook = x.Workbook();

    final x.Worksheet sheet = workbook.worksheets[0];
    sheet.pageSetup.topMargin = 1;
    sheet.pageSetup.bottomMargin = 1;
    sheet.pageSetup.leftMargin = 1;
    sheet.pageSetup.rightMargin = 1;

    //Adding a picture
    // final ByteData bytes_image = await rootBundle.load('images/LOGO.png');
    // final Uint8List image = bytes_image.buffer
    //     .asUint8List(bytes_image.offsetInBytes, bytes_image.lengthInBytes);
// Adding an image.
    // sheet.pictures.addStream(1, 1, image);
    // final x.Picture picture = sheet.pictures[0];

// Re-size an image
    // picture.height = 30;
    // picture.width = 50;

// // rotate an image.
//     picture.rotation = 100;

// // Flip an image.
//     picture.horizontalFlip = true;
    x.Style globalStyle = workbook.styles.add('style');
    globalStyle.fontName = 'Angsana New';
    globalStyle.numberFormat = '_(\$* #,##0_)';
    globalStyle.fontSize = 20;

    globalStyle.backColorRgb = const Color.fromARGB(255, 252, 255, 251);
    x.Style globalStyle2 = workbook.styles.add('style1');
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
    final x.Range range = sheet.getRangeByName('E2');
    range.setText('ประวัติบิล($day_)');
// ExcelSheetProtectionOption
    final x.ExcelSheetProtectionOption options = x.ExcelSheetProtectionOption();
    options.all = true;

// Protecting the Worksheet by using a Password

    sheet.getRangeByName('A2').cellStyle = globalStyle;
    sheet.getRangeByName('B2').cellStyle = globalStyle;
    sheet.getRangeByName('C2').cellStyle = globalStyle;
    sheet.getRangeByName('D2').cellStyle = globalStyle;
    sheet.getRangeByName('E2').cellStyle = globalStyle;
    sheet.getRangeByName('F2').cellStyle = globalStyle;
    sheet.getRangeByName('G2').cellStyle = globalStyle;
    sheet.getRangeByName('H2').cellStyle = globalStyle;
    sheet.getRangeByName('I2').cellStyle = globalStyle;
    sheet.getRangeByName('J2').cellStyle = globalStyle;
    sheet.getRangeByName('A2').setText('${renTal_name}');
    sheet.getRangeByName('J1').setText('วันที่: ${day_}');

    sheet.getRangeByName('A3').cellStyle = globalStyle;
    sheet.getRangeByName('B3').cellStyle = globalStyle;
    sheet.getRangeByName('C3').cellStyle = globalStyle;
    sheet.getRangeByName('D3').cellStyle = globalStyle;
    sheet.getRangeByName('E3').cellStyle = globalStyle;
    sheet.getRangeByName('F3').cellStyle = globalStyle;
    sheet.getRangeByName('G3').cellStyle = globalStyle;
    sheet.getRangeByName('H3').cellStyle = globalStyle;
    sheet.getRangeByName('I3').cellStyle = globalStyle;
    sheet.getRangeByName('J3').cellStyle = globalStyle;
    sheet.getRangeByName('J2').setText('เวลา: ${Tim_}');
    globalStyle2.hAlign = x.HAlignType.center;
    sheet.getRangeByName('A4').cellStyle = globalStyle2;
    sheet.getRangeByName('B4').cellStyle = globalStyle2;
    sheet.getRangeByName('C4').cellStyle = globalStyle2;
    sheet.getRangeByName('D4').cellStyle = globalStyle2;
    sheet.getRangeByName('E4').cellStyle = globalStyle2;
    sheet.getRangeByName('F4').cellStyle = globalStyle2;
    sheet.getRangeByName('G4').cellStyle = globalStyle2;
    sheet.getRangeByName('H4').cellStyle = globalStyle2;
    sheet.getRangeByName('I4').cellStyle = globalStyle2;
    sheet.getRangeByName('J4').cellStyle = globalStyle2;
    sheet.getRangeByName('A4').columnWidth = 10;
    sheet.getRangeByName('B4').columnWidth = 18;
    sheet.getRangeByName('C4').columnWidth = 18;
    sheet.getRangeByName('D4').columnWidth = 18;
    sheet.getRangeByName('E4').columnWidth = 18;
    sheet.getRangeByName('F4').columnWidth = 18;
    sheet.getRangeByName('G4').columnWidth = 18;
    sheet.getRangeByName('H4').columnWidth = 18;
    sheet.getRangeByName('I4').columnWidth = 18;
    sheet.getRangeByName('J4').columnWidth = 18;

    sheet.getRangeByName('A4').setText('เลขที่สัญญา');
    sheet.getRangeByName('B4').setText('วันที้ทำรายการ');
    sheet.getRangeByName('C4').setText('วันที่รับชำระ');
    sheet.getRangeByName('D4').setText('เลขที่ใบเสร็จ');
    sheet.getRangeByName('E4').setText('เลขที่ใบวางบิล');
    sheet.getRangeByName('F4').setText('รหัสพื้นที่');
    sheet.getRangeByName('G4').setText('ชื่อร้านค้า');
    sheet.getRangeByName('H4').setText('จำนวนเงิน');
    sheet.getRangeByName('I4').setText('กำหนดชำระ');
    sheet.getRangeByName('J4').setText('สถานะ');

    for (int index = 0; index < _TransReBillModels.length; index++) {
      sheet.getRangeByName('A${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('B${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('C${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('D${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('E${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('F${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('G${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('H${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('I${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('J${index + 5}').cellStyle = globalStyle;
      sheet.getRangeByName('A${index + 5}').setText(
            '${_TransReBillModels[index].cid}',
          );
      sheet.getRangeByName('B${index + 5}').setText(
            '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].daterec} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].daterec} 00:00:00').year + 543}',
          );
      sheet.getRangeByName('C${index + 5}').setText(
            '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].dateacc} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].dateacc} 00:00:00').year + 543}',
          );
      sheet.getRangeByName('D${index + 5}').setText(
            _TransReBillModels[index].doctax == ''
                ? '${_TransReBillModels[index].docno}'
                : '${_TransReBillModels[index].doctax}',
          );
      sheet.getRangeByName('E${index + 5}').setText(
            '${_TransReBillModels[index].inv}',
          );
      sheet.getRangeByName('F${index + 5}').setText(
            _TransReBillModels[index].ln == null
                ? '${_TransReBillModels[index].room_number}'
                : '${_TransReBillModels[index].ln}',
          );
      sheet.getRangeByName('G${index + 5}').setText(
            _TransReBillModels[index].sname == null
                ? '${_TransReBillModels[index].remark}'
                : '${_TransReBillModels[index].sname}',
          );
      sheet.getRangeByName('H${index + 5}').setText(
            _TransReBillModels[index].total_dis == null
                ? '${_TransReBillModels[index].total_bill}'
                : '${_TransReBillModels[index].total_dis}',
          );
      sheet.getRangeByName('I${index + 5}').setText(
            '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].date} 00:00:00').year + 543}',
          );
      sheet.getRangeByName('J${index + 5}').setText(
            _TransReBillModels[index].doctax == '' ? ' ' : 'ใบกำกับภาษี',
          );
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.MICROSOFTEXCEL;
    String path = await FileSaver.instance
        .saveFile("ประวัติบิล($day_)", data, "xlsx", mimeType: type);
    log(path);
    // if (_verticalGroupValue_NameFile.toString() == 'จากระบบ') {
    //   String path = await FileSaver.instance.saveFile(
    //       "ผู้เช่า(${Status[Status_ - 1]})(ณ วันที่${day_})", data, "xlsx",
    //       mimeType: type);
    //   log(path);
    // } else {
    //   String path = await FileSaver.instance
    //       .saveFile("$NameFile_", data, "xlsx", mimeType: type);
    //   log(path);
    // }
  }

//////////----------------------------------------------------------------->
//////////////////-------------------------------------------------->
  ///
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<FinnancetransModel> finnancetransModels = [];

  Future<Null> red_Invoice(index) async {
    if (finnancetransModels.length != 0) {
      setState(() {
        finnancetransModels.clear();
        sum_disamt = 0;
        sum_disp = 0;
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = _TransReBillModels[index].ser;
    var qutser = _TransReBillModels[index].ser_in;
    var docnoin = _TransReBillModels[index].docno;
    print('>>>>>>>>>>>dd>>> in d  $docnoin');

    String url =
        '${MyConstant().domain}/GC_bill_pay_amt.php?isAdd=true&ren=$ren&ciddoc=$ciddoc&docnoin=$docnoin';
    try {
      var response = await http.get(Uri.parse(url));
      var result = json.decode(response.body);
      print('BBBBBBBBBBBBBBBB>>>> $result');
      if (result.toString() != 'null') {
        for (var map in result) {
          FinnancetransModel finnancetransModel =
              FinnancetransModel.fromJson(map);

          var sidamt = double.parse(finnancetransModel.amt!);
          var siddisper = double.parse(finnancetransModel.disper!);
          var pdatex = finnancetransModel.pdate;
          print('>>>>>>>>>>>dd>>> in $sidamt $siddisper');
          setState(() {
            if (int.parse(finnancetransModel.receiptSer!) != 0) {
              finnancetransModels.add(finnancetransModel);
              pdate = pdatex;
            } else {
              if (finnancetransModel.type!.trim() == 'DISCOUNT') {
                sum_disamt = sidamt;
                sum_disp = siddisper;
              }
            }
          });
        }
      }
    } catch (e) {}
  }

  Future<Null> red_Trans_select(index) async {
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
          });
        }
      }
      // setState(() {
      //   red_Invoice();
      // });
    } catch (e) {}
  }

  Widget BodyStatus3_Web() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: (Responsive.isDesktop(context))
                ? MediaQuery.of(context).size.width * 0.85
                : 1200,
            decoration: const BoxDecoration(
              color: AppbackgroundColor.Sub_Abg_Colors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              // border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              children: [
                Container(
                    width: (Responsive.isDesktop(context))
                        ? MediaQuery.of(context).size.width * 0.85
                        : 1200,
                    child: Column(
                      children: [
                        ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          }),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            dragStartBehavior: DragStartBehavior.start,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: (Responsive.isDesktop(context))
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85
                                            : 1200,
                                        decoration: const BoxDecoration(
                                          color:
                                              AppbackgroundColor.TiTile_Colors,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0)),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลขที่สัญญา',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  'วันที่ทำรายการ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'วันที่รับชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลขที่ใบเสร็จ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'เลขที่ใบวางบิล',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  'รหัสพื้นที่',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ชื่อร้านค้า',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'จำนวนเงิน',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'กำหนดชำระ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T,
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
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AccountScreen_Color
                                                        .Colors_Text1_,
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
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.7,
                                          width: (Responsive.isDesktop(context))
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85
                                              : 1200,
                                          decoration: const BoxDecoration(
                                            color: AppbackgroundColor
                                                .Sub_Abg_Colors,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(0)),
                                            // border: Border.all(color: Colors.grey, width: 1),
                                          ),
                                          child: _TransReBillModels.isEmpty
                                              ? SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CircularProgressIndicator(),
                                                      StreamBuilder(
                                                        stream: Stream.periodic(
                                                            const Duration(
                                                                milliseconds:
                                                                    25),
                                                            (i) => i),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot.hasData)
                                                            return const Text(
                                                                '');
                                                          double elapsed = double
                                                                  .parse(snapshot
                                                                      .data
                                                                      .toString()) *
                                                              0.05;
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: (elapsed >
                                                                    8.00)
                                                                ? const Text(
                                                                    'ไม่พบข้อมูล',
                                                                    style: TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  )
                                                                : Text(
                                                                    'ดาวน์โหลด : ${elapsed.toStringAsFixed(2)} s.',
                                                                    // 'Time : ${elapsed.toStringAsFixed(2)} seconds',
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T
                                                                        //fontSize: 10.0
                                                                        ),
                                                                  ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : ListView.builder(
                                                  controller:
                                                      _scrollController2,
                                                  // itemExtent: 50,
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      _TransReBillModels.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      color: tappedIndex_ ==
                                                              index.toString()
                                                          ? tappedIndex_Color
                                                              .tappedIndex_Colors
                                                              .withOpacity(0.5)
                                                          : null,
                                                      child: ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              tappedIndex_ = index
                                                                  .toString();
                                                              red_Trans_select(
                                                                  index);
                                                              red_Invoice(
                                                                  index);
                                                            });
                                                            print(
                                                                'objecnort ${_TransReBillModels[index].docno}');
                                                            checkshowDialog(
                                                                index);
                                                          },
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${_TransReBillModels[index].cid}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].daterec} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].daterec} 00:00:00').year + 543}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].pdate} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].pdate} 00:00:00').year + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  _TransReBillModels[index]
                                                                              .doctax ==
                                                                          ''
                                                                      ? '${_TransReBillModels[index].docno}'
                                                                      : '${_TransReBillModels[index].doctax}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
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
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        25,
                                                                    maxLines: 1,
                                                                    '${_TransReBillModels[index].inv}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: PeopleChaoScreen_Color
                                                                            .Colors_Text2_,
                                                                        fontFamily:
                                                                            Font_.Fonts_T),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  _TransReBillModels[index]
                                                                              .ln ==
                                                                          null
                                                                      ? '${_TransReBillModels[index].room_number}'
                                                                      : '${_TransReBillModels[index].ln}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  _TransReBillModels[index]
                                                                              .sname ==
                                                                          null
                                                                      ? '${_TransReBillModels[index].remark}'
                                                                      : '${_TransReBillModels[index].sname}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  _TransReBillModels[index]
                                                                              .total_dis ==
                                                                          null
                                                                      ? '${_TransReBillModels[index].total_bill}'
                                                                      : '${_TransReBillModels[index].total_dis}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  '${DateFormat('dd-MM').format(DateTime.parse('${_TransReBillModels[index].date} 00:00:00'))}-${DateTime.parse('${_TransReBillModels[index].date} 00:00:00').year + 543}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  _TransReBillModels[index]
                                                                              .doctax ==
                                                                          ''
                                                                      ? ' '
                                                                      : 'ใบกำกับภาษี',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: PeopleChaoScreen_Color
                                                                          .Colors_Text2_,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    );
                                                  })),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            width: (Responsive.isDesktop(context))
                                ? MediaQuery.of(context).size.width * 0.85
                                : MediaQuery.of(context).size.width,
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
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                // color: AppbackgroundColor
                                                //     .TiTile_Colors,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(8)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: const Text(
                                                'Top',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              // color: AppbackgroundColor
                                              //     .TiTile_Colors,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      topRight:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6),
                                                      bottomRight:
                                                          Radius.circular(6)),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            padding: const EdgeInsets.all(3.0),
                                            child: const Text(
                                              'Down',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6)),
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                          ),
                                          padding: const EdgeInsets.all(3.0),
                                          child: const Text(
                                            'Scroll',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _exportExcel_();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.file_open, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'export file',
                              style: TextStyle(
                                  color: AccountScreen_Color.Colors_Text2_,
                                  // fontWeight:
                                  //     FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                  fontSize: 10.0),
                            ),
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    List newValuePDFimg = [];
                    for (int index = 0; index < 1; index++) {
                      if (renTalModels[0].imglogo!.trim() == '' ||
                          renTalModels[0].imglogo!.trim() == 'null' ||
                          renTalModels[0].imglogo!.trim() == 'Null') {
                        // newValuePDFimg.add(
                        //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                      } else {
                        newValuePDFimg.add(
                            '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                      }
                    }
                    Pdfgen_historybill.exportPDF_historybill(
                      context,
                      _TransReBillModels,
                      renTal_name,
                      ' ${renTalModels[0].bill_addr}',
                      ' ${renTalModels[0].bill_email}',
                      ' ${renTalModels[0].bill_tel}',
                      ' ${renTalModels[0].bill_tax}',
                      ' ${renTalModels[0].bill_name}',
                      newValuePDFimg,
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.print, color: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'พิมพ์',
                              style: TextStyle(
                                  color: AccountScreen_Color.Colors_Text2_,
                                  // fontWeight:
                                  //     FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                  fontSize: 10.0),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: InkWell(
          //             onTap: () {},
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.orange[200],
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(6),
          //                       topRight: Radius.circular(6),
          //                       bottomLeft: Radius.circular(6),
          //                       bottomRight: Radius.circular(6)),
          //                   border: Border.all(color: Colors.grey, width: 1),
          //                 ),
          //                 child: Row(
          //                   children: const [
          //                     Padding(
          //                       padding: EdgeInsets.all(8.0),
          //                       child: Icon(Icons.cancel_presentation,
          //                           color: Colors.black),
          //                     ),
          //                     Padding(
          //                       padding: EdgeInsets.all(8.0),
          //                       child: Text(
          //                         'ยกเลิกการรับชำระ',
          //                         style: TextStyle(
          //                           color: AccountScreen_Color.Colors_Text2_,
          //                           // fontWeight:
          //                           //     FontWeight.bold,
          //                           fontFamily: Font_.Fonts_T,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: InkWell(
          //             onTap: () {},
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.red[200],
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(6),
          //                       topRight: Radius.circular(6),
          //                       bottomLeft: Radius.circular(6),
          //                       bottomRight: Radius.circular(6)),
          //                   border: Border.all(color: Colors.grey, width: 1),
          //                 ),
          //                 child: Row(
          //                   children: const [
          //                     Padding(
          //                       padding: EdgeInsets.all(8.0),
          //                       child: Icon(Icons.cancel_outlined,
          //                           color: Colors.black),
          //                     ),
          //                     Padding(
          //                       padding: EdgeInsets.all(8.0),
          //                       child: Text(
          //                         'ลดหนี้',
          //                         style: TextStyle(
          //                           color: AccountScreen_Color.Colors_Text2_,
          //                           // fontWeight:
          //                           //     FontWeight.bold,
          //                           fontFamily: Font_.Fonts_T,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: InkWell(
          //             onTap: () {},
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.green[200],
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(6),
          //                       topRight: Radius.circular(6),
          //                       bottomLeft: Radius.circular(6),
          //                       bottomRight: Radius.circular(6)),
          //                   border: Border.all(color: Colors.grey, width: 1),
          //                 ),
          //                 child: Row(
          //                   children: const [
          //                     Padding(
          //                       padding: EdgeInsets.all(8.0),
          //                       child: Icon(Icons.refresh, color: Colors.black),
          //                     ),
          //                     Padding(
          //                       padding: EdgeInsets.all(8.0),
          //                       child: Text(
          //                         'เปลี่ยนสถานะบิล',
          //                         style: TextStyle(
          //                           color: AccountScreen_Color.Colors_Text2_,
          //                           // fontWeight:
          //                           //     FontWeight.bold,
          //                           fontFamily: Font_.Fonts_T,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget BodyStatus4_Web() {
    red_DeC();
    return const LockpayScreen();
  }

  Future<Null> red_DeC() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url =
        '${MyConstant().domain}/DeC_trans_select.php?isAdd=true&ren=$ren&user=$user';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {}
    } catch (e) {}
  }

  ///---------------------------------------------------------------------->
  Future<Null> checkshowDialog(index) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'เลขที่บิล ${_TransReBillModels[index].docno}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          Container(
                              width: (Responsive.isDesktop(context))
                                  ? MediaQuery.of(context).size.width * 0.85
                                  : 1200,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        // padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: Text(
                                            'รายละเอียดบิล', //numinvoice
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                          ),
                                          // border: Border.all(
                                          //     color: Colors.grey, width: 1),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                            // border: Border.all(
                                            //     color: Colors.grey, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'บิลเลขที่ ${_TransReBillModels[index].docno}', //
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        // padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'ลำดับ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'วันที่ชำระ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'กำหนดชำระ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'เลขตั้งหนี้',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'รายการ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'VAT(฿)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'WHT(฿)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: Container(
                                    //     height: 50,
                                    //     color: Colors.brown[200],
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: const Center(
                                    //       child: AutoSizeText(
                                    //         minFontSize: 10,
                                    //         maxFontSize: 15,
                                    //         maxLines: 1,
                                    //         'VAT',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //             color: PeopleChaoScreen_Color
                                    //                 .Colors_Text1_,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontFamily: FontWeight_.Fonts_T
                                    //             //fontSize: 10.0
                                    //             //fontSize: 10.0
                                    //             ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    if (renTal_user.toString() == '65' ||
                                        renTal_user.toString() == '50')
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          color: Colors.brown[200],
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              '70',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (renTal_user.toString() == '65' ||
                                        renTal_user.toString() == '50')
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          color: Colors.brown[200],
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Center(
                                            child: AutoSizeText(
                                              minFontSize: 10,
                                              maxFontSize: 15,
                                              maxLines: 1,
                                              '30',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: PeopleChaoScreen_Color
                                                      .Colors_Text1_,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T
                                                  //fontSize: 10.0
                                                  //fontSize: 10.0
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: Container(
                                    //     height: 50,
                                    //     color: Colors.brown[200],
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: const Center(
                                    //       child: AutoSizeText(
                                    //         minFontSize: 10,
                                    //         maxFontSize: 15,
                                    //         maxLines: 2,
                                    //         'ราคารวมก่อน VAT',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //             color: PeopleChaoScreen_Color
                                    //                 .Colors_Text1_,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontFamily: FontWeight_.Fonts_T
                                    //             //fontSize: 10.0
                                    //             //fontSize: 10.0
                                    //             ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        color: Colors.brown[200],
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Center(
                                          child: AutoSizeText(
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 1,
                                            'ยอดสุทธิ',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: FontWeight_.Fonts_T
                                                //fontSize: 10.0
                                                //fontSize: 10.0
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 220,
                                  decoration: const BoxDecoration(
                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    // border: Border.all(
                                    //     color: Colors.grey, width: 1),
                                  ),
                                  child: StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(seconds: 0)),
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        controller: _scrollController2,
                                        // itemExtent: 50,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            _TransReBillHistoryModels.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${index + 1}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransReBillHistoryModels[index].date}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransReBillHistoryModels[index].date}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransReBillHistoryModels[index].docno}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransReBillHistoryModels[index].expname}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransReBillHistoryModels[index].vat}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${_TransReBillHistoryModels[index].wht}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: AutoSizeText(
                                                //     minFontSize: 10,
                                                //     maxFontSize: 15,
                                                //     maxLines: 1,
                                                //     '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                                //     textAlign:
                                                //         TextAlign.center,
                                                //     style: const TextStyle(
                                                //         color:
                                                //             PeopleChaoScreen_Color
                                                //                 .Colors_Text2_,
                                                //         //fontWeight: FontWeight.bold,
                                                //         fontFamily:
                                                //             Font_.Fonts_T),
                                                //   ),
                                                // ),
                                                if (renTal_user.toString() ==
                                                        '65' ||
                                                    renTal_user.toString() ==
                                                        '50')
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 50,
                                                      // color: Colors.brown[200],
                                                      // padding:
                                                      //     const EdgeInsets.all(
                                                      //         8.0),
                                                      child: Center(
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          maxLines: 1,
                                                          (_TransReBillHistoryModels[
                                                                          index]
                                                                      .ramt
                                                                      .toString() ==
                                                                  'null')
                                                              ? '-'
                                                              : '${_TransReBillHistoryModels[index].ramt}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: const TextStyle(
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
                                                  ),
                                                if (renTal_user.toString() ==
                                                        '65' ||
                                                    renTal_user.toString() ==
                                                        '50')
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 50,
                                                      // color: Colors.brown[200],
                                                      // padding:
                                                      //     const EdgeInsets.all(
                                                      //         8.0),
                                                      child: Center(
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          maxLines: 1,
                                                          (_TransReBillHistoryModels[
                                                                          index]
                                                                      .ramtd
                                                                      .toString() ==
                                                                  'null')
                                                              ? '-'
                                                              : '${_TransReBillHistoryModels[index].ramtd}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: const TextStyle(
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
                                                  ),
                                                // Expanded(
                                                //   flex: 1,
                                                //   child: AutoSizeText(
                                                //     minFontSize: 10,
                                                //     maxFontSize: 15,
                                                //     maxLines: 1,
                                                //     '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                                //     textAlign:
                                                //         TextAlign.center,
                                                //     style: const TextStyle(
                                                //         color:
                                                //             PeopleChaoScreen_Color
                                                //                 .Colors_Text2_,
                                                //         //fontWeight: FontWeight.bold,
                                                //         fontFamily:
                                                //             Font_.Fonts_T),
                                                //   ),
                                                // ),
                                                Expanded(
                                                  flex: 1,
                                                  child: AutoSizeText(
                                                    minFontSize: 10,
                                                    maxFontSize: 15,
                                                    maxLines: 1,
                                                    '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: (Responsive.isDesktop(context))
                                        ? MediaQuery.of(context).size.width *
                                            0.85
                                        : 1200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          // height: 50,
                                          // color: Colors.red,
                                          child: StreamBuilder(
                                              stream: Stream.periodic(
                                                  const Duration(seconds: 0)),
                                              builder: (context, snapshot) {
                                                return Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight:
                                                            //     FontWeight
                                                            //         .bold,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'รูปแบบการชำระ',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text1_,
                                                            // fontWeight:
                                                            //     FontWeight
                                                            //         .bold,
                                                            fontFamily:
                                                                Font_.Fonts_T
                                                            //fontSize: 10.0
                                                            ),
                                                      ),
                                                    ),
                                                    for (var i = 0;
                                                        i <
                                                            finnancetransModels
                                                                .length;
                                                        i++)
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          // minFontSize: 10,
                                                          // maxFontSize: 15,
                                                          '${i + 1}.(${finnancetransModels[i].type}) จำนวน ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              }),
                                        ),
                                        Container(
                                          width: 350,
                                          // height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0)),
                                          ),
                                          child: StreamBuilder(
                                            stream: Stream.periodic(
                                                const Duration(seconds: 0)),
                                            builder: (context, snapshot) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'รวม(บาท)',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_pvat)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ภาษีมูลค่าเพิ่ม(vat)',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_vat)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'หัก ณ ที่จ่าย',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_wht)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ยอดรวม',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ส่วนลด $sum_disp  %',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          '${nFormat.format(sum_disamt)}',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          'ยอดชำระ',
                                                          style: TextStyle(
                                                              color: PeopleChaoScreen_Color
                                                                  .Colors_Text2_,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: Font_
                                                                  .Fonts_T),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        // flex: 1,
                                                        child: AutoSizeText(
                                                          minFontSize: 10,
                                                          maxFontSize: 15,
                                                          textAlign:
                                                              TextAlign.end,
                                                          '${nFormat.format(sum_amt - sum_disamt)}',
                                                          style:
                                                              const TextStyle(
                                                                  color: PeopleChaoScreen_Color
                                                                      .Colors_Text2_,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: Font_
                                                                      .Fonts_T),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.85
                                      : 1200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 200,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                title: const Center(
                                                    child: Text(
                                                  'ยกเลิกการรับชำระ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                )),
                                                content: Container(
                                                  height: 120,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 2.0,
                                                      ),
                                                      Text(
                                                        'บิลเลขที่ ${_TransReBillModels[index].docno}',
                                                        style: const TextStyle(
                                                            color: AccountScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              Formbecause_,
                                                          validator: (value) {
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
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.3),
                                                                  filled: true,
                                                                  // prefixIcon: const Icon(Icons.water,
                                                                  //     color: Colors.blue),
                                                                  // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              15),
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              15),
                                                                      topLeft: Radius
                                                                          .circular(
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
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  labelText:
                                                                      'หมายเหตุ',
                                                                  labelStyle:
                                                                      const TextStyle(
                                                                    color: AccountScreen_Color
                                                                        .Colors_Text2_,
                                                                    // fontWeight:
                                                                    //     FontWeight.bold,
                                                                    fontFamily:
                                                                        Font_
                                                                            .Fonts_T,
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
                                                        height: 5.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 150,
                                                      height: 40,
                                                      // ignore: deprecated_member_use
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          String Formbecause =
                                                              Formbecause_.text
                                                                  .toString();
                                                          if (Formbecause ==
                                                              '') {
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.0))),
                                                                title:
                                                                    const Center(
                                                                        child:
                                                                            Text(
                                                                  'กรุณากรอกเหตุผล !!',
                                                                  style: TextStyle(
                                                                      color: AdminScafScreen_Color
                                                                          .Colors_Text1_,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          FontWeight_
                                                                              .Fonts_T),
                                                                )),
                                                                actions: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Colors.redAccent,
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                topRight: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(10),
                                                                                bottomRight: Radius.circular(10)),
                                                                          ),
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'OK'),
                                                                            child:
                                                                                const Text(
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
                                                            pPC_finantIbill(
                                                                Formbecause);
                                                            setState(() {
                                                              Formbecause_
                                                                  .clear();
                                                            });
                                                            Navigator.pop(
                                                                context, 'OK');
                                                          }
                                                        },
                                                        child: const Text(
                                                          'ยืนยัน',
                                                          style: TextStyle(
                                                            // fontSize: 20.0,
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 150,
                                                      height: 40,
                                                      // ignore: deprecated_member_use
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            Formbecause_
                                                                .clear();
                                                          });
                                                          Navigator.pop(
                                                              context, 'OK');
                                                        },
                                                        child: const Text(
                                                          'ปิด',
                                                          style: TextStyle(
                                                            // fontSize: 20.0,
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        // color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.orange[200],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'ยกเลิกการรับชำระ',
                                                      style: TextStyle(
                                                        color:
                                                            AccountScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      _TransReBillModels[index].doctax == ''
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              width: 200,
                                              child: InkWell(
                                                onTap: () {
                                                  List newValuePDFimg = [];
                                                  for (int index = 0;
                                                      index < 1;
                                                      index++) {
                                                    if (renTalModels[0]
                                                            .imglogo!
                                                            .trim() ==
                                                        '') {
                                                      // newValuePDFimg.add(
                                                      //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                                    } else {
                                                      newValuePDFimg.add(
                                                          '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                                    }
                                                  }
                                                  final tableData00 = [
                                                    for (int index = 0;
                                                        index <
                                                            _TransReBillHistoryModels
                                                                .length;
                                                        index++)
                                                      [
                                                        '${index + 1}',
                                                        '${_TransReBillHistoryModels[index].date}',
                                                        '${_TransReBillHistoryModels[index].expname}',
                                                        '${_TransReBillHistoryModels[index].nvat}',
                                                        '${_TransReBillHistoryModels[index].vtype}',
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                      ],
                                                  ];
                                                  String sname = _TransReBillModels[
                                                                  index]
                                                              .sname ==
                                                          null
                                                      ? '${_TransReBillModels[index].remark}'
                                                      : '${_TransReBillModels[index].sname}';
                                                  String cname =
                                                      '${_TransReBillModels[index].cname}';
                                                  String addr =
                                                      '${_TransReBillModels[index].addr}';
                                                  String tax =
                                                      '${_TransReBillModels[index].tax}';

                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      title: const Center(
                                                          child: Text(
                                                        'เปลี่ยนเป็นใบกำกับภาษีหรือไม่',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                FontWeight_
                                                                    .Fonts_T),
                                                      )),
                                                      content: Container(
                                                        height: 120,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 2.0,
                                                            ),
                                                            Text(
                                                              'บิลเลขที่ ${_TransReBillModels[index].docno}',
                                                              style:
                                                                  const TextStyle(
                                                                      color: AccountScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T),
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 150,
                                                            height: 40,
                                                            // ignore: deprecated_member_use
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                              ),
                                                              onPressed: () {
                                                                // Navigator.pop(
                                                                //     context,
                                                                //     'OK');
                                                                pPC_finantIbillREbill(
                                                                    tableData00,
                                                                    sname,
                                                                    cname,
                                                                    addr,
                                                                    tax,
                                                                    newValuePDFimg,
                                                                    finnancetransModels);
                                                              },
                                                              child: const Text(
                                                                'ยืนยัน',
                                                                style:
                                                                    TextStyle(
                                                                  // fontSize: 20.0,
                                                                  // fontWeight: FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              // color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 150,
                                                            height: 40,
                                                            // ignore: deprecated_member_use
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    'OK');
                                                              },
                                                              child: const Text(
                                                                'ปิด',
                                                                style:
                                                                    TextStyle(
                                                                  // fontSize: 20.0,
                                                                  // fontWeight: FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              // color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[200],
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(6),
                                                              topRight: Radius
                                                                  .circular(6),
                                                              bottomLeft: Radius
                                                                  .circular(6),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Icon(
                                                              Icons.refresh,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'เปลี่ยนสถานะบิล',
                                                            style: TextStyle(
                                                              color: AccountScreen_Color
                                                                  .Colors_Text2_,
                                                              // fontWeight:
                                                              //     FontWeight.bold,
                                                              fontFamily:
                                                                  Font_.Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            )
                                          : const SizedBox(),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 200,
                                        child: InkWell(
                                          onTap: () {
                                            Insert_log.Insert_logs('บัญชี',
                                                'ประวัติบิล>>ลดหนี้(${_TransReBillModels[index].docno})');
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red[200],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'ลดหนี้',
                                                      style: TextStyle(
                                                        color:
                                                            AccountScreen_Color
                                                                .Colors_Text2_,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 200,
                                        child: InkWell(
                                          onTap: () {
                                            List newValuePDFimg = [];
                                            for (int index = 0;
                                                index < 1;
                                                index++) {
                                              if (renTalModels[0]
                                                      .imglogo!
                                                      .trim() ==
                                                  '') {
                                                // newValuePDFimg.add(
                                                //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                              } else {
                                                newValuePDFimg.add(
                                                    '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                              }
                                            }
                                            final tableData00 = [
                                              for (int index = 0;
                                                  index <
                                                      _TransReBillHistoryModels
                                                          .length;
                                                  index++)
                                                [
                                                  '${index + 1}',
                                                  '${_TransReBillHistoryModels[index].date}',
                                                  '${_TransReBillHistoryModels[index].expname}',
                                                  '${_TransReBillHistoryModels[index].nvat}',
                                                  '${_TransReBillHistoryModels[index].vtype}',
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].vat!))}',
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].amt!))}',
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                ],
                                            ];
                                            String sname = _TransReBillModels[
                                                            index]
                                                        .sname ==
                                                    null
                                                ? '${_TransReBillModels[index].remark}'
                                                : '${_TransReBillModels[index].sname}';
                                            String cname =
                                                '${_TransReBillModels[index].cname}';
                                            String addr =
                                                '${_TransReBillModels[index].addr}';
                                            String tax =
                                                '${_TransReBillModels[index].tax}';
                                            Pdfgen_his_statusbill
                                                .exportPDF_statusbill(
                                                    tableData00,
                                                    context,
                                                    _TransReBillHistoryModels,
                                                    'Num_cid',
                                                    'Namenew',
                                                    sum_pvat,
                                                    sum_vat,
                                                    sum_wht,
                                                    sum_amt,
                                                    sum_disp,
                                                    sum_disamt,
                                                    '${sum_amt - sum_disamt}',
                                                    renTal_name,
                                                    sname,
                                                    cname,
                                                    addr,
                                                    tax,
                                                    bill_addr,
                                                    bill_email,
                                                    bill_tel,
                                                    bill_tax,
                                                    bill_name,
                                                    newValuePDFimg,
                                                    numinvoice,
                                                    'cFinn',
                                                    finnancetransModels,
                                                    '${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}');
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(Icons.print,
                                                        color: Colors.white),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'พิมพ์',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 200,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(6),
                                                        topRight:
                                                            Radius.circular(6),
                                                        bottomLeft:
                                                            Radius.circular(6),
                                                        bottomRight:
                                                            Radius.circular(6)),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                        Icons.highlight_off,
                                                        color: Colors.white),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'ปิด',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        fontFamily:
                                                            Font_.Fonts_T,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<Null> pPC_finantIbill(Formbecause) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    var numin = numinvoice;

    String url =
        '${MyConstant().domain}/UPC_finant_bill.php?isAdd=true&ren=$ren&user=$user&numin=$numin&because=$Formbecause';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        Insert_log.Insert_logs('บัญชี',
            'ประวัติบิล>>ยกเลิกการรับชำระ($numin,เหตุผล:${Formbecause})');
        setState(() {
          // _InvoiceModels.clear();
          // _InvoiceHistoryModels.clear();
          _TransReBillHistoryModels.clear();
          // numinvoice = null;
          // sum_disamtx.text = '0.00';
          // sum_dispx.text = '0.00';
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          // select_page = 0;
          red_Trans_bill();
          finnancetransModels.clear();
          Navigator.pop(context);
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

  Future<Null> pPC_finantIbillREbill(tableData00, sname, cname, addr, tax,
      newValuePDFimg, finnancetransModels) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    var numin = numinvoice;
    print(
        'finnancetransModels>>>zzzz${finnancetransModels.length}>>>>>> $numin');

    String url =
        '${MyConstant().domain}/UPC_finant_billREbill.php?isAdd=true&ren=$ren&user=$user&numin=$numin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() == 'true') {
        Insert_log.Insert_logs(
            'บัญชี', 'ประวัติบิล>>เปลี่ยนสถานะบิล(ร้าน:$sname,${numinvoice})');
        Pdfgen_his_statusbill.exportPDF_statusbill(
            tableData00,
            context,
            _TransReBillHistoryModels,
            'Num_cid',
            'Namenew',
            sum_pvat,
            sum_vat,
            sum_wht,
            sum_amt,
            sum_disp,
            sum_disamt,
            '${sum_amt - sum_disamt}',
            renTal_name,
            sname,
            cname,
            addr,
            tax,
            bill_addr,
            bill_email,
            bill_tel,
            bill_tax,
            bill_name,
            newValuePDFimg,
            numinvoice,
            'cFinn',
            finnancetransModels,
            '${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}');
        setState(() async {
          // _InvoiceModels.clear();
          // _InvoiceHistoryModels.clear();
          _TransReBillHistoryModels.clear();
          // numinvoice = null;
          // sum_disamtx.text = '0.00';
          // sum_dispx.text = '0.00';
          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;
          // select_page = 0;
          red_Trans_bill();
          // finnancetransModels.clear();
          Navigator.pop(context);
        });
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }
}

class PreviewPdfgen_AC_HistoryBills extends StatelessWidget {
  final pw.Document doc;

  const PreviewPdfgen_AC_HistoryBills({Key? key, required this.doc})
      : super(key: key);

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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "ประวัติบิล(วันที่${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}) ",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: Font_.Fonts_T,
            ),
          ),
        ),
        body: PdfPreview(
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true, canDebug: false,
          canChangeOrientation: false, canChangePageFormat: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName:
              "ประวัติบิล( วันที่${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}).pdf",
        ),
      ),
    );
  }
}