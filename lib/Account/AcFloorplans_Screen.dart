import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chaoperty/Model/GetSubZone_Model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:slide_switcher/slide_switcher.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../ChaoArea/loadSvgImage.dart';
import '../Constant/Myconstant.dart';
import '../INSERT_Log/Insert_log.dart';
import '../Man_PDF/Man_Pay_Receipt_PDF.dart';
import '../Model/GetArea_Model.dart';
import '../Model/GetArea_quot.dart';
import '../Model/GetAreax_con_Model.dart';
import '../Model/GetFinnancetrans_Model.dart';
import '../Model/GetOverdue_floorplans_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Model/trans_re_bill_history_model.dart';
import '../Model/trans_re_bill_model.dart';
import '../Responsive/responsive.dart';
import '../Style/colors.dart';
import 'loadSvgImageOverdue.dart';

class AcFloorplans_Screen extends StatefulWidget {
  final updateMessage;
  const AcFloorplans_Screen({super.key, this.updateMessage});

  @override
  State<AcFloorplans_Screen> createState() => _AcFloorplans_ScreenState();
}

class _AcFloorplans_ScreenState extends State<AcFloorplans_Screen> {
  // List<GlobalKey> _btnKeys = [];
  var nFormat = NumberFormat("#,##0.00", "en_US");
  DateTime datex = DateTime.now();
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  ///////---------------------------------------------------->
  String? ser_Floor_plans;
  List<ZoneModel> zoneModels = [];
  List<Overdue_floorplansModel> areaModelsOverdue = [];
  List<Overdue_floorplansModel> areaModelsAll = [];
  List<TransReBillModel> _TransReBillModels = [];
  List<AreaQuotModel> areaQuotModels = [];
  List<Overdue_floorplansModel> areaFloorplanModels = [];
  List<Overdue_floorplansModel> _areaModels = <Overdue_floorplansModel>[];
  List<RenTalModel> renTalModels = [];
  List<SubZoneModel> subzoneModels = [];
  List<AreaxConModel> areaxConModels = [];
  List<TeNantModel> teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  final Formbecause_ = TextEditingController();
  String? renTal_user,
      renTal_name,
      zone_ser,
      zone_name,
      Value_cid,
      Ln_name,
      Img_Zone,
      Imgfloorplan,
      zone_Subser,
      zone_Subname,
      Value_stasus,
      pdate;

  String? ser_user,
      foder,
      position_user,
      fname_user,
      lname_user,
      email_user,
      utype_user,
      permission_user,
      tel_user,
      img_,
      img_logo;

  String? Name_, Img_, Img_logo_, Province_, DBN_, Typex_, Img_rental_;
  String? rtname, type, typex, renname, pkname, ser_Zonex;
  int? pkqty, pkuser, countarae;
  String? bill_name,
      bill_addr,
      bill_tax,
      bill_tel,
      bill_email,
      expbill,
      expbill_name,
      bill_default,
      bill_tser,
      bills_name_,
      newValuePDFimg_QR;
  var Value_Daily;
  double sum_pvat = 0.00,
      sum_vat = 0.00,
      sum_wht = 0.00,
      sum_amt = 0.00,
      sum_dis = 0.00,
      sum_disamt = 0.00,
      sum_disp = 0,
      dis_sum_Matjum = 0.00;
  String? Slip_status, resultqr, numdoctax, tem_page_ser;
  String? base64_Slip, fileName_Slip, Slip_history;
  String? teNantcid, teNantsname, teNantnamenew;
  String? numinvoice,
      paymentSer1,
      paymentName1,
      paymentSer2,
      paymentName2,
      cFinn,
      Value_newDateY = '',
      Value_newDateD = '',
      Value_newDateY1 = '',
      Value_newDateD1 = '';
  @override
  void initState() {
    super.initState();
    checkPreferance();
    read_GC_Sub_zone();
    read_GC_zone();
    read_GC_area();
    read_GC_rental();

    _areaModels = areaModelsOverdue;
  }

  /////////////----------------------------------------->
  // List<Country> countries = [];
  Overdue_floorplansModel? areaFloorplanModelss;
  TransformationController _controller = TransformationController();
  Key _countriesKey = UniqueKey();
  void _zoomInSVG() {
    _controller.value *= Matrix4.identity()..scale(1.2);
  }

  void _zoomOutSVG() {
    _controller.value *= Matrix4.identity()..scale(0.8);
  }

