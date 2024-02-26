// ignore_for_file: unused_import, unused_local_variable, unnecessary_null_comparison, unused_field, override_on_non_overriding_member, duplicate_import, must_be_immutable, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:file_saver/file_saver.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:printing/printing.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';
import '../AdminScaffold/AdminScaffold.dart';
import '../Constant/Myconstant.dart';
import '../Model/GetContract_Photo_Model.dart';
import '../Model/GetRenTal_Model.dart';
import '../Model/GetTeNant_Model.dart';
import '../Model/GetZone_Model.dart';
import '../Report/Excel_PeopleCho_Report.dart';
import '../Responsive/responsive.dart';
import 'package:http/http.dart' as http;

import '../Style/colors.dart';
import '../Style/downloadImage.dart';
import 'PeopleChao_Screen2.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PeopleChao_Screen3.dart';
import 'PeopleChao_Screen4.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:image/image.dart' as IMG;

import 'QR_PDF.dart';
import 'QR_PDF2.dart';
import 'Rental_customer.dart';
import '../Man_PDF/Man_Cancel_Rental.dart';
import '../Style/view_pagenow.dart';

class PeopleChaoScreen extends StatefulWidget {
  final Get_NameShop_index;
  final Get_cid;
  final Get_status;
  final Get_ReturnBody;

  const PeopleChaoScreen({
    super.key,
    this.Get_NameShop_index,
    this.Get_cid,
    this.Get_status,
    this.Get_ReturnBody,
  });

  @override
  State<PeopleChaoScreen> createState() => _PeopleChaoScreenState();
}

class _PeopleChaoScreenState extends State<PeopleChaoScreen> {
  DateTime datex = DateTime.now();
  // String rotation = 'vertical';
  String Ser_nowpage = '2';

  ///------------------------------------------------->
  String ReturnBodyPeople = 'PeopleChao_Screen';
  String Ser_PeopleChao_index = ''; //indexรายการหน้าPeopleChao_Screen
  String Value_NameShop_index = ''; //ชื่อร้านค้าหน้าPeopleChao_Screen
  List<ZoneModel> zoneModels = [];

  List<TeNantModel> teNantModels = [];
  List<TeNantModel> limitedList_teNantModels = [];
  List<TeNantModel> _teNantModels = <TeNantModel>[];
  List<List<dynamic>> teNantModels_Save = [];
  List<ContractPhotoModel> contractPhotoModels = [];
  String? renTal_user, renTal_name, zone_ser, zone_name, Value_cid, fname_;
  String? rtname,
      type,
      typex,
      renname,
      pkname,
      ser_Zonex,
      Value_stasus,
      Status_pe;
////-------------->
  int TitleType_Default_Receipt = 0;
  String _ReportValue_type = "ไม่ระบุ";
  List TitleType_Default_Receipt_ = [
    'ไม่ระบุ',
    'ต้นฉบับ',
    'สำเนา',
  ];
/////////////--------------->
  String? bill_name,
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
      bills_name_;
/////////////--------------->
  int? pkqty, pkuser, countarae;
  int limit = 100; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  Color cardColor = Colors.green[300]!;
  int indexcardColor = 0;
  List<dynamic> colorList = [
    Colors.green[300],
    Colors.red[300],
    Colors.blue[300],
    Colors.yellow[300],
    Colors.orange[300],
    Colors.purple[300],
    Colors.teal[300],
    Colors.pink[300],
    Colors.indigo[300],
    Colors.cyan[300],
    Colors.brown[300],
    Colors.black,
    Colors.grey[300],
  ];

  void changeCardColor(namecolor) {
    setState(() {
      // Change the color to a different one
      cardColor = namecolor; // You can replace this with any color you want
    });
  }

  List<RenTalModel> renTalModels = [];
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
  ///////---------------------------------------------------->
  String tappedIndex_ = '';
  int Status_ = 1, open_set_date = 30;
  int index_listviwe = 0;
  String? serPositioned;
  ///////---------------------------------------------------->showMyDialog_SAVE
  String _verticalGroupValue_File = "EXCEL";
  String _verticalGroupValue_NameFile = "จากระบบ";
  String Value_Report = ' ';
  String NameFile_ = '';
  String Pre_and_Dow = '';
  final _formKey = GlobalKey<FormState>();
  final FormNameFile_text = TextEditingController();
  late List<GlobalKey> qrImageKey;
  List<Uint8List> netImage = [];

  late List<GlobalKey> controller;
  Uint8List? bytes;
  ///////---------------------------------------------------->
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
    read_GC_zone();
    read_GC_tenant();
    read_GC_rental();
    teNantModels_Save = [];
  }

  // Future<Null> read_GC_rental() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   var seruser = preferences.getString('ser');
  //   var utype = preferences.getString('utype');
  //   String url =
  //       '${MyConstant().domain}/GC_rental.php?isAdd=true&ser=$seruser&type=$utype';

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     var result = json.decode(response.body);
  //     print('read_GC_rental///// $result');
  //     for (var map in result) {
  //       RenTalModel renTalModel = RenTalModel.fromJson(map);
  //       setState(() {
  //         renTalModels.add(renTalModel);
  //       });
  //     }
  //   } catch (e) {}
  // }
  Future<Null> read_GC_rental() async {
    if (renTalModels.isNotEmpty) {
      renTalModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var ren = preferences.getString('renTalSer');
    var utype = preferences.getString('utype');
    var seruser = preferences.getString('ser');
    String url =
        '${MyConstant().domain}/GC_rental_setring.php?isAdd=true&ser=$seruser&type=$utype&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
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
          var bill_addrx = renTalModel.bill_addr!.trim();
          var bill_taxx = renTalModel.bill_tax!.trim();
          var bill_telx = renTalModel.bill_tel!.trim();
          var bill_emailx = renTalModel.bill_email!.trim();
          var bill_defaultx = renTalModel.bill_default;
          var bill_tserx = renTalModel.tser;
          var open_set_datex = int.parse(renTalModel.open_set_date!);
          setState(() {
            open_set_date = open_set_datex == 0 ? 30 : open_set_datex;
            foder = foderx;
            rtname = rtnamex;
            type = typexs;
            typex = typexx;
            renname = name;
            pkqty = pkqtyx;
            pkuser = pkuserx;
            pkname = pkx;
            img_ = img;
            img_logo = imglogo;
            bill_addr = bill_addrx;
            bill_tax = bill_taxx;
            bill_tel = bill_telx;
            bill_email = bill_emailx;
            bill_default = bill_defaultx;
            bill_tser = bill_tserx;
            bill_name = renTalModel.bill_name;

            renTalModels.add(renTalModel);
          });
        }
      } else {}
    } catch (e) {}
    print('Peoplename>>>>>  $renname >>> $open_set_date');
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      renTal_user = preferences.getString('renTalSer');
      renTal_name = preferences.getString('renTalName');
      fname_ = preferences.getString('fname');
      teNantModels_Save = List.generate(300, (_) => []);
      Value_NameShop_index = widget.Get_NameShop_index;
      Value_cid = widget.Get_cid;
      Value_stasus = widget.Get_status;
      ReturnBodyPeople = widget.Get_ReturnBody;
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
        setState(() {
          zoneModels.add(zoneModel);
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
  }

  int teNantModels_Save_index = 0;
  int teNantModels_List_count = 0;
  int List_count = 0;
  Future<Null> read_GC_tenant() async {
    setState(() {
      teNantModels_Save_index = 0;
      teNantModels_List_count = 0;
      List_count = 0;
    });

    for (int index = 0; index < teNantModels_Save.length; index++) {
      teNantModels_Save[index].clear();
    }

    if (limitedList_teNantModels.isNotEmpty) {
      limitedList_teNantModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    print('zone>>>>>>zone>>>>>$zone');

    String url = zone == null
        ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
        : zone == '0'
            ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
            : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModel = TeNantModel.fromJson(map);
          setState(() {
            limitedList_teNantModels.add(teNantModel);
            teNantModels_Save[teNantModels_Save_index].add(teNantModel);
          });
          read_GC_photo(
              teNantModel.docno == null
                  ? teNantModel.cid == null
                      ? ''
                      : '${teNantModel.cid}'
                  : '${teNantModel.docno}',
              teNantModel.quantity);
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
        _teNantModels = limitedList_teNantModels;
        qrImageKey = List.generate(teNantModels.length, (_) => GlobalKey());
        teNantModels_Save = List.generate(
            (limitedList_teNantModels.length ~/ 24) + 1, (_) => []);
        controller =
            List.generate(limitedList_teNantModels.length, (_) => GlobalKey());
        zone_ser = preferences.getString('zonePSer');
        zone_name = preferences.getString('zonesPName');
      });
      for (int index = 0; index < limitedList_teNantModels.length; index++) {
        setState(() {
          // teNantModels_Save[teNantModels_Save_index] = [];
          List_count++;
        });
        if (teNantModels_List_count == 24) {
          setState(() {
            teNantModels_Save_index++;
            teNantModels_List_count = 1;
          });
          print(
              'teNantModels_Save_index: $teNantModels_List_count /// $teNantModels_Save_index//$List_count');
        } else {
          setState(() {
            teNantModels_List_count++;
          });
          print(
              'teNantModels_Save_index: $teNantModels_List_count /// $teNantModels_Save_index//$List_count');
        }

        teNantModels_Save[teNantModels_Save_index]
            .add(limitedList_teNantModels[index]);
      }
      read_tenant_limit();
    } catch (e) {}
  }

  /////////////////--------------------------->
  Future<Null> read_tenant_limit() async {
    setState(() {
      endIndex = offset + limit;
      teNantModels = limitedList_teNantModels.sublist(
          offset, // Start index
          (endIndex <= limitedList_teNantModels.length)
              ? endIndex
              : limitedList_teNantModels.length // End index
          );
    });
    //limitedList_teNantModels
  }

////////////////////------------------------------------------------>limitedList_teNantModels

  Future<Null> read_GC_photo(ciddoc_, qutser_) async {
    ////////////////------------------------------------------------------>
    SharedPreferences preferences = await SharedPreferences.getInstance();

    ////////////////------------------------------------------------------>
    var ren = preferences.getString('renTalSer');

    String url =
        '${MyConstant().domain}/GC_photo_cont.php?isAdd=true&ren=$ren&ciddoc=$ciddoc_&qutser=$qutser_';
    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result.toString() != 'null') {
        for (var map in result) {
          ContractPhotoModel contractPhotoModel =
              ContractPhotoModel.fromJson(map);

          var pic_tenantx = contractPhotoModel.pic_tenant!.trim();
          var pic_shopx = contractPhotoModel.pic_shop!.trim();
          var pic_planx = contractPhotoModel.pic_plan!.trim();
          setState(() {
            // pic_tenant = pic_tenantx;
            // pic_shop = pic_shopx;
            // pic_plan = pic_planx;
            contractPhotoModels.add(contractPhotoModel);
          });
          print('pic_tenantx');
          print(pic_tenantx);
        }
      }
    } catch (e) {}
  }

////////////----------------------------------------------------->(รายงาน ข้อมูลผู้เช่า(ยกเลิกสัญญา))
  Future<Null> read_GC_tenant_Cancel() async {
    if (limitedList_teNantModels.isNotEmpty) {
      limitedList_teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zoneSer');

    print('zone>>>>>>zone>>>>>$zone');

    String url =
        //  (zone != '0' || zone != null)
        //     ? '${MyConstant().domain}/GC_tenant_Cancel_Zone.php?isAdd=true&ren=$ren&ser_zone=$zone'
        //     :
        '${MyConstant().domain}/GC_tenant_Cancel_All.php?isAdd=true&ren=$ren';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);
      if (result != null) {
        for (var map in result) {
          TeNantModel teNantModelsCancel = TeNantModel.fromJson(map);
          setState(() {
            limitedList_teNantModels.add(teNantModelsCancel);
          });
        }
      } else {}
      print('teNantModels///result ${limitedList_teNantModels.length}');
      setState(() {
        _teNantModels = limitedList_teNantModels;
      });
      read_tenant_limit();
    } catch (e) {}
  }

