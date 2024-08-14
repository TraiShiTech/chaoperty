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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/Account_Screen.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/ChaoArea_Screen.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetContractx_Model.dart';
import '../Model/GetPayMent_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetSubZone_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/Get_maintenance_model.dart';
import '../Model/Get_tran_meter_model.dart';
import '../Model/Getexp_sz_model.dart';
import '../Model/electricity_history_model.dart';
import '../Model/electricity_model.dart';
import '../PeopleChao/PeopleChao_Screen.dart';
import '../Responsive/responsive.dart';
import '../Setting/SettingScreen.dart';
import '../Style/Translate.dart';
import '../Style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import '../Style/view_pagenow.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  var nFormat = NumberFormat("#,##0.00", "en_US");
  var End_Bill_Paydate;
  DateTime datex = DateTime.now();
  int Status_ = 1;
  int Ser_BodySta1 = 0;
  String Ser_nowpage = '4';
  String? paymentSer1, paymentName1, selectedValue;
  ///////---------------------------------------------------->
  int tappedIndex_ = -1;
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ListObserverController observerController = ListObserverController();
  List<TransMeterModel> transMeterModels = [];
  List<MaintenanceModel> maintenanceModels = [];
  List<MaintenanceModel> _maintenanceModels = <MaintenanceModel>[];
  List<TransMeterModel> _transMeterModels = <TransMeterModel>[];
  List<ElectricityHistoryModel> electricityHistoryModels = [];
  List<TeNantModel> teNantModels = [];
  List<ExpSZModel> expSZModels = [];
  List<ZoneModel> zoneModels = [];
  List<RenTalModel> renTalModels = [];
  List<SubZoneModel> subzoneModels = [];
  List<PayMentModel> _PayMentModels = [];
  final FormMeter_text = TextEditingController();
  final Formbecause_ = TextEditingController();
  String? typezonesName, typevalue;
  ///////---------------------------------------------------->
  List<String> _selecteSerbool = [];
  List _selecteSer = [];
  List<AreaModel> areaModels = [];

  List<ElectricityModel> electricityModels = [];
  int indexdelog = 0;
  String? serarea,
      lncodearea,
      lnarea,
      Value_D_start,
      snamearea,
      custnoarea,
      zone_ser,
      zone_name,
      zone_Subser,
      zone_Subname;
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
      cFinn,
      expbill_name,
      bill_default,
      bill_tser,
      Slip_status,
      foder,
      bills_name_,
      renTal_name;
  int renTal_lavel = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read_GC_rental();
    checkPreferance();
    read_GC_Sub_zone();
    read_GC_zone();
    red_Trans_bill();
    red_Trans_c_maintenance();
    red_exp_sz();
    read_GC_areaSelect();
    red_payMent();
    End_Bill_Paydate = DateFormat('yyyy-MM-dd').format(datex);
    observerController = ListObserverController(controller: _scrollController1);
  }

  Future<Null> red_payMent() async {
    if (_PayMentModels.length != 0) {
      setState(() {
        _PayMentModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_payMent.php?isAdd=true&ren=$ren';
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
        map['auto'] = '0';

        PayMentModel _PayMentModel = PayMentModel.fromJson(map);
        setState(() {
          _PayMentModels.add(_PayMentModel);
        });

        for (var map in result) {
          PayMentModel _PayMentModel = PayMentModel.fromJson(map);
          var autox = _PayMentModel.auto;
          var serx = _PayMentModel.ser;
          var ptnamex = _PayMentModel.ptname;
          setState(() {
            _PayMentModels.add(_PayMentModel);
            if (autox == '1') {
              paymentSer1 = serx.toString();
              paymentName1 = ptnamex.toString();
            }
          });
          if (_PayMentModel.btser.toString() == '1') {
          } else {}
        }

        if (paymentSer1 == null) {
          paymentSer1 = 0.toString();
          paymentName1 = 'เลือก'.toString();
        }
      }
    } catch (e) {}
  }

  // Future<Null> read_Electricity() async {
  //   if (electricityModels.isNotEmpty) {
  //     electricityModels.clear();
  //   }

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   String url =
  //       '${MyConstant().domain}/GC_electricity.php?isAdd=true&ren=$ren';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         ElectricityModel electricityModel = ElectricityModel.fromJson(map);
  //           setState(() {
  //             electricityModels.add(electricityModel);
  //           });
  //       }
  //     } else {}
  //   } catch (e) {}
  // }

  Future<Null> infomation() async {
    showDialog<String>(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: const Center(
                  child: Text(
                'Level ของคุณไม่สามารถเข้าถึงได้',
                style: TextStyle(
                  color: SettingScreen_Color.Colors_Text1_,
                  fontFamily: FontWeight_.Fonts_T,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ));
  }

  Future<Null> read_GC_Sub_zone() async {
    if (subzoneModels.length != 0) {
      setState(() {
        subzoneModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');

    String url = '${MyConstant().domain}/GC_zone_sub.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      Map<String, dynamic> map = Map();
      map['ser'] = '0';
      map['rser'] = '0';
      map['zn'] = 'ทั้งหมด';
      map['qty'] = '0';
      map['img'] = '0';
      map['data_update'] = '0';

      SubZoneModel subzoneModelx = SubZoneModel.fromJson(map);

      setState(() {
        subzoneModels.add(subzoneModelx);
      });

      for (var map in result) {
        SubZoneModel subzoneModel = SubZoneModel.fromJson(map);
        setState(() {
          subzoneModels.add(subzoneModel);
        });
      }
    } catch (e) {}
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      setState(() {
        renTalModels.clear();
      });
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
    print('name>>>>>  $renname');
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      zone_ser = preferences.getString('zonePSer');
      zone_name = preferences.getString('zonesPName');
      renTal_lavel = int.parse(preferences.getString('lavel').toString());
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
    var zoneSubSer = preferences.getString('zoneSubSer');
    var zonesSubName = preferences.getString('zonesSubName');
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
        var sub = zoneModel.sub_zone;
        setState(() {
          if (zoneSubSer == null || zoneSubSer == '0') {
            zoneModels.add(zoneModel);
          } else {
            if (sub == zoneSubSer) {
              zoneModels.add(zoneModel);
            }
          }
        });
      }
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
    setState(() {
      zone_ser = preferences.getString('zonePSer');
      zone_name = preferences.getString('zonesPName');
      zone_Subser = preferences.getString('zoneSubSer');
      zone_Subname = preferences.getString('zonesSubName');
    });
  }

  Future<Null> red_Trans_bill() async {
    if (transMeterModels.length != 0) {
      setState(() {
        transMeterModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var zone_Sub = preferences.getString('zoneSubSer');
    print('Ser_BodySta1 >>>>  $Ser_BodySta1');

    String url = zone_Sub == null || zone_Sub == '0'
        ? (zone_ser.toString() == 'null')
            ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=$Ser_BodySta1&serzone=0'
            : '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren&sertype=$Ser_BodySta1&serzone=$zone_ser'
        : (zone_ser.toString() == 'null')
            ? '${MyConstant().domain}/GC_trans_mitter_sub.php?isAdd=true&ren=$ren&sertype=$Ser_BodySta1&serzone=0&serzonesub=$zone_Sub'
            : '${MyConstant().domain}/GC_trans_mitter_sub.php?isAdd=true&ren=$ren&sertype=$Ser_BodySta1&serzone=$zone_ser&serzonesub=$zone_Sub';
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

  Future _scrollToIndex(int index) async {
    // observerController.jumpTo(index: index);
    observerController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  // Future<Null> red_Trans_bill_exp(int expser) async {
  //   if (transMeterModels.length != 0) {
  //     setState(() {
  //       transMeterModels.clear();
  //     });
  //   }

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   // var ciddoc = widget.Get_Value_cid;
  //   // var qutser = widget.Get_Value_NameShop_index;

  //   String url = expser == 0
  //       ? '${MyConstant().domain}/GC_trans_mitter.php?isAdd=true&ren=$ren'
  //       : '${MyConstant().domain}/GC_expser.php?isAdd=true&ren=$ren&expser=$expser';
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
  //   } catch (e) {}
  // }

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
    var zone_Sub = preferences.getString('zoneSubSer');

    String url = zone_Sub == null || zone_Sub == '0'
        ? (zone_ser.toString() == 'null')
            ? '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren&serzone=0'
            : '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren&serzone=$zone_ser'
        : (zone_ser.toString() == 'null')
            ? '${MyConstant().domain}/GC_maintenance_sub.php?isAdd=true&ren=$ren&serzone=$zone_Sub'
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
    var zone_Sub = preferences.getString('zoneSubSer');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    String url = zone_Sub == null || zone_Sub == '0'
        ? expser == 0
            ? '${MyConstant().domain}/GC_maintenance.php?isAdd=true&ren=$ren'
            : '${MyConstant().domain}/GC_maintenance_mst.php?isAdd=true&ren=$ren&expser=$expser'
        : expser == 0
            ? '${MyConstant().domain}/GC_maintenance_sub.php?isAdd=true&ren=$ren&serzone=$zone_Sub'
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
  // _setState(index) {
  //   setState(() {
  //     tappedIndex_ = index.toString();
  //   });
  // }

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
              var notTitle = transMeterModels.ln.toString();
              var notTitle2 = transMeterModels.sname.toString();
              var notTitle3 = transMeterModels.num_meter.toString();
              var notTitle4 = transMeterModels.refno.toString();
              // var notTitle = transMeterModels.ln.toString().toLowerCase();
              // var notTitle2 = transMeterModels.sname.toString().toLowerCase();
              // var notTitle3 =
              //     transMeterModels.num_meter.toString().toLowerCase();
              // var notTitle4 = transMeterModels.refno.toString().toLowerCase();
              return notTitle.contains(text) ||
                  notTitle2.contains(text) ||
                  notTitle3.contains(text) ||
                  notTitle4.contains(text);
            }).toList();
          });
        } else if (Status_ == 2) {
          setState(() {
            maintenanceModels = _maintenanceModels.where((maintenanceModelss) {
              var notTitle = maintenanceModelss.lncode.toString();
              var notTitle2 = maintenanceModelss.sname.toString();
              // var notTitle = maintenanceModelss.lncode.toString().toLowerCase();
              // var notTitle2 = maintenanceModelss.sname.toString().toLowerCase();

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

/////////////----------------------------------------------------------->
  var extension_;
  var file_;
  String? base64_Slip, fileName_Slip;
  Future<void> uploadFile_Slip(docno, Cid, ser) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);

    if (pickedFile == null) {
      print('User canceled image selection');
      return;
    } else {
      // 2. Read the image as bytes
      final imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      final base64Image = base64Encode(imageBytes);
      setState(() {
        base64_Slip = base64Image;
      });

      setState(() {
        extension_ = 'png';
        // file_ = file;
      });
      print(extension_);
      print(extension_);
      Future.delayed(Duration(milliseconds: 200), () {
        OKuploadFile_Slip(docno, Cid, ser);
      });
    }
    // print(base64_Slip);
    //
  }

/////////////----------------------------------------------------------->
  Future<void> OKuploadFile_Slip(docno, Cid, ser) async {
    if (base64_Slip != null) {
      String Path_foder = 'Meter';
      String dateTimeNow = DateTime.now().toString();
      String date = DateFormat('ddMMyyyy')
          .format(DateTime.parse('${dateTimeNow}'))
          .toString();
      final dateTimeNow2 = DateTime.now().toUtc().add(const Duration(hours: 7));
      final formatter2 = DateFormat('HHmmss');
      final formattedTime2 = formatter2.format(dateTimeNow2);
      String Time_ = formattedTime2.toString();

      setState(() {
        fileName_Slip = 'Meter_${Cid}_${date}_$Time_.$extension_';
      });

      try {
        // 2. Read the image as bytes
        // final imageBytes = await pickedFile.readAsBytes();

        // 3. Encode the image as a base64 string
        // final base64Image = base64Encode(imageBytes);

        // 4. Make an HTTP POST request to your server
        final url =
            '${MyConstant().domain}/File_uploadMeter.php?name=$fileName_Slip&Foder=$foder&extension=$extension_';

        final response = await http.post(
          Uri.parse(url),
          body: {
            'image': base64_Slip,
            'Foder': foder,
            'name': fileName_Slip,
            'ex': extension_.toString()
          }, // Send the image as a form field named 'image'
        );

        if (response.statusCode == 200) {
          print('File uploaded successfully!*** : $fileName_Slip');
          OK_up_insert_img(docno, Cid, ser);
        } else {
          print('Image upload failed');
        }
      } catch (e) {
        print('Error during image processing: $e');
      }
    } else {
      print('ยังไม่ได้เลือกรูปภาพ');
    }
  }

/////////////----------------------------------------------------------->
  Future<void> OK_up_insert_img(docno, Cid, ser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');

    var docno_ = docno;
    String url =
        '${MyConstant().domain}/UPC_Invoice_img.php?isAdd=true&ren=$ren&fileName=$fileName_Slip&transer=$ser';
    print('$docno_ /// $ren /// $user /// $fileName_Slip ');
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);

      if (result.toString() == 'true') {
        //print(result);
        // Navigator.pop(context);
        setState(() {
          checkPreferance();
          read_GC_zone();
          red_Trans_bill();
          red_Trans_c_maintenance();
          red_exp_sz();
          read_GC_areaSelect();
          read_GC_rental();
        });
      }
    } catch (e) {
      print('******************** > $e');
    }
  }

  ////------------------------------------------------->
  Future<void> Dialog_img_Meter(docno, Cid, ser, index) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text(
            '$Cid',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: FontWeight_.Fonts_T),
          ),
        ),
        content: SizedBox(
          width: 350,
          // width: MediaQuery.of(context)
          //     .size
          //     .width,
          child: (transMeterModels.isEmpty ||
                  transMeterModels[index].img.toString() == '' ||
                  transMeterModels[index].img == null)
              ? Center(child: Icon(Icons.image_not_supported))
              : Image.network(
                  // '${MyConstant().domain}/files/kad_taii/logo/${Img_logo_}',
                  '${MyConstant().domain}/files/$foder/Meter/${transMeterModels[index].img}',
                  // fit: BoxFit.cover,
                ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                          onPressed: () async {
                            uploadFile_Slip(docno, Cid, ser);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'แก้ไข',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontWeight_.Fonts_T),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ////------------------------------------------------->
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppbackgroundColor.Abg_Colors,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppbackgroundColor.TiTile_Box,
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
                            children: [
                              Translate.TranslateAndSetText(
                                  'จัดการ',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.center,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  14,
                                  2),
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
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: viewpage(context, '$Ser_nowpage'),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Align(
            //       alignment: Alignment.topLeft,
            //       child: viewpage(context, '$Ser_nowpage'),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.TiTile_Box,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // border: Border.all(color: Colors.white, width: 1),
                ),
                // padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    subzoneModels.length == 1
                        ? SizedBox()
                        : MediaQuery.of(context).size.shortestSide <
                                MediaQuery.of(context).size.width * 1
                            ? Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Translate.TranslateAndSetText(
                                      'โซน:',
                                      SettingScreen_Color.Colors_Text1_,
                                      TextAlign.center,
                                      FontWeight.bold,
                                      FontWeight_.Fonts_T,
                                      14,
                                      2),
                                ))
                            : const SizedBox(),
                    subzoneModels.length == 1
                        ? SizedBox()
                        : Expanded(
                            flex: MediaQuery.of(context).size.shortestSide <
                                    MediaQuery.of(context).size.width * 1
                                ? 2
                                : 3,
                            child: Padding(
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
                                width: 200,
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
                                    zone_Subname == null
                                        ? 'ทั้งหมด'
                                        : '$zone_Subname',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: TextHome_Color.TextHome_Colors,
                                  ),
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontFamily: Font_.Fonts_T),
                                  iconSize: 30,
                                  buttonHeight: 40,
                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  items: subzoneModels
                                      .map((item) => DropdownMenuItem<String>(
                                            value: '${item.ser},${item.zn}',
                                            child: Text(
                                              item.zn!,
                                              style: const TextStyle(
                                                  fontSize: 14,
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
                                        'zoneSubSer', zoneSer.toString());
                                    preferences.setString(
                                        'zonesSubName', zonesName.toString());
                                    preferences.remove("zonePSer");
                                    preferences.remove("zonesPName");

                                    // setState(() {
                                    //   zoneModels.clear();
                                    //   zone_ser =
                                    //       preferences.getString('zoneSer');
                                    //   zone_name =
                                    //       preferences.getString('zonesName');
                                    //   zone_Subser =
                                    //       preferences.getString('zoneSubSer');
                                    //   zone_Subname =
                                    //       preferences.getString('zonesSubName');
                                    //   read_GC_Sub_zone().then((value) =>
                                    //       read_GC_zone()
                                    //           .then((value) => read_GC_area()));
                                    // });

                                    String? _route =
                                        preferences.getString('route');
                                    MaterialPageRoute materialPageRoute =
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AdminScafScreen(route: _route));
                                    Navigator.pushAndRemoveUntil(context,
                                        materialPageRoute, (route) => false);
                                  },
                                  // onSaved: (value) {
                                  //   // selectedValue = value.toString();
                                  // },
                                ),
                              ),
                            ),
                          ),
                    MediaQuery.of(context).size.shortestSide <
                            MediaQuery.of(context).size.width * 1
                        ? Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Translate.TranslateAndSetText(
                                  'โซนพื้นที่เช่า:',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.center,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  14,
                                  2),
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                      flex: MediaQuery.of(context).size.shortestSide <
                              MediaQuery.of(context).size.width * 1
                          ? 2
                          : 3,
                      child: Padding(
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
                          )),
                    ),
                    if (Status_ != 3)
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Translate.TranslateAndSetText(
                              'ค้นหา:',
                              SettingScreen_Color.Colors_Text1_,
                              TextAlign.center,
                              FontWeight.bold,
                              FontWeight_.Fonts_T,
                              14,
                              2),
                        ),
                      ),
                    if (Status_ != 3)
                      Expanded(
                        flex: MediaQuery.of(context).size.shortestSide <
                                MediaQuery.of(context).size.width * 1
                            ? 8
                            : 6,
                        child: Padding(
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
                            width: 120,
                            height: 40,
                            child: _searchBar(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
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
                              Translate.TranslateAndSetText(
                                  'สถานะ : ',
                                  SettingScreen_Color.Colors_Text1_,
                                  TextAlign.center,
                                  FontWeight.bold,
                                  FontWeight_.Fonts_T,
                                  14,
                                  2),
                              //  Text(
                              //   'สถานะ : ',
                              //   style: TextStyle(
                              //     color: ManageScreen_Color.Colors_Text1_,
                              //     fontWeight: FontWeight.bold,
                              //     fontFamily: FontWeight_.Fonts_T,
                              //   ),
                              // ),
                              for (int i = 0; i < Status.length; i++)
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          Status_ = 0;
                                          Status_ = i + 1;
                                          tappedIndex_ = -1;
                                          typezonesName = null;
                                          typevalue = null;
                                          // red_Trans_c_maintenance_exp(0);
                                          // red_Trans_bill_exp(0);
                                        });
                                        print(Status_);
                                        // red_Trans_bill_exp(0);
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
                                          child: Translate.TranslateAndSetText(
                                              Status[i],
                                              (Status_ == i + 1)
                                                  ? Colors.white
                                                  : Colors.black,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                          // Text(
                                          //   Status[i],
                                          //   style: TextStyle(
                                          //     color: (Status_ == i + 1)
                                          //         ? Colors.white
                                          //         : Colors.black,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //   ),
                                          // ),
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
                                                for (int index = 0;
                                                    index < expSZModels.length;
                                                    index++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      child: Container(
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (index == 0)
                                                              ? Colors
                                                                  .brown[400]
                                                              : (index == 1)
                                                                  ? Colors.red
                                                                  : (index == 2)
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors.purple[
                                                                          400],
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
                                                            EdgeInsets.all(4.0),
                                                        child: Center(
                                                          child: Text(
                                                            '${expSZModels[index].expname}',
                                                            style: TextStyle(
                                                              // fontSize: 15,
                                                              color: (Ser_BodySta1 ==
                                                                      int.parse(
                                                                          expSZModels[index]
                                                                              .ser!))
                                                                  ? Colors.white
                                                                  : Colors.grey[
                                                                      800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          Ser_BodySta1 =
                                                              int.parse(
                                                                  expSZModels[
                                                                          index]
                                                                      .ser!);
                                                        });
                                                        red_Trans_bill();
                                                      },
                                                    ),
                                                  ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.all(8.0),
                                                //   child: InkWell(
                                                //     child: Container(
                                                //       width: 100,
                                                //       decoration:
                                                //           const BoxDecoration(
                                                //         color: Colors.red,
                                                //         borderRadius:
                                                //             BorderRadius.only(
                                                //           topLeft:
                                                //               Radius.circular(
                                                //                   10),
                                                //           topRight:
                                                //               Radius.circular(
                                                //                   10),
                                                //           bottomLeft:
                                                //               Radius.circular(
                                                //                   10),
                                                //           bottomRight:
                                                //               Radius.circular(
                                                //                   10),
                                                //         ),
                                                //       ),
                                                //       padding:
                                                //           const EdgeInsets.all(
                                                //               4.0),
                                                //       child: Center(
                                                //         child: Text(
                                                //           'ไฟฟ้า',
                                                //           style: TextStyle(
                                                //             // fontSize: 15,
                                                //             color:
                                                //                 (Ser_BodySta1 ==
                                                //                         1)
                                                //                     ? Colors
                                                //                         .white
                                                //                     : Colors.grey[
                                                //                         800],
                                                //             fontWeight:
                                                //                 FontWeight.bold,
                                                //             fontFamily:
                                                //                 FontWeight_
                                                //                     .Fonts_T,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     onTap: () {
                                                //       setState(() {
                                                //         Ser_BodySta1 = 1;
                                                //       });
                                                //       red_Trans_bill();
                                                //     },
                                                //   ),
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.all(8.0),
                                                //   child: InkWell(
                                                //     child: Container(
                                                //       width: 100,
                                                //       decoration:
                                                //           const BoxDecoration(
                                                //         color: Colors.blue,
                                                //         borderRadius:
                                                //             BorderRadius.only(
                                                //           topLeft:
                                                //               Radius.circular(
                                                //                   10),
                                                //           topRight:
                                                //               Radius.circular(
                                                //                   10),
                                                //           bottomLeft:
                                                //               Radius.circular(
                                                //                   10),
                                                //           bottomRight:
                                                //               Radius.circular(
                                                //                   10),
                                                //         ),
                                                //       ),
                                                //       padding:
                                                //           const EdgeInsets.all(
                                                //               4.0),
                                                //       child: Center(
                                                //         child: Text(
                                                //           'น้ำ',
                                                //           style: TextStyle(
                                                //             // fontSize: 15,
                                                //             color:
                                                //                 (Ser_BodySta1 ==
                                                //                         2)
                                                //                     ? Colors
                                                //                         .white
                                                //                     : Colors.grey[
                                                //                         800],
                                                //             fontWeight:
                                                //                 FontWeight.bold,
                                                //             fontFamily:
                                                //                 FontWeight_
                                                //                     .Fonts_T,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     onTap: () {
                                                //       setState(() {
                                                //         Ser_BodySta1 = 2;
                                                //       });
                                                //       red_Trans_bill();
                                                //     },
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        if (Responsive.isDesktop(context))
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                          ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Translate
                                                    .TranslateAndSetText(
                                                        (Status_ == 1)
                                                            ? 'ประเภทรายการ'
                                                            : 'สถานะ',
                                                        ManageScreen_Color
                                                            .Colors_Text1_,
                                                        TextAlign.center,
                                                        FontWeight.bold,
                                                        FontWeight_.Fonts_T,
                                                        14,
                                                        2),
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

                                                                      // setState(
                                                                      //     () {

                                                                      // red_Trans_bill_exp(
                                                                      //     int.parse(zoneSer));
                                                                      // });

                                                                      setState(
                                                                          () {
                                                                        typezonesName =
                                                                            zonesName;
                                                                        Ser_BodySta1 =
                                                                            int.parse(zoneSer);
                                                                        red_Trans_bill();
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
                                                  ? Row(
                                                      children: [
                                                        InkWell(
                                                          child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
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
                                                                        EdgeInsets.all(
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
                                                              // red_Trans_bill();
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
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
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'Invoice',
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
                                                            if (renTal_lavel <=
                                                                1) {
                                                              infomation();
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false, // user must tap button!
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20.0))),
                                                                      title:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  flex: 1,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [],
                                                                                  )),
                                                                              Expanded(
                                                                                flex: 4,
                                                                                child: Translate.TranslateAndSetText('วางบิล น้ำ-ไฟ เดือน ${DateFormat.MMM('th_TH').format(datex)}', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                // Text(
                                                                                //   'วางบิล น้ำ-ไฟ เดือน ${DateFormat.MMM('th_TH').format(datex)}',
                                                                                //   textAlign: TextAlign.center,
                                                                                //   style: TextStyle(
                                                                                //     // fontSize: 20,
                                                                                //     color: SettingScreen_Color.Colors_Text1_,
                                                                                //     fontFamily: FontWeight_.Fonts_T,
                                                                                //   ),
                                                                                // ),
                                                                              ),
                                                                              Expanded(
                                                                                  flex: 1,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      IconButton(
                                                                                          onPressed: () {
                                                                                            Navigator.of(context).pop();
                                                                                          },
                                                                                          icon: Icon(Icons.close)),
                                                                                    ],
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                          Divider(),
                                                                          Container(
                                                                            color:
                                                                                Colors.indigo.shade100,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('รหัสพื้นที่', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    //  Text(
                                                                                    //   'รหัสพื้นที่',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('เลขที่สัญญา', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    // Text(
                                                                                    //   'เลขที่สัญญา',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('ชื่อร้านค้า', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    // Text(
                                                                                    //   'ชื่อร้านค้า',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('รายการ', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    // Text(
                                                                                    //   'รายการ',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('เลขเครื่อง', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    // Text(
                                                                                    //   'เลขเครื่อง',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('เลขครั้งก่อน', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    //  Text(
                                                                                    //   'เลขครั้งก่อน',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('เลขปัจจุบัน', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),

                                                                                    // Text(
                                                                                    //   'เลขปัจจุบัน',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('หน่วยที่ใช้', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    //  Text(
                                                                                    //   'หน่วยที่ใช้',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Translate.TranslateAndSetText('ยอดชำระ', ManageScreen_Color.Colors_Text1_, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                    //  Text(
                                                                                    //   'ยอดชำระ',
                                                                                    //   textAlign: TextAlign.center,
                                                                                    //   style: TextStyle(
                                                                                    //     color: SettingScreen_Color.Colors_Text1_,
                                                                                    //     fontFamily: Font_.Fonts_T,
                                                                                    //   ),
                                                                                    // ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      content:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.8,
                                                                        height: MediaQuery.of(context).size.width *
                                                                            0.5,
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                for (int index = 0; index < transMeterModels.length; index++)
                                                                                  if (transMeterModels[index].nvalue != '0')
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].ln}',
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].refno}',
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].sname}',
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].expname}',
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].num_meter}',
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].ovalue}',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].nvalue}',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].qty}',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            '${transMeterModels[index].c_amt}',
                                                                                            textAlign: TextAlign.end,
                                                                                            style: TextStyle(
                                                                                              color: SettingScreen_Color.Colors_Text1_,
                                                                                              fontFamily: Font_.Fonts_T,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Translate.TranslateAndSetText(
                                                                                'รูปแบบชำระ',
                                                                                ManageScreen_Color.Colors_Text1_,
                                                                                TextAlign.center,
                                                                                FontWeight.bold,
                                                                                FontWeight_.Fonts_T,
                                                                                14,
                                                                                2),
                                                                            StreamBuilder(
                                                                                stream: Stream.periodic(const Duration(milliseconds: 0)),
                                                                                builder: (
                                                                                  context,
                                                                                  snapshot,
                                                                                ) {
                                                                                  return Container(
                                                                                    height: 50,
                                                                                    width: 350,
                                                                                    // color:
                                                                                    //     AppbackgroundColor
                                                                                    //         .Sub_Abg_Colors,
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: AppbackgroundColor.Sub_Abg_Colors,
                                                                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        // border: Border.all(
                                                                                        //     color: Colors.grey, width: 1),
                                                                                      ),
                                                                                      width: 120,
                                                                                      child: DropdownButtonFormField2(
                                                                                        decoration: InputDecoration(
                                                                                          //Add isDense true and zero Padding.
                                                                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                                                          isDense: true,
                                                                                          contentPadding: EdgeInsets.zero,
                                                                                          border: OutlineInputBorder(
                                                                                            borderRadius: BorderRadius.circular(15),
                                                                                          ),
                                                                                          //Add more decoration as you want here
                                                                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                                                        ),
                                                                                        isExpanded: true,
                                                                                        // disabledHint: Icon(Icons.time_to_leave, color: Colors.black),
                                                                                        hint: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              '$paymentName1',
                                                                                              style: const TextStyle(
                                                                                                  fontSize: 14,
                                                                                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                  // fontWeight: FontWeight.bold,
                                                                                                  fontFamily: Font_.Fonts_T),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        icon: const Icon(
                                                                                          Icons.arrow_drop_down,
                                                                                          color: Colors.black45,
                                                                                        ),
                                                                                        iconSize: 25,
                                                                                        buttonHeight: 42,
                                                                                        // buttonPadding:
                                                                                        //     const EdgeInsets
                                                                                        //         .only(
                                                                                        //         left:
                                                                                        //             10,
                                                                                        //         right:
                                                                                        //             10),
                                                                                        dropdownDecoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                        ),
                                                                                        items: _PayMentModels.map((item) => DropdownMenuItem<String>(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  selectedValue = item.bno!;
                                                                                                });
                                                                                                print('**/*/*   --- ${selectedValue}');
                                                                                              },
                                                                                              value: '${item.ser}:${item.ptname}',
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Text(
                                                                                                      '${item.ptname!}',
                                                                                                      textAlign: TextAlign.start,
                                                                                                      style: const TextStyle(
                                                                                                          fontSize: 14,
                                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight: FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Text(
                                                                                                      '${item.bno!}',
                                                                                                      textAlign: TextAlign.end,
                                                                                                      style: const TextStyle(
                                                                                                          fontSize: 14,
                                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                          // fontWeight: FontWeight.bold,
                                                                                                          fontFamily: Font_.Fonts_T),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )).toList(),
                                                                                        onChanged: (value) async {
                                                                                          print(value);
                                                                                          // Do something when changing the item if you want.

                                                                                          var zones = value!.indexOf(':');
                                                                                          var rtnameSer = value.substring(0, zones);
                                                                                          var rtnameName = value.substring(zones + 1);
                                                                                          // print(
                                                                                          //     'mmmmm ${rtnameSer.toString()} $rtnameName');
                                                                                          setState(() {
                                                                                            paymentSer1 = rtnameSer.toString();

                                                                                            if (rtnameSer.toString() == '0') {
                                                                                              paymentName1 = null;
                                                                                            } else {
                                                                                              paymentName1 = rtnameName.toString();
                                                                                            }
                                                                                            // paymentSer1 =
                                                                                            //     rtnameSer;
                                                                                          });
                                                                                          print('mmmmm ${rtnameSer.toString()} $rtnameName');
                                                                                          // print(
                                                                                          //     'pppppp $paymentSer1 $paymentName1');
                                                                                          // print('Form_payment1.text');
                                                                                          // print(Form_payment1.text);
                                                                                          // print(Form_payment2.text);
                                                                                          // print('Form_payment1.text');
                                                                                        },
                                                                                        // onSaved: (value) {

                                                                                        // },
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                            SizedBox(
                                                                              height: 40,
                                                                              child: StreamBuilder(
                                                                                  stream: Stream.periodic(const Duration(milliseconds: 0)),
                                                                                  builder: (
                                                                                    context,
                                                                                    snapshot,
                                                                                  ) {
                                                                                    return InkWell(
                                                                                      onTap: () async {
                                                                                        select_Date_Inv(context);
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            'วันที่ครบกำหนดชำระ : ',
                                                                                            style: TextStyle(
                                                                                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                //fontWeight: FontWeight.bold,
                                                                                                fontFamily: Font_.Fonts_T),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(6, 6, 0, 6),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.white,
                                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(0)),
                                                                                                border: Border.all(color: Colors.grey, width: 1),
                                                                                              ),
                                                                                              // width: 120,
                                                                                              padding: const EdgeInsets.all(2.0),
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${End_Bill_Paydate}'))}',
                                                                                                  // '${End_Bill_Paydate}',
                                                                                                  style: const TextStyle(
                                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                                      //fontWeight: FontWeight.bold,
                                                                                                      fontFamily: Font_.Fonts_T),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.white,
                                                                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(10), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(10)),
                                                                                                border: Border.all(color: Colors.grey, width: 1),
                                                                                              ),
                                                                                              // width: 120,
                                                                                              child: Icon(
                                                                                                Icons.arrow_drop_down,
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                            ),
                                                                            Container(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Translate.TranslateAndSetText('***หมายเหตุ เลขที่สัญญาเดียวกันจะรวมบิลอัตโนมัติ  ', Colors.red, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  child: Container(
                                                                                      width: 200,
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.black,
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                        // border: Border.all(color: Colors.white, width: 1),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Center(
                                                                                        child: Translate.TranslateAndSetText('บันทึกวางบิล', Colors.white, TextAlign.center, FontWeight.bold, FontWeight_.Fonts_T, 14, 2),
                                                                                      )),
                                                                                  onTap: () {
                                                                                    in_Trans_invoice().then((value) => Navigator.of(context).pop());
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    );
                                                                  });
                                                            }
                                                          },
                                                        ),
                                                      ],
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
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Translate.TranslateAndSetText(
                                                                    'แจ้งซ่อมบำรุง',
                                                                    Colors
                                                                        .white,
                                                                    TextAlign
                                                                        .center,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    14,
                                                                    2),
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

  Future<Null> select_Date_Inv(BuildContext context) async {
    final Future<DateTime?> picked = showDatePicker(
      // locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันที่ครบกำหนด', confirmText: 'ตกลง',
      cancelText: 'ยกเลิก',
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month + 6, DateTime.now().day),
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
      // ignore: unnecessary_null_comparison
      if (picked != null) {
        var formatter = DateFormat('yyyy-MM-dd');
        print("${formatter.format(result!)}");
        setState(() {
          End_Bill_Paydate = "${formatter.format(result)}";
        });
      }
    });
  }

  Future<Null> in_Trans_invoice() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    var zone_Sub = preferences.getString('zoneSubSer') == null
        ? '0'
        : preferences.getString('zoneSubSer');
    var zone_ser = preferences.getString('zonePSer') == null
        ? '0'
        : preferences.getString('zonePSer');
    print(
        'zzzzasaaa123454>>>>  &sertype=$Ser_BodySta1&serzone=$zone_ser&serzonesub=$zone_Sub');
    // String? cFinn;

    String url =
        '${MyConstant().domain}/In_tran_invoice_all.php?isAdd=true&ren=$ren&user=$user&sertype=$Ser_BodySta1&serzone=$zone_ser&serzonesub=$zone_Sub&pSer=$paymentSer1&Paydate=$End_Bill_Paydate';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result.toString() == 'true') {
        // for (var map in result) {
        //   // TransBillModel transBillModel = TransBillModel.fromJson(map);
        //   // setState(() {
        //   //   cFinn = transBillModel.docno;
        //   // });
        //   // print('zzzzasaaa123454>>>>  $cFinn');
        //   // print('docnodocnodocnodocnodocno123456>>>>  ${transBillModel.docno}');
        // }

        Insert_log.Insert_logs(
            'ผู้เช่า', 'วางบิลทั้งหมด>>บันทึก(${user.toString()})');
        setState(() {
          red_Trans_bill();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('บันทึกรายการวางบิลสำเร็จ',
                  style: TextStyle(
                      color: Colors.white, fontFamily: Font_.Fonts_T))),
        );
        print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
    // Future.delayed(const Duration(milliseconds: 200), () async {
    //   setState(() {
    //     red_Trans_bill();
    //   });
    // });
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
                                      child: Center(
                                        child: Translate.TranslateAndSetText(
                                            'ผู้เช่า',
                                            ManageScreen_Color.Colors_Text1_,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            FontWeight_.Fonts_T,
                                            14,
                                            2),
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
                                      child: Center(
                                        child: Translate.TranslateAndSetText(
                                            'หน่วยที่ใช้',
                                            ManageScreen_Color.Colors_Text1_,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            FontWeight_.Fonts_T,
                                            14,
                                            2),
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
                                    flex: 6,
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
                                      child: Center(
                                        child: Translate.TranslateAndSetText(
                                            'จำนวนเงิน',
                                            ManageScreen_Color.Colors_Text1_,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            FontWeight_.Fonts_T,
                                            14,
                                            2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
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
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'รหัสพื้นที่',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'เลขที่สัญญา',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'ชื่อร้านค้า',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'รายการ',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'หมายเลขเครื่อง',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        color: Colors.lightGreen[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'เลขมิเตอร์เดือน ${DateFormat.MMM('th_TH').format(DateTime.parse('${DateFormat('yyyy').format(datex)}-${(datex.month - 1).toString().padLeft(2, '0')}-${DateFormat('dd').format(datex)} 00:00:00'))}',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                          // Text(
                                          //   'เลขมิเตอร์เดือน ${DateFormat.MMM('th_TH').format(DateTime.parse('${DateFormat('yyyy').format(datex)}-${(datex.month - 1).toString().padLeft(2, '0')}-${DateFormat('dd').format(datex)} 00:00:00'))}',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //     color: ManageScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.orange[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'เลขมิเตอร์เดือน ${DateFormat.MMM('th_TH').format(datex)}',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                          // Text(
                                          //   'เลขมิเตอร์เดือน ${DateFormat.MMM('th_TH').format(datex)}',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //     color: ManageScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.orange[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'หน่วยที่ใช้',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),

                                          // Text(
                                          //   'หน่วยที่ใช้',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //     color: ManageScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'ราคาต่อหน่วย',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Container(
                                    //     height: 50,
                                    //     color: Colors.deepPurple[300],
                                    //     child: const Center(
                                    //       child: Text(
                                    //         'Vat (%)',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //           color: ManageScreen_Color
                                    //               .Colors_Text1_,
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
                                    //     height: 50,
                                    //     color: Colors.deepPurple[300],
                                    //     child: const Center(
                                    //       child: Text(
                                    //         'Vat (บาท)',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //           color: ManageScreen_Color
                                    //               .Colors_Text1_,
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
                                    //     height: 50,
                                    //     color: Colors.deepPurple[300],
                                    //     child: const Center(
                                    //       child: Text(
                                    //         'ก่อน Vat (บาท)',
                                    //         textAlign: TextAlign.center,
                                    //         style: TextStyle(
                                    //           color: ManageScreen_Color
                                    //               .Colors_Text1_,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontFamily: FontWeight_.Fonts_T,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 50,
                                        color: Colors.deepPurple[300],
                                        child: Center(
                                          child: Translate.TranslateAndSetText(
                                              'รวม Vat',
                                              ManageScreen_Color.Colors_Text1_,
                                              TextAlign.center,
                                              FontWeight.bold,
                                              FontWeight_.Fonts_T,
                                              14,
                                              2),
                                          //  Text(
                                          //   'รวม Vat',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //     color: ManageScreen_Color
                                          //         .Colors_Text1_,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontFamily: FontWeight_.Fonts_T,
                                          //   ),
                                          // ),
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
                                            '...',
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
                                child: Scaffold(
                                  body: ListViewObserver(
                                    controller: observerController,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      controller: _scrollController1,
                                      itemCount: transMeterModels.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                          color: tappedIndex_ == index
                                              ? tappedIndex_Color
                                                  .tappedIndex_Colors
                                              : AppbackgroundColor
                                                  .Sub_Abg_Colors,
                                          child: Container(
                                            // color: tappedIndex_ == index.toString()
                                            //     ? tappedIndex_Color
                                            //         .tappedIndex_Colors
                                            //         .withOpacity(0.5)
                                            //     : null,
                                            child: ListTile(
                                              // onTap: () {
                                              //   setState(() {
                                              //     tappedIndex_ = index;
                                              //   });
                                              // },
                                              contentPadding:
                                                  const EdgeInsets.all(0.0),
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
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 2, 0),
                                                        child: Text(
                                                          '${transMeterModels[index].ln}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            //fontSize: 10.0
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 2, 0),
                                                        child: Text(
                                                          '${transMeterModels[index].refno}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            //fontSize: 10.0
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 2, 0),
                                                        child: Text(
                                                          '${transMeterModels[index].sname}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            //fontSize: 10.0
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 2, 0),
                                                        child: Text(
                                                          '${transMeterModels[index].expname} ${transMeterModels[index].date}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            // fontSize: 12.0
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 2, 0),
                                                        child: Text(
                                                          '${transMeterModels[index].num_meter}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            // fontSize: 12.0
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 2, 0),
                                                        child: Text(
                                                          '${nFormat.format(double.parse(transMeterModels[index].ovalue!))}',
                                                          // '${transMeterModels[index].ovalue}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                            //fontSize: 12.0
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: TextFormField(
                                                            autofocus: renTal_lavel <=
                                                                    1
                                                                ? false
                                                                : tappedIndex_ +
                                                                            1 ==
                                                                        index
                                                                    ? true
                                                                    : false,
                                                            readOnly:
                                                                renTal_lavel <=
                                                                        1
                                                                    ? true
                                                                    : false,
                                                            // focusNode: myFocusNode,
                                                            textAlign:
                                                                TextAlign.right,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
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
                                                                transMeterModels[
                                                                        index]
                                                                    .nvalue,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                tappedIndex_ =
                                                                    index;
                                                              });
                                                            },
                                                            onFieldSubmitted:
                                                                (valuem) async {
                                                              SharedPreferences
                                                                  preferences =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              String? ren =
                                                                  preferences
                                                                      .getString(
                                                                          'renTalSer');
                                                              String? ser_user =
                                                                  preferences
                                                                      .getString(
                                                                          'ser');

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
                                                              var value =
                                                                  valuem;
                                                              String url =
                                                                  '${MyConstant().domain}/UPC_Invoice_n.php?isAdd=true&ren=$ren&qser_in=$qser_in&qty=$value&ser_user=$ser_user&ovalue=$ovalue&nvalue=$nvalue&_celvat=$_celvat&_cqty_vat=$_cqty_vat&con_ser=$_cser&tran_ser=$tran_ser&tran_expser=$tran_expser';

                                                              try {
                                                                var response =
                                                                    await http.get(
                                                                        Uri.parse(
                                                                            url));

                                                                var result =
                                                                    json.decode(
                                                                        response
                                                                            .body);
                                                                print(result);

                                                                if (result
                                                                        .toString() !=
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
                                                              Insert_log
                                                                  .Insert_logs(
                                                                      'จัดการ',
                                                                      'มิเตอร์น้ำไฟฟ้า>>แก้ไขเลขมิเตอร์เดือนนี้(${transMeterModels[index].ln},${transMeterModels[index].expname})');
                                                              setState(() {
                                                                tappedIndex_ =
                                                                    index;
                                                                red_Trans_bill()
                                                                    .then((value) =>
                                                                        _scrollToIndex(
                                                                            index));
                                                                // FormMeter_text.clear();
                                                              });
                                                            },
                                                            // onFieldSubmitted: (value) {
                                                            //   Insert_log.Insert_logs(
                                                            //       'จัดการ',
                                                            //       'มิเตอร์น้ำไฟฟ้า>>แก้ไขเลขมิเตอร์เดือนนี้(${transMeterModels[index].ln},${transMeterModels[index].expname})');
                                                            //   setState(() {
                                                            //     red_Trans_bill();
                                                            //     // FormMeter_text.clear();
                                                            //   });
                                                            // },
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.3),
                                                                    filled:
                                                                        true,
                                                                    // prefixIcon: const Icon(
                                                                    //     Icons
                                                                    //         .electrical_services,
                                                                    //     color: Colors.red),
                                                                    focusedBorder:
                                                                        const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
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
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    labelText:
                                                                        'เลขมิเตอร์',
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: ManageScreen_Color
                                                                          .Colors_Text2_,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    )),
                                                            inputFormatters: <TextInputFormatter>[
                                                              // for below version 2 use this
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      r'[0-9]')),
                                                              // for version 2 and greater youcan also use this
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                          ),
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
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: const TextStyle(
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
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (transMeterModels[
                                                                      index]
                                                                  .ele_ty !=
                                                              '0') {
                                                            showcountmiter(
                                                                index);
                                                          }
                                                        },
                                                        child: Text(
                                                          transMeterModels[
                                                                          index]
                                                                      .ele_ty ==
                                                                  '0'
                                                              ? '${nFormat.format(double.parse(transMeterModels[index].c_qty!))}'
                                                              : 'อัตราพิเศษ',
                                                          //  '${transMeterModels[index].pri}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   flex: 2,
                                                    //   child: Text(
                                                    //     '${nFormat.format(double.parse(transMeterModels[index].nvat!))}',
                                                    //     // '${transMeterModels[index].nvat} %',
                                                    //     textAlign: TextAlign.right,
                                                    //     style: const TextStyle(
                                                    //       color: ManageScreen_Color
                                                    //           .Colors_Text2_,
                                                    //       // fontWeight:
                                                    //       //     FontWeight.bold,
                                                    //       fontFamily: Font_.Fonts_T,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Expanded(
                                                    //   flex: 2,
                                                    //   child: Text(
                                                    //     '${nFormat.format(double.parse(transMeterModels[index].c_vat!))}',
                                                    //     //'${transMeterModels[index].c_vat}',
                                                    //     textAlign: TextAlign.right,
                                                    //     style: const TextStyle(
                                                    //       color: ManageScreen_Color
                                                    //           .Colors_Text2_,
                                                    //       // fontWeight:
                                                    //       //     FontWeight.bold,
                                                    //       fontFamily: Font_.Fonts_T,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Expanded(
                                                    //   flex: 2,
                                                    //   child: Text(
                                                    //     // '${transMeterModels[index].c_pvat}',
                                                    //     '${nFormat.format(double.parse(transMeterModels[index].c_pvat!))}',
                                                    //     textAlign: TextAlign.right,
                                                    //     style: const TextStyle(
                                                    //       color: ManageScreen_Color
                                                    //           .Colors_Text2_,
                                                    //       // fontWeight:
                                                    //       //     FontWeight.bold,
                                                    //       fontFamily: Font_.Fonts_T,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            electricityHistoryModels
                                                                .clear();
                                                            unit1 = 0;
                                                            unit2 = 0;
                                                            unit3 = 0;
                                                            unit4 = 0;
                                                            unit5 = 0;
                                                            unit6 = 0;
                                                            sum1 = 0;
                                                            sum2 = 0;
                                                            sum3 = 0;
                                                            sum4 = 0;
                                                            sum5 = 0;
                                                            sum6 = 0;
                                                            unit = 0;
                                                            unit1c = 0;
                                                            unit2c = 0;
                                                            unit3c = 0;
                                                            unit4c = 0;
                                                            unit5c = 0;
                                                            unit6c = 0;
                                                            ele_tf = 0.0000;
                                                            ele_other = 0;
                                                            ele_vat = 0;
                                                            ele_one = 0;
                                                            ele_mit_one = 0;
                                                            ele_gob_one = 0;
                                                            ele_two = 0;
                                                            ele_mit_two = 0;
                                                            ele_gob_two = 0;
                                                            ele_three = 0;
                                                            ele_mit_three = 0;
                                                            ele_gob_three = 0;
                                                            ele_tour = 0;
                                                            ele_mit_tour = 0;
                                                            ele_gob_tour = 0;
                                                            ele_five = 0;
                                                            ele_mit_five = 0;
                                                            ele_gob_five = 0;
                                                            ele_six = 0;
                                                            ele_mit_six = 0;
                                                            ele_gob_six = 0;
                                                            sum = 0;
                                                            sum_n = 0;
                                                            sum_f = 0;
                                                            sum_per = 0;
                                                            sum_all = 0;
                                                          });
                                                          showmiter(index);
                                                        },
                                                        child: Text(
                                                          '${nFormat.format(double.parse(transMeterModels[index].c_amt!))}',
                                                          //'${transMeterModels[index].c_amt}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style:
                                                              const TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 2, 8, 2),
                                                          child: InkWell(
                                                            child: Container(
                                                              // height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: (transMeterModels[index]
                                                                            .img !=
                                                                        '')
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .green,
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Center(
                                                                child: Translate.TranslateAndSetText(
                                                                    (transMeterModels[index]
                                                                                .img !=
                                                                            '')
                                                                        ? 'ดู/แก้ไข'
                                                                        : 'เพิ่ม',
                                                                    ManageScreen_Color
                                                                        .Colors_Text1_,
                                                                    TextAlign
                                                                        .right,
                                                                    FontWeight
                                                                        .bold,
                                                                    FontWeight_
                                                                        .Fonts_T,
                                                                    14,
                                                                    2),

                                                                // Text(
                                                                //   (transMeterModels[index]
                                                                //               .img !=
                                                                //           '')
                                                                //       ? 'ดู/แก้ไข'
                                                                //       : 'เพิ่ม',
                                                                //   //'${transMeterModels[index].c_amt}',
                                                                //   textAlign:
                                                                //       TextAlign
                                                                //           .right,
                                                                //   style:
                                                                //       const TextStyle(
                                                                //     color: ManageScreen_Color
                                                                //         .Colors_Text2_,
                                                                //     fontWeight:
                                                                //         FontWeight
                                                                //             .bold,
                                                                //     fontFamily:
                                                                //         Font_
                                                                //             .Fonts_T,
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              if (renTal_lavel <=
                                                                  1) {
                                                                infomation();
                                                              } else {
                                                                var doc =
                                                                    transMeterModels[
                                                                            index]
                                                                        .docno;
                                                                var cid =
                                                                    transMeterModels[
                                                                            index]
                                                                        .refno;
                                                                var ser =
                                                                    transMeterModels[
                                                                            index]
                                                                        .ser;
                                                                print(
                                                                    '$ser /// $doc // $cid   //   ');

                                                                if (transMeterModels[
                                                                            index]
                                                                        .img !=
                                                                    '') {
                                                                  Dialog_img_Meter(
                                                                      doc,
                                                                      cid,
                                                                      ser,
                                                                      index);
                                                                } else {
                                                                  uploadFile_Slip(
                                                                      doc,
                                                                      cid,
                                                                      ser);
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
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
                                decoration: BoxDecoration(
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
                                      color: tappedIndex_ == index
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
                                              tappedIndex_ = index;
                                            });
                                          },
                                          contentPadding:
                                              const EdgeInsets.all(0.0),
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
                                                        : maintenanceModels[
                                                                        index]
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: InkWell(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: maintenanceModels[
                                                                          index]
                                                                      .mst ==
                                                                  '2'
                                                              ? Colors.green
                                                              : Colors
                                                                  .grey[100],
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
                                                          // border: Border.all(
                                                          //     color: Colors.grey, width: 1),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: const Text(
                                                          'เรียกดู',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: ManageScreen_Color
                                                                .Colors_Text2_,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T,
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        if (maintenanceModels[
                                                                    index]
                                                                .mst
                                                                .toString() ==
                                                            '2') {
                                                          showDialog<void>(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false, // user must tap button!
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
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
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: <Widget>[
                                                                        Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'วันที่ดำเนินการ : ${maintenanceModels[index].rdate}',
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: ManageScreen_Color.Colors_Text2_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
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
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                color: ManageScreen_Color.Colors_Text2_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T,
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
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.redAccent,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextButton(
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
                                                        }

                                                        ////////////////////-------------------------------------------------------------->
                                                        if (maintenanceModels[
                                                                    index]
                                                                .mst
                                                                .toString() ==
                                                            '1')
                                                          showDialog<void>(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false, // user must tap button!
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20.0))),
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
                                                                      fontFamily:
                                                                          Font_
                                                                              .Fonts_T,
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: <Widget>[
                                                                        Row(
                                                                          children: [
                                                                            //_select_Date
                                                                            const Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                'วันที่แก้ไข:',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: ManageScreen_Color.Colors_Text2_,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            StreamBuilder(
                                                                                stream: Stream.periodic(const Duration(seconds: 0)),
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
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              TextFormField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            controller:
                                                                                Formbecause_,
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null || value.isEmpty) {
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
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.green,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextButton(
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
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Colors.redAccent,
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: TextButton(
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
                                                ),
                                              ],
                                            ),
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

  double unit1 = 0,
      unit2 = 0,
      unit3 = 0,
      unit4 = 0,
      unit5 = 0,
      unit6 = 0,
      sum1 = 0,
      sum2 = 0,
      sum3 = 0,
      sum4 = 0,
      sum5 = 0,
      sum6 = 0,
      unit = 0,
      unit1c = 0,
      unit2c = 0,
      unit3c = 0,
      unit4c = 0,
      unit5c = 0,
      unit6c = 0,
      ele_tf = 0.0000,
      ele_other = 0,
      ele_vat = 0,
      ele_one = 0,
      ele_mit_one = 0,
      ele_gob_one = 0,
      ele_two = 0,
      ele_mit_two = 0,
      ele_gob_two = 0,
      ele_three = 0,
      ele_mit_three = 0,
      ele_gob_three = 0,
      ele_tour = 0,
      ele_mit_tour = 0,
      ele_gob_tour = 0,
      ele_five = 0,
      ele_mit_five = 0,
      ele_gob_five = 0,
      ele_six = 0,
      ele_mit_six = 0,
      ele_gob_six = 0,
      sum = 0,
      sum_n = 0,
      sum_f = 0,
      sum_per = 0,
      sum_all = 0;

  Future<dynamic> showmiter(int indextran) async {
    var qser_in = transMeterModels[indextran].ser_in;
    var expname = transMeterModels[indextran].expname;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_electricity_history.php?isAdd=true&ren=$ren&qser_in=$qser_in';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ElectricityHistoryModel electricityHistoryModel =
              ElectricityHistoryModel.fromJson(map);
          setState(() {
            electricityHistoryModels.add(electricityHistoryModel);
          });
        }
      } else {}
    } catch (e) {}

    if (electricityHistoryModels.isEmpty) {
      return null;
    } else {
      setState(() {
        unit = double.parse(electricityHistoryModels[0].edit_new!);

        unit1c = double.parse(electricityHistoryModels[0].eleOne!) - 0;
        unit2c = double.parse(electricityHistoryModels[0].eleTwo!) -
            double.parse(electricityHistoryModels[0].eleOne!);
        unit3c = double.parse(electricityHistoryModels[0].eleThree!) -
            double.parse(electricityHistoryModels[0].eleTwo!);
        unit4c = double.parse(electricityHistoryModels[0].eleTour!) -
            double.parse(electricityHistoryModels[0].eleThree!);
        unit5c = double.parse(electricityHistoryModels[0].eleFive!) -
            double.parse(electricityHistoryModels[0].eleTour!);
        unit6c = unit - double.parse(electricityHistoryModels[0].eleSix!);

        ele_tf = double.parse(electricityHistoryModels[0].eleTf!);
        ele_other = double.parse(electricityHistoryModels[0].other!);
        ele_vat = double.parse(electricityHistoryModels[0].vat!);

        ele_one = double.parse(electricityHistoryModels[0].eleOne!);
        ele_mit_one = double.parse(electricityHistoryModels[0].eleMitOne!);
        ele_gob_one = double.parse(electricityHistoryModels[0].eleGobOne!);

        ele_two = double.parse(electricityHistoryModels[0].eleTwo!);
        ele_mit_two = double.parse(electricityHistoryModels[0].eleMitTwo!);
        ele_gob_two = double.parse(electricityHistoryModels[0].eleGobTwo!);

        ele_three = double.parse(electricityHistoryModels[0].eleThree!);
        ele_mit_three = double.parse(electricityHistoryModels[0].eleMitThree!);
        ele_gob_three = double.parse(electricityHistoryModels[0].eleGobThree!);

        ele_tour = double.parse(electricityHistoryModels[0].eleTour!);
        ele_mit_tour = double.parse(electricityHistoryModels[0].eleMitTour!);
        ele_gob_tour = double.parse(electricityHistoryModels[0].eleGobTour!);

        ele_five = double.parse(electricityHistoryModels[0].eleFive!);
        ele_mit_five = double.parse(electricityHistoryModels[0].eleMitFive!);
        ele_gob_five = double.parse(electricityHistoryModels[0].eleGobFive!);

        ele_six = double.parse(electricityHistoryModels[0].eleSix!);
        ele_mit_six = double.parse(electricityHistoryModels[0].eleMitSix!);
        ele_gob_six = double.parse(electricityHistoryModels[0].eleGobSix!);
      });

      if (unit > unit1c) {
        setState(() {
          unit1 = unit - unit1c;
        });

        if (ele_gob_one != 0.00) {
          setState(() {
            sum1 = ele_gob_one;
          });
        } else {
          setState(() {
            sum1 = unit1c * ele_mit_one;
          });
        }
      } else {
        if (ele_gob_one != 0.00) {
          setState(() {
            sum1 = ele_gob_one;
          });
        } else {
          setState(() {
            sum1 = unit * ele_mit_one;
          });
        }
      }

      if (unit1 >= unit2c) {
        setState(() {
          unit2 = unit1 - unit2c;
        });

        if (ele_gob_two != 0.00) {
          setState(() {
            sum2 = ele_gob_two;
          });
        } else {
          setState(() {
            sum2 = unit2c * ele_mit_two;
          });
        }
      } else {
        if (ele_gob_two != 0.00) {
          setState(() {
            sum2 = ele_gob_two;
          });
        } else {
          setState(() {
            sum2 = unit1 * ele_mit_two;
          });
        }
      }

      if (unit2 >= unit3c) {
        setState(() {
          unit3 = unit2 - unit3c;
        });
        if (ele_gob_three != 0.00) {
          setState(() {
            sum3 = ele_gob_three;
          });
        } else {
          setState(() {
            sum3 = unit3c * ele_mit_three;
          });
        }
      } else {
        if (ele_gob_three != 0.00) {
          setState(() {
            sum3 = ele_gob_three;
          });
        } else {
          setState(() {
            sum3 = unit2 * ele_mit_three;
          });
        }
      }

      if (unit3 >= unit4c) {
        setState(() {
          unit4 = unit3 - unit4c;
        });

        if (ele_gob_tour != 0.00) {
          setState(() {
            sum4 = ele_gob_tour;
          });
        } else {
          setState(() {
            sum4 = unit4c * ele_mit_tour;
          });
        }
      } else {
        if (ele_gob_tour != 0.00) {
          setState(() {
            sum4 = ele_gob_tour;
          });
        } else {
          setState(() {
            sum4 = unit3 * ele_mit_tour;
          });
        }
      }

      if (unit4 >= unit5c) {
        setState(() {
          unit5 = unit4 - unit5c;
        });

        if (ele_gob_five != 0.00) {
          setState(() {
            sum5 = ele_gob_five;
          });
        } else {
          setState(() {
            sum5 = unit5c * ele_mit_five;
          });
        }
      } else {
        if (ele_gob_five != 0.00) {
          setState(() {
            sum5 = ele_gob_five;
          });
        } else {
          setState(() {
            sum5 = unit4 * ele_mit_five;
          });
        }
      }

      if (unit5 >= unit6c) {
        setState(() {
          unit6 = unit5 - unit6c;
        });

        if (ele_gob_six != 0.00) {
          setState(() {
            sum6 = ele_gob_six;
          });
        } else {
          setState(() {
            sum6 = unit6c * ele_mit_six;
          });
        }
      } else {
        if (ele_gob_six != 0.00) {
          setState(() {
            sum6 = ele_gob_six;
          });
        } else {
          setState(() {
            sum6 = unit5 * ele_mit_six;
          });
        }
      }

      // if (unit5 >= unit6c) {
      //   if (ele_gob_six != 0.00) {
      //     setState(() {
      //       sum6 = ele_gob_six;
      //     });
      //   } else {
      //     setState(() {
      //       sum6 = unit6c * ele_mit_six;
      //     });
      //   }
      // }
      setState(() {
        if (sum6 < 0) {
          sum = sum1 + sum2 + sum3 + sum4 + sum5;
        } else {
          sum = sum1 + sum2 + sum3 + sum4 + sum5 + sum6;
        }
      });
      setState(() {
        sum_n = sum + ele_other;
      });
      setState(() {
        sum_f = unit * ele_tf;
      });
      setState(() {
        sum_per = (sum_n + sum_f) * ele_vat / 100;
      });
      setState(() {
        sum_all = sum_n + sum_f + sum_per;
      });

      return showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                // ignore: unnecessary_string_interpolations
                                '${DateFormat.MMMM('th_TH').format((DateTime.parse('${transMeterModels[indextran].date} 00:00:00')))} ${DateTime.parse('${transMeterModels[indextran].date} 00:00:00').year + 543}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'หน่วยที่ใช้ไป : ',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                '$unit',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'หน่วย',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      (unit - unit1) == 0 || sum1 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: 'หน่วยที่ 0-$ele_one',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_one == 0
                                              ? ' (เหมาจ่าย $ele_gob_one บาท)'
                                              : ' (หน่วยละ $ele_mit_one บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit - unit1} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum1)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit1 - unit2) == 0 || sum2 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_one + 1)} - $ele_two',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_two == 0
                                              ? ' (เหมาจ่าย $ele_gob_two บาท)'
                                              : ' (หน่วยละ $ele_mit_two บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit1 - unit2} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum2)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit2 - unit3) == 0 || sum3 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_two + 1)} - $ele_three',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_three == 0
                                              ? ' (เหมาจ่าย $ele_gob_three บาท)'
                                              : ' (หน่วยละ $ele_mit_three บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit2 - unit3} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum3)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit3 - unit4) == 0 || sum4 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_three + 1)} - $ele_tour',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_tour == 0
                                              ? ' (เหมาจ่าย $ele_gob_tour บาท)'
                                              : ' (หน่วยละ $ele_mit_tour บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit3 - unit4} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum4)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit4 - unit5) == 0 || sum5 <= 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 4,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text:
                                          'หน่วยที่ ${(ele_tour + 1)} - $ele_five',
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text2_,
                                          fontFamily: Font_.Fonts_T),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ele_mit_five == 0
                                              ? ' (เหมาจ่าย $ele_gob_five บาท)'
                                              : ' (หน่วยละ $ele_mit_five บาท)',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${unit4 - unit5} หน่วย',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${nFormat.format(sum5)}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'บาท',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      (unit5 - unit6) == 0 || sum6 <= 0
                          ? SizedBox()
                          : sum6 < 0
                              ? SizedBox()
                              : Row(
                                  children: [
                                    Expanded(flex: 1, child: Text('')),
                                    Expanded(
                                      flex: 4,
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          text: 'หน่วยที่ $ele_six ขึ้นไป',
                                          style: TextStyle(
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ele_mit_six == 0
                                                  ? ' (เหมาจ่าย $ele_gob_six บาท)'
                                                  : ' (หน่วยละ $ele_mit_six บาท)',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: Font_.Fonts_T),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${unit5 - unit6} หน่วย',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${nFormat.format(sum6)}',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'บาท',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                      ),
                                    ),
                                  ],
                                ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'เงิน$expnameฐาน',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: 'ค่า Ft',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ( $ele_tf ) บาท/หน่วย',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_f)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'ค่าบริการรายเดือน',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(ele_other)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Divider(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: 'ภาษีมูลค่าเพิ่ม',
                                style: TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    fontFamily: Font_.Fonts_T),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${nFormat.format(ele_vat)} % (VAT)',
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text2_,
                                        fontFamily: Font_.Fonts_T),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_per)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Divider(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'รวมเงิน$expnameเดือนปัจจุบัน',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: Font_.Fonts_T,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_all)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'รวมเงินทั้งสิ้น',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              ' ',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${nFormat.format(sum_all)}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'บาท',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: PeopleChaoScreen_Color.Colors_Text2_,
                                fontFamily: FontWeight_.Fonts_T,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  Future<dynamic> showcountmiter(int index) async {
    var ser = transMeterModels[index].ele_ty;
    if (electricityModels.isNotEmpty) {
      electricityModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_electricity.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        for (var map in result) {
          ElectricityModel electricityModel = ElectricityModel.fromJson(map);

          if (electricityModel.ser == ser) {
            setState(() {
              electricityModels.add(electricityModel);
            });
          }
        }
      } else {}
    } catch (e) {}

    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              // ignore: unnecessary_string_interpolations
                              'อัตราการคำนวณปัจจุบัน',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: PeopleChaoScreen_Color.Colors_Text2_,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    (double.parse(electricityModels[0].eleMitOne!) +
                                double.parse(
                                    electricityModels[0].eleGobOne!)) ==
                            0.00
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(flex: 1, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'หน่วยที่ 0 - ${electricityModels[0].eleOne}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitOne!) ==
                                          0.00
                                      ? 'เหมาจ่าย'
                                      : 'หน่วยละ',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitOne!) ==
                                          0.00
                                      ? '${electricityModels[0].eleGobOne}'
                                      : '${electricityModels[0].eleMitOne}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'บาท',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    (double.parse(electricityModels[0].eleMitTwo!) +
                                double.parse(
                                    electricityModels[0].eleGobTwo!)) ==
                            0.00
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(flex: 1, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'หน่วยที่ ${int.parse(electricityModels[0].eleOne!) + 1} - ${electricityModels[0].eleTwo}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitTwo!) ==
                                          0.00
                                      ? 'เหมาจ่าย'
                                      : 'หน่วยละ',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitTwo!) ==
                                          0.00
                                      ? '${electricityModels[0].eleGobTwo}'
                                      : '${electricityModels[0].eleMitTwo}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'บาท',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    (double.parse(electricityModels[0].eleMitThree!) +
                                double.parse(
                                    electricityModels[0].eleGobThree!)) ==
                            0.00
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(flex: 1, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'หน่วยที่ ${int.parse(electricityModels[0].eleTwo!) + 1} - ${electricityModels[0].eleThree}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitThree!) ==
                                          0.00
                                      ? 'เหมาจ่าย'
                                      : 'หน่วยละ',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitThree!) ==
                                          0.00
                                      ? '${electricityModels[0].eleGobThree}'
                                      : '${electricityModels[0].eleMitThree}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'บาท',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    (double.parse(electricityModels[0].eleMitTour!) +
                                double.parse(
                                    electricityModels[0].eleGobTour!)) ==
                            0.00
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(flex: 1, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'หน่วยที่ ${int.parse(electricityModels[0].eleThree!) + 1} - ${electricityModels[0].eleTour}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitTour!) ==
                                          0.00
                                      ? 'เหมาจ่าย'
                                      : 'หน่วยละ',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitTour!) ==
                                          0.00
                                      ? '${electricityModels[0].eleGobTour}'
                                      : '${electricityModels[0].eleMitTour}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'บาท',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    (double.parse(electricityModels[0].eleMitFive!) +
                                double.parse(
                                    electricityModels[0].eleGobFive!)) ==
                            0.00
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(flex: 1, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'หน่วยที่ ${int.parse(electricityModels[0].eleTour!) + 1} - ${electricityModels[0].eleFive}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitFive!) ==
                                          0.00
                                      ? 'เหมาจ่าย'
                                      : 'หน่วยละ',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitFive!) ==
                                          0.00
                                      ? '${electricityModels[0].eleGobFive}'
                                      : '${electricityModels[0].eleMitFive}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'บาท',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    (double.parse(electricityModels[0].eleMitSix!) +
                                double.parse(
                                    electricityModels[0].eleGobSix!)) ==
                            0.00
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(flex: 1, child: Text('')),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'หน่วยที่ ${electricityModels[0].eleSix} ขึ้นไป',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitSix!) ==
                                          0.00
                                      ? 'เหมาจ่าย'
                                      : 'หน่วยละ',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  double.parse(electricityModels[0]
                                              .eleMitSix!) ==
                                          0.00
                                      ? '${electricityModels[0].eleGobSix}'
                                      : '${electricityModels[0].eleMitSix}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'บาท',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
                                      fontFamily: Font_.Fonts_T),
                                ),
                              ),
                            ],
                          ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              // ignore: unnecessary_string_interpolations
                              '* อัตราคำนวณปัจจุบันอาจไม่ตรงกับยอดชำระ ณ วันที่บันทึก',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: Font_.Fonts_T),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