  //////////////---------------------------------------------->

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

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
    });
  }

  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      //  print(result);
      if (result != null) {
        for (var map in result) {
          RenTalModel renTalModel = RenTalModel.fromJson(map);
          var rtnamex = renTalModel.rtname;
          var typexs = renTalModel.type;
          var typexx = renTalModel.typex;
          var name = renTalModel.pn!.trim();
          var pkqtyx = int.parse(renTalModel.pkqty!);
          var pkuserx = int.parse(renTalModel.pkuser!);
          var pkx = renTalModel.pk!.trim();
          var foderx = renTalModel.dbn;
          var img = renTalModel.img;
          var imglogo = renTalModel.imglogo;

          var billNamex = renTalModel.bill_name!.trim();
          var billAddrx = renTalModel.bill_addr!.trim();
          var billTaxx = renTalModel.bill_tax!.trim();
          var billTelx = renTalModel.bill_tel!.trim();
          var billEmailx = renTalModel.bill_email!.trim();
          var billDefaultx = renTalModel.bill_default;
          var billTserx = renTalModel.tser;

          setState(() {
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkqty = pkqtyx;
            pkuser = pkuserx;
            DBN_ = renTalModel.dbn;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            ser_Floor_plans = renTalModel.Floor_plans!;
            bill_name = billNamex;
            bill_addr = billAddrx;
            bill_tax = billTaxx;
            bill_tel = billTelx;
            bill_email = billEmailx;
            bill_default = billDefaultx;
            bill_tser = billTserx;
            tem_page_ser = renTalModel.tem_page!.trim();
            renTalModels.add(renTalModel);
            if (billDefaultx == 'P') {
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

  // Future<Null> read_GC_rental() async {
  //   if (renTalModels.isNotEmpty) {
  //     renTalModels.clear();
  //   }

  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var ren = preferences.getString('renTalSer');
  //   String url =
  //       '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ren=$ren';
  //   renTal_name = preferences.getString('renTalName');
  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     // print(result);
  //     if (result != null) {
  //       for (var map in result) {
  //         RenTalModel renTalModel = RenTalModel.fromJson(map);
  //         var rtnamex = renTalModel.rtname!.trim();
  //         var typexs = renTalModel.type!.trim();
  //         var typexx = renTalModel.typex!.trim();
  //         var billNamex = renTalModel.bill_name!.trim();
  //         var billAddrx = renTalModel.bill_addr!.trim();
  //         var billTaxx = renTalModel.bill_tax!.trim();
  //         var billTelx = renTalModel.bill_tel!.trim();
  //         var billEmailx = renTalModel.bill_email!.trim();
  //         var billDefaultx = renTalModel.bill_default;
  //         var billTserx = renTalModel.tser;
  //         var name = renTalModel.pn!.trim();
  //         var foderx = renTalModel.dbn;
  //         setState(() {
  //           foder = foderx;
  //           rtname = rtnamex;
  //           type = typexs;
  //           typex = typexx;
  //           renname = name;
  //           bill_name = billNamex;
  //           bill_addr = billAddrx;
  //           bill_tax = billTaxx;
  //           bill_tel = billTelx;
  //           bill_email = billEmailx;
  //           bill_default = billDefaultx;
  //           bill_tser = billTserx;
  //           tem_page_ser = renTalModel.tem_page!.trim();
  //           renTalModels.add(renTalModel);
  //           if (billDefaultx == 'P') {
  //             bills_name_ = 'บิลธรรมดา';
  //           } else {
  //             bills_name_ = 'ใบกำกับภาษี';
  //           }
  //         });
  //       }
  //     } else {}
  //   } catch (e) {}
  //   // print('name>>>>>  $renname');
  // }

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
    int selectedIndex = zoneModels.indexWhere(
        (element) => element.ser == zone_ser && element.zn == zone_name);

    // print('Selected index: $selectedIndex');
    if (selectedIndex == 0) {
    } else {
      Img_Zone =
          '${MyConstant().domain}/files/${DBN_}/zone/${zoneModels[selectedIndex].img}';
      // Img_Zone =
      //     'https://dzentric.com/chao_perty/chao_api/files/${DBN_}/zone/${zoneModels[selectedIndex].img}';
      Imgfloorplan =
          '${MyConstant().domain}/files/${DBN_}/zone/${zoneModels[selectedIndex].img_floorplan}';
    }

    setState(() {
      areaFloorplanModels.clear;
      read_GC_areaOverdue();
    });
  }

  Future<Null> read_GC_areaOverdue() async {
    var datex_Now = (Value_Daily == null)
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse('${datex}'))
        : Value_Daily;
    if (areaModelsOverdue.length != 0) {
      setState(() {
        areaModelsOverdue.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    String url =
        '${MyConstant().domain}/GC_Overduefloor.php?isAdd=true&ren=$ren&serzone=$zone&date_value=$Value_Daily';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          Overdue_floorplansModel areaModel =
              Overdue_floorplansModel.fromJson(map);

          setState(() {
            areaModelsOverdue.add(areaModel);
          });
        }

        if (zone == null || zone == '0') {
          setState(() {
            areaFloorplanModels.clear();
          });
        } else {}
      } else {}

      // _btnKeys = List.generate(areaModels.length, (_) => GlobalKey());
      print(
          'zoneModels >>. ${zoneModels.length} ${areaModelsOverdue.map((e) => e.zser).toString()}');
    } catch (e) {}
  }

  Future<Null> read_GC_area() async {
    if (areaModelsAll.length != 0) {
      setState(() {
        areaModelsAll.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    //print('zone >>>>>> $zone');

    String url = zone == null
        ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_areaAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_area.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print('read_GC_area ====>  $result');
      if (result != null) {
        for (var map in result) {
          Overdue_floorplansModel areaModel =
              Overdue_floorplansModel.fromJson(map);

          setState(() {
            areaModelsAll.add(areaModel);
          });
        }
        setState(() {
          loadSvg();
        });
      } else {}
    } catch (e) {}
  }

  ///Overdue_floorplans
  void loadSvg() async {
    setState(() {
      areaFloorplanModels.clear();
      areaFloorplanModels.clear();
    });

    // Update the key of the KeyedSubtree widget
    _countriesKey = UniqueKey();

    List<Overdue_floorplansModel> loadedCountries = await loadSvgImageOverdue(
        svgImage: '$Imgfloorplan',
        areaModelsOverdue: areaModelsOverdue,
        areaModelsAll: areaModelsAll);
    // print(
    //     'loadedCountriesloadedCountriesloadedCountries :: ${loadedCountries.length}');
    setState(() {
      areaFloorplanModels = loadedCountries;
    });
    try {
      // for (int index = 0; index < areaModelsAll.length; index++) {
      //   for (int index2 = 0; index2 < areaFloorplanModels.length; index2++) {
      //     print(
      //         ' ${index}:$index2 ${areaModelsAll[index].ln}  ///  ${areaFloorplanModels[index2].ln} ');
      //   }
      // }
    } catch (e) {}
  }

  void onCountrySelected(Overdue_floorplansModel areaFloorplanModel) {
    if (areaFloorplanModel.name == null || areaFloorplanModel.name! == 'null') {
    } else {
      setState(() {
        if (areaFloorplanModelss != areaFloorplanModel) {
          areaFloorplanModelss = areaFloorplanModel;
        } else {
          areaFloorplanModelss = null;
        }
      });
    }
  }

///////////////---------------------->
  Future<Null> red_Trans_bill(Valuecid) async {
    if (_TransReBillModels.length != 0) {
      setState(() {
        _TransReBillModels.clear();
      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = Valuecid;
    var da_tex = (Value_Daily == null)
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse('${datex}'))
        : Value_Daily;
    String url =
        '${MyConstant().domain}/GC_bill_pay_BCFloorP.php?isAdd=true&ren=$ren&cid=$ciddoc&dat_e=$da_tex';
    // String url =
    //     '${MyConstant().domain}/GC_bill_pay_BC.php?isAdd=true&ren=$ren';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print('result $ciddoc');
      if (result.toString() != 'null') {
        for (var map in result) {
          TransReBillModel transReBillModel = TransReBillModel.fromJson(map);
          if (transReBillModel.pos != '1') {
            setState(() {
              _TransReBillModels.add(transReBillModel);
            });
          }
        }

        print('result ${_TransReBillModels.length}');
      }
    } catch (e) {}
  }

  /////////////////////---------------------------->
  Future<Null> _select_Date_Daily(BuildContext context) async {
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
    picked.then((result) async {
      if (picked != null) {
        // TransReBillModels = [];

        var formatter = DateFormat('y-MM-d');
        print("${formatter.format(result!)}");
        setState(() {
          Value_Daily = "${formatter.format(result)}";
        });
        setState(() {
          checkPreferance();
          read_GC_Sub_zone();
          read_GC_zone();
          read_GC_area();
          read_GC_rental();
        });
      }
    });
  }

//////////--------------------->
  List<TransReBillHistoryModel> _TransReBillHistoryModels = [];
  List<FinnancetransModel> finnancetransModels = [];

  Future<Null> red_Invoice(index) async {
    if (finnancetransModels.length != 0) {
      setState(() {
        finnancetransModels.clear();
        sum_disamt = 0;
        sum_disp = 0;
        dis_sum_Matjum = 0.00;
      });
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var ciddoc = _TransReBillModels[index].ser;
    var qutser = _TransReBillModels[index].ser_in;
    var docnoin = _TransReBillModels[index].docno; //.toString().trim()
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

          setState(() {
            Slip_history = finnancetransModel.slip.toString();
            pdate = pdatex;
            if (int.parse(finnancetransModel.receiptSer!) != 0) {
              finnancetransModels.add(finnancetransModel);
            } else {
              if (finnancetransModel.type!.trim() == 'DISCOUNT') {
                sum_disamt = sidamt;
                sum_disp = siddisper;
              }
            }
          });
          if (finnancetransModel.dtype! == 'MM') {
            setState(() {
              dis_sum_Matjum =
                  dis_sum_Matjum + double.parse(finnancetransModel.amt!);
            });
          }
          print(
              '>>>>> ${finnancetransModel.slip}>>>>>>dd>>> in $sidamt $siddisper  ');
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
          var dtypeinvoiceent = _TransReBillHistoryModel.dtype;
          var numinvoiceent = _TransReBillHistoryModel.docno;
          // var sumPvatx = double.parse(_TransReBillHistoryModel.pvat!);
          // var sumVatx = double.parse(_TransReBillHistoryModel.vat!);
          // var sumWhtx = double.parse(_TransReBillHistoryModel.wht!);
          // var sumAmtx = double.parse(_TransReBillHistoryModel.total!);

          var sum_pvatx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.pvat!)
              : 0.0;
          var sum_vatx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.vat!)
              : 0.0;
          var sum_whtx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.wht!)
              : 0.0;
          var sum_amtx = dtypeinvoiceent == 'KP' || dtypeinvoiceent == '!Z'
              ? double.parse(_TransReBillHistoryModel.total!)
              : 0.0;
          // var sum_disamtx = double.parse(_InvoiceHistoryModel.disendbill!);
          // var sum_dispx = double.parse(_InvoiceHistoryModel.disendbillper!);
          // var numinvoiceent = _TransReBillHistoryModel.docno;
          // setState(() {
          //   sum_pvat = sum_pvat + sumPvatx;
          //   sum_vat = sum_vat + sumVatx;
          //   sum_wht = sum_wht + sumWhtx;
          //   sum_amt = sum_amt + sumAmtx;
          //   // sum_disamt = sum_disamtx;
          //   // sum_disp = sum_dispx;
          //   numinvoice = _TransReBillHistoryModel.docno;
          //   numdoctax = _TransReBillHistoryModel.doctax;
          //   _TransReBillHistoryModels.add(_TransReBillHistoryModel);
          // });

          setState(() {
            if (dtypeinvoiceent == 'KP') {
              sum_pvat = sum_pvat + sum_pvatx;
              sum_vat = sum_vat + sum_vatx;
              sum_wht = sum_wht + sum_whtx;
              sum_amt = sum_amt + sum_amtx;
              // sum_disamt = sum_disamtx;
              // sum_disp = sum_dispx;
              numinvoice = _TransReBillHistoryModel.docno;
              numdoctax = _TransReBillHistoryModel.doctax;
              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            } else if (dtypeinvoiceent == '!Z') {
              sum_pvat = sum_pvat + sum_pvatx;
              sum_vat = sum_vat + sum_vatx;
              sum_wht = sum_wht + sum_whtx;
              sum_amt = sum_amt + sum_amtx;
              // sum_disamt = sum_disamtx;
              // sum_disp = sum_dispx;
              numinvoice = _TransReBillHistoryModel.docno;
              numdoctax = _TransReBillHistoryModel.doctax;
              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            } else {
              // total_amt = total_amt + total_amtx;
              _TransReBillHistoryModels.add(_TransReBillHistoryModel);
            }
          });
        }
      }
      // setState(() {
      //   red_Invoice(index);
      // });
    } catch (e) {}
  }

/////////////////------------------------------------>

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
      // print(result);
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
          // red_Trans_bill();
          finnancetransModels.clear();
          Navigator.pop(context);
        });
        setState(() {
          checkPreferance();
          read_GC_Sub_zone();
          read_GC_zone();
          read_GC_area();
          read_GC_rental();
        });
        // print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