/////////////////////----------------------------------------->
  Future<Null> read_GC_areaSelect(int select) async {
    if (teNantModels.isNotEmpty) {
      teNantModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var ren = preferences.getString('renTalSer');
    var zone = preferences.getString('zonePSer');

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>> $select');

    if (select == 1) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

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
            // setState(() {
            //   teNantModels.add(teNantModel);
            // });
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
    } else if (select == 2) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

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

              print('difference == $difference');

              var daterx_now = DateTime.now();

              var daterx_ldate = DateTime.parse('$daterx 00:00:00.000');

              final now = DateTime.now();
              final earlier = daterx_ldate.subtract(const Duration(days: 0));
              var daterx_A = now.isAfter(earlier);
              print(now.isAfter(earlier)); // true
              print(now.isBefore(earlier)); // true

              if (daterx_A == true) {
                setState(() {
                  if (teNantModel.quantity == '1') {
                    teNantModels.add(teNantModel);
                  }
                });
              }
            }
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
    } else if (select == 3) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            if (teNantModel.quantity == '1') {
              if (datex.isAfter(
                      DateTime.parse('${teNantModel.ldate} 00:00:00.000')
                          .subtract(Duration(days: open_set_date))) ==
                  true) {
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
                  final earlier =
                      daterx_ldate.subtract(const Duration(days: 0));
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
            }
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
    } else if (select == 4) {
      String url = zone == null
          ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
          : zone == '0'
              ? '${MyConstant().domain}/GC_tenantAll.php?isAdd=true&ren=$ren&zone=$zone'
              : '${MyConstant().domain}/GC_tenant.php?isAdd=true&ren=$ren&zone=$zone';

      try {
        var response = await http.get(Uri.parse(url));

        var result = json.decode(response.body);
        print(result);
        if (result != null) {
          for (var map in result) {
            TeNantModel teNantModel = TeNantModel.fromJson(map);
            if (teNantModel.quantity == '2' || teNantModel.quantity == '3') {
              setState(() {
                teNantModels.add(teNantModel);
              });
            }
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
  }

  List Status = [
    'ปัจจุบัน',
    'หมดสัญญา',
    'ใกล้หมดสัญญา',
    'ผู้สนใจ',
    'บัญชีผู้เช่า',
    'ยกเลิกสัญญาผู้เช่า',
  ];

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
            var notTitle4 = teNantModels.sname.toString().toLowerCase();
            var notTitle5 = teNantModels.cname.toString().toLowerCase();
            var notTitle6 = teNantModels.zn.toString().toLowerCase();
            var notTitle7 = teNantModels.zser.toString().toLowerCase();
            var notTitle8 = teNantModels.sdate.toString().toLowerCase();
            var notTitle9 = teNantModels.fid.toString().toLowerCase();
            var notTitle10 = teNantModels.sdate_q.toString().toLowerCase();
            var notTitle11 = teNantModels.ldate_q.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text) ||
                notTitle7.contains(text) ||
                notTitle8.contains(text) ||
                notTitle9.contains(text);
          }).toList();
        });
      },
    );
  }

  _searchBar2() {
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
          teNantModels = teNantModels.where((teNantModel) {
            var notTitle = teNantModel.lncode.toString().toLowerCase();
            var notTitle2 = teNantModel.cid.toString().toLowerCase();
            var notTitle3 = teNantModel.docno.toString().toLowerCase();
            var notTitle4 = teNantModel.sname.toString().toLowerCase();
            var notTitle5 = teNantModel.cname.toString().toLowerCase();
            var notTitle6 = teNantModel.zn.toString().toLowerCase();
            var notTitle7 = teNantModel.zser.toString().toLowerCase();
            var notTitle8 = teNantModel.sdate.toString().toLowerCase();
            var notTitle9 = teNantModel.fid.toString().toLowerCase();
            var notTitle10 = teNantModel.sdate_q.toString().toLowerCase();
            var notTitle11 = teNantModel.ldate_q.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text) ||
                notTitle7.contains(text) ||
                notTitle8.contains(text) ||
                notTitle9.contains(text);
          }).toList();
        });
      },
    );
  }

  _searchBar3() {
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
          teNantModels = teNantModels.where((teNantModel) {
            var notTitle = teNantModel.lncode.toString().toLowerCase();
            var notTitle2 = teNantModel.cid.toString().toLowerCase();
            var notTitle3 = teNantModel.docno.toString().toLowerCase();
            var notTitle4 = teNantModel.sname.toString().toLowerCase();
            var notTitle5 = teNantModel.cname.toString().toLowerCase();
            var notTitle6 = teNantModel.zn.toString().toLowerCase();
            var notTitle7 = teNantModel.zser.toString().toLowerCase();
            var notTitle8 = teNantModel.sdate.toString().toLowerCase();
            var notTitle9 = teNantModel.fid.toString().toLowerCase();
            var notTitle10 = teNantModel.sdate_q.toString().toLowerCase();
            var notTitle11 = teNantModel.ldate_q.toString().toLowerCase();
            return notTitle.contains(text) ||
                notTitle2.contains(text) ||
                notTitle3.contains(text) ||
                notTitle4.contains(text) ||
                notTitle5.contains(text) ||
                notTitle6.contains(text) ||
                notTitle7.contains(text) ||
                notTitle8.contains(text) ||
                notTitle9.contains(text);
          }).toList();
        });
      },
    );
  }

  ScrollController _scrollController1 = ScrollController();

  ///----------------->
  _moveUp1() {
    _scrollController1.animateTo(_scrollController1.offset - 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown1() {
    _scrollController1.animateTo(_scrollController1.offset + 250,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  String? _message;
  void updateMessage(newMessage, ValueNameShop_index, Valuecid) {
    setState(() {
      _message = newMessage;
      ReturnBodyPeople = newMessage;
      Value_NameShop_index = ValueNameShop_index;
      Value_cid = Valuecid;
    });
    checkPreferance();
    read_GC_zone();
    read_GC_tenant();
    read_GC_rental();
  }

  _qrImageKey_SAVE(index) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: RepaintBoundary(
        key: qrImageKey[index],
        child: Row(
          children: [
            Container(
              height: 135,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage("images/kindpng.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: PrettyQr(
                          // typeNumber: 3,
                          image: const AssetImage(
                            "images/Icon-chao.png",
                          ),
                          size: 110,
                          data: '${teNantModels[index].cid}',
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
                        child: Container(
                          // decoration:
                          //     BoxDecoration(
                          //   image:
                          //       DecorationImage(
                          //     image: NetworkImage("https://www.kindpng.com/picc/m/266-2660257_dotted-background-png-image-free-download-searchpng-white.png"),
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          width: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              // const Text(
                              //   'เลขสัญญา',
                              //   style: TextStyle(
                              //     fontSize: 10.0,
                              //     color: PeopleChaoScreen_Color.Colors_Text1_,
                              //     // fontWeight: FontWeight.bold,
                              //     fontFamily: Font_.Fonts_T,
                              //   ),
                              // ),
                              Text(
                                '${teNantModels[index].cid}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                              const Text(
                                'ชื่อผู้ติดต่อ',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                              Text(
                                '${teNantModels[index].cname}',
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                              const Text(
                                'ชื่อร้านค้า',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                              Text(
                                '${teNantModels[index].sname}',
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                              Text(
                                'พื้นที่ : ${teNantModels[index].ln} ( ${teNantModels[index].zn} )',
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: PeopleChaoScreen_Color.Colors_Text1_,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: Font_.Fonts_T,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors
                  //             .blueGrey.shade900),
                  //     onPressed:
                  //         () {
                  //       //  saveData(index);
                  //     },
                  //     child: const Text(
                  //         'Add to Cart')),
                ],
              ),
            ),
            Container(
              height: 136,
              width: 15,
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      '$renTal_name',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
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
    );
  }

  void downloadImage(Uint8List bytes, name) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'image_$name.png';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
    setState(() {
      serPositioned = null;
    });
  }

  void downloadImage_for(Uint8List bytes, name) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'image_$name.png';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  ////////////////-------------------------------------->
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (ReturnBodyPeople == 'PeopleChaoScreen2')
          ? Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            ReturnBodyPeople = 'PeopleChaoScreen';
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PeopleChaoScreen2(
                  Get_Value_cid: Value_cid,
                  Get_Value_NameShop_index: Value_NameShop_index,
                  Get_Value_status: Value_stasus,
                  Get_Value_indexpage: '0',
                  updateMessage: updateMessage,
                ),
              ],
            )
          : (ReturnBodyPeople == 'PeopleChaoScreen3')
              ? Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                ReturnBodyPeople = 'PeopleChaoScreen';
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    /////////////----------->คุมเงินประกัน
                    const PeopleChaoScreen3(),
                    /////////////----------->คุมเงินประกัน
                  ],
                )
              : (ReturnBodyPeople == 'PeopleChaoScreen4')
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    ReturnBodyPeople = 'PeopleChaoScreen';
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ), /////////////----------->ยกเลิกสัญญา
                        const PeopleChaoScreen4(),
                        /////////////----------->ยกเลิกสัญญา
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 2, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Box,
                                        // color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            'ผู้เช่า ',
                                            overflow: TextOverflow.ellipsis,
                                            minFontSize: 8,
                                            maxFontSize: 20,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: ReportScreen_Color
                                                  .Colors_Text1_,
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
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: viewpage(context, '$Ser_nowpage'),
                            ),
                          ],
                        ),
                        //               Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Align(
                        //       alignment: Alignment.topLeft,
                        //       child: viewpage(context, '$Ser_nowpage'),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppbackgroundColor.TiTile_Box,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // border: Border.all(color: Colors.white, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                MediaQuery.of(context).size.shortestSide <
                                        MediaQuery.of(context).size.width * 1
                                    ? const Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'โซนพื้นที่เช่า:',
                                            style: TextStyle(
                                                color: PeopleChaoScreen_Color
                                                    .Colors_Text1_,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                Expanded(
                                  flex: MediaQuery.of(context)
                                              .size
                                              .shortestSide <
                                          MediaQuery.of(context).size.width * 1
                                      ? 2
                                      : 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      width: 150,
                                      child: DropdownButtonFormField2(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        isExpanded: true,
                                        hint: Text(
                                          zone_name == null
                                              ? 'ทั้งหมด'
                                              : '$zone_name',
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: PeopleChaoScreen_Color
                                                  .Colors_Text2_,
                                              fontFamily: Font_.Fonts_T),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        style: const TextStyle(
                                            color: PeopleChaoScreen_Color
                                                .Colors_Text2_,
                                            fontFamily: Font_.Fonts_T),
                                        iconSize: 30,
                                        buttonHeight: 40,
                                        // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        items: zoneModels
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value:
                                                      '${item.ser},${item.zn}',
                                                  child: Text(
                                                    item.zn!,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                        fontFamily:
                                                            Font_.Fonts_T),
                                                  ),
                                                ))
                                            .toList(),

                                        onChanged: (value) async {
                                          var zones = value!.indexOf(',');
                                          var zoneSer =
                                              value.substring(0, zones);
                                          var zonesName =
                                              value.substring(zones + 1);
                                          print(
                                              'mmmmm ${zoneSer.toString()} $zonesName');

                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.setString(
                                              'zonePSer', zoneSer.toString());
                                          preferences.setString('zonesPName',
                                              zonesName.toString());

                                          setState(() {
                                            read_GC_tenant();
                                          });
                                        },
                                        // onSaved: (value) {
                                        //   // selectedValue = value.toString();
                                        // },
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'ค้นหา:',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: PeopleChaoScreen_Color
                                              .Colors_Text1_,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontWeight_.Fonts_T),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: MediaQuery.of(context)
                                  //             .size
                                  //             .shortestSide <
                                  //         MediaQuery.of(context).size.width * 1
                                  //     ? 8
                                  //     : 6,
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      // width: 120,
                                      height: 40,
                                      child: _searchBar(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: MediaQuery.of(context)
                                  //             .size
                                  //             .shortestSide <
                                  //         MediaQuery.of(context).size.width * 1
                                  //     ? 8
                                  //     : 6,
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      // width: 120,
                                      height: 40,
                                      child: _searchBar2(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: MediaQuery.of(context)
                                  //             .size
                                  //             .shortestSide <
                                  //         MediaQuery.of(context).size.width * 1
                                  //     ? 8
                                  //     : 6,
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      // width: 120,
                                      height: 40,
                                      child: _searchBar3(),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 2,
                                //   child: SingleChildScrollView(
                                //     scrollDirection: Axis.horizontal,
                                //     child: Row(
                                //       children: [
                                //         Container(
                                //           child: Row(
                                //             children: [
                                //               const Padding(
                                //                 padding: EdgeInsets.all(8.0),
                                //                 child: Text(
                                //                   'โซนพื้นที่เช่า:',
                                //                   style: TextStyle(
                                //                       color:
                                //                           PeopleChaoScreen_Color
                                //                               .Colors_Text1_,
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       fontFamily:
                                //                           FontWeight_.Fonts_T),
                                //                 ),
                                //               ),
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(8.0),
                                //                 child: Container(
                                //                   decoration: BoxDecoration(
                                //                     color: AppbackgroundColor
                                //                         .Sub_Abg_Colors,
                                //                     borderRadius:
                                //                         const BorderRadius.only(
                                //                             topLeft:
                                //                                 Radius.circular(
                                //                                     10),
                                //                             topRight:
                                //                                 Radius.circular(
                                //                                     10),
                                //                             bottomLeft:
                                //                                 Radius.circular(
                                //                                     10),
                                //                             bottomRight:
                                //                                 Radius.circular(
                                //                                     10)),
                                //                     border: Border.all(
                                //                         color: Colors.grey,
                                //                         width: 1),
                                //                   ),
                                //                   width: 150,
                                //                   child:
                                //                       DropdownButtonFormField2(
                                //                     decoration: InputDecoration(
                                //                       isDense: true,
                                //                       contentPadding:
                                //                           EdgeInsets.zero,
                                //                       border:
                                //                           OutlineInputBorder(
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(10),
                                //                       ),
                                //                     ),
                                //                     isExpanded: true,
                                //                     hint: Text(
                                //                       zone_name == null
                                //                           ? 'ทั้งหมด'
                                //                           : '$zone_name',
                                //                       maxLines: 1,
                                //                       style: const TextStyle(
                                //                           fontSize: 14,
                                //                           color:
                                //                               PeopleChaoScreen_Color
                                //                                   .Colors_Text2_,
                                //                           fontFamily:
                                //                               Font_.Fonts_T),
                                //                     ),
                                //                     icon: const Icon(
                                //                       Icons.arrow_drop_down,
                                //                       color: Colors.black,
                                //                     ),
                                //                     style: const TextStyle(
                                //                         color:
                                //                             PeopleChaoScreen_Color
                                //                                 .Colors_Text2_,
                                //                         fontFamily:
                                //                             Font_.Fonts_T),
                                //                     iconSize: 30,
                                //                     buttonHeight: 40,
                                //                     // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                //                     dropdownDecoration:
                                //                         BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               10),
                                //                     ),
                                //                     items: zoneModels
                                //                         .map((item) =>
                                //                             DropdownMenuItem<
                                //                                 String>(
                                //                               value:
                                //                                   '${item.ser},${item.zn}',
                                //                               child: Text(
                                //                                 item.zn!,
                                //                                 style: const TextStyle(
                                //                                     fontSize:
                                //                                         14,
                                //                                     color: PeopleChaoScreen_Color
                                //                                         .Colors_Text2_,
                                //                                     fontFamily:
                                //                                         Font_
                                //                                             .Fonts_T),
                                //                               ),
                                //                             ))
                                //                         .toList(),

                                //                     onChanged: (value) async {
                                //                       var zones =
                                //                           value!.indexOf(',');
                                //                       var zoneSer = value
                                //                           .substring(0, zones);
                                //                       var zonesName = value
                                //                           .substring(zones + 1);
                                //                       print(
                                //                           'mmmmm ${zoneSer.toString()} $zonesName');

                                //                       SharedPreferences
                                //                           preferences =
                                //                           await SharedPreferences
                                //                               .getInstance();
                                //                       preferences.setString(
                                //                           'zonePSer',
                                //                           zoneSer.toString());
                                //                       preferences.setString(
                                //                           'zonesPName',
                                //                           zonesName.toString());

                                //                       setState(() {
                                //                         read_GC_tenant();
                                //                       });
                                //                     },
                                //                     // onSaved: (value) {
                                //                     //   // selectedValue = value.toString();
                                //                     // },
                                //                   ),
                                //                 ),
                                //               ),
                                //               Padding(
                                //                 padding: EdgeInsets.all(8.0),
                                //                 child: Text(
                                //                   'ค้นหา:',
                                //                   textAlign: TextAlign.end,
                                //                   style: TextStyle(
                                //                       color:
                                //                           PeopleChaoScreen_Color
                                //                               .Colors_Text1_,
                                //                       fontWeight:
                                //                           FontWeight.bold,
                                //                       fontFamily:
                                //                           FontWeight_.Fonts_T),
                                //                 ),
                                //               ),
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(8.0),
                                //                 child: Container(
                                //                   decoration: BoxDecoration(
                                //                     color: AppbackgroundColor
                                //                         .Sub_Abg_Colors,
                                //                     borderRadius:
                                //                         const BorderRadius.only(
                                //                             topLeft:
                                //                                 Radius.circular(
                                //                                     10),
                                //                             topRight:
                                //                                 Radius.circular(
                                //                                     10),
                                //                             bottomLeft:
                                //                                 Radius.circular(
                                //                                     10),
                                //                             bottomRight:
                                //                                 Radius.circular(
                                //                                     10)),
                                //                     border: Border.all(
                                //                         color: Colors.grey,
                                //                         width: 1),
                                //                   ),
                                //                   width: 120,
                                //                   height: 35,
                                //                   child: _searchBar(),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.fromLTRB(8, 8, 15, 8),
                                // child: InkWell(
                                //   child: Container(
                                //       // padding: EdgeInsets.all(8.0),
                                //       child: CircleAvatar(
                                //     backgroundColor: Colors.yellow[700],
                                //     radius: 20,
                                //     child: PopupMenuButton(
                                //       child: const Text(
                                //         '...',
                                //         style: TextStyle(
                                //             fontSize: 25,
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.bold,
                                //             fontFamily: FontWeight_.Fonts_T),
                                //       ),
                                //       itemBuilder: (BuildContext context) => [
                                //         PopupMenuItem(
                                //           child: InkWell(
                                //               onTap: () async {
                                //                 Navigator.pop(context);
                                //                 setState(() {
                                //                   ReturnBodyPeople =
                                //                       'PeopleChaoScreen3';
                                //                 });
                                //               },
                                //               child: Container(
                                //                   padding:
                                //                       const EdgeInsets.all(
                                //                           10),
                                //                   width:
                                //                       MediaQuery.of(context)
                                //                           .size
                                //                           .width,
                                //                   child: Row(
                                //                     children: const [
                                //                       Expanded(
                                //                         child: Text(
                                //                           'คุมเงินประกัน',
                                //                           style: TextStyle(
                                //                               color: PeopleChaoScreen_Color
                                //                                   .Colors_Text1_,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .bold,
                                //                               fontFamily:
                                //                                   FontWeight_
                                //                                       .Fonts_T),
                                //                         ),
                                //                       )
                                //                     ],
                                //                   ))),
                                //         ),
                                //         PopupMenuItem(
                                //           child: InkWell(
                                //               onTap: () async {
                                //                 Navigator.pop(context);
                                //                 setState(() {
                                //                   ReturnBodyPeople =
                                //                       'PeopleChaoScreen4';
                                //                 });
                                //               },
                                //               child: Container(
                                //                   padding:
                                //                       const EdgeInsets.all(
                                //                           10),
                                //                   width:
                                //                       MediaQuery.of(context)
                                //                           .size
                                //                           .width,
                                //                   child: Row(
                                //                     children: const [
                                //                       Expanded(
                                //                         child: Text(
                                //                           'ยกเลิกสัญญา',
                                //                           style: TextStyle(
                                //                               color: PeopleChaoScreen_Color
                                //                                   .Colors_Text1_,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .bold,
                                //                               fontFamily:
                                //                                   FontWeight_
                                //                                       .Fonts_T),
                                //                         ),
                                //                       )
                                //                     ],
                                //                   ))),
                                //         ),
                                //       ],
                                //     ),
                                //   )),
                                // ),
                                // ),
                              ],
                            ),
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
                        //       child: Row(
                        //         children: [
                        //           Expanded(
                        //               flex: 1,
                        //               child: Row(
                        //                 children: [
                        //                   const Expanded(
                        //                     flex: 2,
                        //                     child:
                        // Padding(
                        //                       padding: EdgeInsets.all(8.0),
                        //                       child: Text(
                        //                         'โซนพื้นที่เช่า:',
                        //                         style: TextStyle(
                        //                             color:
                        //                                 PeopleChaoScreen_Color
                        //                                     .Colors_Text1_,
                        //                             fontWeight: FontWeight.bold,
                        //                             fontFamily:
                        //                                 FontWeight_.Fonts_T),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     flex: 3,
                        //                     child:
                        // Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                         decoration: BoxDecoration(
                        //                           color: AppbackgroundColor
                        //                               .Sub_Abg_Colors,
                        //                           borderRadius:
                        //                               const BorderRadius.only(
                        //                                   topLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   topRight:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomRight:
                        //                                       Radius.circular(
                        //                                           10)),
                        //                           border: Border.all(
                        //                               color: Colors.grey,
                        //                               width: 1),
                        //                         ),
                        //                         width: 150,
                        //                         child: DropdownButtonFormField2(
                        //                           decoration: InputDecoration(
                        //                             isDense: true,
                        //                             contentPadding:
                        //                                 EdgeInsets.zero,
                        //                             border: OutlineInputBorder(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       10),
                        //                             ),
                        //                           ),
                        //                           isExpanded: true,
                        //                           hint: Text(
                        //                             zone_name == null
                        //                                 ? 'ทั้งหมด'
                        //                                 : '$zone_name',
                        //                             maxLines: 1,
                        //                             style: const TextStyle(
                        //                                 fontSize: 14,
                        //                                 color:
                        //                                     PeopleChaoScreen_Color
                        //                                         .Colors_Text2_,
                        //                                 fontFamily:
                        //                                     Font_.Fonts_T),
                        //                           ),
                        //                           icon: const Icon(
                        //                             Icons.arrow_drop_down,
                        //                             color: Colors.black,
                        //                           ),
                        //                           style: const TextStyle(
                        //                               color:
                        //                                   PeopleChaoScreen_Color
                        //                                       .Colors_Text2_,
                        //                               fontFamily:
                        //                                   Font_.Fonts_T),
                        //                           iconSize: 30,
                        //                           buttonHeight: 40,
                        //                           // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        //                           dropdownDecoration:
                        //                               BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     10),
                        //                           ),
                        //                           items: zoneModels
                        //                               .map((item) =>
                        //                                   DropdownMenuItem<
                        //                                       String>(
                        //                                     value:
                        //                                         '${item.ser},${item.zn}',
                        //                                     child: Text(
                        //                                       item.zn!,
                        //                                       style: const TextStyle(
                        //                                           fontSize: 14,
                        //                                           color: PeopleChaoScreen_Color
                        //                                               .Colors_Text2_,
                        //                                           fontFamily: Font_
                        //                                               .Fonts_T),
                        //                                     ),
                        //                                   ))
                        //                               .toList(),

                        //                           onChanged: (value) async {
                        //                             var zones =
                        //                                 value!.indexOf(',');
                        //                             var zoneSer = value
                        //                                 .substring(0, zones);
                        //                             var zonesName = value
                        //                                 .substring(zones + 1);
                        //                             print(
                        //                                 'mmmmm ${zoneSer.toString()} $zonesName');

                        //                             SharedPreferences
                        //                                 preferences =
                        //                                 await SharedPreferences
                        //                                     .getInstance();
                        //                             preferences.setString(
                        //                                 'zonePSer',
                        //                                 zoneSer.toString());
                        //                             preferences.setString(
                        //                                 'zonesPName',
                        //                                 zonesName.toString());

                        //                             setState(() {
                        //                               read_GC_tenant();
                        //                             });
                        //                           },
                        //                           // onSaved: (value) {
                        //                           //   // selectedValue = value.toString();
                        //                           // },
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //           Expanded(
                        //               flex: 2,
                        //               child: Row(
                        //                 children: [
                        //                   const Expanded(
                        //                     flex: 1,
                        //                     child:
                        // Padding(
                        //                       padding: EdgeInsets.all(8.0),
                        //                       child: Text(
                        //                         'ค้นหา:',
                        //                         textAlign: TextAlign.end,
                        //                         style: TextStyle(
                        //                             color:
                        //                                 PeopleChaoScreen_Color
                        //                                     .Colors_Text1_,
                        //                             fontWeight: FontWeight.bold,
                        //                             fontFamily:
                        //                                 FontWeight_.Fonts_T),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     flex: 4,
                        //                     child:
                        // Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Container(
                        //                         decoration: BoxDecoration(
                        //                           color: AppbackgroundColor
                        //                               .Sub_Abg_Colors,
                        //                           borderRadius:
                        //                               const BorderRadius.only(
                        //                                   topLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   topRight:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomLeft:
                        //                                       Radius.circular(
                        //                                           10),
                        //                                   bottomRight:
                        //                                       Radius.circular(
                        //                                           10)),
                        //                           border: Border.all(
                        //                               color: Colors.grey,
                        //                               width: 1),
                        //                         ),
                        //                         width: 120,
                        //                         height: 35,
                        //                         child: _searchBar(),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //           Expanded(
                        //               flex: 2,
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.end,
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: InkWell(
                        //                       child: Container(
                        //                           // padding: EdgeInsets.all(8.0),
                        //                           child: CircleAvatar(
                        //                         backgroundColor:
                        //                             Colors.yellow[700],
                        //                         radius: 20,
                        //                         child: PopupMenuButton(
                        //                           child: const Text(
                        //                             '...',
                        //                             style: TextStyle(
                        //                                 fontSize: 25,
                        //                                 color: Colors.white,
                        //                                 fontWeight:
                        //                                     FontWeight.bold,
                        //                                 fontFamily: FontWeight_
                        //                                     .Fonts_T),
                        //                           ),
                        //                           itemBuilder:
                        //                               (BuildContext context) =>
                        //                                   [
                        //                             PopupMenuItem(
                        //                               child: InkWell(
                        //                                   onTap: () async {
                        //                                     Navigator.pop(
                        //                                         context);
                        //                                     setState(() {
                        //                                       ReturnBodyPeople =
                        //                                           'PeopleChaoScreen3';
                        //                                     });
                        //                                   },
                        //                                   child: Container(
                        //                                       padding:
                        //                                           const EdgeInsets
                        //                                               .all(10),
                        //                                       width:
                        //                                           MediaQuery.of(
                        //                                                   context)
                        //                                               .size
                        //                                               .width,
                        //                                       child: Row(
                        //                                         children: [
                        //                                           const Expanded(
                        //                                             child: Text(
                        //                                               'คุมเงินประกัน',
                        //                                               style: TextStyle(
                        //                                                   color: PeopleChaoScreen_Color
                        //                                                       .Colors_Text1_,
                        //                                                   fontWeight: FontWeight
                        //                                                       .bold,
                        //                                                   fontFamily:
                        //                                                       FontWeight_.Fonts_T),
                        //                                             ),
                        //                                           )
                        //                                         ],
                        //                                       ))),
                        //                             ),
                        //                             PopupMenuItem(
                        //                               child: InkWell(
                        //                                   onTap: () async {
                        //                                     Navigator.pop(
                        //                                         context);
                        //                                     setState(() {
                        //                                       ReturnBodyPeople =
                        //                                           'PeopleChaoScreen4';
                        //                                     });
                        //                                   },
                        //                                   child: Container(
                        //                                       padding:
                        //                                           const EdgeInsets
                        //                                               .all(10),
                        //                                       width:
                        //                                           MediaQuery.of(
                        //                                                   context)
                        //                                               .size
                        //                                               .width,
                        //                                       child: Row(
                        //                                         children: [
                        //                                           const Expanded(
                        //                                             child: Text(
                        //                                               'ยกเลิกสัญญา',
                        //                                               style: TextStyle(
                        //                                                   color: PeopleChaoScreen_Color
                        //                                                       .Colors_Text1_,
                        //                                                   fontWeight: FontWeight
                        //                                                       .bold,
                        //                                                   fontFamily:
                        //                                                       FontWeight_.Fonts_T),
                        //                                             ),
                        //                                           )
                        //                                         ],
                        //                                       ))),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       )),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //           const SizedBox(
                        //             width: 20,
                        //           ),
                        //         ],
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: MediaQuery.of(context)
                                              .size
                                              .shortestSide <
                                          MediaQuery.of(context).size.width * 1
                                      ? 2
                                      : 3,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'ผู้เช่า :',
                                                  style: TextStyle(
                                                      color:
                                                          PeopleChaoScreen_Color
                                                              .Colors_Text1_,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          FontWeight_.Fonts_T),
                                                ),
                                              ),
                                              for (int i = 0;
                                                  i < Status.length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        tappedIndex_ = '';
                                                      });
                                                      setState(() {
                                                        Status_ = i + 1;
                                                      });
                                                      setState(() {
                                                        Status_pe = Status[i]!;
                                                      });
                                                      print(
                                                          'Status_ //////// $Status_');
                                                      if (Status_ == 6) {
                                                        print('ยกเลิกสัญญา');
                                                        read_GC_tenant_Cancel();
                                                      } else {
                                                        read_GC_areaSelect(
                                                            Status_);
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: (i + 1 == 1)
                                                            ? (Status_ == i + 1)
                                                                ? Colors
                                                                    .grey[700]
                                                                : Colors
                                                                    .grey[300]
                                                            : (i + 1 == 2)
                                                                ? (Status_ ==
                                                                        i + 1)
                                                                    ? Colors.orange[
                                                                        700]
                                                                    : Colors.orange[
                                                                        200]
                                                                : (i + 1 == 3)
                                                                    ? (Status_ ==
                                                                            i +
                                                                                1)
                                                                        ? Colors.blue[
                                                                            700]
                                                                        : Colors.blue[
                                                                            200]
                                                                    : (i + 1 ==
                                                                            4)
                                                                        ? (Status_ ==
                                                                                i + 1)
                                                                            ? Colors.deepPurple[700]
                                                                            : Colors.deepPurple[200]
                                                                        : (i + 1 == 5)
                                                                            ? (Status_ == i + 1)
                                                                                ? Colors.indigo[700]
                                                                                : Colors.indigo[200]
                                                                            : (Status_ == i + 1)
                                                                                ? Colors.red[700]
                                                                                : Colors.red[200],
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                        border: (Status_ ==
                                                                i + 1)
                                                            ? Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1)
                                                            : null,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          Status[i],
                                                          style: TextStyle(
                                                              color: (Status_ ==
                                                                      i + 1)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  FontWeight_
                                                                      .Fonts_T),
                                                        ),
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
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .yellow[700],
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
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .qr_code,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2.0),
                                                                  child: Text(
                                                                    'Gen QR ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: PeopleChaoScreen_Color
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
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: (zone_name ==
                                                                  null ||
                                                              zone_name
                                                                      .toString() ==
                                                                  'ทั้งหมด' ||
                                                              zone_name
                                                                      .toString() ==
                                                                  'null')
                                                          ? () {
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
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
                                                                    'กรุณาเลือกโซนพื้นที่ก่อน',
                                                                    style: TextStyle(
                                                                        color: AdminScafScreen_Color
                                                                            .Colors_Text1_,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            FontWeight_.Fonts_T),
                                                                  )),
                                                                  actions: <Widget>[
                                                                    Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        const Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                          height:
                                                                              4.0,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5.0,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 100,
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Colors.black,
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
                                                                              ]),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                          : () async {
                                                              setState(() {
                                                                limit = 48;
                                                                offset = 0;
                                                              });
                                                              setState(() {
                                                                read_tenant_limit();
                                                              });
                                                              int index_type =
                                                                  0;
                                                              int ser_type = 0;
                                                              // GlobalKey qrImageKey =
                                                              //     GlobalKey();
                                                              showDialog<void>(
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
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Center(
                                                                              child: Text(
                                                                                'Gen QR Code',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: FontWeight_.Fonts_T,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            // if (serPositioned !=
                                                                            //     null)
                                                                            //   SizedBox(
                                                                            //     height: 20,
                                                                            //     width: 20,
                                                                            //     child: CircularProgressIndicator(),
                                                                            //   )
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: AppbackgroundColor.Sub_Abg_Colors,
                                                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                                                  ),
                                                                                  // width: 120,
                                                                                  // height: 35,
                                                                                  child: _searchBar(),
                                                                                ),
                                                                              ),
                                                                              Text('สี : '),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: AppbackgroundColor.Sub_Abg_Colors,
                                                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                  border: Border.all(color: Colors.grey, width: 1),
                                                                                ),
                                                                                width: 70,
                                                                                child: DropdownButtonFormField2(
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    contentPadding: EdgeInsets.zero,
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                  ),
                                                                                  isExpanded: true,
                                                                                  hint: Icon(Icons.circle_rounded, color: cardColor, size: 16),
                                                                                  icon: const Icon(
                                                                                    Icons.arrow_drop_down,
                                                                                    color: TextHome_Color.TextHome_Colors,
                                                                                  ),
                                                                                  style: const TextStyle(color: Colors.green, fontFamily: Font_.Fonts_T),
                                                                                  iconSize: 20,
                                                                                  buttonHeight: 30,
                                                                                  // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                                                                  dropdownDecoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  items: colorList
                                                                                      .map((item) => DropdownMenuItem<dynamic>(
                                                                                            value: item,
                                                                                            child: Icon(Icons.circle_rounded, color: item, size: 16),
                                                                                          ))
                                                                                      .toList(),

                                                                                  onChanged: (value) async {
                                                                                    final selectedColor = value;
                                                                                    final index = colorList.indexWhere((color) => color.value == selectedColor.value);
                                                                                    setState(() {
                                                                                      indexcardColor = index;
                                                                                    });

                                                                                    changeCardColor(colorList[index]);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        // Row(
                                                                        //   mainAxisAlignment:
                                                                        //       MainAxisAlignment.spaceBetween,
                                                                        //   children: [
                                                                        //     Text(
                                                                        //       zone_name == null ? 'โซนพื้นที่เช่า : ทั้งหมด' : 'โซนพื้นที่เช่า : $zone_name',
                                                                        //       maxLines: 1,
                                                                        //       style: const TextStyle(
                                                                        //         fontSize: 14.0,
                                                                        //         color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                        //         // fontWeight: FontWeight.bold,
                                                                        //         fontFamily: Font_.Fonts_T,
                                                                        //       ),
                                                                        //     ),
                                                                        //     Text(
                                                                        //       ' ทั้งหมด : ${limitedList_teNantModels.length}',
                                                                        //       maxLines: 1,
                                                                        //       style: const TextStyle(
                                                                        //         fontSize: 14.0,
                                                                        //         color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                        //         // fontWeight: FontWeight.bold,
                                                                        //         fontFamily: Font_.Fonts_T,
                                                                        //       ),
                                                                        //     ),
                                                                        //   ],
                                                                        // ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(2),
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: AppbackgroundColor.TiTile_Colors,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                            ),
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            // padding: EdgeInsets.all(10),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        zone_name == null ? 'โซนพื้นที่เช่า : ทั้งหมด' : 'โซนพื้นที่เช่า : $zone_name',
                                                                                        maxLines: 1,
                                                                                        style: const TextStyle(
                                                                                          fontSize: 14.0,
                                                                                          color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontFamily: FontWeight_.Fonts_T,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        ' ( ทั้งหมด : ${limitedList_teNantModels.length} )',
                                                                                        maxLines: 1,
                                                                                        style: const TextStyle(
                                                                                          fontSize: 14.0,
                                                                                          color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                          // fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.centerRight,
                                                                                  child: StreamBuilder(
                                                                                      stream: Stream.periodic(const Duration(seconds: 0)),
                                                                                      builder: (context, snapshot) {
                                                                                        return Container(
                                                                                          width: 200,
                                                                                          child: Next_page_Web(),
                                                                                        );
                                                                                      }),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // Padding(
                                                                        //   padding:
                                                                        //       const EdgeInsets.all(4.0),
                                                                        //   child:
                                                                        //       Container(
                                                                        //     padding:
                                                                        //         EdgeInsets.all(2),
                                                                        //     decoration:
                                                                        //         const BoxDecoration(
                                                                        //       color: AppbackgroundColor.TiTile_Colors,
                                                                        //       borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                        //     ),
                                                                        //     width:
                                                                        //         MediaQuery.of(context).size.width * 0.8,
                                                                        //     // padding: EdgeInsets.all(10),
                                                                        //     child:
                                                                        //         ScrollConfiguration(
                                                                        //       behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                        //         PointerDeviceKind.touch,
                                                                        //         PointerDeviceKind.mouse,
                                                                        //       }),
                                                                        //       child: SingleChildScrollView(
                                                                        //         scrollDirection: Axis.horizontal,
                                                                        //         child: Container(
                                                                        //           child: Row(
                                                                        //             children: [
                                                                        //               Container(
                                                                        //                 child: Row(
                                                                        //                   children: [
                                                                        //                     Text(
                                                                        //                       zone_name == null ? 'โซนพื้นที่เช่า : ทั้งหมด' : 'โซนพื้นที่เช่า : $zone_name',
                                                                        //                       maxLines: 1,
                                                                        //                       style: const TextStyle(
                                                                        //                         fontSize: 14.0,
                                                                        //                         color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                        //                         fontWeight: FontWeight.bold,
                                                                        //                         fontFamily: FontWeight_.Fonts_T,
                                                                        //                       ),
                                                                        //                     ),
                                                                        //                     Text(
                                                                        //                       ' ( ทั้งหมด : ${limitedList_teNantModels.length} )',
                                                                        //                       maxLines: 1,
                                                                        //                       style: const TextStyle(
                                                                        //                         fontSize: 14.0,
                                                                        //                         color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                        //                         // fontWeight: FontWeight.bold,
                                                                        //                         fontFamily: Font_.Fonts_T,
                                                                        //                       ),
                                                                        //                     ),
                                                                        //                     // Expanded(
                                                                        //                     //   child: _searchBar(),
                                                                        //                     // ),
                                                                        //                   ],
                                                                        //                 ),
                                                                        //               ),
                                                                        //               Align(alignment: Alignment.centerRight,
                                                                        //                 child: StreamBuilder(
                                                                        //                     stream: Stream.periodic(const Duration(seconds: 0)),
                                                                        //                     builder: (context, snapshot) {
                                                                        //                       return Container(
                                                                        //                         width: 200,
                                                                        //                         child: Next_page_Web(),
                                                                        //                       );
                                                                        //                     }),
                                                                        //               ),
                                                                        //               // for (int index = 0; index < teNantModels_Save.length; index++)
                                                                        //               //   StreamBuilder(
                                                                        //               //       stream: Stream.periodic(const Duration(seconds: 0)),
                                                                        //               //       builder: (context, snapshot) {
                                                                        //               //         return Padding(
                                                                        //               //           padding: const EdgeInsets.all(4.0),
                                                                        //               //           child: InkWell(
                                                                        //               //             child: Container(
                                                                        //               //               decoration: BoxDecoration(
                                                                        //               //                 color: (ser_type == index) ? Colors.blue : Colors.blue[200],
                                                                        //               //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                        //               //               ),
                                                                        //               //               padding: const EdgeInsets.all(4.0),
                                                                        //               //               child: Center(
                                                                        //               //                 child: Text(
                                                                        //               //                   // 'ลำดับที่ : ${index * 24 + 1} - ${(index + 1) * 24}',
                                                                        //               //                   ((index + 1) == teNantModels_Save.length) ? 'ลำดับที่ : ${index * 24 + 1} -  ${((index + 1) * 24) - (((index + 1) * 24) - teNantModels.length)}' : 'ลำดับที่ : ${index * 24 + 1} - ${(index + 1) * 24}',
                                                                        //               //                   maxLines: 1,
                                                                        //               //                   style: TextStyle(
                                                                        //               //                     fontSize: 14.0,
                                                                        //               //                     color: (ser_type == index) ? Colors.white : Colors.grey,
                                                                        //               //                     fontFamily: Font_.Fonts_T,
                                                                        //               //                   ),
                                                                        //               //                 ),
                                                                        //               //               ),
                                                                        //               //             ),
                                                                        //               //             onTap: () {
                                                                        //               //               setState(() {
                                                                        //               //                 index_type = index;
                                                                        //               //                 ser_type = index;
                                                                        //               //               });
                                                                        //               //             },
                                                                        //               //           ),
                                                                        //               //         );
                                                                        //               //       }),
                                                                        //             ],
                                                                        //           ),
                                                                        //         ),
                                                                        //       ),
                                                                        //     ),
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                    content:
                                                                        Container(
                                                                      // width: MediaQuery.of(
                                                                      //         context)
                                                                      //     .size
                                                                      //     .width,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            ScrollConfiguration(
                                                                          behavior:
                                                                              ScrollConfiguration.of(context).copyWith(dragDevices: {
                                                                            PointerDeviceKind.touch,
                                                                            PointerDeviceKind.mouse,
                                                                          }),
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            dragStartBehavior:
                                                                                DragStartBehavior.start,
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                StreamBuilder(
                                                                                    stream: Stream.periodic(const Duration(seconds: 0)),
                                                                                    builder: (context, snapshot) {
                                                                                      return Container(
                                                                                        width: (Responsive.isDesktop(context)) ? MediaQuery.of(context).size.width * 0.85 : 500,
                                                                                        height: MediaQuery.of(context).size.height,
                                                                                        child: ResponsiveGridList(horizontalGridMargin: 8, verticalGridMargin: 8, minItemWidth: 300, minItemsPerRow: 1, children: [
                                                                                          for (int index = 0; index < teNantModels.length; index++)
                                                                                            RepaintBoundary(
                                                                                              key: controller[index],
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 300,
                                                                                                    // height: 135,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.white,
                                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(0)),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          color: Colors.grey.withOpacity(0.5),
                                                                                                          spreadRadius: 3,
                                                                                                          blurRadius: 5,
                                                                                                          offset: const Offset(0, 3), // changes position of shadow
                                                                                                        ),
                                                                                                      ],
                                                                                                      image: const DecorationImage(
                                                                                                        image: AssetImage("images/pngegg2.png"),
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Column(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          color: Colors.white,
                                                                                                          child: Text(
                                                                                                            '$renTal_name ',
                                                                                                            maxLines: 1,
                                                                                                            style: const TextStyle(
                                                                                                              fontSize: 9.0,
                                                                                                              color: Colors.black,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              fontFamily: Font_.Fonts_T,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          color: Colors.white,
                                                                                                          child: Text(
                                                                                                            ' ${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                                                                            maxLines: 1,
                                                                                                            style: const TextStyle(
                                                                                                              fontSize: 8.0,
                                                                                                              color: Colors.black,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              fontFamily: Font_.Fonts_T,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                                                                              child: Container(
                                                                                                                color: Colors.white,
                                                                                                                child: Column(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                  children: [
                                                                                                                    Center(
                                                                                                                        child: Container(
                                                                                                                      height: 84,
                                                                                                                      width: 84,
                                                                                                                      child: SfBarcodeGenerator(
                                                                                                                        value: '${teNantModels[index].cid}',
                                                                                                                        symbology: QRCode(),
                                                                                                                        showValue: false,
                                                                                                                      ),
                                                                                                                    )),
                                                                                                                    Padding(
                                                                                                                      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                                                                                                      child: Container(
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          color: Colors.grey[100],
                                                                                                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                                                          // border: Border.all(color: Colors.grey, width: 1),
                                                                                                                        ),
                                                                                                                        padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                                                                                                                        child: Text(
                                                                                                                          'ลงชื่อ.....................................',
                                                                                                                          maxLines: 1,
                                                                                                                          style: TextStyle(
                                                                                                                            fontSize: 7.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),

                                                                                                                    // Center(
                                                                                                                    //   child: PrettyQr(
                                                                                                                    //     // typeNumber: 3,
                                                                                                                    //     image: const AssetImage(
                                                                                                                    //       "images/Icon-chao.png",
                                                                                                                    //     ),
                                                                                                                    //     size: 90,
                                                                                                                    //     data: '${teNantModels[index].cid}',
                                                                                                                    //     errorCorrectLevel: QrErrorCorrectLevel.M,
                                                                                                                    //     roundEdges: true,
                                                                                                                    //   ),
                                                                                                                    // ),
                                                                                                                    // Container(
                                                                                                                    //   color: Colors.white,
                                                                                                                    //   child: Text(
                                                                                                                    //     ' ${teNantModels_Save[index_type][index].sdate} ถึง ${teNantModels_Save[index_type][index].ldate}',
                                                                                                                    //     maxLines: 2,
                                                                                                                    //     style: const TextStyle(
                                                                                                                    //       fontSize: 8.0,
                                                                                                                    //       color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                    //       // fontWeight: FontWeight.bold,
                                                                                                                    //       fontFamily: Font_.Fonts_T,
                                                                                                                    //     ),
                                                                                                                    //   ),
                                                                                                                    // ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Stack(
                                                                                                              children: [
                                                                                                                Padding(
                                                                                                                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 8),
                                                                                                                  child: Container(
                                                                                                                    // decoration:
                                                                                                                    //     BoxDecoration(
                                                                                                                    //   image:
                                                                                                                    //       DecorationImage(
                                                                                                                    //     image: NetworkImage("https://www.kindpng.com/picc/m/266-2660257_dotted-background-png-image-free-download-searchpng-white.png"),
                                                                                                                    //     fit: BoxFit.cover,
                                                                                                                    //   ),
                                                                                                                    // ),
                                                                                                                    width: 170,
                                                                                                                    child: Column(
                                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                      children: [
                                                                                                                        // const SizedBox(
                                                                                                                        //   height: 5.0,
                                                                                                                        // ),
                                                                                                                        // const Text(
                                                                                                                        //   'เลขสัญญา',
                                                                                                                        //   style: TextStyle(
                                                                                                                        //     fontSize: 10.0,
                                                                                                                        //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                        //     // fontWeight: FontWeight.bold,
                                                                                                                        //     fontFamily: Font_.Fonts_T,
                                                                                                                        //   ),
                                                                                                                        // ),
                                                                                                                        Text(
                                                                                                                          '${teNantModels[index].cid}',
                                                                                                                          maxLines: 1,
                                                                                                                          style: const TextStyle(
                                                                                                                            fontSize: 11.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        const Text(
                                                                                                                          'ชื่อผู้ติดต่อ',
                                                                                                                          maxLines: 1,
                                                                                                                          style: TextStyle(
                                                                                                                            fontSize: 9.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            //fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        Text(
                                                                                                                          '${teNantModels[index].cname}',
                                                                                                                          maxLines: 1,
                                                                                                                          style: const TextStyle(
                                                                                                                            fontSize: 11.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        const Text(
                                                                                                                          'ชื่อร้านค้า',
                                                                                                                          maxLines: 1,
                                                                                                                          style: TextStyle(
                                                                                                                            fontSize: 9.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        Text(
                                                                                                                          '${teNantModels[index].sname}',
                                                                                                                          maxLines: 1,
                                                                                                                          style: const TextStyle(
                                                                                                                            fontSize: 11.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        Text(
                                                                                                                          teNantModels[index].ln_c == null
                                                                                                                              ? teNantModels[index].ln_q == null
                                                                                                                                  ? ''
                                                                                                                                  : 'พื้นที่ :${teNantModels[index].ln_q}'
                                                                                                                              : 'พื้นที่ :${teNantModels[index].ln_c}',
                                                                                                                          // 'พื้นที่ : ${teNantModels[index].ln} ( ${teNantModels[index].zn} )',
                                                                                                                          maxLines: 1,
                                                                                                                          style: const TextStyle(
                                                                                                                            fontSize: 9.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        Text(
                                                                                                                          'โซน :${teNantModels[index].zn}',
                                                                                                                          maxLines: 1,
                                                                                                                          style: const TextStyle(
                                                                                                                            fontSize: 9.0,
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            // fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: Font_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),

                                                                                                                        // Text(
                                                                                                                        //   ' ${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                                                                                        //   maxLines: 2,
                                                                                                                        //   style: const TextStyle(
                                                                                                                        //     fontSize: 8.0,
                                                                                                                        //     color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                        //     // fontWeight: FontWeight.bold,
                                                                                                                        //     fontFamily: Font_.Fonts_T,
                                                                                                                        //   ),
                                                                                                                        // ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                // if (serPositioned == null)
                                                                                                                //   Positioned(
                                                                                                                //     top: 0,
                                                                                                                //     right: 5,
                                                                                                                //     child: InkWell(
                                                                                                                //         child: Container(
                                                                                                                //           width: 30.0,
                                                                                                                //           height: 30.0,
                                                                                                                //           decoration: BoxDecoration(
                                                                                                                //             color: Colors.black.withOpacity(0.5),
                                                                                                                //             shape: BoxShape.circle,
                                                                                                                //           ),
                                                                                                                //           child: Center(
                                                                                                                //               child: Text(
                                                                                                                //             '${index_type + index + 1}',
                                                                                                                //             style: TextStyle(
                                                                                                                //               fontSize: 12,
                                                                                                                //               color: Colors.white,
                                                                                                                //             ),
                                                                                                                //           )),
                                                                                                                //         ),
                                                                                                                //         onTap: () async {}),
                                                                                                                //   ),
                                                                                                                if (serPositioned == null)
                                                                                                                  Positioned(
                                                                                                                    bottom: 5,
                                                                                                                    right: 5,
                                                                                                                    child: InkWell(
                                                                                                                      child: Container(
                                                                                                                        width: 30.0,
                                                                                                                        height: 30.0,
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          color: Colors.black.withOpacity(0.5),
                                                                                                                          shape: BoxShape.circle,
                                                                                                                        ),
                                                                                                                        child: const Center(
                                                                                                                            child: Icon(
                                                                                                                          Icons.download,
                                                                                                                          color: Colors.white,
                                                                                                                        )),
                                                                                                                      ),
                                                                                                                      onTap: () async {
                                                                                                                        // showDialog(
                                                                                                                        //     barrierDismissible: false,
                                                                                                                        //     context: context,
                                                                                                                        //     builder: (_) {
                                                                                                                        //       // Future.delayed(
                                                                                                                        //       //     const Duration(
                                                                                                                        //       //         seconds:
                                                                                                                        //       //             1),
                                                                                                                        //       //     () {
                                                                                                                        //       //   Navigator.of(
                                                                                                                        //       //           context)
                                                                                                                        //       //       .pop();
                                                                                                                        //       // });

                                                                                                                        //       return Dialog(
                                                                                                                        //         child: StreamBuilder(
                                                                                                                        //             stream: Stream.periodic(const Duration(seconds: 1)),
                                                                                                                        //             builder: (context, snapshot) {
                                                                                                                        //               return const SizedBox(
                                                                                                                        //                   // height: 20,
                                                                                                                        //                   width: 350,
                                                                                                                        //                   child: Padding(
                                                                                                                        //                     padding: EdgeInsets.all(20.0),
                                                                                                                        //                     child: Row(
                                                                                                                        //                       mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                        //                       children: [
                                                                                                                        //                         Padding(
                                                                                                                        //                           padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                                                                                        //                           child: SizedBox(height: 30, child: CircularProgressIndicator()),
                                                                                                                        //                         ),
                                                                                                                        //                         Text(
                                                                                                                        //                           'กำลัง Download และแปลงไฟล์ PDF...  ',
                                                                                                                        //                           style: TextStyle(
                                                                                                                        //                             color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                        //                             fontWeight: FontWeight.bold,
                                                                                                                        //                             fontFamily: FontWeight_.Fonts_T,
                                                                                                                        //                           ),
                                                                                                                        //                         ),
                                                                                                                        //                       ],
                                                                                                                        //                     ),
                                                                                                                        //                   ));
                                                                                                                        //             }),
                                                                                                                        //       );
                                                                                                                        //     });
                                                                                                                        // Pdfgen_QR_2.displayPdf_QR2(
                                                                                                                        //   context,
                                                                                                                        //   renTal_name,
                                                                                                                        //   teNantModels[index].cid,
                                                                                                                        //   teNantModels[index].cname,
                                                                                                                        //   '${teNantModels[index].sdate} ถึง ${teNantModels[index].ldate}',
                                                                                                                        //   '${teNantModels[index].sname}',

                                                                                                                        //   teNantModels[index].ln_c == null
                                                                                                                        //       ? teNantModels[index].ln_q == null
                                                                                                                        //           ? ''
                                                                                                                        //           : 'พื้นที่ :${teNantModels[index].ln_q}( ${teNantModels[index].zn} )'
                                                                                                                        //       : 'พื้นที่ :${teNantModels[index].ln_c}( ${teNantModels[index].zn} )',

                                                                                                                        // );

                                                                                                                        setState(() {
                                                                                                                          serPositioned = '0';
                                                                                                                        });
                                                                                                                        Future.delayed(const Duration(milliseconds: 300), () async {
                                                                                                                          captureAndConvertToBase64(controller[index], 'QR_${teNantModels[index].cid}');
                                                                                                                          setState(() {
                                                                                                                            serPositioned = null;
                                                                                                                          });
                                                                                                                        });

                                                                                                                        // Future.delayed(const Duration(milliseconds: 100), () async {
                                                                                                                        //   try {
                                                                                                                        //     final bytes = await controller[index].capture();
                                                                                                                        //     final blob = html.Blob([bytes]);
                                                                                                                        //     final url = html.Url.createObjectUrlFromBlob(blob);
                                                                                                                        //     final anchor = html.document.createElement('a') as html.AnchorElement
                                                                                                                        //       ..href = url
                                                                                                                        //       ..download = '${teNantModels[index].cid}.png';
                                                                                                                        //     html.document.body?.append(anchor);
                                                                                                                        //     anchor.click();
                                                                                                                        //     html.Url.revokeObjectUrl(url);
                                                                                                                        //     print('Image saved to: ${teNantModels[index].cid}.png');
                                                                                                                        //     setState(() {
                                                                                                                        //       serPositioned = null;
                                                                                                                        //     });
                                                                                                                        //   } catch (e) {
                                                                                                                        //     print('Error saving image: $e');
                                                                                                                        //   }
                                                                                                                        // });

                                                                                                                        // Future.delayed(const Duration(milliseconds: 100), () async {
                                                                                                                        //   final bytes = await controller[index].capture();

                                                                                                                        //   try {
                                                                                                                        //     // final tempDir = await getTemporaryDirectory();
                                                                                                                        //     final filename = '${teNantModels[index].cid}/image.png';

                                                                                                                        //     final type = MimeType.PNG;

                                                                                                                        //     final dir = await FileSaver.instance.saveFile("${NameFile_}", bytes!, "pdf", mimeType: type);

                                                                                                                        //     print('Image saved to: $filename');
                                                                                                                        //     setState(() {
                                                                                                                        //       serPositioned = null;
                                                                                                                        //     });
                                                                                                                        //   } catch (e) {
                                                                                                                        //     print('Error saving image: $e');
                                                                                                                        //   }
                                                                                                                        // });
                                                                                                                      },
                                                                                                                    ),
                                                                                                                  )
                                                                                                                // :
                                                                                                                // Positioned(bottom: 5, right: 5, child: Container(padding: const EdgeInsets.all(4.0), child: const CircularProgressIndicator())),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    height: 150,
                                                                                                    width: 15,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: cardColor,
                                                                                                      // Colors.green[300],
                                                                                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(10), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(10)),
                                                                                                    ),
                                                                                                    // child: Column(
                                                                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    //   children: [
                                                                                                    //     RotatedBox(
                                                                                                    //       quarterTurns: 1,
                                                                                                    //       child: Text(
                                                                                                    //         '$renTal_name',
                                                                                                    //         maxLines: 1,
                                                                                                    //         style: const TextStyle(
                                                                                                    //           fontSize: 9.0,
                                                                                                    //           color: Colors.white,
                                                                                                    //           // fontWeight: FontWeight.bold,
                                                                                                    //           fontFamily: Font_.Fonts_T,
                                                                                                    //         ),
                                                                                                    //       ),
                                                                                                    //     ),
                                                                                                    //   ],
                                                                                                    // ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                        ]),
                                                                                      );
                                                                                    }),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    actions: <Widget>[
                                                                      Column(
                                                                        children: [
                                                                          const SizedBox(
                                                                            height:
                                                                                5.0,
                                                                          ),
                                                                          const Divider(
                                                                            color:
                                                                                Colors.grey,
                                                                            height:
                                                                                4.0,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                5.0,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              // StreamBuilder(
                                                                              //     stream: Stream.periodic(const Duration(seconds: 0)),
                                                                              //     builder: (context, snapshot) {
                                                                              //       return Padding(
                                                                              //         padding: const EdgeInsets.all(8.0),
                                                                              //         child: Row(
                                                                              //           mainAxisAlignment: MainAxisAlignment.end,
                                                                              //           children: [
                                                                              //             Container(
                                                                              //               width: 100,
                                                                              //               decoration: BoxDecoration(
                                                                              //                 color: Colors.yellow.shade900,
                                                                              //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                              //               ),
                                                                              //               padding: const EdgeInsets.all(4.0),
                                                                              //               child: TextButton(
                                                                              //                 onPressed: () async {
                                                                              //                   // setState(() {
                                                                              //                   //   serPositioned = '0';
                                                                              //                   // });
                                                                              //                   for (int index = 0; index < teNantModels_Save[index_type].length; index++) {
                                                                              //                     await Future.delayed(const Duration(seconds: 1));
                                                                              //                     final bytes = await controller[index].capture();
                                                                              //                     final blob = html.Blob([bytes]);
                                                                              //                     final url = html.Url.createObjectUrlFromBlob(blob);
                                                                              //                     final anchor = html.document.createElement('a') as html.AnchorElement
                                                                              //                       ..href = url
                                                                              //                       ..download = 'Image${(index_type * 24 + 1) + (index)}_${teNantModels_Save[index_type][index].zn}_${teNantModels_Save[index_type][index].cid}.png';
                                                                              //                     html.document.body?.append(anchor);
                                                                              //                     anchor.click();
                                                                              //                     html.Url.revokeObjectUrl(url);
                                                                              //                     print('Image saved to: ${teNantModels[index].cid}.png');
                                                                              //                     print('------ Image saved to: ${index}.png');
                                                                              //                   }
                                                                              //                   // setState(() {
                                                                              //                   //   serPositioned = null;
                                                                              //                   // });
                                                                              //                   // for (int index = 0; index < teNantModels.length; index++) {
                                                                              //                   //   setState(() {
                                                                              //                   //     serPositioned = '0';
                                                                              //                   //   });

                                                                              //                   //   Future.delayed(const Duration(milliseconds: 100), () async {
                                                                              //                   //     RenderRepaintBoundary boundary = qrImageKey[index].currentContext!.findRenderObject() as RenderRepaintBoundary;
                                                                              //                   //     ui.Image image = await boundary.toImage();

                                                                              //                   //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                                                                              //                   //     ByteData? bytesz = await resizeImage(Uint8List.view(byteData!.buffer), width: 2500, height: 800);
                                                                              //                   //     Uint8List bytes = bytesz!.buffer.asUint8List();

                                                                              //                   //     await WebImageDownloader.downloadImageFromUInt8List(uInt8List: bytes).then((value) {
                                                                              //                   //       setState(() {
                                                                              //                   //         serPositioned = null;
                                                                              //                   //       });
                                                                              //                   //     });
                                                                              //                   //   });
                                                                              //                   // }
                                                                              //                 },
                                                                              //                 child: Column(
                                                                              //                   children: [
                                                                              //                     const Text(
                                                                              //                       'Save All ',
                                                                              //                       style: TextStyle(
                                                                              //                         color: Colors.white,
                                                                              //                         fontWeight: FontWeight.bold,
                                                                              //                         fontSize: 12,
                                                                              //                         fontFamily: FontWeight_.Fonts_T,
                                                                              //                       ),
                                                                              //                     ),
                                                                              //                     Text(
                                                                              //                       '(${index_type * 24 + 1} - ${(index_type + 1) * 24})',
                                                                              //                       style: TextStyle(
                                                                              //                         color: Colors.white,
                                                                              //                         fontSize: 10,
                                                                              //                         fontFamily: FontWeight_.Fonts_T,
                                                                              //                       ),
                                                                              //                     ),
                                                                              //                   ],
                                                                              //                 ),
                                                                              //               ),
                                                                              //             ),
                                                                              //           ],
                                                                              //         ),
                                                                              //       );
                                                                              //     }),
                                                                              StreamBuilder(
                                                                                  stream: Stream.periodic(const Duration(seconds: 0)),
                                                                                  builder: (context, snapshot) {
                                                                                    return Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 120,
                                                                                            decoration: const BoxDecoration(
                                                                                              color: Colors.green,
                                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                            ),
                                                                                            padding: const EdgeInsets.all(4.0),
                                                                                            child: TextButton(
                                                                                              onPressed: () async {
                                                                                                showDialog(
                                                                                                    barrierDismissible: false,
                                                                                                    context: context,
                                                                                                    builder: (_) {
                                                                                                      // Future.delayed(
                                                                                                      //     const Duration(
                                                                                                      //         seconds:
                                                                                                      //             1),
                                                                                                      //     () {
                                                                                                      //   Navigator.of(
                                                                                                      //           context)
                                                                                                      //       .pop();
                                                                                                      // });

                                                                                                      return Dialog(
                                                                                                        child: StreamBuilder(
                                                                                                            stream: Stream.periodic(const Duration(seconds: 1)),
                                                                                                            builder: (context, snapshot) {
                                                                                                              return const SizedBox(
                                                                                                                  // height: 20,
                                                                                                                  width: 350,
                                                                                                                  child: Padding(
                                                                                                                    padding: EdgeInsets.all(20.0),
                                                                                                                    child: Row(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                      children: [
                                                                                                                        Padding(
                                                                                                                          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                                                                                          child: SizedBox(height: 30, child: CircularProgressIndicator()),
                                                                                                                        ),
                                                                                                                        Text(
                                                                                                                          'กำลัง Download และแปลงไฟล์ PDF...  ',
                                                                                                                          style: TextStyle(
                                                                                                                            color: PeopleChaoScreen_Color.Colors_Text1_,
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            fontFamily: FontWeight_.Fonts_T,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ));
                                                                                                            }),
                                                                                                      );
                                                                                                    });

                                                                                                // setState(() {
                                                                                                //   serPositioned = '0';
                                                                                                // });

                                                                                                // Future.delayed(const Duration(milliseconds: 50), () async {
                                                                                                //   for (int index = 0; index < teNantModels.length; index++) {
                                                                                                //     final bytes = await controller[index].capture();
                                                                                                //     setState(() {
                                                                                                //       this.bytes = bytes;
                                                                                                //     });
                                                                                                //     netImage.add(bytes!);
                                                                                                //   }
                                                                                                // });

                                                                                                // Future.delayed(const Duration(milliseconds: 10), () async {
                                                                                                //   setState(() {
                                                                                                //     serPositioned = null;
                                                                                                //   });
                                                                                                // });
                                                                                                Future.delayed(const Duration(milliseconds: 100), () async {
                                                                                                  Pdfgen_QR_.displayPdf_QR(context, renTal_name, zone_name, teNantModels, '${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}', indexcardColor);
                                                                                                }).then((value) => {
                                                                                                      // Navigator.of(context).pop(),
                                                                                                    });
                                                                                              },
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'พิมพ์ PDF',
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.white,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontSize: 12,
                                                                                                      fontFamily: FontWeight_.Fonts_T,
                                                                                                    ),
                                                                                                  ),
                                                                                                  // Text(
                                                                                                  //   '(${index_type * 24 + 1} - ${(index_type + 1) * 24})',
                                                                                                  //   style: TextStyle(
                                                                                                  //     color: Colors.white,
                                                                                                  //     fontSize: 10,
                                                                                                  //     fontFamily: FontWeight_.Fonts_T,
                                                                                                  //   ),
                                                                                                  // ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 100,
                                                                                      decoration: const BoxDecoration(
                                                                                        color: Colors.black,
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context, 'OK');
                                                                                        },
                                                                                        child: const Text(
                                                                                          'ปิด',
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
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              // InkWell(
                                              //   child: Container(
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.green[600],
                                              //       borderRadius:
                                              //           const BorderRadius.only(
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
                                              //       border: Border.all(
                                              //           color: Colors.grey,
                                              //           width: 1),
                                              //     ),
                                              //     padding:
                                              //         const EdgeInsets.all(4.0),
                                              //     child: PopupMenuButton(
                                              //       child: const Center(
                                              //         child: Row(
                                              //           mainAxisAlignment:
                                              //               MainAxisAlignment
                                              //                   .center,
                                              //           children: [
                                              //             Padding(
                                              //               padding:
                                              //                   EdgeInsets.all(
                                              //                       2.0),
                                              //               child: Icon(
                                              //                 Icons
                                              //                     .file_download,
                                              //                 color:
                                              //                     Colors.white,
                                              //               ),
                                              //             ),
                                              //             Padding(
                                              //               padding:
                                              //                   EdgeInsets.all(
                                              //                       2.0),
                                              //               child: Text(
                                              //                 'Export',
                                              //                 style: TextStyle(
                                              //                   color: PeopleChaoScreen_Color
                                              //                       .Colors_Text1_,
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .bold,
                                              //                   fontFamily:
                                              //                       FontWeight_
                                              //                           .Fonts_T,
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ),
                                              //       itemBuilder: (BuildContext
                                              //               context) =>
                                              //           [
                                              //         // PopupMenuItem(
                                              //         //   child: InkWell(
                                              //         //       onTap: () async {
                                              //         //         List newValuePDFimg =
                                              //         //             [];
                                              //         //         for (int index = 0;
                                              //         //             index < 1;
                                              //         //             index++) {
                                              //         //           if (renTalModels[0]
                                              //         //                   .imglogo!
                                              //         //                   .trim() ==
                                              //         //               '') {
                                              //         //             // newValuePDFimg.add(
                                              //         //             //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                              //         //           } else {
                                              //         //             newValuePDFimg.add(
                                              //         //                 '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                              //         //           }
                                              //         //         }
                                              //         //         SharedPreferences
                                              //         //             preferences =
                                              //         //             await SharedPreferences
                                              //         //                 .getInstance();
                                              //         //         var renTal_name =
                                              //         //             preferences.getString(
                                              //         //                 'renTalName');
                                              //         //         setState(() {
                                              //         //           Pre_and_Dow =
                                              //         //               'Preview';
                                              //         //         });
                                              //         //         Navigator.pop(
                                              //         //             context);
                                              //         //         _displayPdf(
                                              //         //           '$renTal_name',
                                              //         //           ' ${renTalModels[0].bill_addr}',
                                              //         //           ' ${renTalModels[0].bill_email}',
                                              //         //           ' ${renTalModels[0].bill_tel}',
                                              //         //           ' ${renTalModels[0].bill_tax}',
                                              //         //           ' ${renTalModels[0].bill_name}',
                                              //         //           newValuePDFimg,
                                              //         //         );
                                              //         //       },
                                              //         //       child: Container(
                                              //         //           padding:
                                              //         //               const EdgeInsets
                                              //         //                   .all(10),
                                              //         //           width:
                                              //         //               MediaQuery.of(
                                              //         //                       context)
                                              //         //                   .size
                                              //         //                   .width,
                                              //         //           child: Row(
                                              //         //             children: const [
                                              //         //               Expanded(
                                              //         //                 child: Text(
                                              //         //                   'Preview & Print',
                                              //         //                   style: TextStyle(
                                              //         //                       color: PeopleChaoScreen_Color
                                              //         //                           .Colors_Text1_,
                                              //         //                       fontWeight:
                                              //         //                           FontWeight
                                              //         //                               .bold,
                                              //         //                       fontFamily:
                                              //         //                           FontWeight_.Fonts_T),
                                              //         //                 ),
                                              //         //               )
                                              //         //             ],
                                              //         //           ))),
                                              //         // ),
                                              //         PopupMenuItem(
                                              //           child: InkWell(
                                              //               onTap: () async {
                                              //                 Navigator.pop(
                                              //                     context);
                                              //                 setState(() {
                                              //                   Pre_and_Dow =
                                              //                       'Download';
                                              //                 });
                                              //                 _showMyDialog_SAVE();
                                              //               },
                                              //               child: Container(
                                              //                   padding:
                                              //                       const EdgeInsets
                                              //                               .all(
                                              //                           10),
                                              //                   width: MediaQuery.of(
                                              //                           context)
                                              //                       .size
                                              //                       .width,
                                              //                   child:
                                              //                       const Row(
                                              //                     children: [
                                              //                       Expanded(
                                              //                         child:
                                              //                             Text(
                                              //                           'Exprt file',
                                              //                           style: TextStyle(
                                              //                               color:
                                              //                                   PeopleChaoScreen_Color.Colors_Text1_,
                                              //                               fontWeight: FontWeight.bold,
                                              //                               fontFamily: FontWeight_.Fonts_T),
                                              //                         ),
                                              //                       )
                                              //                     ],
                                              //                   ))),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),

                        (!Responsive.isDesktop(context))
                            ? BodyHome_mobile()
                            : BodyHome_Web()
                      ],
                    ),
    );
  }

  ///----------------------->
  Widget Next_page_Web() {
    return Row(
      children: [
        Expanded(child: Text('')),
        StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppbackgroundColor.Sub_Abg_Colors,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 20,
                    ),
                    InkWell(
                        onTap: (offset == 0)
                            ? null
                            : () async {
                                if (offset == 0) {
                                } else {
                                  setState(() {
                                    offset = offset - limit;

                                    read_tenant_limit();
                                    tappedIndex_ = '';
                                  });
                                  _scrollController1.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut,
                                  );
                                }
                              },
                        child: Icon(
                          Icons.arrow_left,
                          color:
                              (offset == 0) ? Colors.grey[200] : Colors.black,
                          size: 25,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        /// '*//$endIndex /${limitedList_teNantModels.length} ///${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        '${(endIndex / limit)}/${(limitedList_teNantModels.length / limit).ceil()}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontWeight_.Fonts_T,
                          //fontSize: 10.0
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (endIndex >= limitedList_teNantModels.length)
                            ? null
                            : () async {
                                setState(() {
                                  offset = offset + limit;
                                  tappedIndex_ = '';
                                  read_tenant_limit();
                                });
                                _scrollController1.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
                        child: Icon(
                          Icons.arrow_right,
                          color: (endIndex >= limitedList_teNantModels.length)
                              ? Colors.grey[200]
                              : Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget BodyHome_Web() {
    return (Status_ == 5)
        ? Rental_customers(updateMessage: updateMessage)
        : (Status_ == 6)
            ? BodyHome_TenantCancel()
            : Column(
                children: [
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
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: Next_page_Web()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'เลขที่สัญญา/เสนอราคา',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ชื่อผู้ติดต่อ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ชื่อร้านค้า',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'โซนพื้นที่',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'รหัสพื้นที่',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ขนาดพื้นที่(ต.ร.ม.)',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ระยะเวลาการเช่า',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'วันเริ่มสัญญา',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'วันสิ้นสุดสัญญา',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'สถานะ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: MediaQuery.of(context).size.width,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircularProgressIndicator(),
                                      StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(milliseconds: 25),
                                            (i) => i),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return const Text('');
                                          double elapsed = double.parse(
                                                  snapshot.data.toString()) *
                                              0.05;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (elapsed > 8.00)
                                                ? const Text(
                                                    'ไม่พบข้อมูล',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                  controller: _scrollController1,
                                  // itemExtent: 50,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: teNantModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Material(
                                      color: tappedIndex_ == index.toString()
                                          ? tappedIndex_Color.tappedIndex_Colors
                                              .withOpacity(0.5)
                                          : AppbackgroundColor.Sub_Abg_Colors,
                                      child: Container(
                                        // color: Colors.white,
                                        // color: tappedIndex_ == index.toString()
                                        //     ? tappedIndex_Color.tappedIndex_Colors
                                        //         .withOpacity(0.5)
                                        //     : null,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                tappedIndex_ = index.toString();
                                              });
                                            },
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade300,
                                                            borderRadius: const BorderRadius
                                                                    .only(
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
                                                            // border: Border.all(color: Colors.grey, width: 1),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child:
                                                              PopupMenuButton(
                                                            child: const Center(
                                                              child: InkWell(
                                                                // onTap: () {
                                                                //   setState(() {
                                                                //     tappedIndex_ =
                                                                //         index.toString();
                                                                //   });
                                                                // },
                                                                child:
                                                                    AutoSizeText(
                                                                  minFontSize:
                                                                      10,
                                                                  maxFontSize:
                                                                      25,
                                                                  maxLines: 1,
                                                                  'เรียกดู >',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                      //fontWeight: FontWeight.bold,
                                                                      fontFamily: Font_.Fonts_T),
                                                                ),
                                                              ),
                                                            ),
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context) =>
                                                                    [
                                                              PopupMenuItem(
                                                                child: Column(
                                                                  children: [
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          var ser_teNant =
                                                                              teNantModels[index].quantity;
                                                                          var ser_ciddoc = teNantModels[index].docno == null
                                                                              ? teNantModels[index].cid
                                                                              : teNantModels[index].docno;
                                                                          setState(
                                                                              () {
                                                                            Value_NameShop_index =
                                                                                '$ser_teNant';
                                                                            Value_cid =
                                                                                '$ser_ciddoc';
                                                                            Value_stasus = teNantModels[index].quantity == '1'
                                                                                ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) == true
                                                                                    ? 'หมดสัญญา'
                                                                                    : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true
                                                                                        ? 'ใกล้หมดสัญญา'
                                                                                        : 'เช่าอยู่'
                                                                                : teNantModels[index].quantity == '2'
                                                                                    ? 'เสนอราคา'
                                                                                    : teNantModels[index].quantity == '3'
                                                                                        ? 'เสนอราคา(มัดจำ)'
                                                                                        : 'ว่าง';
                                                                          });

                                                                          setState(
                                                                              () {
                                                                            ReturnBodyPeople =
                                                                                'PeopleChaoScreen2';
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                          // Navigator.push(
                                                                          //     context,
                                                                          //     MaterialPageRoute(
                                                                          //         builder: (context) =>
                                                                          //             const PeopleChaoScreen2()));
                                                                        },
                                                                        child: Container(
                                                                            padding: const EdgeInsets.all(10),
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(
                                                                                    child: Text(
                                                                                  teNantModels[index].docno == null
                                                                                      ? teNantModels[index].cid == null
                                                                                          ? ''
                                                                                          : '${teNantModels[index].cid}'
                                                                                      : '${teNantModels[index].docno}',
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: const TextStyle(
                                                                                      color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                      //fontWeight: FontWeight.bold,
                                                                                      fontFamily: Font_.Fonts_T),
                                                                                ))
                                                                              ],
                                                                            ))),
                                                                    teNantModels[index].cid ==
                                                                            teNantModels[index]
                                                                                .fid
                                                                        ? SizedBox()
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              var ser_teNant = teNantModels[index].quantity;
                                                                              var ser_ciddoc = teNantModels[index].docno == null ? teNantModels[index].fid : teNantModels[index].docno;
                                                                              setState(() {
                                                                                Value_NameShop_index = '$ser_teNant';
                                                                                Value_cid = '$ser_ciddoc';
                                                                                Value_stasus = teNantModels[index].quantity == '1'
                                                                                    ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) == true
                                                                                        ? 'หมดสัญญา'
                                                                                        : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true
                                                                                            ? 'ใกล้หมดสัญญา'
                                                                                            : 'เช่าอยู่'
                                                                                    : teNantModels[index].quantity == '2'
                                                                                        ? 'เสนอราคา'
                                                                                        : teNantModels[index].quantity == '3'
                                                                                            ? 'เสนอราคา(มัดจำ)'
                                                                                            : 'ว่าง';
                                                                              });

                                                                              setState(() {
                                                                                ReturnBodyPeople = 'PeopleChaoScreen2';
                                                                              });
                                                                              Navigator.pop(context);
                                                                              // Navigator.push(
                                                                              //     context,
                                                                              //     MaterialPageRoute(
                                                                              //         builder: (context) =>
                                                                              //             const PeopleChaoScreen2()));
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Text(
                                                                                      teNantModels[index].docno == null
                                                                                          ? teNantModels[index].cid == null
                                                                                              ? ''
                                                                                              : 'สัญญาเดิม ${teNantModels[index].fid}'
                                                                                          : '${teNantModels[index].docno}',
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          //fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ))
                                                                                  ],
                                                                                ))),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                                  : teNantModels[index]
                                                                              .cid ==
                                                                          teNantModels[index]
                                                                              .fid
                                                                      ? '${teNantModels[index].cid}'
                                                                      : 'สัญญาเดิม ${teNantModels[index].fid}'
                                                              : '${teNantModels[index].docno}',
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
                                                                      .docno ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .cid ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].cid}'
                                                              : '${teNantModels[index].docno}',
                                                          textAlign:
                                                              TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                            TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                                      .sname ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .sname_q ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].sname_q}'
                                                              : '${teNantModels[index].sname}',
                                                          textAlign:
                                                              TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '${teNantModels[index].zn}',
                                                        textAlign:
                                                            TextAlign.left,
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
                                                        style: const TextStyle(
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
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.grey[200],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
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
                                                              TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                            TextAlign.right,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                                : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(
                                                                            days:
                                                                                open_set_date))) ==
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
                                                                    : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) ==
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
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  },
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
                                                        FontWeight_.Fonts_T),
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
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
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
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
              );
  }

  Widget BodyHome_mobile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Container(
                      width: 1000,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          dragStartBehavior: DragStartBehavior.start,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 1050,
                                      decoration: const BoxDecoration(
                                        color: AppbackgroundColor.TiTile_Colors,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0)),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              '...',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ชื่อผู้ติดต่อ',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ชื่อร้านค้า',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'โซนพื้นที่',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'รหัสพื้นที่',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ขนาดพื้นที่(ต.ร.ม.)',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'ระยะเวลาการเช่า',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'วันเริ่มสัญญา',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'วันสิ้นสุดสัญญา',
                                              textAlign: TextAlign.center,
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
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              'สถานะ',
                                              textAlign: TextAlign.center,
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
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.6,
                                      width: 1050,
                                      decoration: const BoxDecoration(
                                        color:
                                            AppbackgroundColor.Sub_Abg_Colors,
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
                                                            milliseconds: 50),
                                                        (i) => i),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData)
                                                        return const Text('');
                                                      double elapsed =
                                                          double.parse(snapshot
                                                                  .data
                                                                  .toString()) *
                                                              0.05;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: (elapsed > 40.00)
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
                                                                'Time : ${elapsed.toStringAsFixed(2)} seconds',
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
                                                          tappedIndex_ =
                                                              index.toString();
                                                        });
                                                      },
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
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
                                                                    // border: Border.all(color: Colors.grey, width: 1),
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      PopupMenuButton(
                                                                    child: const Center(
                                                                        child: Row(
                                                                      children: [
                                                                        AutoSizeText(
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              25,
                                                                          maxLines:
                                                                              1,
                                                                          'เรียกดู',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                              //fontWeight: FontWeight.bold,
                                                                              fontFamily: Font_.Fonts_T),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .navigate_next,
                                                                          color:
                                                                              Colors.black,
                                                                        )
                                                                      ],
                                                                    )),
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context) =>
                                                                            [
                                                                      PopupMenuItem(
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                              var ser_teNant = teNantModels[index].quantity;
                                                                              var ser_ciddoc = teNantModels[index].docno == null ? teNantModels[index].cid : teNantModels[index].docno;
                                                                              setState(() {
                                                                                Value_NameShop_index = '$ser_teNant';
                                                                                Value_cid = '$ser_ciddoc';
                                                                                Value_stasus = teNantModels[index].quantity == '1'
                                                                                    ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) == true
                                                                                        ? 'หมดสัญญา'
                                                                                        : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) == true
                                                                                            ? 'ใกล้หมดสัญญา'
                                                                                            : 'เช่าอยู่'
                                                                                    : teNantModels[index].quantity == '2'
                                                                                        ? 'เสนอราคา'
                                                                                        : teNantModels[index].quantity == '3'
                                                                                            ? 'เสนอราคา(มัดจำ)'
                                                                                            : 'ว่าง';
                                                                              });

                                                                              setState(() {
                                                                                index_listviwe = index;
                                                                                ReturnBodyPeople = 'PeopleChaoScreen2';
                                                                              });
                                                                              Navigator.pop(context);
                                                                              // Navigator.push(
                                                                              //     context,
                                                                              //     MaterialPageRoute(
                                                                              //         builder: (context) =>
                                                                              //             const PeopleChaoScreen2()));
                                                                            },
                                                                            child: Container(
                                                                                padding: const EdgeInsets.all(10),
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Text(
                                                                                      teNantModels[index].docno == null
                                                                                          ? teNantModels[index].cid == null
                                                                                              ? ''
                                                                                              : '${teNantModels[index].cid}'
                                                                                          : '${teNantModels[index].docno}',
                                                                                      style: const TextStyle(
                                                                                          color: PeopleChaoScreen_Color.Colors_Text2_,
                                                                                          //fontWeight: FontWeight.bold,
                                                                                          fontFamily: Font_.Fonts_T),
                                                                                    ))
                                                                                  ],
                                                                                ))),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
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
                                                                            .docno ==
                                                                        null
                                                                    ? teNantModels[index].cid ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].cid}'
                                                                    : '${teNantModels[index].docno}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                                            .cname ==
                                                                        null
                                                                    ? teNantModels[index].cname_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].cname_q}'
                                                                    : '${teNantModels[index].cname}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                                            .sname ==
                                                                        null
                                                                    ? teNantModels[index].sname_q ==
                                                                            null
                                                                        ? ''
                                                                        : '${teNantModels[index].sname_q}'
                                                                    : '${teNantModels[index].sname}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                              '${teNantModels[index].ln}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                                          .ln_c ==
                                                                      null
                                                                  ? teNantModels[index]
                                                                              .ln_q ==
                                                                          null
                                                                      ? ''
                                                                      : '${teNantModels[index].ln_q}'
                                                                  : '${teNantModels[index].ln_c}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                                      .center,
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
                                                                      : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) ==
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
                                                              style: TextStyle(
                                                                  color: teNantModels[index]
                                                                              .quantity ==
                                                                          '1'
                                                                      ? datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(const Duration(days: 0))) ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : datex.isAfter(DateTime.parse('${teNantModels[index].ldate} 00:00:00.000').subtract(Duration(days: open_set_date))) ==
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
                                                        ],
                                                      )),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                Container(
                    width: 1050,
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
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget BodyHome_TenantCancel() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.start,
        child: Row(
          children: [
            SizedBox(
              width: (Responsive.isDesktop(context))
                  ? MediaQuery.of(context).size.width * 0.858
                  : 1200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Container(
                        width: (Responsive.isDesktop(context))
                            ? MediaQuery.of(context).size.width * 0.858
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(child: Next_page_Web()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'เลขที่สัญญา/เสนอราคา',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ชื่อผู้ติดต่อ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ชื่อร้านค้า',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'โซนพื้นที่',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'รหัสพื้นที่',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'ประเภท',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'วันที่ยกเลิก/ทำรายการ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'เหตุผล',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    'สถานะ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 25,
                                    maxLines: 2,
                                    '...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: PeopleChaoScreen_Color
                                            .Colors_Text1_,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontWeight_.Fonts_T
                                        //fontSize: 10.0
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: (Responsive.isDesktop(context))
                              ? MediaQuery.of(context).size.width * 0.858
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CircularProgressIndicator(),
                                      StreamBuilder(
                                        stream: Stream.periodic(
                                            const Duration(milliseconds: 25),
                                            (i) => i),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return const Text('');
                                          double elapsed = double.parse(
                                                  snapshot.data.toString()) *
                                              0.05;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: (elapsed > 8.00)
                                                ? const Text(
                                                    'ไม่พบข้อมูล',
                                                    style: TextStyle(
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                                        color:
                                                            PeopleChaoScreen_Color
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
                                  controller: _scrollController1,
                                  // itemExtent: 50,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: teNantModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Material(
                                      color: tappedIndex_ == index.toString()
                                          ? tappedIndex_Color.tappedIndex_Colors
                                              .withOpacity(0.5)
                                          : AppbackgroundColor.Sub_Abg_Colors,
                                      child: Container(
                                        // color: Colors.white,
                                        // color: tappedIndex_ == index.toString()
                                        //     ? tappedIndex_Color.tappedIndex_Colors
                                        //         .withOpacity(0.5)
                                        //     : null,
                                        child: ListTile(
                                            onTap: () {
                                              setState(() {
                                                tappedIndex_ = index.toString();
                                              });
                                            },
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                      .docno ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .cid ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].cid}'
                                                              : '${teNantModels[index].docno}',
                                                          textAlign:
                                                              TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                            TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                      .sname ==
                                                                  null
                                                              ? teNantModels[index]
                                                                          .sname_q ==
                                                                      null
                                                                  ? ''
                                                                  : '${teNantModels[index].sname_q}'
                                                              : '${teNantModels[index].sname}',
                                                          textAlign:
                                                              TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${teNantModels[index].zn}',
                                                      textAlign: TextAlign.left,
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
                                                  Expanded(
                                                    flex: 1,
                                                    child: Tooltip(
                                                      richMessage: TextSpan(
                                                        text:
                                                            '${teNantModels[index].ln}',
                                                        style: const TextStyle(
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
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.grey[200],
                                                      ),
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '${teNantModels[index].ln}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            color: PeopleChaoScreen_Color
                                                                .Colors_Text2_,
                                                            //fontWeight: FontWeight.bold,
                                                            fontFamily:
                                                                Font_.Fonts_T),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${teNantModels[index].rtname}',
                                                      textAlign: TextAlign.left,
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
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      //+ 543
                                                      '${DateFormat('dd-MM').format(DateTime.parse('${teNantModels[index].cc_date} 00:00:00'))}-${int.parse('${DateFormat('yyyy').format(DateTime.parse('${teNantModels[index].cc_date} 00:00:00'))}') + 543}',
                                                      // '${teNantModels[index].cc_date}',
                                                      textAlign: TextAlign.left,
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
                                                  Expanded(
                                                    flex: 1,
                                                    child: Tooltip(
                                                      richMessage: TextSpan(
                                                        text:
                                                            '${teNantModels[index].cc_remark}',
                                                        style: TextStyle(
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
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.grey[200],
                                                      ),
                                                      child: AutoSizeText(
                                                        minFontSize: 10,
                                                        maxFontSize: 25,
                                                        maxLines: 1,
                                                        '${teNantModels[index].cc_remark}',
                                                        textAlign:
                                                            TextAlign.left,
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
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      minFontSize: 10,
                                                      maxFontSize: 25,
                                                      maxLines: 1,
                                                      '${teNantModels[index].st}',
                                                      textAlign:
                                                          TextAlign.center,
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
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                tappedIndex_ = index
                                                                    .toString();
                                                              });
                                                              List
                                                                  newValuePDFimg =
                                                                  [];
                                                              for (int index =
                                                                      0;
                                                                  index < 1;
                                                                  index++) {
                                                                if (renTalModels[
                                                                            0]
                                                                        .imglogo!
                                                                        .trim() ==
                                                                    '') {
                                                                  // newValuePDFimg.add(
                                                                  //     'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg');
                                                                } else {
                                                                  newValuePDFimg
                                                                      .add(
                                                                          '${MyConstant().domain}/files/$foder/logo/${renTalModels[0].imglogo!.trim()}');
                                                                }
                                                              }
                                                              var ser_teNant =
                                                                  teNantModels[
                                                                          index]
                                                                      .quantity;
                                                              var Cid = teNantModels[
                                                                              index]
                                                                          .docno ==
                                                                      null
                                                                  ? '${teNantModels[index].cid}'
                                                                  : '${teNantModels[index].docno}';
                                                              _showMyDialog_SAVE(
                                                                  Cid,
                                                                  newValuePDFimg);
                                                            },
                                                            child: Container(
                                                              width: 130,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red
                                                                    .shade200,
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
                                                              child:
                                                                  AutoSizeText(
                                                                minFontSize: 10,
                                                                maxFontSize: 25,
                                                                maxLines: 1,
                                                                'เรียกดู',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  },
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
                                                        FontWeight_.Fonts_T),
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
                                                  fontFamily:
                                                      FontWeight_.Fonts_T),
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
                                                fontFamily:
                                                    FontWeight_.Fonts_T),
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
            ),
          ],
        ),
      ),
    );
  }

  ////////////------------------------------------------------------>(Export file)
  Future<void> _showMyDialog_SAVE(Cid, newValuePDFimg) async {
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
                          onTap: () async {
                            if (TitleType_Default_Receipt == 0) {
                            } else {
                              setState(() {
                                TitleType_Default_Receipt_Name =
                                    '${TitleType_Default_Receipt_[TitleType_Default_Receipt]}';
                              });
                            }
                            // print('${TitleType_Default_Receipt_Name}');
                            Man_CancelRental_PDF.ManCancelRental_PDF(
                              TitleType_Default_Receipt_Name,
                              '1',
                              '${Cid}',
                              context,
                              foder,
                              renTal_name,
                              bill_addr,
                              bill_email,
                              bill_tel,
                              bill_tax,
                              bill_name,
                              newValuePDFimg,
                              'tem_page_ser',
                            );
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
                            child: Center(
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
                            child: Center(
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

  //////////////////////////------------------------------>
}

class PreviewChaoAreaScreen extends StatelessWidget {
  final pw.Document doc;
  final Status_;
  PreviewChaoAreaScreen({super.key, required this.doc, this.Status_});

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
          allowSharing: true,
          allowPrinting: true, canChangePageFormat: false,
          canChangeOrientation: false, canDebug: false,
          maxPageWidth: MediaQuery.of(context).size.width * 0.6,
          // scrollViewDecoration:,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "${Status_}.pdf",
        ),
      ),
    );
  }
}