/////////////------------------------>
  Future<Null> pPC_finantIbillREbill(tableData00, sname, cname, addr, tax,
      newValuePDFimg, finnancetransModels) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var user = preferences.getString('ser');
    // var ciddoc = widget.Get_Value_cid;
    // var qutser = widget.Get_Value_NameShop_index;

    var numin = numinvoice;
    var doctax;
    String room_number_BillHistory = '';
    // print(
    //     'finnancetransModels>>>zzzz${finnancetransModels.length}>>>>>> $numin');

    String url =
        '${MyConstant().domain}/UPC_finant_billREbill.php?isAdd=true&ren=$ren&user=$user&numin=$numin';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'No') {
        for (var map in result) {
          TransReBillModel cFinnancetransModel = TransReBillModel.fromJson(map);
          setState(() {
            doctax = cFinnancetransModel.doctax;
            numdoctax = cFinnancetransModel.doctax;
          });
          if (cFinnancetransModel.room_number != '' ||
              cFinnancetransModel.room_number != null) {
            setState(() {
              room_number_BillHistory =
                  cFinnancetransModel.room_number.toString();
            });
          }
          // print('zzzzasaaa123454>>>>  $cFinn');
          // print(
          //     'bnobnobnobno123454>>>>  ${cFinnancetransModel.docno}  ////  ${cFinnancetransModel.doctax} ');
        }
        Insert_log.Insert_logs('บัญชี',
            'ประวัติบิล>>เปลี่ยนสถานะบิล(ร้าน:$sname,${numinvoice}-->$doctax)');

        setState(() async {
          _TransReBillHistoryModels.clear();

          sum_pvat = 0.00;
          sum_vat = 0.00;
          sum_wht = 0.00;
          sum_amt = 0.00;
          sum_dis = 0.00;
          sum_disamt = 0.00;
          sum_disp = 0;

          // red_Trans_bill();
          // finnancetransModels.clear();
          Navigator.pop(context);
          Navigator.pop(context);
        });
        setState(() {
          checkPreferance();
          read_GC_Sub_zone();
          read_GC_zone();
          read_GC_area();
          read_GC_rental();
        });
        // print('rrrrrrrrrrrrrr');
      }
    } catch (e) {}
  }

/////////////////////---------------------------->
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Responsive.isDesktop(context))
          ? MediaQuery.of(context).size.width * 0.9
          : 1200,
      height: MediaQuery.of(context).size.height,
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
            child: Container(
              decoration:  BoxDecoration(
                color: AppbackgroundColor.TiTile_Colors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                // border: Border.all(color: Colors.white, width: 1),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  subzoneModels.length == 1
                      ? const SizedBox()
                      : MediaQuery.of(context).size.shortestSide <
                              MediaQuery.of(context).size.width * 1
                          ? const Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'โซน:',
                                  style: TextStyle(
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text1_,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontWeight_.Fonts_T),
                                ),
                              ))
                          : const SizedBox(),
                  subzoneModels.length == 1
                      ? const SizedBox()
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
                                      color:
                                          PeopleChaoScreen_Color.Colors_Text2_,
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
                                  // print(
                                  //     'mmmmm ${zoneSer.toString()} $zonesName');

                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString(
                                      'zoneSubSer', zoneSer.toString());
                                  preferences.setString(
                                      'zonesSubName', zonesName.toString());
                                  preferences.remove("zoneSer");
                                  preferences.remove("zonesName");
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
                  Expanded(
                    flex: 2,
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
                            // print(
                            //     'mmmmm ${zoneSer.toString()} $zonesName');

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
                              checkPreferance();
                              read_GC_Sub_zone();
                              read_GC_zone();
                              read_GC_area();
                              read_GC_rental();
                            });
                          },
                          // onSaved: (value) {
                          //   // selectedValue = value.toString();
                          // },
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'วันที่กำหนดชำระ :',
                      style: TextStyle(
                        color: ReportScreen_Color.Colors_Text2_,
                        // fontWeight: FontWeight.bold,
                        fontFamily: Font_.Fonts_T,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _select_Date_Daily(context);
                        },
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
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (Value_Daily == null)
                                    ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${datex}'))}'
                                    : '$Value_Daily',
                                style: const TextStyle(
                                  color: ReportScreen_Color.Colors_Text2_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: SlideSwitcher(
                  containerBorderRadius: 10,
                  onSelect: (index) async {
                    if (index + 1 == 1 || index + 1 == 2) {
                      widget.updateMessage('1', '', 'PeopleChaoScreen');
                    } else {}
                  },
                  containerHeight: 40,
                  containerWight: 100,
                  containerColor: Colors.grey,
                  children: [
                    const Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                    const Icon(
                      Icons.grid_view_rounded,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.map_outlined,
                      color: Colors.blue[900],
                    )
                  ],
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     widget.updateMessage('1', '', 'PeopleChaoScreen');
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
          //     child: Align(
          //       alignment: Alignment.topRight,
          //       child: Padding(
          //         padding: const EdgeInsets.fromLTRB(4, 4, 2, 0),
          //         child: Container(
          //           width: 100,
          //           decoration: BoxDecoration(
          //             color: Colors.red[700],
          //             borderRadius: const BorderRadius.only(
          //               topLeft: Radius.circular(10),
          //               topRight: Radius.circular(10),
          //               bottomLeft: Radius.circular(10),
          //               bottomRight: Radius.circular(10),
          //             ),
          //             border: Border.all(color: Colors.white, width: 2),
          //           ),
          //           padding: const EdgeInsets.all(2.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: const [
          //               AutoSizeText(
          //                 ' <  ',
          //                 overflow: TextOverflow.ellipsis,
          //                 minFontSize: 8,
          //                 maxFontSize: 14,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                   fontFamily: FontWeight_.Fonts_T,
          //                 ),
          //               ),
          //               AutoSizeText(
          //                 'ย้อนกลับ ',
          //                 overflow: TextOverflow.ellipsis,
          //                 minFontSize: 8,
          //                 maxFontSize: 14,
          //                 style: TextStyle(
          //                   decoration: TextDecoration.underline,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                   fontFamily: FontWeight_.Fonts_T,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          (ser_Floor_plans == '0')
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 600,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          // border: Border.all(color: Colors.grey, width: 1),
                        ),
                        // padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (!Responsive.isDesktop(context))
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            width: 300,
                                                            height: 300,
                                                            child:
                                                                InteractiveViewer(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              scaleEnabled:
                                                                  false,
                                                              trackpadScrollCausesScale:
                                                                  false,
                                                              transformationController:
                                                                  _controller,
                                                              minScale: 0.8,
                                                              maxScale: 2.0,
                                                              constrained: true,
                                                              boundaryMargin:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      double
                                                                          .infinity),
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    width: 300,
                                                                    height: 300,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .grey[50],
                                                                      image:
                                                                          const DecorationImage(
                                                                        image: AssetImage(
                                                                            "images/Floor-plan-try.png"),
                                                                        // fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 80,
                                                                    right: 33,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog<
                                                                            String>(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                            title: const Center(
                                                                                child: Column(
                                                                              children: [
                                                                                Text(
                                                                                  'พื้นที่ : A',
                                                                                  style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                            content: const SingleChildScrollView(
                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                              Text(
                                                                                'สถานะ : เช่าแล้ว',
                                                                                style: TextStyle(
                                                                                    color: AdminScafScreen_Color.Colors_Text1_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ])),
                                                                            actions: <Widget>[
                                                                              Column(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  const Divider(
                                                                                    color: Colors.grey,
                                                                                    height: 4.0,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 100,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Colors.redAccent,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                ),
                                                                                                padding: const EdgeInsets.all(5.0),
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
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            60,
                                                                        color: Colors
                                                                            .red[200]!
                                                                            .withOpacity(0.5),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'A',
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 95,
                                                                    left: 70,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog<
                                                                            String>(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                            title: const Center(
                                                                                child: Column(
                                                                              children: [
                                                                                Text(
                                                                                  'พื้นที่ : B',
                                                                                  style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                            content: const SingleChildScrollView(
                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                              Text(
                                                                                'สถานะ : ว่าง',
                                                                                style: TextStyle(
                                                                                    color: AdminScafScreen_Color.Colors_Text1_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ])),
                                                                            actions: <Widget>[
                                                                              Column(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  const Divider(
                                                                                    color: Colors.grey,
                                                                                    height: 4.0,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 100,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Colors.redAccent,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                ),
                                                                                                padding: const EdgeInsets.all(5.0),
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
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            105,
                                                                        height:
                                                                            45,
                                                                        color: Colors
                                                                            .green[200]!
                                                                            .withOpacity(0.5),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'B',
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 75,
                                                                    left: 72,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog<
                                                                            String>(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                            title: const Center(
                                                                                child: Column(
                                                                              children: [
                                                                                Text(
                                                                                  'พื้นที่ : C',
                                                                                  style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                            content: const SingleChildScrollView(
                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                              Text(
                                                                                'สถานะ : ว่าง',
                                                                                style: TextStyle(
                                                                                    color: AdminScafScreen_Color.Colors_Text1_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ])),
                                                                            actions: <Widget>[
                                                                              Column(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  const Divider(
                                                                                    color: Colors.grey,
                                                                                    height: 4.0,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 100,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Colors.redAccent,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                ),
                                                                                                padding: const EdgeInsets.all(5.0),
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
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            193,
                                                                        height:
                                                                            65,
                                                                        color: Colors
                                                                            .green[200]!
                                                                            .withOpacity(0.5),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'C',
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 75,
                                                                    left: 25,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog<
                                                                            String>(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                            title: const Center(
                                                                                child: Column(
                                                                              children: [
                                                                                Text(
                                                                                  'พื้นที่ : D',
                                                                                  style: TextStyle(color: AdminScafScreen_Color.Colors_Text1_, fontWeight: FontWeight.bold, fontFamily: FontWeight_.Fonts_T),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                            content: const SingleChildScrollView(
                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                              Text(
                                                                                'สถานะ : เช่าแล้ว',
                                                                                style: TextStyle(
                                                                                    color: AdminScafScreen_Color.Colors_Text1_,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    fontFamily: Font_.Fonts_T),
                                                                              ),
                                                                            ])),
                                                                            actions: <Widget>[
                                                                              Column(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  const Divider(
                                                                                    color: Colors.grey,
                                                                                    height: 4.0,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 2.0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 100,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Colors.redAccent,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                ),
                                                                                                padding: const EdgeInsets.all(5.0),
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
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            45,
                                                                        height:
                                                                            100,
                                                                        color: Colors
                                                                            .red[200]!
                                                                            .withOpacity(0.5),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'D',
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: Font_.Fonts_T),
                                                                          ),
                                                                        ),
                                                                      ),
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
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueGrey
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.zoom_in,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed:
                                                                _zoomInSVG,
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.zoom_out,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed:
                                                                _zoomOutSVG,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Floorplans แผนผังพื้นที่ ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ดูสถานะพื้นที่เช่าได้อย่างง่ายดายด้วย Floorplans แผนผังพื้นที่',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text2_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          Font_.Fonts_T),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange[600],
                                                      borderRadius:
                                                          const BorderRadius
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
                                                      // border: Border.all(color: Colors.grey, width: 1),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Text(
                                                      'อัพเกรด ( Upgrade ) ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              Font_.Fonts_T),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (Responsive.isDesktop(context))
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          image: const DecorationImage(
                                            image:
                                                AssetImage("images/Lap2.png"),
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 500,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      width: 400,
                                                      height: 250,
                                                      child: InteractiveViewer(
                                                        alignment:
                                                            Alignment.center,
                                                        scaleEnabled: false,
                                                        trackpadScrollCausesScale:
                                                            false,
                                                        transformationController:
                                                            _controller,
                                                        minScale: 0.8,
                                                        maxScale: 1.5,
                                                        constrained: true,
                                                        boundaryMargin:
                                                            const EdgeInsets
                                                                    .all(
                                                                double
                                                                    .infinity),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: 280,
                                                              height: 280,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      "images/Floor-plan-try.png"),
                                                                  // fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 55,
                                                              right: 150,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20.0))),
                                                                      title: const Center(
                                                                          child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'พื้นที่ : A',
                                                                            style: TextStyle(
                                                                                color: AdminScafScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                      content:
                                                                          const SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: <Widget>[
                                                                            Text(
                                                                              'สถานะ : เช่าแล้ว',
                                                                              style: TextStyle(
                                                                                  color: AdminScafScreen_Color.Colors_Text1_,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                  fontFamily: Font_.Fonts_T),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        Column(
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            const Divider(
                                                                              color: Colors.grey,
                                                                              height: 4.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 100,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Colors.redAccent,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(5.0),
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
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 75,
                                                                  height: 58,
                                                                  color: Colors
                                                                      .red[200]!
                                                                      .withOpacity(
                                                                          0.5),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'A',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 55,
                                                              left: 70,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20.0))),
                                                                      title: const Center(
                                                                          child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'พื้นที่ : B',
                                                                            style: TextStyle(
                                                                                color: AdminScafScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                      content:
                                                                          const SingleChildScrollView(
                                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                        Text(
                                                                          'สถานะ : ว่าง',
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ])),
                                                                      actions: <Widget>[
                                                                        Column(
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            const Divider(
                                                                              color: Colors.grey,
                                                                              height: 4.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 100,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Colors.redAccent,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(5.0),
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
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 105,
                                                                  height: 53,
                                                                  color: Colors
                                                                      .green[
                                                                          200]!
                                                                      .withOpacity(
                                                                          0.5),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'B',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 55,
                                                              left: 65,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20.0))),
                                                                      title: const Center(
                                                                          child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'พื้นที่ : C',
                                                                            style: TextStyle(
                                                                                color: AdminScafScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                      content:
                                                                          const SingleChildScrollView(
                                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                        Text(
                                                                          'สถานะ : ว่าง',
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ])),
                                                                      actions: <Widget>[
                                                                        Column(
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            const Divider(
                                                                              color: Colors.grey,
                                                                              height: 4.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 100,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Colors.redAccent,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(5.0),
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
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 185,
                                                                  height: 65,
                                                                  color: Colors
                                                                      .green[
                                                                          200]!
                                                                      .withOpacity(
                                                                          0.5),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'C',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 50,
                                                              left: 22,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20.0))),
                                                                      title: const Center(
                                                                          child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'พื้นที่ : D',
                                                                            style: TextStyle(
                                                                                color: AdminScafScreen_Color.Colors_Text1_,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: FontWeight_.Fonts_T),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                      content:
                                                                          const SingleChildScrollView(
                                                                              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                        Text(
                                                                          'สถานะ : เช่าแล้ว',
                                                                          style: TextStyle(
                                                                              color: AdminScafScreen_Color.Colors_Text1_,
                                                                              // fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                      ])),
                                                                      actions: <Widget>[
                                                                        Column(
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            const Divider(
                                                                              color: Colors.grey,
                                                                              height: 4.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 2.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 100,
                                                                                          decoration: const BoxDecoration(
                                                                                            color: Colors.redAccent,
                                                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                          ),
                                                                                          padding: const EdgeInsets.all(5.0),
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
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 45,
                                                                  height: 100,
                                                                  color: Colors
                                                                      .red[200]!
                                                                      .withOpacity(
                                                                          0.5),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'D',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              Font_.Fonts_T),
                                                                    ),
                                                                  ),
                                                                ),
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
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.zoom_in,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: _zoomInSVG,
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.zoom_out,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: _zoomOutSVG,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  // color: AppBarColors.ABar_Colors,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  // border: Border.all(color: Colors.grey, width: 1),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white,
                                      // Color.fromARGB(255, 244, 245, 242),
                                      Color.fromARGB(255, 216, 231, 199),
                                      Color.fromARGB(255, 199, 219, 175),
                                      AppBarColors.ABar_Colors,
                                    ],
                                  )),
                              height: 80,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (zone_ser == '0' || zone_ser == null)
                      ? Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: const BoxDecoration(
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 520,
                                          width: 850,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            border: Border.all(
                                                color: Colors.black, width: 5),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'กรุณาเลือกโซนพื้นที่',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        // color: AppBarColors.ABar_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white,
                                            // Color.fromARGB(255, 244, 245, 242),
                                            Color.fromARGB(255, 216, 231, 199),
                                            Color.fromARGB(255, 199, 219, 175),
                                            AppBarColors.ABar_Colors,
                                          ],
                                        )),
                                    height: 80,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.95,
                              decoration: const BoxDecoration(
                                // image: const DecorationImage(
                                //   image: AssetImage("images/pngegg2.png"),
                                //   fit: BoxFit.cover,
                                // ),
                                color: AppbackgroundColor.Sub_Abg_Colors,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      reverse: false,
                                      child: Column(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: RichText(
                                                    text: const TextSpan(
                                                      text:
                                                          'Floorplans แผนผังพื้นที่',
                                                      style: TextStyle(
                                                          // decoration:
                                                          //     TextDecoration
                                                          //         .underline,
                                                          // decorationStyle:
                                                          //     TextDecorationStyle
                                                          //         .dashed,
                                                          fontSize: 20.0,
                                                          color:
                                                              AdminScafScreen_Color
                                                                  .Colors_Text1_,
                                                          fontFamily:
                                                              FontWeight_
                                                                  .Fonts_T),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: ' ค้างชำระ ',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationStyle:
                                                                  TextDecorationStyle
                                                                      .dotted,
                                                              fontSize: 20.0,
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                        TextSpan(
                                                          text: ' / ',
                                                          style: TextStyle(
                                                              // decoration:
                                                              //     TextDecoration
                                                              //         .underline,
                                                              // decorationStyle:
                                                              //     TextDecorationStyle
                                                              //         .dotted,
                                                              fontSize: 20.0,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                        TextSpan(
                                                          text: ' ชำระแล้ว ',
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationStyle:
                                                                  TextDecorationStyle
                                                                      .dotted,
                                                              fontSize: 20.0,
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 510,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: ScrollConfiguration(
                                                  behavior: ScrollConfiguration
                                                          .of(context)
                                                      .copyWith(dragDevices: {
                                                    PointerDeviceKind.touch,
                                                    PointerDeviceKind.mouse,
                                                  }),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
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
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            5),
                                                                  ),
                                                                  child:
                                                                      InteractiveViewer(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    scaleEnabled:
                                                                        false,
                                                                    trackpadScrollCausesScale:
                                                                        false,
                                                                    transformationController:
                                                                        _controller,
                                                                    minScale:
                                                                        0.8,
                                                                    maxScale:
                                                                        2.0,
                                                                    constrained:
                                                                        true,
                                                                    boundaryMargin:
                                                                        const EdgeInsets.all(
                                                                            150.0),
                                                                    // boundaryMargin:
                                                                    //     const EdgeInsets.all(
                                                                    //         double.infinity),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Container(
                                                                          // color: Colors.purple,
                                                                          height:
                                                                              520,
                                                                          width:
                                                                              850,
                                                                          child: KeyedSubtree(
                                                                              key: _countriesKey,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage("$Img_Zone"),
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                                child: Stack(alignment: Alignment.center, children: [
                                                                                  for (var areaModel in areaFloorplanModels)
                                                                                    Stack(
                                                                                      children: [
                                                                                        ClipPath(
                                                                                          clipper: ClipperOverdue(
                                                                                            svgPath: areaModel.path!,
                                                                                            // height:
                                                                                            //     17.0,
                                                                                            // width:
                                                                                            //     26.2,
                                                                                          ),
                                                                                          child: InkWell(
                                                                                            onTap: (areaModelsAll.any((area) {
                                                                                              return area.quantity == null && area.ser.toString().trim() == areaModel.ser;
                                                                                            }))
                                                                                                ? () async {
                                                                                                    int index = areaModelsAll.indexWhere((area) => area.ser.toString().trim() == areaModel.ser);
                                                                                                    dialogFreespace_svg(index, context);
                                                                                                  }
                                                                                                : () async {
                                                                                                    onCountrySelected.call(areaModel);

                                                                                                    if (areaModelsOverdue.any((Overdue) {
                                                                                                      return Overdue.ser_area.toString() == '${areaModel.ser}';
                                                                                                    })) {
                                                                                                      int index = areaModelsOverdue.indexWhere((area) => area.ser_area.toString().trim() == areaModel.ser);
                                                                                                      Future.delayed(const Duration(milliseconds: 150), () {
                                                                                                        dialog_svg(index, context, '1');
                                                                                                      });
                                                                                                    } else {
                                                                                                      int index = areaModelsAll.indexWhere((area) => area.ser.toString().trim() == areaModel.ser);
                                                                                                      print('${areaModelsAll[index].cid}');
                                                                                                      red_Trans_bill('${areaModelsAll[index].cid}');
                                                                                                      Future.delayed(const Duration(milliseconds: 150), () {
                                                                                                        dialog_svg(index, context, '2');
                                                                                                      });
                                                                                                    }
                                                                                                  },
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: (areaModelsAll.any((area) {
                                                                                                  return area.quantity == null && area.ser.toString().trim() == areaModel.ser;
                                                                                                }))
                                                                                                    ? Colors.blueGrey[200]!.withOpacity(0.5)
                                                                                                    : (areaFloorplanModelss?.id == areaModel.id)
                                                                                                        ? (areaModelsOverdue.any((Overdue) {
                                                                                                            return Overdue.ser_area.toString() == '${areaModel.ser}';
                                                                                                          }))
                                                                                                            ? Colors.red[900]!.withOpacity(0.5)
                                                                                                            : Colors.green[900]!.withOpacity(0.5)
                                                                                                        : (areaFloorplanModelss != null)
                                                                                                            ? Colors.grey[200]!.withOpacity(0.4)
                                                                                                            : (areaModelsOverdue.any((Overdue) {
                                                                                                                return Overdue.ser_area.toString() == '${areaModel.ser}';
                                                                                                              }))
                                                                                                                ? Colors.red[200]!.withOpacity(0.5)
                                                                                                                : Colors.green[200]!.withOpacity(0.5),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                ]),
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: RichText(
                                              text: const TextSpan(
                                                text: '**หมายเหตุ : ',
                                                style: TextStyle(
                                                    color: AdminScafScreen_Color
                                                        .Colors_Text1_,
                                                    fontFamily:
                                                        FontWeight_.Fonts_T),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: ' สีเขียว ',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' พื้นที่ชำระแล้วหรือไม่มีรายการที่ต้องชำระ ,',
                                                    style: TextStyle(
                                                        color:
                                                            AdminScafScreen_Color
                                                                .Colors_Text1_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text: ' สีแดง ',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text: ' พื้นที่ค้างชำระ',
                                                    style: TextStyle(
                                                        color:
                                                            AdminScafScreen_Color
                                                                .Colors_Text1_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text: ' สีเทา ',
                                                    style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontFamily: FontWeight_
                                                            .Fonts_T),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' พื้นที่ไม่พบผู้เช่าอยู่หรือไม่มีผู้เช่า',
                                                    style: TextStyle(
                                                        color:
                                                            AdminScafScreen_Color
                                                                .Colors_Text1_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        // color: AppBarColors.ABar_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            topRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                        // border: Border.all(color: Colors.grey, width: 1),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white,
                                            // Color.fromARGB(255, 244, 245, 242),
                                            Color.fromARGB(255, 216, 231, 199),
                                            Color.fromARGB(255, 199, 219, 175),
                                            AppBarColors.ABar_Colors,
                                          ],
                                        )),
                                    height: 80,
                                  )
                                ],
                              ),
                            ),
                            // Positioned(
                            //   top: 10,
                            //   left: 10,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       color: Colors.blueGrey.withOpacity(0.5),
                            //       borderRadius: const BorderRadius.only(
                            //         topLeft: Radius.circular(5),
                            //         topRight: Radius.circular(5),
                            //         bottomLeft: Radius.circular(5),
                            //         bottomRight: Radius.circular(5),
                            //       ),
                            //     ),
                            //     padding: const EdgeInsets.all(4.0),
                            //     child: Center(
                            //       child: Text(
                            //         'Floorplans แผนผังพื้นที่ ${areaModelsAll.length}  /// ${areaModelsOverdue.length}  ///${areaFloorplanModels.length}',
                            //         style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 20.0,
                            //             fontFamily: FontWeight_.Fonts_T),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.zoom_in,
                                        color: Colors.white,
                                      ),
                                      onPressed: _zoomInSVG,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.zoom_out,
                                        color: Colors.white,
                                      ),
                                      onPressed: _zoomOutSVG,
                                    ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.grey,
                                    //     borderRadius: const BorderRadius.only(
                                    //       topLeft: Radius.circular(5),
                                    //       topRight: Radius.circular(5),
                                    //       bottomLeft: Radius.circular(5),
                                    //       bottomRight: Radius.circular(5),
                                    //     ),
                                    //   ),
                                    //   child: Text(
                                    //     '${MediaQuery.of(context).size.width}',
                                    //     overflow: TextOverflow.ellipsis,
                                    //     // minFontSize: 1,
                                    //     // maxFontSize: 12,
                                    //     maxLines: 1,
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontFamily: Font_.Fonts_T,

                                    //       //fontSize: 10.0s
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
        ],
      )),
    );
  }

  Color getRandomColor(index, nameln) {
    final random = Random();
    return (nameln == '2') ? Colors.green.shade700 : Colors.red.shade700;
  }

  dialogFreespace_svg(int index, context) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.91),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
            child: Column(
          children: [
            Text(
              'พื้นที่ว่าง : ${areaModelsAll[index].lncode} (${areaModelsAll[index].ln}) ',
              style: const TextStyle(
                  color: AdminScafScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Divider(
              color: Colors.grey[100],
              height: 3.0,
            ),
            const SizedBox(
              height: 2.0,
            ),
          ],
        )),
        actions: <Widget>[
          Column(
            children: [
              const SizedBox(
                height: 2.0,
              ),
              const Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
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
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  areaFloorplanModelss = null;
                                });

                                Navigator.pop(context, 'OK');
                              },
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

  dialog_svg(int index, context, nameln) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.91),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
            child: Column(
          children: [
            Text(
              (nameln == '2')
                  ? (_TransReBillModels.length == 0)
                      ? '${areaModelsAll[index].lncode} (${areaModelsAll[index].ln}) '
                      : 'ชำระแล้ว : ${areaModelsAll[index].lncode} (${areaModelsAll[index].ln}) '
                  : '${areaModelsOverdue[index].lncode} (${areaModelsOverdue[index].ln})',
              style: const TextStyle(
                  color: AdminScafScreen_Color.Colors_Text1_,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontWeight_.Fonts_T),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Divider(
              color: Colors.grey[100],
              height: 3.0,
            ),
            const SizedBox(
              height: 2.0,
            ),
          ],
        )),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (nameln == '1')
                Container(
                  child: Column(
                    children: [
                      Text(
                        '${areaModelsOverdue[index].sname}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                      Text(
                        'เลขที่สัญญา : ${areaModelsOverdue[index].refno}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                    ],
                  ),
                ),
              if (nameln == '1')
                ListTile(
                    onTap: () async {
                      if (nameln == '1') {
                        widget.updateMessage(
                            '1',
                            '${areaModelsOverdue[index].refno}',
                            'PeopleChaoScreen2');
                      } else {}

                      Navigator.pop(context, 'OK');
                    },
                    title: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                    <--- top side
                          width: 0.5,
                        ),
                      )),
                      padding: const EdgeInsets.all(4.0),
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'รับชำระ :',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: areaModelsOverdue[index]
                                          .docno! // Assuming docno is non-null
                                          .split(
                                              ',') // Split the string by commas
                                          .asMap() // Convert the list to a map
                                          .entries // Get the entries of the map
                                          .map(
                                            (entry) => Text(
                                              '${entry.key + 1} : ${entry.value.trim()}', // Displaying index + 1 and the trimmed docno
                                              style: const TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text2_,
                                                //fontWeight: FontWeight.bold,
                                                fontFamily: Font_.Fonts_T,
                                              ),
                                            ),
                                          )
                                          .toList()),
                                ),
                              ],
                            ),
                          ),
                          Icon(Iconsax.arrow_circle_right,
                              color: getRandomColor(index, nameln)),
                        ],
                      ),
                    )),
              if (_TransReBillModels.length == 0 && nameln == '2')
                ListTile(
                    title: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      //                    <--- top side
                      width: 0.5,
                    ),
                  )),
                  padding: const EdgeInsets.all(4.0),
                  width: 270,
                  child: Column(
                    children: [
                      Text(
                        '${areaModelsAll[index].sname}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                      Text(
                        'เลขที่สัญญา : ${areaModelsAll[index].cid}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                      const Text(
                        '( ไม่มีรายการที่ต้องชำระ ณ วันที่เลือก )',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                    ],
                  ),
                )),
              if (_TransReBillModels.length != 0 && nameln == '2')
                Container(
                  child: Column(
                    children: [
                      Text(
                        '${areaModelsAll[index].sname}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                      Text(
                        'เลขที่สัญญา : ${areaModelsAll[index].cid}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: PeopleChaoScreen_Color.Colors_Text2_,
                            //fontWeight: FontWeight.bold,
                            fontFamily: Font_.Fonts_T),
                      ),
                    ],
                  ),
                ),
              if (nameln == '2')
                for (int index = 0; index < _TransReBillModels.length; index++)
                  ListTile(
                      onTap: () async {
                        setState(() {
                          red_Trans_select(index);
                          red_Invoice(index);
                        });

                        Future.delayed(const Duration(milliseconds: 150),
                            () async {
                          Navigator.pop(context, 'OK');
                          checkshowDialog(index);
                        });
                      },
                      title: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            //                    <--- top side
                            width: 0.5,
                          ),
                        )),
                        padding: const EdgeInsets.all(4.0),
                        width: 270,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'เรียกดู : ${_TransReBillModels[index].docno}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: Font_.Fonts_T),
                              ),
                            ),
                            Icon(Iconsax.arrow_circle_right,
                                color: getRandomColor(index, nameln)),
                          ],
                        ),
                      )),
            ],
          ),
        ),
        actions: <Widget>[
          Column(
            children: [
              const SizedBox(
                height: 2.0,
              ),
              const Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
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
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  areaFloorplanModelss = null;
                                });

                                Navigator.pop(context, 'OK');
                              },
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

////////////------------------------------->
  Future<Null> checkshowDialog(index) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: AppbackgroundColor.Sub_Abg_Colors,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          areaFloorplanModelss = null;
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.highlight_off,
                            size: 30, color: Colors.red[700]),
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   width: MediaQuery.of(context).size.width * 0.6,
                    //   child: Text(
                    //     _TransReBillModels[index].doctax == ''
                    //         ? 'เลขที่บิล ${_TransReBillModels[index].docno}'
                    //         : 'เลขที่บิล ${_TransReBillModels[index].doctax}',
                    //     style: const TextStyle(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
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
                                        height: 30,
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
                                          child: AutoSizeText(
                                            minFontSize: 8,
                                            maxFontSize: 14,
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
                                        height: 30,
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
                                        padding: const EdgeInsets.all(4.0),
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
                                            child: AutoSizeText(
                                              minFontSize: 8,
                                              maxFontSize: 12,
                                              _TransReBillModels[index]
                                                          .doctax ==
                                                      ''
                                                  ? 'บิลเลขที่ ${_TransReBillModels[index].docno}'
                                                  : 'บิลเลขที่ ${_TransReBillModels[index].doctax}',
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
                                Container(
                                  color: Colors.brown[200],
                                  padding: const EdgeInsets.all(2.0),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'วันที่ชำระ',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'กำหนดชำระ',
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
                                      Expanded(
                                        flex: 2,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'เลขตั้งหนี้',
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
                                      Expanded(
                                        flex: 2,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'รายการ',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'VAT(฿)',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          'WHT(฿)',
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
                                      Expanded(
                                        flex: 1,
                                        child: AutoSizeText(
                                          minFontSize: 8,
                                          maxFontSize: 14,
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
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.height / 4.8,
                                    decoration: BoxDecoration(
                                      color: AppbackgroundColor.Sub_Abg_Colors,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        // bottomLeft: Radius.circular(0),
                                        // bottomRight: Radius.circular(0),
                                      ),
                                      // border: Border.all(
                                      //     color: Colors.black12, width: 1),
                                    ),
                                    child: StreamBuilder(
                                      stream: Stream.periodic(
                                          const Duration(seconds: 0)),
                                      builder: (context, snapshot) {
                                        return ListView.builder(
                                          // controller: _scrollController2,
                                          // itemExtent: 50,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              _TransReBillHistoryModels.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
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
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${index + 1}',
                                                        textAlign:
                                                            TextAlign.start,
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
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransReBillHistoryModels[index].dateacc} 00:00:00'))}',
                                                        textAlign:
                                                            TextAlign.start,
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
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        // '${_TransReBillHistoryModels[index].duedate}',
                                                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse('${_TransReBillHistoryModels[index].date} 00:00:00'))}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].refno}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].expname}',
                                                        textAlign:
                                                            TextAlign.start,
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
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].vat}',
                                                        textAlign:
                                                            TextAlign.end,
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
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${_TransReBillHistoryModels[index].wht}',
                                                        textAlign:
                                                            TextAlign.end,
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
                                                        minFontSize: 8,
                                                        maxFontSize: 14,
                                                        maxLines: 1,
                                                        '${nFormat.format(double.parse(_TransReBillHistoryModels[index].total!))}',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
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
                                                      child: AutoSizeText(
                                                        minFontSize: 8,
                                                        'วันที่ชำระ : $pdate',
                                                        //  'วันที่ชำระ : ${DateFormat('dd-MM').format(DateTime.parse('$pdate 00:00:00'))}-${DateTime.parse('$pdate 00:00:00').year + 543}',
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
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: const AutoSizeText(
                                                        minFontSize: 8,
                                                        maxFontSize: 13,
                                                        'รูปแบบการชำระ',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
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
                                                      (finnancetransModels[i]
                                                                  .dtype
                                                                  .toString() ==
                                                              'KP')
                                                          ? Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 8,
                                                                maxFontSize: 13,
                                                                (finnancetransModels[i]
                                                                            .type
                                                                            .toString() ==
                                                                        'CASH')
                                                                    ? '${i + 1}.เงินสด : ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท'
                                                                    : '${i + 1}.เงินโอน : ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
                                                              ),
                                                            )
                                                          : Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 8,
                                                                maxFontSize: 13,
                                                                '${i + 1}.${finnancetransModels[i].remark} : ${nFormat.format(double.parse(finnancetransModels[i].amt!))} บาท',
                                                                style: const TextStyle(
                                                                    color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                    //fontWeight: FontWeight.bold,
                                                                    fontFamily: Font_.Fonts_T),
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'รวมราคาสินค้า/Sub Total',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,

                                                          // '${sum_pvat} // $dis_sum_Matjum',

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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ภาษีมูลค่าเพิ่ม/Vat',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          // '${sum_amt} // $dis_sum_Matjum ',

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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ส่วนลด/Discount $sum_disp %',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                  if (nFormat
                                                          .format(
                                                              dis_sum_Matjum)
                                                          .toString() !=
                                                      '0.00')
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child:
                                                              const AutoSizeText(
                                                            minFontSize: 8,
                                                            maxFontSize: 11,
                                                            'เงินมัดจำ(ตัดมัดจำ)',
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
                                                            minFontSize: 8,
                                                            maxFontSize: 11,
                                                            '${nFormat.format(dis_sum_Matjum)}',
                                                            textAlign:
                                                                TextAlign.end,
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
                                                      ],
                                                    ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 120,
                                                        child:
                                                            const AutoSizeText(
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          //  '${sum_amt - sum_disamt} // $dis_sum_Matjum',

                                                          '${nFormat.format((sum_amt - sum_disamt) - dis_sum_Matjum)}',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          'ยอดสุทธิ',
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
                                                          minFontSize: 8,
                                                          maxFontSize: 11,
                                                          textAlign:
                                                              TextAlign.end,
                                                          //  '${sum_amt - sum_disamt} // $dis_sum_Matjum',

                                                          '${nFormat.format((sum_amt - sum_disamt))}',
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
                              ])),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 2.0,
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 2.0,
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 0)),
                          builder: (context, snapshot) {
                            return ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              }),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: (Responsive.isDesktop(context))
                                      ? MediaQuery.of(context).size.width * 0.85
                                      : 1200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      (Slip_history.toString() == null ||
                                              Slip_history == null ||
                                              Slip_history.toString() == 'null')
                                          ? const SizedBox()
                                          : Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              width: 200,
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                            title: Center(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    '${_TransReBillModels[index].docno}',
                                                                    maxLines: 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_
                                                                                .Fonts_T,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                  Text(
                                                                    '${Slip_history}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_
                                                                                .Fonts_T,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            content: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Image.network(
                                                                    '${MyConstant().domain}/files/$foder/slip/${Slip_history}')
                                                              ],
                                                            ),
                                                            actions: <Widget>[
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                                height: 4.0,
                                                              ),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
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
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                            bottomLeft: Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            context,
                                                                            'OK'),
                                                                        child:
                                                                            const Text(
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
                                                        ]),
                                                  );
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[200],
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
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Text(
                                                            'หลักฐานการโอน',
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
                                            ),
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
                                                                actions: <Widget>[
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
                                                        onPressed: () async {
                                                          setState(() {
                                                            areaFloorplanModelss =
                                                                null;
                                                          });
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
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
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
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  areaFloorplanModelss =
                                                                      null;
                                                                });
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
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Icon(
                                                              Icons.refresh,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
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
                                            // Insert_log.Insert_logs('บัญชี',
                                            //     'ประวัติบิล>>ลดหนี้(${_TransReBillModels[index].docno})');
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
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
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
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].nvat!))}',
                                                  '${nFormat.format(double.parse(_TransReBillHistoryModels[index].wht!))}',
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
                                            String room_number_BillHistory =
                                                '${_TransReBillModels[index].room_number}';
                                            print(
                                                'room_number ------> ${_TransReBillModels[index].room_number}');

                                            _showMyDialog_SAVE(
                                                tableData00,
                                                newValuePDFimg,
                                                sname,
                                                cname,
                                                addr,
                                                tax,
                                                room_number_BillHistory);
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
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(Icons.print,
                                                        color: Colors.white),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ));
  }

  ////////////------------------------------------------------------>(Export file)
  Future<void> _showMyDialog_SAVE(tableData00, newValuePDFimg, sname, cname,
      addr, tax, room_number_BillHistory) async {
    String _ReportValue_type = "ไม่ระบุ";
    String _verticalGroupValue_NameFile = "จากระบบ";
    String Value_Report = ' ';
    String NameFile_ = '';
    String Pre_and_Dow = '';
    String? TitleType_Default_Receipt_Name;
    final _formKey = GlobalKey<FormState>();
    final FormNameFile_text = TextEditingController();
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
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      const Text(
                        'หัวบิล :',
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

                            if (value == 'ไม่ระบุ') {
                              setState(() {
                                TitleType_Default_Receipt_Name = null;
                              });
                            } else {
                              setState(() {
                                TitleType_Default_Receipt_Name = value;
                              });
                            }
                          },
                          items: const <String>[
                            'ไม่ระบุ',
                            'ต้นฉบับ',
                            'สำเนา',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Receipt_his_statusbill(
                                tableData00,
                                newValuePDFimg,
                                sname,
                                cname,
                                addr,
                                tax,
                                room_number_BillHistory,
                                TitleType_Default_Receipt_Name);
                          },
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
                            child: const Center(
                              child: Text(
                                'พิมพ์',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () => Navigator.pop(context, 'OK'),
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
                                  //fontWeight: FontWeight.bold, color:

                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  //////////////-------------------------------------------------------------> ( รายการ ประวัติบิล )
  Future<Null> Receipt_his_statusbill(
      tableData00,
      newValuePDFimg,
      sname,
      cname,
      addr,
      tax,
      room_number_BillHistory,
      TitleType_Default_Receipt_Name) async {
    // var date_Transaction = (finnancetransModels.length == 0)
    //     ? ''
    //     : '${finnancetransModels[0].daterec}';
    // var date_pay = (finnancetransModels.length == 0)
    //     ? ''
    //     : '${finnancetransModels[0].dateacc}';
    ManPay_Receipt_PDF.ManPayReceipt_PDF(
        numinvoice,
        context,
        foder,
        renTal_name,
        // sname,
        // cname,
        // addr,
        // tax,
        bill_addr,
        bill_email,
        bill_tel,
        bill_tax,
        bill_name,
        newValuePDFimg,
        TitleType_Default_Receipt_Name,
        tem_page_ser,
        bills_name_);
  }
}
